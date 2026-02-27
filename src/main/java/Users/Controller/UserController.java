package Users.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Objects;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import DB.DBConnection;
import Users.model.Users;
import Users.services.implementation.UsersImp;
import errors.ErrorMessages;


@WebServlet("/UserController")
public class UserController extends HttpServlet {
	@Resource (name = "jdbc/connection")
	
	private DataSource dataSource;
	
	private DBConnection db ; 
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 HttpSession session = request.getSession(false);
		
			
		if (!checkSession(request, response , session)) {	
		    	return;
		}
		
		
		if(dataSource == null ) {
			ErrorMessages.setErrorMessage(session, "DB");
			response.sendRedirect(request.getContextPath() + "/errors/serverError.jsp");
			return;
		}
		
		try {
			
			String action = request.getParameter("action");
			db = DBConnection.getInstance(dataSource);
			
			
			if(action == null) {
				response.sendRedirect(request.getContextPath() + "/errors/serverError.jsp");
				return;
			}
			
			UsersImp user = new UsersImp(db);
			
			switch(action) {
			case "login":
				login(request , response , user);
				break;
			case "signup":
				signUp(request , response , user);
				break;
			case"logout":
				logOut(request , response);
				break;
			case"deleteAccount":
				deleteAccount(request , response , user);
				break;
			case"changePasswordView":
				changePasswordView(request , response);
				break;
			case"changePassword":
				changePassword(request , response , user);
				break;
			default:
				response.sendRedirect(request.getContextPath() + "/errors/serverError.jsp");
			}
			
			
		}catch(IOException | ServletException e  ) {
			System.err.println("Critical Error in UserController: " + e.getMessage());
			response.sendRedirect(request.getContextPath() + "/errors/serverError.jsp");
		}
		

		
		

		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
	 
	
	
	
	
	private void login(HttpServletRequest request, HttpServletResponse response, UsersImp userService) throws IOException {
	    String userName = request.getParameter("username");
	    String password = request.getParameter("password");

	    // 1. Authenticate user
	    Users user = userService.login(userName, password);

	    if (user == null) {
	        // Handle failed login
	        HttpSession session = request.getSession(true);
	        ErrorMessages.setErrorMessage(session, "login");
	        response.sendRedirect(request.getContextPath() + "/UsersView/loginUsers.jsp");
	        return;
	    }

	    // 2. Security: Invalidate current session to prevent Session Fixation
	    HttpSession oldSession = request.getSession(false);
	    if (oldSession != null) {
	        oldSession.invalidate();
	    }

	    // 3. Create fresh session and store user data
	    HttpSession newSession = request.getSession(true);
	    newSession.setAttribute("userId", user.getId());
	    
	    newSession.setAttribute("flashType", "success");
	    newSession.setAttribute("flashMessage", "Welcome back, " + user.getUserName() + "!");
	    

	    // 4. Redirect to the landing page
	    response.sendRedirect(request.getContextPath() + "/ItemsController");
	}
	
	
	
	
	
