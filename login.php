<?php
include 'authorization/auth.php';

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Авторизация в системе медицинкой аккредитации</title>
    <!-- plugins:css -->
    <link rel="stylesheet" href="assets/vendors/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="assets/vendors/flag-icon-css/css/flag-icon.min.css">
    <link rel="stylesheet" href="assets/vendors/css/vendor.bundle.base.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <!-- endinject -->
    <!-- Layout styles -->
    <link rel="stylesheet" href="assets/css/style.css">
    <!-- End layout styles -->
    <link rel="shortcut icon" href="assets/images/favicon.png"/>
</head>
<body>
<div class="container-scroller">
    <div class="container-fluid page-body-wrapper full-page-wrapper">
        <div class="content-wrapper d-flex align-items-center auth">
            <div class="row flex-grow">
                <div class="col-lg-4 mx-auto">
                    <div class="auth-form-light text-left p-5">
                        <h4>Авторизация в системе медицинкой аккредитации</h4>

                        <div class="form-group">
                            <input type="text" class="form-control form-control-lg" id="exampleInputEmail1"
                                   placeholder="Логин" name="login">
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control form-control-lg" id="exampleInputPassword1"
                                   placeholder="Пароль" name="password">
                        </div>
                        <!--                  <div class="mt-3">-->
                        <!--                    <a class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn" href="../../index.html" name="log_in">SIGN IN</a>-->
                        <!--                  </div>-->
                        <button class="btn btn-block btn-primary" id="log_in" name="log_in">
                            Войти
                        </button>

                    </div>
                </div>
            </div>
        </div>
        <!-- content-wrapper ends -->
    </div>
    <!-- page-body-wrapper ends -->
</div>
<script>
    function getCookie(cname) {
        let name = cname + "=";
        let decodedCookie = decodeURIComponent(document.cookie);
        let ca = decodedCookie.split(';');
        for (let i = 0; i < ca.length; i++) {
            let c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }

    let log_in = document.getElementById("log_in");
    log_in.onclick = () => {

        $.ajax({
            url: "authorization/enter.php",
            method: "POST",
            data: {
                login: document.getElementById("exampleInputEmail1").value,
                password: document.getElementById("exampleInputPassword1").value
            }
        }).done(function (response) {
            let arr = JSON.parse(response);
            if (arr.length == "1") {
                if (arr[0] == "1") {
                    alert("Учетная запись занята");
                } else
                    alert("Неверные данные");
            } else if (arr.length == "2") {
                let lastSession = arr[1];
                let currentDate = new Date();
                let year = currentDate.getFullYear();
                let month = String(currentDate.getMonth() + 1).padStart(2, '0');
                let day = String(currentDate.getDate()).padStart(2, '0');
                let hours = String(currentDate.getHours()).padStart(2, '0');
                let minutes = String(currentDate.getMinutes()).padStart(2, '0');
                let seconds = String(currentDate.getSeconds()).padStart(2, '0');

                let formattedDate = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;

                const date1 = new Date(lastSession);
                const date2 = new Date(formattedDate);
                const diffInMs = date1 - date2;
                const diffInSeconds = Math.floor(diffInMs / 1000);
                const minutes1 = Math.floor(diffInSeconds / 60);
                const seconds1 = diffInSeconds % 60;

                let exampleInputPassword1 = document.getElementById("exampleInputPassword1");
                let oldPTime = document.getElementById("pTime");
                if (oldPTime)
                    oldPTime.remove();
                let pTime = document.createElement("p");
                pTime.id = "pTime";
                pTime.innerHTML = `Времени до окончания не закрытой сессии: ${minutes1} минут ${seconds1} секунд`;
                let parPas = exampleInputPassword1.parentElement;
                parPas.appendChild(pTime);


            } else {
                // document.cookie ="login="+document.getElementById("exampleInputEmail1").value+";";

                location.href = "/index.php";
            }

        })
    }
</script>
<!-- container-scroller -->
<!-- plugins:js -->
<script src="assets/vendors/js/vendor.bundle.base.js"></script>
<!-- endinject -->
<!-- Plugin js for this page -->
<!-- End plugin js for this page -->
<!-- inject:js -->
<script src="assets/js/off-canvas.js"></script>
<script src="assets/js/hoverable-collapse.js"></script>
<script src="assets/js/misc.js"></script>
<script src="dist/js/moment.js"></script>
<!-- endinject -->
</body>
</html>