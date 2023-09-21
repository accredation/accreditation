<link rel="stylesheet" href="modules/report/report_analiz_ocenka/report_analiz_ocenka.css">
<?php if(isset($_COOKIE['login'])){?>
    <div class="content-wrapper">

            <h2 class="text-dark font-weight-bold mb-2">Анализ результатов медицинской аккредитации  </h2>
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
                        <span class="mr-2">Таблицы критериев</span>
                        <select id="criteriaAll" class="form-select-my" onclick="chengeAllCrit(this.value)">
                            <option value="0">Все критерии</option>
                            <option value="1">Выборочно по таблицам критериев</option>    
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
                <div class="col-sm-6 col-md-3 col-lg-3 mb-2 mr-4" style="font-size: 1rem; line-height: 3rem;"  id="divCrit1" hidden>
                        <div class=""  >Общие  критериев</div>
                        <div  style="max-height: 300px; overflow: auto; " >
                                <?php
                                    $query = "SELECT id_criteria, CONCAT(c.name, IFNUll(CONCAT(' (', con.conditions,')'),'') ) as name_criteria
                                                FROM criteria c
                                                left outer join conditions con on c.conditions_id=con.conditions_id
                                                where c.type_criteria=1
                                                order by c.name
                                                ";
                                    $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);

                                        foreach ($data as $app) {
                                                                                
                                ?>
                                         <div class="d-flex mb-2" id="<?= $app['id_criteria']?>" >
                                            
                                            <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                                    type="checkbox" 
                                                    id="checkbox_criteria_<?= $app['id_criteria']?>" 
                                                    onclick="CheckCriteria(`checkBox`,'<?= $app['id_criteria']?>' )"
                                            />
                                            <span style="line-height: normal; cursor: pointer;"
                                            id="span_criteria_<?= $app['id_criteria']?>"
                                            onclick="CheckCriteria(`span`,'<?= $app['id_criteria']?>')"
                                            ><?= $app['name_criteria']?></span>
                                        </div>
                                             
                                <?php }?>
                        </div>

                </div>

                <div class="col-sm-6 col-md-3 col-lg-3 mb-2 mr-4" style="font-size: 1rem; line-height: 3rem;" id="divCrit2" hidden='true'>
                        
                        <div class="mr-2" >Профильные  критериев</div>
                        <div  style="max-height: 300px; overflow: auto" >
                                <?php
                                    $query = "SELECT id_criteria, CONCAT(c.name, IFNUll(CONCAT(' (', con.conditions,')'),'') ) as name_criteria
                                                FROM criteria c
                                                left outer join conditions con on c.conditions_id=con.conditions_id
                                                where c.type_criteria=2
                                                order by c.name
                                                ";
                                    $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);

                                        foreach ($data as $app) {
                                        //  $id_otvetstvennogo = $app['id_otvetstvennogo'];

                                ?>
                                         <div class="d-flex mb-2" id="<?= $app['id_criteria']?>" >
                                            
                                            <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                                    type="checkbox" 
                                                    id="checkbox_criteria_<?= $app['id_criteria']?>" 
                                                    onclick="CheckCriteria(`checkBox`,'<?= $app['id_criteria']?>' )"
                                            />
                                            <span 
                                                style="line-height: normal; cursor: pointer;"
                                                id="span_criteria_<?= $app['id_criteria']?>"
                                                onclick="CheckCriteria(`span`,'<?= $app['id_criteria']?>')"
                                            ><?= $app['name_criteria']?></span>
                                        </div>
                                             
                                <?php }?>
                        </div>


                </div>

                <div class="col-sm-6 col-md-3 col-lg-3 mb-2 mr-2" style="font-size: 1rem; line-height: 3rem;" id="divCrit3" hidden='true'>
                                    
                        <div class="mr-2"  >Дополнительные  критериев</div>
                        <div  style="max-height: 300px; overflow: auto" >
                                <?php
                                    $query = "SELECT id_criteria, CONCAT(c.name, IFNUll(CONCAT(' (', con.conditions,')'),'') ) as name_criteria
                                                FROM criteria c
                                                left outer join conditions con on c.conditions_id=con.conditions_id
                                                where c.type_criteria=3
                                                order by c.name
                                                ";
                                    $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);

                                        foreach ($data as $app) {

                                ?>
                                         <div class="d-flex mb-2" id="<?= $app['id_criteria']?>" >
                                            
                                            <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                                    type="checkbox" 
                                                    id="checkbox_criteria_<?= $app['id_criteria']?>" 
                                                    onclick="CheckCriteria(`checkBox`,'<?= $app['id_criteria']?>' )"
                                            />
                                            <span 
                                                style="line-height: normal; cursor: pointer;"
                                                id="span_criteria_<?= $app['id_criteria']?>"
                                                onclick="CheckCriteria(`span`,'<?= $app['id_criteria']?>')"
                                                ><?= $app['name_criteria']?></span>
                                        </div>
                                             
                                <?php }?>
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



<script src="modules/report/report_analiz_ocenka/report_analiz_ocenka.js"></script>

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