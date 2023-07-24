<div class="content-wrapper">
    <div class="row">
          <div class="col-xl-4 col-lg-6 col-sm-6 grid-margin stretch-card">
            <div class="card">
              <div class="card-body text-center">
<!--                <h5 class="mb-2 text-dark font-weight-normal">Всего заявлений</h5>-->
<!--                <h2 class="mb-4 text-dark font-weight-bold">-->
                  <?php
                    $rez = mysqli_query($con, "Select count(*) as countUsers from users where last_act is not null and id_role=3") or die("Ошибка " . mysqli_error($con));
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


                  <h4 class="card-title" style="margin-bottom: 0.3rem">Регистрация в личном кабинете</h4>
                  <canvas id="doughnutChart1" style="height: 250px;display: block;width: 299px;" width="350" height="200"></canvas>
                  <script>
                      let ll = <?= $countUsers ?>;
                      document.getElementById('doughnutChart1').setAttribute('attr1',ll);
                  </script>
              </div>
            </div>
          </div>
          <div class="col-xl-4 col-lg-6 col-sm-6 grid-margin stretch-card">
            <div class="card">
              <div class="card-body text-center">

<!--                <h5 class="mb-2 text-dark font-weight-normal">Unique Visitors</h5>-->
<!--                <h2 class="mb-4 text-dark font-weight-bold">-->

                   <?php
                    $rez = mysqli_query($con, "Select count(*) as countNewApp from applications where id_status = 1") or die("Ошибка " . mysqli_error($con));
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
<!--                  </h3>-->
                  <h4 class="card-title" style="margin-bottom: 0.3rem">Процесс проведения
                      медицинской аккредитации </h4>
                  <canvas id="doughnutChart2" style="height: 393px; display: block; width: 688px;" attr1="438"></canvas>

                  <script>
                      let countNewApp = <?= $countNewApp ?>;
                      let countSended = <?= $countSended ?>;
                      let countChecking = <?= $countChecking ?>;
                      let countOk = <?= $countOk ?>;

                      document.getElementById('doughnutChart2').setAttribute('attr1',countNewApp);
                      document.getElementById('doughnutChart2').setAttribute('attr2',countSended);
                      document.getElementById('doughnutChart2').setAttribute('attr3',countChecking);
                      document.getElementById('doughnutChart2').setAttribute('attr4',countOk);

                  </script>

              </div>
            </div>
          </div>
        <div class="col-xl-4 col-lg-6 col-sm-6 grid-margin stretch-card">
            <div class="card">
                <div class="card-body text-center">

                    <?php
                    $rez = mysqli_query($con, "                    SELECT (
                                      SELECT count(*)
                                      FROM applications a
                                      left outer join report_application_mark ram on a.id_application=ram.id_application
                                      where id_status = 4 and otmetka_accred_all<26) as count25,(
                                      select count(*)
                                      FROM applications a
                                      left outer join report_application_mark ram on a.id_application=ram.id_application
                                      where id_status = 4 and otmetka_accred_all>25 and otmetka_accred_all<51) as count50,(
                                      select count(*)
                                      FROM applications a
                                      left outer join report_application_mark ram on a.id_application=ram.id_application
                                      where id_status = 4 and otmetka_accred_all>50 and otmetka_accred_all<76) as count75,(
                                      select count(*)
                                      FROM applications a
                                      left outer join report_application_mark ram on a.id_application=ram.id_application
                                      where id_status = 4 and otmetka_accred_all>75) as count100,(
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
                    <h4 class="card-title" style="margin-bottom: 0.3rem">Результаты оценки соответствия первичным критериям медицинской аккредитации</h4>
                    <canvas id="doughnutChart3" style="height: 393px; display: block; width: 688px;"></canvas>

                    <script>
                        let count25 = <?= $count25 ?>;
                        let count50 = <?= $count50 ?>;
                        let count75 = <?= $count75 ?>;
                        let count100 = <?= $count100 ?>;

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


</div>
<script src="assets/js/chart.js"></script>