<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome Back | ShopProject</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4f46e5;
            --primary-hover: #4338ca;
            --bg: #f3f4f6;
            --text: #1f2937;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg);
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        .card {
            background: white;
            padding: 2.5rem;
            border-radius: 1rem;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        h2 { color: var(--text); margin-bottom: 1.5rem; text-align: center; }

        .form-group { margin-bottom: 1rem; position: relative; }

        input {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid #d1d5db;
            border-radius: 0.5rem;
            transition: border-color 0.2s;
            box-sizing: border-box;
        }

        input:focus {
            outline: none;
            border-color: var(--primary);
            ring: 2px var(--primary);
        }

        button {
            width: 100%;
            background: var(--primary);
            color: white;
            padding: 0.75rem;
            border: none;
            border-radius: 0.5rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }

        button:hover { background: var(--primary-hover); }

        .flash {
            padding: 0.75rem;
            border-radius: 0.5rem;
            margin-bottom: 1rem;
            font-size: 0.875rem;
            text-align: center;
        }
        .error { background: #fee2e2; color: #991b1b; }
        .success { background: #dcfce7; color: #166534; }
    </style>
</head>
<body>
    <div class="card">
        <h2>Login</h2>

        <c:if test="${not empty sessionScope.flashMessage}">
            <div class="flash ${sessionScope.flashType}">${sessionScope.flashMessage}</div>
            <c:remove var="flashMessage" scope="session"/>
        </c:if>

        <form action="${pageContext.request.contextPath}/UserController" method="POST">
            <div class="form-group">
                <input type="text" name="username" placeholder="Username" required>
            </div>
            <div class="form-group">
                <input type="password" name="password" id="password" placeholder="Password" required>
            </div>
            <input type="hidden" name="action" value="login">
            <button type="submit">Sign In</button>
        </form>
        
        <p style="text-align:center; font-size: 0.875rem; margin-top: 1rem;">
            New here? <a href="${pageContext.request.contextPath}/UsersView/signUp.jsp" style="color: var(--primary);">Create an account</a>
        </p>
    </div>
</body>
</html>