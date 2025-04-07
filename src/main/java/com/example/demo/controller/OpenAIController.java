package com.example.demo.controller;

import com.example.demo.entity.ChatResponse;
import com.example.demo.repository.ChatResponseRepository;
import com.example.demo.service.OpenAIService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;
import reactor.core.scheduler.Schedulers;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api") // 添加统一前缀
public class OpenAIController {

    @Autowired
    private OpenAIService openAIService;

    @Autowired
    private ChatResponseRepository chatResponseRepository;

    @PostMapping("/chat")
    public Mono<ResponseEntity<Map<String, String>>> chat(@RequestBody Map<String, String> requestBody) {
        String prompt = requestBody.get("prompt");
        if (prompt == null || prompt.isEmpty()) {
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "Prompt cannot be empty.");
            return Mono.just(ResponseEntity.badRequest().body(errorResponse));
        }

        // 调用服务获取 ChatGPT 的响应
        return openAIService.getChatCompletion(prompt)
                .publishOn(Schedulers.boundedElastic())
                .map(response -> {
                    // 保存到数据库
                    ChatResponse chatResponse = new ChatResponse();
                    chatResponse.setPrompt(prompt);
                    chatResponse.setResponse(response);
                    chatResponse.setCreatedAt(LocalDateTime.now());
                    chatResponseRepository.save(chatResponse);

                    // 构建成功的响应
                    Map<String, String> successResponse = new HashMap<>();
                    successResponse.put("response", response);
                    return ResponseEntity.ok(successResponse);
                })
                .onErrorResume(e -> {
                    // 处理错误情况
                    Map<String, String> errorResponse = new HashMap<>();
                    errorResponse.put("error", "Failed to get chat completion: " + e.getMessage());
                    return Mono.just(ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse));
                });
    }
}