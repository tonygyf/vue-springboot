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
}