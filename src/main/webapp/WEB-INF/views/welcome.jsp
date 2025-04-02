<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
    <title>Welcome</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            min-height: 100vh;
        }

        .navbar {
            background-color: rgba(255, 255, 255, 0.9);
            border-bottom: 2px solid rgba(0, 0, 0, 0.1);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-weight: bold;
            color: #667eea !important;
        }

        .navbar-nav > li > a {
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .navbar-nav > li.active > a {
            background-color: #667eea !important;
            color: white !important;
        }

        .content-container {
            display: flex;
            justify-content: center;
            align-items: center;
            padding-top: 100px;
            padding-bottom: 30px;
        }

        .welcome-container {
            background: white;
            padding: 50px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
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
            background: linear-gradient(45deg, #ff6b6b, #4ecdc4);
            z-index: -1;
            opacity: 0.3;
            border-radius: 20px;
        }

        .welcome-title {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 20px;
            color: #333;
        }

        .welcome-message {
            font-size: 18px;
            color: #555;
            margin-bottom: 30px;
        }

        .btn-primary {
            background: linear-gradient(to right, #667eea, #764ba2);
            border: none;
            padding: 12px 30px;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 14px rgba(50, 50, 93, 0.1), 0 3px 6px rgba(0, 0, 0, 0.08);
            background: linear-gradient(to right, #764ba2, #667eea);
        }

        .footer {
            text-align: center;
            color: white;
            margin-top: 40px;
            font-size: 14px;
            padding: 20px;
        }
    </style>
</head>
<body>
<%@ include file="common/header.jspf"%>
<%@ include file="common/navigation.jspf"%>

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

    <!-- Footer Fragment -->
<%@ include file="common/footer.jspf"%>
</body>
</html>