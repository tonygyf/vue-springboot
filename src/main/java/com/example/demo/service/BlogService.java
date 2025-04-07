package com.example.demo.service;

import com.example.demo.entity.Blog;
import com.example.demo.entity.Comment;
import com.example.demo.entity.Like;
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
        return blogRepository.findAllByIsDeletedFalseOrderByCreatedAtDesc();
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

    public List<Blog> getDeletedBlogs() {
        return blogRepository.findAllByIsDeletedTrueOrderByCreatedAtDesc();
    }

    public boolean getLikeStatus(Integer blogId, Integer userId) {
        return likeRepository.existsByBlogBlogIdAndUserUserId(blogId, userId);
    }

    public void likeBlog(Integer blogId, Integer userId) {
        if (!getLikeStatus(blogId, userId)) {
            Blog blog = getBlogById(blogId);
            User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
            
            Like like = new Like();
            like.setBlog(blog);
            like.setUser(user);
            likeRepository.save(like);
        }
    }

    public void unlikeBlog(Integer blogId, Integer userId) {
        Like like = likeRepository.findByBlogBlogIdAndUserUserId(blogId, userId);
        if (like != null) {
            likeRepository.delete(like);
        }
    }
    public boolean deleteComment(Integer commentId, Integer userId) {
        Optional<Comment> commentOpt = commentRepository.findById(commentId);
        if (commentOpt.isEmpty()) return false;

        Comment comment = commentOpt.get();
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isEmpty()) return false;

        User user = userOpt.get();
        if (!"admin".equals(user.getRole())) {
            return false; // 只有 admin 才能删除评论
        }

        commentRepository.delete(comment);
        return true;
    }
//    删除评论
    public boolean deleteCommentById(Integer commentId) {
        Optional<Comment> comment = commentRepository.findById(commentId);
        if (comment.isPresent()) {
            commentRepository.deleteById(commentId);
            return true;
        }
        return false;
    }



}