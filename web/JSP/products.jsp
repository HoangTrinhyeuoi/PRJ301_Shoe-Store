<%@page import="java.util.List"%>
<%@page import="DAO.ProductDAO"%>
<%@page import="Model.Product"%>
<%@page import="DAO.CartDAO"%>
<%@page import="Model.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách sản phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
 /* Reset mặc định và font */
:root {
    --primary-color: #ff6b6b;
    --secondary-color: #4ecdc4;
    --dark-color: #1a1a2e;
    --light-color: #f7f7f7;
    --transition: all 0.3s ease;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    background: var(--light-color);
    font-family: 'Poppins', sans-serif;
    line-height: 1.6;
    color: #333;
}

/* Chatbot Styles - Enhanced */
#chatbot-wrapper {
    position: fixed;
    bottom: 30px;
    right: 30px;
    z-index: 1000;
}

#toggle-chatbot {
    background: linear-gradient(45deg, var(--secondary-color), var(--primary-color));
    color: white;
    border: none;
    padding: 14px 24px;
    border-radius: 30px;
    font-weight: 600;
    cursor: pointer;
    box-shadow: 0 8px 20px rgba(255, 107, 107, 0.4);
    transition: var(--transition);
    font-size: 1rem;
    letter-spacing: 0.5px;
}

#toggle-chatbot:hover {
    transform: translateY(-5px) scale(1.05);
    box-shadow: 0 12px 25px rgba(255, 107, 107, 0.5);
}

#chatbot-container {
    width: 360px;
    background: #fff;
    border-radius: 20px;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
    margin-top: 15px;
    overflow: hidden;
    transition: var(--transition);
    border: 1px solid rgba(255, 107, 107, 0.1);
}

.hidden {
    transform: translateY(30px);
    opacity: 0;
    pointer-events: none;
}

.show {
    transform: translateY(0);
    opacity: 1;
    pointer-events: auto;
}

#chatbot-messages {
    max-height: 400px;
    overflow-y: auto;
    padding: 20px;
    background: #f8fafc;
    border-bottom: 1px solid #eee;
}

#chatbot-messages::-webkit-scrollbar {
    width: 6px;
}

#chatbot-messages::-webkit-scrollbar-thumb {
    background: var(--primary-color);
    border-radius: 10px;
}

#chatbot-messages div {
    background: #fff;
    padding: 12px 18px;
    margin-bottom: 15px;
    border-radius: 15px;
    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
    word-wrap: break-word;
    animation: fadeIn 0.3s ease;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

#chatbot-messages div:nth-child(odd) {
    background: #ffeaea;
    border-top-left-radius: 5px;
    margin-right: 40px;
}

#chatbot-messages div:nth-child(even) {
    background: #e8fbf8;
    border-top-right-radius: 5px;
    margin-left: 40px;
}

#chatbot-messages div b {
    color: var(--primary-color);
    font-weight: 600;
    display: block;
    margin-bottom: 5px;
}

#chatbot-input {
    width: 100%;
    padding: 15px 20px;
    border: none;
    border-top: 1px solid #eee;
    outline: none;
    font-size: 15px;
    background: #fff;
    transition: var(--transition);
}

#chatbot-input:focus {
    background: #ffeaea;
    border-color: var(--primary-color);
}

/* Navbar - Enhanced */
.main-navbar {
    background: var(--dark-color);
    padding: 1.2rem 0;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
}

.navbar-brand {
    font-size: 2rem;
    font-weight: 700;
    color: var(--primary-color) !important;
    text-transform: uppercase;
    letter-spacing: 1.5px;
    transition: var(--transition);
}

.navbar-brand:hover {
    transform: scale(1.05);
    text-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
}

.nav-link {
    color: rgba(255, 255, 255, 0.9) !important;
    font-weight: 500;
    padding: 12px 18px !important;
    transition: var(--transition);
    position: relative;
    font-size: 1.05rem;
}

.nav-link:after {
    content: "";
    position: absolute;
    bottom: 5px;
    left: 0;
    width: 0;
    height: 2px;
    background: var(--primary-color);
    transition: var(--transition);
}

.nav-link:hover:after, .nav-link.active:after {
    width: 100%;
}

.nav-link:hover, .nav-link.active {
    color: #fff !important;
    text-shadow: 0 0 8px rgba(255, 255, 255, 0.5);
}

.cart-icon {
    font-size: 1.5rem;
    position: relative;
    transition: var(--transition);
}

.cart-icon:hover {
    transform: scale(1.1);
}

.cart-badge {
    background: var(--primary-color);
    color: white;
    font-size: 0.8rem;
    font-weight: 600;
    width: 22px;
    height: 22px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    position: absolute;
    top: -8px;
    right: -12px;
    box-shadow: 0 3px 8px rgba(255, 107, 107, 0.5);
    animation: pulse 2s infinite;
}

@keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.1); }
    100% { transform: scale(1); }
}

/* Header - Enhanced */
.page-header {
    background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('../img/adidas_predator.jpg');
    background-size: cover;
    background-position: center;
    color: #fff;
    padding: 4rem 0;
    border-radius: 0 0 35px 35px;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
    margin-bottom: 40px;
    position: relative;
    overflow: hidden;
}

.page-header h1 {
    font-size: 3rem;
    font-weight: 700;
    letter-spacing: 1.5px;
    text-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    position: relative;
}

/* Search Container - Enhanced */
.search-container {
    background: #fff;
    padding: 2.5rem;
    border-radius: 20px;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
    margin-bottom: 3rem;
    transition: var(--transition);
    border: 1px solid rgba(0, 0, 0, 0.05);
}

