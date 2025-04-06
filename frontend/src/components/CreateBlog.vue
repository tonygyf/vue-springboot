<template>
  <div class="create-blog">
    <div class="blog-form">
      <div class="form-group">
        <input
          type="text"
          class="title-input"
          v-model="blog.title"
          placeholder="请输入标题"
        >
      </div>
      <div class="form-group">
        <textarea
          class="content-input"
          v-model="blog.content"
          placeholder="请输入博客内容"
          rows="15"
        ></textarea>
      </div>
      <div class="action-buttons">
        <button class="save-draft" @click="saveDraft">
          <i class="fas fa-save"></i> 保存草稿
        </button>
        <button class="publish" @click="publish">
          <i class="fas fa-paper-plane"></i> 发布博客
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import { blogService } from '../services/api';

export default {
  name: 'CreateBlog',
  data() {
    return {
      blog: {
        title: '',
        content: '',
        isDraft: false
      }
    }
  },
  methods: {
    async saveDraft() {
      try {
        this.blog.isDraft = true;
        // TODO: 调用后端API保存草稿
        this.$message.success('草稿保存成功');
      } catch (error) {
        this.$message.error('保存失败：' + error.message);
      }
    },
    async publish() {
      try {
        if (!this.blog.title.trim()) {
          this.$message.warning('请输入标题');
          return;
        }
        if (!this.blog.content.trim()) {
          this.$message.warning('请输入内容');
          return;
        }
        this.blog.isDraft = false;
        
        // 调用后端API发布博客
        await blogService.createBlog(this.blog.title, this.blog.content);
        this.$message.success('博客发布成功');
        this.$router.push('/blogs');
      } catch (error) {
        this.$message.error('发布失败：' + (error.response?.data || error.message));
      }
    }
  }
}
</script>

<style scoped>
.create-blog {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0,0,0,.1);
}

.blog-form {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.form-group {
  width: 100%;
}

.title-input {
  width: 100%;
  padding: 12px;
  font-size: 1.5em;
  border: none;
  border-bottom: 2px solid #e4e7ed;
  outline: none;
  transition: border-color 0.3s;
}

.title-input:focus {
  border-color: #409eff;
}

.content-input {
  width: 100%;
  padding: 12px;
  font-size: 1.1em;
  border: 1px solid #e4e7ed;
  border-radius: 4px;
  outline: none;
  resize: vertical;
  transition: border-color 0.3s;
}

.content-input:focus {
  border-color: #409eff;
}

.action-buttons {
  display: flex;
  gap: 12px;
  justify-content: flex-end;
}

.action-buttons button {
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 8px;
  transition: all 0.3s;
}

.save-draft {
  background-color: #f5f7fa;
  color: #606266;
}

.save-draft:hover {
  background-color: #e4e7ed;
}

.publish {
  background-color: #409eff;
  color: white;
}

.publish:hover {
  background-color: #66b1ff;
}
</style>