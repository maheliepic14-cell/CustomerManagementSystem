<%@ page import="java.util.List" %>
<%@ page import="com.customer.customermanagementsystem.model.Customer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    //Retrieve customer list from request.
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
    //Receiving current page and total page from the request
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
%>
<%
    String keyword = request.getParameter("keyword");
    if(keyword == null){
        keyword = "";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Customer Management</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>

<body style="
        margin:0;
        min-height:100vh;
        background-image:url('https://images.pexels.com/photos/26628057/pexels-photo-26628057.jpeg');
        background-size:cover;
        background-position:center;
        background-repeat:no-repeat;
        font-family:'Segoe UI',sans-serif;
        position:relative;
">

<div id="notification-container"></div>

<!-- Dark Overlay -->
<div style="
        position:fixed;
        inset:0;
        background:rgba(0,0,0,0.72);
"></div>

<div class="container py-4"
     style="position:relative; z-index:2;">

    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">

        <div>

            <h2 style="
                color:white;
                font-weight:300;
                margin-bottom:4px;
            ">
                Customer
                <span style="color:#c6a57a;">
                    Management
                </span>
            </h2>

            <small style="color:#9ea5af;">
                Manage your customer records
            </small>

        </div>

        <div class="d-flex gap-2">

            <!-- Add Customer -->
            <a href="${pageContext.request.contextPath}/customer-form"
               class="btn"
               style="
                    background:#4a4f58;
                    color:white;
                    border:none;
                    border-radius:10px;
                    padding:10px 18px;
               ">
                <i class="bi bi-plus-circle me-1"></i>
                Add Customer
            </a>

            <!-- Logout -->
            <a id="logoutButton" href="${pageContext.request.contextPath}/logout"
               class="btn"
               style="
                    background:#c84f4f;
                    color:white;
                    border:none;
                    border-radius:10px;
                    padding:10px 18px;
               ">
                <i class="bi bi-box-arrow-right me-1"></i>
                Logout
            </a>

        </div>

    </div>

    <!-- Glass Card -->
    <div style="
            background:rgba(15,18,24,0.55);

            backdrop-filter:blur(28px);
            -webkit-backdrop-filter:blur(28px);

            border:1px solid rgba(255,255,255,0.05);

            border-radius:18px;

            padding:24px;

            box-shadow:
            0 20px 40px rgba(0,0,0,0.45),
            inset 0 1px 0 rgba(255,255,255,0.05);
    ">

        <!-- Success Message -->
        <%
            String success = (String) session.getAttribute("success");

            if(success != null){
        %>

        <script>
            document.addEventListener("DOMContentLoaded", function () {

                Swal.fire({
                    icon: "success",
                    title: "Success",
                    text: "<%= success %>",
                    timer: 2000,
                    showConfirmButton: false
                });

            });
        </script>

        <%
                session.removeAttribute("success");
            }
        %>


        <!-- Search -->
        <form id="searchForm" class="mb-4">

            <div class="row g-2">

                <div class="col-md-9">

                    <input
                            type="text"
                            id="keyword"
                            name="keyword"
                            class="form-control"
                            placeholder="Search by name, city or email"
                            value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>"

                            style="
                                background:rgba(255,255,255,0.05);
                                border:1px solid rgba(255,255,255,0.08);
                                color:white;
                                height:48px;
                            ">
                </div>

                <div class="col-md-2 d-grid">

                    <button
                            type="submit"
                            class="btn"
                            style="
                                background:#3c414b;
                                color:white;
                                border:none;
                            ">
                        <i class="bi bi-search me-1"></i>
                        Search
                    </button>

                </div>

                <div class="col-md-1 d-grid">
                    <button type="button" id="clearButton" class="btn"
                            style=" background:transparent; color:#c0c7d0; border:1px solid #58606b;">
                        Clear
                    </button>

                </div>

            </div>

        </form>

        <!-- Table -->
        <div class="table-responsive">

            <table class="table align-middle mb-0"
                   style="
                        --bs-table-bg: transparent;
                        --bs-table-color: inherit;
                   ">

                <thead>

                <tr style="
                    border-bottom:1px solid rgba(255,255,255,0.08);
                ">

                    <th style="color:#bcc3cd;font-weight:600;">
                        ID
                    </th>

                    <th style="color:#bcc3cd;font-weight:600;">
                        Profile
                    </th>

                    <th style="color:#bcc3cd;font-weight:600;">
                        Name
                    </th>

                    <th style="color:#bcc3cd;font-weight:600;">
                        City
                    </th>

                    <th style="color:#bcc3cd;font-weight:600;">
                        Phone
                    </th>

                    <th style="color:#bcc3cd;font-weight:600;">
                        Email
                    </th>

                    <th style="color:#bcc3cd;font-weight:600;">
                        Actions
                    </th>

                </tr>

                </thead>

                <tbody id="customerTableBody">

                <%
                    if(customers != null){

                        for(Customer customer : customers){
                %>

                <tr style="
                    border-bottom:1px solid rgba(255,255,255,0.04);
                ">

                    <td style="color:white;">
                        <%= customer.getCustomerId() %>
                    </td>

                    <td>
                        <% if (customer.getImagePath() != null && !customer.getImagePath().isEmpty()) {%>

                        <img
                        src="${pageContext.request.contextPath}/image?file=<%= customer.getImagePath() %>"
                        width="50"
                        height="50"
                        style="object-fit: cover; border-radius: 50%; border: 1px solid rgba(255,255,255,0.15)">

                        <% } else { %>
                        <div style="
                        width:50px;
                        height:50px;
                        border-radius:50%;
                        background:rgba(255,255,255,0.05);
                        display:flex;
                        align-items:center;
                        justify-content:center;
                        color:#9ea5af;">

                            <i class="bi bi-person"></i>

                        </div>

                        <%}%>
                    </td>

                    <td style="color:white;">
                        <%= customer.getName() %>
                    </td>

                    <td style="color:white;">
                        <%= customer.getCity() %>
                    </td>

                    <td style="color:white;">
                        <%= customer.getPhone() %>
                    </td>

                    <td style="color:white;">
                        <%= customer.getEmail() %>
                    </td>

                    <td>

                        <!-- Edit Button-->
                        <a href="${pageContext.request.contextPath}/edit-customer?id=<%= customer.getCustomerId() %>" class="me-3"
                           style=" color:#9aa5b3; text-decoration:none; font-size:18px;">
                            <i class="bi bi-pencil-square"></i>
                        </a>

                        <!-- Delete -->
                        <a href="${pageContext.request.contextPath}/delete-customer?id=<%= customer.getCustomerId() %>&clientId="
                           class="btn btn-danger btn-sm delete-btn"

                           style="
                                color:#d36b6b;
                                text-decoration:none;
                                font-size:18px;
                           ">
                            <i class="bi bi-trash"></i>
                        </a>
                    </td>

                </tr>

                <%
                        }
                    }
                %>

                </tbody>

            </table>

        </div>



                    </li>

                </ul>

            </nav>

        </div>

    <% if (totalPages != null && totalPages > 1){ %>

        <div class="d-flex justify-content-center mt-4">

            <nav>
                <ul class="pagination mb-0" id="pagination">

                    <li class="page-item <%= currentPage == 1 ? "disabled" : "" %>">
                        <a class="page-link"
                           href="javascript:void(0);"
                           onclick="loadCustomers(<%= currentPage - 1 %>)">
                        Previous
                        </a>
                    </li>

                    <!-- Page Numbers Generation -->

                    <%-- Loop through all pages and create a pagination link for each page number --%>
                        <% for (int i = 1; i <= totalPages; i++) { %>

                    <li class="page-item <%= i == currentPage ? "active" : "" %>">
                        <a class="page-link"
                           href="javascript:void(0);"
                           onclick="loadCustomers(<%= i %>)">
                            <%= i %>
                        </a>
                    </li>
                        <% } %>

                    <li class="page-item <%= currentPage.equals(totalPages) ? "disabled" : "" %>">

                        <a class="page-link"
                           href="javascript:void(0);"
                           onclick="loadCustomers(<%= currentPage + 1 %>)">
                            Next
                        </a>
                    </li>
                </ul>
            </nav>
        </div>

    <% } %>

        <!-- Empty State -->
        <%
            if(customers == null || customers.isEmpty()){
        %>

        <div class="text-center py-5">

            <i class="bi bi-people"
               style="
                    font-size:50px;
                    color:#c6a57a;
               ">
            </i>

            <h5 class="mt-3 text-light">
                No Customers Found
            </h5>

            <p style="color:#9ea5af;">
                Add your first customer to get started.
            </p>

        </div>

        <%
            }
        %>

    </div>

</div>

<style>

    .pagination{
        gap:8px;
    }

    .pagination .page-link{
        background:rgba(255,255,255,0.05);
        border:1px solid rgba(255,255,255,0.08);
        color:#bcc3cd;
        border-radius:10px;
        min-width:42px;
        text-align:center;
        backdrop-filter:blur(10px);
    }

    .pagination .page-link:hover{
        background:#3c414b;
        border-color:#4a4f58;
        color:white;
    }

    .pagination .active .page-link{
        background:#4a4f58;
        border-color:#4a4f58;
        color:white;
    }

    .pagination .disabled .page-link{
        background:rgba(255,255,255,0.03);
        color:#6c757d;
        border-color:rgba(255,255,255,0.05);
    }

    #notification-container{
        position:fixed;
        top:20px;
        right:20px;
        z-index:9999;
        display:flex;
        flex-direction:column;
        gap:12px;
    }

    .notification{
        min-width:320px;

        background:rgba(15,18,24,0.85);

        backdrop-filter:blur(20px);

        border:1px solid rgba(255,255,255,0.08);

        border-radius:14px;

        padding:14px 16px;

        color:white;

        box-shadow:0 10px 30px rgba(0,0,0,0.4);

        animation:slideIn 0.3s ease;
    }

    .notification-title{
        font-weight:600;
        margin-bottom:4px;
    }

    .notification-message{
        color:#bcc3cd;
        font-size:14px;
    }

    @keyframes slideIn{
        from{
            transform:translateX(100%);
            opacity:0;
        }

        to{
            transform:translateX(0);
            opacity:1;
        }
    }

