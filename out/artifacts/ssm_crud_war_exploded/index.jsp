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

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">员工添加</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="empName" id="empName_add_input"
                                   placeholder="张三">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="email" id="empEmail_add_input"
                                   placeholder="email@163.com">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="empGender_add_radio_M" value="M"
                                       checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="empGender_add_radio_F" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-10">
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h3>SSM-CRUD</h3>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
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

        function to_page(pn) {
            $.ajax({
                url: "emps",
                data: "pn=" + pn,
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
            if (result.extend.pageInfo.hasPreviousPage == false) {
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            } else {
                firstPageLi.click(function () {
                    to_page(1);
                });
                prePageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum - 1);
                });
            }


            var nextPageLi = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append("&raquo;"));
            var lastPageLi = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append("末页").attr("href", "#"));
            if (result.extend.pageInfo.hasNextPage == false) {
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            } else {
                nextPageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum + 1);
                });
                lastPageLi.click(function () {
                    to_page(result.extend.pageInfo.pages);
                });
            }

            ul.append(firstPageLi).append(prePageLi);
            $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {

                var numLi = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append(item));
                if (result.extend.pageInfo.pageNum == item) {
                    numLi.addClass("active");
                }
                numLi.click(function () {
                    to_page(item);
                });
                ul.append(numLi);
            });
            ul.append(nextPageLi).append(lastPageLi);

            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }

        // 点击新增按钮弹出模态窗
        $("#emp_add_modal_btn").click(function () {
            // 发送ajax请求 查出部门信息 显示在下拉列表
            getDepts();

            $("#empAddModal").modal({
                backdrop: "static"
            })
        });

        // 查出所有部门信息
        function getDepts() {
            $.ajax({
                url: "depts",
                type: "GET",
                success: function (result) {
                    console.log(result)
                    // $("#empAddModal select").append("")
                    $.each(result.extend.departments, function () {
                        var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                        optionEle.appendTo("#empAddModal select");
                    });
                }
            });
        }

        $("#emp_save_btn").click(function () {
            // 1. 将模态框中填写的数据提交给服务器进行保存
            $.ajax({
                url: "emp",
                type: "POST",
                data: $("#empAddModal form").serialize(),
                success: function (result) {
                    // alert(result.msg);
                    // 1. 关闭模态框
                    $("#empAddModal").modal('hide');
                    // 2. 来到最后一页 显示刚才保存的数据
                    // 发送ajax请求显示最后一页
                    to_page($("#pages").text() + 1);
                    alert(result.msg);
                }
            });
        });

    </script>
</div>

</body>
</html>
