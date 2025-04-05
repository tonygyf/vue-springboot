<template>
  <div class="card">
    <div class="card-header">
      <h3 class="text-center">博客列表</h3>
    </div>
    <div class="card-body">
      <div v-if="message" class="alert" :class="messageClass" role="alert">
        {{ message }}
      </div>
      <div v-for="blog in blogs" :key="blog.blogId" class="mb-3 p-3 border blog-item" @click="viewBlogDetail(blog.blogId)">
        <h4>{{ blog.title }}</h4>
        <p>{{ blog.content }}</p>
        <small>{{ formatDate(blog.createdAt) }}</small>
      </div>
    </div>
  </div>
</template>

<script>
import { blogService } from '../services/api';

export default {
  name: 'BlogList',
  data() {
    return {
      blogs: [],
      message: '',
      messageClass: ''
    };
  },
  created() {
    this.fetchBlogs();
  },
  methods: {
    async fetchBlogs() {
      try {
        const response = await blogService.getBlogList();
        this.blogs = response.data;
        this.message = '';
        this.messageClass = '';
      } catch (error) {
        this.message = error.response?.data?.message || '获取博客列表失败，请检查网络连接';
        this.messageClass = 'alert-danger';
      }
    },
    formatDate(dateString) {
      if (!dateString) return '';
      const date = new Date(dateString);
      return date.toLocaleDateString();
    },
    viewBlogDetail(blogId) {
      this.$router.push(`/blogs/${blogId}`);
    }
  }
};
</script>