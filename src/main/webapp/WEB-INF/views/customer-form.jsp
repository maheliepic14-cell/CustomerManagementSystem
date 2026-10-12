<%@ page import="com.customer.customermanagementsystem.model.Customer" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    //retrieve request object and type cast it to Customer object
    Customer customer = (Customer) request.getAttribute("customer");

    //check if edit mode or create mode
    boolean editing = customer != null && customer.getCustomerId() > 0;

    Map<String, String> errors = (Map<String, String>) request.getAttribute("errors");

%>


<!DOCTYPE html>
<html>
<head>
    <title>
        <%= editing ? "Edit Customer" : "Add Customer" %>
    </title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>

        .glass-popup {
            border-radius: 18px !important;

            border: 1px solid rgba(255,255,255,0.08) !important;

            box-shadow:
                    0 20px 50px rgba(0,0,0,0.55),
                    inset 0 1px 0 rgba(255,255,255,0.05) !important;

            backdrop-filter: blur(28px) !important;
            -webkit-backdrop-filter: blur(28px) !important;
        }

        .glass-popup .swal2-title {
            color: white !important;
            font-weight: 300 !important;
        }

        .glass-popup .swal2-html-container {
            color: #b9bcc7 !important;
            font-size: 13px !important;
        }

        .glass-popup .swal2-confirm {
            border-radius: 10px !important;
            box-shadow: none !important;
        }

    </style>

</head>

<body style="
        margin:0;
        min-height:100vh;
        background-image:url('https://images.pexels.com/photos/26628057/pexels-photo-26628057.jpeg');
        background-size:cover;
        background-position:center;
        background-repeat:no-repeat;
        display:flex;
        justify-content:center;
        align-items:flex-start;
        font-family:'Segoe UI',sans-serif;
        position:relative;
        overflow-y:auto;
        padding:20px 0;
">

<!-- Dark Overlay -->
<div style="
        position:absolute;
        inset:0;
        background:rgba(0,0,0,0.72);
"></div>

<!-- Glass Card -->
<div style="
        position:relative;
        z-index:2;

        width:350px;
        max-width:92%;

        background:rgba(15,18,24,0.55);

        backdrop-filter:blur(28px);
        -webkit-backdrop-filter:blur(28px);

        border:1px solid rgba(255,255,255,0.05);

        border-radius:16px;

        padding:18px;

        box-shadow:
        0 20px 40px rgba(0,0,0,0.45),
        inset 0 1px 0 rgba(255,255,255,0.05);
