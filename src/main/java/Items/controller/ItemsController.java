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
	
	
	List<Items>items = null ;
	
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		if(dataSource == null ) {
			request.getRequestDispatcher("/UsersView/loginUsers.jsp").forward(request, response);
			
			return;
		}
		
		db = DBConnection.getInstance(dataSource);
		
		ItemsImp item = new ItemsImp(db);
		
	    if (action == null) {
	        items = item.getItems();
	        request.setAttribute("allItems", items);
	        request.getRequestDispatcher("/ItemsView/showItems.jsp").forward(request, response);
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
			items = item.getItems();
			request.setAttribute("allItems", items);
			request.getRequestDispatcher("/ItemsView/showItems.jsp").forward(request, response);
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
	
	
	
	
	private void addItems(HttpServletRequest request, HttpServletResponse response , ItemsImp item) {
		
		String name = request.getParameter("name");
		String price = request.getParameter("price");
		String totalNumber = request.getParameter("totalNumber");
		
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null) {
		    try {
		    	response.sendRedirect(request.getContextPath() + "/UsersView/loginUsers.jsp");
			} catch (IOException e) {
				e.printStackTrace();
			}
		    return;
		}

		int userId = (int) session.getAttribute("userId");
				
		try {
			if(!item.checkName(name)|| !item.checkNumber(totalNumber)|| !item.checkPrice(price)|| item.checkRepeatedName(name)) {
				  session.setAttribute("flashType", "error");
				request.getSession().setAttribute("flashMessage", "No Item Added");
				response.sendRedirect(request.getContextPath() + "/ItemsController");
				return;
			}
			
			if(!(item.addItems(name , price , totalNumber , userId))) {
				session.setAttribute("flashType", "error");
				request.getSession().setAttribute("flashMessage", "No Item Added");
				response.sendRedirect(request.getContextPath() + "/ItemsController");
				return;
			}
			session.setAttribute("flashType", "success");
			request.getSession().setAttribute("flashMessage", "Item Added Successfully");
			response.sendRedirect(request.getContextPath() + "/ItemsController");
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	
	}
	
	
	
	
	
	private void getItem(HttpServletRequest request, HttpServletResponse response , ItemsImp item) throws IOException {
		
		
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null) {
		    try {
		    	response.sendRedirect(request.getContextPath() + "/UsersView/loginUsers.jsp");
			} catch (IOException e) {
				e.printStackTrace();
			}
		    return;
		}
		
		int id = Integer.parseInt(request.getParameter("id"));
		
		Items itemNew = item.getItem(id);
		
		if(itemNew == null) {
			session.setAttribute("flashType", "error");
			request.getSession().setAttribute("flashMessage", "Something Went Wrong");
			response.sendRedirect(request.getContextPath() + "/ItemsController");
			return;
		}
		
		System.out.println(id);
		
		request.setAttribute("item", itemNew);
		session.setAttribute("itemId", id);
		try {
			request.getRequestDispatcher("/ItemsView/updateItems.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
		return;
	
	}
	
	
	
	
	private void removeItem(HttpServletRequest request, HttpServletResponse response,ItemsImp item) {
		int id = Integer.parseInt(request.getParameter("id"));
		
		
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null) {
		    try {
		    	response.sendRedirect(request.getContextPath() + "/UsersView/loginUsers.jsp");
			} catch (IOException e) {
				e.printStackTrace();
			}
		    return;
		}
		
		try {
			if(item.removeItem(id) <= 0) {
				session.setAttribute("flashType", "error");
				request.getSession().setAttribute("flashMessage", "No Item Deleted");
				response.sendRedirect(request.getContextPath() + "/ItemsController");
				return;
			}
			session.setAttribute("flashType", "success");
			request.getSession().setAttribute("flashMessage", "Item Deleted Successfully");
			response.sendRedirect(request.getContextPath() + "/ItemsController");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
	
	
	
	private void updateItem(HttpServletRequest request, HttpServletResponse response , ItemsImp item) {
		
	
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null) {
		    try {
		    	response.sendRedirect(request.getContextPath() + "/UsersView/loginUsers.jsp");
			} catch (IOException e) {
				e.printStackTrace();
			}
		    return;
		}
		
		String updatedName = request.getParameter("updatedName");
		String price = request.getParameter("price");
		String totalNumber = request.getParameter("totalNumber");
		int id  = (int) session.getAttribute("itemId");
		
		
		
		try {
			if(!item.checkName(updatedName)|| !item.checkNumber(totalNumber)|| !item.checkPrice(price) || item.checkRepeatedName(updatedName)) {
				  session.setAttribute("flashType", "error");
				request.getSession().setAttribute("flashMessage", "No Item Updated");
				response.sendRedirect(request.getContextPath() + "/ItemsController");
				return;
			}
			if(!(item.updateItems(updatedName,price,totalNumber,id))) {
				  session.setAttribute("flashType", "error");
				request.getSession().setAttribute("flashMessage", "No Item Updated");
				response.sendRedirect(request.getContextPath() + "/ItemsController");
				return;
			}
			session.setAttribute("flashType", "success");
			request.getSession().setAttribute("flashMessage", "Item Updated Successfully");
			response.sendRedirect(request.getContextPath() + "/ItemsController");
			
		} catch (IOException e) {
			e.printStackTrace();
		}

		
	}

}
