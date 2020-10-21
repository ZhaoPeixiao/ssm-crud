package com.peixiao.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.peixiao.bean.Employee;
import com.peixiao.bean.Msg;
import com.peixiao.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author Peixiao Zhao
 * @date 2020/10/20 15:16
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 查询员工数据(分页查询)
     *
     * @return jsp
     */
//    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        // 这不是分页查询
        // 引入PageHelper
        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeService.getAll();
        PageInfo page = new PageInfo(emps, 5);
        model.addAttribute("pageInfo", page);

        return "list";
    }

    /**
     * 导入jackson包
     *
     * @param pn
     * @return
     */
    @ResponseBody
    @RequestMapping("/emps")
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5);
        List<Employee> employees = employeeService.getAll();
        PageInfo pageInfo = new PageInfo(employees, 5);
        List<Employee> employeesResult = pageInfo.getList();

        return Msg.success().add("pageInfo", pageInfo);
    }


    @PostMapping("/emp")
    @ResponseBody
    public Msg saveEmp(Employee employee){
        employeeService.saveEmp(employee);
        return Msg.success();
    }

}
