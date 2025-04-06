<template>
  <div class="user-management">
    <h2>用户管理</h2>
    <div class="user-list">
      <table class="user-table">
        <thead>
          <tr>
            <th>用户名</th>
            <th>角色</th>
            <th>操作</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="user in users" :key="user.id">
            <td>{{ user.username }}</td>
            <td>{{ user.role }}</td>
            <td>
              <button class="edit-btn" @click="editUser(user)">
                <i class="fas fa-edit"></i> 编辑
              </button>
              <button class="delete-btn" @click="deleteUser(user)">
                <i class="fas fa-trash"></i> 删除
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'UserManagement',
  data() {
    return {
      users: []
    };
  },
  created() {
    this.fetchUsers();
  },
  methods: {
    async fetchUsers() {
      try {
        const response = await axios.get('http://localhost:8080/api/users');
        this.users = response.data;
      } catch (error) {
        console.error('获取用户列表失败:', error);
      }
    },
    editUser(user) {
      // 实现编辑用户的逻辑
      console.log('编辑用户:', user);
    },
    async deleteUser(user) {
      if (confirm(`确定要删除用户 ${user.username} 吗？`)) {
        try {
          await axios.delete(`http://localhost:8080/api/users/${user.id}`);
          await this.fetchUsers();
        } catch (error) {
          console.error('删除用户失败:', error);
        }
      }
    }
  }
};
</script>

<style scoped>
.user-management {
  padding: 20px;
}

.user-list {
  margin-top: 20px;
}

.user-table {
  width: 100%;
  border-collapse: collapse;
  background-color: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 12px rgba(0,0,0,0.1);
}

th, td {
  padding: 12px;
  text-align: left;
  border-bottom: 1px solid #ebeef5;
}

th {
  background-color: #f5f7fa;
  color: #606266;
  font-weight: 500;
}

.edit-btn, .delete-btn {
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  margin-right: 8px;
  display: inline-flex;
  align-items: center;
  gap: 4px;
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
</style>