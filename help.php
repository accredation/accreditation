<style>
    .card {
        position: relative;
        display: -ms-flexbox;
        display: flex;
        -ms-flex-direction: column;
        flex-direction: column;
        min-width: 0;
        word-wrap: break-word;
        background-color: #fff;
        background-clip: border-box;
        border: 0 solid rgba(0, 0, 0, 0.125);
        border-radius: 0.25rem;
    }
    .direct-chat-messages {
        -webkit-transform: translate(0, 0);
        transform: translate(0, 0);
        overflow: auto;
        padding: 10px;
    }
    .direct-chat-infos {
        display: block;
        font-size: 0.875rem;
        margin-bottom: 2px;
    }
    .direct-chat-name {
        font-weight: 600;
    }
    .float-left {
        float: left !important;
    }
    .direct-chat-msg {
        margin-bottom: 10px;
    }

    .direct-chat-msg, .direct-chat-text {
        display: block;
    }
    .direct-chat-text {
        border-radius: 0.3rem;
        background-color: #d2d6de;
        border: 1px solid #d2d6de;
        color: #444;
        margin: 5px 0 0 1rem;
        padding: 5px 10px;
        position: relative;
    }
    .card .card-body {
         padding: 1rem;

    }
    .direct-chat-infos {
        display: block;
        font-size: 0.875rem;
        margin-bottom: 2px;
    }
    .content-wrapper {
        background: #f0f1f6;
        padding: 0.875rem 2.875rem 0 2.875rem;
        width: 100%;
        -webkit-box-flex: 1;
        -ms-flex-positive: 1;
        flex-grow: 1;
    }
    .container-fluid1{
        width: 50%;
        padding-right: 9px;
        padding-left: 9px;
        margin-right: auto;
        margin-left: 0;
    }
    @media (max-width: 800px) {
        .container-fluid1{
            width: 100%;
            padding-right: 9px;
            padding-left: 9px;
            margin-right: auto;
            margin-left: 0;
        }
    }

    .question{
        padding: 5px 20px;
        border-bottom: 1px solid #d1d1d1;
        max-width: 100%;
        margin-bottom: 10px;
        width: 100%;
        text-align: left;
        font-size: 19px;
        font-weight: 600;
    }
    /*.question span {*/
    /*    float: left;*/
    /*    font-size: 14px;*/
    /*    display: flex;*/
    /*    align-items: center;*/
    /*    justify-content: center;*/
    /*    border: 1px solid;*/
    /*    width: 30px;*/
    /*    height: 30px;*/
    /*}*/
    .content1 {
        text-align: left;
        font-size: 14px;
        font-weight: 300;
        display:none
    }

    .file-block {
        display: inline-block;
        width: 18%;
        margin: 10px;
        height: 99px;
    }

    .file-link {
        text-decoration: none;
        color: #333;
    }

    .file-link:hover {
        color: #0099ff;
    }

    .file-icon {
        width: 50px;
        height: 50px;
    }

    .file-name {
        display: block;
        margin-top: 5px;
    }
    .col-lg-2{
        margin-left: 2rem
    }
    @media (max-width: 800px) {
        .col-lg-2{
            margin-left: 0rem;
        }
    }
