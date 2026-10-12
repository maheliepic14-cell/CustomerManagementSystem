<%@ page import="com.customer.customermanagementsystem.model.User" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<% User user = (User) request.getAttribute("user");%>

<% Map<String, String> errors = (Map<String, String>) request.getAttribute("errors"); %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>

        .glass-alert {
            border-radius: 18px !important;

            border: 1px solid rgba(255,255,255,0.08) !important;

            background: rgba(15,18,24,0.95) !important;

            backdrop-filter: blur(28px) !important;
            -webkit-backdrop-filter: blur(28px) !important;

            box-shadow:
                    0 20px 50px rgba(0,0,0,0.55),
                    inset 0 1px 0 rgba(255,255,255,0.05) !important;
        }

        .glass-alert .swal2-title {
            color: white !important;
            font-weight: 300 !important;
        }

        .glass-alert .swal2-html-container {
            color: #b9bcc7 !important;
        }

        .glass-alert .swal2-confirm {
            background: #4a4f57 !important;
            border-radius: 10px !important;
            border: none !important;
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
            Welcome <span style="color:#c6a57a;">Back</span>
        </h1>

        <p style="
            color:#b9bcc7;
            font-size:11px;
            margin:0;
        ">
            Sign in to continue your engineering journey
        </p>

    </div>

    <%
        String message = (String) request.getAttribute("message");

        if (message != null) {
    %>

    <div class="alert alert-danger py-2 text-center mb-3">
        <%= message %>
    </div>

    <%
        }
    %>

    <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post">

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
                            value="<%= user != null ? user.getEmail() : "" %>"
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
                <%= errors != null && errors.get("email") != null ? errors.get("email") : "" %>
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
                <%= errors != null && errors.get("password") != null ? errors.get("password") : "" %>
            </div>

        </div>

        <!-- Login Button -->
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
                ">

            Login

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
            Don't have an account?
        </span>

        <a href="${pageContext.request.contextPath}/register"
           style="
                text-decoration:none;
                color:#c6a57a;
                font-size:11px;
                font-weight:500;
           ">
            Sign Up
        </a>

    </div>

</div>

<%--validation--%>
<script>

    /*

    function hideErrorTyping(fieldId,errorId){

        const field = document.getElementById(fieldId);

        if(field){

            field.addEventListener("input", function(){

                const error = document.getElementById(errorId);

                if(error){
                    error.style.display = "none";
                }

            });

        }

    }

    //hideErrorTyping("email","emailError");
    hideErrorTyping("password","passwordError");

    //Revalidate the email
    const emailField = document.getElementById("email");
    const emailError = document.getElementById("emailError")

    if (emailField && emailError){
        emailField.addEventListener("input", function (){

            const email = emailField.value.trim();

            if (email === ""){
                emailError.style.display = "block";
                emailError.innerText = "Customer email is required";
            }

            else if (!email.includes("@")){
                emailError.style.display = "block";
                emailError.innerText = "Customer email must contain @";
            }

            else emailError.style.display = "none";

        });

    }

    */


    // Email validation
    const emailField = document.getElementById("email");
    const emailError = document.getElementById("emailError");

    if (emailField) {

        emailField.addEventListener("input", function () {

            const email = emailField.value.trim();

            if (email === "") {

                emailError.style.display = "block";
                emailError.innerText = "User email is required";

            }
            else if (!/^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/.test(email)) {

                emailError.style.display = "block";
                emailError.innerText = "Customer email must contain @";

            }
            else {

                emailError.style.display = "none";

            }

        });

    }


    // Password validation
    const passwordField = document.getElementById("password");
    const passwordError = document.getElementById("passwordError");

    if (passwordField) {

        passwordField.addEventListener("input", function () {

            const password = passwordField.value;

            if (password.trim() === "") {

                passwordError.style.display = "block";
                passwordError.innerText = "Password is required";

            }
            else if (password.length < 8) {

                passwordError.style.display = "block";
                passwordError.innerText = "Password must be at least 8 characters";

            }
            else {

                passwordError.style.display = "none";

            }

        });

    }



</script>


<%--Submit login form--%>
<script>

    const loginForm = document.getElementById("loginForm");

    loginForm.addEventListener("submit", function (e) {

        e.preventDefault();

        const formData = new URLSearchParams(new FormData(loginForm));

        fetch(loginForm.action, {
            method: "POST",
            body: formData
        })
            .then(response => response.json())
            .then(result => {

                if (result.errors) {

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

                        customClass: {
                            popup: "glass-alert"
                        },

                        confirmButtonText: "OK"
                    }).then(() => {

                        window.location.href = "${pageContext.request.contextPath}/customers";

                    });

                }

                if (!result.success && result.message) {

                    Swal.fire({
                        icon: "error",
                        title: "Login Failed",
                        text: result.message,

                        customClass: {
                            popup: "glass-alert"
                        },

                        confirmButtonText: "OK"
                    });

                }


            });

    });

</script>







<%
    String success = (String) session.getAttribute("success");

    if(success != null){
%>

<script>

    document.addEventListener("DOMContentLoaded", function (){

        Swal.fire({
            icon: "success",
            title: "Success",
            text: "<%= success %>",

            customClass: {
                popup: "glass-alert"
            },

            timer: 2000,
            showConfirmButton: false
        });

    });

</script>

<%
        session.removeAttribute("success");
    }
%>

</body>

</html>