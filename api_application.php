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

    .tooltip1 {
        position: fixed;
        padding: 10px 20px;
        border: 1px solid #b3c9ce;
        border-radius: 4px;
        text-align: center;
        font: italic 14px/1.3 sans-serif;
        color: #333;
        background: #fff;
        box-shadow: 3px 3px 3px rgba(0, 0, 0, .3);
        z-index: 9999;
    }
    #formDateDorabotka{
        margin-left: 2px;
    }
    #formFileReportDorabotka{
        margin-left: 2px;
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
$query = "SELECT * FROM applications a
    left outer join users u on u.id_user = a.id_user
    WHERE login='$login' and  id_status in (1,2,3,5)";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
if (mysqli_num_rows($rez) == 0) //если нашлась одна строка, значит такой юзер существует в базе данных
{

?>
                <div class="dropdown ml-0 ml-md-4 mt-2 mt-lg-0">
                  <button class="btn bg-create p-3 d-flex align-items-center" type="button" id="dropdownMenuButton1" onclick="createApplication()"> Создать заявление </button>
                </div>
                  <?php } ?>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12">
                <div class="d-sm-flex justify-content-between align-items-center transaparent-tab-border ">
                  <ul class="nav nav-tabs tab-transparent" role="tablist">
                    <li class="nav-item">
                      <a class="nav-link active" id="home-tab" data-toggle="tab" href="#allApps" role="tab" aria-selected="true">Самооценка</a>
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
                  </ul>
                  <div class="d-md-block d-none">
<!--                    <a href="#" class="text-light p-1"><i class="mdi mdi-view-dashboard"></i></a>-->
<!--                    <a href="#" class="text-light p-1"><i class="mdi mdi-dots-vertical"></i></a>-->
                  </div>
                </div>
                <div class="tab-content tab-transparent-content">
                  <div class="tab-pane fade show active" id="allApps" role="tabpanel" aria-labelledby="home-tab">

                    <div class="row">
                      <div class="col-12 grid-margin">
                        <div class="card">
                          <div class="card-body">

                              <?php
                              $login = $_COOKIE['login'];
                              $insertquery = "SELECT * FROM users WHERE login='$login'";

                              $rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
                              $username = "";
                              if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                              {
                                  $row = mysqli_fetch_assoc($rez);
                                  $id = $row['id_user'];
                                  $username = $row['username'];
                              }

                              $query = "SELECT a.*, u.username, ram.*, a.id_application as app_id
                                FROM applications a
                               left outer join report_application_mark ram on a.id_application=ram.id_application
                                left outer join users u on a.id_user =u.id_user where a.id_user='$id' and (id_status = 1 or id_status = 5)";
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
                                          $id_application = $app['app_id'];
                                          ?>


                                          <tr onclick="showModal('<?= $app['app_id'] ?>','<?= $str_CalcSelfMark ?>', '')" style="cursor: pointer;">



                                              <td>Заявление <?= $username ?> №<?= $app['app_id'] ?></td>
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
                      <div class="tab-pane fade" id="rassmotrenie" role="tabpanel" aria-labelledby="rassmotrenie-tab">
                          <div class="row">
                              <div class="col-12 grid-margin">
                                  <div class="card">
                                      <div class="card-body">

                                          <?php
                                          $login = $_COOKIE['login'];
                                          $insertquery = "SELECT * FROM users WHERE login='$login'";

                                          $rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
                                          $username = "";
                                          if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                                          {
                                              $row = mysqli_fetch_assoc($rez);
                                              $id = $row['id_user'];
                                              $username = $row['username'];
                                          }

                                          $query = "SELECT a.*, u.username, ram.*, a.id_application as app_id
                                FROM applications a
                               left outer join report_application_mark ram on a.id_application=ram.id_application
                                left outer join users u on a.id_user =u.id_user where a.id_user='$id' and id_status in (2,3)";
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

                                                  <tr onclick="showModal('<?= $app['app_id'] ?>', '<?= $str_CalcSelfMark ?>', '')" style="cursor: pointer;">


                                                      <td>Заявление <?= $username ?> №<?= $app['app_id'] ?></td>
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
                                          $login = $_COOKIE['login'];
                                          $insertquery = "SELECT * FROM users WHERE login='$login'";

                                          $rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
                                          $username = "";
                                          if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                                          {
                                              $row = mysqli_fetch_assoc($rez);
                                              $id = $row['id_user'];
                                              $username = $row['username'];
                                          }

                                          $query = "SELECT a.*, u.username, ram.*, a.id_application as app_id
                                FROM applications a
                               left outer join report_application_mark ram on a.id_application=ram.id_application
                                left outer join users u on a.id_user =u.id_user where a.id_user='$id' and id_status = 4";
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
                                                   /*<?= $str_CalcSelfMarkAccred ?>*/ // второй параметр для showModal
                                                  ?>
                                                                
                                                  <tr onclick="showModal('<?= $app['app_id'] ?>', '<?= $str_CalcSelfMark ?>', '')" style="cursor: pointer;">


                                                      <td>Заявление <?= $username ?> №<?= $app['app_id'] ?></td>
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
                                          $login = $_COOKIE['login'];
                                          $insertquery = "SELECT * FROM users WHERE login='$login'";

                                          $rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
                                          $username = "";
                                          if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                                          {
                                              $row = mysqli_fetch_assoc($rez);
                                              $id = $row['id_user'];
                                              $username = $row['username'];
                                          }

                                          $query = "SELECT a.*, u.username, ram.*, a.id_application as app_id
                                FROM applications a
                               left outer join report_application_mark ram on a.id_application=ram.id_application
                                left outer join users u on a.id_user =u.id_user where a.id_user='$id' and id_status = 5";
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
                                                  /*<?= $str_CalcSelfMarkAccred ?>*/ // второй параметр для showModal
                                                  ?>

                                                  <tr onclick="showModal('<?= $app['app_id'] ?>', '<?= $str_CalcSelfMark ?>', '')" style="cursor: pointer;">


                                                      <td>Заявление <?= $username ?> №<?= $app['app_id'] ?></td>
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
                <button type="button" class="btn  btn-danger btn-close closeX" data-bs-dismiss="modal">x</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">




                <div class="col-md-12">
                    <div class="d-sm-flex justify-content-between align-items-center transaparent-tab-border ">
                        <ul class="nav nav-tabs tab-transparent" role="tablist" id="tablist">
                            <li class="nav-item" id="tab1" onclick="showTab(this)">
                                <button class="nav-link active"  data-toggle="tab" href="#" role="tab" aria-selected="true" id = "button1" ;>Общие сведения о заявителе</button>
                            </li>


                        <!--                            ...-->
                        </ul>
                        <div class="d-md-block d-none">
