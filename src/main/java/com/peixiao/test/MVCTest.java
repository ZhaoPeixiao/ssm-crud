package com.peixiao.test;

import com.github.pagehelper.PageInfo;
import com.peixiao.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @author Peixiao Zhao
 * @date 2020/10/20 15:31
 * 使用Spring测试模块测试请求功能
 */
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "file:web/WEB-INF/dispatcherServlet-servlet.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
public class MVCTest {

    @Autowired
    WebApplicationContext context;

    // 虚拟mvc请求 获取处理结果
    MockMvc mockMvc;

    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        // 模拟请求 拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5")).andReturn();
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码: " + pageInfo.getPageNum());
        System.out.println("总页码: " + pageInfo.getPages());
        System.out.println("总记录数: " + pageInfo.getTotal());
        for (int i : pageInfo.getNavigatepageNums()){
            System.out.print(" " + i);
        }
        System.out.println();
        List<Employee> list = pageInfo.getList();
        for (Employee employee : list){
            System.out.println(employee.toString());
        }
    }
}
