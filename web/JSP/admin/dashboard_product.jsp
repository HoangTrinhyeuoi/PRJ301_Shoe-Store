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
                        <h5 class="mb-0">Product Table</h5>
                        <button type="button" 
                                class="btn btn-success" 
                                data-bs-toggle="modal" 
                                data-bs-target="#addProductModal">
                            Add Product
                        </button>
                    </div>


                    <div class="card-body">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th width="10%">Name</th>
                                    <th>Image</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Category</th>
                                    <th>Description</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${listProduct}" var="p">
                                    <tr>
                                        <td>${p.id}</td>
                                        <td>${p.name}</td>
                                        <td>
                                            <img src="${pageContext.request.contextPath}/${p.imageUrl}" width="100" height="100" alt="alt"/>
                                        </td>
                                        <td>${p.stock}</td>
                                        <td>${p.price}$</td>
                                        <td>
                                            <c:forEach items="${listCategory}" var="c">
                                                <c:if test="${c.ID == p.id}">
                                                    ${c.name}
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>${p.description}</td>
                                        <td>
                                            <button type="button" class="btn btn-primary"
                                                    data-toggle="modal" 
                                                    data-target="#editProductModal"
                                                    onclick="editProductModal(this)">
                                                Edit
                                            </button>
                                            <button type="button" class="btn btn-danger" 
                                                    onclick="deleteProductModal(${p.id}, '${p.name}')">
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
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Bắt tất cả nút Edit
                const editButtons = document.querySelectorAll(".edit-product-btn");

                editButtons.forEach(button => {
                    button.addEventListener("click", function () {
                        // Lấy dữ liệu từ thuộc tính data
                        const productId = this.getAttribute("data-id");
                        const productName = this.getAttribute("data-name");
                        const productPrice = this.getAttribute("data-price");
                        const productImage = this.getAttribute("data-image");
                        const productDescription = this.getAttribute("data-description");

                        // Gán vào các input trong modal
                        document.getElementById("editProductId").value = productId;
                        document.getElementById("editProductName").value = productName;
                        document.getElementById("editProductPrice").value = productPrice;
                        document.getElementById("editProductImage").value = productImage;
                        document.getElementById("editProductDescription").value = productDescription;

                        // Mở modal (nếu không tự mở)
                        const editModal = new bootstrap.Modal(document.getElementById('editProductModal'));
                        editModal.show();
                    });
                });
            });
        </script>
        <!-- Add Product Modal (Popup) -->
        <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="admin/product?action=add" method="post" enctype="multipart/form-data">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addProductModalLabel">Add New Product</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="name" class="form-label">Name:</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                                <small class="text-danger d-none" id="nameError">Tên không được để trống</small>
                            </div>

                            <div class="mb-3">
                                <label for="price" class="form-label">Price:</label>
                                <input type="number" class="form-control" id="price" name="price" required>
                                <small class="text-danger d-none" id="priceError">Giá của không được để trống</small>
                            </div>

                            <div class="mb-3">
                                <label for="quantity" class="form-label">Quantity:</label>
                                <input type="number" class="form-control" id="quantity" name="quantity" required>
                                <small class="text-danger d-none" id="quantityError">Số lượng sách không được để trống</small>
                            </div>

                            <div class="mb-3">
                                <label for="category" class="form-label">Category:</label>
                                <select class="form-select" id="category" name="category" required>
                                    <option value="">-- Select Category --</option>
                                    <c:forEach items="${listCategory}" var="c">
                                        <option value="${c.ID}">${c.name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="image" class="form-label">Image (URL):</label>
                                <input type="text" class="form-control" id="image" name="image" placeholder="Enter image link">
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Description:</label>
                                <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Add</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="deleteProductModal.jsp"></jsp:include>
        <footer class="bg-dark text-white text-center p-3 mt-4">&copy; 2025 Your Website</footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body><script>
    document.addEventListener("DOMContentLoaded", function () {
        // Bắt tất cả nút Edit
        const editButtons = document.querySelectorAll(".edit-product-btn");

        editButtons.forEach(button => {
            button.addEventListener("click", function () {
                // Lấy dữ liệu từ thuộc tính data
                const productId = this.getAttribute("data-id");
                const productName = this.getAttribute("data-name");
                const productPrice = this.getAttribute("data-price");
                const productImage = this.getAttribute("data-image");
                const productDescription = this.getAttribute("data-description");

                // Gán vào các input trong modal
                document.getElementById("editProductId").value = productId;
                document.getElementById("editProductName").value = productName;
                document.getElementById("editProductPrice").value = productPrice;
                document.getElementById("editProductImage").value = productImage;
                document.getElementById("editProductDescription").value = productDescription;

                // Mở modal (nếu không tự mở)
                const editModal = new bootstrap.Modal(document.getElementById('editProductModal'));
                editModal.show();
            });
        });
    });
    </script>
</html>
