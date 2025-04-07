package com.example.demo.repository;

import com.example.demo.entity.Blog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BlogRepository extends JpaRepository<Blog, Integer> {

    // 查询所有未删除的博客，按时间倒序
    List<Blog> findAllByIsDeletedFalseOrderByCreatedAtDesc();

    // 查询某个用户的博客，按时间倒序
    List<Blog> findByUserIdOrderByCreatedAtDesc(Integer userId);
    
    // 根据标题或内容搜索博客，只返回未删除的博客
    List<Blog> findByTitleContainingOrContentContainingAndIsDeletedFalseOrderByCreatedAtDesc(String title, String content);

    // 查询所有已删除的博客，按时间倒序
    List<Blog> findAllByIsDeletedTrueOrderByCreatedAtDesc();
}
