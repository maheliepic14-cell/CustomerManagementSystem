<%@ page import="com.customer.customermanagementsystem.model.User" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<% User user = (User) request.getAttribute("user");%>

<% Map<String, String> errors = (Map<String, String>) request.getAttribute("errors"); %>

<!DOCTYPE html>
<html>
<head>
    <title>Register</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>

        .glass-alert {
            border-radius: 18px !important;
            border: 1px solid rgba(255,255,255,0.08) !important;

            box-shadow:
                    0 20px 50px rgba(0,0,0,0.55),
                    inset 0 1px 0 rgba(255,255,255,0.05) !important;

            backdrop-filter: blur(28px) !important;
            -webkit-backdrop-filter: blur(28px) !important;
        }

        .glass-alert .swal2-title {
            color: #ffffff !important;
            font-weight: 400 !important;
            font-size: 24px !important;
        }

        .glass-alert .swal2-html-container {
            color: #b9bcc7 !important;
            font-size: 13px !important;
        }

        .glass-alert .swal2-confirm {
            border-radius: 10px !important;
            padding: 9px 24px !important;
            font-size: 13px !important;
            box-shadow: none !important;
        }

        .glass-alert .swal2-success-ring {
            border-color: rgba(198,165,122,0.35) !important;
        }

        .glass-alert .swal2-success-line-tip,
        .glass-alert .swal2-success-line-long {
            background-color: #c6a57a !important;
        }

        .glass-alert .swal2-error {
            border-color: #d36b6b !important;
        }

        .glass-alert .swal2-x-mark-line-left,
        .glass-alert .swal2-x-mark-line-right {
            background-color: #d36b6b !important;
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
        align-items:center;
        font-family:'Segoe UI',sans-serif;
        overflow:hidden;
        position:relative;
">

<!-- Dark Overlay -->
<div style="
    position:absolute;
    inset:0;
    background:rgba(0,0,0,0.70);
"></div>

<!-- Glass Card -->
<div style="
    position:relative;
    z-index:2;

    width:360px;
    max-width:90%;

    padding:24px;

    border-radius:18px;

    background:rgba(15,18,24,0.55);

    backdrop-filter:blur(28px);
    -webkit-backdrop-filter:blur(28px);

    border:1px solid rgba(255,255,255,0.05);

    box-shadow:
        0 20px 40px rgba(0,0,0,0.45),
        inset 0 1px 0 rgba(255,255,255,0.05);
">

    <!-- Heading -->
    <div class="text-center mb-3">

        <h1 style="
            color:white;
            font-size:30px;
            font-weight:300;
            margin-bottom:6px;
            letter-spacing:0.3px;
        ">
            Welcome <span style="color:#c6a57a;"></span>
        </h1>

        <p style="
            color:#b9bcc7;
            font-size:11px;
            margin:0;
        ">
            Sign up to see customers page
        </p>

    </div>

    <%
        String message = (String) request.getAttribute("message");
        if(message != null){
    %>

    <div class="alert alert-danger py-2 text-center mb-3">
        <%= message %>
    </div>

    <% } %>

    <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post">

        <!-- Full Name -->
        <div class="mb-2">

            <div style="
                height:58px;
                display:flex;
                align-items:center;
                padding:0 12px;

                background:rgba(255,255,255,0.04);

                border:1px solid rgba(255,255,255,0.05);

                border-radius:10px;
            ">

                <i class="bi bi-person"
                   style="
                        color:#b5bcc7;
                        font-size:16px;
                        margin-right:10px;
                   ">
                </i>

                <div style="width:100%;">

                    <div style="
                        color:#ececec;
                        font-size:10px;
                        margin-bottom:1px;
                    ">
                        Full Name
                    </div>

                    <input
                            type="text"
                            id="fullName"
                            name="fullName"
                            placeholder="Enter your full name"
                            value="<%= user != null ? user.getFullName() : ""  %>"

                            style="
                                width:100%;
                                background:transparent;
                                border:none;
                                outline:none;
                                color:white;
                                font-size:13px;
                            ">
                </div>

            </div>

                <div
                        id="fullNameError"
                        class="invalid-feedback"
                        style="font-size:12px;"
                >
                    <%= errors != null && errors.get("fullName") != null? errors.get("fullName") : ""%>

                </div>


        </div>

        <!-- Email -->
        <div class="mb-2">

            <div style="
                height:58px;
                display:flex;
                align-items:center;
                padding:0 12px;

                background:rgba(255,255,255,0.04);

                border:1px solid rgba(255,255,255,0.05);

                border-radius:10px;
            ">

                <i class="bi bi-envelope"
                   style="
                        color:#b5bcc7;
                        font-size:16px;
                        margin-right:10px;
                   ">
                </i>

                <div style="width:100%;">

                    <div style="
                        color:#ececec;
                        font-size:10px;
                        margin-bottom:1px;
                    ">
                        Email Address
                    </div>

                    <input
                            type="text"
                            id="email"
                            name="email"
                            placeholder="Enter your email"
                            value="<%= user != null ? user.getEmail() : ""  %>"
                            style="
                                width:100%;
                                background:transparent;
                                border:none;
                                outline:none;
                                color:white;
                                font-size:13px;
                            ">

                </div>

            </div>

            <div
                    id="emailError"
                    class="text-danger"
                    style="font-size:12px;"
            >
                <%= errors != null && errors.get("email") != null ? errors.get("email") : ""%>
            </div>

        </div>

        <!-- Password -->
        <div class="mb-3">

            <div style="
                height:58px;
                display:flex;
                align-items:center;
                padding:0 12px;

                background:rgba(255,255,255,0.04);

                border:1px solid rgba(255,255,255,0.05);

                border-radius:10px;
            ">

                <i class="bi bi-lock"
                   style="
                        color:#b5bcc7;
                        font-size:16px;
                        margin-right:10px;
                   ">
                </i>

                <div style="width:100%;">

                    <div style="
                        color:#ececec;
                        font-size:10px;
                        margin-bottom:1px;
                    ">
                        Password
                    </div>

                    <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Enter your password"
                            style="
                                width:100%;
                                background:transparent;
                                border:none;
                                outline:none;
                                color:white;
                                font-size:13px;
                            ">

                </div>

            </div>


            <div
                    id="passwordError"
                    class="text-danger"
                    style="font-size:12px;"
            >
                <%= errors != null && errors.get("password") != null ? errors.get("password") : ""%>

            </div>

        </div>

        <!-- Sign Up Button -->
        <button
                type="submit"
                style="
                    width:100%;
                    height:48px;

                    border:none;
                    border-radius:12px;

                    color:white;
                    font-size:16px;
                    font-weight:500;

                    position:relative;

                    background:linear-gradient(
                        90deg,
                        #2b3037 0%,
                        #4a4f57 55%,
                        #8c8277 100%
                    );

                    box-shadow:
                        0 8px 18px rgba(0,0,0,0.35);

                    transition:all .3s ease;
                ">

            Sign Up

            <i class="bi bi-arrow-right"
               style="
                    position:absolute;
                    right:16px;
                    top:50%;
                    transform:translateY(-50%);
                    font-size:18px;
               ">
            </i>

        </button>

    </form>

    <!-- Bottom Text -->
    <div class="text-center mt-3">

        <span style="
            color:#aeb4be;
            font-size:11px;
        ">
            Already have an account?
        </span>

        <a href="${pageContext.request.contextPath}/login"
           style="
                text-decoration:none;
                color:#c6a57a;
                font-size:11px;
                font-weight:500;
           ">
            Login
        </a>

    </div>

</div>

<%--Register form submission--%>
<script>

    const registerForm = document.getElementById("registerForm");

    registerForm.addEventListener("submit", function (e) {

        e.preventDefault();

        //send the normal form values as URL-encoded data
        const formData = new URLSearchParams(new FormData(registerForm));

        fetch(registerForm.action, {
            method: "POST",
            body: formData
        })
            .then(response => response.json())
            .then(result => {

                console.log(result);

                if (result.errors) {

                    if (result.errors.fullName) {
                        document.getElementById("fullNameError").innerText = result.errors.fullName;
                        document.getElementById("fullNameError").style.display = "block";
                    }

                    if (result.errors.email) {
                        document.getElementById("emailError").innerText = result.errors.email;
                        document.getElementById("emailError").style.display = "block";
                    }

                    if (result.errors.password) {
                        document.getElementById("passwordError").innerText = result.errors.password;
                        document.getElementById("passwordError").style.display = "block";
                    }

                }

                if (result.success) {
                    Swal.fire({
                        icon: "success",
                        title: "Success",
                        text: result.message,
                        background: "rgba(15,18,24,0.95)",
                        color: "#ffffff",
                        confirmButtonText: "OK",
                        confirmButtonColor: "#8c8277",

                        customClass: {
                            popup: "glass-alert"
                        }
                    }).then(() => {

                        window.location.href = "${pageContext.request.contextPath}/login";

                    });

                }

                if (!result.success && result.message) {

                    Swal.fire({
                        icon: "error",
                        title: "Error",
                        text: result.message,
                        background: "rgba(15,18,24,0.95)",
                        color: "#ffffff",
                        confirmButtonText: "OK",

                        customClass: {
                            popup: "glass-alert"
                        }
                    });

                }

            });

    });

</script>

<script>

    //Validate the email
    const emailField = document.getElementById("email");
    const emailError = document.getElementById("emailError")

    if (emailField && emailError){

        let emailTimer;

        emailField.addEventListener("input", function (){

            const email = emailField.value.trim();

            if (email === ""){
                emailError.style.display = "block";
                emailError.innerText = "Customer email is required";
            }

            else if (!/^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/.test(email)){
                emailError.style.display = "block";
                emailError.innerText = "Customer email must contain @";
            }

            else emailError.style.display = "none";

            //clear the previous time
            clearTimeout(emailTimer);

            emailTimer = setTimeout(function (){

                const email = emailField.value.trim();

                if (email !== "" && /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/.test(email)) {

                    fetch("${pageContext.request.contextPath}/check-email?email=" +
                        encodeURIComponent(email))
                        .then(response => response.text())
                        .then(result => {

                            if (result === "exists") {
                                emailError.style.display = "block";
                                emailError.innerText = "Email already exists";
                            } else {
                                emailError.style.display = "none";
                            }

                        })
                        .catch(error => {
                            console.error(error);
                        });
                }
            },500);
        });
    }

</script>

<script>
    //fullname validation
    const fullNameFeild = document.getElementById("fullName");
    const fullNameError = document.getElementById("fullNameError");

    if (fullNameFeild){
        fullNameFeild.addEventListener("input", function (){
            const name = fullNameFeild.value.trim();

            if (name === ""){
                if (fullNameError){
                    fullNameError.style.display = "block";
                    fullNameError.innerHTML = "Full name is required";
                }
            }else if (name.length < 2){
                if (fullNameError){
                    fullNameError.style.display = "block";
                    fullNameError.innerHTML = "Full name must be at least 2 characters";
                }
            } else {
                if (fullNameError){
                    fullNameError.style.display = "none";
                }
            }

        });
    }
</script>

<script>
    //validation for password
    const passwordField = document.getElementById("password");
    const passwordError = document.getElementById("passwordError");

    if (passwordField){
        passwordField.addEventListener("input", function (){
           const password = passwordField.value;

           if (password.trim() === ""){
               if (passwordError){
                   passwordError.style.display = "block";
                   passwordError.innerHTML = "Password is required";
               }
           } else if (password.length <8){
               if (passwordError){
                   passwordError.style.display = "block";
                   passwordError.innerHTML = "Password must be at least 8 character";
               }
           } else {
               if (passwordError){
                   passwordError.style.display = "none";
               }
           }

        });
    }

</script>


</body>

</html>