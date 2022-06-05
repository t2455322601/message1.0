<%--
  Created by IntelliJ IDEA.
  User: Liuyoo
  Date: 2021/6/22
  Time: 23:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="DAO.UserDAO" %>
<%@ page import="DAO.UserInfoDAO" %>
<%@ page import="Bean.Suggest" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DAO.SuggestDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="./img/favicon.html">

    <title>建议栏</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap-reset.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/font-awesome.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <%--    <link href="${pageContext.request.contextPath}/css/style-responsive.css" rel="stylesheet" />--%>
    <style type="text/css">
        .comment {
            float: left;
            width: 600px;
            padding: 5px;
            margin: 20px auto 0 auto;
        }
        .comment-content {
            float: left;
            margin: 0 0 0 40px;
            width: 400px;
        }
        .comment-content > span {
            line-height: 150%;
            color: #444;
            background: #f5f5f5;
            display: block;
            width: 100%;
            padding: 10px 15px 10px 15px;
            font-size: 0.9em;
            display: block;
            position: relative;
            border-radius: 3px;
            box-shadow: 1px 1px 3px rgba(0, 0, 0, .3);
        }
        .comment-content > span:before {
            content: '';
            position: absolute;
            top: 28px;
            left: -28px;
            display: block;
            width: 0;
            height: 0;
            border: 1em solid #f5f5f5;
            border-color: transparent #f5f5f5 transparent transparent;
        }
        .comment p {
            font-family: 'Open Sans';
            text-shadow: 1px 1px 2px #fff;
        }
        .comment strong {
            font-weight: 700;
        }
        .comment .author {
            font-weight: 300;
            font-size: 0.8em;
        }



    </style>

</head>
<body>

<jsp:useBean id="user" class="Bean.User"/>
<jsp:useBean id="userInfo" class="Bean.UserInfo"/>

<%
    //获取当前登录用户
    int UserID = (int) session.getAttribute("UserID");
    UserDAO userDAO = new UserDAO();
    user = userDAO.getUserIn(UserID);
    UserInfoDAO userInfoDAO = new UserInfoDAO();
    userInfo = userInfoDAO.getUserInfo(UserID);
%>
<section id="container">
    <header class="header white-bg">
        <div class="sidebar-toggle-box">
            <div data-original-title="点击隐藏" data-placement="right" class="icon-reorder tooltips"></div>
        </div>
        <a href="${pageContext.request.contextPath}/User/UserMain.jsp" class="logo">图书馆<span>管理系统</span></a>
        <div class="top-nav ">
            <ul class="nav pull-right top-menu">
                <li class="dropdown">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                        <span class="username"><%= userInfo.getName()%></span>
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu extended logout">
                        <div class="log-arrow-up"></div>
                        <li><a href="${pageContext.request.contextPath}/User/User_UpdateInfo.jsp"><i class=" icon-suitcase"></i>修改个人资料</a></li>
                        <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
                        <li><a href="${pageContext.request.contextPath}/User/User_UpdatePassword.jsp"><i class="icon-cog"></i> 修改密码</a></li>
                        <li><a href="javascript:void(0);" onclick="ExitLogin()"><i class="icon-key"></i>退出登录</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </header>

    <script type="text/javascript">
        function ExitLogin()
        {
            var con=confirm("是否退出?");
            if(con==true){
                location.href = "../exit";
            }
        }
    </script>

    <aside>
        <div id="sidebar"  class="nav-collapse ">
            <ul class="sidebar-menu">
                <li class="active">
                    <a  href="${pageContext.request.contextPath}/User/UserMain.jsp">
                        <span>首页</span>
                    </a>
                </li>
                <li class="sub-menu">
                    <a href="${pageContext.request.contextPath}/User/User_SelectBook.jsp">
                        <span>图书查询</span>
                        <span class="arrow"></span>
                    </a>
                </li>
                <li class="sub-menu">
                    <a href="${pageContext.request.contextPath}/User/User_BorrowInfo.jsp">
                        <span>借阅信息</span>
                        <span class="arrow"></span>
                    </a>
                </li>
                <li class="sub-menu">
                    <a href="${pageContext.request.contextPath}/User/User_History.jsp">
                        <span>借阅历史</span>
                        <span class="arrow"></span>
                    </a>
                </li>
                <li class="sub-menu">
                    <a href="${pageContext.request.contextPath}/User/User_SetMessage.jsp">
                        <span>留言板</span>
                        <span class="arrow"></span>
                    </a>
                </li>
            </ul>
        </div>
    </aside>
    <section id="main-content">
        <section class="wrapper">
            <div class="alert alert-info">
               留言板
            </div>

            <div class="comment">
                <%
                    ArrayList<Suggest> suggests = new ArrayList<>();

                    SuggestDAO suggestDAO = new SuggestDAO();

                    suggests = suggestDAO.getBookLsit();

                    for(Suggest bean:suggests)
                    {
                %>
                <div class="comment-content">
                    <p class="author"><strong><%= bean.getName()%></strong> &nbsp; &nbsp;&nbsp; &nbsp; <%= bean.getTime()%>
                    <% if(bean.getUserID() == UserID ) { %>
                        &nbsp; &nbsp; &nbsp;&nbsp;<a href="#" onclick="DeleteSuggest(<%= bean.getSID()%>)">删除</a>
                        <% } %>
                    </p>
                    <span><%=bean.getContent()%></span>
                </div>
                <div class="comment-content">
                    &nbsp;
                </div>

                    <%
                        }
                    %>

                <div class="col-md-8">
                    <div class="panel-default">
                        <div class="panel-body">
                            <form  action="${pageContext.request.contextPath}/addsuggest">
                                <textarea rows="6" cols="55" name="Suggest"  placeholder="请输入您的建议 :" ></textarea>
                                <input type="submit" class="btn btn-primary" value="提 交">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </section>
</section>

<script type="text/javascript">
    function DeleteSuggest(SID) {
        var con=confirm("是否删除该条建议?");
        if(con==true){
            location.href = "../deletesuggest?SID="+SID;
        }
    }
</script>

<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/common-scripts.js"></script>
</body>
</html>
