package dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import java.util.List;
import Model.Book;

public class BookDAO {
    private EntityManagerFactory emf;

    // Constructor
    public BookDAO(EntityManagerFactory emf) {
        this.emf = emf;
    }

    // Create a new book
    public void createBook(Book book) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(book);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
        } finally {
            em.close();
        }
    }

    // Retrieve all books
    public List<Book> getAllBooks() {
        EntityManager em = emf.createEntityManager();
        try {
            Query query = em.createQuery("SELECT b FROM Book b", Book.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // Retrieve a book by its ID
    public Book getBookById(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Book.class, id);
        } finally {
            em.close();
        }
    }

    // Update an existing book
    public void updateBook(Book book) throws Exception {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(book);  // Merges the state of the given entity into the current persistence context
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw new Exception("Error updating book", e);
        } finally {
            em.close();
        }
    }

    // Delete a book by its ID
    public boolean deleteBook(int id) throws Exception {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Book book = em.find(Book.class, id);
            if (book != null) {
                em.remove(book);  // Removes the book entity from the database
            } else {
                throw new Exception("Book not found for deletion");
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw new Exception("Error deleting book", e);
        } finally {
            em.close();
        }
        return false;
    }
}
