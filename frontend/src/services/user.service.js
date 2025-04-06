import axios from 'axios';

const API_URL = 'http://localhost:8080/api';

class UserService {
    async getAllUsers() {
        try {
            const response = await axios.get(`${API_URL}/users`);
            return response.data;
        } catch (error) {
            throw new Error('获取用户列表失败');
        }
    }

    async updateUser(userId, userData) {
        try {
            const response = await axios.put(`${API_URL}/users/${userId}`, userData);
            return response.data;
        } catch (error) {
            throw new Error('更新用户信息失败');
        }
    }

    async deleteUser(userId) {
        try {
            await axios.delete(`${API_URL}/users/${userId}`);
        } catch (error) {
            throw new Error('删除用户失败');
        }
    }

    async getUserProfile(userId) {
        try {
            const response = await axios.get(`${API_URL}/users/${userId}`);
            return response.data;
        } catch (error) {
            throw new Error('获取用户信息失败');
        }
    }
}

export default new UserService();