<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        body, html {
            height: 100%;
            margin: 0;
            background-color: #f4f6f9;
        }
        .login-container {
            max-width: 1100px;
            height: 80vh;
            max-height: 700px;
            background: white;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        .login-image {
            background-image: url("https://i.pinimg.com/474x/fa/3f/8a/fa3f8a978a7899587e86226b66cead99.jpg");
            background-size: cover;
            background-position: center;
            height: 100%;
        }
        .login-card {
            display: flex;
            flex-direction: column;
            justify-content: center;
            height: 100%;
            padding: 2rem;
        }
        .password-container {
            position: relative;
        }
        .toggle-password {
            position: absolute;
            right: 10px;
            top: 38px;
            cursor: pointer;
            color: #6c757d;
        }
        @media (max-width: 768px) {
            .login-container {
                height: auto;
                max-height: none;
            }
            .login-image {
                display: none;
            }
        }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="login-container row">
                <div class="col-md-6 d-flex align-items-center">
                    <div class="login-card w-100">
                        <h2 class="text-center mb-4">Admin Login</h2>

                        <!-- Error Alert Section -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <strong>Error!</strong> ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <!-- Login Form -->
                        <form action="loginServlet" method="post" id="loginForm" novalidate>
                            <div class="mb-3">
                                <label for="username" class="form-label">Username</label>
                                <input type="text" name="username" id="username"
                                       class="form-control"
                                       required
                                       autocomplete="username"
                                       placeholder="Enter your username">
                                <div class="invalid-feedback">
                                    Please enter your username
                                </div>
                            </div>
                            <div class="mb-3 password-container">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" name="password" id="password"
                                       class="form-control"
                                       required
                                       autocomplete="current-password"
                                       placeholder="Enter your password">
                                <span class="toggle-password" onclick="togglePasswordVisibility()">
                                    <i id="passwordToggleIcon" class="bi bi-eye-slash"></i>
                                </span>
                                <div class="invalid-feedback">
                                    Please enter your password
                                </div>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    Login
                                </button>
                            </div>
                        </form>

                        <div class="text-center text-muted mt-3">
                            © 2024 Admin Portal
                        </div>
                    </div>
                </div>
                <div class="col-md-6 login-image">
                    <!-- Image is set as a background in CSS -->
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('loginForm');

        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);

        // Prevent form resubmission on page refresh
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }
    });

    function togglePasswordVisibility() {
        const passwordInput = document.getElementById('password');
        const passwordToggleIcon = document.getElementById('passwordToggleIcon');

        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            passwordToggleIcon.classList.remove('bi-eye-slash');
            passwordToggleIcon.classList.add('bi-eye');
        } else {
            passwordInput.type = 'password';
            passwordToggleIcon.classList.remove('bi-eye');
            passwordToggleIcon.classList.add('bi-eye-slash');
        }
    }
</script>
</body>
</html>