package com.nazarukiv.easymarket.models.enums;

import org.jspecify.annotations.Nullable;
import org.springframework.security.core.GrantedAuthority;

public enum Roles implements GrantedAuthority {
    ROLE_USER, ROLE_ADMIN;

    @Override
    public @Nullable String getAuthority() {
        return name();
    }
}
