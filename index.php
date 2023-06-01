<?php require_once 'connection.php'; ?>
<?php include 'authorization/auth.php';?>
<?php include 'authorization/out.php';?>

<?php login();?>
<?php out(); ?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Connect Plus</title>
    <!-- plugins:css -->
    <link rel="stylesheet" href="assets/vendors/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="assets/vendors/flag-icon-css/css/flag-icon.min.css">
    <link rel="stylesheet" href="assets/vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <link rel="stylesheet" href="assets/vendors/font-awesome/css/font-awesome.min.css" />
    <link rel="stylesheet" href="assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css">
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <!-- endinject -->
    <!-- Layout styles -->
    <link rel="stylesheet" href="assets/css/style.css">
    <!-- End layout styles -->
    <link rel="shortcut icon" href="assets/images/favicon.png" />

    <link rel="stylesheet" href="dist/css/dataTables.bootstrap4.min.css">






  </head>
  <body>
    <div class="container-scroller">
      <!-- partial:partials/_navbar.html -->
      <nav class="navbar default-layout-navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
        <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
          <a class="navbar-brand brand-logo" href="index.html"><img src="assets/images/logo.svg" alt="logo" /></a>
          <a class="navbar-brand brand-logo-mini" href="index.html"><img src="assets/images/logo-mini.svg" alt="logo" /></a>
        </div>
        <div class="navbar-menu-wrapper d-flex align-items-stretch">
          <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
            <span class="mdi mdi-menu"></span>
          </button>
          <div class="search-field d-none d-xl-block">
            <form class="d-flex align-items-center h-100" action="#">
              <div class="input-group">
                <div class="input-group-prepend bg-transparent">
                  <i class="input-group-text border-0 mdi mdi-magnify"></i>
                </div>
                <input type="text" class="form-control bg-transparent border-0" placeholder="Search products">
              </div>
            </form>
          </div>
          <ul class="navbar-nav navbar-nav-right">
            <li class="nav-item  dropdown d-none d-md-block">
              <a class="nav-link dropdown-toggle" id="reportDropdown" href="#" data-toggle="dropdown" aria-expanded="false"> Reports </a>
              <div class="dropdown-menu navbar-dropdown" aria-labelledby="reportDropdown">
                <a class="dropdown-item" href="#">
                  <i class="mdi mdi-file-pdf mr-2"></i>PDF </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#">
                  <i class="mdi mdi-file-excel mr-2"></i>Excel </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#">
                  <i class="mdi mdi-file-word mr-2"></i>doc </a>
              </div>
            </li>
            <li class="nav-item  dropdown d-none d-md-block">
              <a class="nav-link dropdown-toggle" id="projectDropdown" href="#" data-toggle="dropdown" aria-expanded="false"> Projects </a>
              <div class="dropdown-menu navbar-dropdown" aria-labelledby="projectDropdown">
                <a class="dropdown-item" href="#">
                  <i class="mdi mdi-eye-outline mr-2"></i>View Project </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#">
                  <i class="mdi mdi-pencil-outline mr-2"></i>Edit Project </a>
              </div>
            </li>
            <li class="nav-item nav-language dropdown d-none d-md-block">
              <a class="nav-link dropdown-toggle" id="languageDropdown" href="#" data-toggle="dropdown" aria-expanded="false">
                <div class="nav-language-icon">
                  <i class="flag-icon flag-icon-us" title="us" id="us"></i>
                </div>
                <div class="nav-language-text">
                  <p class="mb-1 text-black">English</p>
                </div>
              </a>
              <div class="dropdown-menu navbar-dropdown" aria-labelledby="languageDropdown">
                <a class="dropdown-item" href="#">
                  <div class="nav-language-icon mr-2">
                    <i class="flag-icon flag-icon-ae" title="ae" id="ae"></i>
                  </div>
                  <div class="nav-language-text">
                    <p class="mb-1 text-black">Arabic</p>
                  </div>
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#">
                  <div class="nav-language-icon mr-2">
                    <i class="flag-icon flag-icon-gb" title="GB" id="gb"></i>
                  </div>
                  <div class="nav-language-text">
                    <p class="mb-1 text-black">English</p>
                  </div>
                </a>
              </div>
            </li>
            <li class="nav-item nav-profile dropdown">
              <a class="nav-link dropdown-toggle" id="profileDropdown" href="#" data-toggle="dropdown" aria-expanded="false">
                <div class="nav-profile-img">
                  <img src="assets/images/faces/face28.png" alt="image">
                </div>
                <div class="nav-profile-text">
                  <p class="mb-1 text-black"><?php if (!isset($_COOKIE['login']))
                          echo "Гость";
                      else
                          echo $_COOKIE['login']; ?></p>
                </div>
              </a>
              <div class="dropdown-menu navbar-dropdown dropdown-menu-right p-0 border-0 font-size-sm" aria-labelledby="profileDropdown" data-x-placement="bottom-end">
                <div class="p-3 text-center bg-primary">
                  <img class="img-avatar img-avatar48 img-avatar-thumb" src="assets/images/faces/face28.png" alt="">
                </div>
                <div class="p-2">
                  <h5 class="dropdown-header text-uppercase pl-2 text-dark">User Options</h5>
                  <a class="dropdown-item py-1 d-flex align-items-center justify-content-between" href="#">
                    <span>Inbox</span>
                    <span class="p-0">
                      <span class="badge badge-primary">3</span>
                      <i class="mdi mdi-email-open-outline ml-1"></i>
                    </span>
                  </a>
                  <a class="dropdown-item py-1 d-flex align-items-center justify-content-between" href="#">
                    <span>Profile</span>
                    <span class="p-0">
                      <span class="badge badge-success">1</span>
                      <i class="mdi mdi-account-outline ml-1"></i>
                    </span>
                  </a>
                  <a class="dropdown-item py-1 d-flex align-items-center justify-content-between" href="javascript:void(0)">
                    <span>Settings</span>
                    <i class="mdi mdi-settings"></i>
                  </a>
                  <div role="separator" class="dropdown-divider"></div>
                  <h5 class="dropdown-header text-uppercase  pl-2 text-dark mt-2">Actions</h5>
                    <?php
                    if (isset($_COOKIE['login'])) {?>
                    <a class="dropdown-item py-1 d-flex align-items-center justify-content-between" href="/index.php?logout">
                        <span>Выйти</span>
                        <i class="mdi mdi-logout ml-1"></i>
                    </a>
                    <?php } else {?>
                  <a class="dropdown-item py-1 d-flex align-items-center justify-content-between" href="/login.php">
                    <span>Войти</span>
                    <i class="mdi mdi-lock ml-1"></i>
                  </a>
                    <?php } ?>
                </div>
              </div>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link count-indicator dropdown-toggle" id="messageDropdown" href="#" data-toggle="dropdown" aria-expanded="false">
                <i class="mdi mdi-email-outline"></i>
                <span class="count-symbol bg-success"></span>
              </a>
              <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="messageDropdown">
                <h6 class="p-3 mb-0 bg-primary text-white py-4">Messages</h6>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item preview-item">
                  <div class="preview-thumbnail">
                    <img src="assets/images/faces/face4.jpg" alt="image" class="profile-pic">
                  </div>
                  <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                    <h6 class="preview-subject ellipsis mb-1 font-weight-normal">Mark send you a message</h6>
                    <p class="text-gray mb-0"> 1 Minutes ago </p>
                  </div>
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item preview-item">
                  <div class="preview-thumbnail">
                    <img src="assets/images/faces/face2.jpg" alt="image" class="profile-pic">
                  </div>
                  <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                    <h6 class="preview-subject ellipsis mb-1 font-weight-normal">Cregh send you a message</h6>
                    <p class="text-gray mb-0"> 15 Minutes ago </p>
                  </div>
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item preview-item">
                  <div class="preview-thumbnail">
                    <img src="assets/images/faces/face3.jpg" alt="image" class="profile-pic">
                  </div>
                  <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                    <h6 class="preview-subject ellipsis mb-1 font-weight-normal">Profile picture updated</h6>
                    <p class="text-gray mb-0"> 18 Minutes ago </p>
                  </div>
                </a>
                <div class="dropdown-divider"></div>
                <h6 class="p-3 mb-0 text-center">4 new messages</h6>
              </div>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link count-indicator dropdown-toggle" id="notificationDropdown" href="#" data-toggle="dropdown">
                <i class="mdi mdi-bell-outline"></i>
                <span class="count-symbol bg-danger"></span>
              </a>
              <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="notificationDropdown">
                <h6 class="p-3 mb-0 bg-primary text-white py-4">Notifications</h6>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item preview-item">
                  <div class="preview-thumbnail">
                    <div class="preview-icon bg-success">
                      <i class="mdi mdi-calendar"></i>
                    </div>
                  </div>
                  <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                    <h6 class="preview-subject font-weight-normal mb-1">Event today</h6>
                    <p class="text-gray ellipsis mb-0"> Just a reminder that you have an event today </p>
                  </div>
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item preview-item">
                  <div class="preview-thumbnail">
                    <div class="preview-icon bg-warning">
                      <i class="mdi mdi-settings"></i>
                    </div>
                  </div>
                  <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                    <h6 class="preview-subject font-weight-normal mb-1">Settings</h6>
                    <p class="text-gray ellipsis mb-0"> Update dashboard </p>
                  </div>
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item preview-item">
                  <div class="preview-thumbnail">
                    <div class="preview-icon bg-info">
                      <i class="mdi mdi-link-variant"></i>
                    </div>
                  </div>
                  <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                    <h6 class="preview-subject font-weight-normal mb-1">Launch Admin</h6>
                    <p class="text-gray ellipsis mb-0"> New admin wow! </p>
                  </div>
                </a>
                <div class="dropdown-divider"></div>
                <h6 class="p-3 mb-0 text-center">See all notifications</h6>
              </div>
            </li>
          </ul>
          <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
            <span class="mdi mdi-menu"></span>
          </button>
        </div>
      </nav>
      <!-- partial -->
      <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_sidebar.html -->
       <?php include 'elements/navmenu/navmenu.php';?>
        <!-- partial -->
        <div class="main-panel">
          <div class="content-wrapper">
            <div class="row" id="proBanner">
              <div class="col-12">
            <!--    -->
              </div>
            </div>
            <div class="d-xl-flex justify-content-between align-items-start">
              <h2 class="text-dark font-weight-bold mb-2"> Заявления </h2>
              <div class="d-sm-flex justify-content-xl-between align-items-center mb-2">
                <div class="btn-group bg-white p-3" role="group" aria-label="Basic example">
                  <button type="button" class="btn btn-link text-light py-0 border-right">7 Days</button>
                  <button type="button" class="btn btn-link text-dark py-0 border-right">1 Month</button>
                  <button type="button" class="btn btn-link text-light py-0">3 Month</button>
                </div>
                <div class="dropdown ml-0 ml-md-4 mt-2 mt-lg-0">
                  <button class="btn bg-white dropdown-toggle p-3 d-flex align-items-center" type="button" id="dropdownMenuButton1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="mdi mdi-calendar mr-1"></i>24 Mar 2019 - 24 Mar 2019 </button>
                  <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuButton1">
                    <h6 class="dropdown-header">Settings</h6>
                    <a class="dropdown-item" href="#">Action</a>
                    <a class="dropdown-item" href="#">Another action</a>
                    <a class="dropdown-item" href="#">Something else here</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">Separated link</a>
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12">
                <div class="d-sm-flex justify-content-between align-items-center transaparent-tab-border {">
                  <ul class="nav nav-tabs tab-transparent" role="tablist">
                    <li class="nav-item">
                          <a class="nav-link" id="home-tab" data-toggle="tab" href="#" role="tab" aria-selected="true">Все заявления</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link active" id="business-tab" data-toggle="tab" href="#business-1" role="tab" aria-selected="false">На рассмотрении</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" id="performance-tab" data-toggle="tab" href="#" role="tab" aria-selected="false">Одобренные</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" id="conversion-tab" data-toggle="tab" href="#" role="tab" aria-selected="false">Не одобренные</a>
                    </li>
                  </ul>
                  <div class="d-md-block d-none">
                    <a href="#" class="text-light p-1"><i class="mdi mdi-view-dashboard"></i></a>
                    <a href="#" class="text-light p-1"><i class="mdi mdi-dots-vertical"></i></a>
                  </div>
                </div>
                <div class="tab-content tab-transparent-content">
                  <div class="tab-pane fade show active" id="business-1" role="tabpanel" aria-labelledby="business-tab">
                    <div class="row">
                      <div class="col-xl-3 col-lg-6 col-sm-6 grid-margin stretch-card">
                        <div class="card">
                          <div class="card-body text-center">
                            <h5 class="mb-2 text-dark font-weight-normal">Orders</h5>
                            <h2 class="mb-4 text-dark font-weight-bold">932.00</h2>
                            <div class="dashboard-progress dashboard-progress-1 d-flex align-items-center justify-content-center item-parent"><i class="mdi mdi-lightbulb icon-md absolute-center text-dark"></i></div>
                            <p class="mt-4 mb-0">Completed</p>
                            <h3 class="mb-0 font-weight-bold mt-2 text-dark">5443</h3>
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
                    <div class="row">
                      <div class="col-12 grid-margin">
                        <div class="card">
                          <div class="card-body">


                              <table id="example" class="table table-striped table-bordered" style="width:100%">
                                  <thead>
                                  <tr>
                                      <th>Name</th>
                                      <th>Position</th>
                                      <th>Office</th>
                                      <th>Age</th>
                                      <th>Start date</th>
                                      <th>Salary</th>
                                  </tr>
                                  </thead>
                                  <tbody>
                                  <tr>
                                      <td>Tiger Nixon</td>
                                      <td>System Architect</td>
                                      <td>Edinburgh</td>
                                      <td>61</td>
                                      <td>2011-04-25</td>
                                      <td>$320,800</td>
                                  </tr>
                                  <tr>
                                      <td>Garrett Winters</td>
                                      <td>Accountant</td>
                                      <td>Tokyo</td>
                                      <td>63</td>
                                      <td>2011-07-25</td>
                                      <td>$170,750</td>
                                  </tr>
                                  <tr>
                                      <td>Ashton Cox</td>
                                      <td>Junior Technical Author</td>
                                      <td>San Francisco</td>
                                      <td>66</td>
                                      <td>2009-01-12</td>
                                      <td>$86,000</td>
                                  </tr>
                                  <tr>
                                      <td>Cedric Kelly</td>
                                      <td>Senior Javascript Developer</td>
                                      <td>Edinburgh</td>
                                      <td>22</td>
                                      <td>2012-03-29</td>
                                      <td>$433,060</td>
                                  </tr>
                                  <tr>
                                      <td>Airi Satou</td>
                                      <td>Accountant</td>
                                      <td>Tokyo</td>
                                      <td>33</td>
                                      <td>2008-11-28</td>
                                      <td>$162,700</td>
                                  </tr>
                                  <tr>
                                      <td>Brielle Williamson</td>
                                      <td>Integration Specialist</td>
                                      <td>New York</td>
                                      <td>61</td>
                                      <td>2012-12-02</td>
                                      <td>$372,000</td>
                                  </tr>
                                  <tr>
                                      <td>Herrod Chandler</td>
                                      <td>Sales Assistant</td>
                                      <td>San Francisco</td>
                                      <td>59</td>
                                      <td>2012-08-06</td>
                                      <td>$137,500</td>
                                  </tr>
                                  <tr>
                                      <td>Rhona Davidson</td>
                                      <td>Integration Specialist</td>
                                      <td>Tokyo</td>
                                      <td>55</td>
                                      <td>2010-10-14</td>
                                      <td>$327,900</td>
                                  </tr>
                                  <tr>
                                      <td>Colleen Hurst</td>
                                      <td>Javascript Developer</td>
                                      <td>San Francisco</td>
                                      <td>39</td>
                                      <td>2009-09-15</td>
                                      <td>$205,500</td>
                                  </tr>
                                  <tr>
                                      <td>Sonya Frost</td>
                                      <td>Software Engineer</td>
                                      <td>Edinburgh</td>
                                      <td>23</td>
                                      <td>2008-12-13</td>
                                      <td>$103,600</td>
                                  </tr>
                                  <tr>
                                      <td>Jena Gaines</td>
                                      <td>Office Manager</td>
                                      <td>London</td>
                                      <td>30</td>
                                      <td>2008-12-19</td>
                                      <td>$90,560</td>
                                  </tr>
                                  <tr>
                                      <td>Quinn Flynn</td>
                                      <td>Support Lead</td>
                                      <td>Edinburgh</td>
                                      <td>22</td>
                                      <td>2013-03-03</td>
                                      <td>$342,000</td>
                                  </tr>
                                  <tr>
                                      <td>Charde Marshall</td>
                                      <td>Regional Director</td>
                                      <td>San Francisco</td>
                                      <td>36</td>
                                      <td>2008-10-16</td>
                                      <td>$470,600</td>
                                  </tr>
                                  <tr>
                                      <td>Haley Kennedy</td>
                                      <td>Senior Marketing Designer</td>
                                      <td>London</td>
                                      <td>43</td>
                                      <td>2012-12-18</td>
                                      <td>$313,500</td>
                                  </tr>
                                  <tr>
                                      <td>Tatyana Fitzpatrick</td>
                                      <td>Regional Director</td>
                                      <td>London</td>
                                      <td>19</td>
                                      <td>2010-03-17</td>
                                      <td>$385,750</td>
                                  </tr>
                                  <tr>
                                      <td>Michael Silva</td>
                                      <td>Marketing Designer</td>
                                      <td>London</td>
                                      <td>66</td>
                                      <td>2012-11-27</td>
                                      <td>$198,500</td>
                                  </tr>
                                  <tr>
                                      <td>Paul Byrd</td>
                                      <td>Chief Financial Officer (CFO)</td>
                                      <td>New York</td>
                                      <td>64</td>
                                      <td>2010-06-09</td>
                                      <td>$725,000</td>
                                  </tr>
                                  <tr>
                                      <td>Gloria Little</td>
                                      <td>Systems Administrator</td>
                                      <td>New York</td>
                                      <td>59</td>
                                      <td>2009-04-10</td>
                                      <td>$237,500</td>
                                  </tr>
                                  <tr>
                                      <td>Bradley Greer</td>
                                      <td>Software Engineer</td>
                                      <td>London</td>
                                      <td>41</td>
                                      <td>2012-10-13</td>
                                      <td>$132,000</td>
                                  </tr>
                                  <tr>
                                      <td>Dai Rios</td>
                                      <td>Personnel Lead</td>
                                      <td>Edinburgh</td>
                                      <td>35</td>
                                      <td>2012-09-26</td>
                                      <td>$217,500</td>
                                  </tr>
                                  <tr>
                                      <td>Jenette Caldwell</td>
                                      <td>Development Lead</td>
                                      <td>New York</td>
                                      <td>30</td>
                                      <td>2011-09-03</td>
                                      <td>$345,000</td>
                                  </tr>
                                  <tr>
                                      <td>Yuri Berry</td>
                                      <td>Chief Marketing Officer (CMO)</td>
                                      <td>New York</td>
                                      <td>40</td>
                                      <td>2009-06-25</td>
                                      <td>$675,000</td>
                                  </tr>
                                  <tr>
                                      <td>Caesar Vance</td>
                                      <td>Pre-Sales Support</td>
                                      <td>New York</td>
                                      <td>21</td>
                                      <td>2011-12-12</td>
                                      <td>$106,450</td>
                                  </tr>
                                  <tr>
                                      <td>Doris Wilder</td>
                                      <td>Sales Assistant</td>
                                      <td>Sydney</td>
                                      <td>23</td>
                                      <td>2010-09-20</td>
                                      <td>$85,600</td>
                                  </tr>
                                  <tr>
                                      <td>Angelica Ramos</td>
                                      <td>Chief Executive Officer (CEO)</td>
                                      <td>London</td>
                                      <td>47</td>
                                      <td>2009-10-09</td>
                                      <td>$1,200,000</td>
                                  </tr>
                                  <tr>
                                      <td>Gavin Joyce</td>
                                      <td>Developer</td>
                                      <td>Edinburgh</td>
                                      <td>42</td>
                                      <td>2010-12-22</td>
                                      <td>$92,575</td>
                                  </tr>
                                  <tr>
                                      <td>Jennifer Chang</td>
                                      <td>Regional Director</td>
                                      <td>Singapore</td>
                                      <td>28</td>
                                      <td>2010-11-14</td>
                                      <td>$357,650</td>
                                  </tr>
                                  <tr>
                                      <td>Brenden Wagner</td>
                                      <td>Software Engineer</td>
                                      <td>San Francisco</td>
                                      <td>28</td>
                                      <td>2011-06-07</td>
                                      <td>$206,850</td>
                                  </tr>
                                  <tr>
                                      <td>Fiona Green</td>
                                      <td>Chief Operating Officer (COO)</td>
                                      <td>San Francisco</td>
                                      <td>48</td>
                                      <td>2010-03-11</td>
                                      <td>$850,000</td>
                                  </tr>
                                  <tr>
                                      <td>Shou Itou</td>
                                      <td>Regional Marketing</td>
                                      <td>Tokyo</td>
                                      <td>20</td>
                                      <td>2011-08-14</td>
                                      <td>$163,000</td>
                                  </tr>
                                  <tr>
                                      <td>Michelle House</td>
                                      <td>Integration Specialist</td>
                                      <td>Sydney</td>
                                      <td>37</td>
                                      <td>2011-06-02</td>
                                      <td>$95,400</td>
                                  </tr>
                                  <tr>
                                      <td>Suki Burks</td>
                                      <td>Developer</td>
                                      <td>London</td>
                                      <td>53</td>
                                      <td>2009-10-22</td>
                                      <td>$114,500</td>
                                  </tr>
                                  <tr>
                                      <td>Prescott Bartlett</td>
                                      <td>Technical Author</td>
                                      <td>London</td>
                                      <td>27</td>
                                      <td>2011-05-07</td>
                                      <td>$145,000</td>
                                  </tr>
                                  <tr>
                                      <td>Gavin Cortez</td>
                                      <td>Team Leader</td>
                                      <td>San Francisco</td>
                                      <td>22</td>
                                      <td>2008-10-26</td>
                                      <td>$235,500</td>
                                  </tr>
                                  <tr>
                                      <td>Martena Mccray</td>
                                      <td>Post-Sales support</td>
                                      <td>Edinburgh</td>
                                      <td>46</td>
                                      <td>2011-03-09</td>
                                      <td>$324,050</td>
                                  </tr>
                                  <tr>
                                      <td>Unity Butler</td>
                                      <td>Marketing Designer</td>
                                      <td>San Francisco</td>
                                      <td>47</td>
                                      <td>2009-12-09</td>
                                      <td>$85,675</td>
                                  </tr>
                                  <tr>
                                      <td>Howard Hatfield</td>
                                      <td>Office Manager</td>
                                      <td>San Francisco</td>
                                      <td>51</td>
                                      <td>2008-12-16</td>
                                      <td>$164,500</td>
                                  </tr>
                                  <tr>
                                      <td>Hope Fuentes</td>
                                      <td>Secretary</td>
                                      <td>San Francisco</td>
                                      <td>41</td>
                                      <td>2010-02-12</td>
                                      <td>$109,850</td>
                                  </tr>
                                  <tr>
                                      <td>Vivian Harrell</td>
                                      <td>Financial Controller</td>
                                      <td>San Francisco</td>
                                      <td>62</td>
                                      <td>2009-02-14</td>
                                      <td>$452,500</td>
                                  </tr>
                                  <tr>
                                      <td>Timothy Mooney</td>
                                      <td>Office Manager</td>
                                      <td>London</td>
                                      <td>37</td>
                                      <td>2008-12-11</td>
                                      <td>$136,200</td>
                                  </tr>
                                  <tr>
                                      <td>Jackson Bradshaw</td>
                                      <td>Director</td>
                                      <td>New York</td>
                                      <td>65</td>
                                      <td>2008-09-26</td>
                                      <td>$645,750</td>
                                  </tr>
                                  <tr>
                                      <td>Olivia Liang</td>
                                      <td>Support Engineer</td>
                                      <td>Singapore</td>
                                      <td>64</td>
                                      <td>2011-02-03</td>
                                      <td>$234,500</td>
                                  </tr>
                                  <tr>
                                      <td>Bruno Nash</td>
                                      <td>Software Engineer</td>
                                      <td>London</td>
                                      <td>38</td>
                                      <td>2011-05-03</td>
                                      <td>$163,500</td>
                                  </tr>
                                  <tr>
                                      <td>Sakura Yamamoto</td>
                                      <td>Support Engineer</td>
                                      <td>Tokyo</td>
                                      <td>37</td>
                                      <td>2009-08-19</td>
                                      <td>$139,575</td>
                                  </tr>
                                  <tr>
                                      <td>Thor Walton</td>
                                      <td>Developer</td>
                                      <td>New York</td>
                                      <td>61</td>
                                      <td>2013-08-11</td>
                                      <td>$98,540</td>
                                  </tr>
                                  <tr>
                                      <td>Finn Camacho</td>
                                      <td>Support Engineer</td>
                                      <td>San Francisco</td>
                                      <td>47</td>
                                      <td>2009-07-07</td>
                                      <td>$87,500</td>
                                  </tr>
                                  <tr>
                                      <td>Serge Baldwin</td>
                                      <td>Data Coordinator</td>
                                      <td>Singapore</td>
                                      <td>64</td>
                                      <td>2012-04-09</td>
                                      <td>$138,575</td>
                                  </tr>
                                  <tr>
                                      <td>Zenaida Frank</td>
                                      <td>Software Engineer</td>
                                      <td>New York</td>
                                      <td>63</td>
                                      <td>2010-01-04</td>
                                      <td>$125,250</td>
                                  </tr>
                                  <tr>
                                      <td>Zorita Serrano</td>
                                      <td>Software Engineer</td>
                                      <td>San Francisco</td>
                                      <td>56</td>
                                      <td>2012-06-01</td>
                                      <td>$115,000</td>
                                  </tr>
                                  <tr>
                                      <td>Jennifer Acosta</td>
                                      <td>Junior Javascript Developer</td>
                                      <td>Edinburgh</td>
                                      <td>43</td>
                                      <td>2013-02-01</td>
                                      <td>$75,650</td>
                                  </tr>
                                  <tr>
                                      <td>Cara Stevens</td>
                                      <td>Sales Assistant</td>
                                      <td>New York</td>
                                      <td>46</td>
                                      <td>2011-12-06</td>
                                      <td>$145,600</td>
                                  </tr>
                                  <tr>
                                      <td>Hermione Butler</td>
                                      <td>Regional Director</td>
                                      <td>London</td>
                                      <td>47</td>
                                      <td>2011-03-21</td>
                                      <td>$356,250</td>
                                  </tr>
                                  <tr>
                                      <td>Lael Greer</td>
                                      <td>Systems Administrator</td>
                                      <td>London</td>
                                      <td>21</td>
                                      <td>2009-02-27</td>
                                      <td>$103,500</td>
                                  </tr>
                                  <tr>
                                      <td>Jonas Alexander</td>
                                      <td>Developer</td>
                                      <td>San Francisco</td>
                                      <td>30</td>
                                      <td>2010-07-14</td>
                                      <td>$86,500</td>
                                  </tr>
                                  <tr>
                                      <td>Shad Decker</td>
                                      <td>Regional Director</td>
                                      <td>Edinburgh</td>
                                      <td>51</td>
                                      <td>2008-11-13</td>
                                      <td>$183,000</td>
                                  </tr>
                                  <tr>
                                      <td>Michael Bruce</td>
                                      <td>Javascript Developer</td>
                                      <td>Singapore</td>
                                      <td>29</td>
                                      <td>2011-06-27</td>
                                      <td>$183,000</td>
                                  </tr>
                                  <tr>
                                      <td>Donna Snider</td>
                                      <td>Customer Support</td>
                                      <td>New York</td>
                                      <td>27</td>
                                      <td>2011-01-25</td>
                                      <td>$112,000</td>
                                  </tr>
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
          <!-- content-wrapper ends -->
          <!-- partial:partials/_footer.html -->
          <footer class="footer">
            <div class="footer-inner-wraper">
              <div class="d-sm-flex justify-content-center justify-content-sm-between">
                <span class="text-muted d-block text-center text-sm-left d-sm-inline-block">Copyright © bootstrapdash.com 2020</span>
                <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center"> Free <a href="https://www.bootstrapdash.com/" target="_blank">Bootstrap dashboard templates</a> from Bootstrapdash.com</span>
              </div>
            </div>
          </footer>
          <!-- partial -->
        </div>
        <!-- main-panel ends -->
      </div>
      <!-- page-body-wrapper ends -->
    </div>
    <!-- container-scroller -->
    <!-- plugins:js -->
    <script src="assets/vendors/js/vendor.bundle.base.js"></script>
    <!-- endinject -->
    <!-- Plugin js for this page -->
    <script src="assets/vendors/chart.js/Chart.min.js"></script>
    <script src="assets/vendors/jquery-circle-progress/js/circle-progress.min.js"></script>
    <!-- End plugin js for this page -->
    <!-- inject:js -->
    <script src="assets/js/off-canvas.js"></script>
    <script src="assets/js/hoverable-collapse.js"></script>
    <script src="assets/js/misc.js"></script>
    <!-- endinject -->
    <!-- Custom js for this page -->
    <script src="assets/js/dashboard.js"></script>


    <script>

        $(document).ready(function () {
            $('#example').DataTable({
                scrollY: '500px',
                scrollCollapse: true,
                paging: false,
            });
        });


    </script>


    <script src="dist/js/jquery-3.5.1.js"></script>
    <script src="dist/js/jquery.dataTables.min.js"></script>



    <!-- End custom js for this page -->



  </body>
</html>