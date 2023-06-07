<style>
    .hiddentab{
        display: none;
    }
    .margleft{
        padding-left: 20px;
    }
</style>

<style>
    .container {
        padding: 0rem 0rem;
    }

    h4 {
        margin: 2rem 0rem 1rem;
    }

    .table-image {
    td, th {
        vertical-align: middle;
    }
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
                            <li class="nav-item" id="home-tab" onclick="showTab1()">
                                <a class="nav-link"  data-toggle="tab" href="#" role="tab" aria-selected="true">Общие сведения о заявителе</a>
                            </li>
                            <li class="nav-item hiddentab" id="khirurg-tab" onclick="showTab2()">
                                <a class="nav-link"  data-toggle="tab" href="#" role="tab" aria-selected="false">Хирургия</a>
                            </li>
                            <li class="nav-item hiddentab" id="rodovspom-tab" onclick="showTab3()">
                                <a class="nav-link"  data-toggle="tab" href="#" role="tab" aria-selected="false">Родовспоможение</a>
                            </li>
                            <li class="nav-item hiddentab" id="akush-tab" onclick="showTab4()">
                                <a class="nav-link"  data-toggle="tab" href="#" role="tab" aria-selected="false">Акушерство и гинекология</a>
                            </li>
                            <li class="nav-item hiddentab" id="anest-tab" onclick="showTab5()">
                                <a class="nav-link"  data-toggle="tab" href="#" role="tab" aria-selected="false">Анестезиология и реаниматология</a>
                            </li>
                        </ul>
                        <div class="d-md-block d-none">
                            <a href="#" class="text-light p-1"><i class="mdi mdi-view-dashboard"></i></a>
                            <a href="#" class="text-light p-1"><i class="mdi mdi-dots-vertical"></i></a>
                        </div>
                    </div>
                    <div class="tab-content tab-transparent-content">
                        <div class="tab-pane fade show active" id="tab-1" role="tabpanel" aria-labelledby="business-tab" >

                            <div class="row">
                                <div class="col-12 grid-margin">
                                    <div class="card">
                                        <div class="card-body">

                                            <div class="form-group"> <label>Наименование заинтересованного лица</label><input  type="text" class="form-control"/></div>
                                            <div class="form-group"><label>Сокращенное наименование</label><input class="form-control" type="text"/></div>
                                            <div class="form-group"><label>УНП</label><input class="form-control" type="text" id="unp" onfocusout="onInputUnp()"/></div>
                                            <div class="form-group"><label>Юридический адрес</label><input class="form-control" type="text" id="adress" onfocusout="onInputAdress()"/></div>
                                            <div class="form-group"><label>Номер телефона</label><input class="form-control" type="text"/></div>
                                            <div class="form-group"><label>Электронная почта</label><input class="form-control" type="email" id="email" onfocusout="onInputEmail()"/></div>
                                            <div class="form-group"><label style="font-size: 18px">Инициатор административной процедуры</label></div>
                                            <div class="form-check margleft">
                                                <input class="form-check-input" type="radio" name="exampleRadios" id="rukovoditel" value="option1" onclick="deleteDoverennost()" checked>
                                                <label class="form-check-label" for="rukovoditel">
                                                    Руководитель заинтересованного лица
                                                </label>
                                            </div>
                                            <div class="form-check margleft">
                                                <input class="form-check-input" type="radio" name="exampleRadios" id="predstavitel" value="option2" onclick="showDoverennost(this)">
                                                <label class="form-check-label" for="predstavitel">
                                                    Представитель заинтересованного лица
                                                </label>
                                            </div>
                                            <br/>
                                            <form id="formDoverennost" method="post" class="hiddentab">
                                                <div class="form-group">
                                                    <label for="doverennost">Доверенность</label>
                                                    <input type="file" name="doverennost" class="form-control-file" id="doverennost">
                                                </div>
                                            </form>

                                            <div class="row">
                                                <div class="col">
                                                    <input type="text" class="form-control" placeholder="Имя">
                                                </div>
                                                <div class="col">
                                                    <input type="text" class="form-control" placeholder="Фамилия">
                                                </div>
                                                <div class="col">
                                                    <input type="text" class="form-control" placeholder="Отчество">
                                                </div>
                                            </div>

                                            <br/>
                                            <div class="form-group"> <label>Должность</label><input  type="text" class="form-control"/></div>

                                            <div class="form-group"> <label style="font-size: 18px">Обязательные документы</label></div>

                                            <form id="formCopyRaspisanie" method="POST" action="saveFiles.php">
                                                <div class="form-group">
                                                    <label for="copyRaspisanie">Копия штатного расписания</label>
                                                    <input type="text" class="form-control-file" name="Name" id="copyRaspisanie">
                                                </div>
                                                <input type="submit" name="submit" value="Нажми">
                                            </form>

                                            <form id="formInfoMedTecnics" >
                                                <div class="form-group">
                                                    <label for="infoMedTecnics">Информация об используемой медицинской технике с указанием ее наименования, количества, продолжительности эксплуатации и срока службы</label>
                                                    <input type="file" class="form-control-file" id="infoMedTecnics">
                                                </div>
                                            </form>

                                            <div class="form-group"><label for="formGroupExampleInput" style="font-size: 18px">Аккредитация по профилям заболеваний, состояниям, синдромам (отметить необходимые профили, далее заполнить таблицу самооценки во вкладках)</label>
                                            <div class="form-check margleft">
                                                <input class="form-check-input" type="checkbox" value="" id="defaultCheck1" onclick="toggleTabs(this,'khirurg-tab')">
                                                <label class="form-check-label" for="defaultCheck1">
                                                    Хирургия
                                                </label>
                                            </div>
                                            <div class="form-check margleft">
                                                <input class="form-check-input" type="checkbox" value="" id="defaultCheck2" onclick="toggleTabs(this,'rodovspom-tab')">
                                                <label class="form-check-label" for="defaultCheck2" >
                                                    Родовспоможение
                                                </label>
                                            </div>
                                            <div class="form-check margleft">
                                                <input class="form-check-input" type="checkbox" value="" id="defaultCheck3" onclick="toggleTabs(this,'akush-tab')">
                                                <label class="form-check-label" for="defaultCheck3">
                                                    Акушерство и гинекология
                                                </label>
                                            </div>
                                            <div class="form-check margleft">
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



                        <div class="tab-pane fade show " id="tab-2" role="tabpanel" aria-labelledby="business-tab" >

                            <div class="row">
                                <div class="col-12 grid-margin">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="container">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <table class="table table-bordered">
                                                            <thead>
                                                            <tr>
                                                                <th scope="col">№ п/п</th>
                                                                <th scope="col">Наименование критерия </th>
                                                                <th scope="col">Класс</th>
                                                                <th scope="col">Наименование ЛПА</th>
                                                                <th scope="col">Приложения</th>
                                                                <th scope="col">Соответствие критерию (выполнено / не выполнено)</th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <tr>
                                                                <th scope="row">1</th>
                                                                <td>Деятельность структурного подразделения организации здравоохранения (далее – структурное подразделение) осуществляется в соответствии с положением о структурном подразделении</td>
                                                                <td></td>
                                                                <td class = "lpa" contenteditable ></td>
                                                                <td class = "pril"><input type="file" name="filesPril_" id="pril1" multiple/><br/></td>
                                                                <td ></td>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">1</th>
                                                                <td>Деятельность структурного подразделения организации здравоохранения (далее – структурное подразделение) осуществляется в соответствии с положением о структурном подразделении</td>
                                                                <td></td>
                                                                <td class="lpa" contenteditable ></td>
                                                                <td class = "pril"><input type="file" multiple/><br/></td>
                                                                <td ></td>
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

                        <div class="tab-pane fade show " id="tab-3" role="tabpanel" aria-labelledby="business-tab" >
s
                            <div class="row">
                                <div class="col-12 grid-margin">
                                    <div class="card">
                                        <div class="card-body">
                                            3
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="tab-pane fade show " id="tab-4" role="tabpanel" aria-labelledby="business-tab" >

                            <div class="row">
                                <div class="col-12 grid-margin">
                                    <div class="card">
                                        <div class="card-body">
                                            4
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane fade show" id="tab-5" role="tabpanel" aria-labelledby="business-tab" >

                            <div class="row">
                                <div class="col-12 grid-margin">
                                    <div class="card">
                                        <div class="card-body">
                                            5
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
<!--                <form action="getFiles.php" method="post">-->
<!--                    <input type="text" name="count" id="count"/>-->
<!--                <p id="btnSuc" style="cursor: pointer">Загрузить данные</p>-->
                    <button type="submit" class="btn btn-success btn-fw" id="btnSuc">Success</button>
<!--                </form>-->
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Закрыть</button>
            </div>

        </div>
    </div>
</div>
<script>

    $(document).ready(function () {

        // var files;
        // $('#pril1').change(function(){
        //     files = this.files;
        // });

   $("#btnSuc").on("click", function () {

        var filesPril=document.getElementById("pril1"),
            xhr1=new XMLHttpRequest(),
            form1=new FormData();
        var upload_filePril=filesPril.files;
        let index = 0;
        for (let i=0; i<upload_filePril.length; i++){
            form1.append("filesPril_"+index,upload_filePril.item(i));
            index++;
        }
       form1.append("index", index);
       xhr1.open("post","saveFiles.php",true);
       xhr1.send(form1);


        let tds = document.getElementsByClassName('lpa');
        let pril = document.getElementsByClassName('pril');
        let i = 0;
        for (let item of pril){
            let files = item.getElementsByTagName('input')[0];
            for (let file of files.files){
                item.innerHTML += file.name+"<br/>";

            }
        }
        //
        var doverennost=document.getElementById("doverennost"),
            xhr=new XMLHttpRequest(),
            form=new FormData();
        var upload_file=doverennost.files[0];
        form.append("doverennost",upload_file);
        xhr.open("post","saveFiles.php",true);
        xhr.send(form);
    });
    });
</script>

<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src="dist/js/formApplication.js"></script>