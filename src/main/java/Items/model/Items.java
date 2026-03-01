package Items.model;

public class Items {

    private int id;
    private String name;
    private String price;
    private String totalNumber;
    private int userId;
    private String userName;

    
    public int getId() {
        return id;
    }

    public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	
    public void setId(int id) {
        this.id = id;
    }

 
    public String getName() {
        return name;
    }

 
    public void setName(String name) {
        this.name = name;
    }

  
    public String getPrice() {
        return price;
    }


    public void setPrice(String price) {
        this.price = price;
    }

 
    public String getTotalNumbers() {
        return totalNumber;
    }

   
    public void setTotalNumbers(String totalNumber) {
        this.totalNumber = totalNumber;
    }
    
    
    public void setUserName(String userName) {
    	this.userName = userName;
    }
    
    public String getUserName() {
    	return userName;
    }
}

