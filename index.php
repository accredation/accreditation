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
                <span style="margin-left: 3rem;font-size: 1.4rem;line-height: 3.9rem; "> Информационная система «Медицинская аккредитация»</span>
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
<!--            <li class="nav-item dropdown">-->
<!--              <a class="nav-link count-indicator dropdown-toggle" id="messageDropdown" href="#" data-toggle="dropdown" aria-expanded="false">-->
<!--                <i class="mdi mdi-email-outline"></i>-->
<!--                <span class="count-symbol bg-success"></span>-->
<!--              </a>-->
<!--              <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="messageDropdown">-->
<!--                <h6 class="p-3 mb-0 bg-primary text-white py-4">Messages</h6>-->
<!--                <div class="dropdown-divider"></div>-->
<!--                <a class="dropdown-item preview-item">-->
<!--                  <div class="preview-thumbnail">-->
<!--                    <img src="assets/images/faces/face4.jpg" alt="image" class="profile-pic">-->
<!--                  </div>-->
<!--                  <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">-->
<!--                    <h6 class="preview-subject ellipsis mb-1 font-weight-normal">Mark send you a message</h6>-->
<!--                    <p class="text-gray mb-0"> 1 Minutes ago </p>-->
<!--                  </div>-->
<!--                </a>-->
<!--                <div class="dropdown-divider"></div>-->
<!--                <a class="dropdown-item preview-item">-->
<!--                  <div class="preview-thumbnail">-->
<!--                    <img src="assets/images/faces/face2.jpg" alt="image" class="profile-pic">-->
<!--                  </div>-->
<!--                  <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">-->
<!--                    <h6 class="preview-subject ellipsis mb-1 font-weight-normal">Cregh send you a message</h6>-->
<!--                    <p class="text-gray mb-0"> 15 Minutes ago </p>-->
<!--                  </div>-->
<!--                </a>-->
<!--                <div class="dropdown-divider"></div>-->
<!--                <a class="dropdown-item preview-item">-->
<!--                  <div class="preview-thumbnail">-->
<!--                    <img src="assets/images/faces/face3.jpg" alt="image" class="profile-pic">-->
<!--                  </div>-->
<!--                  <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">-->
<!--                    <h6 class="preview-subject ellipsis mb-1 font-weight-normal">Profile picture updated</h6>-->
<!--                    <p class="text-gray mb-0"> 18 Minutes ago </p>-->
<!--                  </div>-->
<!--                </a>-->
<!--                <div class="dropdown-divider"></div>-->
<!--                <h6 class="p-3 mb-0 text-center">4 new messages</h6>-->
<!--              </div>-->
<!--            </li>-->
<!--            <li class="nav-item dropdown">-->
<!--              <a class="nav-link count-indicator dropdown-toggle" id="notificationDropdown" href="#" data-toggle="dropdown">-->
<!--                <i class="mdi mdi-bell-outline"></i>-->
<!--                <span class="count-symbol bg-danger"></span>-->
<!--              </a>-->
<!--              <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="notificationDropdown">-->
<!--                <h6 class="p-3 mb-0 bg-primary text-white py-4">Notifications</h6>-->
<!--                <div class="dropdown-divider"></div>-->
<!--                <a class="dropdown-item preview-item">-->
<!--                  <div class="preview-thumbnail">-->
<!--                    <div class="preview-icon bg-success">-->
<!--                      <i class="mdi mdi-calendar"></i>-->
<!--                    </div>-->
<!--                  </div>-->
<!--                  <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">-->
<!--                    <h6 class="preview-subject font-weight-normal mb-1">Event today</h6>-->
<!--                    <p class="text-gray ellipsis mb-0"> Just a reminder that you have an event today </p>-->
<!--                  </div>-->
<!--                </a>-->
<!--                <div class="dropdown-divider"></div>-->
<!--                <a class="dropdown-item preview-item">-->
<!--                  <div class="preview-thumbnail">-->
<!--                    <div class="preview-icon bg-warning">-->
<!--                      <i class="mdi mdi-settings"></i>-->
<!--                    </div>-->
<!--                  </div>-->
<!--                  <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">-->
<!--                    <h6 class="preview-subject font-weight-normal mb-1">Settings</h6>-->
<!--                    <p class="text-gray ellipsis mb-0"> Update dashboard </p>-->
<!--                  </div>-->
<!--                </a>-->
<!--                <div class="dropdown-divider"></div>-->
<!--                <a class="dropdown-item preview-item">-->
<!--                  <div class="preview-thumbnail">-->
<!--                    <div class="preview-icon bg-info">-->
<!--                      <i class="mdi mdi-link-variant"></i>-->
<!--                    </div>-->
<!--                  </div>-->
<!--                  <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">-->
<!--                    <h6 class="preview-subject font-weight-normal mb-1">Launch Admin</h6>-->
<!--                    <p class="text-gray ellipsis mb-0"> New admin wow! </p>-->
<!--                  </div>-->
<!--                </a>-->
<!--                <div class="dropdown-divider"></div>-->
<!--                <h6 class="p-3 mb-0 text-center">See all notifications</h6>-->
<!--              </div>-->
<!--            </li>-->
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
        });


    </script>


    <script src="dist/js/jquery.dataTables.min.js"></script>

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
</html>