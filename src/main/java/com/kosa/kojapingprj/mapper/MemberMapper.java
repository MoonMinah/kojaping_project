package com.kosa.kojapingprj.mapper;

import com.kosa.kojaping.entity.Member;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {
    public int insertMember(Member member);

    public Member selectMemberByUserId(String userId);

    public void updateMember(Member member);

    public int updateMemberStatusByUserId(String userId);
}
