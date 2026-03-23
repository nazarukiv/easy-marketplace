package com.nazarukiv.easymarket.services;


import com.nazarukiv.easymarket.models.User;
import com.nazarukiv.easymarket.models.enums.Roles;
import com.nazarukiv.easymarket.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final EmailService emailService;

    public boolean createUser(User user){
        String email = user.getEmail();
        if (userRepository.findByEmail(email) != null) return false;
        user.setActive(true);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.getRoles().add(Roles.ROLE_USER);
        log.info("user was successfully registered with email: {}", email);
        userRepository.save(user);

        emailService.sendEmail(
                user.getEmail(),
                "Welcome to EasyMarket",
                "Your account was created successfully"
        );

        return true;
    }

    public User getUserById(Long id){
        return userRepository.findById(id).orElse(null);
    }

    public List<User> list(){
        return userRepository.findAll();
    }

    public void banUser(Long id) {
        User user = userRepository.findById(id).orElse(null);

        if (user != null) {
            user.setActive(!user.isActive());

            log.info("Toggle ban for user id = {}; email: {}; active = {}",
                    user.getId(), user.getEmail(), user.isActive());

            userRepository.save(user);
        }
    }

    public void changeUserRoles(User user, Map<String, String> form) {

        Set<String> roles = Arrays.stream(Roles.values())
                .map(Roles::name)
                .collect(Collectors.toSet());

        user.getRoles().clear();

        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Roles.valueOf(key));
            }
        }

        userRepository.save(user);
    }
}
