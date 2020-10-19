package com.peixiao.test;

import com.peixiao.bean.Department;
import com.peixiao.bean.Employee;
import com.peixiao.dao.DepartmentMapper;
import com.peixiao.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Random;
import java.util.UUID;

/**
 * @author Peixiao Zhao
 * @date 2020/10/19 21:20
 * 测试DAO
 * 引入SpringTest
 */
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;
    /**
     * 测试 DEPT MAPPER
     */
    @Test
    public void testCRUD(){
        System.out.println(departmentMapper);
        System.out.println(employeeMapper);
//        departmentMapper.insertSelective(new Department(null, "开发部"));
//        departmentMapper.insertSelective(new Department(null, "测试部"));

//        employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "jerry@mail.com", 1));

        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i ++){
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            String email = uid + "@mail.com";
            String gender = Math.random() > 0.5 ? "M" : "F";
            mapper.insertSelective(new Employee(null, uid, gender, email, 1));
        }
        System.out.println("Success!");

    }
}
