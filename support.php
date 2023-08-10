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
                              left outer join users u on q.id_user =u.id_user 
                               ";
                                        $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                                        ?>

                                        <table id="example" class="table table-striped table-bordered" style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Вопрос</th>
                                                <th>Ответ</th>
                                                <th>Файл</th>
                                                <th>Пользователь</th>
                                                <th></th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                ?>
                                                <!-- <tr onclick="showModal('<?= $app['id_question'] ?>', '')" style="cursor: pointer;"> -->
                                                <tr  style="cursor: pointer; height: 100px;">
                                                    <td style="width: 20%;"><?= $app['question'] ?></td>
                                                    <td style="width: 30%"><textarea style="width: 100%; height: 100%" id="<?= $app['id_question'] ?>" rows="5" ><?= $app['answer'] ?></textarea></td>
                                                    <td><a href="<?= $app['file'] ?>" target="_blank">файл</a></td>
                                                    <td><?= $app['username'] ?></td>
                                                    <td><button class="btn btn-success btn-fw" onclick="sendAnswerQuestion('<?= $app['id_question'] ?>', document.getElementById('<?= $app['id_question'] ?>').value)">Ответить</button></td>

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
                                        left outer join users u on q.id_user =u.id_user 
                                        ";
                                        $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                                        ?>

                                        <table id="example" class="table table-striped table-bordered" style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Вопросы</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                ?>
                                                <!-- <tr onclick="showModal('<?= $app['id_question'] ?>', '')" style="cursor: pointer;"> -->
                                                <tr  style="cursor: pointer;">
                                                    <td>от <?= $app['username'] ?></td>
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
                                        left outer join users u on q.id_user =u.id_user 
                                        ";
                                        $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                                        ?>

                                        <table id="example" class="table table-striped table-bordered" style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Вопросы</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                ?>
                                                <!-- <tr onclick="showModal('<?= $app['id_question'] ?>', '')" style="cursor: pointer;"> -->
                                                <tr style="cursor: pointer;">
                                                    <td>от <?= $app['username'] ?></td>
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
            if((!answer) || (answer===null) || (answer.trim()==='')){
                alert('Поле ответа пусто');
                return
            }

            $.ajax({
                url: "sendAnswer.php",
                method: "GET",
                data: {id_question: id, answer: answer}

            })
                .done(function (response) {
                    alert("Ответ отправлен.");
                })
        }

    </script>
<?php }

?>


