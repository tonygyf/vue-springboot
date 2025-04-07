package com.example.demo.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

@Service
public class OpenAIService {

    @Value("${openai.api.key}")
    private String apiKey;

    @Value("${openai.api.url}")
    private String apiUrl;

    private final WebClient webClient;
    private final ObjectMapper objectMapper;  // 用于 Jackson 解析 JSON

    public OpenAIService(WebClient.Builder webClientBuilder, ObjectMapper objectMapper) {
        this.webClient = webClientBuilder.build();
        this.objectMapper = objectMapper;
    }

    public Mono<String> getChatCompletion(String prompt) {
        // 构建请求体
        String requestBody = String.format("{\"model\": \"gpt-3.5-turbo\", \"messages\": [{\"role\": \"user\", \"content\": \"%s\"}]}", prompt);

        // 发送请求并处理响应
        return webClient.post()
                .uri(apiUrl)
                .header("Authorization", "Bearer " + apiKey)
                .header("Content-Type", "application/json")
                .body(BodyInserters.fromValue(requestBody))
                .retrieve()
                .bodyToMono(String.class)
                .map(response -> {
                    try {
                        // 使用 Jackson 解析 JSON
                        JsonNode json = objectMapper.readTree(response);
                        JsonNode choices = json.get("choices");
                        String aiContent = choices.get(0).get("message").get("content").asText();
                        return aiContent;  // 返回提取出来的 content
                    } catch (Exception e) {
                        e.printStackTrace();
                        return "抱歉，AI 响应解析失败。";  // 错误处理
                    }
                });
    }
}
