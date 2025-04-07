<template>
  <div class="main-content">
    <div class="search-container">
      <input
        type="text"
        v-model="searchQuery"
        @input="handleSearch"
        @keyup.enter="handleSearch"
        class="search-input"
        placeholder="搜索已删除的博客..."
      />
    </div>
    <div class="card">
      <div class="card-header">
        <h3 class="text-center">已删除的博客列表</h3>
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
<!-- 恢复和永久删除按钮 -->
          <!-- <div v-if="isAdmin" class="admin-actions mt-2" @click.stop>
            <button class="restore-btn" @click="restoreBlog(blog.blogId)">恢复</button>
            <button class="delete-btn" @click="permanentDelete(blog.blogId)">永久删除</button>
          </div> -->
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { blogService } from '../services/api';

export default {
  name: 'DeletedBlogList',
  data() {
    return {
      blogs: [],
      message: '',
      messageClass: '',
      isAdmin: false,
      searchQuery: '',
      searchTimeout: null,
    };
  },
  created() {
    this.checkRole();
    this.fetchDeletedBlogs();
  },
  methods: {
    checkRole() {
      const user = JSON.parse(localStorage.getItem('user'));
      this.isAdmin = user?.role === 'admin';
      if (!this.isAdmin) {
        this.$router.push('/blogs');
      }
    },
    async fetchDeletedBlogs() {
      try {
        const response = await blogService.getDeletedBlogList();
        this.blogs = response.data;
      } catch (error) {
        this.message = error.response?.data?.message || '获取已删除博客列表失败';
        this.messageClass = 'alert-danger';
      }
    },
    async handleSearch() {
      if (this.searchTimeout) {
        clearTimeout(this.searchTimeout);
      }
      
      this.searchTimeout = setTimeout(async () => {
        try {
          if (!this.searchQuery.trim()) {
            await this.fetchDeletedBlogs();
            return;
          }
          const response = await blogService.searchDeletedBlogs(this.searchQuery);
          this.blogs = response.data;
        } catch (error) {
          this.message = error.response?.data?.message || '搜索失败';
          this.messageClass = 'alert-danger';
        }
      }, 300);
    },
    formatDate(date) {
      return new Date(date).toLocaleDateString();
    },
    viewBlogDetail(blogId) {
      this.$router.push(`/blogs/${blogId}`);
    },
    async restoreBlog(blogId) {
      try {
        await blogService.restoreBlog(blogId);
        this.message = '博客已恢复';
        this.messageClass = 'alert-success';
        await this.fetchDeletedBlogs();
      } catch (error) {
        this.message = error.response?.data?.message || '恢复博客失败';
        this.messageClass = 'alert-danger';
      }
    },
    async permanentDelete(blogId) {
      if (!confirm('确定要永久删除这篇博客吗？此操作不可撤销。')) {
        return;
      }
      try {
        await blogService.permanentDeleteBlog(blogId);
        this.message = '博客已永久删除';
        this.messageClass = 'alert-success';
        await this.fetchDeletedBlogs();
      } catch (error) {
        this.message = error.response?.data?.message || '永久删除博客失败';
        this.messageClass = 'alert-danger';
      }
    }
  }
}
</script>

<style scoped>
.main-content {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.search-container {
  margin-bottom: 20px;
}

.search-input {
  width: 100%;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 16px;
}

.card {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.card-header {
  padding: 15px;
  border-bottom: 1px solid #eee;
}

.card-body {
  padding: 20px;
}

.blog-item {
  background: white;
  border-radius: 4px;
  transition: all 0.3s ease;
  cursor: pointer;
}

.blog-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.admin-actions {
  display: flex;
  gap: 10px;
}

.restore-btn, .delete-btn {
  padding: 5px 10px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.restore-btn {
  background-color: #4CAF50;
  color: white;
}

.restore-btn:hover {
  background-color: #45a049;
}

.delete-btn {
  background-color: #f44336;
  color: white;
}

.delete-btn:hover {
  background-color: #da190b;
}

.alert {
  padding: 10px;
  margin-bottom: 15px;
  border-radius: 4px;
}

.alert-success {
  background-color: #dff0d8;
  color: #3c763d;
  border: 1px solid #d6e9c6;
}

.alert-danger {
  background-color: #f2dede;
  color: #a94442;
  border: 1px solid #ebccd1;
}
</style>