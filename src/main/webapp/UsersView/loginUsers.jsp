
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        /* Reset defaults */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #6a11cb, #2575fc);
        }

        .login-container {
            background: #fff;
            width: 350px;
            max-width: 90%;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            text-align: center;
        }

        .login-container h2 {
            margin-bottom: 25px;
            color: #333;
        }

        .login-container input {
            width: 100%;
            padding: 12px 15px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        .login-container button {
            width: 100%;
            padding: 12px;
            margin-top: 15px;
            border: none;
            border-radius: 6px;
            background: #2575fc;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        .login-container button:hover {
            background: #6a11cb;
        }

        .signup-link {
            margin-top: 20px;
            font-size: 14px;
        }

        .signup-link a {
            color: #2575fc;
            text-decoration: none;
            font-weight: bold;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }
        
        .error {
	        color: red;
	        font-size: 12px; 
	        margin-top: 5px;
    	}
    	
    	.password-wrapper {
        	position: relative;
        	display: inline-block;
   		}

    	.password-wrapper input {
        	padding-right: 30px; /* space for the icon */
    	}

   		 .toggle-password {
        	position: absolute;
       		right: 8px;
        	top: 50%;
        	transform: translateY(-50%);
        	cursor: pointer;
        	font-size: 14px;
    	}
    	.flash {
		    padding: 14px 22px;
		    margin: 15px 0;
		    border-radius: 10px;
		    font-weight: 500;
		    width: fit-content;
		    transition: opacity 0.5s ease;
		}
		
		.flash.success {
		    background-color: #e6fffa;
		    color: #065f46;
		    border: 1px solid #34d399;
		}
		
		.flash.error {
		    background-color: #fee2e2;
		    color: #7f1d1d;
		    border: 1px solid #f87171;
		}
    	
    	
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <form action="/shopProject/UserController" method="POST">
            <input type="text" name="username" value="${param.username}" placeholder="Username" required>
            <br>
            <div class="password-wrapper">
                <input type="password" id="password" name="password" placeholder="Password" required>
                <span class="toggle-password" 
                      onclick="this.previousElementSibling.type = this.previousElementSibling.type === 'password' ? 'text' : 'password'"> 👀
                </span>
            </div>
            <br>
            <input type="hidden" name="action" value="login">
            <button type="submit">Login</button>
        </form>

        <!-- Signup reference -->
        <p>Don't have an account? <a href="${pageContext.request.contextPath}/UsersView/signUp.jsp">SignUp</a></p>

       

    <c:if test="${not empty sessionScope.flashMessage}">
		    <div id="flashMessage"
		         class="flash ${sessionScope.flashType}">
		        ${sessionScope.flashMessage}
		    </div>
		
		    <script>
		        setTimeout(() => {
		            const msg = document.getElementById("flashMessage");
		            if (msg) {
		                msg.style.opacity = "0";
		                setTimeout(() => msg.style.display = "none", 500);
		            }
		        }, 3000);
		    </script>
		
		    <!-- ❌ REMOVE immediately so it appears ONCE -->
		    <c:remove var="flashMessage" scope="session"/>
		    <c:remove var="flashType" scope="session"/>
		</c:if>

    </div>
</body>

</html>