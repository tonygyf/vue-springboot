<template>
  <div class="main-content">
    <div class="card">
      <div class="card-header">
        <h3 class="text-center">博客列表</h3>
      </div>
      <div class="card-body">
        <div v-if="message" class="alert" :class="messageClass" role="alert">
          {{ message }}
        </div>
        <div
            v-for="blog in blogs"
            :key="blog.blogId"
            class="mb-3 p-3 border blog-item"
            @click="viewBlogDetail(blog.blogId)"
        >
          <h4>{{ blog.title }}</h4>
          <p>{{ blog.content }}</p>
          <small>{{ formatDate(blog.createdAt) }}</small>
        </div>
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
      messageClass: '',
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
        this.message =
            error.response?.data?.message || '获取博客列表失败，请检查网络连接';
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
    },
  },
};
</script>

<style scoped>
.main-content {
  margin: 0 auto;
  width: 100%;
  max-width: 900px;
  padding: 0 20px;
}

.card {
  background-color: #fff;
  border-radius: 8px;
  margin: 20px 0;
}

.blog-item {
  cursor: pointer;
  transition: all 0.3s;
  background-color: #fff;
  border-radius: 4px;
  border: 1px solid #ebeef5;
}

.blog-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.mb-3 {
  margin-bottom: 1rem;
}
</style>
