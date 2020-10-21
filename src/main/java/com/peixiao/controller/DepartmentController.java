package com.peixiao.controller;

import com.peixiao.bean.Department;
import com.peixiao.bean.Msg;
import com.peixiao.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author Peixiao Zhao
 * @date 2020/10/21 17:24
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    /**
     * 返回所有部门信息
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Department> departments = departmentService.getDepts();
        return Msg.success().add("departments", departments);
    }
}
