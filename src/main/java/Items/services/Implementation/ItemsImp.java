package Items.services.Implementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DB.DBConnection;
import Items.model.Items;
import Items.services.ItemsServices;

public class ItemsImp implements ItemsServices{
	
	private DBConnection db ;
	
	public ItemsImp() {}
	
    public ItemsImp(DBConnection db) {
        this.db = db;
    }

	@Override
	public boolean addItems(String name , String price , String totalNumber , int userId) {
		String query = "insert into Items (name , price , totalNumber , user_id) values (? , ? , ? , ?)";
		
		try(Connection connection = db.getConnection();
		        PreparedStatement stmt = connection.prepareStatement(query)){
			stmt.setString(1,name);
			stmt.setString(2, price);
			stmt.setString(3,totalNumber );
			stmt.setInt(4,userId);
	        int rowsInserted = stmt.executeUpdate();	
	        return rowsInserted > 0;
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean updateItems(String updatedName , String price , String totalNumber , int id){
		String query = "update items set name = ? , price = ? ,totalNumber = ? where id = ?";
		try(Connection connection = db.getConnection();
		        PreparedStatement stmt = connection.prepareStatement(query)){
			stmt.setString(1,updatedName);
			stmt.setString(2, price);
			stmt.setString(3,totalNumber );
			stmt.setInt(4,id);

			
	        int rowsInserted = stmt.executeUpdate();	
	        return rowsInserted > 0;
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	
	
	@Override
	public List<Items> getItems() {
		
		String query = "select * from Items order by id ";
		try(Connection connection = db.getConnection();
		        PreparedStatement stmt = connection.prepareStatement(query)){
		
			ResultSet resultSet = stmt.executeQuery(query);
			
			List<Items> items = new ArrayList<>();
			while (resultSet.next()) {
				Items item = new Items();
				item.setId(resultSet.getInt("id"));
				item.setName(resultSet.getString("name"));
				item.setPrice(resultSet.getString("price"));
	            item.setTotalNumbers(resultSet.getString("totalNumber"));
	            item.setUserId(resultSet.getInt("user_id"));
	            items.add(item);
		}	
		return items;
		
		}catch(SQLException e) {
			e.printStackTrace();
		}
			return new ArrayList<>();
	}
	
	
	

	@Override
	public boolean checkName(String name) {
		return name.length() >= 3 && Character.isUpperCase(name.charAt(0)) && name.matches("[A-Za-z ]+");
	}
	
	

	@Override
	public boolean checkNumber(String number) {
		String regex = "^[1-9][0-9]*$";
		return number.matches(regex);
	}
	
	

	@Override
	public boolean checkPrice(String price) {
		String regex = "^(?:[1-9]\\d*|0?\\.\\d*[1-9]\\d*)$";
		return price.matches(regex);
	}
	
	
		
	
	@Override
	public boolean checkRepeatedName(String itemName) {
		String query = "SELECT * FROM Items WHERE name = ?";
		
		try(Connection connection = db.getConnection();
		        PreparedStatement stmt = connection.prepareStatement(query)) {
				stmt.setString(1, itemName);
				ResultSet resultSet = stmt.executeQuery();
				return resultSet.next();
				
			}catch(SQLException e) {
				e.printStackTrace();
				return false;
			}
	}

	@Override
	public Items getItem(int id) {
		String query = "select * from Items where id = ?";
		Items item = new Items();
		
		try(Connection connection = db.getConnection();
		        PreparedStatement stmt = connection.prepareStatement(query)) {
				stmt.setInt(1, id);
				ResultSet resultSet = stmt.executeQuery();
				if(resultSet.next()) {
					item.setName(resultSet.getString("name"));
					item.setPrice(resultSet.getString("price"));
					item.setTotalNumbers(resultSet.getString("totalNumber"));
					item.setId(id);
				}
				return item;
			}catch(SQLException e) {
				e.printStackTrace();
				return null;
			}
	}

	@Override
	public int removeItem(int id) {
		String query = "DELETE FROM Items WHERE id = ?";
		try(Connection connection = db.getConnection();
		        PreparedStatement stmt = connection.prepareStatement(query)){
	
			stmt.setInt(1,id);
	        int rowsdeleted = stmt.executeUpdate();
	        return rowsdeleted;
	        
		}catch(SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}
	
}	
