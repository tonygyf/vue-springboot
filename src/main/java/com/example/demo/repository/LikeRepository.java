package com.example.demo.repository;

import com.example.demo.entity.Like;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LikeRepository extends JpaRepository<Like, Integer> {
    @Query("SELECT COUNT(l) FROM Like l WHERE l.blog.blogId = ?1")
    long countByBlogId(Integer blogId);
    
    List<Like> findByBlogBlogId(Integer blogId);
}