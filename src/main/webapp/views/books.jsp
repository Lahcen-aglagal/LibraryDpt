<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Collection</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./views/books.css">
</head>

<body>
    <div class="header">
        <h1>Book Collection</h1>
        <p>Explore our curated collection of books</p>

        <div class="header-actions">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/logout-servlet" class="btn btn-outline-light">
                        <i class="fas fa-sign-out-alt"></i> Log Out
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/Auth/login.jsp" class="btn btn-outline-light">
                        <i class="fas fa-sign-in-alt"></i> Log In
                    </a>
                </c:otherwise>
            </c:choose>

            <c:if test="${not empty sessionScope.user and sessionScope.user.role == 'admin'}">
                <a data-bs-toggle="modal" data-bs-target="#addBookModal" class="btn btn-light">
                    <i class="fas fa-plus"></i> Add Book
                </a>
                <a  class="btn btn-light" href="${pageContext.request.contextPath}/emprunter">
<%--                    <i class="fas fa-plus"></i> --%>
                    View borrow
                </a>
            </c:if>
        </div>
    </div>
</div>

<div class="container-fluid">
    <div class="book-grid">
        <c:forEach var="book" items="${books}">
            <div class="book-card">
                <c:if test="${not empty sessionScope.user and sessionScope.user.role == 'admin'}">
                    <div class="book-admin-actions">
                        <a href="#" data-bs-toggle="modal" data-bs-target="#deleteModal${book.id}">
                            <i class="fas fa-trash"></i>
                        </a>
                        <a href="#" data-bs-toggle="modal" data-bs-target="#updateModal${book.id}">
                            <i class="fas fa-edit"></i>
                        </a>
                    </div>
                </c:if>

                <img src="<c:choose><c:when test="${empty book.imagePath}">https://via.placeholder.com/350x350?text=No+Image</c:when><c:otherwise>${book.imagePath}</c:otherwise></c:choose>"
                     alt="${book.title}">

                <div class="book-info">
                    <div class="book-info-content">
                        <h3>${book.title}</h3>
                        <p><strong>Author:</strong> ${book.author}</p>
                        <p><strong>ISBN:</strong> ${book.isbn}</p>
                        <p class="price"><strong>Price:</strong> ${book.price} <strong>MAD</strong></p>
                    </div>

                    <div class="book-actions-divider"></div>

                    <div class="book-actions">
                            <span class="availability">
                                <c:choose>
                                    <c:when test="${book.isAvailable}">
                                        <span class="badge bg-success">In Stock</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">Out of Stock</span>
                                    </c:otherwise>
                                </c:choose>
                            </span>

                        <div class="book-actions-buttons">
                            <button type="button" class="btn btn-sm btn-primary"
                                    data-bs-toggle="modal"
                                    data-bs-target="#detailsModal${book.id}">
                                <i class="fas fa-info-circle"></i> Details
                            </button>

                            <c:if test="${book.isAvailable}">
                                <button type="button" class="btn btn-sm btn-success"
                                        data-bs-toggle="modal"
                                        data-bs-target="#emprunterModal${book.id}">
                                    <i class="fas fa-book-reader"></i> Borrow
                                </button>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Details Modal -->
            <div class="modal fade" id="detailsModal${book.id}" tabindex="-1" aria-labelledby="detailsModalLabel${book.id}" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="detailsModalLabel${book.id}">${book.title}</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p><strong>Author:</strong> ${book.author}</p>
                            <p><strong>ISBN:</strong> ${book.isbn}</p>
                            <p><strong>Description:</strong> ${book.description}</p>
                            <p class="price"><strong>Price:</strong> ${book.price}</p>
                            <p class="availability">
                                <c:choose>
                                    <c:when test="${book.isAvailable}">
                                        <span style="color: #28a745;">In Stock</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #dc3545;">Out of Stock</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Delete Confirmation Modal -->
            <div class="modal fade" id="deleteModal${book.id}" tabindex="-1" aria-labelledby="deleteModalLabel${book.id}" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="deleteModalLabel${book.id}">Confirm Deletion</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>Are you sure you want to delete this book?</p>
                        </div>
                        <div class="modal-footer">
                            <form action="${pageContext.request.contextPath}/book-servlet" method="post">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="bookId" value="${book.id}">
                                <button type="submit" class="btn btn-danger">Delete</button>
                            </form>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Emprunter Modal -->
            <div class="modal fade" id="emprunterModal${book.id}" tabindex="-1" aria-labelledby="emprunterModalLabel${book.id}" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="emprunterModalLabel${book.id}">Emprunter: ${book.title}</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="emprunter" method="post">
                                <input type="hidden" name="bookId" value="${book.id}">
                                <div class="mb-3">
                                    <label for="userName${book.id}" class="form-label">Your Name</label>
                                    <input type="text" class="form-control" id="userName${book.id}" name="userName" required>
                                </div>
                                <div class="mb-3">
                                    <label for="userEmail${book.id}" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="userEmail${book.id}" name="userEmail" required>
                                </div>
                                <div class="mb-3">
                                    <label for="userContact${book.id}" class="form-label">Contact</label>
                                    <input type="text" class="form-control" id="userContact${book.id}" name="userContact" required>
                                </div>
                                <div class="mb-3">
                                    <label for="borrowDate${book.id}" class="form-label">Borrow Date</label>
                                    <input type="date" class="form-control" id="borrowDate${book.id}" name="borrowDate" required>
                                </div>
                                <div class="mb-3">
                                    <label for="returnDate${book.id}" class="form-label">Return Date</label>
                                    <input type="date" class="form-control" id="returnDate${book.id}" name="returnDate" required>
                                </div>
                                <button type="submit" class="btn btn-success">Confirm Borrow</button>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Update Book Modal -->
            <div class="modal fade" id="updateModal${book.id}" tabindex="-1" aria-labelledby="updateModalLabel${book.id}" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="updateModalLabel${book.id}">Update Book: ${book.title}</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="${pageContext.request.contextPath}/book-servlet" method="post">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="bookId" value="${book.id}">
                                <div class="mb-3">
                                    <label for="bookTitle${book.id}" class="form-label">Title</label>
                                    <input type="text" class="form-control" id="bookTitle${book.id}" name="title" value="${book.title}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="bookAuthor${book.id}" class="form-label">Author</label>
                                    <input type="text" class="form-control" id="bookAuthor${book.id}" name="author" value="${book.author}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="bookIsbn${book.id}" class="form-label">ISBN</label>
                                    <input type="text" class="form-control" id="bookIsbn${book.id}" name="isbn" value="${book.isbn}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="bookPrice${book.id}" class="form-label">Price</label>
                                    <input type="text" class="form-control" id="bookPrice${book.id}" name="price" value="${book.price}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="bookDescription${book.id}" class="form-label">Description</label>
                                    <textarea class="form-control" id="bookDescription${book.id}" name="description" rows="3">${book.description}</textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="bookAvailability${book.id}" class="form-label">Availability</label>
                                    <select class="form-select" id="bookAvailability${book.id}" name="isAvailable">
                                        <option value="true" ${book.isAvailable ? 'selected' : ''}>Available</option>
                                        <option value="false" ${!book.isAvailable ? 'selected' : ''}>Out of Stock</option>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-success">Update Book</button>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Add Book Modal -->
            <div class="modal fade" id="addBookModal" tabindex="-1" aria-labelledby="addBookModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content border-0 shadow-lg">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title" id="addBookModalLabel">
                                <i class="bi bi-plus-circle me-2"></i>Add New Book
                            </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="${pageContext.request.contextPath}/book-servlet" method="post" id="addBookForm">
                                <!-- Hidden Field to specify adding a book action -->
                                <input type="hidden" name="action" value="addBook">

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="bookTitle" class="form-label">Title <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" id="bookTitle" name="title"
                                                   placeholder="Enter book title" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="bookAuthor" class="form-label">Author <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" id="bookAuthor" name="author"
                                                   placeholder="Enter author name" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="bookIsbn" class="form-label">ISBN <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" id="bookIsbn" name="isbn"
                                                   placeholder="Enter ISBN" pattern="[0-9-]+" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="bookPrice" class="form-label">Price <span class="text-danger">*</span></label>
                                            <div class="input-group">
                                                <span class="input-group-text">$</span>
                                                <input type="number" class="form-control" id="bookPrice" name="price"
                                                       placeholder="0.00" step="0.01" min="0" required>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="availableCopies" class="form-label">Available Copies <span class="text-danger">*</span></label>
                                            <input type="number" class="form-control" id="availableCopies" name="availableCopies"
                                                   placeholder="Number of copies" min="0" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="bookAvailability" class="form-label">Availability <span class="text-danger">*</span></label>
                                            <select class="form-select" id="bookAvailability" name="isAvailable" required>
                                                <option value="true">Available</option>
                                                <option value="false">Out of Stock</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="bookDescription" class="form-label">Description <span class="text-danger">*</span></label>
                                    <textarea class="form-control" id="bookDescription" name="description"
                                              rows="3" placeholder="Enter book description" required></textarea>
                                </div>

                                <div class="mb-3">
                                    <label for="imagePath" class="form-label">Book Cover Image <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="imagePath" name="imagePath"
                                           placeholder="Enter image URL" required>
                                </div>

                                <div class="modal-footer border-0 px-0">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                        <i class="bi bi-x-circle me-2"></i>Cancel
                                    </button>
                                    <button type="submit" class="btn btn-success">
                                        <i class="bi bi-plus-circle me-2"></i>Add Book
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>