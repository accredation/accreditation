<?php require_once 'ajax/connection.php'; ?>
<?php include 'authorization/auth.php'; ?>
<?php include 'authorization/out.php'; ?>
<?php if(isset($_COOKIE['login'])) {

    if (!isset($_GET['role'])) {
        $login = $_COOKIE['login'];
        $query = "SELECT * FROM users where login = '$login'";

        $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
        if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
        {
            $row = mysqli_fetch_assoc($rez);
            $role = $row['id_role'];
        }
    }
}?>

<?php login(); ?>
<?php out(); ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Мед.аккредитация</title>
    <!-- plugins:css -->
    <link rel="stylesheet" href="assets/vendors/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="assets/vendors/flag-icon-css/css/flag-icon.min.css">
    <link rel="stylesheet" href="assets/vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <link rel="stylesheet" href="assets/vendors/font-awesome/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css">
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <!-- endinject -->
    <!-- Layout styles -->
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="dist/css/global.css">
    <!-- End layout styles -->
    <link rel="shortcut icon" href="assets/images/logo-rnpcmt.png"/>

    <link rel="stylesheet" href="dist/css/dataTables.bootstrap4.min.css">

    <script src="dist/js/jquery-3.5.1.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

    <style>
        @media (max-width: 1700px) {
            .col-sm-6 {
                -webkit-box-flex: 0;
                -ms-flex: 0 0 50%;
                flex: 0 0 50%;
                max-width: 50% !important;
            }

            .col-lg-6 {
                -webkit-box-flex: 0;
                -ms-flex: 0 0 50%;
                flex: 0 0 50%;
                max-width: 50% !important;
            }

            .col-xl-3 {
                -webkit-box-flex: 0;
                -ms-flex: 0 0 25%;
                flex: 0 0 50%;
                max-width: 50% !important;
            }
        }

        @media (max-width: 750px) {
            .col-sm-6 {
                -webkit-box-flex: 0;
                -ms-flex: 0 0 50%;
                flex: 0 0 100%;
                max-width: 100% !important;
            }

            .col-lg-6 {
                -webkit-box-flex: 0;
                -ms-flex: 0 0 50%;
                flex: 0 0 100%;
                max-width: 100% !important;
            }

            .col-xl-3 {
                -webkit-box-flex: 0;
                -ms-flex: 0 0 25%;
                flex: 0 0 100%;
                max-width: 100% !important;
            }
        }
    </style>
