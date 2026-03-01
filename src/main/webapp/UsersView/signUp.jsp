<%@page import="Users.services.implementation.UsersImp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account | ShopProject</title>
    <style>
        :root {
            --primary: #6366f1;
            --primary-dark: #4f46e5;
            --error: #ef4444;
            --success: #10b981;
            --bg: #f8fafc;
        }

        body {
            margin: 0;
            min-height: 100vh;
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Inter', -apple-system, sans-serif;
        }

        .signup-card {
            background: white;
            width: 100%;
            max-width: 420px;
            padding: 2.5rem;
            border-radius: 1rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            text-align: center;
        }

        h2 { color: #1e293b; margin-bottom: 0.5rem; font-size: 1.75rem; }
        p.subtitle { color: #64748b; margin-bottom: 2rem; font-size: 0.9rem; }

        .msg-container {
            position: fixed;
            top: 20px;
            left: 20px;
            padding: 15px 25px;
            border-radius: 8px;
            color: white;
            font-weight: 600;
            z-index: 10000;
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
            animation: slideIn 0.5s ease;
        }

        .input-group { margin-bottom: 1.2rem; text-align: left; position: relative; }
        
        label { display: block; font-size: 0.85rem; font-weight: 600; color: #475569; margin-bottom: 0.4rem; }

        input {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1.5px solid #e2e8f0;
            border-radius: 0.5rem;
            font-size: 0.95rem;
            transition: all 0.2s;
            box-sizing: border-box;
        }

        input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
        }

        /* Password Toggle */
        .pass-wrapper { position: relative; }
        .toggle-btn {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            font-size: 1.1rem;
            user-select: none;
        }

        button {
            width: 100%;
            padding: 0.8rem;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 0.5rem;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.2s;
            margin-top: 1rem;
        }

        button:hover { background: var(--primary-dark); transform: translateY(-1px); }
        button:disabled { background: #cbd5e1; cursor: not-allowed; transform: none; }

        .footer-link { margin-top: 1.5rem; font-size: 0.85rem; color: #64748b; }
        .footer-link a { color: var(--primary); text-decoration: none; font-weight: 600; }
    </style>
</head>
<body>

<div class="signup-card">
    <h2>Create Account</h2>
    <p class="subtitle">Join our community today</p>

    <form id="signupForm" action="${pageContext.request.contextPath}/UserController" method="POST">
        
        <div style="display: flex; gap: 10px;">
            <div class="input-group">
                <label>First Name</label>
                <input type="text" id="firstname" name="firstname" value="${param.firstname}" placeholder="Amir" required>
            </div>
            <div class="input-group">
                <label>Last Name</label>
                <input type="text" id="lastname" name="lastname" value="${param.lastname}" placeholder="Hany" required>
            </div>
        </div>

        <div class="input-group">
            <label>Username</label>
            <input type="text" id="username" name="username" value="${param.username}" placeholder="Amir" required>
        </div>

        <div class="input-group">
            <label>Email Address</label>
            <input type="email" id="email" name="email" value="${param.email}" placeholder="amir@gmail.com" required>
        </div>

        <div class="input-group">
            <label>Password</label>
            <div class="pass-wrapper">
                <input type="password" id="password" name="password" required>
                <span class="toggle-btn" onclick="toggle('password')">👁️</span>
            </div>
        </div>

        <div class="input-group">
            <label>Confirm Password</label>
            <div class="pass-wrapper">
                <input type="password" id="confirmPassword" name="confirmPassword" required>
                <span class="toggle-btn" onclick="toggle('confirmPassword')">👁️</span>
            </div>
        </div>

        <input type="hidden" name="action" value="signup">
        <button id="submitBtn" type="submit" disabled>Register Now</button>
    </form>

    <p class="footer-link">
        Already have an account? <a href="loginUsers.jsp">Log in</a>
    </p>

    <% 
        String flashMsg = (String) session.getAttribute("flashMessage");
        String flashType = (String) session.getAttribute("flashType");
        if (flashMsg != null) { 
            String bgColor = "linear-gradient(45deg, #27ae60, #2ecc71)"; // Default Green
            String icon = "✓ ";
            if ("error".equals(flashType)) {
                bgColor = "linear-gradient(45deg, #c0392b, #e74c3c)"; // Red
                icon = "⚠ ";
            }
    %>
        <div class="msg-container" id="notif" style="background: <%= bgColor %>;">
            <%= icon %> <%= flashMsg %>
        </div>
    <% 
        session.removeAttribute("flashMessage"); 
        session.removeAttribute("flashType");
        }else { }
    %>

</div> 


<script>
    function toggle(id) {
        const input = document.getElementById(id);
        input.type = input.type === 'password' ? 'text' : 'password';
    }

    const form = document.getElementById('signupForm');
    const btn = document.getElementById('submitBtn');

    form.addEventListener('input', () => {
        const pass = document.getElementById('password').value;
        const conf = document.getElementById('confirmPassword').value;
        const email = document.getElementById('email').value;
        const user = document.getElementById('username').value;

        // Simple frontend validation to enable button
        const isValid = 
            user.length >= 3 && 
            email.includes('@') && 
            pass.length >= 6 && 
            pass === conf;

        btn.disabled = !isValid;
    });
    // Auto-hide notification
    const notif = document.getElementById('notif');
    if (notif) {
        setTimeout(() => {
            notif.style.transition = "opacity 0.5s ease";
            notif.style.opacity = "0";
            setTimeout(() => notif.remove(), 500);
        }, 4000);
    }
</script>


</body>
</html>