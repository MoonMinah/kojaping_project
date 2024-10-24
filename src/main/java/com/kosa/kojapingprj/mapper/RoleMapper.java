package com.kosa.kojapingprj.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RoleMapper {
    public String selectRoleNameByRoleNo(Long roleNo);

}