">

    <!-- Heading -->
    <div class="text-center mb-3">

        <h2 style="
            color:white;
            font-weight:300;
            font-size:24px;
            margin-bottom:4px;
        ">
            <%= editing ? "Edit" : "Add" %>

            <span style="color:#c6a57a;">
                Customer
            </span>
        </h2>

        <small style="
            color:#9ea5af;
            font-size:11px;
        ">
            Enter customer information below
        </small>

    </div>

    <%
        String message = (String) request.getAttribute("message");

        if(message != null){
    %>

    <div class="alert alert-danger py-2 mb-3">
        <%= message %>
    </div>

    <%
        }
    %>

    <div id="messageBox"></div>
    
    <form id="customerForm" action="${pageContext.request.contextPath}/customers" method="post" enctype="multipart/form-data">

        <input type="hidden"
               name="customerId"
               value="<%= customer != null ? customer.getCustomerId() : 0 %>">

        <input type="hidden"
               id="clientId"
               name="clientId">

        <!-- Name -->
        <div class="mb-2">

            <label class="form-label"
                   style="
                        color:#bcc3cd;
                        font-size:12px;
                        margin-bottom:4px;
                   ">
                Name
            </label>

            <input
                    id="name"
                    type="text"
                    name="name"
                    class="form-control"

                    value="<%= customer != null ? customer.getName() : "" %>"

                    style="
                        background:rgba(255,255,255,0.05);
                        border:1px solid rgba(255,255,255,0.08);
                        color:white;
                        height:42px;
                        font-size:13px;
                    ">

            <div id="nameError"
                 class="text-danger"
                 style="font-size:12px;">

                <%= errors != null && errors.get("name") != null ? errors.get("name") : "" %>

            </div>


        </div>

        <!-- City -->
        <div class="mb-2">

            <label class="form-label"
                   style="
                        color:#bcc3cd;
                        font-size:12px;
                        margin-bottom:4px;
                   ">
                City
            </label>

            <input
                    id="city"
                    type="text"
                    name="city"
                    class="form-control"

                    value="<%= customer != null ? customer.getCity() : "" %>"

                    style="
                        background:rgba(255,255,255,0.05);
                        border:1px solid rgba(255,255,255,0.08);
                        color:white;
                        height:42px;
                        font-size:13px;
                    ">

            <div id="cityError"
                 class="text-danger"
                 style="font-size: 12px;">

                <%= errors != null && errors.get("city") != null ? errors.get("city") : "" %>

            </div>

        </div>

        <!-- Address -->
        <div class="mb-2">

            <label class="form-label"
                   style="
                        color:#bcc3cd;
                        font-size:12px;
                        margin-bottom:4px;
                   ">
                Address
            </label>

            <input
                    id="address"
                    type="text"
                    name="address"
                    class="form-control"

                    value="<%= customer != null ? customer.getAddress() : "" %>"

                    style="
                        background:rgba(255,255,255,0.05);
                        border:1px solid rgba(255,255,255,0.08);
                        color:white;
                        height:42px;
                        font-size:13px;
                    ">

            <div id="addressError"
                 class="text-danger"
                 style="font-size: 12px;">
                <%= errors != null && errors.get("address") != null ? errors.get("address") : "" %>

            </div>


        </div>

        <!-- Phone -->
        <div class="mb-2">

            <label class="form-label"
                   style="
                        color:#bcc3cd;
                        font-size:12px;
                        margin-bottom:4px;
                   ">
                Phone
            </label>

            <input
                    id="phone"
                    type="text"
                    name="phone"
                    class="form-control"

                    value="<%= customer != null ? customer.getPhone() : "" %>"

                    style="
                        background:rgba(255,255,255,0.05);
                        border:1px solid rgba(255,255,255,0.08);
                        color:white;
                        height:42px;
                        font-size:13px;
                    ">

            <div id="phoneError"
                 class="text-danger"
                 style="font-size: 12px;">
                <%= errors != null && errors.get("phone") != null ? errors.get("phone") : "" %>
            </div>

        </div>

        <!-- Email -->
        <div class="mb-3">

            <label class="form-label"
                   style="
                        color:#bcc3cd;
                        font-size:12px;
                        margin-bottom:4px;
                   ">
                Email
            </label>

            <input
                    id="email"
                    type="text"
                    name="email"
                    class="form-control"

                    value="<%= customer != null ? customer.getEmail() : "" %>"

                    style="
                        background:rgba(255,255,255,0.05);
                        border:1px solid rgba(255,255,255,0.08);
                        color:white;
                        height:42px;
                        font-size:13px;
                    ">

            <div id="emailError"
                 class="text-danger"
                 style="font-size:12px;">

                <%= errors != null && errors.get("email") != null ? errors.get("email") : "" %>

            </div>

        </div>

        <!-- Image -->
        <div class="mb-3">

            <label class="form-label"
                   style="
                color:#bcc3cd;
                font-size:12px;
                margin-bottom:6px;
           ">
                Profile Image (Optional)
            </label>

            <% if (editing && customer.getImagePath() != null && !customer.getImagePath().isEmpty()) { %>

            <div class="text-center mb-3">

                <img id="currentProfileImage" src="${pageContext.request.contextPath}/image?file=<%= customer.getImagePath() %>"
                     style="
                    width:110px;
                    height:110px;
                    object-fit:cover;
                    border-radius:50%;
                    border:3px solid rgba(255,255,255,0.12);
                    box-shadow:0 8px 20px rgba(0,0,0,0.35);
                ">

                <div style="
                color:#9ea5af;
                font-size:11px;
                margin-top:8px;
        ">
                    Current Profile Picture
                </div>

            </div>

            <% } %>

            <div style="
            background:rgba(255,255,255,0.05);
            border:1px dashed rgba(255,255,255,0.12);
            border-radius:12px;
            padding:14px;">

                <div style="position:relative; width:110px; height:110px;">

                    <img id="imagePreview"
                         src=""
                         style="
                    width:110px;
                    height:110px;
                    object-fit:cover;
                    border-radius:50%;
                    display:none;
                    border:1px solid rgba(255,255,255,0.15);
             ">

                    <button type="button"
                            id="removeImageButton"
                            style="
                    position:absolute;
                    top:-5px;
                    right:-5px;
                    width:24px;
                    height:24px;
                    border:none;
                    border-radius:50%;
                    background:#d36b6b;
                    color:white;
                    display:none;
                    align-items:center;
                    justify-content:center;
                    padding:0;
                ">
                        <i class="bi bi-x"></i></button>

                </div>

                <input
                        type="file"
                        id="imageInput"
                        name="image"
                        accept="image/*"
                        class="form-control mt-2"
                        style="
                    background:rgba(255,255,255,0.04);
                    border:1px solid rgba(255,255,255,0.08);
                    color:white;
                    font-size:12px;
                ">

                <small style="
                color:#8d96a0;
                font-size:11px;
        ">
                    JPG, PNG or JPEG. Leave empty to keep current image.
                </small>

            </div>

            <div id="imageError"
                 class="text-danger mt-1"
                 style="font-size:12px;">

                <%= errors != null && errors.get("image") != null ? errors.get("image") : "" %>

            </div>

        </div>

        <!-- Buttons -->
        <div class="d-flex gap-2">

            <button
                    type="submit"
                    class="btn flex-grow-1"

                    style="
                        background:#4a4f58;
                        color:white;
                        border:none;
                        height:42px;
                        font-size:13px;
                    ">

                <i class="bi bi-check-circle me-1"></i>

                <%= editing ? "Update Customer" : "Save Customer" %>

            </button>

            <button
                    type="button"
                    id="clearFormButton"
                    class="btn"
                    style="
                    background:transparent;
                    color:#c0c7d0;
                    border:1px solid #58606b;">

                <i class="bi bi-x-circle me-1"></i>
                <%= editing ? "Reset" : "Clear" %>
            </button>

            <a href="${pageContext.request.contextPath}/customers"
               class="btn"

               style="
                    background:transparent;
                    color:#c0c7d0;
                    border:1px solid #58606b;
                    height:42px;
                    font-size:13px;
                    display:flex;
                    align-items:center;
               ">

                <i class="bi bi-arrow-left me-1"></i>

                Back

            </a>

        </div>

    </form>

