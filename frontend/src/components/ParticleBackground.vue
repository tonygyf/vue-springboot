<template>
  <canvas ref="canvas" class="particle-canvas"></canvas>
</template>

<script>
export default {
  name: 'ParticleBackground',
  data() {
    return {
      canvas: null,
      ctx: null,
      particles: [],
      mouse: {
        x: null,
        y: null,
        radius: 150
      },
      particleCount: 100
    }
  },
  mounted() {
    this.initCanvas()
    this.createParticles()
    this.animate()
    window.addEventListener('mousemove', this.handleMouseMove)
    window.addEventListener('resize', this.handleResize)
  },
  beforeDestroy() {
    window.removeEventListener('mousemove', this.handleMouseMove)
    window.removeEventListener('resize', this.handleResize)
  },
  methods: {
    initCanvas() {
      this.canvas = this.$refs.canvas
      this.ctx = this.canvas.getContext('2d')
      this.canvas.width = window.innerWidth
      this.canvas.height = window.innerHeight
    },
    createParticles() {
      for (let i = 0; i < this.particleCount; i++) {
        this.particles.push({
          x: Math.random() * this.canvas.width,
          y: Math.random() * this.canvas.height,
          size: Math.random() * 3 + 1,
          speedX: Math.random() * 2 - 1,
          speedY: Math.random() * 2 - 1,
          color: `rgba(0, 255, 255, ${Math.random() * 0.5 + 0.2})`
        })
      }
    },
    drawParticles() {
      this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height)
      
      for (let i = 0; i < this.particles.length; i++) {
        const p = this.particles[i]
        
        // 更新粒子位置
        p.x += p.speedX
        p.y += p.speedY
        
        // 边界检查
        if (p.x < 0 || p.x > this.canvas.width) p.speedX *= -1
        if (p.y < 0 || p.y > this.canvas.height) p.speedY *= -1
        
        // 绘制粒子
        this.ctx.beginPath()
        this.ctx.arc(p.x, p.y, p.size, 0, Math.PI * 2)
        this.ctx.fillStyle = p.color
        this.ctx.fill()
        
        // 连接临近粒子
        for (let j = i + 1; j < this.particles.length; j++) {
          const p2 = this.particles[j]
          const dx = p.x - p2.x
          const dy = p.y - p2.y
          const distance = Math.sqrt(dx * dx + dy * dy)
          
          if (distance < 100) {
            this.ctx.beginPath()
            this.ctx.strokeStyle = `rgba(0, 255, 255, ${0.1 * (1 - distance/100)})`
            this.ctx.lineWidth = 1
            this.ctx.moveTo(p.x, p.y)
            this.ctx.lineTo(p2.x, p2.y)
            this.ctx.stroke()
          }
        }
        
        // 鼠标交互
        if (this.mouse.x !== null) {
          const dx = p.x - this.mouse.x
          const dy = p.y - this.mouse.y
          const distance = Math.sqrt(dx * dx + dy * dy)
          
          if (distance < this.mouse.radius) {
            const angle = Math.atan2(dy, dx)
            const force = (this.mouse.radius - distance) / this.mouse.radius
            p.x += Math.cos(angle) * force * 2
            p.y += Math.sin(angle) * force * 2
          }
        }
      }
    },
    animate() {
      this.drawParticles()
      requestAnimationFrame(this.animate)
    },
    handleMouseMove(e) {
      this.mouse.x = e.clientX
      this.mouse.y = e.clientY
    },
    handleResize() {
      this.canvas.width = window.innerWidth
      this.canvas.height = window.innerHeight
    }
  }
}
</script>

<style scoped>
.particle-canvas {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: -1;
  background: #000;
}
</style>