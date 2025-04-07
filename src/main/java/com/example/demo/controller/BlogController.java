package com.example.demo.controller;

import com.example.demo.entity.Blog;
import com.example.demo.entity.Comment;
import com.example.demo.service.BlogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class BlogController {
    @Autowired
    private BlogService blogService;

    @GetMapping("/blogs/search")
    public ResponseEntity<List<Blog>> searchBlogs(@RequestParam String query) {
        List<Blog> blogs = blogService.searchBlogs(query);
        return ResponseEntity.ok(blogs);
    }

    @GetMapping("/blogs")
    public ResponseEntity<List<Blog>> getAllBlogs() {
        List<Blog> blogs = blogService.getAllBlogs();
        return ResponseEntity.ok(blogs);
    }

    @PostMapping("/blogs/{blogId}/comments")
    public ResponseEntity<?> createComment(@PathVariable Integer blogId, @RequestBody Map<String, String> payload) {
        try {
            // 这里暂时硬编码userId为1，实际应该从认证信息中获取
            Integer userId = 1;
            String content = payload.get("content");
            Comment comment = blogService.createComment(blogId, userId, content);
            return ResponseEntity.ok(comment);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/blogs/{id}")
    public ResponseEntity<?> getBlogDetails(@PathVariable Integer id) {
        Blog blog = blogService.getBlogById(id);
        if (blog == null) {
            return ResponseEntity.notFound().build();
        }

        long likesCount = blogService.getLikesCount(id);
        List<Comment> comments = blogService.getBlogComments(id);

        Map<String, Object> response = new HashMap<>();
        response.put("blog", blog);
        response.put("likesCount", likesCount);
        response.put("comments", comments);

        return ResponseEntity.ok(response);
    }

    @PostMapping("/blogs/create")
    public ResponseEntity<?> createBlog(@RequestBody Blog blog) {
        try {
            if (blog.getUserId() == null) {
                return ResponseEntity.badRequest().body("用户ID不能为空");
            }
            
            if (blog.getTitle() == null || blog.getTitle().trim().isEmpty()) {
                return ResponseEntity.badRequest().body("标题不能为空");
            }
            if (blog.getContent() == null || blog.getContent().trim().isEmpty()) {
                return ResponseEntity.badRequest().body("内容不能为空");
            }

            Blog savedBlog = blogService.createBlog(blog.getUserId(), blog.getTitle(), blog.getContent());
            return ResponseEntity.ok(savedBlog);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
    @PutMapping("/blogs/{id}")
    public ResponseEntity<?> updateBlog(@PathVariable Integer id, @RequestBody Blog updatedBlog) {
        try {
            Blog blog = blogService.updateBlog(id, updatedBlog.getTitle(), updatedBlog.getContent());
            if (blog == null) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(blog);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/blogs/deleted")
    public ResponseEntity<?> getDeletedBlogs() {
        List<Blog> blogs = blogService.getDeletedBlogs();
        return ResponseEntity.ok(blogs);
    }

    @GetMapping("/blogs/{blogId}/like/status")
    public ResponseEntity<?> getLikeStatus(@PathVariable Integer blogId) {
        try {
            // 这里暂时硬编码userId为1，实际应该从认证信息中获取
            Integer userId = 1;
            boolean liked = blogService.getLikeStatus(blogId, userId);
            Map<String, Object> response = new HashMap<>();
            response.put("liked", liked);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/blogs/{blogId}/like")
    public ResponseEntity<?> likeBlog(@PathVariable Integer blogId) {
        try {
            // 这里暂时硬编码userId为1，实际应该从认证信息中获取
            Integer userId = 1;
            blogService.likeBlog(blogId, userId);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @DeleteMapping("/blogs/{blogId}/like")
    public ResponseEntity<?> unlikeBlog(@PathVariable Integer blogId) {
        try {
            // 这里暂时硬编码userId为1，实际应该从认证信息中获取
            Integer userId = 1;
            blogService.unlikeBlog(blogId, userId);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @DeleteMapping("/blogs/{id}")
    public ResponseEntity<?> deleteBlog(@PathVariable Integer id) {
        try {
            boolean deleted = blogService.deleteBlog(id);
            if (!deleted) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok("博客已删除");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}