</div>

<%--validation--%>
<script>
const nameField = document.getElementById("name");
const cityField = document.getElementById("city");
const addressField = document.getElementById("address");
const phoneField = document.getElementById("phone");

const nameError = document.getElementById("nameError");
const cityError = document.getElementById("cityError");
const addressError = document.getElementById("addressError");
const phoneError = document.getElementById("phoneError");

//Name
nameField.addEventListener("input", function () {

    const name = nameField.value.trim();

    if (name === "") {
        nameError.style.display = "block";
        nameError.innerText = "Customer name is required";
        return;
    }

    if (name.length < 2) {
        nameError.style.display = "block";
        nameError.innerText = "Customer name must be at least 2 characters";
        return;
    }

    nameError.style.display = "none";
});


//city
cityField.addEventListener("input", function () {

    const city = cityField.value.trim();

    if (city === "") {
        cityError.style.display = "block";
        cityError.innerText = "Customer city is required";
        return;
    }

    if (city.length < 2) {
        cityError.style.display = "block";
        cityError.innerText = "Customer city must be at least 2 characters";
        return;
    }

    cityError.style.display = "none";
});


//address
addressField.addEventListener("input", function () {

    const address = addressField.value.trim();

    if (address === "") {
        addressError.style.display = "block";
        addressError.innerText = "Customer address is required";
        return;
    }

    if (address.length < 5) {
        addressError.style.display = "block";
        addressError.innerText = "Customer address must be at least 5 characters";
        return;
    }

    addressError.style.display = "none";
});


