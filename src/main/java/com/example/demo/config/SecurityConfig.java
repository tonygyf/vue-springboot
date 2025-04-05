package com.example.demo.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable()
            .authorizeRequests()
            .antMatchers("/api/auth/**", "/api/blogs/**").permitAll()
            // 这意味着所有以"/api/blogs/"开头的路径都将被允许访问，包括"/api/blogs/"本身。
                .antMatchers(
                        "/",               // 首页
                        "/avatars/**",     // 用户头像
                        "/css/**",         // 样式
                        "/js/**",          // JS 脚本
                        "/images/**",      // 图片
                        "/favicon.ico"     // 图标
                ).permitAll()
            .anyRequest().authenticated();
        
        http.cors();
    }
}