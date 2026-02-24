<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Connection Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7f6;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .error-container {
            text-align: center;
            padding: 50px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        h1 { color: #e74c3c; }
        p { color: #555; }
        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background 0.3s;
        }
        .btn:hover { background-color: #2980b9; }
    </style>
</head>
<body>

    <div class="error-container">
        <h1>Oops! Something went sideways.</h1>
        <p>We're having a bit of trouble connecting to the server. Please try again in a moment.</p>
        
        <a class="btn" href="${pageContext.request.contextPath}/UsersView/loginUsers.jsp">
            Return to Login
        </a>
    </div>

</body>
</html>

</web-app>