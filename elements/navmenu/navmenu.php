
<nav class="sidebar sidebar-offcanvas" id="sidebar">
          <ul class="nav">
            <li class="nav-item nav-category"></li>
            <li class="nav-item">
              <a class="nav-link" href="index.php">
                <span class="icon-bg"><i class="mdi mdi-cube menu-icon"></i></span>
                <span class="menu-title">Главная</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
                <span class="icon-bg"><i class="mdi mdi-crosshairs-gps menu-icon"></i></span>
                <span class="menu-title">Заявления</span>
                <i class="menu-arrow"></i>
              </a>

            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">
                <span class="icon-bg"><i class="mdi mdi-contacts menu-icon"></i></span>
                <span class="menu-title">Контакты</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">
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
                    if($row['id_role'] == 2){?>
                  <li class="nav-item">
                      <a class="nav-link" href="#">
                          <span class="icon-bg"><i class="mdi mdi-contacts menu-icon"></i></span>
                          <span class="menu-title">Пользователи</span>
                      </a>
                  </li>
                  <?php
                    }
                  }
              }
              ?>
          </ul>
        </nav>