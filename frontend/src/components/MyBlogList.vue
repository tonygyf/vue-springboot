<template>
  <div class="main-content">
    <div class="search-container">
      <input
        type="text"
        v-model="searchQuery"
        @input="handleSearch"
        @keyup.enter="handleSearch"
        class="search-input"
        placeholder="搜索我的博客..."
      />
    </div>
    <div class="card">
      <div class="card-header">
        <h3 class="text-center">我的博客</h3>
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

          <div class="user-actions mt-2" @click.stop>
            <button class="edit-btn" @click="openEdit(blog)">编辑</button>
            <button class="delete-btn" @click="deleteBlog(blog.blogId)">删除</button>
          </div>
        </div>
      </div>
    </div>

    <!-- 编辑浮窗 -->
    <FloatEditor :visible="editDialogVisible" @close="editDialogVisible = false">
      <div class="editor-content">
        <h3>编辑博客</h3>
        <label>标题</label>
        <input v-model="editingBlog.title" />
        <label>内容</label>
        <textarea v-model="editingBlog.content" rows="6" />

        <div class="editor-actions">
          <button @click="editDialogVisible = false">取消</button>
          <button class="save-btn" @click="submitEdit">保存</button>
        </div>
      </div>
    </FloatEditor>
  </div>
</template>

<script>
import { blogService } from '../services/api';
import FloatEditor from './FloatEditor.vue';

export default {
  name: 'MyBlogList',
  components: { FloatEditor },
  data() {
    return {
      blogs: [],
      message: '',
      messageClass: '',
      editDialogVisible: false,
      editingBlog: {},
      searchQuery: '',
      searchTimeout: null,
      currentUser: null
    };
  },
  created() {
    this.currentUser = JSON.parse(localStorage.getItem('user'));
    if (!this.currentUser) {
      this.$router.push('/login');
      return;
    }
    this.fetchMyBlogs();
  },
  methods: {
    async fetchMyBlogs() {
      try {
        const response = await blogService.getBlogList();
        // 过滤出当前用户的博客
        this.blogs = response.data.filter(blog => blog.userId === this.currentUser.userId);
      } catch (error) {
        this.message = error.response?.data?.message || '获取博客列表失败';
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
            await this.fetchMyBlogs();
            return;
          }
          const response = await blogService.searchBlogs(this.searchQuery);
          // 过滤出当前用户的博客
          this.blogs = response.data.filter(blog => blog.userId === this.currentUser.userId);
        } catch (error) {
          this.message = error.response?.data?.message || '搜索失败';
          this.messageClass = 'alert-danger';
        }
      }, 300);
    },
    formatDate(dateString) {
      if (!dateString) return '';
      const date = new Date(dateString);
      return date.toLocaleDateString();
    },
    viewBlogDetail(blogId) {
      this.$router.push(`/blogs/${blogId}`);
    },
    openEdit(blog) {
      this.editingBlog = { ...blog };
      this.editDialogVisible = true;
    },
    async submitEdit() {
      try {
        await blogService.updateBlog(this.editingBlog.blogId, {
          title: this.editingBlog.title,
          content: this.editingBlog.content,
        });
        this.message = '博客更新成功';
        this.messageClass = 'alert-success';
        this.editDialogVisible = false;
        this.fetchMyBlogs();
      } catch (error) {
        this.message = error.response?.data?.message || '更新失败';
        this.messageClass = 'alert-danger';
      }
    },
    async deleteBlog(blogId) {
      if (confirm('确定要删除这篇博客吗？')) {
        try {
          await blogService.deleteBlog(blogId);
          this.message = '博客删除成功';
          this.messageClass = 'alert-success';
          this.fetchMyBlogs();
        } catch (error) {
          this.message = error.response?.data?.message || '删除失败';
          this.messageClass = 'alert-danger';
        }
      }
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

.search-container {
  margin: 20px 0;
  display: flex;
  justify-content: center;
}

.search-input {
  width: 100%;
  max-width: 600px;
  height: 40px;
  padding: 0 16px;
  font-size: 16px;
  border: 1px solid #e8e8e8;
  border-radius: 20px;
  background-color: #f5f5f5;
  transition: all 0.3s;
}

.search-input:focus {
  outline: none;
  background-color: #fff;
  border-color: #409eff;
  box-shadow: 0 0 0 2px rgba(64,158,255,.2);
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
  box-shadow: 0 2px 12px 0 rgba(0,0,0,.1);
}

.blog-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 16px 0 rgba(0,0,0,.2);
}

.user-actions {
  display: flex;
  gap: 10px;
}

.edit-btn, .delete-btn {
  padding: 5px 15px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.3s;
}

.edit-btn {
  background-color: #409eff;
  color: white;
}

.delete-btn {
  background-color: #f56c6c;
  color: white;
}

.edit-btn:hover {
  background-color: #66b1ff;
}

.delete-btn:hover {
  background-color: #f78989;
}

.editor-content {
  padding: 20px;
}

.editor-content input,
.editor-content textarea {
  width: 100%;
  margin: 10px 0;
  padding: 8px;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
}

.editor-actions {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
  margin-top: 20px;
}

.save-btn {
  background-color: #409eff;
  color: white;
  border: none;
  padding: 8px 20px;
  border-radius: 4px;
  cursor: pointer;
}

.save-btn:hover {
  background-color: #66b1ff;
}
</style>