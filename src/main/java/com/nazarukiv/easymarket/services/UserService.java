package com.nazarukiv.easymarket.services;


import com.nazarukiv.easymarket.models.User;
import com.nazarukiv.easymarket.models.enums.Roles;
import com.nazarukiv.easymarket.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public boolean createUser(User user){
        String email = user.getEmail();
        if (userRepository.findByEmail(email) != null) return false;
        user.setActive(true);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.getRoles().add(Roles.ROLE_USER);
        log.info("user was successfully registered with email: {}", email);
        userRepository.save(user);
        return true;
    }
}
