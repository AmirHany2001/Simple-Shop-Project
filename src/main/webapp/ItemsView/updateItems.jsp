<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Item</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
    <style type="text/css">
        * { margin: 0; padding: 0; outline: none; box-sizing: border-box; font-family: 'Poppins', sans-serif; }

        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px;
            /* COOL COLOR GRADIENT: Deep Teal to Arctic Blue */
            background: linear-gradient(135deg, #0f2027 0%, #203a43 50%, #2c5364 100%);
        }

        .container {
            max-width: 800px; /* Slightly wider for the 3-column row */
            width: 100%;
            background: rgba(255, 255, 255, 0.98);
            padding: 50px;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
            position: relative;
            overflow: visible; /* Prevents labels from being cut off when they float up */
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
            margin-bottom: 50px;
        }

        .form-row {
            display: flex;
            margin-bottom: 40px;
            gap: 25px;
            flex-wrap: wrap;
        }

        .input-data {
            flex: 1;
            min-width: 200px;
            height: 50px;
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
            color: #333;
            transition: all 0.3s ease;
        }

        /* Readonly style */
        .input-data input[readonly] {
            color: #888;
            border-bottom: 2px dashed rgba(0, 0, 0, 0.1);
            cursor: not-allowed;
        }

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

        .input-data input:focus ~ label,
        .input-data input:valid ~ label,
        .input-data input[readonly] ~ label {
            transform: translateY(-25px);
            font-size: 0.85rem;
            color: #3a7bd5;
            font-weight: 600;
        }

        .input-data input:focus ~ .underline:before,
        .input-data input:valid ~ .underline:before {
            transform: scaleX(1);
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .button {
            padding: 15px 70px;
            font-size: 1.1rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
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
            margin-top: 30px;
        }

        .back a {
            color: #666;
            text-decoration: none;
            font-size: 0.95rem;
            transition: 0.3s;
            font-weight: 500;
        }

        .back a:hover { color: #3a7bd5; }

        /* Notifications */
        .msg-container {
            position: fixed;
            top: 25px;
            left: 25px;
            padding: 15px 25px;
            border-radius: 8px;
            color: white;
            font-weight: 600;
            z-index: 10000;
            box-shadow: 0 10px 20px rgba(0,0,0,0.3);
            animation: slideIn 0.5s ease;
        }

        @keyframes slideIn { from { transform: translateX(-100%); opacity: 0; } to { transform: translateX(0); opacity: 1; } }

        @media (max-width: 700px) {
            .form-row { flex-direction: column; gap: 35px; }
            .container { padding: 30px; }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="text">Update Item</div>

    <form id="updateItem" action="${pageContext.request.contextPath}/ItemsController" method="POST">
        <div class="form-row">    
            <div class="input-data">
                <input type="text" id="name" name="name" value="${item.name}" readonly>
                <div class="underline"></div>
                <label>Current Name</label>
            </div>
            <div class="input-data">
                <input type="text" id="updatedName" name="updatedName" required autocomplete="off">
                <div class="underline"></div>
                <label>New Name</label>
            </div>
            <div class="input-data">
                <input type="number" id="price" name="price" value="${item.price}" required step="0.01" min="0">
                <div class="underline"></div>
                <label>Price ($)</label>
            </div>
        </div>

        <div class="form-row">
            <div class="input-data">
                <input type="number" id="totalNumber" name="totalNumber" value="${item.totalNumbers}" required>
                <div class="underline"></div>
                <label>Total Quantity</label>
            </div>
        </div>

        <input type="hidden" name="action" value="updateItem">
        
        <div class="button-container">
            <input type="submit" value="Update Item" class="button">
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