//phone
phoneField.addEventListener("input", function () {

    const phone = phoneField.value.trim();

    if (phone === "") {
        phoneError.style.display = "block";
        phoneError.innerText = "Customer phone number is required";
        return;
    }

    if (!/^\d{10}$/.test(phone)) {
        phoneError.style.display = "block";
        phoneError.innerText = "Customer phone number must be 10 digits";
        return;
    }

    phoneError.style.display = "none";
});

//Email
const emailField = document.getElementById("email");
const emailError = document.getElementById("emailError");

let emailTimer;

if (emailField && emailError){

    emailField.addEventListener("input", function (){

        const email = emailField.value.trim();

        if (email === ""){

            emailError.style.display = "block";
            emailError.innerText = "Customer email is required";
            return;

        }

        if (!/^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/.test(email)){

            emailError.style.display = "block";
            emailError.innerText = "Customer email must contain @";
            return;

        }

        emailError.style.display = "none";

        clearTimeout(emailTimer);

        emailTimer = setTimeout(function (){

            fetch(
                "${pageContext.request.contextPath}/check-customer-email?email="
                + encodeURIComponent(email)
            )
                .then(response => response.text())
                .then(result => {

                    if(result === "exists"){

                        emailError.style.display = "block";
                        emailError.innerText = "Email already exists";

                    }else{

                        emailError.style.display = "none";

                    }

                })
                .catch(error => {
                    console.error(error);
                });

        },500);

    });

}


</script>

<%--customer form submission--%>
<script>

    //create a variable that stores the latest saved data for reset and clear buttons
    let savedCustomer = {
        name: "<%= customer != null ? customer.getName() : "" %>",
        city: "<%= customer != null ? customer.getCity() : "" %>",
        address: "<%= customer != null ? customer.getAddress() : "" %>",
        phone: "<%= customer != null ? customer.getPhone() : "" %>",
        email: "<%= customer != null ? customer.getEmail() : "" %>",
        imagePath: "<%= customer != null && customer.getImagePath() != null ? customer.getImagePath() : "" %>"

    };

    document.getElementById("customerForm").addEventListener("submit", function (e){
        e.preventDefault();

        //create a variable and store the customer form elements that triggered the submit
        const form = this;

        //const form = document.getElementById("customerForm");

        //collects form feilds
        const formData = new FormData(form);

        //send all the collected form data
        fetch(form.action, {method: "POST", body: formData})
            //take the json response and Read the response body and parse it as JSON
            .then(response => response.json())
            //store converted json in the result
            .then(result => {
                console.log(result)

                if (result.success) {
                    Swal.fire({
                        icon: "success",
                        title: "Success",
                        text: result.message,

                        background: "rgba(15,18,24,0.95)",
                        color: "#ffffff",

                        confirmButtonText: "OK",
                        confirmButtonColor: "#4a4f58",

                        customClass: {
                            popup: "glass-popup"
                        }
                    }).then(()=> {
                        //Update mode
                        if (result.customer) {

                            //puts the updated values into the form
                            document.getElementById("name").value = result.customer.name;
                            document.getElementById("city").value = result.customer.city;
                            document.getElementById("address").value = result.customer.address;
                            document.getElementById("phone").value = result.customer.phone;
                            document.getElementById("email").value = result.customer.email;

                            //Update th saved values in the savedCustomer variable
                            savedCustomer.name = result.customer.name;
                            savedCustomer.city = result.customer.city;
                            savedCustomer.address = result.customer.address;
                            savedCustomer.phone = result.customer.phone;
                            savedCustomer.email = result.customer.email;
                            savedCustomer.imagePath = result.customer.imagePath;

                            if (result.customer.imagePath) {

                                document.getElementById("currentProfileImage").src = "${pageContext.request.contextPath}/image?file=" + encodeURIComponent(result.customer.imagePath) + "&t=" + Date.now();
                            }

                            //Existing image-clearing
                            document.getElementById("imageInput").value = "";

                            document.getElementById("imagePreview").src = "";
                            document.getElementById("imagePreview").style.display = "none";
                            document.getElementById("removeImageButton").style.display = "none";
                        }

                        else {

                            //Add mode

                            // clears the form back to its original HTML values
                            document.getElementById("customerForm").reset()

                            //Take the clientid back after reset
                            document.getElementById("clientId").value = localStorage.getItem("clientId");

                            //clear the image preview and hide the remove button
                            document.getElementById("imagePreview").src = "";

                            document.getElementById("imagePreview").style.display = "none";

                            document.getElementById("removeImageButton").style.display = "none";

                        }

                    });

                }

            else {

                    if (result.errors) {

                        const errors = result.errors;

                        //puts the server error into the page.

                        if (errors.name) {
                            document.getElementById("nameError").textContent = errors.name;
                        }

                        if (errors.city) {
                            document.getElementById("cityError").textContent = errors.city;
                        }

                        if (errors.address) {
                            document.getElementById("addressError").textContent = errors.address;
                        }

                        if (errors.phone) {
                            document.getElementById("phoneError").textContent = errors.phone;
                        }

                        if (errors.email) {
                            document.getElementById("emailError").textContent = errors.email;
                        }

                        if (errors.image) {
                            document.getElementById("imageError").textContent = errors.image;
                        }

                    }

                    if (result.message) {

                        Swal.fire({
                            icon: result.message === "No changes made" ? "info" : "error",
                            title: result.message === "No changes made" ? "No Changes" : "Error",
                            text: result.message,

                            background: "rgba(15,18,24,0.95)",
                            color: "#ffffff",

                            confirmButtonText: "OK",
                            confirmButtonColor: "#4a4f58",

                            customClass: {
                                popup: "glass-popup"
                            }
                        });

                    }

                }
            });
    });
