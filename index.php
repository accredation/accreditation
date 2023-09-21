<?php require_once 'connection.php'; ?>
<?php include 'authorization/auth.php';?>
<?php include 'authorization/out.php';?>

<?php login();?>
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
    <link rel="stylesheet" href="assets/vendors/font-awesome/css/font-awesome.min.css" />
    <link rel="stylesheet" href="assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css">
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <!-- endinject -->
    <!-- Layout styles -->
    <link rel="stylesheet" href="assets/css/style.css">
      <link rel="stylesheet" href="dist/css/global.css" >
    <!-- End layout styles -->
    <link rel="shortcut icon" href="assets/images/logo-rnpcmt.png" />

    <link rel="stylesheet" href="dist/css/dataTables.bootstrap4.min.css">

      <script src="dist/js/jquery-3.5.1.js"></script>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>


  </head>
  <body >
    <div class="container-scroller">
      <!-- partial:partials/_navbar.html -->
      <nav class="navbar default-layout-navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
        <div class="text-center navbar-brand-wrapper d-flex align-items-center ">
         <div style="display: flex;"> <a class="navbar-brand brand-logo" href="index.php" style="color: white; float: left; text-align: left; margin-left: 2rem; font-weight: 600;">РНПЦ МТ

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


            <li class="nav-item nav-profile dropdown">
              <a class="nav-link dropdown-toggle" id="profileDropdown" href="#" data-toggle="dropdown" aria-expanded="false">
                <div class="nav-profile-img">
                  <img src="assets/images/faces/face16.jpg" alt="image">
                </div>
                <div class="nav-profile-text">
                  <p class="mb-1 text-black"><?php if (!isset($_COOKIE['login']))
                          echo "Гость";
                      else
                          echo $_COOKIE['login']; ?></p>
                </div>
              </a>
              <div class="dropdown-menu navbar-dropdown dropdown-menu-right p-0 border-0 font-size-sm" aria-labelledby="profileDropdown" data-x-placement="bottom-end">
                <div class="p-3 text-center bg-primary">
                  <img class="img-avatar img-avatar48 img-avatar-thumb" src="assets/images/faces/face16.jpg" alt="">
                </div>
                <div class="p-2">
                    <?php
                    if (isset($_COOKIE['login'])) {?>
<!--                  <h5 class="dropdown-header text-uppercase pl-2 text-dark">Пользовательские данные</h5>-->
<!--                  <a class="dropdown-item py-1 d-flex align-items-center justify-content-between" href="#">-->
<!--                    <span>Входящие</span>-->
<!--                    <span class="p-0">-->
<!--                      <span class="badge badge-primary">3</span>-->
<!--                      <i class="mdi mdi-email-open-outline ml-1"></i>-->
<!--                    </span>-->
<!--                  </a>-->
<!--                  <a class="dropdown-item py-1 d-flex align-items-center justify-content-between" href="#">-->
<!--                    <span>Профиль</span>-->
<!--                    <span class="p-0">-->
<!--                      <span class="badge badge-success">1</span>-->
<!--                      <i class="mdi mdi-account-outline ml-1"></i>-->
<!--                    </span>-->
<!--                  </a>-->
                        <?php
                        if ($_COOKIE['login'] == "hancharou@rnpcmt.by") {?>
                            <a class="dropdown-item py-1 d-flex align-items-center justify-content-between" href="/administrator/online-info.php">
                                <i class="fa fa-user "></i>
                                Пользователи
                            </a>
                        <?php } ?>
                    <?php

                    $query = "SELECT login FROM users where id_role =3";
                    $result = mysqli_query($con, $query) or die(mysqli_error($con));
                    $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);

                    foreach ($rows as $row) {



                        if ($_COOKIE['login'] == $row['login']) {?>
                        <a class="dropdown-item py-1 d-flex align-items-center justify-content-between" href="/index.php?messages_users">
                            <i class="fa fa-envelope-open"></i>
                            Мои сообщения
                        </a>
                    <?php  break; //при первом совпадении
                    }
                     ?>
                        <?php } ?>


                  <div role="separator" class="dropdown-divider"></div>
                    <?php }?>
                  <h5 class="dropdown-header text-uppercase  pl-2 text-dark mt-2">Действия</h5>
                    <?php
                    if (isset($_COOKIE['login'])) {?>
                    <a class="dropdown-item py-1 d-flex align-items-center justify-content-between" href="/index.php?logout">
                        <span>Выйти</span>
                        <i class="mdi mdi-logout ml-1"></i>
                    </a>
                    <?php } else {?>
                  <a class="dropdown-item py-1 d-flex align-items-center justify-content-between" href="/login.php">
                    <span>Войти</span>
                    <i class="mdi mdi-lock ml-1"></i>
                  </a>
                    <?php } ?>
                </div>
              </div>
            </li>
              <?php
              if (isset($_COOKIE['login'])) {?>
              <li class="nav-item dropdown">
                  <a class="nav-link count-indicator dropdown-toggle" id="notificationDropdown" href="#" data-toggle="dropdown">
                      <i class="mdi mdi-bell-outline"></i>
                      <span class="count-symbol bg-danger" id = "symb"></span>
                  </a>

                  <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" id = "notifications" aria-labelledby="notificationDropdown">
                      <h6 class="p-3 mb-0 bg-primary text-white py-4">Уведомления</h6>
                      <div class="dropdown-divider"></div>


                  </div>
              </li>
              <?php } else {?>
              <?php } ?>

          </ul>
            <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
                <span class="mdi mdi-menu" style="color: white; font-size: 1.6rem "></span>
            </button>
        </div>
      </nav>
      <!-- partial -->
      <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_sidebar.html -->
       <?php include 'elements/navmenu/navmenu.php';?>
        <!-- partial -->
        <div class="main-panel">



            <?php
            foreach ($_GET as $key => $value) {
                $value = $key;
                break;
            }
            if(isset($value)){
                switch ($value) {
                    case 'application':
                        include 'api_application.php';
                        break;
                    case 'users':
                        include 'api_accreditation.php';
                        break;
                    case 'help':
                        include 'help.php';
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
                }
            }
            else{
                include 'main.php';
            }
            ?>
          <!-- content-wrapper ends -->
          <!-- partial:partials/_footer.html -->
          <footer class="footer">
            <div class="footer-inner-wraper">
              <div class="d-sm-flex justify-content-center justify-content-sm-between">
                <span class="text-muted d-block text-center text-sm-left d-sm-inline-block">Copyright © РНПЦ МТ 2023</span>
                <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center"> <a href="https://www.bootstrapdash.com/" target="_blank"></a> </span>
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
    <script>

        $(document).ready(function () {
            $('#example').DataTable({
                scrollY: '500px',
                scrollCollapse: true,
                paging: false,
            });
        });


    </script>

    <script>

        $(document).ready(function () {
            $('#table-2').DataTable({
                scrollY: 200,
                scrollX: true,
            });

            let example_filter = document.getElementById("example_filter");
            if(document.getElementById("nav2")){
                example_filter.classList.add("hiddentab");
            }
        });


    </script>




    <script>
        //window.onload = () => console.log('page is loaded');

        //const arr = [1,5,3,7,8,2,10,9,6];
        /*for (let i = 0; i< arr.length; i++) {
            for (let j = 0; j< arr.length-1; j++) {
                let c;
                if (arr[j] > arr[j+1]) {
                    c = arr[j];
                    arr[j] = arr[j+1];
                    arr[j+1] = c;
                }
            }
        }*/
        //arr.sort((a,b) => a-b);
        /*arr.forEach((el, ind) => {
            //console.log(arr[ind+1]);
            let c;
            if (ind < arr.length && el > arr[ind + 1]) {
                c = el;
                el = arr[ind + 1];
                arr[ind + 1] = c;
            }
        })*/
        //console.log(arr);

        const ourButton = document.querySelector('.navbar-toggler');
        //console.log(ourButton);
    </script>

    <!-- End custom js for this page -->
    <script>

        // let el = document.getElementById("nav5");
        // if (!el || el.children[0].href !== "/index.php?users" || !example_filter)
        //     example_filter.remove();
    </script>
  </body>
  <script type="text/javascript">
      // document.onkeydown = function(e) {
      //     if(event.keyCode == 123) {
      //         return false;
      //     }
      //     if(e.ctrlKey && e.shiftKey && e.keyCode == 'I'.charCodeAt(0)){
      //         return false;
      //     }
      //     if(e.ctrlKey && e.shiftKey && e.keyCode == 'J'.charCodeAt(0)){
      //         return false;
      //     }
      //     if(e.ctrlKey && e.keyCode == 'U'.charCodeAt(0)){
      //         return false;
      //     }
      //
      // }
      // document.addEventListener('contextmenu', function(e) {
      //     e.preventDefault();
      // });

  </script>
  <script>

      // fetch('getFiles.php?id_application=24', {
      //     method: 'GET'
      // })
      // .then(response => response.json())
      // .then(data => console.log(data));
  </script>
  <script>
      function getCookie(cname) {
          let name = cname + "=";
          let decodedCookie = decodeURIComponent(document.cookie);
          let ca = decodedCookie.split(';');
          for(let i = 0; i <ca.length; i++) {
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
  </script>

  <script>
      // Функция для получения и отображения уведомлений
      <?php
      if (isset($_COOKIE['login']))
      {?>

      function getNotifications() {
          let id_user = getCookie('id_user');
          let notif = document.getElementById("notifications");
          let symbol = document.getElementById("symb");
          $.ajax({
              url: "getNotifications.php",
              method: "GET",
              data: {id_user: id_user}

          })
              .done(function (response) {
                  // Очистка уведомлений
                  notif.innerHTML = " <h6 class='p-3 mb-0 bg-primary text-white py-4'>Уведомления</h6><div class='dropdown-divider'></div>";

                  var notifications = JSON.parse(response);
                  console.log (notifications);
                  if (notifications.length === 0) {
                      symbol.style.display = "none";
                      notif.innerHTML += "<p class='text-muted p-3'>Нет уведомлений</p>";
                  } else {
                      symbol.style.display = "block";
                      for (var i = 0; i < notifications.length; i++) {
                          var notification = notifications[i];
                          let idNot = notification['id_notifications'];
                          var html = "<a class='dropdown-item preview-item' onclick='markAsRead(" + idNot + ")'>";
                          html += '<div class="preview-thumbnail">';
                          html += '<div class="preview-icon bg-success">';
                          html += '<i class="mdi mdi-calendar"></i>';
                          html += '</div>';
                          html += '</div>';
                          html += '<div class="preview-item-content d-flex align-items-start flex-column justify-content-center">';
                          html += '<h6 class="preview-subject font-weight-normal mb-1">Новое уведомление</h6>';
                          html += '<p class="text-gray ellipsis mb-0" style="text-wrap: wrap; min-width: 250px">' + notification['text_notifications'] + '</p>';
                          html += '</div>';
                          html += '</a>';
                          html += '<div class="dropdown-divider"></div>';
                          notif.innerHTML += html;
                      }
                  }
              });
      }
      // Вызов функции getNotifications при нажатии на колокольчик
      $("#notificationDropdown").click(function () {
          getNotifications();
      });


      function markAsRead(notificationId) {

          $.ajax({
              url: "markNotificationAsRead.php",
              method: "POST",
              data: {notificationId: notificationId}
          })
              .done(function (response) {
                  // Обновляем список уведомлений после изменений
                  getNotifications();
              });
      }

      $(document).ready(function() {
          getNotifications(); //

          function checkNotifications() {
              let symbol = document.getElementById("symb");
              if (symbol.innerHTML === "") {
                  symbol.style.display = "none";
              } else {
                  symbol.style.display = "block";
              }
          }

          checkNotifications();
      });

      <?php } else {?>

      <?php } ?>

  </script>

</html>