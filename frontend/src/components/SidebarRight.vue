<template>
  <div class="sidebar-right">
    <div class="user-info-card">
      <div class="user-avatar">
        <img :src="'http://localhost:8080' + user.avatarUrl" alt="头像">
      </div>
      <h4 class="user-name">{{ user.username }}</h4>
      <div class="user-stats">
<!--        <div class="stat-item">-->
<!--          <span class="stat-label">博客</span>-->
<!--          <span class="stat-value">{{ user.blogCount }}</span>-->
<!--        </div>-->

        <div class="stat-item">
          <span class="stat-label">权限</span>
          <span class="stat-value">{{ user.role }}</span>
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
  }
}
</script>


<style scoped>
.sidebar-right {
  position: fixed;
  right: calc((100% - 1440px) / 2 + 20px);
  top: 20px;
  width: 250px;
  background-color: #fff;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0,0,0,.1);
  height: fit-content;
}
@media screen and (max-width: 1440px) {
  .sidebar-right {
    right: 20px;
  }
}
@media screen and (max-width: 768px) {
  .sidebar-right {
    display: none;
  }
}
.user-info-card {
  text-align: center;
}
.user-avatar img {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  object-fit: cover;
}
.user-name {
  margin-bottom: 20px;
  font-size: 1.2em;
  color: #303133;
}
.user-stats {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px;
  padding: 15px 0;
  border-top: 1px solid #ebeef5;
}
.stat-item {
  display: flex;
  flex-direction: column;
  gap: 5px;
}
.stat-label {
  color: #909399;
  font-size: 0.9em;
}
.stat-value {
  color: #303133;
  font-weight: bold;
}
</style>
