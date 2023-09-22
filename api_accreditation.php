<style>
    .rolledUp{
        width: 25px;
        transition: 2s linear;
    }

    .rightCardFS{
        width: 100%;
        transition: 2s linear;
    }

    .rightCard65{
        width: 100%;
        transition: 2s linear;
    }

    .hiddentab{
        display: none;
    }
    .margleft{
        padding-left: 20px;
    }
    .inform{
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

    .sovet{
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

</style>
<?php if(isset($_COOKIE['login'])){?>
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
                $login = $_COOKIE['login'];
                $query = "SELECT * FROM applications";

                $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
                if (mysqli_num_rows($rez) == 0) //если нашлась одна строка, значит такой юзер существует в базе данных
                {

                    ?>
                    <div class="dropdown ml-0 ml-md-4 mt-2 mt-lg-0">
                        <button class="btn bg-white  p-3 d-flex align-items-center" type="button" id="dropdownMenuButton1" onclick="createApplication()"> Создать заявление </button>
                    </div>
                <?php } ?>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="d-sm-flex justify-content-between align-items-center transaparent-tab-border ">
                    <ul class="nav nav-tabs tab-transparent" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="home-tab" data-toggle="tab" href="#allApps" role="tab" aria-selected="true">Новые</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link " id="rassmotrenie-tab" data-toggle="tab" href="#rassmotrenie" role="tab" aria-selected="false">На рассмотрении</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="odobrennie-tab" data-toggle="tab" href="#" role="tab" aria-selected="false">Завершена оценка</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="neodobrennie-tab" data-toggle="tab" href="#" role="tab" aria-selected="false">На доработке</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="reshenieSoveta-tab" data-toggle="tab" href="#" role="tab" aria-selected="false">Решение совета</a>
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
                                        if ($role > 3 && $role < 12){
                                            $query = "SELECT a.*, u.username, u.oblast, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join users u on a.id_user =u.id_user
                                                   where id_status = 2 and u.oblast = '$role'";
                                        }
                                        else {
                                            $query = "SELECT a.*, u.username, u.oblast, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join users u on a.id_user =u.id_user
                                                   where id_status = 2";
                                        }
                                        $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                                        ?>

                                        <table id="example" class="table table-striped table-bordered" style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Заявления</th>
                                                <th>Дата отправки</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                include "mainMark.php"
                                                ?>

                                                <tr onclick="showModal('<?= $app['app_id'] ?>', '<?= $str_CalcSelfMark ?>', '<?= $str_CalcSelfMarkAccred ?>')" style="cursor: pointer;">

                                                    <td>Заявление <?= $app['username'] ?>  №<?= $app['app_id'] ?></td>
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
                                        if ($role > 3 && $role < 12){
                                            $query = "SELECT a.*, u.username, u.oblast, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join users u on a.id_user =u.id_user
                                                   where id_status = 3 and u.oblast = '$role'";
                                        }
                                        else {
                                            $query = "SELECT a.*, u.username, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join users u on a.id_user =u.id_user 
                                                    where id_status = 3";
                                        }
                                        $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                                        ?>

                                        <table id="example" class="table table-striped table-bordered" style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Заявления</th>
                                                <th>Дата принятия на рассмотрение</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                    include "mainMark.php";
                                                ?>

                                                <tr onclick="showModal('<?= $app['app_id'] ?>', '<?= $str_CalcSelfMark ?>', '<?= $str_CalcSelfMarkAccred ?>')" style="cursor: pointer;">


                                                    <td>Заявление <?= $app['username'] ?> №<?= $app['app_id'] ?></td>
                                                    <td><?= $app['date_accept'] ?></td>


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
                                        if ($role > 3 && $role < 12){
                                            $query = "SELECT a.*, u.username, u.oblast, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join users u on a.id_user =u.id_user
                                                   where id_status = 4 and u.oblast = '$role'";
                                        }
                                        else {

                                            $query = "SELECT a.*, u.username, ram.*, a.id_application as app_id
                                                FROM applications a
                                               left outer join report_application_mark ram on a.id_application=ram.id_application
                                                left outer join users u on a.id_user =u.id_user where id_status = 4";
                                        }
                                        $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                                        ?>

                                        <table id="example" class="table table-striped table-bordered" style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Заявления</th>
                                                <th>Дата одобрения</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                include "mainMark.php";
                                                ?>

                                                <tr onclick="showModal('<?= $app['app_id'] ?>', '<?= $str_CalcSelfMark ?>', '<?= $str_CalcSelfMarkAccred ?>')" style="cursor: pointer;">


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
                                        if ($role > 3 && $role < 12){
                                            $query = "SELECT a.*, u.username, u.oblast, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join users u on a.id_user =u.id_user
                                                   where id_status = 5 and u.oblast = '$role'";
                                        }
                                        else {

                                            $query = "SELECT a.*, u.username, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join users u on a.id_user =u.id_user where id_status = 5";
                                        }
                                        $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                                        ?>

                                        <table id="example" class="table table-striped table-bordered" style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Заявления</th>
                                                <th>Дата доработки</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                include "mainMark.php";
                                                ?>

                                                <tr onclick="showModal('<?= $app['app_id'] ?>', '<?= $str_CalcSelfMark ?>', '<?= $str_CalcSelfMarkAccred ?>')" style="cursor: pointer;">


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
                                        if ($role > 3 && $role < 12){
                                            $query = "SELECT a.*, u.username, u.oblast, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join users u on a.id_user =u.id_user
                                                   where id_status = 2 and u.oblast = '$role'";
                                        }
                                        else {
                                            $query = "SELECT a.*, u.username, u.oblast, ram.*, a.id_application as app_id
                                                    FROM applications a
                                                   left outer join report_application_mark ram on a.id_application=ram.id_application
                                                    left outer join users u on a.id_user =u.id_user
                                                   where id_status = 2";
                                        }
                                        $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                                        ?>

                                        <table id="example" class="table table-striped table-bordered" style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Заявления</th>
                                                <th>Дата решения совета</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                include "mainMark.php"
                                                ?>

                                                <tr onclick="showModal('<?= $app['app_id'] ?>', '<?= $str_CalcSelfMark ?>', '<?= $str_CalcSelfMarkAccred ?>')" style="cursor: pointer;">

                                                    <td>Заявление <?= $app['username'] ?>  №<?= $app['app_id'] ?></td>
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
                    <h4 class="modal-title">Создание заявления</h4>
                    <h4 id="id_application"></h4>
                    <button type="button" class="btn  btn-danger btn-close"  data-bs-dismiss="modal">x</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">




                    <div class="col-md-12">
                        <div class="d-sm-flex justify-content-between align-items-center transaparent-tab-border ">
                            <ul class="nav nav-tabs tab-transparent" role="tablist" id="tablist">
                                <li class="nav-item" id="tab1" onclick="showTab(this)">
                                    <button class="nav-link active"  data-toggle="tab" href="#" role="tab" aria-selected="true" id = "button1" >Общие сведения о заявителе</button>
                                </li>


                                <!--                            ...-->
                            </ul>
                            <div class="d-md-block d-none">
<!--                                <a href="#" class="text-light p-1"><i class="mdi mdi-view-dashboard"></i></a>-->
<!--                                <a href="#" class="text-light p-1"><i class="mdi mdi-dots-vertical"></i></a>-->
                            </div>
                        </div>
                        <div class="tab-content tab-transparent-content">
                            <div class="tab-pane fade show active" id="tab1-" role="tabpanel" aria-labelledby="business-tab" >

                                <div class="row">
                                    <div class="col-6 grid-margin">
                                        <div class="card">
                                            <div class="card-body">

                                                <div class="form-group"> <label>Наименование юридического лица</label><input id="naim" type="text" class="form-control" readonly/></div>
                                                <div class="form-group"><label>Сокращенное наименование</label><input class="form-control" id="sokr" type="text" readonly/></div>
                                                <div class="form-group"><label>УНП</label><input class="form-control" type="text" id="unp" onfocusout="onInputUnp()" readonly/></div>
                                                <div class="form-group"><label>Юридический адрес</label><input class="form-control" type="text" id="adress" onfocusout="onInputAdress()" readonly/></div>
                                                <div class="form-group"><label>Номер телефона</label><input class="form-control" id="tel" type="text" readonly/></div>
                                                <div class="form-group"><label>Электронная почта</label><input class="form-control" type="email" id="email" onfocusout="onInputEmail()" readonly/></div>
                                                <div class="form-group"><label>Руководитель заинтересованного лица</label><input class="form-control" type="text" id="rukovoditel" placeholder="Должность, ФИО" readonly/></div>
                                                <div class="form-group"><label>Представитель заинтересованного лица</label><input class="form-control" type="text" id="predstavitel" placeholder="Контактное лицо" readonly/></div>
                                                <br/>
                                                <!--                                            <form id="formDoverennost" method="post" class="hiddentab">-->
                                                <!--                                                <div class="form-group" id="divDoverennost">-->
                                                <!--                                                    <label for="doverennost">Доверенность</label>-->
                                                <!--                                                    <input type="file" name="doverennost" class="form-control-file" id="doverennost">-->
                                                <!--                                                </div>-->
                                                <!--                                            </form>-->


                                                <div class="form-group"> <label style="font-size: 18px">Обязательные документы</label></div>

                                                <form id="formSoprovodPismo">
                                                    <div class="form-group" id = "divSoprovodPismo">
                                                        <label for="soprPismo">Сопроводительное письмо</label><br/>
                                                        <input type="file" class="form-control-file hiddentab" name="Name" id="soprPismo" disabled="true">
                                                    </div>
                                                </form>

                                                <form id="formCopyRaspisanie">
                                                    <div class="form-group" id = "divCopyRaspisanie">
                                                        <label for="copyRaspisanie" >Копия штатного расписания</label><br/>
                                                        <input type="file" class="form-control-file hiddentab" name="Name" id="copyRaspisanie" disabled="true">
                                                    </div>
                                                </form>

                                                <form id="formOrgStrukt" >
                                                    <div class="form-group" id = "divOrgStrukt">
                                                        <label for="orgStrukt">Организационная структура</label><br/>
                                                        <input type="file" class="form-control-file hiddentab" id="orgStrukt" disabled="true">
                                                    </div>
                                                </form>

                                                <form id="formUcomplect" >
                                                    <div class="form-group" id = "divUcomplect">
                                                        <label for="ucomplect">Укомплектованность</label><br/>
                                                        <input type="file" class="form-control-file hiddentab" id="ucomplect">
                                                    </div>
                                                </form>

                                                <form id="formTechOsn" >
                                                    <div class="form-group" id = "divTechOsn">
                                                        <label for="techOsn">Техническое оснащение</label><br/>
                                                        <input type="file" class="form-control-file hiddentab" id="techOsn">
                                                    </div>
                                                </form>

                                                <form id="formReportSamoocenka" >
                                                    <div class="form-group" id = "divReportSamoocenka">
                                                        <label for="reportSamoocenka">Результат самооценки</label><br/>
                                                        <input type="file" class="form-control-file hiddentab" id="reportSamoocenka" disabled="true">
                                                    </div>
                                                </form>
<!--                                                <button class="btn-inverse-info" onclick="addTab()">+ добавить структурное подразделение</button>-->
                                                <br/>
                                                <br/>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6 grid-margin">


                                    <div class = "inform" id = "informgr" >
                                        <div class="newform-group" id = "infile">
                                            <label>Информация о необходимости доработки(нажмите на поле ввода, чтобы присоединить файл)</label>
                                            <input id="infdorabotki" type="text" class="form-control" readonly/>
                                            <input type="file" id="fileInputDorabotka" style="display: none;" accept=".pdf">
                                            </div>
                                        <br>
                                        <div class="newform-group">
                                            <label>Срок доработки (дата)</label>
                                            <input id="dateInputDorabotki" type="date" class="form-control">
                                        </div>
                                        <br>
                                        <div class="newform-group">
                                            <input type="checkbox" id="checkboxInput" style="margin-right: 1rem"><label>Отправить уведомление на электронную почту ОЗ</label>

                                    </div>


                                    </div>

                                        <div class = "sovet"  id="sovetgr" >

                                            <div class="newform-group" id = "protfile">
                                                <label>Протокол Совета (Проект)</label>
                                                <input id="protokolsoveta" type="text" class="form-control" readonly/>
                                                <input type="file" id="fileInputProtokol" style="display: none;" accept=".pdf">
                                            </div>
                                            <br>
                                            <div class="newform-group" id = "zaklfile">
                                                <label>Заключение Совета (Проект)</label>
                                                <input id="zaklsoveta" type="text" class="form-control" readonly/>
                                                <input type="file" id="fileInputZakl" style="display: none;" accept=".pdf">
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
                                                    <option value="Частично соответствует">Частично соответствует</option>
                                                    <option value="Не соответствует">Не соответствует</option>
                                                </select>

                                            </div>
                                             <br>
                                            <div class="newform-group">
                                                <label>Срок решения</label>
                                                <input id="dateInputSrok" type="date" class="form-control">
                                            </div>
                                            <br>
                                            <button type="submit" class="btn btn-light btn-fw" id="btnSaveSovet">Сохранить</button>
                                        </div>



                                        <div class="card">
                                            <div class="card-body" id="mainRightCard">

                                            </div>

                                            <form id="formReport" >
                                                <div class="form-group" id = "divReport" style="margin-left: 2.5rem">
                                                    <div style="margin-bottom:1rem">

                                                    </div>
                                                    <label for="fileReport" style="font-size: 24px">Отчет</label>
                                                    <input type="file" class="form-control-file" id="fileReport" >
                                                </div>
                                            </form>
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
                    <!--                <form action="getApplication.php" method="post">-->
                    <!--                    <input type="text" name="count" id="count"/>-->
                    <!--                <p id="btnSuc" style="cursor: pointer">Загрузить данные</p>-->

                    <button type="submit" class="btn btn-success btn-fw hiddentab" id="btnChecking">На рассмотрение</button>
                    <button type="submit" class="btn btn-success btn-fw hiddentab" id="btnOk">Завершить оценку</button>
                    <button type="submit" class="btn btn-success btn-fw hiddentab" id="btnOkReshenie">Решение совета</button>

                    <button type="submit" class="btn btn-danger hiddentab" id="btnNeOk">На доработку</button>
                    <button type="submit" class="btn btn-light btn-fw" id="btnPrint">Печать</button>
                    <button type="submit"  class="btn btn-light btn-fw" id="btnPrintReport">Сформировать отчет</button>
                    <button type="submit" class="btn btn-light btn-fw" id="btnCalc">Рассчитать результат соответствия</button>

                    <!--                </form>-->
                    <button type="button" class="btn btn-danger" id="closerModal" data-bs-dismiss="modal">Закрыть</button>
                </div>

            </div>
        </div>
    </div>

    <script>

        $(document).ready(function () {

            // var files;
            // $('#pril1').change(function(){
            //     files = this.files;
            // });


        });
    </script>

    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>

    <!--<script>--><?php //include 'getApplication.php' ?><!--</script>-->
    <!--<script>console.log(filesName)</script>-->
    <script src="dist/js/formAccreditation.js"></script>


    
    <script>
        let tabLink = document.querySelector('#home-tab');
        let tabPane = document.querySelector('#allApps');

        tabLink.addEventListener('click', function(event) {
            event.preventDefault();

            // Проверяем, есть ли у вкладки класс 'active'
            if (!tabPane.classList.contains('active')) {
                // Если нет, то устанавливаем класс 'active'
                tabPane.classList.add('active');
            }
        });
    </script>



    <script>

        document.getElementById("infdorabotki").addEventListener("click", function() {
            document.getElementById("fileInputDorabotka").click();
        });

        document.getElementById("fileInputDorabotka").addEventListener("change", function() {
            var file = this.files[0];
            if (file) {
                document.getElementById("infdorabotki").value = file.name;
            }
        });
    </script>



    <script>

        document.getElementById("protokolsoveta").addEventListener("click", function() {
            document.getElementById("fileInputProtokol").click();
        });

        document.getElementById("fileInputProtokol").addEventListener("change", function() {
            var file = this.files[0];
            if (file) {
                document.getElementById("protokolsoveta").value = file.name;
            }
        });
    </script>




    <script>

        document.getElementById("zaklsoveta").addEventListener("click", function() {
            document.getElementById("fileInputZakl").click();
        });

        document.getElementById("fileInputZakl").addEventListener("change", function() {
            var file = this.files[0];
            if (file) {
                document.getElementById("zaklsoveta").value = file.name;
            }
        });
    </script>



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