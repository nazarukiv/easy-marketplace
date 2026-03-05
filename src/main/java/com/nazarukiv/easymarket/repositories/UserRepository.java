package com.nazarukiv.easymarket.repositories;

import com.nazarukiv.easymarket.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);
}
