<style>
    .row {
        display: -webkit-box;
        display: -ms-flexbox;
        display: flex;
        -ms-flex-wrap: wrap;
        flex-wrap: wrap;
        margin-right: -9px;
        margin-left: -9px;
        justify-content: start;
    }
    .item {
        display: block;
        background: #fff;
        height: 100%;
        padding: 0;
        overflow: hidden;
        position: relative;
        transition: background-color .3s ease;
        /* margin: 0 auto 30px; */
    }
    .wrapper {
        padding-bottom: 30px;
    }
    .item .preview {
        display: block;
        padding-bottom: 75%;
        background-size: cover;
        /* background-position: 50% 50%; */
        background-repeat: no-repeat;
        transform-origin: 50% 100%;
        transition: transform .7s ease .1s;
    }
    .item a {
        color: #444444;
        transition: none;
        font-size: 16px;
    }
    @media screen and (min-width: 1200px)
        .item .content {
            padding: 20px 15px 30px;
        }

        .item .content {
            padding: 15px 15px 40px;
            line-height: 1.1em;
            color: #151515;
            position: relative;
            z-index: 10;
            height:100%;
        }

        .item h3 {
            margin: 0 0 15px;
            font-size: 1.1em;
            height: 90%;
        }
        .item .anno {
            font-size: 0.86em;
            margin-bottom: 15px;
            color: #aaa;
        }

        .section_title {
            font-size: 1.3em;
            text-align: center;
            margin: 0 auto 30px;
            font-weight: bold;
        }
        .item .date {
            color: #444444;
            font-size: 15px;
            display: inline-block;
            margin-right: 20px;
            vertical-align: middle;
            font-weight: 500;
            line-height: 2.5rem;damir
            position: absolute;
            bottom: 0;
        }
        /*.row-eq-height {*/
        /*    display: -webkit-box;*/
        /*    display: -webkit-flex;*/
        /*    display: -ms-flexbox;*/
        /*    display: flex;*/
        /*    flex-wrap: wrap;*/
        /*}*/

        .modal {
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
        .modal-body {
            max-height: 480px;
            width: 640px;
            overflow-y: auto;
        }
        .show {
            display: block;
        }
        .hiddentab {
            display: none;
        }

</style>

<div class="content-wrapper">

    <div class="row">
        <div class="col-xl-3 col-lg-6 col-sm-6 grid-margin stretch-card">
            <div class="card">
                <div class="card-body text-center" style="padding: 1.5rem 1.5rem;">
                    <!--                <h5 class="mb-2 text-dark font-weight-normal">Всего заявлений</h5>-->
                    <!--                <h2 class="mb-4 text-dark font-weight-bold">-->
                    <?php
                    $rez = mysqli_query($con, "Select count(*) as countUsers from users where last_time_online >= '2024-01-29'  and id_role=3 and active = 1") or die("Ошибка " . mysqli_error($con));
                    if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                    {
                        $row = mysqli_fetch_assoc($rez);

                    }
                    $countUsers = $row['countUsers'];
                    ?>


                    <!--                  </h2>-->
                    <!--                <div class="dashboard-progress dashboard-progress-1-dark d-flex align-items-center justify-content-center item-parent"><i class="mdi mdi-lightbulb icon-md absolute-center text-dark"></i></div>-->
                    <!--                <p class="mt-4 mb-0">Проверенных</p>-->
                    <!--                <h3 class="mb-0 font-weight-bold mt-2 text-dark">-->
                    <!--                    -->


                    <h4 class="card-title" style="margin-bottom: 0.3rem">Авторизация в личном кабинете</h4>
                    <canvas id="doughnutChart1" style="height: 250px;display: block;width: 299px;" width="350" height="200"></canvas>
                    <script>
                        let ll = <?= $countUsers ?>;
                        document.getElementById('doughnutChart1').setAttribute('attr1',ll);
                    </script>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-lg-6 col-sm-6 grid-margin stretch-card">
            <div class="card">
                <div class="card-body text-center" style="padding: 1.5rem 1.5rem;">

                    <!--                <h5 class="mb-2 text-dark font-weight-normal">Unique Visitors</h5>-->
                    <!--                <h2 class="mb-4 text-dark font-weight-bold">-->

                    <?php
                    $rez = mysqli_query($con, "Select count(*) as countNewApp from applications left outer join `users` on `users`.id_user = applications.id_user where id_status = 1 and `users`.id_role = 3") or die("Ошибка " . mysqli_error($con));
                    if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                    {
                        $row = mysqli_fetch_assoc($rez);

                    }
                    $countNewApp = $row['countNewApp'];
                    ?>

                    <?php
                    $rez = mysqli_query($con, "Select count(*) as countSended from applications where id_status = 2") or die("Ошибка " . mysqli_error($con));
                    if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                    {
                        $row = mysqli_fetch_assoc($rez);

                    }
                    $countSended = $row['countSended'];
                    ?>


                    <?php
                    $rez = mysqli_query($con, "Select count(*) as countChecking from applications where id_status = 3") or die("Ошибка " . mysqli_error($con));
                    if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                    {
                        $row = mysqli_fetch_assoc($rez);

                    }
                    $countChecking = $row['countChecking'];
                    ?>

                    <?php
                    $rez = mysqli_query($con, "Select count(*) as countOk from applications where id_status = 4") or die("Ошибка " . mysqli_error($con));
                    if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                    {
                        $row = mysqli_fetch_assoc($rez);

                    }
                    $countOk = $row['countOk'];
                    ?>
                    <?php
                    $rez = mysqli_query($con, "Select count(*) as countResh from applications where id_status = 6") or die("Ошибка " . mysqli_error($con));
                    if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                    {
                        $row = mysqli_fetch_assoc($rez);

                    }
                    $countResh = $row['countResh'];
                    ?>
                    <!--                  </h3>-->
                    <h4 class="card-title" style="margin-bottom: 0.3rem">Процесс проведения
                        медицинской аккредитации </h4>
                    <canvas id="doughnutChart2" style="height: 393px; display: block; width: 688px;" attr1="463"></canvas>

                    <script>
                        let countNewApp = <?= $countNewApp ?>;
                        let countSended = <?= $countSended ?>;
                        let countChecking = <?= $countChecking ?>;
                        let countOk = <?= $countOk ?>;
                        let countResh = <?= $countResh ?>;

                        document.getElementById('doughnutChart2').setAttribute('attr1',countNewApp);
                        document.getElementById('doughnutChart2').setAttribute('attr2',countSended);
                        document.getElementById('doughnutChart2').setAttribute('attr3',countChecking);
                        document.getElementById('doughnutChart2').setAttribute('attr4',countOk);
                        document.getElementById('doughnutChart2').setAttribute('attr5',countResh);

                    </script>

                </div>
            </div>
        </div>
        <div class="col-xl-3 col-lg-6 col-sm-6 grid-margin stretch-card">
            <div class="card">
                <div class="card-body text-center" style="padding: 1.5rem 1.5rem;">

                    <?php
                    $rez = mysqli_query($con, "                    SELECT (
                                      SELECT count(*)
                                      FROM applications where id_status > 1 and year(date_create_app)=2024 and  mark_percent<50) as count25,(
                                      select count(*)
                                      FROM applications where id_status > 1 and year(date_create_app)=2024 and  mark_percent>49 and mark_percent<70) as count50,(
                                      select count(*)
                                      FROM applications where id_status > 1 and year(date_create_app)=2024 and  mark_percent>69 and mark_percent<90) as count75,(
                                      select count(*)
                                      FROM applications where id_status > 1 and year(date_create_app)=2024 and  mark_percent>89) as count100,(
                                      select count(*)
                                      FROM applications where id_status  > 1 and year(date_create_app)=2024) as countStatus4") or die("Ошибка " . mysqli_error($con));
                    if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                    {
                        $row = mysqli_fetch_assoc($rez);

                    }
                    $count25 = $row['count25'];
                    $count50 = $row['count50'];
                    $count75 = $row['count75'];
                    $count100 = $row['count100'];
                    ?>
                    <!--                  </h3>-->
                    <h4 class="card-title" style="margin-bottom: 0.3rem">Результаты самоаккредитации организаций здравоохранения</h4>
                    <canvas id="doughnutChart4" style="height: 393px; display: block; width: 688px;"></canvas>

                    <script>
                        let count25 = <?= $count25 ?>;
                        let count50 = <?= $count50 ?>;
                        let count75 = <?= $count75 ?>;
                        let count100 = <?= $count100 ?>;

                        document.getElementById('doughnutChart4').setAttribute('attr1',count25);
                        document.getElementById('doughnutChart4').setAttribute('attr2',count50);
                        document.getElementById('doughnutChart4').setAttribute('attr3',count75);
                        document.getElementById('doughnutChart4').setAttribute('attr4',count100);


                    </script>

                    <!--                  --><?php
                    //                  $rez = mysqli_query($con, "Select count(*) as countOk from applications where id_status = 4") or die("Ошибка " . mysqli_error($con));
                    //                  if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                    //                  {
                    //                      $row = mysqli_fetch_assoc($rez);
                    //
                    //                  }
                    //                  $countOk = $row['countOk'];
                    //                  ?>



                </div>
            </div>
        </div>
        <div class="col-xl-3 col-lg-6 col-sm-6 grid-margin stretch-card">
            <div class="card">
                <div class="card-body text-center" style="padding: 1.5rem 1.5rem;">

                    <?php
                    $rez = mysqli_query($con, "                    SELECT (
                                      SELECT count(*)
                                      FROM applications a
                                      left outer join report_application_mark ram on a.id_application=ram.id_application
                                      where id_status = 4 and otmetka_accred_all<50) as count25,(
                                      select count(*)
                                      FROM applications a
                                      left outer join report_application_mark ram on a.id_application=ram.id_application
                                      where id_status = 4 and otmetka_accred_all>49 and otmetka_accred_all<70) as count50,(
                                      select count(*)
                                      FROM applications a
                                      left outer join report_application_mark ram on a.id_application=ram.id_application
                                      where id_status = 4 and otmetka_accred_all>69 and otmetka_accred_all<90) as count75,(
                                      select count(*)
                                      FROM applications a
                                      left outer join report_application_mark ram on a.id_application=ram.id_application
                                      where id_status = 4 and otmetka_accred_all>89) as count100,(
                                      select count(*)
                                      FROM applications a
                                      left outer join report_application_mark ram on a.id_application=ram.id_application
                                      where id_status = 4) as countStatus4") or die("Ошибка " . mysqli_error($con));
                    if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                    {
                        $row = mysqli_fetch_assoc($rez);

                    }
                    $count25 = $row['count25'];
                    $count50 = $row['count50'];
                    $count75 = $row['count75'];
                    $count100 = $row['count100'];
                    ?>
                    <!--                  </h3>-->
                    <h4 class="card-title" style="margin-bottom: 0.3rem">Результаты оценки соответствия критериям</h4>
                    <canvas id="doughnutChart3" style="height: 393px; display: block; width: 688px;"></canvas>

                    <script>
                        count25 = <?= $count25 ?>;
                        count50 = <?= $count50 ?>;
                        count75 = <?= $count75 ?>;
                        count100 = <?= $count100 ?>;

                        document.getElementById('doughnutChart3').setAttribute('attr1',count25);
                        document.getElementById('doughnutChart3').setAttribute('attr2',count50);
                        document.getElementById('doughnutChart3').setAttribute('attr3',count75);
                        document.getElementById('doughnutChart3').setAttribute('attr4',count100);


                    </script>

                    <!--                  --><?php
                    //                  $rez = mysqli_query($con, "Select count(*) as countOk from applications where id_status = 4") or die("Ошибка " . mysqli_error($con));
                    //                  if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                    //                  {
                    //                      $row = mysqli_fetch_assoc($rez);
                    //
                    //                  }
                    //                  $countOk = $row['countOk'];
                    //                  ?>



                </div>
            </div>
        </div>


        <!--          <div class="col-xl-3  col-lg-6 col-sm-6 grid-margin stretch-card">-->
        <!--            <div class="card">-->
        <!--              <div class="card-body text-center">-->
        <!--                <h5 class="mb-2 text-dark font-weight-normal">Impressions</h5>-->
        <!--                <h2 class="mb-4 text-dark font-weight-bold">100,38</h2>-->
        <!--                <div class="dashboard-progress dashboard-progress-3 d-flex align-items-center justify-content-center item-parent"><i class="mdi mdi-eye icon-md absolute-center text-dark"></i></div>-->
        <!--                <p class="mt-4 mb-0">Increased since yesterday</p>-->
        <!--                <h3 class="mb-0 font-weight-bold mt-2 text-dark">35%</h3>-->
        <!--              </div>-->
        <!--            </div>-->
        <!--          </div>-->

        <!--          <div class="col-xl-0 col-lg-6 col-sm-6 grid-margin stretch-card">-->
        <!--            <div class="card">-->
        <!--              <div class="card-body text-center">-->
        <!--                <h5 class="mb-2 text-dark font-weight-normal">Followers</h5>-->
        <!--                <h2 class="mb-4 text-dark font-weight-bold">4250k</h2>-->
        <!--                <div class="dashboard-progress dashboard-progress-4 d-flex align-items-center justify-content-center item-parent"><i class="mdi mdi-cube icon-md absolute-center text-dark"></i></div>-->
        <!--                <p class="mt-4 mb-0">Decreased since yesterday</p>-->
        <!--                <h3 class="mb-0 font-weight-bold mt-2 text-dark">25%</h3>-->
        <!--              </div>-->
        <!--            </div>-->
        <!--          </div>-->
    </div>
    <div class="section_title">НОВОСТИ  <?php
                                        if (isset($_COOKIE['login'])) {

                                        $login = $_COOKIE['login'];
                                        $query = "SELECT * FROM users where login = '$login'";

                                        $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
                                        if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                                        {
                                            $row = mysqli_fetch_assoc($rez);
                                            $role = $row['id_role'];
                                        }
                                        if ( $role==12 ){?> <button class="btn btn-primary"  style =" position: absolute; right: 3%;" onclick="addNews()">Добавить новость</button> <?php }} ?></div>

    <div class="row">

        <?php
        $query = "SELECT *
FROM news
ORDER BY id_news DESC
";
        $result=mysqli_query($con, $query) or die ( mysqli_error($con));
        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
        $i = 0;
        foreach ($data as $app) {
        if($i == 0){
        ?>
        <div class="col-xs-12 col-md-5" ><div class="item first">
                <!--                <a href="#" class="preview" style="background-image: url('-->
                <!--                 $app["path_img"] -->
                <!--                        ');"></a>-->
                <div class="content">
                    <h3><a href="<?= $app["id_news"] == 30 ? 'https://www.youtube.com/watch?v=BNPDFogkO8k' : '#'?>"><?= $app["name_news"] ?></a></h3>
                    <div class="anno"></div>
                    <div class="date"><?= $app["date_news"] ?></div>
                    <!--                    <a href="#" class="read_more">Подробнее</a>-->
                </div>

            </div>

        </div>
        <div class="col-xs-12 col-md-12" style="margin-top: 1.5rem">
            <div class="row">
                <?php
                }
                else if($i > 0 && $i < 5){?>
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 wrapper">
                        <div class="item">
                            <!--                        <a href="#" class="preview" style="background-image: url('-->
                            <!-- $app["path_img"] -->
                            <!--                                ');"></a>-->
                            <div class="content">
                                <h3><a href="<?= $app["id_news"] == 30 ? 'https://www.youtube.com/watch?v=BNPDFogkO8k' : '#'?>"><?= $app["name_news"] ?></a></h3>
                                <div class="date"><?= $app["date_news"] ?></div>
                                <!--                            <a href="#" class="read_more">Подробнее</a>-->
                            </div>
                        </div>
                    </div>

                <?php }
                else{
                    ?>
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 wrapper morenews hiddentab">
                        <div class="item">
                            <!--                        <a href="#" class="preview" style="background-image: url('-->
                            <!-- $app["path_img"] -->
                            <!--                                ');"></a>-->
                            <div class="content">
                                <h3><a href="<?= $app["id_news"] == 30 ? 'https://www.youtube.com/watch?v=BNPDFogkO8k' : '#'?>"><?= $app["name_news"] ?></a></h3>
                                <div class="date"><?= $app["date_news"] ?></div>
                                <!--                            <a href="#" class="read_more">Подробнее</a>-->
                            </div>
                        </div>
                    </div>
                <?php
                }
                $i++;
                }

                ?>
            </div>
            <button class="btn btn-primary" onclick="showMore(this)">
                Все новости
            </button>
        </div>

        <div class="clearfix sm-visible"></div>

    </div>
</div>



<div class="modal" id="modalnews">
    <div class="modal-dialog modal-lg" >
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Добавление новости</h4><h4 class="modal-title hiddentab" id="id_news"></h4>
                <button type="button" class="btn  btn-danger btn-close" data-bs-dismiss="modal">x</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">

                <label for="newsContent">Текст новости:</label>
                <textarea class="form-control" id="newsContent" rows="3"></textarea>

                <label for="newsDate">Дата:</label>
                <input type="date" class="form-control" id="newsDate">


            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="saveNews()">Сохранить</button>
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Закрыть</button>
            </div>

        </div>
    </div>
</div>


<script>
    let toggleNews = false;
    function showMore(el){
        let morenews = document.getElementsByClassName("morenews");
        if(!toggleNews) {
            [...morenews].map(item => {
                item.classList.remove("hiddentab");
                toggleNews = true;
                el.innerText = "Скрыть все новости";
            })
        }
        else{
            [...morenews].map(item => {
                item.classList.add("hiddentab");
                toggleNews = false;
                el.innerText = "Все новости";

            })
        }
    }

function addNews(){
let modal = document.getElementById("modalnews");
modal.classList.add("show");

$(".btn-close").on("click",() => {

modal.classList.remove("show");


});
$(".btn-danger").on("click",() => {

modal.classList.remove("show");

});
}

function saveNews() {
    let newsContent = document.getElementById("newsContent").value;
    let newsDate = document.getElementById("newsDate").value;

    $.ajax({
        url:"ajax/createNews.php",
        method:"POST",
        data:{newsContent: newsContent , newsDate:newsDate}

    }).done(function (response){

        console.log('news' + response);
        alert("Добавленa новость");

    });

    let modal = document.getElementById("modalnews");
    modal.classList.remove("show");
}
</script>





<script src="assets/js/chart.js"></script>