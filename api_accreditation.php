<style>
    .rolledUp {
        width: 25px;
        transition: 2s linear;
    }

    .rightCardFS {
        width: 100%;
        transition: 2s linear;
    }

    .rightCard65 {
        width: 100%;
        transition: 2s linear;
    }

    .hiddentab {
        display: none;
    }

    .margleft {
        padding-left: 20px;
    }

    .inform {
        height: 20%;
        position: relative;
        display: flex;
        -webkit-box-orient: vertical;
        -webkit-box-direction: normal;
        flex-direction: column;
        min-width: 0;
        word-wrap: break-word;
        background-color: #fff;
        background-clip: border-box;
        border: 0px solid rgba(0, 0, 0, 0.125);
        border-radius: 0.3125rem;
        padding: 2.5rem 2.5rem;
    }

    .sovet {
        height: 60%;
        position: relative;
        display: flex;
        -webkit-box-orient: vertical;
        -webkit-box-direction: normal;
        flex-direction: column;
        min-width: 0;
        word-wrap: break-word;
        background-color: #fff;
        background-clip: border-box;
        border: 0px solid rgba(0, 0, 0, 0.125);
        border-radius: 0.3125rem;
        padding: 2.5rem 2.5rem;
    }

    #checkboxInput {
        transform: scale(1.2);
        font-weight: bold;
    }

    #formDateDorabotka {
        margin-left: 35px;
    }

    #formFileReportDorabotka {
        margin-left: 35px;
    }

    .history {
        display: flex;
        justify-content: center;
    }
</style>

<style>

    .container {
        padding: 0rem 0rem;
    }

    .leftSide {
        margin-left: 0;
        margin-right: 0;
    }

    h4 {
        margin: 2rem 0rem 1rem;
    }

    .table-image {

    td, th {
        vertical-align: middle;
    }

    }


    .modalHistoryCl {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: 1050;
        display: none;
        width: 38%;
        height: 100%;
        overflow: hidden;
        outline: 0;
    }

    .modalHistoryCl-body {
        max-height: 480px;
        width: 640px;
        overflow-y: auto;
    }

    .showcl {
        display: block;
    }

    .hiddentabcl {
        display: none;
    }


    .btn-dangers.btn-closes {
        background-color: transparent;
        border: none;
        font-size: 1.5rem;
        color: #dc3545; /* красный цвет */
        padding-right: 0;
        padding-left: 0;
    }

    .btn-dangers.btn-closes:hover {
        color: #b02a37; /* тёмно-красный цвет */
        background-color: transparent;
        border: none;
    }

    .btn-dangers {
        color: red;
    }

    .zvezda {
        color: red;
    }

</style>