<!--                            <a href="#" class="text-light p-1"><i class="mdi mdi-view-dashboard"></i></a>-->
<!--                            <a href="#" class="text-light p-1"><i class="mdi mdi-dots-vertical"></i></a>-->
                        </div>
                    </div>
                    <div class="tab-content tab-transparent-content">
                        <div class="tab-pane fade show active" id="tab1-" role="tabpanel" aria-labelledby="business-tab" >

                            <div class="row">
                                <div class="col-6 grid-margin">
                                    <div class="card">
                                        <div class="card-body">

                                            <div class="form-group"> <label>Наименование юридического лица</label><input id="naim" type="text" class="form-control"/></div>
                                            <div class="form-group"><label>Сокращенное наименование</label><input class="form-control" id="sokr" type="text"/></div>
                                            <div class="form-group"><label>УНП</label><input class="form-control" type="text" id="unp" onfocusout="onInputUnp()"/></div>
                                            <div class="form-group"><label>Юридический адрес</label><input class="form-control" type="text" id="adress" onfocusout="onInputAdress()"/></div>
                                            <div class="form-group"><label>Номер телефона</label><input class="form-control" id="tel" type="text"/></div>
                                            <div class="form-group"><label>Электронная почта</label><input class="form-control" type="email" id="email" onfocusout="onInputEmail()"/></div>
                                            <div class="form-group"><label>Руководитель заинтересованного лица</label><input class="form-control" type="text" id="rukovoditel" placeholder="Должность, ФИО"/></div>
                                            <div class="form-group"><label>Представитель заинтересованного лица</label><input class="form-control" type="text" id="predstavitel" placeholder="Контактное лицо"/></div>
                                            <br/>