	private void logOut(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    
	    HttpSession session = request.getSession(false);

		
		if (!checkSession(request, response , session)) {	
		    	return;
		}
	    
        session.removeAttribute("userId"); 
        session.invalidate();
        
	    HttpSession newSession = request.getSession(true);
	    newSession.setAttribute("flashMessage", "You have been logged out successfully.");
	    newSession.setAttribute("flashType", "success");

	    // Redirect to login page
	    response.sendRedirect(request.getContextPath() + "/UsersView/loginUsers.jsp");

	       
	}
	
	
	private void deleteAccount(HttpServletRequest request, HttpServletResponse response , UsersImp user) throws IOException {
		HttpSession session = request.getSession(false);
		
	
		
		if (!checkSession(request, response , session)) {	
		    	return;
		}
		
		int userId = (int)session.getAttribute("userId"); 
		
		if(user.deleteAccount(userId)) {
			
			session.setAttribute("flashType", "success");
			session.setAttribute("flashMessage", "The Account Has Been Deleted Successfully" );
			session.removeAttribute("userId");
			response.sendRedirect(request.getContextPath() + "/UsersView/loginUsers.jsp");
		   
		}else {
			ErrorMessages.setErrorMessage(session, "delete");
			response.sendRedirect(request.getContextPath() + "/ItemsController");
		}
		
		
	    
	}
	
	
	
	
	private void changePasswordView(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.sendRedirect(request.getContextPath() + "/UsersView/changePassword.jsp");
	}
	
	
	private void changePassword(HttpServletRequest request, HttpServletResponse response , UsersImp user) throws IOException, ServletException{
		
		String errorKey = null ;
		
		HttpSession session = request.getSession(false);
		
		
		if (!checkSession(request, response , session)) {	
		    	return;
		}
		
		int id = (int)session.getAttribute("userId");
		String oldPassword = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		String newPassword = request.getParameter("newPassword");
		
		if (!user.getPassword(oldPassword, id)) {
			errorKey = "ErrorPassword";
	    } else if (!user.signUpPassword(newPassword)) {
	    	errorKey = "Password";
	    } else if (!user.checkpassword(confirmPassword, newPassword)) {
	    	errorKey = "confirmPW";
	    } else if (user.checkpassword(oldPassword, newPassword)) {
	    	errorKey = "MatchPW";
	    }
		
		if(errorKey != null) {
	        ErrorMessages.setErrorMessage(session, errorKey);
	        response.sendRedirect(request.getContextPath() + "/UsersView/changePassword.jsp");
	        return;
		}
		
		if(user.changePassword(id,newPassword)) {
			
			session.setAttribute("flashType", "success");
			request.getSession().setAttribute("flashMessage", "Your password has been changed");
			response.sendRedirect(request.getContextPath() + "/ItemsController");

		}else {
			errorKey = "delete";
			ErrorMessages.setErrorMessage(session, errorKey);
			response.sendRedirect(request.getContextPath() + "/UsersView/changePassword.jsp");
		}
		
	}
	

	private void signUp(HttpServletRequest request, HttpServletResponse response, UsersImp userService) throws IOException {
	    HttpSession session = request.getSession();

	    // 1. Extract Parameters
	    String firstName = request.getParameter("firstname");
	    String lastName  = request.getParameter("lastname");
	    String userName  = request.getParameter("username");
	    String email     = request.getParameter("email");
	    String password  = request.getParameter("password");
	    String confirmPW = request.getParameter("confirmPassword");

	    // 2. Validation Chain (Fail Fast)
	    String errorKey = null;

	    if (!userService.signUpName(firstName)) {
	        errorKey = "firstname";
	    } else if (!userService.signUpName(lastName)) {
	        errorKey = "lastname";
	    } else if (!userService.signUpName(userName) || userService.signUpUN(userName)) {
	        errorKey = "username";
	    } else if (!userService.checkEmail(email) || userService.signUpEmail(email)) {
	        errorKey = "email";
	    } else if (!userService.signUpPassword(password)) {
	        errorKey = "password";
	    } else if (!userService.checkpassword(confirmPW, password)) {
	        errorKey = "confirmPW";
	    }

	    // 3. Handle Validation Errors
	    if (errorKey != null) {
	        ErrorMessages.setErrorMessage(session, errorKey);
	        response.sendRedirect(request.getContextPath() + "/UsersView/signUp.jsp");
	        return;
	    }

	    // 4. Attempt Database Insertion

	    if (userService.addingData(firstName, lastName, userName, email, password)) {
	        session.setAttribute("flashType", "success");
	        session.setAttribute("flashMessage", "Account created successfully! Please log in.");
	        response.sendRedirect(request.getContextPath() + "/UsersView/loginUsers.jsp");
	    } else {
	        ErrorMessages.setErrorMessage(session, "data");
	        response.sendRedirect(request.getContextPath() + "/UsersView/signUp.jsp");
	    }
	}
	
	
	
	
	public static boolean checkSession(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		
		
		if (session == null || session.getAttribute("userId") == null) {	
			HttpSession newSession = request.getSession(true);
	        ErrorMessages.setErrorMessage(newSession, "session");
	        response.sendRedirect(request.getContextPath() + "/errors/serverError.jsp");
	    	return false;
		}
		return true;
		
	}
}
