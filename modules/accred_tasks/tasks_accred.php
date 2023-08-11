<style>
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
    .content1 {
        text-align: left;
        font-size: 14px;
        font-weight: 300;
        display:none
    }
</style>
    <div class="content-wrapper">

            <h2 class="text-dark font-weight-bold mb-2"> Задачи </h2>
            <div class="row">
                <div class="col-12 grid-margin">
                    <div class="card">
                        <div class="card-body">
                            <?php
                            $query = "SELECT a.*, u.username, ram.*, a.id_application as app_id
                                                                FROM applications a
                                                               left outer join report_application_mark ram on a.id_application=ram.id_application
                                                                left outer join users u on a.id_user =u.id_user 
                                                                
                                                                where id_status = 3";
                            $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                            for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);

                                foreach ($data as $app) {
                                    ?>
                                    <div class="faq">
                                        <div class="question" id="<?= $app['app_id']?>" >
                                            <div style="display: flex">
                                                <div onclick="collaps(this)" style="font-size: 1rem;cursor: pointer;width: 18rem" >   <?= $app['username']?> №<?= $app['app_id'] ?></div>
                                                <div style="padding-right: 1rem; padding-left: 1rem">Статус</div>
                                                <div style="padding-right: 1rem">дата подачи</div>
                                                <div style="padding-right: 1rem">ФИО ответственного</div>
                                                <div style="padding-right: 1rem">Начало</div>
                                                <div style="padding-right: 1rem">Завершение</div>
                                                <div style="padding-right: 1rem">Совет</div>
                                                <div style="padding-right: 1rem">Прогресс</div>

                                            </div>

                                            <?php
                                            $id_app = $app['app_id'];
                                            $query1 = "SELECT * FROM subvision where id_application = '$id_app'";
                                            $result1=mysqli_query($con, $query1) or die ( mysqli_error($con));
                                            for ($data1 = []; $row1 = mysqli_fetch_assoc($result1); $data1[] = $row1);

                                            foreach ($data1 as $app1) {
                                            ?>
                                            <div class="content1" style="margin-left:2rem; margin-top: 1rem">
                                                <div><?= $app1['name']?></div>
                                                <div style="padding-right: 1rem; padding-left: 1rem">Статус</div>
                                                <div style="padding-right: 1rem">дата подачи</div>
                                                <div style="padding-right: 1rem">ФИО ответственного</div>
                                                <div style="padding-right: 1rem">Начало</div>
                                                <div style="padding-right: 1rem">Завершение</div>
                                                <div style="padding-right: 1rem">Совет</div>
                                                <div style="padding-right: 1rem">Прогресс</div>
                                                <div style="padding-right: 1rem">Тайм лайн</div>

                                            </div>
                                            <?php
                                            }
                                            ?>
                                        </div>
                                    </div>

                                    <?php
                                }
                                ?>
                         </div>
                    </div>
                </div>

        </div>
    </div>

<script>
    function collaps(el){
        console.log(el.parentElement.parentElement.getElementsByClassName('content1'));
      //  el.parent().find('.content1').toggle(200); //скрытие, показ ответа
        if (el.parentElement.parentElement.classList.contains('open')) {
            el.parentElement.parentElement.classList.remove('open');
            let arrEl = [...el.parentElement.parentElement.getElementsByClassName('content1')];
            arrEl.forEach((item)=>item.style='display:none');
        } else {
            el.parentElement.parentElement.classList.add('open');
           //  el.parentElement.style='animation-timing-function: linear; cursor: pointer';
           let arrEl = [...el.parentElement.parentElement.getElementsByClassName('content1')];
            arrEl.forEach((item)=>item.style='display:flex; margin-left:2rem; margin-top: 1rem');
        };
    }
    //
    // $('.question').click(function() {
    //     $(this).find('.content1').toggle(200); //скрытие, показ ответа
    //     if ($(this).hasClass('open')) {
    //         $(this).removeClass('open');
    //     } else {
    //         $(this).addClass('open');
    //     };
    // });
</script>