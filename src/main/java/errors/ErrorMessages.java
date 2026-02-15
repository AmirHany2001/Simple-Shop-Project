package errors;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ErrorMessages {
	public void redirect( HttpServletRequest request, HttpServletResponse response, String type) {
		
		
	    
		switch (type) {
		case "firstname":
			request.setAttribute("FNErrorMessage", "First Name Invalid");
			break;
		case "lastname":
			request.setAttribute("LNErrorMessage", "Last Name Invalid");
			break;
		case "username":	
			request.setAttribute("UNErrorMessage", "User Name Invalid");
			break;
		case "email":
			request.setAttribute("emailErrorMessage", "Email Invalid");
			break;
		case "password":
			request.setAttribute("passwordErrorMessage", "password Invalid");
			break;
		case "confirmPW":
			request.setAttribute("confirmPWErrorMessage", "password Doesn't Match");
			break;
		case "data":
			request.setAttribute("dataErrorMessage", "Something Went Wrong");
			break;
		}
		
        try {
			request.getRequestDispatcher("/UsersView/signUp.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
		return;
	    
	}
}