package Users.services;

import Users.model.Users;

public interface userServices {

	Users login(String name , String password);
	
	boolean signUpName(String name );
	boolean signUpUN(String userName);
	boolean signUpPassword(String password);
	boolean signUpEmail(String email);
	
	boolean checkpassword(String confirmPW , String password);
	boolean checkEmail(String email);
	
	boolean deleteAccount(int id);
	boolean getPassword(String password , int id);
	boolean changePassword(int id , String password);
	
	boolean addingData(String firstName , String  lastName , String userName ,String email ,String password );
	
}
