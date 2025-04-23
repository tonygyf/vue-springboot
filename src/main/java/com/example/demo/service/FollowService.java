package com.example.demo.service;

import com.example.demo.entity.Follow;
import com.example.demo.entity.User;
import com.example.demo.repository.FollowRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class FollowService {
    @Autowired
    private FollowRepository followRepository;

    @Autowired
    private UserRepository userRepository;

    @Transactional
    public void followUser(Integer followerId, Integer followingId) {
        if (followerId.equals(followingId)) {
            throw new IllegalArgumentException("用户不能关注自己");
        }

        User follower = userRepository.findById(followerId)
                .orElseThrow(() -> new IllegalArgumentException("关注者不存在"));
        User following = userRepository.findById(followingId)
                .orElseThrow(() -> new IllegalArgumentException("被关注者不存在"));

        if (followRepository.existsByFollowerAndFollowing(follower, following)) {
            throw new IllegalArgumentException("已经关注该用户");
        }

        Follow follow = new Follow();
        follow.setFollower(follower);
        follow.setFollowing(following);
        follow.setCreatedAt(LocalDateTime.now());
        followRepository.save(follow);
    }

    @Transactional
    public void unfollowUser(Integer followerId, Integer followingId) {
        User follower = userRepository.findById(followerId)
                .orElseThrow(() -> new IllegalArgumentException("关注者不存在"));
        User following = userRepository.findById(followingId)
                .orElseThrow(() -> new IllegalArgumentException("被关注者不存在"));

        if (!followRepository.existsByFollowerAndFollowing(follower, following)) {
            throw new IllegalArgumentException("未关注该用户");
        }

        followRepository.deleteByFollowerAndFollowing(follower, following);
    }

    public List<User> getFollowers(Integer userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("用户不存在"));
        return followRepository.findByFollowing(user).stream()
                .map(Follow::getFollower)
                .collect(Collectors.toList());
    }

    public List<User> getFollowing(Integer userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("用户不存在"));
        return followRepository.findByFollower(user).stream()
                .map(Follow::getFollowing)
                .collect(Collectors.toList());
    }

    public boolean isFollowing(Integer followerId, Integer followingId) {
        User follower = userRepository.findById(followerId)
                .orElseThrow(() -> new IllegalArgumentException("关注者不存在"));
        User following = userRepository.findById(followingId)
                .orElseThrow(() -> new IllegalArgumentException("被关注者不存在"));
        return followRepository.existsByFollowerAndFollowing(follower, following);
    }
}