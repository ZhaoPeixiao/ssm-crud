package com.peixiao.service;

import com.peixiao.bean.Employee;
import com.peixiao.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Peixiao Zhao
 * @date 2020/10/20 15:18
 */
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     * @return list
     */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 员工保存
     * @param employee 员工
     */
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }


}
