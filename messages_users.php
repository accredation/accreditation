
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
            <h2 class="text-dark font-weight-bold mb-2"> Мои вопросы</h2>
            <div class="d-sm-flex justify-content-xl-between align-items-center mb-2">
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="d-sm-flex justify-content-between align-items-center transaparent-tab-border ">
                    <ul class="nav nav-tabs tab-transparent" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="all-question-tab" data-toggle="tab" href="#allQuestions" role="tab" aria-selected="true">Все вопросы</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link " id="new-question-tab" data-toggle="tab" href="#newQuestions" role="tab" aria-selected="false">Новые</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="answer-qestion-tab" data-toggle="tab" href="#answerQestions" role="tab" aria-selected="false">Обработанные</a>
                        </li>
                        <!-- <li class="nav-item">
                          <a class="nav-link" id="neodobrennie-tab" data-toggle="tab" href="#" role="tab" aria-selected="false">Отклоненные</a>
                        </li> -->
                    </ul>
                    <div class="d-md-block d-none">

                    </div>
                </div>
                <div class="tab-content tab-transparent-content">
                    <div class="tab-pane fade show active" id="allQuestions" role="tabpanel" aria-labelledby="all-question-tab">

                        <div class="row">
                            <div class="col-12 grid-margin">
                                <div class="card">
                                    <div class="card-body">

                                        <?php
                                        $query = "SELECT * 
                                                  FROM questions q 
                                                 LEFT OUTER JOIN users u on q.id_user = u.id_user 
                                                 WHERE u.login = '".$_COOKIE['login']."'";

                                        $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                                        ?>

                                        <table id="example" class="table table-striped table-bordered" style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Вопрос</th>
                                                <th>Дата вопроса</th>
                                                <th>Ответ</th>
                                                <th>Дата ответа</th>
                                                <th>Файл</th>
                                                <th>Тип вопроса</th>

                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                ?>
                                                <!-- <tr onclick="showModal('<?= $app['id_question'] ?>', '')" style="cursor: pointer;"> -->
                                                <tr  style="cursor: pointer; height: 100px;">
                                                    <td style="width: 20%;"><?= $app['question'] ?></td>
                                                    <td style="width: 20%;"><?= $app['date_question'] ?></td>
                                                    <td style="width: 30%" > <?= $app['answer'] ?></td>
                                                    <td style="width: 20%;"><?= $app['date_answer'] ?></td>
                                                    <td><a href="<?= $app['file'] ?>" target="_blank">файл</a></td>
                                                    <td style="width: 20%;"><?= $app['type_question'] ?></td>


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

                <div class="tab-content tab-transparent-content hiddentab">
                    <div class="tab-pane fade" id="newQuestions" role="tabpanel" aria-labelledby="new-question-tab">
                        <div class="row">
                            <div class="col-12 grid-margin">
                                <div class="card">
                                    <div class="card-body">

                                        <?php
                                        $query = "SELECT * 
                                                  FROM questions q 
                                                 LEFT OUTER JOIN users u on q.id_user = u.id_user 
                                                 WHERE u.login = '".$_COOKIE['login']."' AND (q.answer = '' or q.answer IS NULL)";

                                        $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                                        ?>

                                        <table id="example" class="table table-striped table-bordered" style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Вопрос</th>
                                                <th>Дата вопроса</th>
                                                <th>Ответ</th>
                                                <th>Дата ответа</th>
                                                <th>Файл</th>
                                                <th>Тип вопроса</th>

                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                ?>
                                                <!-- <tr onclick="showModal('<?= $app['id_question'] ?>', '')" style="cursor: pointer;"> -->
                                                <tr  style="cursor: pointer; height: 100px;">
                                                    <td style="width: 20%;"><?= $app['question'] ?></td>
                                                    <td style="width: 20%;"><?= $app['date_question'] ?></td>
                                                    <td style="width: 30%" > <?= $app['answer'] ?></td>
                                                    <td style="width: 20%;"><?= $app['date_answer'] ?></td>
                                                    <td><a href="<?= $app['file'] ?>" target="_blank">файл</a></td>
                                                    <td style="width: 20%;"><?= $app['type_question'] ?></td>

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


                <div class="tab-content tab-transparent-content hiddentab">
                    <div class="tab-pane fade " id="answerQestions" role="tabpanel" aria-labelledby="answer-qestion-tab">
                        <div class="row">
                            <div class="col-12 grid-margin">
                                <div class="card">
                                    <div class="card-body">

                                        <?php
                                        $query = "SELECT * 
                                                  FROM questions q 
                                                 LEFT OUTER JOIN users u on q.id_user = u.id_user 
                                                 WHERE u.login = '".$_COOKIE['login']."' AND q.answer != ''";

                                        $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                                        ?>

                                        <table id="example" class="table table-striped table-bordered" style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Вопрос</th>
                                                <th>Дата вопроса</th>
                                                <th>Ответ</th>
                                                <th>Дата ответа</th>
                                                <th>Файл</th>
                                                <th>Тип вопроса</th>

                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                ?>
                                                <!-- <tr onclick="showModal('<?= $app['id_question'] ?>', '')" style="cursor: pointer;"> -->
                                                <tr  style="cursor: pointer; height: 100px;">
                                                    <td style="width: 20%;"><?= $app['question'] ?></td>
                                                    <td style="width: 20%;"><?= $app['date_question'] ?></td>
                                                    <td style="width: 30%" > <?= $app['answer'] ?></td>
                                                    <td style="width: 20%;"><?= $app['date_answer'] ?></td>
                                                    <td><a href="<?= $app['file'] ?>" target="_blank">файл</a></td>
                                                    <td style="width: 20%;"><?= $app['type_question'] ?></td>

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
                    <button type="button" class="btn  btn-danger btn-close" data-bs-dismiss="modal">x</button>
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

                                                <form id="formFileReportSamoocenka" >
                                                    <div class="form-group " id = "divFileReportSamoocenka">
                                                        <label for="reportSamoocenka">Результат самооценки</label>
                                                        <input type="file" class="form-control-file" id="reportSamoocenka">
                                                    </div>
                                                </form>
                                            </div>
                                            <div class="card-body" id="mainRightCard">

                                            </div>
                                            <form id="formReport" >
                                                <div class="form-group" id = "divReport" style="margin-left: 2.5rem">
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
                    <button type="submit" class="btn btn-success btn-fw" id="btnSend">Отправить</button>
                    <button type="submit" class="btn btn-light btn-fw" id="btnPrint">Печать</button>
                    <button type="submit"  class="btn btn-light btn-fw" id="btnPrintReport">Результат самооценки</button>
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


        });
    </script>



    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <!--<script>--><?php //include 'getApplication.php' ?><!--</script>-->
    <!--<script>console.log(filesName)</script>-->
    <!-- <script src="dist/js/formApplication.js"></script> -->


    <script>
        let allTabsMainPage = document.getElementsByClassName("tab-content tab-transparent-content");
        let tabs = document.getElementsByClassName("tab-content tab-transparent-content");

        $("#all-question-tab").on("click", () => {

            for (let i = 0 ; i < 4; i++){
                allTabsMainPage[i].children[0].classList.remove("show");
                allTabsMainPage[i].children[0].classList.remove("active");
                allTabsMainPage[i].classList.add("hiddentab");
            }
            allTabsMainPage[0].children[0].classList.add("show");
            allTabsMainPage[0].children[0].classList.add("active");
            allTabsMainPage[0].classList.remove("hiddentab");
            status = 1;

            //  console.log(status);
        });

        $("#new-question-tab").on("click", () => {

            for (let i = 0 ; i < 4; i++){
                allTabsMainPage[i].children[0].classList.remove("show");
                allTabsMainPage[i].children[0].classList.remove("active");
                allTabsMainPage[i].classList.add("hiddentab");
            }
            allTabsMainPage[1].children[0].classList.add("show");
            allTabsMainPage[1].children[0].classList.add("active");
            allTabsMainPage[1].classList.remove("hiddentab");
            status = 2;
            //  console.log(status);

        });

        $("#answer-qestion-tab").on("click", () => {

            for (let i = 0 ; i < 4; i++){
                allTabsMainPage[i].children[0].classList.remove("show");
                allTabsMainPage[i].children[0].classList.remove("active");
                allTabsMainPage[i].classList.add("hiddentab");
            }
            allTabsMainPage[2].children[0].classList.add("show");
            allTabsMainPage[2].children[0].classList.add("active");
            allTabsMainPage[2].classList.remove("hiddentab");
            status = 4;
            //  console.log(status);

        });



    </script>
    <script>
        let tabLink = document.querySelector('#all-question-tab');
        let tabPane = document.querySelector('#allQuestions');


        tabLink.addEventListener('click', function(event) {
            event.preventDefault();

            // Проверяем, есть ли у вкладки класс 'active'
            if (!tabPane.classList.contains('active') ) {
                // Если нет, то устанавливаем класс 'active'
                tabs.forEach((item)=>{
                    item.classList.add("hiddentab");
                });
                tabPane.classList.add('active');
            }
        });
    </script>


    <script>
        function sendAnswerQuestion(id, answer){
            $.ajax({
                url: "sendAnswer.php",
                method: "GET",
                data: {id_question: id, answer: answer}

            })
                .done(function (response) {
                    // alert("123");
                })
        }

    </script>
<?php }

?>


