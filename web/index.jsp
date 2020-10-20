<%--
  Created by IntelliJ IDEA.
  User: 42077
  Date: 2020/10/21
  Time: 0:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>

    <script src="static/jquery/js/jquery-3.5.1.min.js"></script>
    <script src="static/bootstrap-4.5.3-dist/js/bootstrap.min.js"></script>
    <link href="static/bootstrap-4.5.3-dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h3>SSM-CRUD</h3>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <td>#</td>
                    <td>empName</td>
                    <td>gender</td>
                    <td>email</td>
                    <td>deptName</td>
                    <td>操作</td>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <div class="row">

<%--        分页文字信息--%>
        <div class="col-md-6" id="page_info_area">
            当前第<code id="pageNum">1</code>页,总共<code id="pages">1</code>页,总共<code id="total">1</code>条记录
        </div>

<%--       分页条信息--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
    <script type="text/javascript">
        // 1. 页面加载完成之后 直接发送一个ajax请求 要到分页数据
        $(function () {
            to_page(1);
        });

        function to_page(pn){
            $.ajax({
                url: "emps",
                data: "pn="+pn,
                type: "get",
                success: function (result) {
                    // console.log(result)
                    //解析显示员工列表
                    build_emps_table(result)
                    //解析显示分页条
                    build_page_nav(result)
                    //解析显示分页信息
                    build_page_info(result)
                }
            });
        }

        function build_emps_table(result) {
            // 清空table表格
            $("#emps_table tbody").empty();
            var emps = result.extend.pageInfo.list;
            $.each(emps, function (index, item) {
                var empId = $("<td></td>").append(item.empId);
                var empName = $("<td></td>").append(item.empName);
                var gender = $("<td></td>").append(item.gender == "M" ? "男" : "女");
                var email = $("<td></td>").append(item.email);
                var deptName = $("<td></td>").append(item.department.deptName);
                var btnTd = $("<td></td>").append(
                    $("<button></button>").append(
                        $("<span></span>").addClass("glyphicon glyphicon-pencil"),
                        "编辑"
                    ).addClass("btn btn-primary btn-sm edit_btn").attr("edit-id", item.empId),
                    " ",
                    $("<button></button>").append(
                        $("<span></span>").addClass("glyphicon glyphicon-trash"),
                        "删除"
                    ).addClass("btn btn-danger btn-sm delete_btn").attr("edit-id", item.empId)
                )
                $("<tr></tr>")
                    .append(empId)
                    .append(empName)
                    .append(gender)
                    .append(email)
                    .append(deptName)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");
            })
        }

        //解析显示分页信息
        function build_page_info(result) {
            // $("#page_info_area").empty();
            //当前页数
            $("#pageNum").text(result.extend.pageInfo.pageNum)
            //总页数
            $("#pages").text(result.extend.pageInfo.pages)
            //总记录数
            $("#total").text(result.extend.pageInfo.total)
        }

        //解析显示分页条
        function build_page_nav(result) {
            $("#page_nav_area").empty();
            var ul = $("<ul></ul>").addClass("pagination");

            var firstPageLi = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append("首页").attr("href", "#"));
            var prePageLi = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append("&laquo;"));
            if (result.extend.pageInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else {
                firstPageLi.click(function (){
                    to_page(1);
                });
                prePageLi.click(function (){
                    to_page(result.extend.pageInfo.pageNum - 1);
                });
            }


            var nextPageLi = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append("&raquo;"));
            var lastPageLi = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append("末页").attr("href", "#"));
            if (result.extend.pageInfo.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else {
                nextPageLi.click(function (){
                    to_page(result.extend.pageInfo.pageNum + 1);
                });
                lastPageLi.click(function (){
                    to_page(result.extend.pageInfo.pages);
                });
            }

            ul.append(firstPageLi).append(prePageLi);
            $.each(result.extend.pageInfo.navigatepageNums, function (index, item){

                var numLi = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append(item));
                if (result.extend.pageInfo.pageNum == item){
                    numLi.addClass("active");
                }
                numLi.click(function (){
                    to_page(item);
                });
                ul.append(numLi);
            });
            ul.append(nextPageLi).append(lastPageLi);

            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }
    </script>
</div>

</body>
</html>
