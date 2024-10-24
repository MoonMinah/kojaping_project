package com.kosa.kojapingprj.service.serviceImpl;

import com.kosa.kojaping.mapper.RoleMapper;
import com.kosa.kojaping.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleMapper roleMapper;

    @Override
    public String selectRoleNameByRoleNo(Long roleNo) {
        return roleMapper.selectRoleNameByRoleNo(roleNo);
    }
}
