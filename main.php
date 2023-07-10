<div class="content-wrapper">
    <div class="row">
          <div class="col-xl-3 col-lg-6 col-sm-6 grid-margin stretch-card">
            <div class="card">
              <div class="card-body text-center">
                <h5 class="mb-2 text-dark font-weight-normal">Всего заявлений</h5>
                <h2 class="mb-4 text-dark font-weight-bold"><?php
                    $rez = mysqli_query($con, "Select count(*) allApps from applications") or die("Ошибка " . mysqli_error($con));
                    if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                    {
                        $row = mysqli_fetch_assoc($rez);
                        echo $row['allApps'];
                    }?></h2>
                <div class="dashboard-progress dashboard-progress-1 d-flex align-items-center justify-content-center item-parent"><i class="mdi mdi-lightbulb icon-md absolute-center text-dark"></i></div>
                <p class="mt-4 mb-0">Проверенных</p>
                <h3 class="mb-0 font-weight-bold mt-2 text-dark">
                    <?php
                    $rez = mysqli_query($con, "Select count(*) allApps from applications where id_status in (4,5)") or die("Ошибка " . mysqli_error($con));
                    if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
                    {
                        $row = mysqli_fetch_assoc($rez);
                        echo $row['allApps'];
                    }?>
                </h3>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-6 col-sm-6 grid-margin stretch-card">
            <div class="card">
              <div class="card-body text-center">
                <h5 class="mb-2 text-dark font-weight-normal">Unique Visitors</h5>
                <h2 class="mb-4 text-dark font-weight-bold">756,00</h2>
                <div class="dashboard-progress dashboard-progress-2 d-flex align-items-center justify-content-center item-parent"><i class="mdi mdi-account-circle icon-md absolute-center text-dark"></i></div>
                <p class="mt-4 mb-0">Increased since yesterday</p>
                <h3 class="mb-0 font-weight-bold mt-2 text-dark">50%</h3>
              </div>
            </div>
          </div>
          <div class="col-xl-3  col-lg-6 col-sm-6 grid-margin stretch-card">
            <div class="card">
              <div class="card-body text-center">
                <h5 class="mb-2 text-dark font-weight-normal">Impressions</h5>
                <h2 class="mb-4 text-dark font-weight-bold">100,38</h2>
                <div class="dashboard-progress dashboard-progress-3 d-flex align-items-center justify-content-center item-parent"><i class="mdi mdi-eye icon-md absolute-center text-dark"></i></div>
                <p class="mt-4 mb-0">Increased since yesterday</p>
                <h3 class="mb-0 font-weight-bold mt-2 text-dark">35%</h3>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-6 col-sm-6 grid-margin stretch-card">
            <div class="card">
              <div class="card-body text-center">
                <h5 class="mb-2 text-dark font-weight-normal">Followers</h5>
                <h2 class="mb-4 text-dark font-weight-bold">4250k</h2>
                <div class="dashboard-progress dashboard-progress-4 d-flex align-items-center justify-content-center item-parent"><i class="mdi mdi-cube icon-md absolute-center text-dark"></i></div>
                <p class="mt-4 mb-0">Decreased since yesterday</p>
                <h3 class="mb-0 font-weight-bold mt-2 text-dark">25%</h3>
              </div>
            </div>
          </div>
    </div>


</div>