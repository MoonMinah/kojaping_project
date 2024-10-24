package com.kosa.kojapingprj.config;

import com.kosa.kojaping.entity.Member;
import com.kosa.kojaping.service.RoleService;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;

public class MemberDetails implements UserDetails {
    private Member member;
    private RoleService roleService;

    public MemberDetails(Member member, RoleService roleService) {
        this.member = member;
        this.roleService = roleService;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> collection = new ArrayList<>();

        collection.add(new GrantedAuthority() {
            @Override
            public String getAuthority() {
                String roleName = roleService.selectRoleNameByRoleNo((Long) member.getRoleNo());

                return roleName;
            }
        });

        return collection;
    }

    @Override
    public String getPassword() {
        return member.getPassword();
    }

    @Override
    public String getUsername() {
        return member.getUserId();
    }

    @Override
    public boolean isAccountNonExpired() {
        return UserDetails.super.isAccountNonExpired();
    }

    @Override
    public boolean isAccountNonLocked() {
        return UserDetails.super.isAccountNonLocked();
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return UserDetails.super.isCredentialsNonExpired();
    }

    @Override
    public boolean isEnabled() {
        if(member.getStatus().equals("탈퇴")){
            return false;
        }

        return UserDetails.super.isEnabled();
    }
}