</style>

<style>

    .glass-popup{
        backdrop-filter: blur(28px);
        -webkit-backdrop-filter: blur(28px);

        border: 1px solid rgba(255,255,255,0.05) !important;

        box-shadow:
                0 20px 40px rgba(0,0,0,0.45),
                inset 0 1px 0 rgba(255,255,255,0.05) !important;

        border-radius: 18px !important;
    }

</style>


<%--Customer data tabel with keyword and paginations--%>
<script>

    function loadCustomers(page){

        const keyword = document.getElementById("keyword").value;

        currentCustomerPage = page;

        //sending ajax request
        fetch("${pageContext.request.contextPath}/customers-data?page=" + page + "&keyword=" + encodeURIComponent(keyword))
            .then(response => response.json())
            .then(data => {

                //get the customer array
                const customers = data.customers;

                //get the current page
                const currentPage = data.currentPage;

                //get the total number of pages
                const totalPages = data.totalPages;

                if (page > totalPages && totalPages > 0) {
                    loadCustomers(totalPages);
                    return;
                }


                //Create an empty html string
                let html = "";

                //Go through each customer one by one in the array
                customers.forEach(customer => {

                    html +=
                        "<tr>" +

                        // ID
                        "<td style='color:white;'>" + customer.customerId + "</td>" +

                        // Profile
                        "<td>" +
                        (customer.imagePath ?
                                "<img src='${pageContext.request.contextPath}/image?file=" + encodeURIComponent(customer.imagePath) + "' width='50' height='50' " + "style='object-fit:cover; border-radius:50%; border:1px solid rgba(255,255,255,0.15);'>"
                                :
                                "<div " + "style='width:50px;height:50px;border-radius:50%;" + "background:rgba(255,255,255,0.05);" + "display:flex;align-items:center;justify-content:center;" + "color:#9ea5af;'>" +
                                "<i class='bi bi-person'></i>" +
                                "</div>"
                        ) +
                        "</td>" +

                        // Name
                        "<td style='color:white;'>" + customer.name + "</td>" +

                        // City
                        "<td style='color:white;'>" + customer.city + "</td>" +

                        // Phone
                        "<td style='color:white;'>" + customer.phone + "</td>" +

                        // Email
                        "<td style='color:white;'>" + customer.email + "</td>" +

                        // Actions
                        "<td>" +
                        "<a href='${pageContext.request.contextPath}/edit-customer?id=" + customer.customerId +
                        "' class='me-3' " +
                        "style='color:#9aa5b3;text-decoration:none;font-size:18px;'>" +
                        "<i class='bi bi-pencil-square'></i>" +
                        "</a>" +

                        "<a href='${pageContext.request.contextPath}/delete-customer?id=" + customer.customerId + "&clientId=' " +
                        "class='btn btn-danger btn-sm delete-btn' " +
                        "style='color:#d36b6b;text-decoration:none;font-size:18px;'>" +
                        "<i class='bi bi-trash'></i>" +
                        "</a>" +

                        "</td>" +

                        "</tr>";

                    //html +=
                    //"<tr>" +
                    //"<td>" + customer.customerId + "</td>" +
                    //"<td>" + customer.name + "</td>" +
                    //"<td>" + customer.city + "</td>" +
                    //"<td>" + customer.phone + "</td>" +
                    //"<td>" + customer.email + "</td>" +
                    //"</tr>";

                });

                //Replace everything inside this customerTableBody
                document.getElementById("customerTableBody").innerHTML = html;

                //update pagination
                updatePagination(currentPage, totalPages, keyword);

            });

    }

