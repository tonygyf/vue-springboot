package com.example.demo.controller;

import com.example.demo.entity.User;
import com.example.demo.service.FollowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/follows")
public class FollowController {
    @Autowired
    private FollowService followService;

    @PostMapping("/{followerId}/follow/{followingId}")
    public ResponseEntity<?> followUser(@PathVariable Integer followerId, @PathVariable Integer followingId) {
        try {
            followService.followUser(followerId, followingId);
            return ResponseEntity.ok().build();
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @DeleteMapping("/{followerId}/unfollow/{followingId}")
    public ResponseEntity<?> unfollowUser(@PathVariable Integer followerId, @PathVariable Integer followingId) {
        try {
            followService.unfollowUser(followerId, followingId);
            return ResponseEntity.ok().build();
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/{userId}/followers")
    public ResponseEntity<?> getFollowers(@PathVariable Integer userId) {
        try {
            List<User> followers = followService.getFollowers(userId);
            return ResponseEntity.ok(followers);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/{userId}/following")
    public ResponseEntity<?> getFollowing(@PathVariable Integer userId) {
        try {
            List<User> following = followService.getFollowing(userId);
            return ResponseEntity.ok(following);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/{followerId}/status/{followingId}")
    public ResponseEntity<?> getFollowStatus(@PathVariable Integer followerId, @PathVariable Integer followingId) {
        try {
            boolean isFollowing = followService.isFollowing(followerId, followingId);
            Map<String, Boolean> response = new HashMap<>();
            response.put("isFollowing", isFollowing);
            return ResponseEntity.ok(response);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}