<link rel="stylesheet" href="modules/report/report_application_status/report_application_status.css">
<?php if(isset($_COOKIE['login'])){?>
    <div class="content-wrapper">

            <h2 class="text-dark font-weight-bold mb-2">Отчет по статусам заявлений организаций здравоохранения  </h2>
            <div class="row mb-2">
                <div class="col-sm-6 col-md-3 col-lg-3 mb-2" style="font-size: 1rem; line-height: 3rem;">
                        <span class="mr-2">Выберите область</span>
                        
                        <select id="oblast" class="form-select-my" onclick="disablePrint()">
                            <option value="0">Все</option>
                            <option value="4">Минздрав</option>
                            <option value="5">Минск</option>
                            <option value="6">Минская область</option>
                            <option value="7">Гомель</option>
                            <option value="8">Могилев</option>
                            <option value="9">Витебск</option>
                            <option value="10">Гродно</option>
                            <option value="11">Брест</option>          
                        </select>

                </div>

                <div class="col-sm-6 col-md-3 col-lg-3 mb-2" style="font-size: 1rem; line-height: 3rem;">
                        <span class="mr-2">Статус</span>
                        
                        <select id='status' class="form-select-my" onclick="disablePrint()">
                            <option value="0">Все</option>
                            <option value="1">Самооценка</option>
                            <option value="2">Новое</option>
                            <option value="3">На рассмотрении</option>
                            <option value="4">Завершена оценка</option>
                            <option value="5">На доработке</option>
                            <option value="6">Решение совета</option>
                            <option value="7">Окончательное решение совета</option>
                        </select>

                </div>

                <div class="col-sm-6 col-md-5 col-lg-5 mb-2">   

                        <div class="form-group mr-3" style="display: inline-flex;">
                            <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Дата подачи заявления с</label>
                            <input type="date" class="form-control"  style="font-size: 1rem;" id="dateAccept" onclick="disablePrint()">
                        </div>
                        
                        <div class="form-group" style="display: inline-flex;">
                            <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">по</label>
                            <input type="date" class="form-control" style="font-size: 1rem;" id="dateComplete" onclick="disablePrint()">
                        </div>
                    
                    
                </div>

            

                <div class="col-sm-6 col-md-5 col-lg-5 mb-2" style="font-size: 1rem; line-height: 3rem;">
                        <span class="mr-2">Тип организации</span>
                        
                        <select id="typeOrg" class="form-select-my" onclick="disablePrint()">
                            <option value="0">Все</option>  
                            <?php
                                $query = "SELECT id_type, type_name
                                            FROM spr_type_organization";
                                $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                    for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);

                                    foreach ($data as $app) {
                                    //  $id_otvetstvennogo = $app['id_otvetstvennogo'];

                            ?>
                                    <option value="<?= $app['id_type']?>"><?= $app['type_name']?></option>                                               
                            <?php }?>
                        </select>

                </div>

                <div class="col-sm-6 col-md-5 col-lg-5 mb-2" style="font-size: 1rem; line-height: 3rem;">

                        <div class="form-group mr-3" style="display: inline-flex;">
                            <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Отдельно по юр. лицам</label>
                            <input type="checkbox" class="form-control"  style="font-size: 1rem;" id="flag_yur_lica" onclick="disablePrint()">
                        </div>                   
                    
                </div>
                
            </div>
                        
            <div class="row">
                <div class="col-sm-6 col-md-3 col-lg-3 mb-2 mr-2" style="font-size: 1rem; line-height: 3rem;">
                    <button 
                        id="btnReport"
                        class="btn btn-success btn-fw"
                        onclick="preperaReport()"
                    >Построить отчет </button>

                    <button 
                        id="btnReportPrint"
                        class="btn btn-success btn-fw"
                        disabled
                        onclick="printReport()"
                    >Печатать отчета </button>
                </div>
                
            </div>

            <div id="reportRow" class="row">
                <div class=" m-3 " style="font-size: 1rem; line-height: 3rem;">
                    
                    <div id="divForTable" ></div>
                </div>
            </div>

    </div>



<script src="modules/report/report_application_status/report_application_status.js"></script>

<?php } else { ?>
    <div class="content-wrapper">
        <div class="row" id="proBanner">
            <div class="col-12">
                <!--    -->
            </div>
        </div>
        <div class="d-xl-flex justify-content-between align-items-start">
            <h2 class="text-dark font-weight-bold mb-2"> Требуется авторизация </h2>
        </div>
    </div>

<?php } ?>