package errors;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ErrorMessages {
    // Return the message instead of redirecting inside the helper
    public static void setErrorMessage(HttpSession session, String type) {
        String message = switch (type) {
        	case "login"		 -> "Invalid username or password";
            case "firstname" 	 -> "First Name Invalid (min 3 chars, start with Capital)";
            case "lastname"  	 -> "Last Name Invalid";
            case "username"  	 -> "Username already exists or invalid";
            case "email"     	 -> "Email is already registered or invalid";
            case "password"  	 -> "Password must be 6+ chars with uppercase & special char";
            case "confirmPW" 	 -> "Passwords do not match";
            case "session"   	 -> "Session Expired";
            case "ErrorPassword" -> "Wrong Password";
            case "MatchPW"		 -> "You Have Used This Password Recently";
            case "delete"		 -> "Something Went Wrong While Deleting Your Account";
            case "DB"			 -> "Issue With Data Base";
            case "price"		 -> "Enter Valid Price";
            case "totalNumber"	 -> "Enter Valid Input";
            case "name"			 -> "Name Is Not Valid";
            case "data"			 -> "Something Went Wrong With Your Data";
            case "idUpdate"		 -> "You Can't Update this Item";
            case "idDelete"		 -> "You Can't Delete this Item";
            default         	 -> "An unexpected error occurred";
        };
        session.setAttribute("flashMessage", message);
        session.setAttribute("flashType", "error");
    }
}