<?php if (isset($_COOKIE['login'])) { ?>
    <div class="content-wrapper">
        <div class="row" id="proBanner">
            <div class="col-12">
                <!--    -->
            </div>
        </div>
        <div class="d-xl-flex justify-content-between align-items-start">
            <h2 class="text-dark font-weight-bold mb-2"> Заявления </h2>
            <div class="d-sm-flex justify-content-xl-between align-items-center mb-2">
                <?php
                $login = $_COOKIE['login']; ?>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="d-sm-flex justify-content-between align-items-center transaparent-tab-border ">
                    <ul class="nav nav-tabs tab-transparent" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="home-tab" data-toggle="tab" href="#allApps" role="tab"
                               aria-selected="true">Новые</a>
                        </li>
                        <li class="nav-item">

                            <a class="nav-link " id="rassmotrenie-tab" data-toggle="tab" href="#rassmotrenie" role="tab"
                               aria-selected="false">На рассмотрении</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="odobrennie-tab" data-toggle="tab" href="#" role="tab"
                               aria-selected="false">Завершена оценка</a>
                        </li>
                        <li class="nav-item hiddentab" >
                            <a class="nav-link" id="neodobrennie-tab" data-toggle="tab" href="#" role="tab"
                               aria-selected="false">На доработке</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="reshenieSoveta-tab" data-toggle="tab" href="#" role="tab"
                               aria-selected="false">Решение совета</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="accredArchiveNew-tab" data-toggle="tab" href="#" role="tab"
                               aria-selected="false">Архив</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" id="accredArchive-tab" data-toggle="tab" href="#" role="tab"
                               aria-selected="false">Архив 2023</a>
                        </li>

                    </ul>
                    <div class="d-md-block d-none">
                        <!--                        <a href="#" class="text-light p-1"><i class="mdi mdi-view-dashboard"></i></a>-->
                        <!--                        <a href="#" class="text-light p-1"><i class="mdi mdi-dots-vertical"></i></a>-->
                    </div>
                </div>
                <div class="tab-content tab-transparent-content">
                    <div class="tab-pane fade show active" id="allApps" role="tabpanel" aria-labelledby="home-tab">

                        <div class="row">
                            <div class="col-12 grid-margin">
                                <div class="card">
                                    <div class="card-body">

                                        <?php
                                        $query = "SELECT * FROM users where login = '$login'";

                                        $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
                                        if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                                        {
                                            $row = mysqli_fetch_assoc($rez);
                                            $role = $row['id_role'];
                                        }
                                        if ($role > 3 && $role < 12) {
                                            $query = "SELECT a.*, uz.username, uz.oblast, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join uz uz on uz.id_uz=a.id_user
                                                   where id_status = 2 and uz.oblast = '$role'";
                                        } else {
                                            $query = "SELECT a.*, uz.username, uz.oblast, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join uz uz on uz.id_uz=a.id_user
                                                   where id_status = 2";
                                        }
                                        $result = mysqli_query($con, $query) or die (mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row) ;
                                        ?>

                                        <table id="example" class="table table-striped table-bordered"
                                               style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Заявления</th>
                                                <th>Дата отправки</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                include "ajax/mainMark.php"
                                                /*                                                <tr onclick="showModal('<?= $app['app_id'] ?>', '<?= $str_CalcSelfMark ?>', '<?= $str_CalcSelfMarkAccred ?>')" style="cursor: pointer;">*/
                                                ?>

                                                <tr onclick="newShowModal('<?= $app['app_id'] ?>')"
                                                    style="cursor: pointer;">

                                                    <td>
                                                        Заявление <?= $app['username'] ?>  <?= $app['id_rkk'] == "0" ? "№" . $app['app_id'] : "" ?></td>
                                                    <td><?= $app['date_send'] ?></td>


                                                </tr>
                                                <?php
                                            }
                                            ?>

                                            </tbody>

                                        </table>


                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>


                <div class="tab-content tab-transparent-content">
                    <div class="tab-pane fade" id="rassmotrenie" role="tabpanel" aria-labelledby="rassmotrenie-tab">
                        <div class="row">
                            <div class="col-12 grid-margin">
                                <div class="card">
                                    <div class="card-body">

                                        <?php
                                        //                                        $login = $_COOKIE['login'];
                                        //                                        $insertquery = "SELECT * FROM users WHERE login='$login'";
                                        //
                                        //                                        $rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
                                        //                                        $username = "";
                                        //                                        if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                                        //                                        {
                                        //                                            $row = mysqli_fetch_assoc($rez);
                                        //                                            $id = $row['id_user'];
                                        //                                            $username = $row['username'];
                                        //                                        }
                                        $query = "SELECT * FROM users where login = '$login'";

                                        $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
                                        if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                                        {
                                            $row = mysqli_fetch_assoc($rez);
                                            $role = $row['id_role'];
                                        }
                                        if ($role > 3 && $role < 12) {
                                            $query = "SELECT a.*, uz.username, uz.oblast, ram.*, a.id_application as app_id, rkk.date_reg
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join uz uz on uz.id_uz=a.id_user
                                                    left outer join rkk on rkk.id_rkk=a.id_rkk  
                                                   where id_status = 3 and u.oblast = '$role'";
                                        } else {
                                            $query = "SELECT a.*, uz.username, uz.oblast, ram.*, a.id_application as app_id, rkk.date_reg
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join uz uz on uz.id_uz=a.id_user
                                                    left outer join rkk on rkk.id_rkk=a.id_rkk   
                                                    where id_status = 3";
                                        }
                                        $result = mysqli_query($con, $query) or die (mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row) ;
                                        ?>

                                        <table id="example" class="table table-striped table-bordered"
                                               style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Заявления</th>
                                                <th>Дата регистрации</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                include "ajax/mainMark.php";
                                                ?>

                                                <tr onclick="newShowModal('<?= $app['app_id'] ?>')"
                                                    style="cursor: pointer;">


                                                    <td>Заявление <?= $app['username'] ?> №<?= $app['app_id'] ?></td>
                                                    <td><?= $app['date_reg'] ?></td>


                                                </tr>
                                                <?php
                                            }
                                            ?>

                                            </tbody>

                                        </table>


                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>


                <div class="tab-content tab-transparent-content">
                    <div class="tab-pane fade" id="odobrennie" role="tabpanel" aria-labelledby="odobrennie-tab">
                        <div class="row">
                            <div class="col-12 grid-margin">
                                <div class="card">
                                    <div class="card-body">

                                        <?php
                                        $query = "SELECT * FROM users where login = '$login'";

                                        $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
                                        if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                                        {
                                            $row = mysqli_fetch_assoc($rez);
                                            $role = $row['id_role'];
                                        }
                                        if ($role > 3 && $role < 12) {
                                            $query = "SELECT a.*, uz.username, uz.oblast, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join uz uz on uz.id_uz=a.id_user
                                                   where id_status = 4 and u.oblast = '$role'";
                                        } else {

                                            $query = "SELECT a.*, uz.username, uz.oblast, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join uz uz on uz.id_uz=a.id_user where id_status = 4";
                                        }
                                        $result = mysqli_query($con, $query) or die (mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row) ;
                                        ?>

                                        <table id="example" class="table table-striped table-bordered"
                                               style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Заявления</th>
                                                <th>Дата одобрения</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                include "ajax/mainMark.php";
                                                ?>

                                                <tr onclick="newShowModal('<?= $app['app_id'] ?>')"
                                                    style="cursor: pointer;">


                                                    <td>Заявление <?= $app['username'] ?> №<?= $app['app_id'] ?></td>
                                                    <td><?= $app['date_complete'] ?></td>


                                                </tr>
                                                <?php
                                            }
                                            ?>

                                            </tbody>

                                        </table>


                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>


                <div class="tab-content tab-transparent-content">
                    <div class="tab-pane fade" id="neodobrennie" role="tabpanel" aria-labelledby="neodobrennie-tab">
                        <div class="row">
                            <div class="col-12 grid-margin">
                                <div class="card">
                                    <div class="card-body">

                                        <?php
                                        $query = "SELECT * FROM users where login = '$login'";

                                        $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
                                        if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                                        {
                                            $row = mysqli_fetch_assoc($rez);
                                            $role = $row['id_role'];
                                        }
                                        if ($role > 3 && $role < 12) {
                                            $query = "SELECT a.*, uz.username, uz.oblast, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join uz uz on uz.id_uz=a.id_user
                                                   where id_status = 5 and u.oblast = '$role'";
                                        } else {

                                            $query = "SELECT a.*, uz.username, uz.oblast, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join uz uz on uz.id_uz=a.id_user where id_status = 5";
                                        }
                                        $result = mysqli_query($con, $query) or die (mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row) ;
                                        ?>

                                        <table id="example" class="table table-striped table-bordered"
                                               style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Заявления</th>
                                                <th>Дата доработки</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                include "ajax/mainMark.php";
                                                ?>

                                                <tr onclick="newShowModal('<?= $app['app_id'] ?>')"
                                                    style="cursor: pointer;">


                                                    <td>Заявление <?= $app['username'] ?> №<?= $app['app_id'] ?></td>
                                                    <td><?= $app['dateInputDorabotki'] ?></td>


                                                </tr>
                                                <?php
                                            }
                                            ?>

                                            </tbody>

                                        </table>


                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>


                <div class="tab-content tab-transparent-content">
                    <div class="tab-pane fade" id="reshenieSoveta" role="tabpanel" aria-labelledby="reshenieSoveta-tab">
                        <div class="row">
                            <div class="col-12 grid-margin">
                                <div class="card">
                                    <div class="card-body">

                                        <?php
                                        $query = "SELECT * FROM users where login = '$login'";

                                        $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
                                        if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                                        {
                                            $row = mysqli_fetch_assoc($rez);
                                            $role = $row['id_role'];
                                        }
                                        if ($role > 3 && $role < 12) {
                                            $query = "SELECT a.*, uz.username, uz.oblast, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join uz uz on uz.id_uz=a.id_user
                                                   where id_status = 6 and u.oblast = '$role'";
                                        } else {
                                            $query = "SELECT a.*, uz.username, uz.oblast, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join uz uz on uz.id_uz=a.id_user
                                                   where id_status = 6";
                                        }
                                        $result = mysqli_query($con, $query) or die (mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row) ;
                                        ?>

                                        <table id="example" class="table table-striped table-bordered"
                                               style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Заявления</th>
                                                <th>Дата решения совета</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                include "ajax/mainMark.php"
                                                ?>

                                                <tr onclick="newShowModal('<?= $app['app_id'] ?>')"
                                                    style="cursor: pointer;">

                                                    <td>Заявление <?= $app['username'] ?> №<?= $app['app_id'] ?></td>
                                                    <td><?= $app['date_council'] ?></td>


                                                </tr>
                                                <?php
                                            }
                                            ?>

                                            </tbody>

                                        </table>


                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>




                <div class="tab-content tab-transparent-content">
                    <div class="tab-pane fade" id="accredArchiveNew" role="tabpanel" aria-labelledby="accredArchiveNew-tab">
                        <div class="row">
                            <div class="col-12 grid-margin">
                                <div class="card">
                                    <div class="card-body">

                                        <?php
                                        $query = "SELECT * FROM users where login = '$login'";

                                        $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
                                        if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                                        {
                                            $row = mysqli_fetch_assoc($rez);
                                            $role = $row['id_role'];
                                        }
                                        if ($role > 3 && $role < 12) {
                                            $query = "SELECT a.*, uz.username, uz.oblast, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join uz uz on uz.id_uz=a.id_user
                                                   where id_status = 9 and u.oblast = '$role'";
                                        } else {
                                            $query = "SELECT a.*, uz.username, uz.oblast, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join uz uz on uz.id_uz=a.id_user
                                                   where id_status = 9";
                                        }
                                        $result = mysqli_query($con, $query) or die (mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row) ;
                                        ?>

                                        <table id="example" class="table table-striped table-bordered"
                                               style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Заявления</th>
                                                <th>Дата решения совета</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                include "ajax/mainMark.php"
                                                ?>

                                                <tr onclick="newShowModal('<?= $app['app_id'] ?>')"
                                                    style="cursor: pointer;">

                                                    <td>Заявление <?= $app['username'] ?> №<?= $app['app_id'] ?></td>
                                                    <td><?= $app['date_council'] ?></td>


                                                </tr>
                                                <?php
                                            }
                                            ?>

                                            </tbody>

                                        </table>


                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>





                <div class="tab-content tab-transparent-content">
                    <div class="tab-pane fade" id="accredArchive" role="tabpanel" aria-labelledby="accredArchive-tab">
                        <div class="row">
                            <div class="col-12 grid-margin">
                                <div class="card">
                                    <div class="card-body">

                                        <?php
                                        $query = "SELECT * FROM users where login = '$login'";

                                        $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
                                        if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                                        {
                                            $row = mysqli_fetch_assoc($rez);
                                            $role = $row['id_role'];
                                        }
                                        if ($role > 3 && $role < 12) {
                                            $query = "SELECT a.*, uz.username, uz.oblast, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join uz uz on uz.id_uz=a.id_user
                                                   where id_status = 8 and u.oblast = '$role'";
                                        } else {
                                            $query = "SELECT a.*, uz.username, uz.oblast, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join uz uz on uz.id_uz=a.id_user
                                                   where id_status = 8";
                                        }
                                        $result = mysqli_query($con, $query) or die (mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row) ;
                                        ?>

                                        <table id="example" class="table table-striped table-bordered"
                                               style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Заявления</th>
                                                <th>Дата решения совета</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                include "ajax/mainMark.php"
                                                ?>

                                                <tr onclick="showModal('<?= $app['app_id'] ?>', '<?= $str_CalcSelfMark ?>', '<?= $str_CalcSelfMarkAccred ?>')"
                                                    style="cursor: pointer;">

                                                    <td>Заявление <?= $app['username'] ?> №<?= $app['app_id'] ?></td>
                                                    <td><?= $app['date_council'] ?></td>


                                                </tr>
                                                <?php
                                            }
                                            ?>

                                            </tbody>

                                        </table>


                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
    <div class="modal" id="myModal">
        <div class="modal-dialog modal-lg" style="max-width: none; margin: 0;">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <div style="display: flex">
                        <h4 class="modal-title">Создание заявления</h4>
                        <h4 id="id_application" style="margin-left: 5px"></h4>
                    </div>

                    <div style="display: flex">
                        <div style="margin-right: 1rem; margin-top: 10px;">
                            <h5 style="display: contents;" id="timeLeftSession"></h5>
                        </div>

                        <button type="button" class="btn  btn-danger btn-close closeX" data-bs-dismiss="modal">x
                        </button>
                    </div>
                </div>

                <!-- Modal body -->
                <div class="modal-body">


                    <div class="col-md-12">
                        <div class="d-sm-flex justify-content-between align-items-center transaparent-tab-border ">
                            <ul class="nav nav-tabs tab-transparent" role="tablist" id="tablist">
                                <li class="nav-item" id="tab1" onclick="showTab(this)">
                                    <button class="nav-link active" data-toggle="tab" href="#" role="tab"
                                            aria-selected="true" id="button1">Общие сведения о заявителе
                                    </button>
                                </li>


                                <!--                            ...-->
                            </ul>
                            <div class="d-md-block d-none">
                                <!--                                <a href="#" class="text-light p-1"><i class="mdi mdi-view-dashboard"></i></a>-->
                                <!--                                <a href="#" class="text-light p-1"><i class="mdi mdi-dots-vertical"></i></a>-->
                            </div>
                        </div>
                        <div class="tab-content tab-transparent-content">
                            <div class="tab-pane fade show active" id="tab1-" role="tabpanel"
                                 aria-labelledby="business-tab">

                                <div class="row">
                                    <div class="col-6 grid-margin">
                                        <div class="card">
                                            <div class="card-body">

                                                <div class="form-group"><label>Наименование юридического
                                                        лица</label><input id="naim" type="text" class="form-control"
                                                                           readonly/></div>
                                                <div class="form-group"><label>Сокращенное наименование</label><input
                                                            class="form-control" id="sokr" type="text" readonly/></div>
                                                <div class="form-group"><label>УНП</label><input class="form-control"
                                                                                                 type="text" id="unp"
                                                                                                 onfocusout="onInputUnp()"
                                                                                                 readonly/></div>
                                                <div class="form-group"><label>Юридический адрес</label><input
                                                            class="form-control" type="text" id="adress"
                                                            onfocusout="onInputAdress()" readonly/></div>
                                                <div class="form-group"><label>Фактический адрес</label><input
                                                            class="form-control" type="text" id="adressFact"
                                                            onfocusout="onInputAdressFact()" readonly/></div>
                                                <div class="form-group"><label>Номер телефона</label><input
                                                            class="form-control" id="tel" type="text" readonly/></div>
                                                <div class="form-group"><label>Электронная почта</label><input
                                                            class="form-control" type="email" id="email"
                                                            onfocusout="onInputEmail()" readonly/></div>
                                                <div class="form-group">
                                                    <select name="" id="lico" onchange="chengeLico(this)"
                                                            disabled="true">
                                                        <option value="0">Выбрать ответственное лицо</option>
                                                        <option value="1">Руководитель</option>
                                                        <option value="2">Представитель</option>
                                                    </select>
                                                </div>
                                                <div id="rukDiv" class="form-group hiddentab">
                                                    <label>Руководитель</label><input class="form-control" type="text"
                                                                                      id="rukovoditel"
                                                                                      placeholder="Должность, ФИО"
                                                                                      readonly/></div>
                                                <div id="predDiv" class="form-group hiddentab">
                                                    <label>Представитель</label><input class="form-control" type="text"
                                                                                       id="predstavitel"
                                                                                       placeholder="Должность, ФИО"
                                                                                       readonly/></div>
                                                <form id="formDoverennost" class="hiddentab">
                                                    <div class="form-group" id="divDoverennost">
                                                        <label for="doverennost">Доверенность</label>
                                                        <div id="doverennost"></div>
                                                    </div>
                                                </form>
                                                <form id="formPrikazNaznach" class="hiddentab">
                                                    <div class="form-group" id="divPrikazNaznach">
                                                        <label for="prikazNaznach">Приказ о назначении
                                                            руководителя</label>

                                                        <div id="prikazNaznach"></div>
                                                    </div>
                                                </form>
                                                <br/>
                                                <div class="form-group"><label style="font-size: 18px">Обязательные
                                                        документы</label></div>

                                                <form id="formSoprovodPismo">
                                                    <div class="form-group" id="divSoprovodPismo">
                                                        <label for="soprPismo">Сопроводительное письмо</label><br/>
                                                        <input type="file" class="form-control-file hiddentab"
                                                               name="Name" id="soprPismo" disabled="true">
                                                    </div>
                                                </form>

                                                <form id="formCopyRaspisanie">
                                                    <div class="form-group" id="divCopyRaspisanie">
                                                        <label for="copyRaspisanie">Копия штатного
                                                            расписания</label><br/>
                                                        <input type="file" class="form-control-file hiddentab"
                                                               name="Name" id="copyRaspisanie" disabled="true">
                                                    </div>
                                                </form>

                                                <form id="formOrgStrukt">
                                                    <div class="form-group" id="divOrgStrukt">
                                                        <label for="orgStrukt">Организационная структура</label><br/>
                                                        <input type="file" class="form-control-file hiddentab"
                                                               id="orgStrukt" disabled="true">
                                                    </div>
                                                </form>

                                                <form id="formUcomplect">
                                                    <div class="form-group" id="divUcomplect">
                                                        <label for="ucomplect">Укомплектованность</label><br/>
                                                        <input type="file" class="form-control-file hiddentab"
                                                               id="ucomplect">
                                                    </div>
                                                </form>

                                                <form id="formTechOsn">
                                                    <div class="form-group" id="divTechOsn">
                                                        <label for="techOsn">Техническое оснащение</label><br/>
                                                        <input type="file" class="form-control-file hiddentab"
                                                               id="techOsn">
                                                    </div>
                                                </form>

                                                <form id="formFileReportSamoocenka">
                                                    <div class="form-group" id="divFileReportSamoocenka">
                                                        <label for="reportSamoocenka">Результат самооценки</label><br/>
                                                        <input type="file" class="form-control-file hiddentab"
                                                               id="reportSamoocenka" disabled="true">
                                                    </div>
                                                </form>

                                                <form id="formFileReportZakluchenieSootvet">
                                                    <div class="form-group " id="divFileReportZakluchenieSootvet">
                                                        <label for="reportZakluchenieSootvet">Заключение о соответствии
                                                            помещений государственных организаций здравоохранения и
                                                            созданных в них условий требованиям законодательства в
                                                            области санитарно-эпидемиологического благополучия
                                                            населения</label>
                                                        <div id="reportZakluchenieSootvet"></div>

                                                    </div>
                                                </form>
                                                <!--                                                <button class="btn-inverse-info" onclick="addTab()">+ добавить структурное подразделение</button>-->
                                                <br/>
                                                <br/>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6 grid-margin">


                                        <div class="inform" id="informgr">
                                            <div class="newform-group" id="infile">
                                                <label>Информация о необходимости доработки(нажмите на поле ввода, чтобы
                                                    присоединить файл)</label>
                                                <input id="infdorabotki" type="text" class="form-control" readonly/>
                                                <input type="file" id="fileInputDorabotka" style="display: none;"
                                                       accept=".pdf">
                                            </div>
                                            <br>
                                            <div class="newform-group">
                                                <label>Срок доработки (дата)</label>
                                                <input id="dateInputDorabotki" type="date" class="form-control">
                                            </div>
                                            <br>
                                            <div class="newform-group">
                                                <input type="checkbox" id="checkboxInput"
                                                       style="margin-right: 1rem"><label>Отправить уведомление на
                                                    электронную почту ОЗ</label>

                                            </div>


                                        </div>

                                        <div class="sovet" id="sovetgr">

                                            <div class="newform-group" id="protfile">
                                                <label>Протокол Совета (Проект)</label>
                                                <input id="protokolsoveta" type="text" class="form-control" readonly/>
                                                <input type="file" id="fileInputProtokol" style="display: none;"
                                                       accept=".pdf">
                                            </div>
                                            <br>
                                            <div class="newform-group" id="zaklfile">
                                                <label>Заключение Совета (Проект)</label>
                                                <input id="zaklsoveta" type="text" class="form-control" readonly/>
                                                <input type="file" id="fileInputZakl" style="display: none;"
                                                       accept=".pdf">
                                            </div>
                                            <br>
                                            <div class="newform-group">
                                                <label>Запланировать дату Совета</label>
                                                <input id="dateInputPlan" type="date" class="form-control">
                                            </div>
                                            <br>
                                            <div class="newform-group">
                                                <label for="resolution">Решение совета</label>
                                                <select id="resolution" class="form-control">
                                                    <option value="Соответствует">Соответствует</option>
                                                    <option value="Частично соответствует">Частично соответствует
                                                    </option>
                                                    <option value="Не соответствует">Не соответствует</option>
                                                </select>

                                            </div>
                                            <br>
                                            <div class="newform-group">
                                                <label>Срок решения</label>
                                                <input id="dateInputSrok" type="date" class="form-control">
                                            </div>
                                            <br>
                                            <button type="submit" class="btn btn-light btn-fw" id="btnSaveSovet">
                                                Сохранить
                                            </button>
                                        </div>


                                        <div class="card">
                                            <div class="card-body" id="mainRightCard">

                                            </div>

                                            <form id="formReport">
                                                <div class="form-group" id="divReport" style="margin-left: 2.5rem">
                                                    <label for="" style="font-size: 24px">Отчет</label><br/>
                                                    <input type="file"  class="form-control-file"
                                                           id="fileReport" multiple>
                                                </div>
                                                <div id="filesContainer" style="margin-left: 50px;  margin-top: -15px;"></div>
                                            </form>


                                            <form id="formFileReportDorabotka">
                                                <div class="form-group " id="divFileReportDorabotka"
                                                     style="margin-bottom: 0px;">
                                                    <label for="reportDorabotka">Информация о необходимости
                                                        доработки</label>
                                                </div>
                                            </form>
                                            <br>
                                            <form id="formDateDorabotka">
                                                <div class="form-group " id="divDateDorabotka"
                                                     style="margin-bottom: 0px;">
                                                    <label for="dateDorabotka">Срок доработки</label>
                                                </div>
                                            </form>
                                            <br>


                                            <div class="history">
                                                <button class="btn btn-success" id="history" onclick="showHistory()">
                                                    История заявления
                                                </button>
                                            </div>

                                        </div>

                                    </div>


                                    <div style="width: 100%">
                                        <div style="display:flex; justify-content: flex-end;">
                                            <!--                                            <button type="submit" class="btn btn-warning btn-fw" id="btnSuc" >Сохранить</button>-->
                                        </div>
                                    </div>

                                </div>

                            </div>

                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button"  class="btn btn-danger" data-bs-dismiss="modal" onclick="toArchive(1)">Отзыв заявления</button>
                    <button type="button"  class="btn btn-danger" data-bs-dismiss="modal" onclick="toArchive(2)">Отзказ в принятии</button>
                </div>
                <div class="modal-footer" style="margin-top: 3rem">
                    <!--                <form action="getApplication.php" method="post">-->
                    <!--                    <input type="text" name="count" id="count"/>-->
                    <!--                <p id="btnSuc" style="cursor: pointer">Загрузить данные</p>-->

                    <button type="submit" class="btn btn-success btn-fw hiddentab" id="btnChecking">На рассмотрение
                    </button>

                    <button type="submit" class="btn btn-success btn-fw hiddentab" id="btnOk">Завершить оценку</button>
                    <?php if($_COOKIE['login'] == 'kuznec@rnpcmt.by') { ?>
                    <button type="submit" class="btn btn-warning" onclick="setNewStatus()">Отзыв</button>
                    <?php }?>
                    <button type="submit" class="btn btn-success btn-fw hiddentab" id="btnOkReshenie">Решение совета
                    </button>

                    <!--                    <button type="submit" class="btn btn-danger hiddentab" id="btnNeOk">На доработку</button>-->
                    <button type="submit" class="btn btn-danger hiddentab" id="btnOkonchatelnoeReshenie">Окончательное
                        решение
                    </button>
                    <button type="submit"  class="btn btn-light btn-fw" id="btnFormApplication">Форма заявления</button>

                    <button type="submit" class="btn btn-light btn-fw" id="btnPrint">Печать</button>
                    <button type="submit" class="btn btn-light btn-fw" id="btnPrintReport">Сформировать отчет</button>
                    <button type="submit" class="btn btn-light btn-fw" id="btnCalc">Рассчитать результат соответствия
                    </button>

                    <!--                </form>-->
                    <button type="button" class="btn btn-danger closeD" id="closerModal" data-bs-dismiss="modal">
                        Закрыть
                    </button>
                </div>

            </div>
        </div>
    </div>


    <div class="modalHistoryCl" id="modalHistory">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">История заявления</h4><h4 class="modal-title hiddentab" id="app_id"></h4>
                    <button type="button" class="btn  btn-dangers btn-closes" data-bs-dismiss="modal">x</button>
                </div>

                <!-- Modal body -->
                <div class="modalHistoryCl-body">


                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-dangers" data-bs-dismiss="modal">Закрыть</button>
                </div>

            </div>
        </div>
    </div>


    <div class="modal" id="modalUcomplect">
        <div class="modal-dialog " style="max-width: 80vw;">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <div style="display: flex">
                        <h4 class="modal-title">Укомплектованность</h4>
                    </div>

                    <div style="display: flex">

                        <button type="button" class="btn  btn-danger btn-close  closeXucomplect"
                                data-bs-dismiss="modal">x
                        </button>
                    </div>
                </div>

                <!-- Modal body -->
                <div class="modal-body">


                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-light btn-fw" id="printUcomp" data-bs-dismiss="modal"
                            onclick="printModalContent()">Печать
                    </button>

                    <button type="button" class="btn btn-danger closeUcomplect" data-bs-dismiss="modal">Закрыть</button>
                </div>

            </div>
        </div>
    </div>


    <!-- RKK -->

    <div class="modal" id="modalRkk">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">

                    <h4 class="modal-title" id="sokr_name">Регистрация заявления </h4>
                    <button type="button" id="closexRkk" class="btn  btn-dangers btn-closes" data-bs-dismiss="modal">x
                    </button>
                </div>
                <!-- Modal body -->
                <div class="modalRkkbody">

                    <div class="row">
                        <div class="col-6 grid-margin">
                            <div class="card">
                                <div class="card-body">

                                    <div class="newform-group">
                                        <label>Дата регистрации<span class="zvezda">*</span></label>
                                        <input id="dateRegistr" type="date" class="form-control" required disabled="true"/>
                                    </div>
                                    <br>


                                    <div class="form-group"><label>В заявлении листов<span
                                                    class="zvezda">*</span></label><input id="countlist" type="text"
                                                                                          class="form-control"
                                                                                          required disabled="true"/></div>
                                    <div class="form-group"><label>Техническое оснащение<span
                                                    class="zvezda">*</span></label><input class="form-control"
                                                                                          id="tech_osn_rkk" type="text"
                                                                                          required disabled="true"/></div>
                                    <div class="form-group"><label>Штатное расписание<span
                                                    class="zvezda">*</span></label><input class="form-control"
                                                                                          type="text" id="stat_rasp"
                                                                                          required disabled="true"/></div>
                                    <div class="form-group"><label>Укомплектованность<span
                                                    class="zvezda">*</span></label><input class="form-control"
                                                                                          type="text" id="ucomp_rkk"
                                                                                          required disabled="true"/></div>
                                    <div class="form-group"><label>Отчет о самоакредитации<span class="zvezda">*</span></label><input
                                                class="form-control" type="text" id="report_samoacred" required disabled="true"/></div>
                                    <div class="form-group"><label>Дополнительные сведения</label><input
                                                class="form-control" id="dop_sved" type="text" disabled="true"/></div>

                                    <div class="form-group"><label>Представитель заинтересованного лица (ФИО, должность)<span
                                                    class="zvezda">*</span></label><input class="form-control"
                                                                                          type="text" id="predst_rkk"
                                                                                          required disabled="true"/></div>
                                    <div class="form-group">
                                        <label>Заявление<span class="zvezda">*</span></label>
                                        <select class="form-control" name="" id="perv_vtor_zayav" disabled="true">
                                            <option value="0" >Выбор</option>
                                            <option value="1">Первичное</option>
                                            <option value="2">Вторичное</option>
                                        </select>

                                    </div>
                                    <div class="form-group"><label>Регистрационный индекс -</label><span
                                                id="reg_index" ></span></div>
                                    <div class="form-group"><label>Даты, индексы повторных заявлений</label><input
                                                class="form-control" id="povtor_index" type="text" disabled="true"/></div>

                                    <div class="form-group">
                                        <label for="checkboxValue">Разрешить для ГУЗО</label>
                                        <input type="checkbox" id="checkboxValueGuzo" name="checkboxValueGuzo" value="0" disabled="true" onchange="guzoChange(this)"/>
                                    </div>

                                   </div>

                            </div>
                        </div>


                        <div class="col-6 grid-margin">
                            <div class="card">
                                <div class="card-body">

                                    <div class="form-group"><label>Информация о направлении запросов и в другие
                                            организации</label><input id="info_napr_zapr" type="text"
                                                                      class="form-control" disabled="true"/></div>
                                    <div class="form-group"><label>Информация о согласии заинтересованного лица на
                                            предоставление документа</label><input id="info_sogl" type="text"
                                                                                   class="form-control" disabled="true"/></div>
                                    <div class="form-group" style="display: flex;"><label>Протокол заседания комиссии
                                            №</label><input id="protolol_zasedanie" type="text" class="form-control" disabled="true"/>
                                        <label style="margin-left: 1rem;
    margin-right: 1rem;
    margin-top: 1rem;">Дата</label> <input id="date_zasedanie" type="date" class="form-control"
                                           style="max-width: 30%;" disabled="true" />
                                    </div>
                                    <div class="form-group"><label>Информация о возврате заявления при отказе в
                                            принятии</label><input id="info_vozvrat" type="text" class="form-control" disabled="true"/>
                                    </div>
                                    <div class="form-group"><label>Информация об отзыве заявления</label><input
                                                id="info_otzyv" type="text" class="form-control" disabled="true"/></div>
                                    <div class="form-group" style="display: flex;  "><label style="margin-right:1rem">Административное
                                            решение №</label><span id="admin_resh"></span>
                                        <label style="margin-left: 1rem;
    margin-right: 1rem;
    margin-top: 1rem;">Дата</label><input id="date_admin_resh" type="date" class="form-control" disabled="true"/>
                                        <label style="margin-left: 1rem;
    margin-right: 1rem;
    margin-top: 1rem;">Листов</label><input id="count_admin_resh" type="text" class="form-control" disabled="true"/>
                                    </div>
                                    <div class="form-group" style="display: flex;  "><label style="margin-right:1rem">Результат</label><input id="resultat" type="text" class="form-control" disabled="true"/>
                                    </div>
                                    <div class="form-group" style="display: flex;"><label style="margin-right:1rem">Свидетельство
                                            №</label><input id="svidetelstvo" type="text" class="form-control"/>
                                        <label style="margin-left: 1rem;
    margin-right: 1rem;
    margin-top: 1rem;">Дата</label><input id="date_svidetelstvo" type="date" class="form-control" disabled="true"/>
                                        <label style="margin-left: 1rem;
    margin-right: 1rem;
    margin-top: 1rem;">по №</label><input id="po_n" type="text" class="form-control" disabled="true"/>
                                        <label style="margin-left: 1rem;
    margin-right: 1rem;
    margin-top: 1rem;">Листов</label><input id="count_svidetelstvo" type="text" class="form-control" disabled="true"/>
                                    </div>

                                    <div class="form-group"><label>Информация об уведомлении заинтересованного
                                            лица</label><input id="info_uved" type="text" class="form-control" disabled="true"/></div>
                                    <div class="form-group " style="display: flex; justify-content: space-between;">
                                        <label style="

    margin-top: 1rem;">Отчет о медицинской аккредитации</label>
                                        <div style="display:flex"><label style="margin-left: 1rem;
    margin-right: 1rem;
    margin-top: 1rem;">Листов</label><input id="count_medacr" type="text" class="form-control" disabled="true"/></div>
                                    </div>
                                    <div class="form-group"><label>Получил на руки (ФИО, должность)</label><input
                                                id="getter" type="text" class="form-control" disabled="true"/></div>
                                    <div class="form-group" style="display: flex;"><label style="
    margin-right: 1rem;
    margin-top: 1rem;">В дело №</label><input id="delo" type="text" class="form-control" style="max-width: 31%;" disabled="true"/>
                                        <label style="
    margin-right: 1rem;
    margin-top: 1rem;">Листов</label><input id="delo_listov" type="text" class="form-control" style="max-width: 31%;" disabled="true"/>
                                        <span style="margin-left: 1rem;

    margin-top: 1rem;" id = "kontrol">Снято с контроля</span>
                                        <label style="margin-left: 1rem;
    margin-right: 1rem;
    margin-top: 1rem;">Дата</label>
                                        <input id="date_delo" type="date" class="form-control" style="max-width: 30%;" disabled="true"/>
                                    </div>

                                    <div class="form-group"><label>Дополнительная информация</label> <input
                                                id="dop_info" type="text" class="form-control" disabled="true" /></div>

                                </div>
                            </div>
                        </div>


                        <div style="width: 100%">
                            <div style="display:flex; justify-content: flex-end;">
                                <button type="button" class="btn btn-success" id="registerRkk" style="margin-right: 10px" onclick="regRkk()">
                                    Зарегистрировать
                                </button>
                                <button type="button" class="btn btn-warning" id="" style="margin-right: 10px">Отмена
                                </button>
                                <button type="button" class="btn btn-primary" id="" style="margin-right: 10px" onclick="saveRkk()">
                                    Сохранить
                                </button>
                                <button type="button" class="btn btn-secondary" id="" onclick="printRkk()" style="margin-right: 10px">
                                    Печать
                                </button>
                                <button type="button" class="btn btn-info" id="" style="margin-right: 20px">Снять с
                                    контроля
                                </button>
                            </div>
                        </div>

                    </div>


                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" id="closeRkk" class="btn btn-dangers" data-bs-dismiss="modal">Закрыть</button>
                </div>

            </div>
        </div>
    </div>

    <!-- RKK -->


    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>

    <!--<script>--><?php //include 'getApplication.php' ?><!--</script>-->
    <!--<script>console.log(filesName)</script>-->
    <script src="dist/js/formAccreditation.js"></script>
    <script src="dist/js/newFormAccreditation.js"></script>

<?php } else { ?>
    <div class="content-wrapper">
        <div class="row" id="proBanner">
            <div class="col-12">
                <!--    -->
            </div>
        </div>
        <div class="d-xl-flex justify-content-between align-items-start">
            <h2 class="text-dark font-weight-bold mb-2"> Требуется авторизация </h2>
        </div>
    </div>

<?php } ?>