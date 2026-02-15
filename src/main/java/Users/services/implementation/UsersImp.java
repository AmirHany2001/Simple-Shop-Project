package Users.services.implementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import DB.DBConnection;
import Users.model.Users;
import Users.services.userServices;

public class UsersImp implements userServices{
	
	private DBConnection db ;
	
	public UsersImp() {}
	
    public UsersImp(DBConnection db) {
        this.db = db;
    }

	
	@Override
	public Users login(String name , String password) {
		 
		String query = "SELECT * FROM Users WHERE username = ? and password = ?";
		
		try(Connection connection = db.getConnection();
	        PreparedStatement stmt = connection.prepareStatement(query)) {
			stmt.setString(1, name);
			stmt.setString(2, password);
			ResultSet resultSet = stmt.executeQuery();
			
			if(resultSet.next()) {
	            Users user = new Users();
	            user.setId(resultSet.getInt("id"));
	            user.setFirstName(resultSet.getString("firstName"));
	            user.setLastName(resultSet.getString("lastName"));
	            user.setUserName(resultSet.getString("username"));
	            user.setEmail(resultSet.getString("email"));
	            user.setPassword(resultSet.getString("password"));
	            return user;
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
		
	}

	@Override
	public boolean signUpPassword(String password) {
		String regex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[@#$%^&+=!]).+$";
		return password.length() >= 6 && password.matches(regex);
	}

	@Override
	public boolean signUpEmail(String email) {
		String query = "SELECT * FROM Users WHERE email = ?";
		try(Connection connection = db.getConnection();
		        PreparedStatement stmt = connection.prepareStatement(query)) {
				stmt.setString(1, email);
				ResultSet resultSet = stmt.executeQuery();
				return resultSet.next();
				
			}catch(SQLException e) {
				e.printStackTrace();
				return false;
			}
	}

	@Override
	public boolean signUpName(String name) {
		
		return name.length() >= 3 && Character.isUpperCase(name.charAt(0)) && name.matches("[A-Za-z ]+") ;
	}


	@Override
	public boolean signUpUN(String userName) {
		
		String query = "SELECT * FROM Users WHERE username = ?";
		
		try(Connection connection = db.getConnection();
		        PreparedStatement stmt = connection.prepareStatement(query)) {
				stmt.setString(1, userName);
				ResultSet resultSet = stmt.executeQuery();
				return resultSet.next();
				
			}catch(SQLException e) {
				e.printStackTrace();
				return false;
			}
	}


	@Override
	public boolean addingData(String firstName, String lastName, String userName, String email, String password ) {
		String query = "insert into Users (firstName,lastName,username,email,password)values(?, ?, ?, ?, ?)";
		
		try(Connection connection = db.getConnection();
		        PreparedStatement stmt = connection.prepareStatement(query)) {
		        stmt.setString(1, firstName);
		        stmt.setString(2, lastName);
		        stmt.setString(3, userName);
		        stmt.setString(4, email);
		        stmt.setString(5, password);
		        int rowsInserted = stmt.executeUpdate();	
		        return rowsInserted > 0;
				
			}catch(SQLException e) {
				e.printStackTrace();
				return false;
			}
	}


	@Override
	public boolean checkpassword(String confirmPW , String password) {
		
		return confirmPW.equals(password);
	}

	@Override
	public boolean checkEmail(String email) {
		String regex = "^[A-Za-z0-9._%+-]+@gmail\\.com$";
		return email.matches(regex);
	}

	@Override
	public boolean deleteAccount(int id) {
		String query = "DELETE FROM Users WHERE id = ?";
		try(Connection connection = db.getConnection();
		        PreparedStatement stmt = connection.prepareStatement(query)){
	
			stmt.setInt(1,id);
	        int rowsdeleted = stmt.executeUpdate();
	        return rowsdeleted > 0;
	        
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean getPassword(String password , int id) {
		String query = "SELECT * FROM Users WHERE id = ? and password = ?";
		try(Connection connection = db.getConnection();
		        PreparedStatement stmt = connection.prepareStatement(query)) {
				stmt.setInt(1, id);
				stmt.setString(2, password);
				ResultSet resultSet = stmt.executeQuery();
			return resultSet.next();
				
			}catch(SQLException e) {
				e.printStackTrace();
			}
		return false;
	}

	@Override
	public boolean changePassword(int id, String password) {
		String query = "update Users set password = ? where id = ?";
		try(Connection connection = db.getConnection();
		        PreparedStatement stmt = connection.prepareStatement(query)){
			stmt.setString(1,password);
			stmt.setInt(2,id);

	        int rowsInserted = stmt.executeUpdate();	
	        return rowsInserted > 0;
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

}



