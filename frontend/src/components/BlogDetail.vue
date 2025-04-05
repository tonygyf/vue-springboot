<template>
  <div class="card">
    <div class="card-header">
      <h3 class="text-center">博客详情</h3>
    </div>
    <div class="card-body" v-if="blog">
      <div v-if="message" class="alert" :class="messageClass" role="alert">
        {{ message }}
      </div>
      <div class="blog-content mb-4">
        <h2>{{ blog.title }}</h2>
        <p class="mt-3">{{ blog.content }}</p>
        <div class="d-flex align-items-center text-muted">
          <small>发布于: {{ formatDate(blog.createdAt) }}</small>
          <div class="ms-3">
            <i class="el-icon-star-on"></i>
            <span>{{ likesCount }} 点赞</span>
          </div>
        </div>
      </div>
      <div class="comments-section">
        <h4>评论 ({{ comments.length }})</h4>
        <div v-for="comment in comments" :key="comment.commentId" class="comment-item p-3 border-bottom">
          <p>{{ comment.content }}</p>
          <small class="text-muted">{{ formatDate(comment.createdAt) }}</small>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { blogService } from '../services/api';

export default {
  name: 'BlogDetail',
  data() {
    return {
      blog: null,
      comments: [],
      likesCount: 0,
      message: '',
      messageClass: ''
    };
  },
  created() {
    this.fetchBlogDetails();
  },
  methods: {
    async fetchBlogDetails() {
      try {
        const blogId = this.$route.params.id;
        const response = await blogService.getBlogDetails(blogId);
        this.blog = response.data.blog;
        this.comments = response.data.comments;
        this.likesCount = response.data.likesCount;
        this.message = '';
        this.messageClass = '';
      } catch (error) {
        this.message = error.response?.data?.message || '获取博客详情失败';
        this.messageClass = 'alert-danger';
      }
    },
    formatDate(dateString) {
      if (!dateString) return '';
      const date = new Date(dateString);
      return date.toLocaleDateString();
    }
  }
};
</script>

<style scoped>
.blog-content {
  border-bottom: 1px solid #eee;
  padding-bottom: 1rem;
}
.comment-item {
  background-color: #f8f9fa;
  margin-bottom: 1rem;
  border-radius: 4px;
}
</style>