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
		
		String action = request.getParameter("action");
		
		if(dataSource == null ) {
			request.getRequestDispatcher("/UsersView/loginUsers.jsp").forward(request, response);
			return;
		}
		
		db = DBConnection.getInstance(dataSource);
		
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
		case"changePassword":
			changePassword(request , response , user);
			break;
		case"getUsername":
			
			break;
		default:
			request.getRequestDispatcher("/UsersView/loginUsers.jsp").forward(request, response);
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
	 
	
	
	
	
	private void login(HttpServletRequest request, HttpServletResponse response , UsersImp userService){
		
		
		String userName = request.getParameter("username");
		String password = request.getParameter("password");
		
		
		Users user = userService.login(userName, password);
		

	    if (user == null) {
	    	
	        HttpSession session = request.getSession(true);
	        session.setAttribute("flashMessage", "Username or Password is Incorrect");
	        session.setAttribute("flashType", "error");
	       
	        
	        try {
	        	response.sendRedirect(request.getContextPath() + "/UsersView/loginUsers.jsp");
	        } catch (Exception e) {
	            e.printStackTrace();
	        } 
		       
	        return;
	    }
	    
	    HttpSession session = request.getSession(true); // true = create if not exists
	    session.setAttribute("userId", user.getId());           

	    try {
	        response.sendRedirect(request.getContextPath() + "/ItemsController");
	    } catch (IOException e) {
	        e.printStackTrace();
	    }

	}
	
	
	
	
	
	private void logOut(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    
	    HttpSession session = request.getSession(false);

	    if (session != null) {
	       
	        session.removeAttribute("userId"); 
	       
	        session.invalidate();
	    }
	    HttpSession newSession = request.getSession(true);
	    newSession.setAttribute("flashMessage", "You have been logged out successfully.");
	    newSession.setAttribute("flashType", "success");

	    // Redirect to login page
	    response.sendRedirect(request.getContextPath() + "/UsersView/loginUsers.jsp");

	       
	}
	
	
	private void deleteAccount(HttpServletRequest request, HttpServletResponse response , UsersImp user) throws IOException {
		HttpSession session = request.getSession(false);
		
		int userId = (int)session.getAttribute("userId"); 
	
		if (session == null || session.getAttribute("userId") == null) {
		    try {
		    	response.sendRedirect(request.getContextPath() + "/UsersView/loginUsers.jsp");
			} catch (IOException e) {
				e.printStackTrace();
			}
		    return;
		}
		
		if(!user.deleteAccount(userId)) {
			HttpSession newSession = request.getSession(true);
		    newSession.setAttribute("flashMessage", "Something Went Wrong");
		    newSession.setAttribute("flashType", "error");
		    return;
		}
        session.removeAttribute("userId"); 
        session.invalidate();
        
        
		HttpSession newSession = request.getSession(true);
	    newSession.setAttribute("flashMessage", "Your Account has been deleted Successfully");
	    newSession.setAttribute("flashType", "success");
	    response.sendRedirect(request.getContextPath() + "/UsersView/loginUsers.jsp");
	}
	
	
	
	
	private void changePassword(HttpServletRequest request, HttpServletResponse response , UsersImp user) throws IOException, ServletException{
		
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null) {
		    try {
				session.setAttribute("flashType", "error");
				request.getSession().setAttribute("flashMessage", "Something Went Wrong-1");
		    	response.sendRedirect(request.getContextPath() + "/UsersView/loginUsers.jsp");
			} catch (IOException e) {
				e.printStackTrace();
			}
		    return;
		}
		
		int id = (int)session.getAttribute("userId");
		String oldPassword = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		String newPassword = request.getParameter("newPassword");
		
		if(!user.getPassword(oldPassword,id) || !user.signUpPassword(newPassword) || !user.checkpassword(confirmPassword, newPassword) 
				|| user.checkpassword(oldPassword, newPassword)) {
			session.setAttribute("flashType", "error");
			request.getSession().setAttribute("flashMessage", "Something Went Wrong-2");
			response.sendRedirect(request.getContextPath() + "/ItemsController");
			return;
		}
		
		if(!user.changePassword(id,newPassword)) {
			session.setAttribute("flashType", "error");
			request.getSession().setAttribute("flashMessage", "Something Went Wrong-3");
			response.sendRedirect(request.getContextPath() + "/ItemsController");
			return;
		}
		
		session.setAttribute("flashType", "success");
		request.getSession().setAttribute("flashMessage", "Your password has been changed");
		response.sendRedirect(request.getContextPath() + "/ItemsController");
		
		
	}
	
	

	
	
	
	

	
	private void signUp(HttpServletRequest request, HttpServletResponse response , UsersImp user) {
		
		ErrorMessages error = new ErrorMessages();

	    String firstName = request.getParameter("firstname");
	    if (!user.signUpName(firstName)) {
	        error.redirect(request, response, "firstname");
	        return;
	    }

	    String lastName = request.getParameter("lastname");
	    if (!user.signUpName(lastName)) {
	        error.redirect(request, response, "lastname");
	        return;
	    }

	    String userName = request.getParameter("username");
	    if (user.signUpUN(userName) || !user.signUpName(userName) ) { 
	        error.redirect(request, response, "username");
	        return;
	    }

	    String password = request.getParameter("password");
	    if (!user.signUpPassword(password)) {
	        error.redirect(request, response, "password");
	        return;
	    }

	    String confirmPW = request.getParameter("confirmPassword");
	    if (!user.checkpassword(confirmPW, password)) {
	        error.redirect(request, response, "confirmPW");
	        return;
	    }

	    String email = request.getParameter("email");
	    if (user.signUpEmail(email) || !user.checkEmail(email)) { 
	        error.redirect(request, response,  "email");
	        return;
	    }

	    boolean addedData = user.addingData(firstName, lastName, userName, email, password);
	    if (!addedData) {
	        error.redirect(request, response,"data");
	        return;
	    }
 
		
        try {
        	request.setAttribute("successMessage", "User has been added successfully!");
			request.getRequestDispatcher("/UsersView/loginUsers.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
		
		
	}

}
