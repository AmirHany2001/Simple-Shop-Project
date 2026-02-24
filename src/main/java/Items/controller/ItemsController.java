package Items.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.mysql.cj.Session;

import DB.DBConnection;
import Items.model.Items;
import Items.services.Implementation.ItemsImp;
import errors.ErrorMessages;


@WebServlet("/ItemsController")
public class ItemsController extends HttpServlet {
	@Resource (name = "jdbc/connection")
	
	private DataSource dataSource;
	
	private DBConnection db ; 
	
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		

		 
		 HttpSession session = request.getSession(false);
		 
		
	    if (session == null) {
	    	
	    	HttpSession newSession = request.getSession(true);
			
	        ErrorMessages.setErrorMessage(newSession, "session");
		    response.sendRedirect(request.getContextPath() + "/errors/serverError.jsp");
		    return;

	    }
		
		
		if(dataSource == null ) {
			ErrorMessages.setErrorMessage(session, "DB");
			response.sendRedirect(request.getContextPath() + "/errors/serverError.jsp");
			return;
		}
		
		
		try {
			
			 db = DBConnection.getInstance(dataSource);
			
			 String action = request.getParameter("action");
			 ItemsImp item = new ItemsImp(db);
			
			if(action == null) {
				listItems(request,response ,item );
				return;
			}
			
			
			switch(action) {
			case "addItem":
				addItems(request,response,item);
				break;
			case"updateItem":	
				updateItem(request,response,item);
				break;
			case"getItem":
				getItem(request,response,item);
				break;
			case"removeItem":
				removeItem(request,response,item);
				break;
			default:
				response.sendRedirect(request.getContextPath() + "/errors/itemError.jsp");
			}
			
			
		}catch( IOException e  ) {
			System.err.println("Critical Error in UserController: " + e.getMessage());
			response.sendRedirect(request.getContextPath() + "/errors/itemError.jsp");
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
	
	
	
	
	private void listItems (HttpServletRequest request, HttpServletResponse response , ItemsImp item) throws ServletException,IOException {
		
		
		HttpSession session = request.getSession(false);
    	
		List<Items> items = item.getItems();
		
		session.setAttribute("allItems", items);
		response.sendRedirect(request.getContextPath() + "/ItemsView/showItems.jsp");
		
	}
	
	
	private void addItems(HttpServletRequest request, HttpServletResponse response , ItemsImp item)throws ServletException,IOException {
		
		
		String errorKey = null;
		String name = request.getParameter("name");
		String price = request.getParameter("price");
		String totalNumber = request.getParameter("totalNumber");
		
		HttpSession session = request.getSession(false);
		
		
		
	    if (session == null || session.getAttribute("userId") == null) {
	    	
	    	HttpSession newSession = request.getSession(true);
			
	        ErrorMessages.setErrorMessage(newSession, "session");
		    response.sendRedirect(request.getContextPath() + "/errors/serverError.jsp");
		    return;

	    }

		Object objUserId = session.getAttribute("userId");
		
		if(objUserId == null) {
			ErrorMessages.setErrorMessage(session, "data");
		    response.sendRedirect(request.getContextPath() + "/errors/itemError.jsp");
		    return;
		}
				
		int userId = (int) objUserId;
		
		if(!item.checkName(name) ) {
			errorKey = "name" ;
		}else if(!item.checkNumber(totalNumber)){
			errorKey = "totalNumber";
		}else if(!item.checkPrice(price)){
			errorKey = "price";
		}else if(item.checkRepeatedName(name)) {
			errorKey = "name" ;
		}		
		
		if(errorKey != null) {
			ErrorMessages.setErrorMessage(session, errorKey);
			response.sendRedirect(request.getContextPath() + "/ItemsView/addItems.jsp");
			return;
		}
		
		if(item.addItems(name , price , totalNumber , userId)) {
			
			
			
			session.setAttribute("flashType", "success");
			request.getSession().setAttribute("flashMessage", "Item Added Successfully");
			response.sendRedirect(request.getContextPath() + "/ItemsController");
		}else {
			ErrorMessages.setErrorMessage(session, "data");
			response.sendRedirect(request.getContextPath() +"/ItemsView/addItems.jsp");
		}

	}
	
	
	
	
	
	private void getItem(HttpServletRequest request, HttpServletResponse response , ItemsImp item) throws IOException, ServletException {
		
		
		HttpSession session = request.getSession(false);
		
		if (session == null || session.getAttribute("userId") == null) {
	    	
	    	HttpSession newSession = request.getSession(true);
			
	        ErrorMessages.setErrorMessage(newSession, "session");
	        
		    response.sendRedirect(request.getContextPath() + "/errors/serverError.jsp");
		    return;

	    }
		
		String strId = request.getParameter("id");
		String actionType = request.getParameter("actiontype");
		
		
		if(strId == null) {
			ErrorMessages.setErrorMessage(session, "data");
		    response.sendRedirect(request.getContextPath() + "/errors/itemError.jsp");
		    return;
		}
		
		int id = Integer.parseInt(strId);
		
		Items itemNew = item.getItem(id);
		
		if(itemNew == null) {
			
			ErrorMessages.setErrorMessage(session, "data");
			response.sendRedirect(request.getContextPath() + "/errors/itemError.jsp");
			return;
		}
	
		
		session.setAttribute("item", itemNew);
		session.setAttribute("itemId", id);
		session.setAttribute("itemUserId", itemNew.getUserId());
		

		switch(actionType) {
		case "updateItem":
			response.sendRedirect(request.getContextPath() + "/ItemsView/updateItems.jsp");
			break;
		case "removeItem":
			removeItem(request , response , item);
			break;
		}
	
	}
	
	
	
	
	private void removeItem(HttpServletRequest request, HttpServletResponse response,ItemsImp item)throws IOException, ServletException {
		
		
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null) {
			
	    	
	    	HttpSession newSession = request.getSession(true);
			
	        ErrorMessages.setErrorMessage(newSession, "session");
	        
		    response.sendRedirect(request.getContextPath() + "/errors/serverError.jsp");
		    return;

	    }
		
		Object objUserId =  session.getAttribute("userId");
		Object objItemUserID =  session.getAttribute("itemUserId");
		String strId = request.getParameter("id");
		
		if(objUserId == null || objItemUserID == null || strId == null) {
			ErrorMessages.setErrorMessage(session, "data");
		    response.sendRedirect(request.getContextPath() + "/errors/itemError.jsp");
		    return;
		}
		
		
		int userId = (int) objUserId;
		int itemUserId = (int) objItemUserID;
		int id = Integer.parseInt(strId);
		
		if(userId != itemUserId) {			
			ErrorMessages.setErrorMessage(session, "idDelete");
			response.sendRedirect(request.getContextPath() + "/ItemsController");
			return;
		}
		
		if(item.removeItem(id) >= 0) {
			
			session.setAttribute("flashType", "success");
			request.getSession().setAttribute("flashMessage", "Item Deleted Successfully");
			response.sendRedirect(request.getContextPath() + "/ItemsController");
			return;
		}else {
			ErrorMessages.setErrorMessage(session, "data");
			response.sendRedirect(request.getContextPath() + "/ItemsController");
		}

	
	}
	
	
	
	
	
	
	
	
	
