package Model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Column;
import javax.persistence.Table;

@Entity
@Table(name = "books") // Specifies the database table name
public class Book {

    @Id // Marks this field as the primary key
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto-generates the primary key value
    private int id;

    @Column(name = "title", nullable = false, length = 200) // Maps to a column named 'title'
    private String title;

    @Column(name = "author", nullable = false, length = 100) // Maps to a column named 'author'
    private String author;

    @Column(name = "price", nullable = false) // Maps to a column named 'price'
    private double price;

    @Column(name = "isbn", unique = true, length = 20) // Maps to a column named 'isbn'
    private String isbn;

    @Column(name = "isAvailable", nullable = false) // Maps to a column to check availability of the book
    private boolean isAvailable;

    @Column(name = "availableCopies", nullable = false) // Maps to a column for the number of available copies
    private int availableCopies;

    @Column(name = "imagePath", length = 255) // Maps to a column for the image path
    private String imagePath;

    @Column(name = "description" )
    private String description;

    // Default constructor (required by JPA)
    public Book() {}

    // Constructor for convenience
    public Book(String title, String author, double price, String isbn, int availableCopies, String imagePath) {
        this.title = title;
        this.author = author;
        this.price = price;
        this.isbn = isbn;
        this.availableCopies = availableCopies;
        this.imagePath = imagePath;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public boolean getisAvailable() {
        return isAvailable;
    }

    public void setisAvailable(boolean available) {
        isAvailable = available;
    }

    public int getAvailableCopies() {
        return availableCopies;
    }

    public void setAvailableCopies(int availableCopies) {
        this.availableCopies = availableCopies;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    // toString method for debugging
    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", author='" + author + '\'' +
                ", price=" + price +
                ", isbn='" + isbn + '\'' +
                ", availableCopies=" + availableCopies +
                ", imagePath='" + imagePath + '\'' +
                '}';
    }
}
