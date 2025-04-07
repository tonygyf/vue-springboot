package com.example.demo.repository;

import com.example.demo.entity.ChatResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ChatResponseRepository extends JpaRepository<ChatResponse, Long> {
}