</style>
<div class="content-wrapper">
    <h2 for="quastion" style = "margin-top: 1rem; cursor: pointer;" id="razled_1_h" onclick="togleDiv('razled_1_h','razled_1_row')">Регламентирующие документы</h2><br/>
    <div class="row hidden" id="razled_1_row" hidden>
            <?php
                $query_RAZDEL_1 = "SELECT * FROM `documents` where razdel  = 1";
                $result_RAZDEL_1=mysqli_query($con, $query_RAZDEL_1) or die ( mysqli_error($con));
                for ($data = []; $row = mysqli_fetch_assoc($result_RAZDEL_1); $data[] = $row);
                
                foreach ($data as $app_RAZDEL_1) {
                    
                ?>
                <div class="col-lg-2 mb-2">
                    <a href="documentation/Регламентирующие документы/<?= $app_RAZDEL_1['doc_name_with_type'] ?>" class="file-link">
                        <img src="assets/images/<?= $app_RAZDEL_1['img_name'] ?>" alt="<?= $app_RAZDEL_1['doc_type'] ?>" class="file-icon">
                        <span class="file-name"><?= $app_RAZDEL_1['doc_name'] ?></span>
                    </a>
                </div>
            <?php } ?>

    </div>

    <h2 for="quastion" style = "margin-top: 1rem; cursor: pointer;" id="razled_2_h" onclick="togleDiv('razled_2_h','razled_2_row')">Формы обязательных документов</h2><br/>
    <div class="row hidden" id="razled_2_row" hidden>
        <?php
                $query_RAZDEL_2 = "SELECT * FROM `documents` where razdel  = 2";
                $result_RAZDEL_2=mysqli_query($con, $query_RAZDEL_2) or die ( mysqli_error($con));
                for ($data = []; $row = mysqli_fetch_assoc($result_RAZDEL_2); $data[] = $row);
                
                foreach ($data as $app_RAZDEL_2) {
                    
                ?>
                <div class="col-lg-2 mb-2">
                    <a href="documentation/Формы обязательных документов/<?= $app_RAZDEL_2['doc_name_with_type'] ?>" class="file-link">
                        <img src="assets/images/<?= $app_RAZDEL_2['img_name'] ?>" alt="<?= $app_RAZDEL_2['doc_type'] ?>" class="file-icon">
                        <span class="file-name"><?= $app_RAZDEL_2['doc_name'] ?></span>
                    </a>
                </div>
        <?php } ?>

    </div>

    <h2 for="quastion" style = "margin-top: 1rem; cursor: pointer;" id="razled_3_h" onclick="togleDiv('razled_3_h','razled_3_row')">Обучающие материалы и видео</h2><br/>
    <div class="row hidden" id="razled_3_row" hidden>
    <?php
                $query_RAZDEL_3 = "SELECT * FROM `documents` where razdel  = 3";
                $result_RAZDEL_3=mysqli_query($con, $query_RAZDEL_3) or die ( mysqli_error($con));
                for ($data = []; $row = mysqli_fetch_assoc($result_RAZDEL_3); $data[] = $row);
                
                foreach ($data as $app_RAZDEL_3) {
                    
                ?>
                <div class="col-lg-2 mb-2">
                    <a href="documentation/Обучающие материалы и видео/<?= $app_RAZDEL_3['doc_name_with_type'] ?>" class="file-link">
                        <img src="assets/images/<?= $app_RAZDEL_3['img_name'] ?>" alt="<?= $app_RAZDEL_3['doc_type'] ?>" class="file-icon">
                        <span class="file-name"><?= $app_RAZDEL_3['doc_name'] ?></span>
                    </a>
                </div>
        <?php } ?>

    </div>

    <section class="content">


        <div class="card direct-chat direct-chat-primary" style="margin-top: 2rem">

            <div class="card direct-chat direct-chat-primary" >
                <div class="card-header" style="background-color: #148A8A; color: white; height: 3rem">
                    <h3 class="card-title" style=" color: white;">Часто задаваемые вопросы</h3>

                </div>
            <!-- /.card-header -->
            <div class="card-body">
                <!-- Conversations are loaded here -->
                <?php
                $query = "SELECT * FROM `questions` where important  = 1";
                $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                $i=0;
                foreach ($data as $app) {
                    $i++;
                ?>
                <div class="faq">
                    <div class="question" style="cursor: pointer">
                        <p><?= $i?>. <span>   <?= $app['question']?></span></p>
                        <div class="content1"><?= $app['answer']?></div>
                    </div>
                </div>
                <?php } ?>

            </div>
            </div>
        </div>
    </section>

    <div class="container-fluid1">
        <!-- Small boxes (Stat box) -->
        <!-- /.row -->
        <!-- Main row -->

        <?php if (isset($_COOKIE['login'])) { ?>
            <h2 for="quastion" style = "margin-top: 2rem">Задать вопрос</h2>
            <span>Есть вопросы? Пожалуйста, сформулируйте Ваш вопрос достаточно подробно и воспользуйтесь при необходимости функцией для прикрепления файла (документ или снимок экрана). При ответе сотрудника отдела сопровождения Вы получите уведомление на электронную почту, которую укажете при отправке вопроса.</span>
            <br/>
            <br/>
            <textarea name="" id="question"  rows="7" style="width: 100%;"></textarea><br/>

            <div>
            <label for="typeQuestion">Тип вопроса</label><br/>
            <select id="typeQuestion">
                <option selected disabled>Выберите тип</option>
                <option value="">по использованию программы</option>
                <option value="">по самооценке и заполнению таблиц критериев</option>
                <option value="">предложения по программе или критериям</option>
            </select>
            </div>
            <br/>
            <input type="file" id="screenQuestion"/>
            <br/>
            <br/>
            <button type="submit" class="btn btn-success btn-fw" id="btnQuestion">Отправить</button>
        <?php }?>
    </div>
    <div class="container-fluid1" style="margin-top: 2rem; width: 80%;">
    <h2>Техническая поддержка</h2>
    <div class="row" style="margin-top: 2rem">

        <!-- Left col -->
        <section class="col-lg-12" style="padding-left: 2%; ">
            <!-- <div class="row"><p style="text-align: justify;font-size: 1.1rem">Контакты: </p> </div> -->


            <div class="row" >
                <section class="col-lg-4" style="padding-left: 2%">
                    <div class="row mb-0" style="font-size: 1.1rem" >
                    <section  style="padding-left: 2%">
                        <p style="display:inline;font-size: 1.1rem">График работы:</p><br>
                        <p style="display:inline;font-size: 1.1rem">Понедельник - Четверг: 8:30 - 17:30</p><br>
                        <p style="display:inline;font-size: 1.1rem">Пятница: 8:30 - 17:00</p>
                    </section>

                    </div>
                    <div class="row mb-0" style="font-size: 1.1rem" >
                        <section style="padding-left: 2%">
                            <p style="text-align: justify;font-size: 1.1rem">e-mail: <a href="mailto:support@rnpcmt.by">support@rnpcmt.by</a></p>
                        </section>
                    </div>
                </section>

                <section class="col-lg-4" style="padding-left: 2%">
                    <p style="display:inline; font-size: 1.1rem">Василевич Анжелика Дмитриевна</p><br/>
                    Тел.: +375 17 311-50-92<br/>
                </section>
                <section class="col-lg-4">
                    <p class="card-text" style="display:inline; font-size: 1.1rem">Довнар Ольга Александровна</p><br/>
                    Тел.: +375 17 311-50-88<br/>
                </section>
            </div>

        </section>
    </div>
    </div>
