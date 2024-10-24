package com.kosa.kojapingprj.config;

import com.kosa.kojaping.service.RoleService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Collection;

@Slf4j
@Component
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

    private RequestCache requestCache = new HttpSessionRequestCache();
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Autowired
    private RoleService roleService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, FilterChain chain, Authentication authentication) throws IOException, ServletException {
        AuthenticationSuccessHandler.super.onAuthenticationSuccess(request, response, chain, authentication);
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        log.info("onAuthenticationSuccess");

        // 사용자의 권한(게스트/호스트) 가져오기
        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        String roleName = "";

        // 사용자가 가진 권한 중에서 첫 번째 권한을 가져와서 설정 (여러 권한 중 하나만 사용한다고 가정)
        for (GrantedAuthority authority : authorities) {
            roleName = authority.getAuthority();  // 권한 이름 (예: 호스트, 게스트) 가져오기
            log.info("권한: " + roleName);
            break; // 첫 번째 권한만 가져오려면 루프를 종료합니다.
        }

        SavedRequest savedRequest = requestCache.getRequest(request, response);

        // 접근 권한 없는 경로 접근해서 스프링 시큐리티가 인터셉트해서 로그인폼으로 이동 후 로그인 성공한 경우
        if (savedRequest != null) {
            String targetUrl = savedRequest.getRedirectUrl();
            log.info("targetUrl = {}", targetUrl);

            // roleName에 따른 리다이렉트 처리
            if (roleName.equals("호스트")) { // 호스트 권한
                redirectStrategy.sendRedirect(request, response, "/host/hostPage"); // 호스트 페이지로 리다이렉트
            } else if (roleName.equals("게스트")) { // 게스트 권한
                redirectStrategy.sendRedirect(request, response, targetUrl); // 이전 페이지로 리다이렉트
            } else {
                // 기타 권한 처리 (필요 시 추가)
                redirectStrategy.sendRedirect(request, response, "/");
            }
        }
        // 로그인 버튼을 눌러서 로그인한 경우 기존에 있던 페이지로 리다이렉트
        else {
            String prevPage = (String) request.getSession().getAttribute("prevPage");
            log.info("prevPage = {}", prevPage);
            if (prevPage != null) {
                redirectStrategy.sendRedirect(request, response, prevPage);
            } else if(roleName.equals("호스트")) {
                redirectStrategy.sendRedirect(request, response, "/host/hostPage");
            } else {
                redirectStrategy.sendRedirect(request, response, "/");
            }
        }
    }

}