<!--                                            <form id="formDoverennost" method="post" class="hiddentab">-->
<!--                                                <div class="form-group" id="divDoverennost">-->
<!--                                                    <label for="doverennost">Доверенность</label>-->
<!--                                                    <input type="file" name="doverennost" class="form-control-file" id="doverennost">-->
<!--                                                </div>-->
<!--                                            </form>-->



                                            <button class="btn-inverse-info" onclick="addTab()" id="addtab">+ добавить обособленное структурное подразделение</button>
                                            <br/>
                                            <br/>

                                        </div>
                                    </div>
                                </div>
                                <div class="col-6 grid-margin">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="form-group"> <label style="font-size: 18px">Обязательные документы</label></div>

                                            <form id="formSoprovodPismo">
                                                <div class="form-group" id = "divSoprovodPismo">
                                                    <label for="soprPismo">Сопроводительное письмо</label>
                                                    <input type="file" class="form-control-file" name="Name" id="soprPismo" content="">
                                                </div>
                                            </form>

                                            <form id="formCopyRaspisanie">
                                                <div class="form-group" id = "divCopyRaspisanie">
                                                    <label for="copyRaspisanie" >Копия штатного расписания</label>
                                                    <input type="file" class="form-control-file" name="Name" id="copyRaspisanie">
                                                </div>
                                            </form>

                                            <form id="formOrgStrukt" >
                                                <div class="form-group" id = "divOrgStrukt">
                                                    <label for="orgStrukt">Организационная структура</label>
                                                    <input type="file" class="form-control-file" id="orgStrukt">
                                                </div>
                                            </form>

                                            <form id="formUcomplect" >
                                                <div class="form-group" id = "divUcomplect">
                                                    <label for="ucomplect">Укомплектованность</label>
                                                    <input type="file" class="form-control-file" id="ucomplect">
                                                </div>
                                            </form>

                                            <form id="formTechOsn" >
                                                <div class="form-group" id = "divTechOsn">
                                                    <label for="techOsn">Техническое оснащение</label>
                                                    <input type="file" class="form-control-file" id="techOsn">
                                                </div>
                                            </form>

                                            <form id="formFileReportSamoocenka" >
                                                <div class="form-group " id = "divFileReportSamoocenka">
                                                    <label for="reportSamoocenka">Результат самооценки</label>
                                                    <input type="file" class="form-control-file" id="reportSamoocenka">
                                                </div>
                                            </form>
                                            <form id="formFileReportDorabotka" >
                                                <div class="form-group " id = "divFileReportDorabotka" style="margin-bottom: 0px;" >
                                                    <label for="reportDorabotka">Информация о необходимости доработки</label>
                                                </div>
                                            </form>
                                            <br>
                                            <form id="formDateDorabotka" >
                                                <div class="form-group " id = "divDateDorabotka"  style="margin-bottom: 0px;">
                                                    <label for="dateDorabotka">Срок доработки</label>
                                                </div>
                                            </form>
                                            <br>
                                        </div>
                                        <div class="card-body" id="mainRightCard">

                                        </div>
                                        <form id="formReport" >
                                            <div class="form-group" id = "divReport" style="margin-left: 2.5rem">
<!--                                                <label for="" style="font-size: 24px">Отчет</label><br/>-->
                                                <input type="file" class="form-control-file hiddentab" id="fileReport" >
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <div style="width: 100%">
                                    <div style="display:flex; justify-content: flex-end;">
                                        <button type="submit" class="btn btn-warning btn-fw" id="btnSuc" >Сохранить</button>
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

             <button type="submit" class="btn btn-success btn-fw" id="btnSend">Отправить</button>
             <button data-tooltip="Печать критериев" type="submit" class="btn btn-light btn-fw" id="btnPrint">Печать</button>
             <button type="submit"  class="btn btn-light btn-fw" id="btnPrintReport">Результат самооценки</button>
<!--                <button type="submit" class="btn btn-light btn-fw" id="btnCalc">Рассчитать самооценку</button>-->

<!--                </form>-->
             <button type="button" class="btn btn-danger closeD" data-bs-dismiss="modal">Закрыть</button>
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
<script src="dist/js/formApplication.js"></script>

<script>
    let tooltipElem;

    document.onmouseover = function(event) {
        let target = event.target;

        // если у нас есть подсказка...
        let tooltipHtml = target.dataset.tooltip;
        if (!tooltipHtml) return;

        // ...создадим элемент для подсказки

        tooltipElem = document.createElement('div');
        tooltipElem.className = 'tooltip1';
        tooltipElem.innerHTML = tooltipHtml;
        let foot = document.getElementById("btnPrint");
        foot.append(tooltipElem);

        // спозиционируем его сверху от аннотируемого элемента (top-center)
        let coords = target.getBoundingClientRect();

        let left = coords.left + (target.offsetWidth - tooltipElem.offsetWidth) / 2;
        if (left < 0) left = 0; // не заезжать за левый край окна

        let top = coords.top - tooltipElem.offsetHeight - 5;
        if (top < 0) { // если подсказка не помещается сверху, то отображать её снизу
            top = coords.top + target.offsetHeight + 5;
        }

        tooltipElem.style.left = left + 'px';
        tooltipElem.style.top = top + 'px';
    };

    document.onmouseout = function(e) {

        if (tooltipElem) {
            tooltipElem.remove();
            tooltipElem = null;
        }

    };

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


