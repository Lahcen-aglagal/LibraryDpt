package controller;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import Model.User;
import javax.persistence.*;
import dao.UserDAO;
import java.io.PrintWriter;

@WebServlet(name = "userServlet" , value = "/user-servlet")
public class UserController extends HttpServlet {

    EntityManagerFactory emf ;
    public void init()  {
        this.emf = Persistence.createEntityManagerFactory("user_pu");
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO dao = new UserDAO(emf);
        List<User> users = dao.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        User newUser = new User();
        newUser.setName(username);
        newUser.setPassword(password);
        newUser.setEmail(email);

        em.persist(newUser);
        em.getTransaction().commit();
        em.close();
        response.sendRedirect("login.jsp");
    }
}