</script>

<%--delete customer--%>
<script>

    let currentCustomerPage = 1;

    //Listen for clicks inside customerTableBody
    document.getElementById("customerTableBody").addEventListener("click", function (e) {

        //Go upward and find the nearest element with delete-btn
        //check if the delete button clicked
        if (e.target.closest(".delete-btn")){

            e.preventDefault();

            //save the clicked delete button
            const button = e.target.closest(".delete-btn")

            //get the clientId and save the url
            const deleteUrl = button.href + encodeURIComponent(localStorage.getItem("clientId"));

            //show confirmation popup
            Swal.fire({
                title: "Delete Customer?",
                text: "Are you sure you want to delete this customer?",
                icon: "warning",

                background: "rgba(15,18,24,0.95)",
                color: "#ffffff",

                showCancelButton: true,

                confirmButtonText: "Delete",
                cancelButtonText: "Cancel",

                confirmButtonColor: "#c84f4f",
                cancelButtonColor: "#4a4f58",

                customClass: {
                    popup: "glass-popup"
                }
            }).then((results) => {

                if (results.isConfirmed){

                    //browser sends the request to the servlet
                    fetch(deleteUrl)
                        //read the response body,parse json text and convert it into a java script object
                        .then(response => response.json())
                        .then(result => {

                            console.log(result);

                            if (result.success) {

                                //call loadCustomers to rebuilt the tabel
                                loadCustomers(currentCustomerPage);

                                Swal.fire({
                                    icon: "success",
                                    title: "Deleted",
                                    text: result.message,

                                    background: "rgba(15,18,24,0.95)",
                                    color: "#ffffff",

                                    confirmButtonColor: "#4a4f58",

                                    customClass: {
                                        popup: "glass-popup"
                                    }
                                });

                            }else {

                                Swal.fire({
                                    icon: "error",
                                    title: "Error",
                                    text: result.message,

                                    background: "rgba(15,18,24,0.95)",
                                    color: "#ffffff",

                                    confirmButtonColor: "#c84f4f",

                                    customClass: {
                                        popup: "glass-popup"
                                    }
                                });

                            }

                        });

                }

            });


        }

    });

