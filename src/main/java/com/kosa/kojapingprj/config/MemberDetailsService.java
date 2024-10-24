package com.kosa.kojapingprj.config;

import com.kosa.kojaping.entity.Member;
import com.kosa.kojaping.mapper.MemberMapper;
import com.kosa.kojaping.service.RoleService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class MemberDetailsService implements UserDetailsService {
    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private RoleService roleService;

    @Override
    public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
        log.info("loadUserByUsername() : userId = {}", userId);

        Member resultMember = memberMapper.selectMemberByUserId(userId);
        log.info("selectMemberByUserId() : resultMember = {}", resultMember);

        if(resultMember != null) {
            return new MemberDetails(resultMember, roleService);
        }

        return null;
    }
}
