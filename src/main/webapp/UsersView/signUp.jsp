<%@page import="Users.services.implementation.UsersImp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>

<style>
    body {
        margin: 0;
        min-height: 100vh;
        background: linear-gradient(135deg, #6a11cb, #2575fc);
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .signup-container {
        width: 360px;
        text-align: center;
        font-family: Arial, sans-serif;
    }

    form {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    input {
        width: 100%;
        height: 44px;
        padding: 0 40px 0 14px;
        margin: 8px 0;
        font-size: 14.5px;
        border-radius: 8px;
        border: 2px solid #000;
        box-sizing: border-box;
    }

    input:focus {
        outline: none;
        border-color: #4CAF50;
        box-shadow: 0 0 5px rgba(76, 175, 80, 0.4);
    }

    button {
        width: 100%;
        padding: 12px;
        margin-top: 15px;
        background: #2575fc;
        color: #fff;
        font-size: 15px;
        font-weight: bold;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        transition: background 0.3s, transform 0.2s;
    }

    button:hover {
        background: #388e3c;
        transform: translateY(-2px);
    }

    button:active {
        transform: translateY(0);
    }

    .password-wrapper,
    .password-confirm-wrapper {
        width: 100%;
    }

    .password-field {
        position: relative;
        width: 100%;
    }

    .toggle-password {
        position: absolute;
        right: 12px;
        top: 50%;
        transform: translateY(-50%);
        cursor: pointer;
        user-select: none;
    }

    .error {
        color: red;
        font-size: 16px;
        margin-top: 5px;
        text-align: center;
    }
</style>
</head>

<body>
<div class="signup-container">
    <h2>Sign Up</h2>

    <form id="signupForm" action="/shopProject/UserController" method="POST">

        <input type="text" id="firstname" name="firstname" value="${param.firstname}" placeholder="First Name" required>
        
        <c:if test="${not empty FNErrorMessage}">
            <p class="error">${FNErrorMessage}</p>
        </c:if>

        <input type="text" id="lastname" name="lastname" value="${param.lastname}" placeholder="Last Name" required>
        
        <c:if test="${not empty LNErrorMessage}">
            <p class="error">${LNErrorMessage}</p>
        </c:if>

        <input type="text" id="username" name="username" value="${param.username}" placeholder="Username" required>
        <c:if test="${not empty UNErrorMessage}">
            <p class="error">${UNErrorMessage}</p>
        </c:if>

        <input type="text" id="email" name="email" value="${param.email}" placeholder="Email" required>
        <c:if test="${not empty emailErrorMessage}">
            <p class="error">${emailErrorMessage}</p>
        </c:if>

        
        <div class="password-wrapper">
            <div class="password-field">
                <input type="password" id="password" name="password" placeholder="Password" required>
                <span class="toggle-password"
                      onclick="this.previousElementSibling.type =
                      this.previousElementSibling.type === 'password' ? 'text' : 'password'">👀</span>
            </div>

            <c:if test="${not empty passwordErrorMessage}">
                <p class="error">${passwordErrorMessage}</p>
            </c:if>
        </div>

        
        <div class="password-confirm-wrapper">
            <div class="password-field">
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required>
                <span class="toggle-password"
                      onclick="this.previousElementSibling.type =
                      this.previousElementSibling.type === 'password' ? 'text' : 'password'">👀</span>
            </div>

            <c:if test="${not empty confirmPWErrorMessage}">
                <p class="error">${confirmPWErrorMessage}</p>
            </c:if>
        </div>

        <input type="hidden" name="action" value="signup">
        <button id="confirmBtn" type="submit" style="display:none;">Confirm</button>
    </form>
    
<script>
		// Equivalent of signUpPassword
		function signUpPassword(password) {
		    const regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[@#$%^&+=!]).+$/;
		    return password.length >= 6 && regex.test(password);
		}
		
		// Equivalent of signUpName
		function signUpName(name) {
		    const regex = /^[A-Za-z ]+$/;
		    return name.length >= 3 && /^[A-Z]/.test(name.charAt(0)) && regex.test(name);
		}
		
		// Equivalent of checkpassword
		function checkpassword(confirmPW, password) {
		    return confirmPW === password;
		}
		//Equivalent of checkEmail
		function checkEmail(email) {
		    const regex = /^[A-Za-z0-9._%+-]+@gmail\.com$/;
		    return regex.test(email);
		}
		
		// Validate all fields together
		function validateForm() {
		    const firstname = document.getElementById("firstname").value.trim();
		    const lastname = document.getElementById("lastname").value.trim();
		    const username = document.getElementById("username").value.trim();
		    const email = document.getElementById("email").value.trim();
		    const password = document.getElementById("password").value;
		    const confirmPassword = document.getElementById("confirmPassword").value;
		    const valid =
		        signUpName(firstname) &&
		        signUpName(lastname) &&
		        signUpName(username) &&
		        signUpPassword(password) &&
		        checkEmail(email) &&
		        checkpassword(confirmPassword, password);
		
		    document.getElementById("confirmBtn").style.display = valid ? "block" : "none";
		}
		
		// Attach validation on input change
		document.querySelectorAll("#signupForm input").forEach(input => {
		    input.addEventListener("input", validateForm);
		});
</script>

    
</div>
</body>
</html>
