<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="../assets/vendors/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="../assets/vendors/flag-icon-css/css/flag-icon.min.css">
    <link rel="stylesheet" href="../assets/vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <link rel="stylesheet" href="../assets/vendors/font-awesome/css/font-awesome.min.css" />
    <link rel="stylesheet" href="../assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css">
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <!-- endinject -->
    <!-- Layout styles -->
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="../dist/css/global.css" >
    <!-- End layout styles -->
    <link rel="shortcut icon" href="../assets/images/logo-rnpcmt.png" />

    <link rel="stylesheet" href="../dist/css/dataTables.bootstrap4.min.css">

    <script src="../dist/js/jquery-3.5.1.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

    <style>
        .hiden{
            display: none;
        }
    </style>
</head>
<body >
<?php
include '../connection.php';
$query = "SELECT `username`, login, `name`, last_time_online, last_page FROM users, roles where `users`.id_role = `roles`.id_role and online is not null";
$result=mysqli_query($con, $query) or die ( mysqli_error($con));
for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
?>


<div class="col-12">

    <div class="card hiden">
        <div class="card-header">
            <h3 class="card-title">Пользователи</h3>
        </div>
        <!-- /.card-header -->
        <div class="card-body">
            <table id="example1" class="table table-striped table-bordered">

                <thead>
                <tr>
                    <th>User</th>
                    <th>Login</th>
                    <th>Role</th>
                    <th>Last online</th>
                    <th>Last page</th>
                </tr>
                </thead>
                <tbody>

                <?php

                foreach ($data as $user) {

                    ?>

                    <tr style="cursor: pointer;">

                        <td><?= $user['username'] ?></td>
                        <td><?= $user['login'] ?></td>
                        <td><?= $user['name'] ?></td>
                        <td><?= $user['last_time_online'] ?></td>
                        <td><?= $user['last_page'] ?></td>

                    </tr>
                    <?php
                }
                ?>

                </tbody>
                <tfoot>
                <tr>
                    <th>User</th>
                    <th>Login</th>
                    <th>Role</th>
                    <th>Last online</th>
                    <th>Last page</th>
                </tr>
                </tfoot>
            </table>
        </div>
        <!-- /.card-body -->
    </div>


    <!-- /.card -->
</div>

<script src="../assets/vendors/js/vendor.bundle.base.js"></script>
<!-- endinject -->
<!-- Plugin js for this page -->
<script src="../assets/vendors/chart.js/Chart1.min.js"></script>
<script src="../assets/vendors/jquery-circle-progress/js/circle-progress.min.js"></script>
<!-- End plugin js for this page -->
<!-- inject:js -->
<script src="../assets/js/off-canvas.js"></script>
<script src="../assets/js/hoverable-collapse.js"></script>
<script src="../assets/js/misc.js"></script>
<!-- endinject -->
<!-- Custom js for this page -->
<script src="../assets/js/dashboard.js"></script>


<script src="../dist/js/jquery.dataTables.min.js"></script>
<script>
    function getCookie(name) {
        let matches = document.cookie.match(new RegExp("(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"));
        return matches ? decodeURIComponent(matches[1]) : undefined;
    }

    if (getCookie("login") === "hancharou@rnpcmt.by") {
        let card = document.getElementsByClassName("card hiden")[0];
        let card1 = document.getElementsByClassName("card hiden")[1];
        card.classList.remove("hiden");
        card1.classList.remove("hiden");
    }

</script>


</body>
</html>