</head>
<body>
<div class="container-scroller">
    <!-- partial:partials/_navbar.html -->
    <nav class="navbar default-layout-navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
        <div class="text-center navbar-brand-wrapper d-flex align-items-center ">
            <div style="display: flex;"><a class="navbar-brand brand-logo" href="index.php"
                                           style="color: white; float: left; text-align: left; margin-left: 2rem; font-weight: 600;">РНПЦ
                    МТ

                </a>
                <div style="margin-top: 0.5rem">
                    <img src="/assets/images/logo-rnpcmt.png" style="width: 37px; height: 37px; margin-left: 1rem; "/>
                </div>
            </div>
            <!--          <a class="navbar-brand brand-logo-mini" href="index.html"><img src="assets/images/logo-mini.svg" alt="logo" /></a>-->
        </div>
        <div class="navbar-menu-wrapper d-flex align-items-stretch">
            <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
                <span class="mdi mdi-menu" style="color: white; font-size: 1.6rem "></span>
            </button>
            <div>
                <span class="nameMedaccr"> Информационная система «Медицинская аккредитация»</span>
            </div>

            <ul class="navbar-nav navbar-nav-right">

                <span id='timeOut'></span>
                <li class="nav-item nav-profile dropdown">
                    <a class="nav-link dropdown-toggle" id="profileDropdown" href="#" data-toggle="dropdown"
                       aria-expanded="false">
                        <div class="nav-profile-img">
                            <img src="assets/images/faces/face16.jpg" alt="image">
                        </div>
                        <div class="nav-profile-text">
                            <p class="mb-1 text-black" id="loginName"></p>
                        </div>
                    </a>
                    <div class="dropdown-menu navbar-dropdown dropdown-menu-right p-0 border-0 font-size-sm"
                         aria-labelledby="profileDropdown" data-x-placement="bottom-end">
                        <div class="p-3 text-center bg-primary">
                            <img class="img-avatar img-avatar48 img-avatar-thumb" src="assets/images/faces/face16.jpg"
                                 alt="">
                        </div>
                        <div class="p-2" id="accountAction">


                            <div role="separator" class="dropdown-divider"></div>

                            <h5 class="dropdown-header text-uppercase  pl-2 text-dark mt-2">Действия</h5>
                            <div id="log_out">

                            </div>
                        </div>
                    </div>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link count-indicator dropdown-toggle" id="notificationDropdown" href="#"
                       data-toggle="dropdown">
                        <i class="mdi mdi-bell-outline"></i>
                        <span class="count-symbol bg-danger" id="symb"></span>
                    </a>

                    <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" id="notifications"
                         aria-labelledby="notificationDropdown">
                        <h6 class="p-3 mb-0 bg-primary text-white py-4">Уведомления</h6>
                        <div class="dropdown-divider"></div>


                    </div>
                </li>


            </ul>
            <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button"
                    data-toggle="offcanvas">
                <span class="mdi mdi-menu" style="color: white; font-size: 1.6rem "></span>
            </button>
        </div>
    </nav>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_sidebar.html -->
        <?php include 'elements/navmenu/navmenu.php'; ?>
        <!-- partial -->
        <div class="main-panel">

            <?php
            foreach ($_GET as $key => $value) {
                $value = $key;
                break;
            }
            if (isset($value)) {

                //  require_once "ajax/includeRole.php";
                switch ($value) {
                    case 'application':
                        if(isset($role)) {
                            if ($role == "3" || $role == "15")
                                include 'api_application.php';
                            else{
                                phpAlert("Вам недоступна эта страница");
                            }
                        }else{
                            phpAlert("Требуется авторизация");
                        }
//                        include 'api_application.php';
                        break;
                    case 'users':
                        if(isset($role)) {
                            if ($role == "2")
                                include 'api_accreditation.php';
                            else{
                                phpAlert("Вам недоступна эта страница");
                            }
                        }else{
                            phpAlert("Требуется авторизация");
                        }
//                        include 'api_accreditation.php';
                        break;
                    case 'help':
                        include 'help.php';
                        break;
                    case 'myusers':
                        include 'myusers.php';
                        break;
                    case 'myusersGuzo':
                        include 'myusersGuzo.php';
                        break;
                    case 'usersAccred':
                        include 'usersAccred.php';
                        break;
                    case 'contacts':
                        include 'contacts.php';
                        break;
                    case 'support':
                        include 'support.php';
                        break;
                    case 'naznachenie_vrachei':
                        include 'naznachenie_vrachei.php';
                        break;
                    case 'messages_users':
                        include 'messages_users.php';
                        break;
                    case 'tasks_accred':
                        include 'modules/accred_tasks/tasks_accred.php';
                        break;
                    case 'application_support':
                        include 'support/application/application_support.php';
                        break;
                    case 'report_first':
                        include 'modules/report/report_first/report_first.php';
                        break;
                  
                    case 'report_analiz_samoocenka':
                        include 'modules/report/report_analiz_samoocenka/report_analiz_samoocenka.php';
                        break;
                    case 'report_analiz_ocenka':
                        include 'modules/report/report_analiz_ocenka/report_analiz_ocenka.php';
                        break;
                    case 'report_doctor_work':
                        include 'modules/report/report_doctor_work/report_doctor_work.php';
                        break;
                    case 'report_application_status':
                        include 'modules/report/report_application_status/report_application_status.php';
                        break;
                    case 'journal_rkk':
                        include 'modules/journal_rkk/journal_rkk.php';
                        break;
                    case 'schedule_uz':
                        include 'modules/form_date_schedule_uz/schedule_uz.php';
                        break;
                    case 'report_date_schedule':
                        include 'modules/report/report_date_schedule/report_date_schedule.php';
                        break;
                    case 'vid_profile_oz':
                        include 'modules/vid_profile_oz/vid_profile_oz.php';
                        break;   
                    case 'report_vid_profile_oz':
                        include 'modules/report/report_vid_profile_oz/report_vid_profile_oz.php';
                        break;       
                        
                }
            } else {
                include 'main.php';
            }
            ?>
            <!-- content-wrapper ends -->
            <!-- partial:partials/_footer.html -->
            <footer class="footer">
                <div class="footer-inner-wraper">
                    <div class="d-sm-flex justify-content-center justify-content-sm-between">
                        <span class="text-muted d-block text-center text-sm-left d-sm-inline-block">Copyright © РНПЦ МТ 2023</span>
                        <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center"> <a
                                    href="https://www.bootstrapdash.com/" target="_blank"></a> </span>
                    </div>
                </div>
            </footer>
            <!-- partial -->
        </div>
        <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
</div>
<!-- container-scroller -->
<!-- plugins:js -->
<script src="assets/vendors/js/vendor.bundle.base.js"></script>
<!-- endinject -->
<!-- Plugin js for this page -->
<script src="assets/vendors/chart.js/Chart1.min.js"></script>
<script src="assets/vendors/jquery-circle-progress/js/circle-progress.min.js"></script>
<!-- End plugin js for this page -->
<!-- inject:js -->
<script src="assets/js/off-canvas.js"></script>
<script src="assets/js/hoverable-collapse.js"></script>
<script src="assets/js/misc.js"></script>
<!-- endinject -->
<!-- Custom js for this page -->
<script src="assets/js/dashboard.js"></script>


<script src="dist/js/jquery.dataTables.min.js"></script>
<script src="dist/js/global.js"></script>


</html>