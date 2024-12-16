package controller;

import Model.User;
import utils.Utils;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

import utils.Utils;
@WebServlet(name = "loginServlet", value = "/Auth/loginServlet")
public class LoginServlet extends HttpServlet {

    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        super.init();
        emf = Persistence.createEntityManagerFactory("user_pu");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("username");
        String password = request.getParameter("password");

        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class);
            query.setParameter("email", email);
            User user = query.getSingleResult();

            if (user != null && Utils.checkPassword(password, user.getPassword())) {
                // Successful login, clear the error attribute if present
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                response.sendRedirect(request.getContextPath() + "/book-servlet");
            } else {
                // Set the error attribute and forward to login page
                request.setAttribute("error", "Invalid username or password.");
                request.getRequestDispatcher("/Auth/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Set the error attribute and forward to login page
            request.setAttribute("error", "Invalid username or password.");
            request.getRequestDispatcher("/Auth/login.jsp").forward(request, response);
        } finally {
            em.close();
        }
    }

    @Override
    public void destroy() {
        super.destroy();
        if (emf != null) {
            emf.close();
        }
    }
}