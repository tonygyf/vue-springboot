import axios from 'axios';

const API_URL = 'http://localhost:8080/api';

class FollowService {
    async followUser(followerId, followingId) {
        try {
            const response = await axios.post(`${API_URL}/follow`, { followerId, followingId });
            return response.data;
        } catch (error) {
            throw new Error('关注用户失败');
        }
    }

    async unfollowUser(followerId, followingId) {
        try {
            const response = await axios.delete(`${API_URL}/follow`, { 
                data: { followerId, followingId }
            });
            return response.data;
        } catch (error) {
            throw new Error('取消关注失败');
        }
    }

    async getFollowers(userId) {
        try {
            const response = await axios.get(`${API_URL}/follow/followers/${userId}`);
            return response.data;
        } catch (error) {
            throw new Error('获取粉丝列表失败');
        }
    }

    async getFollowing(userId) {
        try {
            const response = await axios.get(`${API_URL}/follow/following/${userId}`);
            return response.data;
        } catch (error) {
            throw new Error('获取关注列表失败');
        }
    }

    async isFollowing(followerId, followingId) {
        try {
            const response = await axios.get(`${API_URL}/follow/check`, {
                params: { followerId, followingId }
            });
            return response.data;
        } catch (error) {
            throw new Error('检查关注状态失败');
        }
    }
}

export default new FollowService();