package controller;

import dao.BorrowDAO;
import dao.BookDAO;
import Model.Borrow;
import Model.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "emprunterServlet", value = "/emprunter")
public class EmprunterServlet extends HttpServlet {

    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        this.emf = Persistence.createEntityManagerFactory("user_pu");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BorrowDAO borrowDAO = new BorrowDAO(emf);
        try {
            List<Borrow> borrowList = borrowDAO.getAllBorrows();

            request.setAttribute("borrowList", borrowList);
            request.getRequestDispatcher("/views/viewBorrow.jsp").forward(request, response);

        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching borrow records: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String userName = request.getParameter("userName");
        String userEmail = request.getParameter("userEmail");
        String userContact = request.getParameter("userContact");
        String bookId = request.getParameter("bookId");
        String borrowDateString = request.getParameter("borrowDate");
        String returnDateString = request.getParameter("returnDate");

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date borrowDate = sdf.parse(borrowDateString);
            Date returnDate = sdf.parse(returnDateString);

            Borrow borrow = new Borrow();
            borrow.setUserName(userName);
            borrow.setUserEmail(userEmail);
            borrow.setUserContact(userContact);
            borrow.setBookId(Integer.parseInt(bookId));
            borrow.setBorrowDate(borrowDate);
            borrow.setReturnDate(returnDate);

            BorrowDAO borrowDAO = new BorrowDAO(emf);
            borrowDAO.borrowBook(borrow);

            BookDAO bookDAO = new BookDAO(emf);
            Book book = bookDAO.getBookById(Integer.parseInt(bookId));

            if (book != null && book.getAvailableCopies() > 0) {
                book.setAvailableCopies(book.getAvailableCopies() - 1);
                bookDAO.updateBook(book);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No copies available for borrowing.");
                return;
            }
            response.sendRedirect(request.getContextPath() + "/book-servlet");
        } catch (ParseException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid date format");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