.search-container:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 30px rgba(0, 0, 0, 0.1);
}

.search-container h2 {
    font-size: 1.8rem;
    font-weight: 600;
    color: var(--dark-color);
    margin-bottom: 1.5rem;
    position: relative;
    padding-bottom: 15px;
}

.search-container h2:after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 80px;
    height: 4px;
    background: var(--primary-color);
    border-radius: 2px;
}

.search-input {
    border: 2px solid #e1e5eb;
    padding: 14px 22px;
    border-radius: 30px 0 0 30px;
    font-size: 1.05rem;
    transition: var(--transition);
    box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
}

.search-input:focus {
    border-color: var(--primary-color);
    box-shadow: 0 0 15px rgba(255, 107, 107, 0.25), inset 0 2px 5px rgba(0, 0, 0, 0);
}

.search-btn {
    background: var(--primary-color);
    padding: 14px 28px;
    border-radius: 0 30px 30px 0;
    font-weight: 600;
    transition: var(--transition);
    font-size: 1.05rem;
    letter-spacing: 0.5px;
    border: none;
    color: white;
}

.search-btn:hover {
    background: var(--dark-color);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
    transform: translateX(3px);
}

/* Sidebar - Enhanced */
.sidebar {
    background: #fff;
    padding: 2.5rem;
    border-radius: 20px;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
    position: sticky;
    top: 30px;
    transition: var(--transition);
    border: 1px solid rgba(0, 0, 0, 0.05);
}

.sidebar:hover {
    box-shadow: 0 12px 30px rgba(0, 0, 0, 0.1);
}

.sidebar h4 {
    font-size: 1.6rem;
    font-weight: 700;
    color: var(--dark-color);
    margin-bottom: 1.8rem;
    position: relative;
    padding-bottom: 15px;
}

.sidebar h4:after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 70px;
    height: 4px;
    background: var(--primary-color);
    border-radius: 2px;
}

.sidebar h5 {
    font-size: 1.3rem;
    font-weight: 600;
    color: #444;
    margin-bottom: 1.2rem;
}

.category-list {
    list-style-type: none;
    padding: 0;
}

.category-list li {
    margin-bottom: 8px;
}

.category-list li a {
    color: #444;
    text-decoration: none;
    padding: 12px 18px;
    display: flex;
    align-items: center;
    border-radius: 12px;
    transition: var(--transition);
    font-weight: 500;
}

.category-list li a:hover {
    background: #ffeaea;
    color: var(--primary-color);
    transform: translateX(8px);
    box-shadow: 0 4px 12px rgba(255, 107, 107, 0.1);
}

.category-list li a i {
    margin-right: 12px;
    color: var(--primary-color);
    transition: var(--transition);
}

.category-list li a:hover i {
    transform: scale(1.2);
}

details {
    margin-bottom: 12px;
}

summary {
    list-style: none;
    cursor: pointer;
    padding: 12px 18px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    transition: var(--transition);
    font-weight: 500;
}

summary::-webkit-details-marker {
    display: none;
}

summary:before {
    content: "\f0fe";
    font-family: "Font Awesome 5 Free";
    font-weight: 900;
    margin-right: 10px;
    color: var(--primary-color);
    transition: var(--transition);
}

details[open] summary:before {
    content: "\f146";
    color: var(--secondary-color);
}

summary:hover {
    background: #ffeaea;
    color: var(--primary-color);
    box-shadow: 0 4px 12px rgba(255, 107, 107, 0.1);
}

summary i {
    margin-right: 12px;
    color: var(--primary-color);
}

/* Product Card - Enhanced */
.card {
    border: none;
    border-radius: 20px;
    overflow: hidden;
    background: #fff;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
    transition: var(--transition);
    height: 100%;
    border: 1px solid rgba(0, 0, 0, 0.05);
    margin-bottom: 30px;
}

.card:hover {
    transform: translateY(-15px);
    box-shadow: 0 18px 35px rgba(0, 0, 0, 0.15);
}

.card-img-container {
    height: 240px;
    background: #f5f7fa;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    position: relative;
}

.card-img-container::after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(to bottom, rgba(0,0,0,0), rgba(0,0,0,0.05));
    opacity: 0;
    transition: all 0.4s ease;
}

.card:hover .card-img-container::after {
    opacity: 1;
}

.card-img-top {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.6s ease;
}

.card:hover .card-img-top {
    transform: scale(1.12);
}

.card-body {
    padding: 1.8rem;
    position: relative;
}

.card-title {
    font-size: 1.25rem;
    font-weight: 700;
    color: var(--dark-color);
    margin-bottom: 1rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    transition: var(--transition);
}

.card:hover .card-title {
    color: var(--primary-color);
}

.card-text {
    color: #666;
    font-size: 0.95rem;
    margin-bottom: 1.2rem;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    line-height: 1.6;
}

.price {
    font-size: 1.4rem;
    font-weight: 700;
    color: var(--primary-color);
    margin-bottom: 1.2rem;
    transition: var(--transition);
}

.card:hover .price {
    transform: scale(1.05);
}

.price small {
    font-size: 0.9rem;
    opacity: 0.7;
}

.btn-detail {
    background: var(--dark-color);
    color: #fff;
    padding: 10px 20px;
    border-radius: 30px;
    font-weight: 600;
    transition: var(--transition);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
}

.btn-detail:hover {
    background: var(--primary-color);
    transform: translateY(-3px);
    box-shadow: 0 8px 20px rgba(255, 107, 107, 0.4);
    color: #fff;
}

