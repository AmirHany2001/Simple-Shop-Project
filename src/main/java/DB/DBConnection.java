package DB;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

public class DBConnection {
	
	private static DBConnection instance = null ;
	private DataSource dataSource;
	
	private DBConnection (DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
    public static DBConnection getInstance(DataSource dataSource) {
        if (instance == null) {
            instance = new DBConnection(dataSource);
        }
        return instance;
    }
    
    public Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
}
