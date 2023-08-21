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

              if (isset($_SESSION['id_user'])) {

              //$query = "SELECT * FROM view_categ_user, category, users WHERE users.id_user = view_categ_user.id_user AND category.id_category = view_categ_user.id_categ AND users.id_user = '{$_SESSION['id_user']}'";
              $query = "SELECT id_role FROM users WHERE users.id_user = '{$_SESSION['id_user']}'";

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

            if (isset($_SESSION['id_user'])) {

            //$query = "SELECT * FROM view_categ_user, category, users WHERE users.id_user = view_categ_user.id_user AND category.id_category = view_categ_user.id_categ AND users.id_user = '{$_SESSION['id_user']}'";
            $query = "SELECT id_role FROM users WHERE users.id_user = '{$_SESSION['id_user']}'";

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
        default:
            nav1.className = "nav-item active";
            break;
    }
</script>