.btn-success {
    background: var(--secondary-color);
    border-radius: 50%;
    width: 45px;
    height: 45px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: var(--transition);
    box-shadow: 0 4px 15px rgba(78, 205, 196, 0.3);
    border: none;
}

.btn-success:hover {
    background: var(--primary-color);
    transform: scale(1.15) rotate(10deg);
    box-shadow: 0 8px 20px rgba(255, 107, 107, 0.4);
}

.badge {
    position: absolute;
    top: 15px;
    right: 15px;
    padding: 8px 16px;
    border-radius: 30px;
    font-weight: 600;
    font-size: 0.9rem;
    z-index: 10;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.badge-new {
    background: var(--secondary-color);
}

.badge-sale {
    background: var(--primary-color);
}

/* Result Count */
.result-count {
    background: #ffeaea;
    padding: 12px 20px;
    border-radius: 10px;
    margin-bottom: 25px;
    font-weight: 500;
    border-left: 4px solid var(--primary-color);
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
}

.empty-result {
    background: #fff9f5;
    padding: 25px;
    border-radius: 10px;
    margin-top: 25px;
    text-align: center;
    border-left: 4px solid var(--primary-color);
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
}

.empty-result i {
    color: var(--primary-color);
    font-size: 1.2rem;
}

.empty-result a {
    color: var(--secondary-color);
    font-weight: 600;
    text-decoration: none;
}

.empty-result a:hover {
    text-decoration: underline;
}

/* Footer - Enhanced */
footer {
    background: var(--dark-color);
    color: rgba(255, 255, 255, 0.8);
    padding: 4rem 0 2rem;
    margin-top: 5rem;
    border-radius: 30px 30px 0 0;
    position: relative;
    overflow: hidden;
}

footer::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><path d="M0,0 L100,0 L100,100 L0,100 Z" fill="none" stroke="%23ffffff" stroke-opacity="0.05" stroke-width="1"/></svg>');
    background-size: 20px 20px;
    opacity: 0.5;
}

footer h5 {
    font-size: 1.5rem;
    font-weight: 700;
    margin-bottom: 1.8rem;
    position: relative;
    display: inline-block;
    padding-bottom: 10px;
    color: white;
}

footer h5:after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 40px;
    height: 3px;
    background: var(--primary-color);
    border-radius: 2px;
}

footer p {
    color: rgba(255, 255, 255, 0.8);
    font-size: 1rem;
    margin-bottom: 15px;
}

footer i.fas, footer i.fab {
    margin-right: 10px;
    color: var(--primary-color);
}

footer a {
    color: rgba(255, 255, 255, 0.8);
    text-decoration: none;
    transition: var(--transition);
    display: block;
    margin-bottom: 12px;
    font-size: 1rem;
}

footer a:hover {
    color: #fff;
    padding-left: 8px;
    text-shadow: 0 0 5px rgba(255, 255, 255, 0.5);
}

footer .text-center {
    position: relative;
    z-index: 1;
}

footer .fab {
    font-size: 1.3rem;
    cursor: pointer;
    transition: var(--transition);
}

footer .fab:hover {
    transform: translateY(-5px);
    color: var(--primary-color);
}

footer hr {
    opacity: 0.1;
}

/* Toast Notification - Enhanced */
.toast-container {
    position: fixed;
    bottom: 30px;
    right: 30px;
    z-index: 9999;
}

.custom-toast {
    border-radius: 15px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
    overflow: hidden;
    animation: slideInUp 0.5s ease forwards;
}

@keyframes slideInUp {
    0% {
        opacity: 0;
        transform: translateY(20px);
    }
    100% {
        opacity: 1;
        transform: translateY(0);
    }
}

.toast-header {
    padding: 12px 20px;
    background: #fff;
    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
}

.toast-header strong {
    font-size: 1.1rem;
    font-weight: 600;
}

.toast-body {
    padding: 15px 20px;
    font-size: 1rem;
}

.toast-success {
    background: #d4edda;
    color: #155724;
    border-left: 5px solid var(--secondary-color);
}

.toast-error {
    background: #f8d7da;
    color: #721c24;
    border-left: 5px solid var(--primary-color);
}

/* Scroll to top button */
.scroll-top {
    position: fixed;
    bottom: 30px;
    right: 100px;
    width: 45px;
    height: 45px;
    background: var(--primary-color);
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
    opacity: 0;
    visibility: hidden;
    transition: var(--transition);
    z-index: 999;
}

.scroll-top.show {
    opacity: 1;
    visibility: visible;
}

.scroll-top:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 20px rgba(255, 107, 107, 0.5);
    background: var(--dark-color);
}

/* Dropdown menu enhancement */
.dropdown-menu {
    border: none;
    border-radius: 15px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    padding: 12px 0;
    min-width: 200px;
    animation: dropdown 0.3s ease;
}

