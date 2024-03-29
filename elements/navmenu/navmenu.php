<nav class="sidebar sidebar-offcanvas" id="sidebar">
          <ul class="nav">
            <li class="nav-item nav-category"></li>
            <li class="nav-item" id="nav1" >
              <a class="nav-link" href="index.php" >
                <span class="icon-bg"><i class="mdi mdi-cube menu-icon"></i></span>
                <span class="menu-title">Главная</span>
              </a>
            </li>
              <?php

              if (isset($_COOKIE['id_user'])) {

              //$query = "SELECT * FROM view_categ_user, category, users WHERE users.id_user = view_categ_user.id_user AND category.id_category = view_categ_user.id_categ AND users.id_user = '{$_SESSION['id_user']}'";
              $query = "SELECT id_role FROM users WHERE users.id_user = '{$_COOKIE['id_user']}'";

              $result = mysqli_query($con, $query) or die (mysqli_error($con));

              if (mysqli_num_rows($result) == 1) //если получена одна строка
              {
              $row = mysqli_fetch_assoc($result);
              if($row['id_role'] == 3){?>
            <li class="nav-item" id="nav2">
              <a class="nav-link"  href="/index.php?application" >
                <span class="icon-bg"><i class="mdi mdi-crosshairs-gps menu-icon"></i></span>
                <span class="menu-title">Заявления</span>
              </a>
            </li>
                  <li class="nav-item" id="nav10">
                      <a class="nav-link"  href="/index.php?myusers" >
                          <span class="icon-bg"><i class="mdi mdi-crosshairs-gps menu-icon"></i></span>
                          <span class="menu-title">Пользователи</span>
                      </a>
                  </li>
                  <?php
              }
              else if( $row['id_role'] == 15){
                  ?>
                  <li class="nav-item" id="nav2">
                      <a class="nav-link"  href="/index.php?application" >
                          <span class="icon-bg"><i class="mdi mdi-crosshairs-gps menu-icon"></i></span>
                          <span class="menu-title">Заявления</span>
                      </a>
                  </li>
                      <?php
              }
              else if ($row['id_role'] == 12){
                  ?>
                  <li class="nav-item" id="nav8">
                      <a class="nav-link"  href="/index.php?application_support" >
                          <span class="icon-bg"><i class="mdi mdi-crosshairs-gps menu-icon"></i></span>
                          <span class="menu-title">Заявления</span>
                      </a>
                  </li>
              <?php
              }
              else if(($row['id_role'] < 3) || ($row['id_role'] > 3 && $row['id_role'] < 12))
              {
                  if($row['id_role'] == 2)
                  {
                  ?>
                      <li class="nav-item" id="nav7">
                          <a class="nav-link" href="/index.php?tasks_accred" >
                              <span class="icon-bg"><i class="mdi mdi-contacts menu-icon"></i></span>
                              <span class="menu-title">Задачи</span>
                          </a>
                      </li>

                      <li class="nav-item" id="nav77">
                          <a class="nav-link"  href="/index.php?naznachenie_vrachei" >
                              <span class="icon-bg"><i class="mdi mdi-account-plus menu-icon"></i></span>
                              <span class="menu-title">Врачи-эксперты</span>
                          </a>
                      </li>

                      <li class="nav-item" id="nav9">
                          <a class="nav-link collapsed" data-toggle="collapse" href="#ui-reports" aria-controls="ui-reports">
                              <span class="icon-bg"><i class="mdi fa-flag menu-icon"></i></span>
                              <span class="menu-title">Отчеты</span>
                          </a>
                          <div class="collapse" id="ui-reports">
                              <ul class="nav flex-column sub-menu">
                                  <li class="nav-item" style="height: 100%">
                                      <a href="/index.php?report_first" class="nav-link" style="padding: 0rem 0rem 0rem 2rem;">

                                          <p style="white-space: normal; line-height: 1">Структура организаций здравоохранения по результатам самооценки</p>
                                      </a>
                                  </li>
                                  <li class="nav-item" style="height: 100%">
                                      <a href="/index.php?report_analiz_samoocenka" class="nav-link" style="padding: 0rem 0rem 0rem 2rem;">

                                          <p style="white-space: normal; line-height: 1">Анализ результатов самооценки организаций здравоохранения</p>
                                      </a>
                                  </li>
                                  <li class="nav-item" style="height: 100%">
                                      <a href="/index.php?report_analiz_ocenka" class="nav-link" style="padding: 0rem 0rem 0rem 2rem;">

                                          <p style="white-space: normal; line-height: 1">Анализ результатов медицинской аккредитации</p>
                                      </a>
                                  </li>

                                  <li class="nav-item" style="height: 100%">
                                      <a href="/index.php?report_doctor_work" class="nav-link" style="padding: 0rem 0rem 0rem 2rem;">

                                          <p style="white-space: normal; line-height: 1">Нагрузка врачей-экспертов</p>
                                      </a>
                                  </li>

                                  <li class="nav-item" style="height: 100%">
                                      <a href="/index.php?report_application_status" class="nav-link" style="padding: 0rem 0rem 0rem 2rem;">

                                          <p style="white-space: normal; line-height: 1">Отчет по статусам заявлений организаций здравоохранения</p>
                                      </a>
                                  </li>

                                  <li class="nav-item" style="height: 100%">
                                    <a href="/index.php?report_date_schedule" class="nav-link" style="padding: 0rem 0rem 0rem 2rem;">

                                        <p style="white-space: normal; line-height: 1">Контроль сроков подачи заявлений по графику</p>
                                    </a>
                                  </li>
                              </ul>
                          </div>
                      </li>

                      <li class="nav-item" id="nav12">
                          <a class="nav-link" href="/index.php?journal_rkk" >
                              <span class="icon-bg"><i class="mdi mdi-contacts menu-icon"></i></span>
                              <span class="menu-title">Журнал РКК</span>
                          </a>
                      </li>
                      
                      <li class="nav-item" id="nav14">
                          <a class="nav-link" href="/index.php?schedule_uz" >
                              <span class="icon-bg"><i class="mdi mdi-contacts menu-icon"></i></span>
                              <span class="menu-title">График ОЗ</span>
                          </a>
                      </li>


                      

                      <?php
              }?>
              <li class="nav-item" id="nav5">
                  <a class="nav-link" href="/index.php?users" >
                      <span class="icon-bg"><i class="mdi mdi-contacts menu-icon"></i></span>
                      <span class="menu-title">Заявки</span>
                  </a>
              </li>
                  <?php
              }
              else if($row['id_role'] == 14){
                  ?>
                  <li class="nav-item" id="nav8">
                      <a class="nav-link"  href="/index.php?application_support" >
                          <span class="icon-bg"><i class="mdi mdi-crosshairs-gps menu-icon"></i></span>
                          <span class="menu-title">Заявления</span>
                      </a>
                  </li>
                  <li class="nav-item" id="nav1001">
                      <a class="nav-link"  href="/index.php?myusersGuzo" >
                          <span class="icon-bg"><i class="mdi mdi-crosshairs-gps menu-icon"></i></span>
                          <span class="menu-title">Пользователи</span>
                      </a>
                  </li>
                  <li class="nav-item" id="nav9">
                      <a class="nav-link collapsed" data-toggle="collapse" href="#ui-reports" aria-controls="ui-reports">
                          <span class="icon-bg"><i class="mdi fa-flag menu-icon"></i></span>
                          <span class="menu-title">Отчеты</span>
                      </a>
                      <div class="collapse" id="ui-reports">
                          <ul class="nav flex-column sub-menu">
                              <li class="nav-item" style="height: 100%">
                                  <a href="/index.php?report_first" class="nav-link" style="padding: 0rem 0rem 0rem 2rem;">

                                      <p style="white-space: normal; line-height: 1">Структура организаций здравоохранения по результатам самооценки</p>
                                  </a>
                              </li>
                              <li class="nav-item" style="height: 100%">
                                  <a href="/index.php?report_analiz_samoocenka" class="nav-link" style="padding: 0rem 0rem 0rem 2rem;">

                                      <p style="white-space: normal; line-height: 1">Анализ результатов самооценки организаций здравоохранения</p>
                                  </a>
                              </li>
                              <li class="nav-item" style="height: 100%">
                                  <a href="/index.php?report_analiz_ocenka" class="nav-link" style="padding: 0rem 0rem 0rem 2rem;">

                                      <p style="white-space: normal; line-height: 1">Анализ результатов медицинской аккредитации</p>
                                  </a>
                              </li>

                              <li class="nav-item" style="height: 100%">
                                  <a href="/index.php?report_application_status" class="nav-link" style="padding: 0rem 0rem 0rem 2rem;">

                                      <p style="white-space: normal; line-height: 1">Отчет по статусам заявлений организаций здравоохранения</p>
                                  </a>
                              </li>
                          </ul>
                      </div>
                  </li>
              <?php
              }
              }
              }
              ?>
            <li class="nav-item" id="nav3">
              <a class="nav-link" href="/index.php?contacts" >
                <span class="icon-bg"><i class="mdi mdi-contacts menu-icon"></i></span>
                <span class="menu-title">Контакты</span>
              </a>
            </li>



            <li class="nav-item" id="nav4">
              <a class="nav-link" href="/index.php?help" >
                <span class="icon-bg"><i class="mdi mdi-format-list-bulleted menu-icon"></i></span>
                <span class="menu-title">Помощь</span>
              </a>
            </li>


            <?php

            if (isset($_COOKIE['id_user'])) {

            //$query = "SELECT * FROM view_categ_user, category, users WHERE users.id_user = view_categ_user.id_user AND category.id_category = view_categ_user.id_categ AND users.id_user = '{$_SESSION['id_user']}'";
            $query = "SELECT id_role FROM users WHERE users.id_user = '{$_COOKIE['id_user']}'";

            $result = mysqli_query($con, $query) or die (mysqli_error($con));

            if (mysqli_num_rows($result) == 1) //если получена одна строка
            {
            $row = mysqli_fetch_assoc($result);
            if($row['id_role'] == 12){?>
            <li class="nav-item" id="nav6">
            <a class="nav-link"  href="/index.php?support" >
              <span class="icon-bg"><i class="mdi mdi-crosshairs-gps menu-icon"></i></span>
              <span class="menu-title">Тех поддержка</span>
            </a>
            </li>

                <li class="nav-item" id="nav11">
                    <a class="nav-link"  href="/index.php?usersAccred" >
                        <span class="icon-bg"><i class="mdi mdi-crosshairs-gps menu-icon"></i></span>
                        <span class="menu-title" >Пользователи <br>аккредитации</span>
                    </a>
                </li>

                <li class="nav-item" id="nav77">
                    <a class="nav-link"  href="/index.php?naznachenie_vrachei" >
                        <span class="icon-bg"><i class="mdi mdi-account-plus menu-icon"></i></span>
                        <span class="menu-title">Врачи-эксперты</span>
                    </a>
                </li>



                <?php
            }
           
            }
            }
            ?>

          </ul>
        </nav>

