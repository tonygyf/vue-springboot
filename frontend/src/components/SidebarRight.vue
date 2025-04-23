<template>
  <div class="user-info-wrapper">
    <div class="user-info-trigger">
      <div class="user-avatar-small">
        <img :src="'http://localhost:8080' + user.avatarUrl" alt="头像" />
      </div>
      <span class="username-small">{{ user.username }}</span>
    </div>
    <div class="user-info-expanded">
      <div class="user-info-card">
        <div class="user-avatar">
          <img :src="'http://localhost:8080' + user.avatarUrl" alt="头像" />
        </div>
        <h4 class="user-name">{{ user.username }}</h4>
        <div class="user-stats">
          <div class="stat-item">
            <span class="stat-label">权限</span>
            <span class="stat-value">{{ user.role }}</span>
          </div>
          <div class="stat-item clickable" @click="showFollowers">
            <span class="stat-label">粉丝</span>
            <span class="stat-value">{{ user.followersCount || 0 }}</span>
          </div>
          <div class="stat-item clickable" @click="showFollowing">
            <span class="stat-label">关注</span>
            <span class="stat-value">{{ user.followingCount || 0 }}</span>
          </div>
        </div>

        <div class="follow-section">
          <button class="follow-btn" @click="toggleFollow" v-if="!isCurrentUser">
            <i :class="isFollowing ? 'fas fa-user-minus' : 'fas fa-user-plus'"></i>
            {{ isFollowing ? '取消关注' : '关注' }}
          </button>
        </div>

        <div class="edit-section">
          <button class="edit-btn" @click="openEditDialog">
            <i class="fas fa-edit"></i> 编辑信息
          </button>
        </div>

        <div class="logout-section">
          <button class="logout-btn" @click="logout">
            <i class="fas fa-sign-out-alt"></i> 退出登录
          </button>
        </div>
      </div>
    </div>

    <!-- 编辑浮窗 -->
    <FloatEditor :visible="editDialogVisible" @close="closeEditDialog">
      <div class="editor-content">
        <h3>编辑我的信息</h3>

        <label>用户名</label>
        <input v-model="editingUser.username" disabled />

        <label>密码</label>
        <input type="text" v-model="editingUser.password" />

        <label>邮箱</label>
        <input v-model="editingUser.email" type="email" />

        <label>头像地址</label>
        <input v-model="editingUser.avatarUrl" />
        <img :src="'http://localhost:8080' + editingUser.avatarUrl"
             alt="头像预览"
             class="avatar-preview"
             v-if="editingUser.avatarUrl" />

        <div class="editor-actions">
          <button @click="closeEditDialog">取消</button>
          <button class="save-btn" @click="submitEdit">保存</button>
        </div>
      </div>
    </FloatEditor>

    <!-- 关注列表浮窗 -->
    <FloatEditor :visible="followListVisible" @close="followListVisible = false">
      <div class="follow-list-content">
        <h3>{{ followType === 'followers' ? '粉丝列表' : '关注列表' }}</h3>
        <div class="follow-list">
          <div v-for="user in followList" :key="user.username" class="follow-item">
            <div class="user-avatar-small">
              <img :src="'http://localhost:8080' + user.avatarUrl" alt="头像" />
            </div>
            <span class="username">{{ user.username }}</span>
            <button 
              class="follow-btn" 
              v-if="!isCurrentUser"
              @click="toggleFollow(user)"
              :class="{ 'following': user.isFollowing }"
            >
              <i :class="user.isFollowing ? 'fas fa-user-minus' : 'fas fa-user-plus'"></i>
              {{ user.isFollowing ? '取消关注' : '关注' }}
            </button>
          </div>
        </div>
      </div>
    </FloatEditor>
  </div>
</template>

<script>
import FloatEditor from './FloatEditor.vue';
import axios from 'axios';

export default {
  components: { FloatEditor },
  data() {
    return {
      user: {
        username: '',
        email: '',
        password: '',
        avatarUrl: '/avatars/admin.png',
        role: 'user',
        followersCount: 0,
        followingCount: 0
      },
      editDialogVisible: false,
      followListVisible: false,
      followType: '',
      followList: [],
      editingUser: {},
      isFollowing: false
    };
  },
  computed: {
    isCurrentUser() {
      const currentUser = JSON.parse(localStorage.getItem('user') || '{}');
      return currentUser.username === this.user.username;
    }
  },
  methods: {
    showFollowers() {
      this.$router.push(`/user/${this.user.username}/followers`);
    },
    showFollowing() {
      this.$router.push(`/user/${this.user.username}/following`);
    },
    async toggleFollow() {
      try {
        if (this.isFollowing) {
          await axios.delete(`/api/users/${this.user.username}/follow`);
          this.user.followersCount--;
        } else {
          await axios.post(`/api/users/${this.user.username}/follow`);
          this.user.followersCount++;
        }
        this.isFollowing = !this.isFollowing;
      } catch (error) {
        alert(error.response?.data?.message || '操作失败');
      }
    },
    async checkFollowStatus() {
      if (!this.isCurrentUser) {
        try {
          const response = await axios.get(`/api/users/${this.user.username}/follow/status`);
          this.isFollowing = response.data.following;
        } catch (error) {
          console.error('获取关注状态失败:', error);
        }
      }
    }
  },
  async created() {
    const savedUser = localStorage.getItem('user');
    if (savedUser) {
      this.user = JSON.parse(savedUser);
      await this.checkFollowStatus();
    }
  }
};
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

.stat-item.clickable {
  cursor: pointer;
}

.stat-item.clickable:hover {
  background-color: rgba(64, 158, 255, 0.1);
  border-radius: 4px;
}

.follow-section {
  margin-top: 10px;
}

.follow-btn {
  width: 100%;
  padding: 10px;
  background-color: #409eff;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  transition: all 0.3s;
}

.follow-btn:hover {
  background-color: #66b1ff;
}

.edit-section {
  margin-top: 10px;
}

.edit-btn {
  width: 100%;
  padding: 10px;
  background-color: #409eff;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  transition: all 0.3s;
}

.edit-btn:hover {
  background-color: #66b1ff;
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

.editor-content {
  max-width: 500px;
  width: 100%;
}

.editor-content label {
  display: block;
  margin-top: 15px;
  font-weight: bold;
}

.editor-content input {
  width: 100%;
  margin-top: 5px;
  padding: 6px 10px;
  border-radius: 4px;
  border: 1px solid #ccc;
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
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.save-btn:hover {
  background-color: #66b1ff;
}

.avatar-preview {
  margin-top: 10px;
  width: 60px;
  height: 60px;
  border-radius: 50%;
  object-fit: cover;
  border: 1px solid #ddd;
}

.follow-list-content {
  max-width: 400px;
  width: 100%;
}

.follow-list {
  margin-top: 20px;
}

.follow-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 10px;
  padding: 10px;
  border-bottom: 1px solid #ebeef5;
}

.follow-item:last-child {
  border-bottom: none;
}

.follow-item .username {
  font-size: 1em;
  color: #303133;
  flex-grow: 1;
}

.follow-item:hover {
  background-color: rgba(64, 158, 255, 0.1);
}

.follow-item .follow-btn {
  padding: 5px 10px;
  font-size: 0.8em;
  background-color: #409eff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 5px;
}

.follow-item .follow-btn:hover {
  background-color: #66b1ff;
}

.follow-item .follow-btn.following {
  background-color: #f56c6c;
}

.follow-item .follow-btn.following:hover {
  background-color: #f78989;
}

</style>
