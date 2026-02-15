## 🛒 Inventory Management System – Java EE CRUD Application
# 📌 Overview

This project is a full-stack Java EE CRUD Web Application developed using Servlets, JSP, JDBC, and MySQL.
It provides a complete inventory management system with secure authentication, session handling, and user account management.

The application follows MVC architecture and demonstrates best practices in backend development, database interaction, and secure session handling.

# 🚀 Features
🔹 Item Management (CRUD)

Add new items

Update existing items

Soft delete items (removed from screen only)

View all items

Front-end validation for:

Name

Price (supports decimal values)

Total Number

# 🔹 Smart Validations

Prevent duplicate item names (with popup message)

Success popup messages for:

Item added successfully

Item updated successfully

Item deleted successfully

Proper error handling and flash messages using session attributes

# 🔹 Security Enhancements

Prevent SQL Injection using PreparedStatement

Refactored controller logic to avoid code duplication

Clear understanding and implementation of:

RequestDispatcher.forward()

response.sendRedirect()

# 🔹 Authentication System

User Signup

User Login

Email uniqueness constraint

Login validation with error message:

"Invalid username or password"

# 🔹 Session & Cookies Management

Session-based authentication

Logout functionality:

Invalidates session

Removes cookies

Redirects to login page

Logout button visible only when user is logged in

# 🔹 Account Management (Additional Features Implemented)

Change Password functionality

Delete Account functionality

Secure password update handling

Flash message system for account actions

# 🏗️ Technologies Used

Java EE (Servlet & JSP)

JDBC

MySQL

HTML5

CSS3

JavaScript

Apache Tomcat

# 🗂️ Project Structure
├── controller
│   ├── ItemsController.java
│   ├── UserController.java
│
├── model
│   ├── Items.java
│   ├── Users.java
│
├── service
│   ├── ItemsService.java
│   ├── UsersService.java
│
├── view
│   ├── login.jsp
│   ├── signup.jsp
│   ├── load-items.jsp
│   ├── updateItems.jsp
│
├── utils
│   ├── DBConnection.java

🛠️ Database Schema
ITEMS Table

id (Primary Key)

name (Unique)

price (Decimal)

total_number

USERS Table

id (Primary Key)

name

email (Unique)

password

# 🔐 Authentication Flow
Login

Valid credentials → Redirect to main page

Invalid credentials → Redirect to login page with error message

Signup

Valid data → Redirect to login/main page

Duplicate email → Show validation message

Logout

Session invalidated

Cookies removed

User redirected to login page

# 🧠 Key Concepts Applied

MVC Design Pattern

Session Management

Cookie Handling

Flash Messaging System

PreparedStatement for secure queries

Soft Delete Pattern

Form Validation (Client-side & Server-side)

📷 UI Highlights

Clean and responsive UI

Dynamic flash messages

Toggle side panel for:

Change Password

Change Username

Logout

Delete Account

# ✅ Testing

The application has been tested for:

CRUD operations

Duplicate handling

Authentication validation

Session expiration

Error handling
