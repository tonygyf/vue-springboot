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

          <div v-if="isAdmin" class="admin-actions mt-2" @click.stop>
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
  name: 'BlogList',
  components: { FloatEditor },
  data() {
    return {
      blogs: [],
      message: '',
      messageClass: '',
      isAdmin: false,
      editDialogVisible: false,
      editingBlog: {},
    };
  },
  created() {
    this.checkRole();
    this.fetchBlogs();
  },
  methods: {
    checkRole() {
      const user = JSON.parse(localStorage.getItem('user'));
      this.isAdmin = user?.role === 'admin';
    },
    async fetchBlogs() {
      try {
        const response = await blogService.getBlogList();
        this.blogs = response.data;
      } catch (error) {
        this.message = error.response?.data?.message || '获取博客列表失败';
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
        this.fetchBlogs();
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
          this.fetchBlogs();
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
  position: relative;
}

.blog-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.admin-actions {
  position: absolute;
  top: 10px;
  right: 10px;
  display: flex;
  gap: 6px;
}


.edit-btn,
.delete-btn {
  padding: 5px 10px;
  border: none;
  font-size: 14px;
  border-radius: 4px;
  cursor: pointer;
  color: white;
}

.edit-btn {
  background-color: #409eff;
}

.delete-btn {
  background-color: #f56c6c;
}

.edit-btn:hover {
  background-color: #66b1ff;
}

.delete-btn:hover {
  background-color: #f78989;
}

textarea {
  width: 100%;
  padding: 6px 10px;
  border-radius: 4px;
  border: 1px solid #ccc;
  resize: vertical;
}

.editor-content label {
  display: block;
  margin-top: 12px;
  font-weight: bold;
}

.editor-actions {
  margin-top: 15px;
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}
</style>
