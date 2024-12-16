package Connectdb;
import java.sql.*;
import Static.Statics;

public class Connectiondb {
    private static Connection connection = null;

    public static Connection getConnection() {
        if (connection == null) {
            try {
                System.out.println("start connecting to database");
                Class.forName(Statics.DRIVER);
                connection = DriverManager.getConnection(Statics.URL, Statics.USER, Statics.PASSWORD);
                System.out.println("Connexion à la base de données reussie !!!!!");
            } catch (ClassNotFoundException e) {
                System.err.println("Erreur : Driver MySQL introuvable !");
                e.printStackTrace();
            } catch (SQLException e) {
                System.err.println("Erreur : Connexion à la base de données échouée !");
                e.printStackTrace();
            }
        }
        return connection;
    }

    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Connexion fermée !");
            } catch (SQLException e) {
                System.err.println("Erreur lors de la fermeture de la connexion !");
                e.printStackTrace();
            }
        }
    }
}