<script>
    const currentUrl = window.location;
    let url = currentUrl.pathname + currentUrl.search;
    let nav1 = document.getElementById("nav1");
    let nav2 = document.getElementById("nav2");
    let nav3 = document.getElementById("nav3");
    let nav4 = document.getElementById("nav4");
    let nav5 = document.getElementById("nav5");
    let nav6 = document.getElementById("nav6");
    let nav7 = document.getElementById("nav7");
    let nav77 = document.getElementById("nav77");
    let nav8 = document.getElementById("nav8");
    let nav9 = document.getElementById("nav9");
    let nav10 = document.getElementById("nav10");
    let nav1001 = document.getElementById("nav1001");
    let nav11 = document.getElementById("nav11");
    let nav12 = document.getElementById("nav12");

    let nav14 = document.getElementById("nav14");

    switch(url){
        case "/index.php":
            nav1.className = "nav-item active";
            break;
        case "/index.php?application":
            nav2.className = "nav-item active";
            break;
        case "/index.php?users":
            nav5.className = "nav-item active";
            break;
        case "/index.php?help":
            nav4.className = "nav-item active";
            break;
        case "/index.php?contacts":
            nav3.className = "nav-item active";
            break;
        case "/index.php?support":
            nav6.className = "nav-item active";
            break;
        case "/index.php?tasks_accred":
            nav7.className = "nav-item active";
            break;
        case "/index.php?naznachenie_vrachei":
            nav77.className = "nav-item active";
            break;
        case "/index.php?application_support":
            nav8.className = "nav-item active";
            break;
        case "/index.php?report_first":
            nav9.className = "nav-item active";
            break;
        case "/index.php?myusers":
            nav10.className = "nav-item active";
            break;
        case "/index.php?myusersGuzo":
            nav1001.className = "nav-item active";
            break;
        case "/index.php?usersAccred":
            nav11.className = "nav-item active";
            break;
        case "/index.php?journal_rkk":
            nav12.className = "nav-item active";
            break;
        case "/index.php?schedule_uz":
            nav14.className = "nav-item active";
            break;
        default:
            nav1.className = "nav-item active";
            break;
    }
</script>