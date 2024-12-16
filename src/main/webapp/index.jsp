<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Library Management Project Overview</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    body {
      background-color: #f4f6f9;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      line-height: 1.6;
    }
    .container {
      max-width: 800px;
      margin: 0 auto;
      padding: 2rem 1rem;
    }
    .card {
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      border: none;
      margin-bottom: 2rem;
    }
    .card-header {
      background-color: #007bff;
      color: white;
      font-weight: bold;
    }
    .tech-stack {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      margin-top: 1rem;
    }
    .tech-badge {
      background-color: #e9ecef;
      color: #495057;
      padding: 5px 10px;
      border-radius: 20px;
      font-size: 0.9rem;
      display: flex;
      align-items: center;
      gap: 5px;
    }
    .project-cta {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 15px;
      margin-top: 2rem;
    }
    .profile-img {
      max-width: 150px;
      border-radius: 50%;
      border: 4px solid #007bff;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="card">
    <div class="card-header text-center">
      <h1 class="mb-0">Library Management System</h1>
    </div>
    <div class="card-body">
      <div class="text-center mb-4">
        <img src="https://media.licdn.com/dms/image/v2/D4E03AQE76EjXT6wrUg/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1732901031560?e=1740009600&v=beta&t=ei6K_QH6F-pFGJBGak7fnBdwrv4PEZRF_dwhVogV-Uc" alt="Creator" class="profile-img mb-3">
        <h3 class="mb-1">Lahcen Aglagal</h3>
        <p class="text-muted">JEE Course Final Module Project</p>
      </div>

      <div class="mb-4">
        <h2 class="border-bottom pb-2 mb-3">Project Description</h2>
        <p>Une application web de gestion
          d&#39;une bibliothèque. L&#39;application permettra aux utilisateurs de
          consulter les livres disponibles, de les emprunter et de les
          retourner. Les bibliothécaires pourront également ajouter,
          modifier ou supprimer des livres et gérer les emprunts.</p>
      </div>

      <div class="mb-4">
        <h2 class="border-bottom pb-2 mb-3">Technology Stack</h2>
        <div class="tech-stack">
          <div class="tech-badge">
            <i class="bi bi-code-slash"></i> Java EE
          </div>
          <div class="tech-badge">
            <i class="bi bi-file-earmark-code"></i> JSP
          </div>
          <div class="tech-badge">
            <i class="bi bi-database"></i> JPA
          </div>
          <div class="tech-badge">
            <i class="bi bi-database-fill"></i> MySQL
          </div>
          <div class="tech-badge">
            <i class="bi bi-gear"></i> Servlets
          </div>
          <div class="tech-badge">
            <i class="bi bi-window"></i> HTML/CSS
          </div>
          <div class="tech-badge">
            <i class="bi bi-cup-hot"></i> Apache Tomcat
          </div>
        </div>
      </div>

      <div class="project-cta">
        <a href="${pageContext.request.contextPath}/book-servlet" class="btn btn-primary btn-lg">
          <i class="bi bi-book me-2"></i>View Book List
        </a>
        <a href="#" class="btn btn-outline-secondary btn-lg">
          <i class="bi bi-info-circle me-2"></i>Learn More
        </a>
      </div>
    </div>
    <div class="card-footer text-center text-muted">
      © 2024 Library Management Project
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>