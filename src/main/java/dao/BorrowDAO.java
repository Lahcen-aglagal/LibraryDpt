package dao;

import Model.Borrow;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import java.util.List;

public class BorrowDAO {

    private EntityManagerFactory emf;

    public BorrowDAO(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public void borrowBook(Borrow borrow) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(borrow);
        em.getTransaction().commit();
        em.close();
    }
    public List<Borrow> getAllBorrows() {
        EntityManager em = emf.createEntityManager();
        try {
            Query query = em.createQuery("SELECT b FROM Borrow b", Borrow.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

}
