<template>
  <div class="card">
    <div class="card-header">
      <h3 class="text-center">登录</h3>
    </div>
    <div class="card-body">
      <div v-if="message" class="alert" :class="messageClass" role="alert">
        {{ message }}
      </div>
      <form @submit.prevent="login">
        <div class="mb-3">
          <label for="username" class="form-label">用户名</label>
          <input type="text" class="form-control" id="username" v-model="user.username" required>
        </div>
        <div class="mb-3">
          <label for="password" class="form-label">密码</label>
          <input type="password" class="form-control" id="password" v-model="user.password" required>
        </div>
        <div class="d-grid gap-2">
          <button type="submit" class="btn btn-primary">登录</button>
        </div>
      </form>
      <div class="mt-3 text-center">
        <p>还没有账号? <router-link to="/register">注册</router-link></p>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'Login',
  data() {
    return {
      user: {
        username: '',
        password: ''
      },
      message: '',
      messageClass: ''
    }
  },
  methods: {
    async login() {
      try {
        const response = await axios.post('http://localhost:8080/api/auth/login', this.user);
        this.message = '登录成功!';
        this.messageClass = 'alert-success';
        localStorage.setItem('user', JSON.stringify(response.data.user));
        setTimeout(() => {
          this.$router.push('/blogs');
        }, 1000);
      } catch (error) {
        this.message = error.response?.data?.message || '登录失败，请检查网络连接';
        this.messageClass = 'alert-danger';
      }
    }
  }
}
</script>