<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ADD Item</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
    <style type="text/css">
        * { margin: 0; padding: 0; outline: none; box-sizing: border-box; font-family: 'Poppins', sans-serif; }

        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px;
            /* COOL COLOR GRADIENT */
            background: linear-gradient(135deg, #0f2027 0%, #203a43 50%, #2c5364 100%);
        }

        .container {
            max-width: 700px;
            width: 100%;
            background: rgba(255, 255, 255, 0.98);
            padding: 50px;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
            position: relative;
            overflow: visible; /* Changed from hidden to prevent label clipping */
        }

        /* Top Accent */
        .container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 6px;
            background: linear-gradient(90deg, #2c5364, #00d2ff);
            border-radius: 20px 20px 0 0;
        }

        .text {
            font-size: 2.5rem;
            font-weight: 700;
            text-align: center;
            background: linear-gradient(45deg, #2c5364, #3a7bd5);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 40px;
        }

        .form-row {
            display: flex;
            margin-bottom: 35px;
            gap: 25px;
        }

        .input-data {
            width: 100%;
            height: 50px; /* Specific height for the input area */
            position: relative;
        }

        .input-data input {
            display: block;
            width: 100%;
            height: 100%;
            border: none;
            font-size: 1rem;
            border-bottom: 2px solid rgba(0, 0, 0, 0.12);
            background: transparent;
            transition: all 0.3s ease;
        }

        /* Label Animation */
        .input-data label {
            position: absolute;
            bottom: 10px;
            left: 0;
            color: #777;
            pointer-events: none;
            transition: all 0.3s ease;
            font-size: 1rem;
        }

        .underline {
            position: absolute;
            bottom: 0;
            height: 2px;
            width: 100%;
        }

        .underline:before {
            content: "";
            position: absolute;
            height: 100%;
            width: 100%;
            background: #3a7bd5;
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        /* Logic for lifting label */
        .input-data input:focus ~ label,
        .input-data input:valid ~ label {
            transform: translateY(-25px);
            font-size: 0.85rem;
            color: #3a7bd5;
            font-weight: 600;
        }

        .input-data input:focus ~ .underline:before,
        .input-data input:valid ~ .underline:before {
            transform: scaleX(1);
        }

        /* Button */
        .button-container {
            text-align: center;
            margin-top: 30px;
        }

        .button {
            padding: 15px 60px;
            font-size: 1.1rem;
            font-weight: 600;
            background: linear-gradient(45deg, #2c5364, #3a7bd5);
            color: white;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            box-shadow: 0 10px 25px rgba(44, 83, 100, 0.3);
            transition: 0.3s;
        }

        .button:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(58, 123, 213, 0.4);
        }

        .back {
            text-align: center;
            margin-top: 25px;
        }

        .back a {
            color: #666;
            text-decoration: none;
            font-size: 0.95rem;
            transition: 0.3s;
        }

        .back a:hover { color: #3a7bd5; }

        /* Notifications */
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

        @keyframes slideIn { from { transform: translateX(-100%); opacity: 0; } to { transform: translateX(0); opacity: 1; } }

        @media (max-width: 600px) {
            .form-row { flex-direction: column; }
            .container { padding: 30px; }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="text">Add Item</div>

    <form id="addItems" action="${pageContext.request.contextPath}/ItemsController" method="POST">
        <div class="form-row">
            <div class="input-data">
                <input type="text" id="name" name="name" required autocomplete="off">
                <div class="underline"></div>
                <label>Name</label>
            </div>
            <div class="input-data">
                <input type="number" id="price" name="price" required autocomplete="off">
                <div class="underline"></div>
                <label>Price</label>
            </div>
        </div>
        <div class="form-row">
            <div class="input-data">
                <input type="number" id="totalNumber" name="totalNumber" required autocomplete="off">
                <div class="underline"></div>
                <label>Total Quantity</label>
            </div>
        </div>
        
        <input type="hidden" name="action" value="addItem">
        <div class="button-container">
            <input type="submit" value="Add Item" class="button">
        </div>
    </form>

    <div class="back">
        <a href="${pageContext.request.contextPath}/ItemsController">← Back To Items</a>
    </div>

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