</script>

<script>

    function showNotification(title, message){

        //find the notification-container
        const container = document.getElementById("notification-container");

        //create the notification element
        const notification = document.createElement("div");

        //Apply class name to the container
        notification.className = "notification";

        //Insert the message with the title
        notification.innerHTML =
            '<div class="notification-title">' + title + '</div>' +
            '<div class="notification-message">' + message + '</div>';

        //Insert notification element in to the notification container
        container.appendChild(notification);

        //Wait 5 seconds and auto remove the notification
        setTimeout(() => {
            notification.remove();
        }, 5000);

    }

</script>

<script>
    //Retrieve an existing clientId from the local storage
    let clientId = localStorage.getItem("clientId")

    //create a clientId if not exist
    if (!clientId){

        //Generate a crytographically secure unique id
        clientId = crypto.randomUUID();

        //save the generated id into the localstorage
        localStorage.setItem("clientId", clientId);

    }
</script>

<script>

    //open a realtime websocket connection
    const socket = new WebSocket("ws://" + window.location.host + "${pageContext.request.contextPath}/notifications?clientId=" + clientId);

    //Catching the Successful Connection Event
    //socket.onopen = function (){
        //console.log("WebSocket Connected")
    //};

    //Catching server message
    socket.onmessage = function (event){
        showNotification("Notification", event.data);
    };

    //Catching the Disconnect Event
    //socket.onclose = function (){
        //console.log("WebSocket Disconnected");
    //};

    //Catching network failures
    socket.onerror = function (error){
        console.log("WebSocket Error", error);
    };

