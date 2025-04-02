<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:url value="/resources/static/css/theme.css" />" rel="stylesheet">
    <title>Welcome</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: var(--bg-gradient);
            margin: 0;
            min-height: 100vh;
        }

        .navbar {
            background-color: var(--navbar-bg);
            border-bottom: 2px solid var(--border-color);
            box-shadow: 0 2px 10px var(--shadow-color);
        }

        .navbar-brand {
            font-weight: bold;
            color: var(--brand-color) !important;
        }

        .navbar-nav > li > a {
            font-weight: 600;
            transition: all 0.3s ease;
            color: var(--nav-link-color);
        }

        .navbar-nav > li.active > a {
            background-color: var(--active-nav-bg) !important;
            color: var(--active-nav-color) !important;
        }

        .content-container {
            display: flex;
            justify-content: center;
            align-items: center;
            padding-top: 100px;
            padding-bottom: 30px;
        }

        .welcome-container {
            background: var(--container-bg);
            padding: 50px;
            border-radius: 15px;
            box-shadow: 0 15px 35px var(--shadow-color);
            width: 650px;
            text-align: center;
            position: relative;
        }

        .welcome-container::before {
            content: '';
            position: absolute;
            top: -10px;
            left: -10px;
            right: -10px;
            bottom: -10px;
            background: var(--container-decoration);
            z-index: -1;
            opacity: 0.3;
            border-radius: 20px;
        }

        .welcome-title {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 20px;
            color: var(--header-color);
        }

        .welcome-message {
            font-size: 18px;
            color: var(--text-color);
            margin-bottom: 30px;
        }

        .btn-primary {
            background: var(--btn-gradient);
            border: none;
            padding: 12px 30px;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 14px var(--btn-shadow);
            background: var(--btn-hover-gradient);
        }

        .footer {
            text-align: center;
            color: var(--footer-color);
            margin-top: 40px;
            font-size: 14px;
            padding: 20px;
        }
    </style>
</head>
<body>
<%@ include file="common/header.jspf"%>
<%@ include file="common/navigation.jspf"%>
<%@ include file="common/theme-toggle.jspf"%>

    <div class="content-container">
        <div class="welcome-container">
            <h1 class="welcome-title">Welcome to Todo Manager</h1>

            <c:choose>
                <c:when test="${not empty sessionScope.name}">
                    <p class="welcome-message">Hello, ${sessionScope.name}! Ready to manage your tasks?</p>
                    <a href="/list-todos" class="btn btn-primary">View My Todos</a>
                </c:when>
                <c:otherwise>
                    <p class="welcome-message">Go to your list to do</p>
                    <a href="/list-todos" class="btn btn-primary">Get Started</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script src="webjars/jquery/1.9.1/jquery.min.js"></script>
    <script src="webjars/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script src="<c:url value="/resources/static/js/theme.js" />"></script>
</body>
</html>