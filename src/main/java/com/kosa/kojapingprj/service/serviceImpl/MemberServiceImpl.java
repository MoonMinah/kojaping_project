package com.kosa.kojapingprj.service.serviceImpl;

import com.kosa.kojaping.entity.Member;
import com.kosa.kojaping.mapper.MemberMapper;
import com.kosa.kojaping.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;

import java.util.HashMap;
import java.util.Map;

@Service
public class MemberServiceImpl implements MemberService {
    @Autowired
    private MemberMapper memberMapper;

    @Override
    public int insertMember(Member member) {
        return memberMapper.insertMember(member);
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, String> validateHandling(Errors errors) {
        Map<String, String> validatorResult = new HashMap<>();

        for (FieldError error : errors.getFieldErrors()) {
            if(error.getField().equals("createdAt")) {
                continue;
            }

            String validKeyName = String.format("valid_%s", error.getField());
            validatorResult.put(validKeyName, error.getDefaultMessage());
        }

        return validatorResult;
    }

    @Override
    public Member selectMemberByUserId(String userId) {
        return memberMapper.selectMemberByUserId(userId);
    }

    @Override
    public void updateMember(Member member) {
        memberMapper.updateMember(member);
    }

    @Override
    public int updateMemberStatusByUserId(String userId) {
        return memberMapper.updateMemberStatusByUserId(userId);
    }
}
