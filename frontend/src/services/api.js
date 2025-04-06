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
}

export const authService = new AuthService();
export const blogService = new BlogService();