package com.kosa.kojapingprj.service;

import com.kosa.kojaping.entity.Member;
import org.springframework.validation.Errors;

import java.util.Map;

public interface MemberService {
    public int insertMember(Member member);

    public Map<String, String> validateHandling(Errors errors);

    public Member selectMemberByUserId(String userId);

    public void updateMember(Member member);

    public int updateMemberStatusByUserId(String userId);
}
