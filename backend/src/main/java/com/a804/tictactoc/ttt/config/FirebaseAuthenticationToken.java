package com.a804.tictactoc.ttt.config;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;

public class FirebaseAuthenticationToken extends AbstractAuthenticationToken {

    private final UserDetails userDetails;

    public FirebaseAuthenticationToken(UserDetails userDetails) {
        super(userDetails.getAuthorities());
        this.userDetails = userDetails;
        super.setAuthenticated(true); // 필수! 인증된 토큰으로 표시
    }

    @Override
    public Object getCredentials() {
        return null;
    }

    @Override
    public UserDetails getPrincipal() {
        return userDetails;
    }
}