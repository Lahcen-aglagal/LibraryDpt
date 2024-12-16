package Static;


public class Statics {

    public static final String USER = "root";
    public static final String PASSWORD = "";
    public static final String DATABASE = "library";
    public static final String HOST = "localhost";
    public static final int PORT = 3306;
    public static final String URL = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DATABASE;
    public static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private Statics() {}
}
