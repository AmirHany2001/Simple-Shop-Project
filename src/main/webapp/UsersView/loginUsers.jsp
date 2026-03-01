<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
        .pass-wrapper {
		    position: relative;
		    display: flex;
		    align-items: center;
		}
		
		.pass-wrapper input {
		    width: 100%;
		    padding-right: 40px; /* Leave space so text doesn't go under the icon */
		    padding-top: 10px;
		    padding-bottom: 10px;
		}
		
		.toggle-btn {
		    position: absolute;
		    right: 10px;
		    cursor: pointer;
		    user-select: none; /* Prevents highlighting the emoji on click */
		}
    </style>
</head>
<body>
    <div class="card">
        <h2>Login</h2>

        <form action="${pageContext.request.contextPath}/UserController" method="POST">
            <div class="form-group">
                <input type="text" name="username" placeholder="Username" required>
            </div>
            <div class="form-group">
                <div class="pass-wrapper">
                	<input type="password" name="password" id="password" placeholder="Password" required>
                	<span class="toggle-btn" onclick="toggle('password')">👁️</span>
            	</div>
            </div>
            <input type="hidden" name="action" value="login">
            <button type="submit">Sign In</button>
        </form>
        
        <p style="text-align:center; font-size: 0.875rem; margin-top: 1rem;">
            New here? <a href="${pageContext.request.contextPath}/UsersView/signUp.jsp" style="color: var(--primary);">Create an account</a>
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