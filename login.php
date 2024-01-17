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
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- endinject -->
    <!-- Plugin css for this page -->
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <!-- endinject -->
    <!-- Layout styles -->
    <link rel="stylesheet" href="assets/css/style.css">
    <!-- End layout styles -->
    <link rel="shortcut icon" href="assets/images/favicon.png"/>
    <style>
        * {
            margin: 0;
            padding: 0;
            font-family: 'poppins', sans-serif;
            overflow: hidden;
        }

        section {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            width: 100%;
            background: url("/assets/images/backlog.jpg") no-repeat center;
            background-size: cover;
        }

        .form-box {
            position: relative;
            width: 400px;
            height: 450px;
            background: transparent;
            border: 2px solid rgba(255, 255, 255, 0.5);
            border-radius: 20px;
            backdrop-filter: blur(15px);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        h2 {
            font-size: 2em;
            color: #fff;
            text-align: center;
        }

        .inputbox {
            position: relative;
            margin: 30px 0;
            width: 310px;
            border-bottom: 2px solid #fff;
        }

        input:focus ~ label,
        input:valid ~ label {
            top: -5px;
        }

        .inputbox input {
            width: 100%;
            height: 50px;
            background: transparent;
            border: none;
            outline: none;
            font-size: 1em;
            padding: 0 35px 0 5px;
            color: #fff;
        }

        .inputbox label {
            position: absolute;
            top: 50%;
            left: 5px;
            transform: translateY(-50%);
            color: #fff;
            font-size: 1em;
            pointer-events: none;
            transition: .5s;
        }

        .inputbox ion-icon {
            position: absolute;
            right: 8px;
            color: #fff;
            font-size: 1.2em;
            top: 20px;
        }

        button {
            width: 100%;
            height: 40px;
            border-radius: 40px;
            background: #fff;
            border: none;
            outline: none;
            cursor: pointer;
            font-size: 1em;
            font-weight: 600;
        }

        .snow {
            position: absolute;
            top: -10px;
            color: #c6d8e2;
            border-radius: 50%;
            animation: fall linear, rotate infinite linear;
        }

        @keyframes fall {
            to {
                transform: translateY(420vh) rotate(6530deg);
            }
        }


    </style>
</head>
<body>

<section>
    <div class="form-box" id="ssss">
        <div class="form-value">

            <h2>Авторизация </h2>
            <div class="inputbox">
                <ion-icon name="mail-outline"></ion-icon>
                <input type="text" id="exampleInputEmail1" required/>
                <label for="">Логин</label>
            </div>
            <div class="inputbox">
                <ion-icon name="lock-closed-outline"></ion-icon>
                <input type="password" id="exampleInputPassword1" required/>
                <label for="">Пароль</label>
            </div>
            <button id="log_in" name="log_in">Войти</button>

        </div>
    </div>
</section>

<div class="modal fade" id="codeModal" tabindex="-1" role="dialog" aria-labelledby="codeModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="codeModalLabel">Введите отправленный код</h5>
                <button style="width:100px;" type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="text" id="codeInput" class="form-control" required/>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="codeSubmit">Отправить</button>
            </div>
        </div>
    </div>
</div>

<!--<div class="container-scroller">-->
<!--    <div class="container-fluid page-body-wrapper full-page-wrapper">-->
<!--        <div class="content-wrapper d-flex align-items-center auth">-->
<!--            <div class="row flex-grow">-->
<!--                <div class="col-lg-4 mx-auto">-->
<!--                    <div class="auth-form-light text-left p-5">-->
<!--                        <h4>Авторизация в системе медицинкой аккредитации</h4>-->
<!---->
<!--                        <div class="form-group">-->
<!--                            <input type="text" class="form-control form-control-lg" id="exampleInputEmail1"-->
<!--                                   placeholder="Логин" name="login">-->
<!--                        </div>-->
<!--                        <div class="form-group">-->
<!--                            <input type="password" class="form-control form-control-lg" id="exampleInputPassword1"-->
<!--                                   placeholder="Пароль" name="password">-->
<!--                        </div>-->
<!--                        <button class="btn btn-block btn-primary" id="log_in" name="log_in">-->
<!--                            Войти-->
<!--                        </button>-->
<!---->
<!--                    </div>-->
<!--                </div>-->
<!--            </div>-->
<!--        </div>-->
<!--    </div>-->
<!--</div>-->

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
    log_in.onclick = (event) => {
        event.target.setAttribute("disabled",true);
        let div11 = document.createElement('div');
        div11.className = "spinner-border spinner-border-sm ml-1";
        document.getElementById("exampleInputEmail1").setAttribute("disabled",true);
        document.getElementById("exampleInputPassword1").setAttribute("disabled",true);
        log_in.appendChild(div11)

       // log_in.className = "spinner-border";

        $.ajax({
            url: "authorization/sendKod.php",
            method: "POST",
            data: {
                login: document.getElementById("exampleInputEmail1").value,
                password: document.getElementById("exampleInputPassword1").value
            }
        }).then((response) => {
            event.target.removeAttribute("disabled");
            document.getElementById("exampleInputEmail1").removeAttribute("disabled");
            document.getElementById("exampleInputPassword1").removeAttribute("disabled");
            div11.remove();
            if (response === "1") {
                $('#codeModal').modal('show');
            } else {
                alert("Неверный логин или пароль");
            }
        })
    }

    let codeSubmit = document.getElementById("codeSubmit");
    codeSubmit.onclick =   () => {



        let vvediKod = document.getElementById("codeInput").value;
        if (vvediKod) {

             $.ajax({
                url: "authorization/checkAuth.php",
                method: "POST",
                data: {
                    login: document.getElementById("exampleInputEmail1").value,
                    kod: vvediKod
                }

            }).then((response) => {

                if (response == "Да") {
                    checkTimeSession();
                } else {
                    alert("Неверный код");
                }
            })
        } else {
            checkTimeSession();
        }
    }

    function makeSnow() {
        const snow = document.createElement("div");
        const size = Math.random() * 35.5 + 3.5;
        snow.className = "snow";
        snow.style.fontSize = size + "px";
        snow.style.left = Math.random() * window.innerWidth + "px";
        snow.innerHTML = "*";
        snow.style.opacity = size / 8;
        if (size < 7) {
            snow.style.zIndex = -5;
        }
        snow.style.animationDuration = Math.random() * 60 + 20 + "s";
        document.body.appendChild(snow);
        setTimeout(() =>
                snow.remove(),
            7000
        )
    }

    function checkTimeSession() {
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
                location.href = "/index.php";
            }
        })
    }

    setInterval(makeSnow, 40);
</script>
<!-- container-scroller -->
<!-- plugins:js -->

<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
<!-- endinject -->
</body>
</html>