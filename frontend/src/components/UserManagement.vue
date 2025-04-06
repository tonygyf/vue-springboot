<template>
  <div class="user-management">
    <h2>用户管理</h2>
    <div v-if="message" class="alert" :class="messageClass" role="alert">
      {{ message }}
    </div>
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
        <tr v-for="user in users" :key="user.userId">
          <td>{{ user.username }}</td>
          <td>{{ user.role }}</td>
          <td>
            <button class="edit-btn" @click="openEditDialog(user)">
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

    <!-- 编辑浮窗 -->
    <FloatEditor :visible="editDialogVisible" @close="closeEditDialog">
      <div class="editor-content">
        <h3>编辑用户</h3>

        <label>用户名</label>
        <input v-model="editingUser.username" disabled />

        <label>密码</label>
        <input type="text" v-model="editingUser.password" />

        <label>邮箱</label>
        <input v-model="editingUser.email" type="email" />

        <label>角色</label>
        <select v-model="editingUser.role">
          <option value="admin">管理员</option>
          <option value="user">用户</option>
        </select>

        <label>头像地址</label>
        <input v-model="editingUser.avatarUrl" />
        <img :src="'http://localhost:8080' + editingUser.avatarUrl" alt="头像预览" class="avatar-preview"
             v-if="editingUser.avatarUrl"/>

        <label>创建时间</label>
        <input :value="formatDate(editingUser.createdAt)" type="datetime-local" disabled/>

        <label>更新时间</label>
        <input :value="formatDate(editingUser.updatedAt)" type="datetime-local" disabled/>

        <div class="editor-actions">
          <button @click="closeEditDialog">取消</button>
          <button class="save-btn" @click="submitEdit">保存</button>
        </div>
      </div>
    </FloatEditor>
  </div>
</template>

<script>
import axios from 'axios';
import FloatEditor from './FloatEditor.vue';

export default {
  name: 'UserManagement',
  components: {FloatEditor},
  data() {
    return {
      users: [],
      message: '',
      messageClass: '',
      editDialogVisible: false,
      editingUser: {}
    };
  },
  created() {
    this.fetchUsers();
  },
  methods: {
    async fetchUsers() {
      try {
        const res = await axios.get('/api/users');
        this.users = res.data;
      } catch (error) {
        this.message = error.response?.data?.message || '获取用户列表失败';
        this.messageClass = 'alert-danger';
      }
    },
    openEditDialog(user) {
      this.editingUser = {...user};
      this.editDialogVisible = true;
    },
    closeEditDialog() {
      this.editDialogVisible = false;
    },
    async submitEdit() {
      try {
        const payload = {
          username: this.editingUser.username,
          password: this.editingUser.password,
          email: this.editingUser.email,
          avatarUrl: this.editingUser.avatarUrl,
          role: this.editingUser.role
        };
        await axios.put(`/api/users/${this.editingUser.username}`, payload);
        this.message = '用户信息更新成功';
        this.messageClass = 'alert-success';
        this.editDialogVisible = false;
        this.fetchUsers();
      } catch (error) {
        this.message = error.response?.data?.message || '更新用户信息失败';
        this.messageClass = 'alert-danger';
      }
    },
    async deleteUser(user) {
      if (confirm(`确定要删除用户 ${user.username} 吗？`)) {
        try {
          await axios.delete(`/api/users/${user.username}`);
          this.message = '用户删除成功';
          this.messageClass = 'alert-success';
          this.fetchUsers();
        } catch (error) {
          this.message = error.response?.data?.message || '删除用户失败';
          this.messageClass = 'alert-danger';
        }
      }
    },
    formatDate(dateStr) {
      if (!dateStr) return '';
      return dateStr.substring(0, 16);
    }
  }
};
</script>

<style scoped>
.user-management {
  max-width: 900px;
  margin: 0 auto;
  padding: 20px;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
}

h2 {
  text-align: center;
  margin-bottom: 20px;
  font-weight: 600;
  color: #303133;
}

.alert {
  margin-bottom: 20px;
  padding: 10px;
  border-radius: 4px;
  text-align: center;
}

.alert-success {
  background-color: #d4edda;
  color: #155724;
  border: 1px solid #c3e6cb;
}

.alert-danger {
  background-color: #f8d7da;
  color: #721c24;
  border: 1px solid #f5c6cb;
}

.user-table {
  width: 100%;
  border-collapse: collapse;
  background-color: white;
  border-radius: 6px;
  overflow: hidden;
}

th, td {
  padding: 10px;
  text-align: left;
  border-bottom: 1px solid #ebeef5;
  font-size: 14px;
}

th {
  background-color: #f9f9f9;
  font-weight: 600;
  color: #606266;
}

.edit-btn, .delete-btn {
  padding: 6px 10px;
  border: none;
  border-radius: 4px;
  font-size: 13px;
  cursor: pointer;
  margin-right: 6px;
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

.editor-content {
  max-width: 500px;
  width: 100%;
  padding: 10px;
}

.editor-content label {
  display: block;
  margin-top: 12px;
  font-weight: bold;
  font-size: 14px;
  color: #303133;
}

.editor-content input,
.editor-content select {
  width: 100%;
  margin-top: 4px;
  padding: 6px 10px;
  font-size: 14px;
  border-radius: 4px;
  border: 1px solid #dcdfe6;
  box-sizing: border-box;
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
  padding: 6px 14px;
  border: none;
  border-radius: 4px;
  font-size: 14px;
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
</style>