</script>

<%--update pagination--%>
<script>
    function updatePagination(currentPage, totalPages, keyword) {

        //find the pagination
        const pagination = document.getElementById("pagination");

        //start with an empty pagination
        let html = "";

        //Previous Button
        html +=
            "<li class='page-item " +
            (currentPage === 1 ? "disabled" : "") +
            "'>" +

            "<a class='page-link' " +
            "href='javascript:void(0);' " +
            "onclick='loadCustomers(" + (currentPage - 1) + ", \"" + keyword + "\")'>" +

            "Previous" +

            "</a>" +

            "</li>";

        //Page numbers
        for (let i = 1; i <= totalPages; i++) {
            html +=
                "<li class='page-item " +
                (i === currentPage ? "active" : "") +
                "'>" +

                "<a class='page-link' " +
                "href='javascript:void(0);' " +
                "onclick='loadCustomers(" + i + ", \"" + keyword + "\")'>" +

                i +

                "</a>" +

                "</li>";

        }

        //Next button
        html +=
            "<li class='page-item " +
            (currentPage === totalPages ? "disabled" : "") +
            "'>" +

            "<a class='page-link' " +
            "href='javascript:void(0);' " +
            "onclick='loadCustomers(" + (currentPage + 1) + ", \"" + keyword + "\")'>" +

            "Next" +

            "</a>" +

            "</li>";

        //Replace the old pagination
        pagination.innerHTML = html;

    }

</script>

<%--search form submit--%>
<script>
    document.getElementById("searchForm").addEventListener("submit", function (e){

        e.preventDefault();

        //start from 1 when new search happens
        loadCustomers(1)

    });
</script>

<%--search form clear button--%>
<script>

    document.getElementById("clearButton").addEventListener("click", function () {
        document.getElementById("keyword").value = "";

        loadCustomers(1);
    });

</script>

<script>

    document.getElementById("logoutButton").addEventListener("click", function (e) {

        e.preventDefault();

        fetch("${pageContext.request.contextPath}/logout")
            .then(response => response.json())
            .then(result => {

                console.log(result);

                if (result.success) {

                    Swal.fire({
                        icon: "success",
                        title: "Logged Out",
                        text: result.message,

                        background: "rgba(15,18,24,0.95)",
                        color: "#ffffff",

                        confirmButtonColor: "#4a4f58",

                        customClass: {
                            popup: "glass-popup"
                        }
                    }).then(() => {

                        window.location.href = "${pageContext.request.contextPath}/login";

                    });

                }

            });

    });

</script>



</body>
</html>