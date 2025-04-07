package com.example.demo.service;

import com.example.demo.entity.Blog;
import com.example.demo.entity.Comment;
import com.example.demo.entity.User;
import com.example.demo.repository.BlogRepository;
import com.example.demo.repository.CommentRepository;
import com.example.demo.repository.LikeRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BlogService {
    @Autowired
    private BlogRepository blogRepository;
    
    @Autowired
    private LikeRepository likeRepository;
    
    @Autowired
    private CommentRepository commentRepository;
    
    @Autowired
    private UserRepository userRepository;

    public List<Blog> getAllBlogs() {
        return blogRepository.findAllByOrderByCreatedAtDesc();
    }
    
    public Blog getBlogById(Integer id) {
        Optional<Blog> blog = blogRepository.findById(id);
        return blog.orElse(null);
    }
    
    public long getLikesCount(Integer blogId) {
        return likeRepository.countByBlogId(blogId);
    }
    
    public List<Comment> getBlogComments(Integer blogId) {
        return commentRepository.findByBlogBlogIdOrderByCreatedAtDesc(blogId);
    }
    
    public Comment createComment(Integer blogId, Integer userId, String content) {
        Blog blog = getBlogById(blogId);
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        
        Comment comment = new Comment();
        comment.setBlog(blog);
        comment.setUser(user);
        comment.setContent(content);
        
        return commentRepository.save(comment);
    }

    public Blog createBlog(Integer userId, String title, String content) {


        Blog blog = new Blog();
        blog.setUserId(userId);
        blog.setTitle(title);
        blog.setContent(content);
        
        return blogRepository.save(blog);
    }
    public Blog updateBlog(Integer blogId, String title, String content) {
        Blog blog = getBlogById(blogId);
        if (blog == null || blog.isDeleted()) return null;

        blog.setTitle(title);
        blog.setContent(content);
        blog.setUpdatedAt(java.time.LocalDateTime.now());
        return blogRepository.save(blog);
    }

    public boolean deleteBlog(Integer blogId) {
        Blog blog = getBlogById(blogId);
        if (blog == null || blog.isDeleted()) return false;

        blog.setDeleted(true); // 逻辑删除
        blog.setUpdatedAt(java.time.LocalDateTime.now());
        blogRepository.save(blog);
        return true;
    }

    public List<Blog> searchBlogs(String query) {
        if (query == null || query.trim().isEmpty()) {
            return getAllBlogs();
        }
        return blogRepository.findByTitleContainingOrContentContainingAndIsDeletedFalseOrderByCreatedAtDesc(
            query, query);
    }

}