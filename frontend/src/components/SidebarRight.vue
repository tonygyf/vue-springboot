<template>
  <div class="user-info-wrapper">
    <div class="user-info-trigger">
      <div class="user-avatar-small">
        <img :src="'http://localhost:8080' + user.avatarUrl" alt="头像">
      </div>
      <span class="username-small">{{ user.username }}</span>
    </div>
    <div class="user-info-expanded">
      <div class="user-info-card">
        <div class="user-avatar">
          <img :src="'http://localhost:8080' + user.avatarUrl" alt="头像">
        </div>
        <h4 class="user-name">{{ user.username }}</h4>
        <div class="user-stats">
          <div class="stat-item">
            <span class="stat-label">权限</span>
            <span class="stat-value">{{ user.role }}</span>
          </div>
        </div>
        <div class="logout-section">
          <button class="logout-btn" @click="logout">
            <i class="fas fa-sign-out-alt"></i> 退出登录
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
      user: {
        username: '',
        blogCount: 0,
        followingCount: 0,
        followerCount: 0,
        avatarUrl: '/avatars/admin.png'
      }
    };
  },
  created() {
    const savedUser = localStorage.getItem('user');
    if (savedUser) {
      this.user = JSON.parse(savedUser);
    }
  },
  methods: {
    logout() {
      localStorage.removeItem('user');
      this.$router.push('/login');
    }
  }
}
</script>

<style scoped>
.user-info-wrapper {
  position: fixed;
  right: 20px;
  top: 20px;
  z-index: 1000;
}

.user-info-trigger {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 8px;
  background-color: rgba(255, 255, 255, 0.9);
  border-radius: 20px;
  cursor: pointer;
  transition: all 0.3s;
}

.user-avatar-small img {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  object-fit: cover;
}

.username-small {
  font-size: 0.9em;
  color: #303133;
}

.user-info-expanded {
  position: absolute;
  top: 100%;
  right: 0;
  margin-top: 10px;
  opacity: 0;
  visibility: hidden;
  transform: translateY(-10px);
  transition: all 0.3s;
}

.user-info-wrapper:hover .user-info-expanded {
  opacity: 1;
  visibility: visible;
  transform: translateY(0);
}

.user-info-card {
  background-color: #fff;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0,0,0,0.1);
  text-align: center;
  min-width: 200px;
}

.user-avatar img {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  object-fit: cover;
  margin-bottom: 10px;
}

.user-name {
  margin-bottom: 15px;
  font-size: 1.1em;
  color: #303133;
}

.user-stats {
  padding: 10px 0;
  border-top: 1px solid #ebeef5;
}

.stat-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 5px 0;
}

.stat-label {
  color: #909399;
  font-size: 0.9em;
}

.stat-value {
  color: #303133;
  font-weight: bold;
}

.logout-section {
  margin-top: 15px;
  padding-top: 15px;
  border-top: 1px solid #ebeef5;
  width: 100%;
}

.logout-btn {
  width: 100%;
  padding: 10px;
  border: none;
  border-radius: 6px;
  background-color: #f56c6c;
  color: white;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  transition: all 0.3s;
}

.logout-btn:hover {
  background-color: #f78989;
}
</style>
