package com.example.demo.repository;

import com.example.demo.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    User findByUsername(String username);
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);
    
    // 根据用户名或角色搜索用户，按创建时间倒序排序
    List<User> findByUsernameContainingOrRoleContainingOrderByCreatedAtDesc(String username, String role);
}