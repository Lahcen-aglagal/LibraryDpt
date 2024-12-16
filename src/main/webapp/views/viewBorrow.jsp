<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library - Borrow Records</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f6f9;
        }
        .table-hover tbody tr:hover {
            background-color: rgba(0,123,255,0.1);
            cursor: pointer;
        }
        .status-badge {
            font-size: 0.8em;
            padding: 0.3em 0.6em;
        }
    </style>
</head>
<body>
<div class="container-fluid px-4 py-5">
    <div class="row">
        <div class="col-12">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <h4 class="mb-0">
                        <i class="bi bi-book me-2"></i>Library Borrow Records
                    </h4>
                    <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#borrowBookModal">
                        <i class="bi bi-plus-circle me-2"></i>New Borrow
                    </button>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="borrowTable" class="table table-striped table-hover">
                            <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>User Name</th>
                                <th>User Email</th>
                                <th>User Contact</th>
                                <th>Book ID</th>
                                <th>Borrow Date</th>
                                <th>Return Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="borrow" items="${borrowList}">
                                <tr>
                                    <td>${borrow.id}</td>
                                    <td>${borrow.userName}</td>
                                    <td>${borrow.userEmail}</td>
                                    <td>${borrow.userContact}</td>
                                    <td>${borrow.bookId}</td>
                                    <td>
                                        <fmt:formatDate value="${borrow.borrowDate}" pattern="yyyy-MM-dd"/>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${borrow.returnDate}" pattern="yyyy-MM-dd"/>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${borrow.returnDate.time < currentDate.time}">
                                                <span class="badge bg-danger status-badge">Overdue</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-success status-badge">Active</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <button class="btn btn-sm btn-outline-primary"
                                                    onclick="viewBorrowDetails(${borrow.id})">
                                                <i class="bi bi-eye"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger"
                                                    onclick="confirmReturn(${borrow.id})">
                                                <i class="bi bi-arrow-return-left"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Borrow Book Modal -->
<div class="modal fade" id="borrowBookModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">
                    <i class="bi bi-book-half me-2"></i>Borrow a Book
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/emprunter" method="post">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">User Name</label>
                            <input type="text" class="form-control" name="userName" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">User Email</label>
                            <input type="email" class="form-control" name="userEmail" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">User Contact</label>
                            <input type="tel" class="form-control" name="userContact" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Book ID</label>
                            <input type="number" class="form-control" name="bookId" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Borrow Date</label>
                            <input type="date" class="form-control" name="borrowDate" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Return Date</label>
                            <input type="date" class="form-control" name="returnDate" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="bi bi-x-circle me-2"></i>Cancel
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-check-circle me-2"></i>Borrow
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>

<script>
    $(document).ready(function() {
        $('#borrowTable').DataTable({
            pageLength: 10,
            responsive: true,
            language: {
                search: "_INPUT_",
                searchPlaceholder: "Search records..."
            }
        });
    });

    function viewBorrowDetails(id) {
        // Implement view details logic
        alert('View details for borrow ID: ' + id);
    }

    function confirmReturn(id) {
        if(confirm('Are you sure you want to mark this book as returned?')) {
            alert('Returning book for borrow ID: ' + id);
        }
    }
</script>
</body>
</html>
