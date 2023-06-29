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
        <h2 class="text-dark font-weight-bold mb-2"> Организации </h2>
        <div class="d-sm-flex justify-content-xl-between align-items-center mb-2">

<!--            <div class="dropdown ml-0 ml-md-4 mt-2 mt-lg-0">-->
<!--                <button class="btn bg-white  p-3 d-flex align-items-center" type="button" id="dropdownMenuButton1" onclick="createApplication()"> Создать заявление </button>-->
<!--            </div>-->
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

                    <div class="row">
                        <div class="col-12 grid-margin">
                            <div class="card">
                                <div class="card-body">

                                    <?php

                                    $query = "SELECT * FROM users where id_role = 3";
                                    $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                    for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                                    ?>

                                    <table id="example" class="table table-striped table-bordered" style="width:100%">
                                        <thead>
                                        <tr>
                                            <th>Пользователи</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <?php

                                        foreach ($data as $app) {

                                            ?>

                                            <tr onclick="showModalApps('<?= $app['username'] ?>')" style="cursor: pointer;">


                                                <td><?= $app['username'] ?></td>


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
            <div class="modal-header" id="myModalHeader">
                <h4 class="modal-title">Заявления пользователя</h4>
                <h4 id="id_application"></h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal">x</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">

                <table id="table-apps" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>Заявления</th>
                    </tr>
                    </thead>
                    <tbody>


                    </tbody>

                </table>

            </div>
            <!-- Modal footer -->
            <div class="modal-footer" id="myModalFooter">

<!--                <button type="submit" class="btn btn-warning btn-fw" id="btnSuc">Сохранить</button>-->

                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Закрыть</button>
            </div>

        </div>
    </div>
</div>

<div class="modal" id="modalApp">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header" id="modalAppHeader">
                <h4 class="modal-title">Заявление</h4>
                <h4 id="id_app"></h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal">x</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">

                <div class="col-md-12">
                    <div class="d-sm-flex justify-content-between align-items-center transaparent-tab-border ">
                        <ul class="nav nav-tabs tab-transparent" role="tablist">
                            <li class="nav-item" id="home-tab" onclick="showTab1()">
                                <a class="nav-link"  data-toggle="tab" href="#" role="tab" aria-selected="true">Общие сведения о заявителе</a>
                            </li>
                            <li class="nav-item hiddentab" id="khirurg-tab" onclick="showTab2()">
                                <a class="nav-link"  data-toggle="tab" href="#" role="tab" aria-selected="false">Хирургия</a>
                            </li>
                            <li class="nav-item hiddentab" id="rodovspom-tab" onclick="showTab3()">
                                <a class="nav-link"  data-toggle="tab" href="#" role="tab" aria-selected="false">Родовспоможение</a>
                            </li>
                            <li class="nav-item hiddentab" id="akush-tab" onclick="showTab4()">
                                <a class="nav-link"  data-toggle="tab" href="#" role="tab" aria-selected="false">Акушерство и гинекология</a>
                            </li>
                            <li class="nav-item hiddentab" id="anest-tab" onclick="showTab5()">
                                <a class="nav-link"  data-toggle="tab" href="#" role="tab" aria-selected="false">Анестезиология и реаниматология</a>
                            </li>
                        </ul>
                        <div class="d-md-block d-none">
                            <a href="#" class="text-light p-1"><i class="mdi mdi-view-dashboard"></i></a>
                            <a href="#" class="text-light p-1"><i class="mdi mdi-dots-vertical"></i></a>
                        </div>
                    </div>
                    <div class="tab-content tab-transparent-content">
                        <div class="tab-pane fade show active" id="tab-1" role="tabpanel" aria-labelledby="business-tab" >

                            <div class="row">
                                <div class="col-12 grid-margin">
                                    <div class="card">
                                        <div class="card-body">

                                            <div class="form-group"> <label>Наименование заинтересованного лица</label><input id="naim" type="text" class="form-control"/></div>
                                            <div class="form-group"><label>Сокращенное наименование</label><input class="form-control" type="text"/></div>
                                            <div class="form-group"><label>УНП</label><input class="form-control" type="text" id="unp" onfocusout="onInputUnp()"/></div>
                                            <div class="form-group"><label>Юридический адрес</label><input class="form-control" type="text" id="adress" onfocusout="onInputAdress()"/></div>
                                            <div class="form-group"><label>Номер телефона</label><input class="form-control" type="text"/></div>
                                            <div class="form-group"><label>Электронная почта</label><input class="form-control" type="email" id="email" onfocusout="onInputEmail()"/></div>
                                            <div class="form-group"><label style="font-size: 18px">Инициатор административной процедуры</label></div>
                                            <div class="form-check margleft">
                                                <input class="form-check-input" type="radio" name="exampleRadios" id="rukovoditel" value="option1" onclick="deleteDoverennost(this)" checked>
                                                <label class="form-check-label" for="rukovoditel">
                                                    Руководитель заинтересованного лица
                                                </label>
                                            </div>
                                            <div class="form-check margleft">
                                                <input class="form-check-input" type="radio" name="exampleRadios" id="predstavitel" value="option2" onclick="showDoverennost(this)">
                                                <label class="form-check-label" for="predstavitel">
                                                    Представитель заинтересованного лица
                                                </label>
                                            </div>
                                            <br/>
                                            <form id="formDoverennost" method="post" class="hiddentab">
                                                <div class="form-group" id="divDoverennost">
                                                    <label for="doverennost">Доверенность</label>
                                                    <input type="file" name="doverennost" class="form-control-file" id="doverennost">
                                                </div>
                                            </form>

                                            <div class="row">
                                                <div class="col">
                                                    <input type="text" class="form-control" placeholder="Имя">
                                                </div>
                                                <div class="col">
                                                    <input type="text" class="form-control" placeholder="Фамилия">
                                                </div>
                                                <div class="col">
                                                    <input type="text" class="form-control" placeholder="Отчество">
                                                </div>
                                            </div>

                                            <br/>
                                            <div class="form-group"> <label>Должность</label><input  type="text" class="form-control"/></div>

                                            <div class="form-group"> <label style="font-size: 18px">Обязательные документы</label></div>

                                            <form id="formCopyRaspisanie">
                                                <div class="form-group">
                                                    <label for="copyRaspisanie">Копия штатного расписания</label>
                                                    <input type="file" class="form-control-file" name="Name" id="copyRaspisanie">
                                                </div>
                                            </form>

                                            <form id="formInfoMedTecnics" >
                                                <div class="form-group">
                                                    <label for="infoMedTecnics">Информация об используемой медицинской технике с указанием ее наименования, количества, продолжительности эксплуатации и срока службы</label>
                                                    <input type="file" class="form-control-file" id="infoMedTecnics">
                                                </div>
                                            </form>

                                            <div class="form-group"><label for="formGroupExampleInput" style="font-size: 18px; text-align: left;">Типы учреждения</label>
                                                <div class="form-check margleft">
                                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck1" onclick="toggleTabs(this,'khirurg-tab')">
                                                    <label class="form-check-label" for="defaultCheck1">
                                                        Хирургия
                                                    </label>
                                                </div>
                                                <div class="form-check margleft">
                                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck2" onclick="toggleTabs(this,'rodovspom-tab')">
                                                    <label class="form-check-label" for="defaultCheck2" >
                                                        Родовспоможение
                                                    </label>
                                                </div>
                                                <div class="form-check margleft">
                                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck3" onclick="toggleTabs(this,'akush-tab')">
                                                    <label class="form-check-label" for="defaultCheck3">
                                                        Акушерство и гинекология
                                                    </label>
                                                </div>
                                                <div class="form-check margleft">
                                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck4" onclick="toggleTabs(this,'anest-tab')">
                                                    <label class="form-check-label" for="defaultCheck4">
                                                        Анестезиология и реаниматология
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>



                        <div class="tab-pane fade show " id="tab-2" role="tabpanel" aria-labelledby="business-tab" >

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

                    </div>
                </div>

            </div>
            <!-- Modal footer -->
            <div class="modal-footer" id="modalAppFooter">

                <button type="submit" class="btn btn-light btn-fw" id="btnPrint">Печать</button>
<!--                <button type="submit" class="btn btn-warning btn-fw" id="btnSuc">Сохранить</button>-->

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
            let naimText = naim.value;
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
            form.append("id_application", id_application);

            xhr.open("post", "saveApplication.php", true);
            xhr.send(form);
            alert("Заявление сохранено");
            location.href = "/index.php?application";


        });
    });
</script>

<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script></script>
<!--<script>--><?php //include 'getApplication.php' ?><!--</script>-->
<!--<script>console.log(filesName)</script>-->
<script src="dist/js/formUsers.js"></script>

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