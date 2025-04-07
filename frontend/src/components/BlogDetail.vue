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
          <div class="ms-3 like-button" @click="toggleLike">
            <i :class="[isLiked ? 'el-icon-star-on active' : 'el-icon-star-off']"></i>
            <span>{{ likesCount }} 点赞</span>
          </div>
        </div>
      </div>
      <div class="comments-section">
        <h4>评论 ({{ comments.length }})</h4>
        <div class="comment-form mb-4">
          <textarea v-model="newComment" class="form-control mb-2" rows="3" placeholder="写下你的评论..."></textarea>
          <button @click="submitComment" class="btn btn-primary" :disabled="!newComment.trim()">发表评论</button>
        </div>
        <div v-for="comment in comments" :key="comment.commentId" class="comment-item p-3 border-bottom">
          <div class="d-flex justify-content-between align-items-center">
            <p class="mb-1">{{ comment.content }}</p>
            <!-- 只有 admin 角色的用户可以看到删除按钮 -->
            <button
                v-if="isAdmin"
                class="btn btn-sm btn-danger"
                @click="deleteComment(comment.commentId)"
            >
              删除
            </button>
          </div>
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
      isLiked: false,
      message: '',
      messageClass: '',
      newComment: '',
      isAdmin: false  // 控制是否显示删除按钮
    };
  },
  created() {
    this.fetchBlogDetails();
    this.checkLikeStatus();

    // 获取当前用户的角色
    const currentUser = JSON.parse(localStorage.getItem('user'));
    if (currentUser && currentUser.role === 'admin') {
      this.isAdmin = true;  // 如果是 admin 用户，则显示删除评论按钮
    }
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
    },
    async checkLikeStatus() {
      try {
        const blogId = this.$route.params.id;
        const response = await blogService.getLikeStatus(blogId);
        this.isLiked = response.data.liked;
      } catch (error) {
        console.error('获取点赞状态失败:', error);
      }
    },

    async toggleLike() {
      try {
        const blogId = this.$route.params.id;
        if (this.isLiked) {
          await blogService.unlikeBlog(blogId);
          this.likesCount--;
        } else {
          await blogService.likeBlog(blogId);
          this.likesCount++;
        }
        this.isLiked = !this.isLiked;
      } catch (error) {
        this.message = error.response?.data?.message || '操作失败';
        this.messageClass = 'alert-danger';
      }
    },

    async submitComment() {
      try {
        const blogId = this.$route.params.id;
        await blogService.createComment(blogId, this.newComment);
        this.newComment = '';
        await this.fetchBlogDetails();
        this.message = '评论发表成功';
        this.messageClass = 'alert-success';
      } catch (error) {
        this.message = error.response?.data?.message || '评论发表失败';
        this.messageClass = 'alert-danger';
      }
    },

    async deleteComment(commentId) {
      try {
        const currentUser = JSON.parse(localStorage.getItem('user'));
        await blogService.deleteComment(commentId, currentUser.userId);  // 调用删除评论 API
        this.message = '评论已删除';
        this.messageClass = 'alert-success';  // 设置为绿色提示信息

        await this.fetchBlogDetails();  // 删除后刷新评论列表
      } catch (error) {
        this.message = error.response?.data?.message || '删除评论失败';
        this.messageClass = 'alert-danger';  // 设置为红色提示信息

        await this.fetchBlogDetails();  // 删除后刷新评论列表
      }
    }





  }
};
</script>

<style scoped>
.card {
  max-width: 900px;
  margin: 20px auto;
  padding: 0 20px;
}

.blog-content {
  border-bottom: 1px solid #eee;
  padding: 1rem 0;
}

.comment-item {
  background-color: #f8f9fa;
  margin-bottom: 1rem;
  border-radius: 4px;
  padding: 1rem;
}

.like-button {
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 4px;
}

.like-button:hover {
  color: #409eff;
}

.like-button i {
  font-size: 18px;
}

.like-button i.active {
  color: #409eff;
}
</style>
