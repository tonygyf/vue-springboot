<template>
  <div class="follow-list-page">
    <div class="header">
      <h2>{{ type === 'followers' ? '粉丝列表' : '关注列表' }}</h2>
      <div class="back-btn" @click="$router.back()">
        <i class="fas fa-arrow-left"></i> 返回
      </div>
    </div>
    
    <div class="user-list">
      <div v-for="user in userList" :key="user.username" class="user-item">
        <div class="user-info">
          <div class="user-avatar">
            <img :src="'http://localhost:8080' + user.avatarUrl" alt="头像" />
          </div>
          <span class="username">{{ user.username }}</span>
        </div>
        <button 
          class="follow-btn" 
          v-if="currentUsername !== user.username"
          @click="toggleFollow(user)"
          :class="{ 'following': user.isFollowing }"
        >
          <i :class="user.isFollowing ? 'fas fa-user-minus' : 'fas fa-user-plus'"></i>
          {{ user.isFollowing ? '取消关注' : '关注' }}
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'UserFollowList',
  props: {
    username: {
      type: String,
      required: true
    },
    type: {
      type: String,
      required: true,
      validator: value => ['followers', 'following'].includes(value)
    }
  },
  data() {
    return {
      userList: [],
      currentUsername: ''
    }
  },
  async created() {
    const currentUser = JSON.parse(localStorage.getItem('user') || '{}')
    this.currentUsername = currentUser.username
    await this.fetchUsers()
  },
  methods: {
    async fetchUsers() {
      try {
        const response = await axios.get(`/api/users/${this.username}/${this.type}`)
        this.userList = await Promise.all(response.data.map(async user => {
          const followStatus = await this.checkFollowStatus(user.username)
          return { ...user, isFollowing: followStatus }
        }))
      } catch (error) {
        console.error('获取用户列表失败:', error)
      }
    },
    async checkFollowStatus(targetUsername) {
      try {
        const response = await axios.get(`/api/users/${targetUsername}/follow/status`)
        return response.data.following
      } catch (error) {
        console.error('获取关注状态失败:', error)
        return false
      }
    },
    async toggleFollow(user) {
      try {
        if (user.isFollowing) {
          await axios.delete(`/api/users/${user.username}/follow`)
        } else {
          await axios.post(`/api/users/${user.username}/follow`)
        }
        user.isFollowing = !user.isFollowing
      } catch (error) {
        alert(error.response?.data?.message || '操作失败')
      }
    }
  }
}
</script>

<style scoped>
.follow-list-page {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.back-btn {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  color: #409eff;
}

.user-list {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.user-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}

.user-info {
  display: flex;
  align-items: center;
  gap: 15px;
}

.user-avatar img {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  object-fit: cover;
}

.username {
  font-size: 1.1em;
  color: #303133;
}

.follow-btn {
  padding: 8px 16px;
  border: none;
  border-radius: 6px;
  background-color: #409eff;
  color: white;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 8px;
  transition: all 0.3s;
}

.follow-btn:hover {
  background-color: #66b1ff;
}

.follow-btn.following {
  background-color: #909399;
}

.follow-btn.following:hover {
  background-color: #f56c6c;
}
</style>