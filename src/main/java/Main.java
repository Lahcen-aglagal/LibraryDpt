import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import Model.*;
import dao.*;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("user_pu");
        UserDAO userDAO = new UserDAO(emf);

        User u = new User();
        u.setName("lahcen");
        u.setEmail("lahcen.aglagal@uit.ac.ma");
        u.setPassword("lahsen");
        u.setRole("admin");
        userDAO.createUser(u);

    }
}
