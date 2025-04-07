<template>
  <div class="card narrow-card">
    <div class="card-header">
      <h3 class="text-center">注册</h3>
    </div>
    <div class="card-body">
      <div v-if="message" class="alert" :class="messageClass" role="alert">
        {{ message }}
      </div>
      <form @submit.prevent="register">
        <div class="mb-3">
          <label for="username" class="form-label">用户名</label>
          <input type="text" class="form-control" id="username" v-model="user.username" required>
        </div>
        <div class="mb-3">
          <label for="email" class="form-label">邮箱</label>
          <input type="email" class="form-control" id="email" v-model="user.email" required>
        </div>
        <div class="mb-3">
          <label for="password" class="form-label">密码</label>
          <input type="password" class="form-control" id="password" v-model="user.password" required>
        </div>
        <div class="d-grid gap-2">
          <button type="submit" class="btn btn-primary">注册</button>
        </div>
      </form>
      <div class="mt-3 text-center">
        <p>已有账号? <router-link to="/login">登录</router-link></p>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'Register',
  data() {
    return {
      user: {
        username: '',
        email: '',
        password: ''
      },
      message: '',
      messageClass: ''
    }
  },
  methods: {
    async register() {
      try {
        const response = await axios.post('http://localhost:8080/api/auth/register', this.user);
        this.message = '注册成功!';
        this.messageClass = 'alert-success';
        setTimeout(() => {
          this.$router.push('/login');
        }, 1000);
      } catch (error) {
        this.message = error.response?.data?.message || '注册失败，请检查网络连接';
        this.messageClass = 'alert-danger';
      }
    }
  }
}
</script>

<style scoped>
.narrow-card {
  max-width: 400px; /* Adjust this value to your desired width */
  margin: 0 auto; /* Center the card horizontally */
}
</style>