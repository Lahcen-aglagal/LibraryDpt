package controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Model.Book;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import dao.BookDAO;
@WebServlet(name = "bookServlet" , value = "/book-servlet")
public class BookController extends HttpServlet {


    EntityManagerFactory emf ;
    public void init()  {
        this.emf = Persistence.createEntityManagerFactory("user_pu");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        BookDAO bookdao = new BookDAO(emf);
        List<Book> books = bookdao.getAllBooks();
        PrintWriter out = response.getWriter();
        request.setAttribute("books", books);
        request.getRequestDispatcher("/views/books.jsp").forward(request, response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String bookId = request.getParameter("bookId"); // Get the book ID from the request

        BookDAO bookDAO = new BookDAO(emf);

        if ("addBook".equals(action)) {
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String isbn = request.getParameter("isbn");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");
            boolean isAvailable = Boolean.parseBoolean(request.getParameter("isAvailable"));
            String imagePath = request.getParameter("imagePath");
            int availableCopies = Integer.parseInt(request.getParameter("availableCopies"));


            Book newBook = new Book();
            newBook.setTitle(title);
            newBook.setAuthor(author);
            newBook.setIsbn(isbn);
            newBook.setPrice(price);
            newBook.setDescription(description);
            newBook.setImagePath(imagePath);
            newBook.setAvailableCopies(availableCopies);

            bookDAO.createBook(newBook);
            response.sendRedirect(request.getContextPath() + "/book-servlet");
        }

        if ("delete".equals(action) && bookId != null) {
            try {
                int id = Integer.parseInt(bookId);
                bookDAO.deleteBook(id);
                response.sendRedirect(request.getContextPath() + "/book-servlet");
            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid book ID for deletion");
            }
        }

        if ("update".equals(action) && bookId != null) {
            try {
                int id = Integer.parseInt(bookId);
                String title = request.getParameter("title");
                String author = request.getParameter("author");
                String isbn = request.getParameter("isbn");
                String price = request.getParameter("price");
                String description = request.getParameter("description");
                boolean isAvailable = Boolean.parseBoolean(request.getParameter("isAvailable"));

                Book bookToUpdate = bookDAO.getBookById(id);
                if (bookToUpdate != null) {
                    bookToUpdate.setTitle(title);
                    bookToUpdate.setAuthor(author);
                    bookToUpdate.setIsbn(isbn);
                    bookToUpdate.setPrice(Double.parseDouble(price));
                    bookToUpdate.setDescription(description);
                    bookToUpdate.setisAvailable(isAvailable);

                    bookDAO.updateBook(bookToUpdate);
                    response.sendRedirect(request.getContextPath() + "/book-servlet");
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Book not found");
                }
            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid book ID for update");
            }
        }
        if (bookId == null && !"addBook".equals(action)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Book ID is required for update or delete");
        }
    }

}

