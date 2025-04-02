<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Todo Application</title>
    <link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:url value="/resources/static/css/theme.css" />" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, var(--bg-gradient-start) 0%, var(--bg-gradient-end) 100%);
            margin: 0;
            min-height: 100vh;
            overflow-x: hidden;
        }

        .navbar-brand {
            font-weight: 700;
            color: var(--link-color) !important;
            letter-spacing: -0.5px;
        }

        .navbar-nav > li > a {
            font-weight: 500;
            transition: all 0.3s ease;
            color: var(--text-color) !important;
        }

        .navbar-nav > li.active > a {
            background-color: var(--navbar-active-bg) !important;
            color: white !important;
        }

        .login-page {
            display: flex;
            min-height: calc(100vh - 80px);
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        .login-container {
            display: flex;
            max-width: 1000px;
            width: 100%;
            background: var(--card-bg);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0,0,0,0.1);
            position: relative;
        }

        .login-image {
            width: 50%;
            background: linear-gradient(to right, #7e57ff, #6a4cbf);
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            padding: 40px;
        }

        .login-image::before {
            content: '';
            position: absolute;
            width: 140%;
            height: 140%;
            background: url('https://images.unsplash.com/photo-1586473219010-2ffc57b0d282?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1350&q=80') center/cover;
            opacity: 0.2;
        }

        .login-welcome {
            color: white;
            position: relative;
            z-index: 2;
            text-align: center;
            max-width: 80%;
        }

        .login-welcome h2 {
            font-size: 42px;
            font-weight: 700;
            margin-bottom: 20px;
            letter-spacing: -1px;
        }

        .login-welcome p {
            font-size: 18px;
            line-height: 1.6;
            font-weight: 300;
            margin-bottom: 30px;
        }

        .login-form {
            width: 50%;
            padding: 60px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-header {
            margin-bottom: 40px;
            text-align: center;
        }

        .login-header h3 {
            font-size: 32px;
            font-weight: 700;
            color: var(--text-color);
            margin-bottom: 10px;
            letter-spacing: -0.5px;
        }

        .login-header p {
            color: var(--text-secondary);
            font-size: 16px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-control {
            height: 55px;
            font-size: 16px;
            padding: 10px 20px;
            border-radius: 12px;
            border: 2px solid var(--input-border);
            background-color: var(--card-bg);
            color: var(--text-color);
            transition: all 0.3s;
            width: 100%;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--link-color);
            box-shadow: 0 0 0 4px rgba(126, 87, 255, 0.1);
        }

        .form-label {
            position: absolute;
            top: -10px;
            left: 15px;
            background: var(--card-bg);
            padding: 0 10px;
            font-size: 14px;
            color: var(--text-secondary);
            font-weight: 500;
        }

        .login-btn {
            height: 55px;
            border: none;
            border-radius: 12px;
            background: linear-gradient(to right, #7e57ff, #6a4cbf);
            color: white;
            font-weight: 600;
            font-size: 18px;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
            margin-top: 15px;
            letter-spacing: 0.5px;
            position: relative;
            overflow: hidden;
        }

        .login-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: all 0.6s;
        }

        .login-btn:hover::before {
            left: 100%;
        }

        .login-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(106, 76, 191, 0.3);
        }

        .login-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 25px;
        }

        .remember-me {
            display: flex;
            align-items: center;
        }

        .remember-me input {
            margin-right: 8px;
        }

        .forgot-password {
            color: var(--link-color);
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.3s;
        }

        .forgot-password:hover {
            color: var(--link-hover-color);
            text-decoration: underline;
        }

        .error-message {
            background-color: rgba(255, 0, 0, 0.1);
            border-left: 4px solid #ff3b30;
            color: #ff3b30;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            font-size: 14px;
            display: none;
        }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .login-container {
                flex-direction: column;
                max-width: 500px;
            }
            
            .login-image, .login-form {
                width: 100%;
            }
            
            .login-image {
                min-height: 250px;
                padding: 30px;
            }
            
            .login-welcome h2 {
                font-size: 32px;
            }
            
            .login-form {
                padding: 40px 30px;
            }
        }

        /* Floating labels animation */
        .form-group {
            position: relative;
        }

        .animated-label {
            position: absolute;
            left: 15px;
            top: 17px;
            font-size: 16px;
            color: var(--text-secondary);
            transition: all 0.2s;
            pointer-events: none;
        }

        .form-control:focus ~ .animated-label,
        .form-control:not(:placeholder-shown) ~ .animated-label {
            top: -10px;
            left: 15px;
            font-size: 14px;
            color: var(--link-color);
            background-color: var(--card-bg);
            padding: 0 5px;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .login-container {
            animation: fadeIn 0.8s ease-out;
        }
    </style>
</head>
<body>

<%@ include file="common/header.jspf"%>
<%@ include file="common/navigation.jspf"%>
<%@ include file="common/theme-toggle.jspf"%>

<div class="login-page">
    <div class="login-container">
        <div class="login-image">
            <div class="login-welcome">
                <h2>Welcome Back!</h2>
                <p>Log in to access your personalized todo list and start managing your tasks efficiently.</p>
            </div>
        </div>
        
        <div class="login-form">
            <div class="login-header">
                <h3>Sign In</h3>
                <p>Enter your credentials to access your account</p>
            </div>
            
            <% String error = (String) request.getAttribute("errorMessage"); %>
            <% if (error != null) { %>
                <div class="error-message" id="error-box">
                    <p><%= error %></p>
                </div>
            <% } %>
            
            <form action="login.do" method="POST">
                <div class="form-group">
                    <input type="text" class="form-control" name="name" id="username" placeholder=" " required>
                    <label for="username" class="animated-label">Username</label>
                </div>
                
                <div class="form-group">
                    <input type="password" class="form-control" name="password" id="password" placeholder=" " required>
                    <label for="password" class="animated-label">Password</label>
                </div>
                
                <div class="login-footer">
                    <div class="remember-me">
                        <input type="checkbox" id="remember" name="remember">
                        <label for="remember">Remember me</label>
                    </div>
                    <a href="/tim-tai-khoan" class="forgot-password">Forgot Password?</a>
                </div>
                
                <button type="submit" class="login-btn">Sign In</button>
            </form>
        </div>
    </div>
</div>

<script src="webjars/jquery/1.9.1/jquery.min.js"></script>
<script src="webjars/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="<c:url value="/resources/static/js/theme.js" />"></script>
<script>
    // If there's an error, show the error message
    window.onload = function() {
        var errorBox = document.getElementById("error-box");
        if (errorBox) {
            errorBox.style.display = "block";
        }
    };
</script>
</body>
</html>