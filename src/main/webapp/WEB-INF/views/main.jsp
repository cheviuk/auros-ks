<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<html>
<head>
    <title>Contents of Set: ${set.title}</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background: #f4f4f4;
        }
        .container {
            text-align: center;
        }
        h1 {
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
        }
        .links {
            display: flex;
            gap: 1rem;
            justify-content: center;
        }
        .card {
            display: inline-block;
            padding: 1rem 2rem;
            font-size: 1.2rem;
            text-decoration: none;
            color: #fff;
            background: #007bff;
            border-radius: 0.5rem;
            transition: 0.3s ease-in-out;
            box-shadow: 0 0.2rem 0.5rem rgba(0, 0, 0, 0.2);
        }
        .card:hover {
            background: #0056b3;
            transform: translateY(-0.2rem);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to KPAC</h1>
        <div class="links">
            <a href="${pageContext.request.contextPath}/kpacs" class="card">K-PACs</a>
            <a href="${pageContext.request.contextPath}/sets" class="card">K-PAC Sets</a>
        </div>
    </div>
</body>
</html>