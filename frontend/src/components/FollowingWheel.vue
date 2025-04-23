<template>
  <div class="following-wheel-container">
    <div class="wheel-container">
      <div class="wheel" :style="wheelStyle" @mousedown="startDrag" @mousemove="onDrag" @mouseup="stopDrag" @mouseleave="stopDrag" @wheel="onWheel">
        <div class="center-user">
          <img :src="currentUser.avatarUrl" alt="当前用户" class="user-avatar" />
          <span>{{ currentUser.username }}</span>
        </div>
        <div v-for="(user, index) in followingUsers" :key="user.id" 
             class="following-user" 
             :style="getUserPosition(index)">
          <img :src="user.avatarUrl" alt="关注用户" class="user-avatar" />
          <span>{{ user.username }}</span>
        </div>
      </div>
    </div>
    
    <div class="selected-user-blogs">
      <h3>{{ selectedUser ? selectedUser.username + '的博客' : '选择一个用户查看博客' }}</h3>
      <div v-if="selectedUser" class="blog-list">
        <div v-for="blog in userBlogs" :key="blog.id" class="blog-item">
          <h4>{{ blog.title }}</h4>
          <p>{{ blog.content }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, computed, onMounted } from 'vue';
import axios from 'axios';

export default {
  name: 'FollowingWheel',
  setup() {
    const currentUser = ref(JSON.parse(localStorage.getItem('user') || '{}'));
    const followingUsers = ref([]);
    const selectedUser = ref(null);
    const userBlogs = ref([]);
    const rotation = ref(0);
    const isDragging = ref(false);
    const startX = ref(0);
    const startRotation = ref(0);

    const wheelStyle = computed(() => ({
      transform: `rotate(${rotation.value}deg)`
    }));

    const getUserPosition = (index) => {
      const totalUsers = followingUsers.value.length;
      const angle = (index * (180 / (totalUsers - 1))) - 90; // 均匀分布在半圆上
      const radius = 150;
      const x = Math.cos((angle * Math.PI) / 180) * radius;
      const y = Math.sin((angle * Math.PI) / 180) * radius;
      
      return {
        transform: `translate(${x}px, ${y}px)`,
        transition: 'transform 0.3s ease'
      };
    };

    const startDrag = (e) => {
      isDragging.value = true;
      startX.value = e.clientX;
      startRotation.value = rotation.value;
    };

    const onDrag = (e) => {
      if (!isDragging.value) return;
      
      const deltaX = e.clientX - startX.value;
      rotation.value = startRotation.value + deltaX * 0.5;
      
      // 计算当前旋转角度对应的用户
      const normalizedRotation = ((rotation.value % 360) + 360) % 360;
      const userIndex = Math.floor(normalizedRotation / (360 / followingUsers.value.length));
      selectedUser.value = followingUsers.value[userIndex];
      
      if (selectedUser.value) {
        fetchUserBlogs(selectedUser.value.id);
      }
    };
    
    const onWheel = (e) => {
      e.preventDefault();
      rotation.value += e.deltaY * 0.2;
      
      const normalizedRotation = ((rotation.value % 360) + 360) % 360;
      const userIndex = Math.floor(normalizedRotation / (360 / followingUsers.value.length));
      selectedUser.value = followingUsers.value[userIndex];
      
      if (selectedUser.value) {
        fetchUserBlogs(selectedUser.value.id);
      }
    };

    const stopDrag = () => {
      isDragging.value = false;
    };

    const fetchFollowing = async () => {
      try {
        const response = await axios.get(`http://localhost:8080/api/users/${currentUser.value.id}/following`);
        followingUsers.value = response.data;
      } catch (error) {
        console.error('获取关注列表失败:', error);
      }
    };

    const fetchUserBlogs = async (userId) => {
      try {
        const response = await axios.get(`http://localhost:8080/api/users/${userId}/blogs`);
        userBlogs.value = response.data;
      } catch (error) {
        console.error('获取用户博客失败:', error);
      }
    };

    onMounted(() => {
      fetchFollowing();
    });

    return {
      currentUser,
      followingUsers,
      selectedUser,
      userBlogs,
      wheelStyle,
      getUserPosition,
      startDrag,
      onDrag,
      stopDrag
    };
  }
};
</script>

<style scoped>
.following-wheel-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 20px;
}

.wheel-container {
  position: relative;
  width: 400px;
  height: 200px;
  overflow: hidden;
  margin-bottom: 40px;
}

.wheel {
  position: absolute;
  bottom: 0;
  left: 50%;
  width: 300px;
  height: 300px;
  transform-origin: center bottom;
  transition: transform 0.3s ease;
}

.center-user {
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  flex-direction: column;
  align-items: center;
}

.following-user {
  position: absolute;
  bottom: 0;
  left: 50%;
  display: flex;
  flex-direction: column;
  align-items: center;
  transform-origin: center bottom;
  transition: transform 0.3s ease;
}

.user-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  margin-bottom: 5px;
}

.selected-user-blogs {
  width: 100%;
  max-width: 600px;
}

.blog-list {
  margin-top: 20px;
}

.blog-item {
  background: rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  padding: 15px;
  margin-bottom: 15px;
}

.blog-item h4 {
  margin: 0 0 10px 0;
  color: #fff;
}

.blog-item p {
  margin: 0;
  color: #ddd;
}
</style>