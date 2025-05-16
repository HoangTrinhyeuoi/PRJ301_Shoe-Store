<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard UI</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .sidebar {
                background-color: grey;
                color: white;
            }
            .sidebar .nav-link {
                color: white;
                font-weight: bold;
            }
            .table thead {
                background-color: black;
                color: white;
            }
        </style>
    </head>

    <body>
        <nav class="navbar navbar-dark bg-dark navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Dashboard</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/JSP/profile.jsp">Profile</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/JSP/logout.jsp">Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="d-flex">
            <div class="sidebar p-3" style="width: 250px; min-height: 100vh;">
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link" href="dashboard">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="dashboard_Order">Orders</a></li>
                </ul>
            </div>

            <div class="container-fluid p-4">
                <h1 class="mb-4">Dashboard Overview</h1>
                <div class="row">
                    <div class="col-md-3">
                        <div class="card bg-primary text-white mb-3">
                            <div class="card-body">26 New Messages</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-warning text-white mb-3">
                            <div class="card-body">11 New Tasks</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-success text-white mb-3">
                            <div class="card-body">123 New Orders</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-danger text-white mb-3">
                            <div class="card-body">13 New Tickets</div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Order Table</h5>
                    </div>

                    <div class="card-body">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Customer ID</th>
                                    <th>Total Amount</th>
                                    <th>Paid Amount</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${listOrder}" var="o">
                                    <tr>
                                        <td>${o.id}</td>
                                        <td>${o.customerId}</td>
                                        <td>${o.totalAmount}$</td>
                                        <td>${o.paidAmount}$</td>
                                        <td>${o.status}</td>
                                        <td>
                   
                                            <button type="button" class="btn btn-danger" onclick="deleteOrderModal(${o.id})">
                                                Delete
                                            </button>

                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="deleteOrderModal.jsp"></jsp:include>
        <footer class="bg-dark text-white text-center p-3 mt-4">&copy; 2025 Your Website</footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>