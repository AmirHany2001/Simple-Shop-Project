<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Password | ShopProject</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
    <style>
        /* Modernized Styles */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }

        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px;
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
        }

        .container {
            max-width: 500px; /* Slimmer for better focus */
            width: 100%;
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(10px);
            position: relative;
            animation: fadeInUp 0.6s ease-out;
        }

        .text {
            font-size: 2.2rem;
            font-weight: 700;
            text-align: center;
            background: linear-gradient(45deg, #71b7e6, #9b59b6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 30px;
        }

        /* Flash Message Styling */
        .message-banner {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 0.9rem;
            font-weight: 600;
            animation: fadeInUp 0.4s ease;
        }
        .message-banner.success { background: #dcfce7; color: #15803d; border: 1px solid #bbf7d0; }
        .message-banner.error { background: #fee2e2; color: #b91c1c; border: 1px solid #fecaca; }

        .form-row { margin-bottom: 30px; }

        .input-data {
            width: 100%;
            height: 50px;
            position: relative;
            margin-bottom: 25px;
        }

        .input-data input {
            display: block;
            width: 100%;
            height: 100%;
            border: none;
            font-size: 1rem;
            background: transparent;
            border-bottom: 2px solid rgba(0, 0, 0, 0.12);
            transition: all 0.3s ease;
            padding-top: 10px;
        }

        .input-data label {
            position: absolute;
            bottom: 10px;
            left: 0;
            color: #666;
            pointer-events: none;
            transition: all 0.3s ease;
        }

        .input-data input:focus ~ label,
        .input-data input:valid ~ label {
            transform: translateY(-25px);
            font-size: 0.85rem;
            color: #3498db;
        }

        .underline {
            position: absolute;
            bottom: 0;
            height: 2px;
            width: 100%;
            background: rgba(0, 0, 0, 0.1);
        }

        .underline:before {
            content: "";
            position: absolute;
            height: 100%;
            width: 100%;
            background: linear-gradient(90deg, #71b7e6, #9b59b6);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .input-data input:focus ~ .underline:before { transform: scaleX(1); }

        .toggle-password {
            position: absolute;
            right: 10px;
            top: 50%;
            cursor: pointer;
            z-index: 2;
        }

        .button {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 50px;
            background: linear-gradient(45deg, #71b7e6, #9b59b6);
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            cursor: pointer;
            transition: 0.3s;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .button:hover { transform: translateY(-2px); box-shadow: 0 15px 25px rgba(0,0,0,0.2); }

        .back-link { text-align: center; margin-top: 20px; }
        .back-link a { color: #666; text-decoration: none; font-size: 0.9rem; }
        .back-link a:hover { color: #3498db; }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="text">Update Password</div>

    <c:if test="${not empty sessionScope.flashMessage}">
        <div class="message-banner ${sessionScope.flashType}">
            ${sessionScope.flashMessage}
        </div>
        <c:remove var="flashMessage" scope="session"/>
        <c:remove var="flashType" scope="session"/>
    </c:if>

    <form action="${pageContext.request.contextPath}/UserController" method="POST">
        <input type="hidden" name="action" value="changePassword">

        <div class="input-data">
            <input type="password" id="oldPass" name="password" required>
            <label for="oldPass">Current Password</label>
            <span class="toggle-password" onclick="toggle('oldPass')">👀</span>
            <div class="underline"></div>
        </div>

        <div class="input-data">
            <input type="password" id="newPass" name="newPassword" required>
            <label for="newPass">New Password</label>
            <span class="toggle-password" onclick="toggle('newPass')">👀</span>
            <div class="underline"></div>
        </div>

        <div class="input-data">
            <input type="password" id="confirmPass" name="confirmPassword" required>
            <label for="confirmPass">Confirm New Password</label>
            <span class="toggle-password" onclick="toggle('confirmPass')">👀</span>
            <div class="underline"></div>
        </div>

        <input type="submit" value="Change Password" class="button">
    </form>

    <div class="back-link">
        <a href="${pageContext.request.contextPath}/ItemsController">← Back to Items</a>
    </div>
</div>

<script>
    function toggle(id) {
        const input = document.getElementById(id);
        input.type = input.type === 'password' ? 'text' : 'password';
    }
</script>

</body>
</html>