</div>



<script>
    function getCookie(cname) {
        let name = cname + "=";
        let decodedCookie = decodeURIComponent(document.cookie);
        let ca = decodedCookie.split(';');
        for(let i = 0; i <ca.length; i++) {
            let c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }

    let txtArea = document.getElementById("question");
    $("#btnQuestion").on("click", () => {
        let screenQuestionInput = document.getElementById("screenQuestion");
        let screenQuestion = screenQuestionInput.files[0];

        let selectType = document.getElementById("typeQuestion");
        if(selectType.selectedIndex === 0){
            alert("Выберите тип вопроса.");
        }else{
            let mail = prompt("Введите почту, на которую хотите получить ответ от технической поддержки.");

                let xhr = new XMLHttpRequest(),
                    form = new FormData();
                form.append("id_user", getCookie('id_user'));
                form.append("question", txtArea.value);
                form.append("typeQuestion", selectType.options[selectType.selectedIndex].innerText);
                form.append("screenQuestion", screenQuestion);
                console.log(mail);
                if(mail !== null) {
                    if (mail !== "") {
                        form.append("email", mail);
                    } else {
                        form.append("email", "support@rnpcmt.by");
                    }
                }
                else{
                    form.append("email", "support@rnpcmt.by");
                }
                xhr.open("post", "sendQuestion.php", true);
                xhr.send(form);
                alert("Ваш вопрос передан сотрудникам отдела сопровождения. При ответе сотрудника отдела сопровождения Вы получите уведомление на электронную почту Вашей организации.");
                location.href = "index.php?help";

        }

    });

      let itemMenu = document.querySelector("[href='help.php']");
      itemMenu.style = "color: #148A8A;";

</script>

<script>
    $('.question').click(function() {
        $(this).find('.content1').toggle(200); //скрытие, показ ответа
        $(this).find('span').css('transform', 'rotate(0deg)'); //поворот стрелки
        if ($(this).hasClass('open')) {
            $(this).removeClass('open');
        } else {
            $(this).addClass('open');
            $(this).find('span').css('transform', 'rotate(180deg)'); //поворот стрелки
        };
    });
</script>

<script>
    function togleDiv(parent_el,row_el) {
       let pnt_element = document.getElementById(parent_el);

       let rw_el = document.getElementById(row_el)

       if  (!rw_el.classList.contains('hidden')){
         rw_el.setAttribute('hidden','true');
         rw_el.classList.add('hidden');
       } else {
         rw_el.removeAttribute('hidden');
         rw_el.classList.remove('hidden');
       }
    }
</script>