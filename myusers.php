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
            <h2 class="text-dark font-weight-bold mb-2"> Вопросы </h2>
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
                        <li class="nav-item">
                            <a class="nav-link" id="faq-tab" data-toggle="tab" href="#faq" role="tab" aria-selected="false">Часто задаваемые</a>
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
                              left outer join users u on q.id_user =u.id_user where important <> 1
                               ";
                                        $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                                        ?>

                                        <table id="example" class="table table-striped table-bordered" style="width:100%">
                                            <thead>
                                            <tr>
                                                <th >Номер</th>
                                                <th >Пользователь</th>
                                                <th >Вопрос</th>
                                                <th id='sotr_th_data'>Дата вопроса</th>
                                                <th >Ответ</th>
                                                <th >Дата ответа</th>
                                                <th >Тип вопроса</th>
                                                <th >Файл</th>
                                                <th></th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                ?>
                                                <!-- <tr onclick="showModal('<?= $app['id_question'] ?>', '')" style="cursor: pointer;"> -->
                                                <tr  style="cursor: pointer; height: 100px;">
                                                    <td><?= $app['id_question'] ?></td>
                                                    <td><?= $app['username'] ?></td>
                                                    <td style="width: 20%;"><?= $app['question'] ?></td>
                                                    <td style="width: 20%;"><?= $app['date_question'] ?></td>
                                                    <td style="width: 30%"> <?php if (!empty($app['answer'])) { ?>
                                                            <textarea style="width: 100%; height: 100%" id="<?= $app['id_question'] ?>" rows="5" disabled><?= $app['answer'] ?></textarea>
                                                        <?php } else { ?>
                                                            <textarea style="width: 100%; height: 100%" id="<?= $app['id_question'] ?>" rows="5"><?= $app['answer'] ?></textarea>
                                                        <?php } ?>
                                                    </td>
                                                    <td style="width: 20%;"><?= $app['date_answer'] ?></td>
                                                    <td style="width: 20%;"><?= $app['type_question'] ?></td>
                                                    <td><?php if($app['file'] != null){ ?>
                                                        <a href="<?= $app['file'] ?>" target="_blank">файл</a></td>
                                                    <?php } ?>
                                                    <?php if (empty($app['answer'])) { ?>
                                                        <td><button class="btn btn-success btn-fw" onclick="sendAnswerQuestion('<?= $app['id_question'] ?>', document.getElementById('<?= $app['id_question'] ?>').value)">Ответить</button></td>
                                                    <?php } else { ?>
                                                        <td><button class="btn btn-success btn-fw" disabled>Ответить</button></td>
                                                    <?php } ?>
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
                                        left outer join users u on q.id_user =u.id_user where q.answer = '' or q.answer IS NULL
                                        ";
                                        $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                                        ?>

                                        <table id="example1" class="table table-striped table-bordered" style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Номер</th>
                                                <th>Вопрос</th>
                                                <th>Ответ</th>
                                                <th>Тип вопроса</th>
                                                <th>Файл</th>
                                                <th style="cursor: pointer" onclick="sortDate()">Дата</th>
                                                <th>Пользователь</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                ?>
                                                <!-- <tr onclick="showModal('<?= $app['id_question'] ?>', '')" style="cursor: pointer;"> -->
                                                <tr  style="cursor: pointer;">
                                                    <td style="width: 5%;"><?= $app['id_question'] ?></td>
                                                    <td style="width: 20%;"><?= $app['question'] ?></td>
                                                    <td style="width: 30%"><textarea style="width: 100%; height: 100%" id="n<?= $app['id_question'] ?>"><?= $app['answer'] ?></textarea></td>
                                                    <td style="width: 20%;"><?= $app['type_question'] ?></td>
                                                    <td><a href="<?= $app['file'] ?>" target="_blank">файл</a></td>

                                                    <td ><?= $app['date_question'] ?></td>
                                                    <td><?= $app['username'] ?></td>
                                                    <td><button class="btn btn-success btn-fw" onclick="sendAnswerQuestion('<?= $app['id_question'] ?>', document.getElementById('n<?= $app['id_question'] ?>').value)">Ответить</button></td>
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
                                        left outer join users u on q.id_user =u.id_user where q.answer != '' and important <> 1
                                        ";
                                        $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                                        ?>

                                        <table id="example" class="table table-striped table-bordered" style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Вопрос</th>
                                                <th>Ответ</th>
                                                <th>Тип вопроса</th>
                                                <th>Файл</th>
                                                <th>Пользователь</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                ?>
                                                <!-- <tr onclick="showModal('<?= $app['id_question'] ?>', '')" style="cursor: pointer;"> -->
                                                <tr style="cursor: pointer;">
                                                    <td style="width: 20%;"><?= $app['question'] ?></td>
                                                    <td style="width: 30%"><?= $app['answer'] ?></td>
                                                    <td style="width: 20%;"><?= $app['type_question'] ?></td>
                                                    <td><a href="<?= $app['file'] ?>" target="_blank">файл</a></td>
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


                <div class="tab-content tab-transparent-content">
                    <div class="tab-pane fade" id="faq" role="tabpanel" aria-labelledby="faq-tab">

                        <div class="row">
                            <div class="col-12 grid-margin">
                                <div class="card">
                                    <div class="card-body">

                                        <?php

                                        $query = "SELECT * 
                              FROM questions q 
                              left outer join users u on q.id_user =u.id_user where important = 1
                               ";
                                        $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                                        ?>

                                        <table id="impTable" class="table table-striped table-bordered" style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Вопрос</th>
                                                <th>Ответ</th>
                                                <th></th>
                                                <th></th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                ?>
                                                <!-- <tr onclick="showModal('<?= $app['id_question'] ?>', '')" style="cursor: pointer;"> -->
                                                <tr  style="cursor: pointer; height: 100px;">
                                                    <td style="width: 40%;"><textarea style="width: 100%; height: 100%" id="question_<?= $app['id_question'] ?>" rows="5" ><?= $app['question'] ?></textarea></td>
                                                    <td style="width: 40%"><textarea style="width: 100%; height: 100%" id="answer_<?= $app['id_question'] ?>" rows="5" ><?= $app['answer'] ?></textarea></td>

                                                    <td style="width: 10%"><button class="btn btn-success btn-fw" onclick="sendAnswerFaqQuestion('<?= $app['id_question'] ?>', document.getElementById('question_'+'<?= $app['id_question'] ?>').value, document.getElementById('answer_'+'<?= $app['id_question'] ?>').value)">Сохранить</button></td>
                                                    <td style="width: 10%"><button class="btn btn-danger btn-fw" onclick="deleteFaqQuestion('<?= $app['id_question'] ?>')">Удалить</button></td>

                                                </tr>
                                                <?php
                                            }
                                            ?>

                                            </tbody>

                                        </table>

                                        <div style="margin-top: 0.5rem">
                                            <button id="btnAddFaq" class="btn btn-success btn-fw" onclick="addQuestion()">Добавить новый вопрос</button>
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

        $("#faq-tab").on("click", () => {

            for (let i = 0 ; i < 4; i++){
                allTabsMainPage[i].children[0].classList.remove("show");
                allTabsMainPage[i].children[0].classList.remove("active");
                allTabsMainPage[i].classList.add("hiddentab");
            }
            allTabsMainPage[3].children[0].classList.add("show");
            allTabsMainPage[3].children[0].classList.add("active");
            allTabsMainPage[3].classList.remove("hiddentab");
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
            if((!answer) || (answer===null) || (answer.trim()==='')){
                alert('Поле ответа пусто');
                return
            }

            $.ajax({
                url: "ajax/sendAnswer.php",
                method: "POST",
                data: {id_question: id, answer: answer}

            })
                .done(function (response) {
                    alert("Ответ отправлен.");
                })
        }

    </script>

    <script>
        function sendAnswerFaqQuestion(id, question, answer){
            console.log(id, question, answer);
            if((!answer) || (answer===null) || (answer.trim()==='')){
                alert('Поле ответа пусто');
                return
            }

            if((!question) || (question===null) || (question.trim()==='')){
                alert('Поле вопроса пусто');
                return
            }

            $.ajax({
                url: "ajax/sendFaqAnswer.php",
                method: "GET",
                data: {id_question: id, question: question, answer: answer}

            })
                .done(function (response) {
                    alert("Вопрос сохранен.");
                })
        }

    </script>

    <script>
        function deleteFaqQuestion(id){
            if(confirm("Вопрос будет удален. Удалить?")) {
                $.ajax({
                    url: "ajax/deleteFaq.php",
                    method: "GET",
                    data: {id_question: id}

                })
                    .done(function (response) {
                        alert("Вопрос удален.");
                        location.href = "/index.php?support";
                    })
            }
        }

        function addQuestion(){
            let impTable = document.getElementById("impTable");
            let tr = impTable.getElementsByTagName("tr");
            let newTr = document.createElement("tr");
            newTr.id = "newTr";
            newTr.style = "cursor: pointer; height: 100px;";
            let td1 = document.createElement("td");
            td1.style = "width: 20%;";
            let textAr1 = document.createElement("textarea");
            textAr1.setAttribute("rows", "5");
            textAr1.style = "width: 100%; height: 100%";
            textAr1.id = "newQuestion";
            td1.appendChild(textAr1);
            let td2 = document.createElement("td");
            td2.style = "width: 30%";
            let textAr2 = document.createElement("textarea");
            textAr2.setAttribute("rows", "5");
            textAr2.style = "width: 100%; height: 100%";
            textAr2.id = "newAnswer";
            td2.appendChild(textAr2);
            let td3 = document.createElement("td");
            let btn3 = document.createElement("button");
            btn3.className = "btn btn-success btn-fw";
            btn3.innerHTML='Сохранить';
            btn3.onclick = () => {addNewQuestion(textAr1.value, textAr2.value)};
            td3.appendChild(btn3);

            let td4 = document.createElement("td");
            let btn4 = document.createElement("button");
            btn4.className = "btn btn-danger btn-fw";
            btn4.innerHTML='Отмена';
            btn4.onclick = () =>{
                newTr.remove();
                let btnAddFaq=document.getElementById('btnAddFaq');
                btnAddFaq.removeAttribute('disabled');
            }
            td4.appendChild(btn4);
            newTr.appendChild(td1);
            newTr.appendChild(td2);
            newTr.appendChild(td3);
            newTr.appendChild(td4);

            //   impTable.appendChild(newTr);
            tr[tr.length-1].insertAdjacentElement("afterend",newTr);



            let btnAddFaq=document.getElementById('btnAddFaq');
            btnAddFaq.setAttribute('disabled','True');
        }

        function addNewQuestion(quest, answ){
            console.log('asdasda ',quest, answ);

            $.ajax({
                url: "ajax/addFaq.php",
                method: "GET",
                data: {question: quest, answer: answ}

            })
                .done(function (response) {
                    alert("Вопрос добавлен.");
                    location.href = "/index.php?support";
                })



        }
        let sorted = false;
        function sortDate(){
            let table = document.getElementById("example1");
            let trs = table.getElementsByTagName("tr");
            let arr = Array.from( table.rows );
            arr = arr.slice(1);
            arr.sort( (a, b) => {

                let str  = new Date(a.cells[5].textContent);
                let str2 = new Date(b.cells[5].textContent);

                if(sorted) {

                    if (str < str2)
                        return 1;
                    else if (str > str2){
                        return -1;
                    }
                    else
                        return 0;

                }else{

                    if (str > str2)
                        return 1;
                    else if (str < str2){
                        return -1;
                    }
                    else{
                        return 0;
                    }

                }

            } );
            if(sorted) {
                sorted = false;
                trs[0].children[5].innerHTML = "Дата ↑";
            }
            else {
                sorted = true;
                trs[0].children[5].innerHTML = "Дата ↓";
            }
            console.log(sorted);
            table.append(...arr);
        }
    </script>


<?php }

?>

<script>
    $(document).ready(function () {
        $(document).ready(function () {
            let example_filter = document.getElementById("sotr_th_data");
            example_filter.click();
            example_filter.click();
        })
    })
</script>

