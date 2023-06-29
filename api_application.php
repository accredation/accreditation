<style>
    .hiddentab{
        display: none;
    }
    .margleft{
        padding-left: 20px;
    }
</style>

<style>
    .container {
        padding: 0rem 0rem;
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
$query = "SELECT * FROM applications, users WHERE login='$login' and users.id_user = applications.id_user";

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
                          <a class="nav-link active" id="home-tab" data-toggle="tab" href="#" role="tab" aria-selected="true">Все заявления</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link " id="business-tab" data-toggle="tab" href="#business-1" role="tab" aria-selected="false">На рассмотрении</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" id="performance-tab" data-toggle="tab" href="#" role="tab" aria-selected="false">Одобренные</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" id="conversion-tab" data-toggle="tab" href="#" role="tab" aria-selected="false">Не одобренные</a>
                    </li>
                  </ul>
                  <div class="d-md-block d-none">
                    <a href="#" class="text-light p-1"><i class="mdi mdi-view-dashboard"></i></a>
                    <a href="#" class="text-light p-1"><i class="mdi mdi-dots-vertical"></i></a>
                  </div>
                </div>
                <div class="tab-content tab-transparent-content">
                  <div class="tab-pane fade show active" id="business-1" role="tabpanel" aria-labelledby="business-tab">
<!--                    <div class="row">-->
<!--                      <div class="col-xl-3 col-lg-6 col-sm-6 grid-margin stretch-card">-->
<!--                        <div class="card">-->
<!--                          <div class="card-body text-center">-->
<!--                            <h5 class="mb-2 text-dark font-weight-normal">Orders</h5>-->
<!--                            <h2 class="mb-4 text-dark font-weight-bold">932.00</h2>-->
<!--                            <div class="dashboard-progress dashboard-progress-1 d-flex align-items-center justify-content-center item-parent"><i class="mdi mdi-lightbulb icon-md absolute-center text-dark"></i></div>-->
<!--                            <p class="mt-4 mb-0">Completed</p>-->
<!--                            <h3 class="mb-0 font-weight-bold mt-2 text-dark">5443</h3>-->
<!--                          </div>-->
<!--                        </div>-->
<!--                      </div>-->
<!--                      <div class="col-xl-3 col-lg-6 col-sm-6 grid-margin stretch-card">-->
<!--                        <div class="card">-->
<!--                          <div class="card-body text-center">-->
<!--                            <h5 class="mb-2 text-dark font-weight-normal">Unique Visitors</h5>-->
<!--                            <h2 class="mb-4 text-dark font-weight-bold">756,00</h2>-->
<!--                            <div class="dashboard-progress dashboard-progress-2 d-flex align-items-center justify-content-center item-parent"><i class="mdi mdi-account-circle icon-md absolute-center text-dark"></i></div>-->
<!--                            <p class="mt-4 mb-0">Increased since yesterday</p>-->
<!--                            <h3 class="mb-0 font-weight-bold mt-2 text-dark">50%</h3>-->
<!--                          </div>-->
<!--                        </div>-->
<!--                      </div>-->
<!--                      <div class="col-xl-3  col-lg-6 col-sm-6 grid-margin stretch-card">-->
<!--                        <div class="card">-->
<!--                          <div class="card-body text-center">-->
<!--                            <h5 class="mb-2 text-dark font-weight-normal">Impressions</h5>-->
<!--                            <h2 class="mb-4 text-dark font-weight-bold">100,38</h2>-->
<!--                            <div class="dashboard-progress dashboard-progress-3 d-flex align-items-center justify-content-center item-parent"><i class="mdi mdi-eye icon-md absolute-center text-dark"></i></div>-->
<!--                            <p class="mt-4 mb-0">Increased since yesterday</p>-->
<!--                            <h3 class="mb-0 font-weight-bold mt-2 text-dark">35%</h3>-->
<!--                          </div>-->
<!--                        </div>-->
<!--                      </div>-->
<!--                      <div class="col-xl-3 col-lg-6 col-sm-6 grid-margin stretch-card">-->
<!--                        <div class="card">-->
<!--                          <div class="card-body text-center">-->
<!--                            <h5 class="mb-2 text-dark font-weight-normal">Followers</h5>-->
<!--                            <h2 class="mb-4 text-dark font-weight-bold">4250k</h2>-->
<!--                            <div class="dashboard-progress dashboard-progress-4 d-flex align-items-center justify-content-center item-parent"><i class="mdi mdi-cube icon-md absolute-center text-dark"></i></div>-->
<!--                            <p class="mt-4 mb-0">Decreased since yesterday</p>-->
<!--                            <h3 class="mb-0 font-weight-bold mt-2 text-dark">25%</h3>-->
<!--                          </div>-->
<!--                        </div>-->
<!--                      </div>-->
<!--                    </div>-->
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

                              $query = "SELECT * FROM applications where id_user='$id'";
                              $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                              for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                              ?>

                              <table id="example" class="table table-striped table-bordered" style="width:100%">
                                  <thead>
                                  <tr>
                                      <th>Заявления</th>
                                  </tr>
                                  </thead>
                                  <tbody>
                                  <?php

                                      foreach ($data as $app) {

                                          ?>

                                          <tr onclick="showModal('<?= $app['id_application'] ?>')" style="cursor: pointer;">


                                              <td>Заявление <?= $username ?></td>


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
    <div class="modal-dialog modal-xl">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Создание заявления</h4>
                <h4 id="id_application"></h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal">x</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">




                <div class="col-md-12">
                    <div class="d-sm-flex justify-content-between align-items-center transaparent-tab-border ">
                        <ul class="nav nav-tabs tab-transparent" role="tablist" id="tablist">
                            <li class="nav-item" id="tab1" onclick="showTab(this)">
                                <a class="nav-link active"  data-toggle="tab" href="#" role="tab" aria-selected="true">Общие сведения о заявителе</a>
                            </li>
                            <li class="nav-item" id="tab2" onclick="showTab(this)">
                                <a class="nav-link"  data-toggle="tab" href="#" role="tab" aria-selected="false">Самооценка <?= $username ?></a>
                            </li>
<!--                            <li class="nav-item hiddentab" id="rodovspom-tab" onclick="showTab3()">-->
<!--                                <a class="nav-link"  data-toggle="tab" href="#" role="tab" aria-selected="false">Родовспоможение</a>-->
<!--                            </li>-->
<!--                            <li class="nav-item hiddentab" id="akush-tab" onclick="showTab4()">-->
<!--                                <a class="nav-link"  data-toggle="tab" href="#" role="tab" aria-selected="false">Акушерство и гинекология</a>-->
<!--                            </li>-->
<!--                            <li class="nav-item hiddentab" id="anest-tab" onclick="showTab5()">-->
<!--                                <a class="nav-link"  data-toggle="tab" href="#" role="tab" aria-selected="false">Анестезиология и реаниматология</a>-->
<!--                            </li>-->
                        </ul>
                        <div class="d-md-block d-none">
                            <a href="#" class="text-light p-1"><i class="mdi mdi-view-dashboard"></i></a>
                            <a href="#" class="text-light p-1"><i class="mdi mdi-dots-vertical"></i></a>
                        </div>
                    </div>
                    <div class="tab-content tab-transparent-content">
                        <div class="tab-pane fade show active" id="tab1-" role="tabpanel" aria-labelledby="business-tab" >

                            <div class="row">
                                <div class="col-12 grid-margin">
                                    <div class="card">
                                        <div class="card-body">

                                            <div class="form-group"> <label>Наименование юридического лица</label><input id="naim" type="text" class="form-control"/></div>
                                            <div class="form-group"><label>Сокращенное наименование</label><input class="form-control" type="text"/></div>
                                            <div class="form-group"><label>УНП</label><input class="form-control" type="text" id="unp" onfocusout="onInputUnp()"/></div>
                                            <div class="form-group"><label>Юридический адрес</label><input class="form-control" type="text" id="adress" onfocusout="onInputAdress()"/></div>
                                            <div class="form-group"><label>Номер телефона</label><input class="form-control" type="text"/></div>
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


                                            <div class="form-group"> <label style="font-size: 18px">Обязательные документы</label></div>

                                            <form id="formSoprovodPismo">
                                                <div class="form-group">
                                                    <label for="soprPismo">Сопроводительное письмо</label>
                                                    <input type="file" class="form-control-file" name="Name" id="soprPismo">
                                                </div>
                                            </form>

                                            <form id="formCopyRaspisanie">
                                                <div class="form-group">
                                                    <label for="copyRaspisanie">Копия штатного расписания</label>
                                                    <input type="file" class="form-control-file" name="Name" id="copyRaspisanie">
                                                </div>
                                            </form>

                                            <form id="formOrgStrukt" >
                                                <div class="form-group">
                                                    <label for="orgStrukt">Организационная структура</label>
                                                    <input type="file" class="form-control-file" id="orgStrukt">
                                                </div>
                                            </form>
                                            <button class="btn-inverse-info" onclick="addTab()">+ добавить структурное подразделение</button>
                                            <br/>
                                            <br/>
                                            <div class="form-group"><label for="formGroupExampleInput" style="font-size: 18px; text-align: left;">Общие критерии</label>
                                            <div class="form-check margleft">
                                                <input class="form-check-input" type="checkbox" value="" id="defaultCheck1" onclick="toggleTabs(this,'fap')">
                                                <label class="form-check-label" for="defaultCheck1">
                                                    Фельдшерско-акушерский пункт
                                                </label>
                                            </div>
                                            <div class="form-check margleft">
                                                <input class="form-check-input" type="checkbox" value="" id="defaultCheck2" onclick="toggleTabs(this,'avop')">
                                                <label class="form-check-label" for="defaultCheck2" >
                                                    Врачебная амбулатория общей практики
                                                </label>
                                            </div>
                                            <div class="form-check margleft">
                                                <input class="form-check-input" type="checkbox" value="" id="defaultCheck3" onclick="toggleTabs(this,'gp')">
                                                <label class="form-check-label" for="defaultCheck3">
                                                    Городская поликлиника (районная поликлиника)
                                                </label>
                                            </div>
                                            <div class="form-check margleft">
                                                <input class="form-check-input" type="checkbox" value="" id="defaultCheck4" onclick="toggleTabs(this,'dp')">
                                                <label class="form-check-label" for="defaultCheck4">
                                                    Детская поликлиника
                                                </label>
                                            </div>
                                                <div class="form-check margleft">
                                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck4" onclick="toggleTabs(this,'cgp')">
                                                    <label class="form-check-label" for="defaultCheck4">
                                                        Центральная городская поликлиника
                                                    </label>
                                                </div>
                                                <div class="form-check margleft">
                                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck4" onclick="toggleTabs(this,'kdp')">
                                                    <label class="form-check-label" for="defaultCheck4">
                                                        Консультативно-диагностическая поликлиника
                                                    </label>
                                                </div>
                                                <div class="form-check margleft">
                                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck4" onclick="toggleTabs(this,'sp')">
                                                    <label class="form-check-label" for="defaultCheck4">
                                                        Стоматологическая поликлиника
                                                    </label>
                                                </div>
                                                <div class="form-check margleft">
                                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck4" onclick="toggleTabs(this,'bsu')">
                                                    <label class="form-check-label" for="defaultCheck4">
                                                        Больница сестринского ухода
                                                    </label>
                                                </div>
                                                <div class="form-check margleft">
                                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck4" onclick="toggleTabs(this,'ub')">
                                                    <label class="form-check-label" for="defaultCheck4">
                                                        Участковая больница
                                                    </label>
                                                </div>
                                                <div class="form-check margleft">
                                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck4" onclick="toggleTabs(this,'crb')">
                                                    <label class="form-check-label" for="defaultCheck4">
                                                        Центральная районная больница
                                                    </label>
                                                </div>
                                                <div class="form-check margleft">
                                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck4" onclick="toggleTabs(this,'gb')">
                                                    <label class="form-check-label" for="defaultCheck4">
                                                        Городская больница
                                                    </label>
                                                </div>
                                                <div class="form-check margleft">
                                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck4" onclick="toggleTabs(this,'rd')">
                                                    <label class="form-check-label" for="defaultCheck4">
                                                        Родильный дом
                                                    </label>
                                                </div>
                                                <div class="form-check margleft">
                                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck4" onclick="toggleTabs(this,'ob')">
                                                    <label class="form-check-label" for="defaultCheck4">
                                                        Областная больница (диспансер, центр)
                                                    </label>
                                                </div>
                                                <div class="form-check margleft">
                                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck4" onclick="toggleTabs(this,'rc')">
                                                    <label class="form-check-label" for="defaultCheck4">
                                                        Республиканский центр (больница)
                                                    </label>
                                                </div>
                                                <div class="form-check margleft">
                                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck4" onclick="toggleTabs(this,'db')">
                                                    <label class="form-check-label" for="defaultCheck4">
                                                        Детская больница
                                                    </label>
                                                </div>
                                                <div class="form-check margleft">
                                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck4" onclick="toggleTabs(this,'bsp')">
                                                    <label class="form-check-label" for="defaultCheck4">
                                                        Больница скорой помощи
                                                    </label>
                                                </div>
                                                <div class="form-check margleft">
                                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck4" onclick="toggleTabs(this,'cpk')">
                                                    <label class="form-check-label" for="defaultCheck4">
                                                        Центр (станция) переливания крови
                                                    </label>
                                                </div>
                                                <div class="form-check margleft">
                                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck4" onclick="toggleTabs(this,'csmp')">
                                                    <label class="form-check-label" for="defaultCheck4">
                                                        Центр (станция) скорой медицинской помощи
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>



                        <div class="tab-pane fade show " id="tab2-" role="tabpanel" aria-labelledby="business-tab" >

                            <div class="row">
                                <div class="col-12 grid-margin">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="container">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <table class="table table-bordered">
                                                            <thead>
                                                            <tr>
                                                                <th scope="col">№ п/п</th>
                                                                <th scope="col">Наименование критерия </th>
                                                                <th scope="col">Класс</th>
                                                                <th scope="col">Наименование ЛПА</th>
                                                                <th scope="col">Приложения</th>
                                                                <th scope="col">Соответствие критерию (выполнено / не выполнено)</th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <tr>
                                                                <th scope="row">1</th>
                                                                <td>Первый критерий</td>
                                                                <td></td>
                                                                <td class = "lpa" contenteditable ></td>
                                                                <td ></td>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">2</th>
                                                                <td>Второй критерий</td>
                                                                <td></td>
                                                                <td class="lpa" contenteditable ></td>
                                                                <td ></td>
                                                            </tr>

                                                            <tr>
                                                                <th scope="row">3</th>
                                                                <td>Третий критерий</td>
                                                                <td></td>
                                                                <td class="lpa" contenteditable ></td>
                                                                <td ></td>
                                                            </tr>

                                                            <tr>
                                                                <th scope="row">4</th>
                                                                <td>Четвертый критерий</td>
                                                                <td></td>
                                                                <td class="lpa" contenteditable ></td>
                                                                <td ></td>
                                                            </tr>

                                                            <tr>
                                                                <th scope="row">5</th>
                                                                <td>Пятый критерий</td>
                                                                <td></td>
                                                                <td class="lpa" contenteditable ></td>
                                                                <td ></td>
                                                            </tr>

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

<!--                        <div class="tab-pane fade show " id="tab-3" role="tabpanel" aria-labelledby="business-tab" >-->
<!--                            <div class="row">-->
<!--                                <div class="col-12 grid-margin">-->
<!--                                    <div class="card">-->
<!--                                        <div class="card-body">-->
<!--                                            3-->
<!--                                        </div>-->
<!--                                    </div>-->
<!--                                </div>-->
<!--                            </div>-->
<!--                        </div>-->
<!---->
<!---->
<!--                        <div class="tab-pane fade show " id="tab-4" role="tabpanel" aria-labelledby="business-tab" >-->
<!---->
<!--                            <div class="row">-->
<!--                                <div class="col-12 grid-margin">-->
<!--                                    <div class="card">-->
<!--                                        <div class="card-body">-->
<!--                                            4-->
<!--                                        </div>-->
<!--                                    </div>-->
<!--                                </div>-->
<!--                            </div>-->
<!--                        </div>-->
<!---->
<!--                        <div class="tab-pane fade show" id="tab-5" role="tabpanel" aria-labelledby="business-tab" >-->
<!---->
<!--                            <div class="row">-->
<!--                                <div class="col-12 grid-margin">-->
<!--                                    <div class="card">-->
<!--                                        <div class="card-body">-->
<!--                                            5-->
<!--                                        </div>-->
<!--                                    </div>-->
<!--                                </div>-->
<!--                            </div>-->
<!--                        </div>-->


                    </div>
                </div>





            </div>
            <!-- Modal footer -->
            <div class="modal-footer">
<!--                <form action="getApplication.php" method="post">-->
<!--                    <input type="text" name="count" id="count"/>-->
<!--                <p id="btnSuc" style="cursor: pointer">Загрузить данные</p>-->
                <button type="submit" class="btn btn-light btn-fw" id="btnPrint">Печать</button>
                    <button type="submit" class="btn btn-warning btn-fw" id="btnSuc">Сохранить</button>
<!--                </form>-->
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Закрыть</button>
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

   $("#btnSuc").on("click", function () {
       let number_app = document.getElementById("id_application");
       let naim = document.getElementById("naim");
       let unp = document.getElementById("unp");
       let naimText = naim.value;
       let unpText = unp.value;
       let id_application = number_app.innerText;
       let modal = document.getElementById("myModal");
       modal.classList.add("show");
       modal.style = "display: block";

       var doverennost = document.getElementById("doverennost"),
           xhr = new XMLHttpRequest(),
           form = new FormData();
       var upload_file = doverennost.files[0];
       form.append("doverennost", upload_file);
       form.append("naimUZ", naimText);
       form.append("unp", unpText);
       form.append("id_application", id_application);

       xhr.open("post", "saveApplication.php", true);
       xhr.send(form);
        alert("Заявление сохранено");
        location.href = "/index.php?application";
       // $.ajax({
       //     url: "saveApplication.php",
       //     method: "POST",
       //     data: {id_application: id_application}
       // })
       //     .done(function( response ) {
       //         alert("ok");
       //     });

       // var doverennost = document.getElementById("doverennost"),
        //     xhr = new XMLHttpRequest(),
        //     form = new FormData();
        // var upload_file = doverennost.files[0];
        // form.append("doverennost", upload_file);
        // xhr.open("post", "saveFiles.php", true);
        // xhr.send(form);

    });
    });
</script>

<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script></script>
<!--<script>--><?php //include 'getApplication.php' ?><!--</script>-->
<!--<script>console.log(filesName)</script>-->
<script src="dist/js/formApplication.js"></script>

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