# Customer Management System

A Java-based web application for managing customer records, featuring user authentication, CRUD operations, image uploads, validation, search, pagination, and asynchronous interactions using the Fetch API.

## Overview

The Customer Management System provides a centralized interface for managing customer information efficiently. Built with Java Servlets, JSP, and MySQL, the application follows a layered architecture that separates request handling, business logic, database operations, and presentation.

The application uses the JavaScript Fetch API to communicate with Servlets asynchronously, reducing unnecessary full-page reloads and providing a smoother user experience.

## Features

### User Authentication
- User registration and login.
- Session-based user authentication.
- Form validation with inline error messages.
- Asynchronous login and registration using the Fetch API.
- Logout with session invalidation.

### Customer Management
- Add, view, update, and delete customer records.
- Search customers by name, city, and email.
- Case-sensitive customer search.
- Pagination for customer records.
- Asynchronous customer operations without unnecessary full-page reloads.

### Validation
- Client-side and server-side validation.
- Required-field and input-format validation.
- Email format validation.
- Duplicate-email checking.
- Inline validation messages and user-friendly error alerts.

### Image Management
- Upload customer profile images.
- Preview images before submission.
- Display profile images in the customer list.
- Preserve existing images when updating other customer details.
- Store image files separately from the database.

### Additional Features
- Real-time notifications using WebSockets.
- Interactive success, error, and confirmation alerts using SweetAlert2.
- Dynamic customer list updates.
- Form clearing and resetting.

- 
## Screenshots

### Login Page

<img width="1358" height="636" alt="login" src="https://github.com/user-attachments/assets/8bbf9b32-6a14-4f6a-a6b3-042271648f97" />

### Registration Page

<img width="1358" height="636" alt="register" src="https://github.com/user-attachments/assets/378df09a-bd25-4f95-9dc6-02cbce3ce856" />

### Customer List

<img width="1358" height="636" alt="list" src="https://github.com/user-attachments/assets/940a52f9-4d20-4cd8-8c0b-5def7c7726ce" />

### Add Customer / Edit Customer

<img width="1358" height="585" alt="add" src="https://github.com/user-attachments/assets/46881088-d128-485a-9b03-5442e56d8dda" />

### Success Popup

<img width="1358" height="636" alt="popup" src="https://github.com/user-attachments/assets/d39ca6d3-dfda-4f7b-861e-66ea758be3ad" />

### Validation Errors

<img width="1358" height="636" alt="validation" src="https://github.com/user-attachments/assets/e5980da0-be02-4915-89f5-b86de1191758" />


## Technology Stack

| Technology | Purpose |
|---|---|
| Java 21 | Application development |
| Jakarta Servlets | Request handling and controller logic |
| JSP | Dynamic web pages |
| Apache Tomcat 10.1 | Web application server |
| MySQL | Database management |
| JDBC | Database connectivity |
| Maven | Dependency management and project building |
| JavaScript Fetch API | Asynchronous HTTP requests |
| Gson | Java object and JSON conversion |
| HTML5 and CSS3 | Web page structure and styling |
| Bootstrap 5.3 | Responsive UI styling |
| Bootstrap Icons | Interface icons |
| SweetAlert2 | Interactive alerts and confirmations |
| WebSockets | Real-time notifications |

## Application Architecture

The application follows a layered architecture to separate responsibilities and improve maintainability.

```text
CustomerManagementSystem
│
├── controller
│   └── Servlets and HTTP request handling
│
├── service
│   └── Business logic
│
├── dao
│   └── Database operations using JDBC
│
├── model
│   └── Customer and User objects
│
├── validation
│   └── Input validation
│
└── WEB-INF/views
    └── JSP pages
```

### Layer Responsibilities

- **Controller:** Handles HTTP requests, processes form submissions, and returns responses.
- **Service:** Manages business logic and coordinates application operations.
- **DAO:** Performs database operations.
- **Model:** Represents application data.
- **Validation:** Checks user input and provides validation errors.
- **JSP Views:** Display forms, customer records, and other user interface elements.

## AJAX Implementation Using the Fetch API

The application uses the Fetch API to send asynchronous HTTP requests from JavaScript to Servlet endpoints.

This approach allows supported operations to communicate with the server and receive JSON responses without requiring a traditional full-page form submission or navigation.

The general workflow is:

1. The user performs an action.
2. JavaScript intercepts the default browser behavior when necessary.
3. The Fetch API sends a request to the appropriate Servlet.
4. The Servlet processes the request and returns a JSON response.
5. JavaScript processes the response and updates the page.
6. SweetAlert2 displays feedback when appropriate.

This implementation is used for supported operations such as authentication, customer form submissions, deletion, and customer list pagination.

## Database

MySQL is used to store customer and user account information.

Customer records include:

- Customer ID
- Name
- City
- Address
- Phone number
- Email address
- Image path

The database must be configured before running the application. Database connection settings should be updated to match the local development environment.

## Getting Started

### Prerequisites

- JDK 21
- Apache Tomcat 10.1
- MySQL Server
- IntelliJ IDEA or another compatible Java IDE
- Git
- Maven, or the Maven integration provided by the IDE

### 1. Clone the Repository

```bash
git clone <YOUR_REPOSITORY_URL>
cd CustomerManagementSystem
```

Replace `<YOUR_REPOSITORY_URL>` with the actual repository URL.

### 2. Configure the Database

1. Start MySQL Server.
2. Create the required database.
3. Create the necessary tables using the project's SQL schema.
4. Configure the database URL, username, and password in the project's database connection class.

### 3. Configure Image Storage

Configure the customer image upload directory in the application.

Ensure that the directory exists or can be created and that the application has permission to read and write files in it.

### 4. Build the Project

Run the following command from the project root:

```bash
mvn clean package
```

Alternatively, open the project in IntelliJ IDEA and reload the Maven project.

### 5. Run the Application

1. Configure Apache Tomcat 10.1 in your IDE.
2. Deploy the application using the appropriate WAR or exploded WAR artifact.
3. Start the Tomcat server.
4. Open the application using the configured context path.

For example:

```text
http://localhost:8080/CustomerManagementSystem/
```

The actual URL depends on the application's deployment configuration.

## Future Improvements

- Automated unit and integration testing.
- Enhanced security and access control.
- Advanced customer filtering and sorting.
- Improved logging and exception handling.
- Production-ready configuration and deployment.
