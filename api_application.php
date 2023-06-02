<style>
    .hiddentab{
        display: none;
    }
</style>
<div class="content-wrapper">
            <div class="row" id="proBanner">
              <div class="col-12">
            <!--    -->
              </div>
            </div>
            <div class="d-xl-flex justify-content-between align-items-start">
              <h2 class="text-dark font-weight-bold mb-2"> Заявления </h2>
              <div class="d-sm-flex justify-content-xl-between align-items-center mb-2">

                <div class="dropdown ml-0 ml-md-4 mt-2 mt-lg-0">
                  <button class="btn bg-white  p-3 d-flex align-items-center" type="button" id="dropdownMenuButton1" onclick="showModal()"> Новое заявление </button>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12">
                <div class="d-sm-flex justify-content-between align-items-center transaparent-tab-border ">
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
<div class="modal" id="myModal">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Создание заявления</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal">x</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">




                <div class="col-md-12">
                    <div class="d-sm-flex justify-content-between align-items-center transaparent-tab-border ">
                        <ul class="nav nav-tabs tab-transparent" role="tablist">
                            <li class="nav-item" id="home-tab">
                                <a class="nav-link"  data-toggle="tab" href="#" role="tab" aria-selected="true">Общие сведения о заявителе</a>
                            </li>
                            <li class="nav-item hiddentab" id="khirurg-tab">
                                <a class="nav-link"  data-toggle="tab" href="#" role="tab" aria-selected="false">Хирургия</a>
                            </li>
                            <li class="nav-item hiddentab" id="rodovspom-tab">
                                <a class="nav-link"  data-toggle="tab" href="#" role="tab" aria-selected="false">Родовспоможение</a>
                            </li>
                            <li class="nav-item hiddentab" id="akush-tab">
                                <a class="nav-link"  data-toggle="tab" href="#" role="tab" aria-selected="false">Акушерство и гинекология</a>
                            </li>
                            <li class="nav-item hiddentab" id="anest-tab">
                                <a class="nav-link"  data-toggle="tab" href="#" role="tab" aria-selected="false">Анестезиология и реаниматология</a>
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
                                <div class="col-12 grid-margin">
                                    <div class="card">
                                        <div class="card-body">

                                            <label>Наименование заинтересованного лица</label><label class="form-control" type="text"></label>
                                            <label>Сокращенное наименование</label><label class="form-control" type="text"></label>
                                            <label>УНП</label><label class="form-control" type="text"></label>
                                            <label>Юридический адрес</label><label class="form-control" type="text"></label>
                                            <label for="formGroupExampleInput">Аккредитация по профилям заболеваний, состояниям, синдромам (отметить необходимые профили, далее заполнить таблицу самооценки во вкладках)</label>
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="defaultCheck1" onclick="toggleTabs(this,'khirurg-tab')">
                                                <label class="form-check-label" for="defaultCheck1">
                                                    Хирургия
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="defaultCheck2" onclick="toggleTabs(this,'rodovspom-tab')">
                                                <label class="form-check-label" for="defaultCheck2" >
                                                    Родовспоможение
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="defaultCheck3" onclick="toggleTabs(this,'akush-tab')">
                                                <label class="form-check-label" for="defaultCheck3">
                                                    Акушерство и гинекология
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="defaultCheck4" onclick="toggleTabs(this,'anest-tab')">
                                                <label class="form-check-label" for="defaultCheck4">
                                                    Анестезиология и реаниматология
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>





            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Закрыть</button>
            </div>

        </div>
    </div>
</div>

<script>
    function showModal(){

        let modal = document.getElementById("myModal");
        modal.classList.add("show");
        modal.style = "display: block";

        $(".btn-close").on("click",() => {
            modal.classList.remove("show");
            modal.style = "display: none";
        });
        $(".btn-danger").on("click",() => {
            modal.classList.remove("show");
            modal.style = "display: none";
        });
    }

    function toggleTabs(chkb,idelement){
        let tab = document.getElementById(idelement);
        if(chkb.checked === true) {
            tab.classList.remove("hiddentab");
        }
        else{
            tab.classList.add("hiddentab");
        }
    }
</script>