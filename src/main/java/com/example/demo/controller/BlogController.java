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

    @GetMapping("/blogs")
    public ResponseEntity<List<Blog>> getAllBlogs() {
        List<Blog> blogs = blogService.getAllBlogs();
        return ResponseEntity.ok(blogs);
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
}