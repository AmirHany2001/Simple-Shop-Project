package Items.model;

public class Items {

    private int id;
    private String name;
    private String price;
    private String totalNumber;
    private int userId;

    // Getter for id
    public int getId() {
        return id;
    }

    public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	// Setter for id
    public void setId(int id) {
        this.id = id;
    }

    // Getter for name
    public String getName() {
        return name;
    }

    // Setter for name
    public void setName(String name) {
        this.name = name;
    }

    // Getter for price
    public String getPrice() {
        return price;
    }

    // Setter for price
    public void setPrice(String price) {
        this.price = price;
    }

    // Getter for totalNumbers
    public String getTotalNumbers() {
        return totalNumber;
    }

    // Setter for totalNumbers
    public void setTotalNumbers(String totalNumber) {
        this.totalNumber = totalNumber;
    }
}

