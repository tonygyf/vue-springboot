<template>
  <div>
    <ParticleBackground />

    <!-- 通用布局：非登录页才显示 -->
    <SidebarLeft
        v-if="!isLoginPage"
        @create-new="goToNew"
        @view-drafts="goToDrafts"
        @view-my-blogs="goToMyBlogs"
        @view-blog-list="goToBlogList"
    />
    <SidebarRight
        v-if="!isLoginPage"
        :userName="userName"
        :blogCount="blogCount"
        :followingCount="followingCount"
        :followerCount="followerCount"
    />

    <div class="container mt-5">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
import ParticleBackground from './components/ParticleBackground.vue'
import SidebarLeft from './components/SidebarLeft.vue'
import SidebarRight from './components/SidebarRight.vue'

export default {
  name: 'App',
  components: {
    ParticleBackground,
    SidebarLeft,
    SidebarRight
  },
  computed: {
    isLoginPage() {
      return this.$route.path === '/login';
    }
  },
  data() {
    return {
      userName: '示例用户',
      blogCount: 12,
      followingCount: 34,
      followerCount: 56
    }
  },
  methods: {
    goToNew() {
      this.$router.push('/blogs/create');
    },
    goToDrafts() {
      this.$router.push('/drafts');
    },
    goToMyBlogs() {
      this.$router.push('/myblogs');
    },
    goToBlogList() {
      this.$router.push('/blogs');
    }
  }
}
</script>

<style>
.container {
  max-width: 90%;
  width: 100%;
  position: relative;
  z-index: 1;
  margin: 0 auto;
  padding: 20px;
}

@media screen and (max-width: 768px) {
  .container {
    max-width: 95%;
    padding: 10px;
  }
}
</style>