</script>

<%--clear button--%>
<script>

    document.getElementById("clearFormButton").addEventListener("click", function () {

        <% if (editing) { %>

        //so the reset gets values from saved customer
        document.getElementById("name").value = savedCustomer.name;
        document.getElementById("city").value = savedCustomer.city;
        document.getElementById("address").value = savedCustomer.address;
        document.getElementById("phone").value = savedCustomer.phone;
        document.getElementById("email").value = savedCustomer.email;

        <% } else { %>

        document.getElementById("customerForm").reset();

        <% } %>

        document.getElementById("imageInput").value = "";

        document.getElementById("imagePreview").src = "";
        document.getElementById("imagePreview").style.display = "none";
        document.getElementById("removeImageButton").style.display = "none";

        document.getElementById("clientId").value = localStorage.getItem("clientId");

        document.getElementById("nameError").innerText = "";
        document.getElementById("cityError").innerText = "";
        document.getElementById("addressError").innerText = "";
        document.getElementById("phoneError").innerText = "";
        document.getElementById("emailError").innerText = "";
        document.getElementById("imageError").innerText = "";

    });

</script>

<%--Image preview--%>
<script>
    document.getElementById("imageInput").addEventListener("change",function (){

        //Gets the selected image
        const file = this.files[0];

        if (file){
            const imagePreview = document.getElementById("imagePreview");

            //here creates a temporary browser url for the image
            //and put that image into the img tag
            imagePreview.src = URL.createObjectURL(file);
            //make the preview visible
            imagePreview.style.display = "block";
            //make the remove button visible
            document.getElementById("removeImageButton").style.display = "flex";
        }
    });

    //Image remove button
    document.getElementById("removeImageButton").addEventListener("click", function () {

        document.getElementById("imageInput").value = "";

        document.getElementById("imagePreview").src = "";

        document.getElementById("imagePreview").style.display = "none";

        document.getElementById("removeImageButton").style.display = "none";

    });

</script>

<%--clientid--%>
<script>
    document.getElementById("clientId").value = localStorage.getItem("clientId");
</script>

</body>

</html>