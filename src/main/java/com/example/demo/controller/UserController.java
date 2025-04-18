package com.example.demo.controller;

import com.example.demo.entity.User;
import com.example.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/users")
@CrossOrigin(origins = "*")
public class UserController {

    @Autowired
    private UserService userService;

    // 修改点：新增 GET /api/users 映射
    @GetMapping
    public ResponseEntity<List<User>> getAllUsersAlias(
            @RequestParam(required = false, defaultValue = "") String query,
            @RequestParam(required = false, defaultValue = "") String role) {
        List<User> users = userService.searchUsers(query, role);
        return ResponseEntity.ok(users);
    }

    // 可选：保留旧路径 /list
//    @GetMapping("/list")
//    public ResponseEntity<List<User>> getAllUsers() {
//        List<User> users = userService.findAllUsers();
//        return ResponseEntity.ok(users);
//    }

    @GetMapping("/{username}")
    public ResponseEntity<User> getUserByUsername(@PathVariable String username) {
        User user = userService.findByUsername(username);
        if (user != null) {
            return ResponseEntity.ok(user);
        }
        return ResponseEntity.notFound().build();
    }

    @PutMapping("/{username}")
    public ResponseEntity<User> updateUser(@PathVariable String username, @RequestBody User updatedUser) {
        User user = userService.findByUsername(username);
        if (user != null) {
            updatedUser.setUserId(user.getUserId());
            User result = userService.updateUser(updatedUser);
            return ResponseEntity.ok(result);
        }
        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{username}")
    public ResponseEntity<Void> deleteUser(@PathVariable String username) {
        User user = userService.findByUsername(username);
        if (user != null) {
            userService.deleteUser(user);
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.notFound().build();
    }

    @GetMapping("/search")
    public ResponseEntity<List<User>> searchUsers(@RequestParam(required = false) String query) {
        List<User> users = userService.searchUsers(query);
        return ResponseEntity.ok(users);
    }
}
