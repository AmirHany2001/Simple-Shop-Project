package Items.services;

import java.util.List;

import Items.model.Items;

public interface ItemsServices {
	
	boolean addItems(String name , String price , String totalNumber , int userId);
	boolean updateItems(String updatedName , String price , String totalNumber , int id);
	List<Items> getItems();
	Items getItem(int id);
	int removeItem(int id);
	
	boolean checkName(String name);
	boolean checkNumber(String number);
	boolean checkPrice(String price);
	boolean checkRepeatedName(String itemName);
	
}
