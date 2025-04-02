<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
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
            padding-top: 80px;
            padding-bottom: 30px;
        }

        .form-container {
            background: white;
            padding: 50px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            width: 450px;
            text-align: center;
            position: relative;
            transform: scale(1.05);
            transition: all 0.3s ease;
        }

        .form-container::before {
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

        .login100-form-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 30px;
            color: #333;
            letter-spacing: -0.5px;
        }

        .form-input {
            width: 100%;
            height: 50px;
            font-size: 16px;
            padding: 15px;
            border-radius: 8px;
            border: 2px solid #e1e1e1;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }

        .form-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.2);
        }

        .btn-large {
            width: 100%;
            height: 55px;
            font-size: 18px;
            font-weight: bold;
            color: white;
            background: linear-gradient(to right, #667eea, #764ba2);
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            letter-spacing: 1px;
        }

        .btn-large:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 14px rgba(50, 50, 93, 0.1), 0 3px 6px rgba(0, 0, 0, 0.08);
        }

        .forgot-password {
            display: block;
            margin-top: 20px;
            color: #667eea;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s ease;
        }

        .forgot-password:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 20px;
            background: #ffebeb;
            padding: 10px;
            border-radius: 5px;
            display: none; /* Ẩn thông báo lỗi ban đầu */
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
        <div class="form-container">
            <% String error = (String) request.getAttribute("errorMessage"); %>
            <% if (error != null) { %>
                <div class="error-message" id="error-box">
                    <p><%= error %></p>
                </div>
            <% } %>

            <form action="login" method="POST">
                <span class="login100-form-title">Member Login</span>

                <input class="form-input" type="text" name="name" placeholder="Username" required>
                <input class="form-input" type="password" name="password" placeholder="Password" required>

                <button class="btn-large" type="submit">Login</button>

                <a href="/tim-tai-khoan" class="forgot-password">Forgot Password?</a>
            </form>

            <script>
                // Nếu có lỗi, hiển thị thông báo lỗi
                window.onload = function() {
                    var errorBox = document.getElementById("error-box");
                    if (errorBox) {
                        errorBox.style.display = "block";
                    }
                };
            </script>
        </div>
    </div>

<%@ include file="common/footer.jspf"%>
</body>
</html>