@keyframes dropdown {
    from {
        opacity: 0;
        transform: translateY(10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.dropdown-item {
    padding: 10px 20px;
    font-size: 0.95rem;
    transition: var(--transition);
}

.dropdown-item i {
    margin-right: 10px;
    color: var(--primary-color);
}

.dropdown-item:hover, .dropdown-item:focus {
    background-color: rgba(255, 107, 107, 0.1);
    color: var(--primary-color);
    transform: translateX(5px);
}

.dropdown-divider {
    margin: 8px 0;
    opacity: 0.1;
}

/* Enhanced hover effects */
.hover-scale {
    transition: var(--transition);
}

.hover-scale:hover {
    transform: scale(1.05);
}

.hover-shadow {
    transition: var(--transition);
}

.hover-shadow:hover {
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

/* Custom animations */
@keyframes float {
    0% {
        transform: translateY(0px);
    }
    50% {
        transform: translateY(-10px);
    }
    100% {
        transform: translateY(0px);
    }
}

.float-animation {
    animation: float 3s ease-in-out infinite;
}

/* Custom scrollbar for entire page */
::-webkit-scrollbar {
    width: 10px;
}

::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 10px;
}

::-webkit-scrollbar-thumb {
    background: var(--primary-color);
    border-radius: 10px;
}

::-webkit-scrollbar-thumb:hover {
    background: var(--dark-color);
}

/* Responsive adjustments */
@media (max-width: 991px) {
    .sidebar {
        margin-bottom: 30px;
    }
    
    .page-header {
        padding: 3rem 0;
    }
    
    .page-header h1 {
        font-size: 2.5rem;
    }
}

@media (max-width: 767px) {
    .page-header {
        padding: 2.5rem 0;
        border-radius: 0 0 25px 25px;
    }
    
    .page-header h1 {
        font-size: 2rem;
    }
    
    .search-container {
        padding: 1.5rem;
    }
    
    .search-container h2 {
        font-size: 1.5rem;
    }
    
    .card-img-container {
        height: 200px;
    }
    
    footer {
        padding: 3rem 0 1.5rem;
    }
}

@media (max-width: 576px) {
    .page-header h1 {
        font-size: 1.8rem;
    }
    
    .btn-detail {
        padding: 8px 15px;
        font-size: 0.9rem;
    }
    
    .price {
        font-size: 1.2rem;
    }
    
    .card-title {
        font-size: 1.1rem;
    }
    
    #chatbot-container {
        width: 300px;
    }
    
    .custom-toast {
        width: 280px;
    }
}

/* Thêm hiệu ứng khi thêm vào giỏ hàng */
@keyframes shake {
    0% { transform: rotate(0deg); }
    25% { transform: rotate(10deg); }
    50% { transform: rotate(0deg); }
    75% { transform: rotate(-10deg); }
    100% { transform: rotate(0deg); }
}

.shake-animation {
    animation: shake 0.5s ease;
}

/* Hiệu ứng hiển thị sản phẩm */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.card {
    animation: fadeInUp 0.5s ease-out;
}

/* Hiệu ứng khi hover vào nút */
.btn {
    transition: var(--transition);
}

.btn:active {
    transform: scale(0.95);
}

/* Hiệu ứng loading */
.loading {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(255, 255, 255, 0.9);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 9999;
}

.loading-spinner {
    width: 50px;
    height: 50px;
    border: 4px solid rgba(255, 107, 107, 0.3);
    border-radius: 50%;
    border-top-color: var(--primary-color);
    animation: spin 1s linear infinite;
}

@keyframes spin {
    to { transform: rotate(360deg); }
}

/* Form styling */
.form-control {
    border: 2px solid #e1e5eb;
    padding: 12px 18px;
    border-radius: 10px;
    transition: var(--transition);
    box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
}

.form-control:focus {
    border-color: var(--primary-color);
    box-shadow: 0 0 15px rgba(255, 107, 107, 0.2);
}

.form-label {
    font-weight: 600;
    color: var(--dark-color);
    margin-bottom: 8px;
}

.form-select {
    border: 2px solid #e1e5eb;
    padding: 12px 18px;
    border-radius: 10px;
    background-position: right 15px center;
    transition: var(--transition);
}

.form-select:focus {
    border-color: var(--primary-color);
    box-shadow: 0 0 15px rgba(255, 107, 107, 0.2);
}

/* Hiệu ứng khi cuộn trang */
.reveal {
    position: relative;
    opacity: 0;
    transform: translateY(30px);
    transition: all 0.8s ease;
}

.reveal.active {
    opacity: 1;
    transform: translateY(0);
}

/* Màu gradient cho text */
.text-gradient {
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

/* Buttons với hiệu ứng ripple */
.btn-ripple {
    position: relative;
    overflow: hidden;
}

.btn-ripple:after {
    content: "";
    display: block;
    position: absolute;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    pointer-events: none;
    background-image: radial-gradient(circle, #fff 10%, transparent 10.01%);
    background-repeat: no-repeat;
    background-position: 50%;
    transform: scale(10, 10);
    opacity: 0;
    transition: transform .5s, opacity 1s;
}

.btn-ripple:active:after {
    transform: scale(0, 0);
    opacity: .3;
    transition: 0s;
}

/* Hiệu ứng hover cho ảnh sản phẩm */
.hover-zoom {
    overflow: hidden;
    position: relative;
}

.hover-zoom img {
    transition: var(--transition);
}

.hover-zoom:hover img {
    transform: scale(1.1);
}

/* Badge hiển thị số lượng sản phẩm */
.product-count {
    position: absolute;
    top: 10px;
    left: 10px;
    background: rgba(255, 107, 107, 0.8);
    color: white;
    padding: 5px 10px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: bold;
    z-index: 10;
}

/* Animation cho các phần tử khi tải trang */
.animated {
    animation-duration: 1s;
    animation-fill-mode: both;
}

.animate__delay-1 {
    animation-delay: 0.2s;
}

.animate__delay-2 {
    animation-delay: 0.4s;
}

.animate__delay-3 {
    animation-delay: 0.6s;
}

.animate__delay-4 {
    animation-delay: 0.8s;
}

@keyframes fadeInLeft {
    from {
        opacity: 0;
        transform: translateX(-30px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

.fadeInLeft {
    animation-name: fadeInLeft;
}

@keyframes fadeInRight {
    from {
        opacity: 0;
        transform: translateX(30px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

.fadeInRight {
    animation-name: fadeInRight;
}

/* Thêm hiệu ứng cho nút thêm vào giỏ hàng */
.btn-add-to-cart {
    position: relative;
    overflow: hidden;
    border-radius: 50%;
    width: 45px;
    height: 45px;
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: var(--secondary-color);
    color: white;
    border: none;
    transition: var(--transition);
}

.btn-add-to-cart:before {
    content: '';
    position: absolute;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    background: rgba(255, 255, 255, 0.3);
    border-radius: 50%;
    transform: scale(0);
    transition: 0.3s ease-in-out;
}

.btn-add-to-cart:hover:before {
    transform: scale(1.5);
    opacity: 0;
}

.btn-add-to-cart:hover {
    background-color: var(--primary-color);
    transform: scale(1.1);
    box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
}

/* Thiết kế thông báo khi thêm vào giỏ hàng */
.cart-notification {
    position: fixed;
    top: 20px;
    right: 20px;
    background-color: var(--dark-color);
    color: white;
    padding: 15px 20px;
    border-radius: 10px;
    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
    z-index: 9999;
    display: flex;
    align-items: center;
    transform: translateX(100%);
    opacity: 0;
    transition: all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
}

.cart-notification.show {
    transform: translateX(0);
    opacity: 1;
}

.cart-notification i {
    font-size: 1.5rem;
    color: var(--primary-color);
    margin-right: 15px;
}

/* Thiết kế hiệu ứng hover cho danh mục */
.category-item {
    border-radius: 15px;
    overflow: hidden;
    position: relative;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    transition: var(--transition);
    margin-bottom: 20px;
    height: 200px;
}

.category-item img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: var(--transition);
}

.category-item:hover img {
    transform: scale(1.1);
}

.category-item .category-overlay {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background: linear-gradient(to top, var(--dark-color), transparent);
    padding: 20px;
    color: white;
    transform: translateY(0);
    transition: var(--transition);
}

.category-item:hover .category-overlay {
    transform: translateY(-10px);
}

.category-item .category-title {
    font-weight: 600;
    margin: 0;
}

.category-item .category-count {
    font-size: 0.9rem;
    opacity: 0.8;
}

/* Custom styles for pagination */
.pagination {
    display: flex;
    justify-content: center;
    margin-top: 40px;
}

.pagination .page-item .page-link {
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 5px;
    border-radius: 50%;
    border: none;
    background-color: #f0f0f0;
    color: var(--dark-color);
    font-weight: 600;
    transition: var(--transition);
}

.pagination .page-item.active .page-link {
    background-color: var(--primary-color);
    color: white;
    box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
}

.pagination .page-item .page-link:hover {
    background-color: var(--secondary-color);
    color: white;
    transform: scale(1.1);
}

/* Giỏ hàng nổi bật */
.cart-highlight {
    animation: highlightCart 1s ease;
}

@keyframes highlightCart {
    0%, 100% {
        transform: scale(1);
    }
    50% {
        transform: scale(1.2);
    }
}
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg main-navbar">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/JSP/index.jsp">
                <i class="fas fa-shoe-prints me-2"></i>ShoeStore
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/JSP/index.jsp">
                            <i class="fas fa-home me-1"></i>Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/JSP/products.jsp">
                            <i class="fas fa-store me-1"></i>Sản phẩm
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                           data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-list me-1"></i>Danh mục
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/JSP/products.jsp?category=1">Sneakers</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/JSP/products.jsp?category=2">Football</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/JSP/products.jsp?category=3">Running</a></li>
                        </ul>
                    </li>
                </ul>
                
                <ul class="navbar-nav ms-auto">
                    <!-- Giỏ hàng -->
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/cart-page">
                            <div class="cart-icon">
                                <i class="fas fa-shopping-cart"></i>
                                <% 
                                    // Lấy số lượng sản phẩm trong giỏ hàng nếu đã đăng nhập
                                    Customer customer = (Customer) session.getAttribute("customer");
                                    if (customer != null) {
                                        CartDAO cartDAO = new CartDAO();
                                        int cartCount = cartDAO.getCartItemCount(customer.getCustomerId());
                                        if (cartCount > 0) {
                                %>
                                    <span class="cart-badge"><%= cartCount %></span>
                                <% 
                                        }
                                    }
                                %>
                            </div>
                        </a>
                    </li>
                    
                   <% if (customer != null) { %>
                        <!-- Đã đăng nhập -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                               data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user-circle me-1"></i><%= customer.getFullName() %>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/JSP/profile.jsp">
                                    <i class="fas fa-user me-2"></i>Tài khoản
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/cart-page">
                                    <i class="fas fa-shopping-cart me-2"></i>Giỏ hàng
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders">
                                    <i class="fas fa-file-invoice me-2"></i>Đơn hàng
                                </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                    <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                                </a></li>
                            </ul>
                        </li>
                    <% } else { %>
                        <!-- Chưa đăng nhập -->
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                <i class="fas fa-sign-in-alt me-1"></i>Đăng nhập
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/register">
                                <i class="fas fa-user-plus me-1"></i>Đăng ký
                            </a>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <header class="page-header">
        <div class="container">
            <h1 class="text-center mb-0"><i class="fas fa-store me-2"></i>Danh Sách Sản Phẩm</h1>
        </div>
    </header>

    <div class="container">
        <div class="row">
            <!-- Left Sidebar -->
            <div class="col-lg-3 mb-4">
                <div class="sidebar">
                    <h4><i class="fas fa-filter me-2"></i>Bộ lọc</h4>
                    
                    <!-- Categories -->
                    <div class="mb-4">
                        <h5 class="fw-bold mb-3">Danh mục</h5>
                        <ul class="category-list">
                            <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=all"><i class="fas fa-th-large"></i>Tất cả sản phẩm</a></li>
                            
                            <!-- Sneaker Category -->
                            <li>
                                <details>
                                    <summary><i class="fas fa-shoe-prints"></i>Sneaker</summary>
                                    <ul class="category-list" style="margin-left: 20px; margin-top: 10px;">
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=1&brand=adidas"><i class="fas fa-angle-right"></i>Adidas</a></li>
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=1&brand=nike"><i class="fas fa-angle-right"></i>Nike</a></li>
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=1&brand=puma"><i class="fas fa-angle-right"></i>Puma</a></li>
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=1"><i class="fas fa-angle-right"></i>Tất cả Sneaker</a></li>
                                    </ul>
                                </details>
                            </li>
                            
                            <!-- Football Category -->
                            <li>
                                <details>
                                    <summary><i class="fas fa-futbol"></i>Football</summary>
                                    <ul class="category-list" style="margin-left: 20px; margin-top: 10px;">
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=2&brand=adidas"><i class="fas fa-angle-right"></i>Adidas</a></li>
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=2&brand=nike"><i class="fas fa-angle-right"></i>Nike</a></li>
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=2&brand=puma"><i class="fas fa-angle-right"></i>Puma</a></li>
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=2"><i class="fas fa-angle-right"></i>Tất cả Football</a></li>
                                    </ul>
                                </details>
                            </li>
                            
                            <!-- Running Category -->
                            <li>
                                <details>
                                    <summary><i class="fas fa-running"></i>Running</summary>
                                    <ul class="category-list" style="margin-left: 20px; margin-top: 10px;">
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=3&brand=adidas"><i class="fas fa-angle-right"></i>Adidas</a></li>
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=3&brand=nike"><i class="fas fa-angle-right"></i>Nike</a></li>
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=3&brand=puma"><i class="fas fa-angle-right"></i>Puma</a></li>
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=3"><i class="fas fa-angle-right"></i>Tất cả Running</a></li>
                                    </ul>
                                </details>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-lg-9">
                <!-- Search Container -->
                <div class="search-container">
                    <h2 class="text-center mb-4">Tìm kiếm sản phẩm</h2>
                    <form action="${pageContext.request.contextPath}/JSP/products.jsp" method="GET">
                        <div class="input-group">
                            <% 
                                String keyword = request.getParameter("keyword");
                                String searchValue = (keyword != null) ? keyword.trim() : "";
                            %>
                            <input type="text" name="keyword" class="form-control search-input" 
                                   placeholder="Nhập tên sản phẩm cần tìm..." 
                                   value="<%= searchValue %>">
                            <button type="submit" class="btn search-btn text-white">
                                <i class="fas fa-search me-2"></i>Tìm kiếm
                            </button>
                        </div>
                    </form>
                </div>

                <%
                    ProductDAO productDAO = new ProductDAO();
                    List<Product> products;

                    String category = request.getParameter("category");
                    String brand = request.getParameter("brand");


                    if (keyword != null && !keyword.trim().isEmpty()) {
                        // Tìm kiếm theo từ khóa
                        products = productDAO.searchProducts(keyword);
                    } else if (category != null && !category.equals("all") && brand != null) {
                        // Lọc theo cả thể loại và thương hiệu
                        products = productDAO.filterProductsByCategoryAndBrand(category, brand);
                    } else if (category != null && !category.equals("all")) {
                        // Lọc chỉ theo thể loại
                        products = productDAO.filterProductsByCategory(category);
                    } else if (brand != null) {
                        // Lọc chỉ theo thương hiệu
                        products = productDAO.filterProductsByBrand(brand);
                    } else {
                        // Hiển thị tất cả sản phẩm
                        products = productDAO.searchProducts("");
                    }
                %>
                <% if (products != null && !products.isEmpty()) { %>
                    <div class="result-count">
                        <i class="fas fa-info-circle me-2"></i>
                        <% if (keyword != null && !keyword.trim().isEmpty()) { %>
                            Tìm thấy <%= products.size() %> sản phẩm cho từ khóa "<%= keyword %>"
                        <% } else { %>
                            Hiển thị tất cả <%= products.size() %> sản phẩm
                        <% } %>
                    </div>
                    
                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                        <% for (Product p : products) { %>
                            <div class="col">
                                <div class="card h-100 position-relative">
                                    <% if (p.getId() % 5 == 0) { %>
                                        <span class="badge badge-new text-white">Mới</span>
                                    <% } else if (p.getId() % 7 == 0) { %>
                                        <span class="badge badge-sale text-white">Giảm giá</span>
                                    <% } %>
                                    
                                    <div class="card-img-container">
                                        <img src="../<%= p.getImageUrl() %>" class="card-img-top" alt="<%= p.getName() %>">
                                    </div>
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title" title="<%= p.getName() %>"><%= p.getName() %></h5>
                                        <p class="card-text flex-grow-1"><%= p.getDescription() %></p>
                                        <div class="price text-danger">
                                            <i class="fas fa-tag me-2"></i><%= String.format("%,.0f", p.getPrice()) %> VND
                                            <% if (p.getId() % 7 == 0) { %>
                                                <small class="text-decoration-line-through text-muted ms-2">
                                                    <%= String.format("%,.0f", p.getPrice() * 1.2) %> VND
                                                </small>
                                            <% } %>
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <a href="${pageContext.request.contextPath}/JSP/productDetail.jsp?id=<%= p.getId() %>" class="btn btn-detail text-white">
                                                <i class="fas fa-eye me-2"></i>Xem chi tiết
                                            </a>
                                            <!-- Sửa đổi ở đây: Thay đổi nút thêm vào giỏ hàng -->
                                            <% if (session.getAttribute("customer") == null) { %>
                                                <!-- Nếu chưa đăng nhập, chuyển trực tiếp đến trang đăng nhập -->
                                                <a href="${pageContext.request.contextPath}/login?redirect=JSP/products.jsp" class="btn btn-success rounded-circle">
                                                    <i class="fas fa-cart-plus"></i>
                                                </a>
                                            <% } else { %>
                                                <!-- Nếu đã đăng nhập, sử dụng JavaScript để thêm vào giỏ hàng -->
                                                <button onclick="addToCart(<%= p.getId() %>)" class="btn btn-success rounded-circle">
                                                    <i class="fas fa-cart-plus"></i>
                                                </button>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <% } %>
                    </div>
                <% } else { %>
                    <div class="empty-result">
                        <i class="fas fa-exclamation-circle me-2"></i>Không tìm thấy sản phẩm nào phù hợp.
                        <% if (keyword != null && !keyword.trim().isEmpty()) { %>
                            Vui lòng thử lại với từ khóa khác hoặc <a href="products.jsp">xem tất cả sản phẩm</a>.
                        <% } %>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
            <div id="chatbot-wrapper">
            <button id="toggle-chatbot">Trợ Lý</button>
            <div id="chatbot-container" class="hidden">
                <div id="chatbot-messages"></div>
                <input type="text" id="chatbot-input" placeholder="Nhập tin nhắn..." />
            </div>
    </div>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <h5 class="mb-3">Về chúng tôi</h5>
                    <p>ShoeStore - Cửa hàng giày chính hãng với đa dạng mẫu mã, phong cách và thương hiệu hàng đầu.</p>
                </div>
                <div class="col-md-4 mb-4">
                    <h5 class="mb-3">Liên hệ</h5>
                    <p><i class="fas fa-map-marker-alt me-2"></i>123 Đường ABC, Quận XYZ, TP. HCM</p>
                    <p><i class="fas fa-phone me-2"></i>(+84) 123 456 789</p>
                    <p><i class="fas fa-envelope me-2"></i>contact@shoestore.com</p>
                </div>
                <div class="col-md-4 mb-4">
                    <h5 class="mb-3">Liên kết nhanh</h5>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/index.jsp" class="text-white text-decoration-none">Trang chủ</a></li>
                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp" class="text-white text-decoration-none">Sản phẩm</a></li>
                        <li><a href="${pageContext.request.contextPath}/cart-page" class="text-white text-decoration-none">Giỏ hàng</a></li>
                        <li><a href="#" class="text-white text-decoration-none">Chính sách</a></li>
                    </ul>
                </div>
            </div>
            <hr class="my-4 bg-light">
            <div class="text-center">
                <p class="mb-2">&copy; 2025 ShoeStore. Tất cả quyền được bảo lưu.</p>
                <div>
                    <i class="fab fa-facebook mx-2"></i>
                    <i class="fab fa-instagram mx-2"></i>
                    <i class="fab fa-twitter mx-2"></i>
                    <i class="fab fa-youtube mx-2"></i>
                </div>
            </div>
        </div>
    </footer>
    
    <!-- Toast thông báo -->
    <div class="toast-container">
        <div class="toast custom-toast" id="notificationToast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <strong class="me-auto" id="toastTitle">Thông báo</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body" id="toastMessage"></div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Khai báo biến toast global để tránh khởi tạo lại
    let toastElement;
    let toast;

    document.addEventListener('DOMContentLoaded', function() {
        // Khởi tạo toast thông báo
        toastElement = document.getElementById('notificationToast');
        if (toastElement) {
            toast = new bootstrap.Toast(toastElement, { delay: 3000 });
        }
        
        // Lưu trạng thái đăng nhập vào biến JavaScript
        window.isLoggedIn = <%= (session.getAttribute("customer") != null) ? "true" : "false" %>;
        
        // Xử lý nút Scroll to top
        window.onscroll = function() {
            if (document.body.scrollTop > 300 || document.documentElement.scrollTop > 300) {
                document.getElementById("scrollTop").classList.add("show");
            } else {
                document.getElementById("scrollTop").classList.remove("show");
            }
        };

        document.getElementById("scrollTop").addEventListener("click", function() {
            window.scrollTo({
                top: 0,
                behavior: "smooth"
            });
        });
    });

    // Hàm hiển thị thông báo
    function showNotification(title, message, isSuccess) {
        if (!toastElement) {
            toastElement = document.getElementById('notificationToast');
            toast = new bootstrap.Toast(toastElement, { delay: 3000 });
        }
        
        document.getElementById('toastTitle').innerText = title;
        document.getElementById('toastMessage').innerText = message;
        
        // Thêm class tương ứng
        toastElement.classList.remove('toast-success', 'toast-error');
        if (isSuccess) {
            toastElement.classList.add('toast-success');
        } else {
            toastElement.classList.add('toast-error');
        }
        
        // Hiển thị toast
        toast.show();
    }
    
    // Hàm thêm vào giỏ hàng với hiệu ứng đẹp mắt
    // Hàm thêm vào giỏ hàng với hiệu ứng đẹp mắt
function addToCart(productId) {
    // Nút thêm vào giỏ
    const addButton = event.currentTarget;
    const originalHTML = addButton.innerHTML;
    
    // Vô hiệu hóa nút trong khi đang xử lý
    addButton.disabled = true;
    addButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
    
    <% if (session.getAttribute("customer") == null) { %>
        // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
        window.location.href = "${pageContext.request.contextPath}/login?redirect=JSP/products.jsp";
    <% } else { %>
        console.log("Thêm sản phẩm vào giỏ: ID=" + productId + ", Quantity=1");
        
        // Sử dụng URLSearchParams
        const params = new URLSearchParams();
        params.append('action', 'add');
        params.append('productId', productId);
        params.append('quantity', 1); // Mặc định thêm số lượng 1 từ trang danh sách
        
        // Gửi yêu cầu thêm vào giỏ hàng
        fetch('${pageContext.request.contextPath}/cart', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: params
        })
        .then(response => {
            console.log("Response status:", response.status);
            return response.text().then(text => {
                console.log("Raw response:", text);
                try {
                    return JSON.parse(text);
                } catch (e) {
                    console.error("Error parsing JSON:", e);
                    return {
                        status: "error",
                        message: "Lỗi khi xử lý phản hồi từ server: " + e.message
                    };
                }
            });
        })
        .then(data => {
            console.log("Processed data:", data);
            
            // Hiển thị thông báo
            showNotification(
                data.status === 'success' ? 'Thành công' : 'Lỗi',
                data.message || "Không nhận được phản hồi chi tiết",
                data.status === 'success'
            );
            
            // Hiệu ứng rung giỏ hàng nếu thành công
            if (data.status === 'success') {
                let cartIcon = document.querySelector('.cart-icon');
                cartIcon.classList.add('shake-animation');
                setTimeout(() => {
                    cartIcon.classList.remove('shake-animation');
                }, 500);
                
                // Tải lại trang sau 1 giây để cập nhật số lượng giỏ hàng
                setTimeout(() => {
                    window.location.reload();
                }, 1000);
            }
            
            // Kích hoạt lại nút
            addButton.disabled = false;
            addButton.innerHTML = originalHTML;
        })
        .catch(error => {
            console.error('Error:', error);
            showNotification('Lỗi', 'Đã xảy ra lỗi khi thêm vào giỏ hàng: ' + error.message, false);
            
            // Kích hoạt lại nút
            addButton.disabled = false;
            addButton.innerHTML = originalHTML;
        });
    <% } %>
}
    // Hàm cập nhật số lượng trong giỏ hàng
    function updateCartCount(count) {
        let cartBadge = document.querySelector('.cart-badge');
        if (count > 0) {
            if (cartBadge) {
                cartBadge.textContent = count;
            } else {
                let cartIcon = document.querySelector('.cart-icon');
                cartBadge = document.createElement('span');
                cartBadge.className = 'cart-badge';
                cartBadge.textContent = count;
                cartIcon.appendChild(cartBadge);
            }
        } else if (cartBadge) {
            cartBadge.remove();
        }
    }
    
    // Xử lý chatbot
    document.getElementById("toggle-chatbot").addEventListener("click", function () {
        let chatbot = document.getElementById("chatbot-container");
        chatbot.classList.toggle("hidden");
        chatbot.classList.toggle("show");
    });
    
    function sendMessage() {
        let inputField = document.getElementById("chatbot-input");
        let chatbox = document.getElementById("chatbot-messages");
        console.log("Chatbox element:", chatbox);
        let input = inputField.value.trim();

        if (!input) return; // Nếu input rỗng thì không gửi

        // Hiển thị tin nhắn của người dùng
        let userMessageDiv = document.createElement("div");
        userMessageDiv.innerHTML = `<b>Bạn: </b>`;
        userMessageDiv.appendChild(document.createTextNode(input));
        chatbox.appendChild(userMessageDiv);

        // Xóa nội dung input sau khi gửi
        inputField.value = "";

        // Gọi API
        fetch("/Group_Assignment/chatbot", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ message: input })
        })
        .then(response => {
            console.log("Raw API Response:", response);
            return response.json();
        })
        .then(data => {
            console.log("Parsed API Data:", data);
            if (data.reply) {
                console.log("Bot Reply:", data.reply);
                let botMessageDiv = document.createElement("div");
                botMessageDiv.innerHTML = `<b>Bot: </b>`;
                botMessageDiv.appendChild(document.createTextNode(data.reply));
                chatbox.appendChild(botMessageDiv);
            } else {
                console.error("No reply found in API response");
                let botErrorMessageDiv = document.createElement("div");
                botErrorMessageDiv.innerHTML = `<b>Bot: </b>Không nhận được phản hồi từ AI.`;
                chatbox.appendChild(botErrorMessageDiv);
            }
            // Tự động cuộn xuống cuối hộp thoại
            chatbox.scrollTop = chatbox.scrollHeight;
        })
        .catch(error => {
            console.error("Lỗi:", error);
            let botErrorMessageDiv = document.createElement("div");
            botErrorMessageDiv.innerHTML = `<b>Bot: </b>Đã xảy ra lỗi khi kết nối với AI.`;
            chatbox.appendChild(botErrorMessageDiv);
            chatbox.scrollTop = chatbox.scrollHeight;
        });
    }

    // Thêm sự kiện nhấn Enter
    document.getElementById("chatbot-input").addEventListener("keydown", function (event) {
        if (event.key === "Enter") {
            sendMessage();
        }
    });
</script>
   