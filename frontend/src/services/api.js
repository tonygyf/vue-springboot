import axios from 'axios';

const API_URL = 'http://localhost:8080/api/';

class AuthService {
  login(username, password) {
    return axios.post(API_URL + 'auth/login', {
      username,
      password
    });
  }

  register(username, email, password) {
    return axios.post(API_URL + 'auth/register', {
      username,
      email,
      password
    });
  }

  getCurrentUser() {
    return JSON.parse(localStorage.getItem('user'));
  }
}

class BlogService {
  getBlogList() {
    return axios.get(API_URL + 'blogs');
  }

  getBlogDetails(blogId) {
    return axios.get(API_URL + `blogs/${blogId}`);
  }

  createBlog(title, content) {
    const currentUser = JSON.parse(localStorage.getItem('user'));
    return axios.post(API_URL + 'blogs/create', {
      userId: currentUser.userId,
      title,
      content
    });
  }

  createComment(blogId, content) {
    return axios.post(API_URL + `blogs/${blogId}/comments`, { content });
  }
  // services/api.js
  updateBlog(blogId, data) {
    return axios.put(`/api/blogs/${blogId}`, data);
  }

  searchBlogs(query) {
    return axios.get(API_URL + 'blogs/search', { params: { query } });
  }
  deleteBlog(blogId) {
    return axios.delete(`/api/blogs/${blogId}`);
  }

  getDeletedBlogList() {
    return axios.get(API_URL + 'blogs/deleted');
  }

  searchDeletedBlogs(query) {
    return axios.get(API_URL + 'blogs/deleted/search', { params: { query } });
  }

  restoreBlog(blogId) {
    return axios.post(API_URL + `blogs/${blogId}/restore`);
  }

  permanentDeleteBlog(blogId) {
    return axios.delete(API_URL + `blogs/${blogId}/permanent`);
  }

  likeBlog(blogId) {
    const currentUser = JSON.parse(localStorage.getItem('user'));
    return axios.post(API_URL + `blogs/${blogId}/like`, {
      userId: currentUser.userId
    });
  }

  unlikeBlog(blogId) {
    const currentUser = JSON.parse(localStorage.getItem('user'));
    return axios.delete(API_URL + `blogs/${blogId}/like`, {
      data: { userId: currentUser.userId }
    });
  }

  getLikeStatus(blogId) {
    const currentUser = JSON.parse(localStorage.getItem('user'));
    return axios.get(API_URL + `blogs/${blogId}/like/status`, {
      params: { userId: currentUser.userId }
    });
  }
  // 删除评论
  deleteComment(commentId, userId) {
    return axios.delete(API_URL + `blogs/comments/${commentId}`, {
      params: { userId }
    });
  }

}

export const authService = new AuthService();
export const blogService = new BlogService();