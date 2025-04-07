<template>
  <div class="sidebar-left">
    <div class="tv-frame">
      <div class="tv-content">
        <div class="action-buttons">
          <button class="action-btn" @click="$emit('create-new')">
            <i class="fas fa-plus"></i> 写博客
          </button>
          <button class="action-btn" @click="$emit('view-my-blogs')">
            <i class="fas fa-book"></i> 我的博客
          </button>
          <button class="action-btn" @click="$emit('view-blog-list')">
            <i class="fas fa-list"></i> 博客列表
          </button>
          <button v-if="isAdmin" class="action-btn" @click="goToUserManagement">
            <i class="fas fa-users"></i> 用户管理
          </button>
          <button v-if="isAdmin" class="action-btn" @click="goToDeletedBlogs">
            <i class="fas fa-trash"></i> 已删除博客
          </button>
          <button class="action-btn" @click="goToAiChat">
            <i class="fas fa-robot"></i> AI对话
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      isAdmin: false
    };
  },
  created() {
    const user = JSON.parse(localStorage.getItem('user'));
    this.isAdmin = user && user.role === 'admin';
  },
  methods: {
    goToUserManagement() {
      this.$router.push('/user-management');
    },
    goToDeletedBlogs() {
      this.$router.push('/deleted-blogs');
    },
    goToAiChat() {
      this.$router.push('/ai-chat');
    }
  }
}
</script>

<style scoped>
.sidebar-left {
  position: fixed;
  left: 0;
  top: 0;
  width: 200px;
  height: 100vh;
  z-index: 10;
  padding: 15px;
}

.tv-frame {
  width: 100%;
  height: 100%;
  background: transparent;
  border-radius: 12px;
  padding: 12px;
  box-shadow: 0 8px 16px rgba(0,0,0,0.1);
  position: relative;
  overflow: hidden;
}

.tv-content {
  width: 100%;
  height: 100%;
  background-color: transparent;
  border-radius: 10px;
  padding: 15px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.action-buttons {
  display: flex;
  flex-direction: column;
  gap: 12px;
  width: 100%;
  max-width: 180px;
}

.action-btn {
  width: 100%;
  padding: 15px;
  border: none;
  border-radius: 8px;
  background-color: #f5f7fa;
  cursor: pointer;
  transition: all 0.3s;
  text-align: left;
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 1.1em;
  color: #2c3e50;
}

.action-btn:hover {
  background-color: #e4e7ed;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

@media screen and (max-width: 768px) {
  .sidebar-left {
    width: 180px;
    padding: 10px;
  }
  .action-btn {
    padding: 10px;
    font-size: 1em;
  }
}
</style>
