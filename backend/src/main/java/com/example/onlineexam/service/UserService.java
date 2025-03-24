package com.example.onlineexam.service;

import com.example.onlineexam.entity.User;

public interface UserService {
    User login(String username, String password);
} 