	private void updateItem(HttpServletRequest request, HttpServletResponse response , ItemsImp item) throws IOException {
		
		String errorKey = null ;
	
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null) {
			
	    	
	    	HttpSession newSession = request.getSession(true);
			
	        ErrorMessages.setErrorMessage(newSession, "session");
	        
		    response.sendRedirect(request.getContextPath() + "/errors/serverError.jsp");
		    return;

	    }
		
		String updatedName = request.getParameter("updatedName");
		String price = request.getParameter("price");
		String totalNumber = request.getParameter("totalNumber");
		
		Object objId  = session.getAttribute("itemId");
		Object objUserId =  session.getAttribute("userId");
		Object objItemUserID =  session.getAttribute("itemUserId");
		
		
		if(objId == null || objUserId == null || objItemUserID == null ) {
			ErrorMessages.setErrorMessage(session, "data");
		    response.sendRedirect(request.getContextPath() + "/errors/itemError.jsp");
		    return;
		}
		
		int id = (int) objId;
		int userId = (int) objUserId;
		int itemUserId = (int) objItemUserID;
		
		
		

		
		if(userId != itemUserId) {			
			ErrorMessages.setErrorMessage(session, "idUpdate");
			response.sendRedirect(request.getContextPath() + "/ItemsController");
			return;
		}
		
		
		if(!item.checkName(updatedName)) {
			errorKey = "name";
		}else if(!item.checkNumber(totalNumber)) {
			errorKey = "totalNumber";
		}else if (!item.checkPrice(price)) {
			errorKey = "price";
		}else if (item.checkRepeatedName(updatedName)) {
			errorKey = "name";
		}
		
		if(errorKey != null) {
			ErrorMessages.setErrorMessage(session, errorKey);
			response.sendRedirect(request.getContextPath() + "/ItemsView/updateItems.jsp");
			return;
		}
		
		
		if(item.updateItems(updatedName,price,totalNumber,id)) {
			session.setAttribute("flashType", "success");
			request.getSession().setAttribute("flashMessage", "Item Updated Successfully");
			response.sendRedirect(request.getContextPath() + "/ItemsController");
			return;
		}else {
			ErrorMessages.setErrorMessage(session, "data");
			response.sendRedirect(request.getContextPath() + "/ItemsView/updateItems.jsp");
		}

		
	}

}
