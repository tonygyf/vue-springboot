<template>
  <div class="card">
    <div class="card-header">
      <h3 class="text-center">欢迎页面</h3>
    </div>
    <div class="card-body">
      <div v-if="user">
        <h4>欢迎, {{ user.username }}!</h4>
        <p>您已成功登录系统。</p>
        <button class="btn btn-danger" @click="logout">退出登录</button>
      </div>
      <div v-else>
        <p>您尚未登录，请先登录。</p>
        <router-link to="/login" class="btn btn-primary">去登录</router-link>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Home',
  data() {
    return {
      user: null
    }
  },
  created() {
    const userStr = localStorage.getItem('user');
    if (userStr) {
      this.user = JSON.parse(userStr);
    } else {
      this.$router.push('/login');
    }
  },
  methods: {
    logout() {
      localStorage.removeItem('user');
      this.$router.push('/login');
    }
  }
}
</script>