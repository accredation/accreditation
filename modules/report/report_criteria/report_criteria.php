 <!-- <link rel="stylesheet" href="modules/report/report_application_status/report_application_status.css"> -->
<script src="modules/component/bootstrap.bundle.js"></script>
<?php if(isset($_COOKIE['login'])){?>
    <div class="content-wrapper">

        <h2 class="text-dark font-weight-bold mb-4">Анализ результатов по отдельным критериям</h2>
            
  
        <div class="row">

            <div class="mb-2" style="padding-left: 0.6rem ;">
                  
                <div style="justify-content: space-between; display: flex;">
                    <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                        <div id="dateRkkReg" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Дата регистрации заявления</div>
                    </div>

                    <div>
                        <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                            <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">с</label>
                            <input type="date" class="form-control"  style="font-size: 1rem;" id="dateRkkReg_at" onclick="disablePrint()">
                        </div>
                                
                        <div class="form-group mb-0" style="display: inline-flex;">
                            <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">по</label>
                            <input type="date" class="form-control" style="font-size: 1rem;" id="dateRkkReg_to" onclick="disablePrint()">
                        </div>
                    </div>
                </div>

            </div>

        </div>
        <div>    

            <div class="row mb-2 " style="padding-left: 9px;">
                
                <div class=" mb-2 mr-5" style="font-size: 1rem; line-height: 3rem;">
                    <div class="d-flex ">
                        <span class="mr-2" >Область</span>
                        <div class="btn-group" style="color: black;">

                            <div data-bs-toggle="dropdown"  data-bs-auto-close="outside"
                                style="min-width: 300px;
                                display: flex;" >
                            <input style="line-height: 2.4rem;       
                                    border: 1px solid rgba(151, 151, 151, 0.3);
                                    border-radius: 2px;
                                    min-width: 300px;
                                    padding: 0 1.375rem;
                                    " 
                                    
                                    readonly
                                    value="Все"
                                    id="divOblastStr"
                                    />
                                
                            <button class="btn btn-success dropdown-toggle" type="button"  aria-expanded="false">
                                
                            </button>
                            </div>

                            <ul class="dropdown-menu" style="min-width: 300px">
                                <?php
                                    $query = "SELECT id_oblast, oblast
                                    FROM accreditation.spr_oblast
                                    where id_oblast > 0
                                    order by order_num";
                                    $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);

                                        foreach ($data as $app) {
                                ?>
                                        <li  >    
                                            <div class="d-flex ml-2 mr-2 mb-2">
                                                <div class="d-flex oblast" 
                                                     id="<?= $app['id_oblast']?>"
                                                >
                                                    <input class="dropdown-item"
                                                        style="vertical-align: top; margin-right: 0.5rem;" 
                                                        type="checkbox" 
                                                        id="checkbox_id_oblast_<?= $app['id_oblast']?>"     
                                                        onclick="CheckMultiElement(`checkBox`,'oblast_<?= $app['id_oblast']?>', 'divOblastStr', 'oblast')"                      
                                                    />
                                                                
                                                    <span
                                                        style="line-height: normal; cursor: pointer;min-width: max-content" 
                                                        id="span_id_oblast_<?= $app['id_oblast']?>"    
                                                        onclick="CheckMultiElement(`span`,'oblast_<?= $app['id_oblast']?>', 'divOblastStr', 'oblast')"   
                                                        ><?= $app['oblast']?>
                                                    </span>
                                                </div>            
                                            </div>
                                        </li>                                         
                                <?php }?>

                                
                            
                            </ul>
                        </div>  
                    </div>
                </div>



                <div class=" mb-2 mr-5 " style="font-size: 1rem; line-height: 3rem;">
                    <div class="d-flex ">
                        <span class="mr-2">Тип организации</span>
                        <div class="btn-group" style="color: black;">

                            <div data-bs-toggle="dropdown" data-bs-auto-close="outside"
                                style="min-width: 300px;
                                display: flex;" >
                            <input style="line-height: 2.4rem;       
                                    border: 1px solid rgba(151, 151, 151, 0.3);
                                    border-radius: 2px;
                                    min-width: 300px;
                                    padding: 0 1.375rem;
                                    " 
                                    
                                    readonly
                                    value="Все"
                                    id="divTypeStr"
                                    />
                                
                            <button class="btn btn-success dropdown-toggle" type="button"  aria-expanded="false">
                                
                            </button>
                            </div>

                            <ul class="dropdown-menu" style="min-width: 300px">
                                <?php
                                    $query = "SELECT id_type, type_name
                                    FROM accreditation.spr_type_organization
                                    ";
                                    $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);

                                        foreach ($data as $app) {
                                ?>
                                        <li >    
                                            <div class="d-flex ml-2 mr-2 mb-2">
                                                <div class="d-flex type"
                                                    id="<?= $app['id_type']?>">
                                                    <input class="dropdown-item" 
                                                        style="vertical-align: top; margin-right: 0.5rem;" 
                                                        type="checkbox" 
                                                        id="checkbox_id_type_<?= $app['id_type']?>"   
                                                        onclick="CheckMultiElement(`checkBox`,'type_<?= $app['id_type']?>', 'divTypeStr', 'type')"                          
                                                    />
                                                                
                                                    <span 
                                                        style="line-height: normal; cursor: pointer;min-width: max-content" 
                                                        id="span_id_type_<?= $app['id_type']?>"   
                                                        onclick="CheckMultiElement(`span`,'type_<?= $app['id_type']?>', 'divTypeStr', 'type')"      
                                                        ><?= $app['type_name']?>
                                                    </span>
                                                </div>            
                                            </div>
                                        </li>                                         
                                <?php }?>

                                
                            
                            </ul>
                        </div>  
                    </div>
                </div>


            </div>
        </div>

        <div class="row">

            <div class=" mb-4 ml-2" style="display: flex;">      
                <div class="mr-3 ">
                    <div>Вид административного решения</div>
                </div> 

                <div>

                    <div class="d-flex mb-2" >
                                                            
                        <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                type="checkbox" 
                                id="checkbox_adm_resh_1" 
                                onclick="CheckCheckBoxElement(`checkBox`,'adm_resh_1' )"                                       
                        />
                        <span   style="line-height: normal; cursor: pointer;"
                                id="span_adm_resh_1"
                                onclick="CheckCheckBoxElement(`span`,'adm_resh_1' )"                             
                            >Выдача свидетельства</span>
                    </div>

                    <div class="d-flex mb-2" >
                                                            
                        <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                type="checkbox" 
                                id="checkbox_adm_resh_2" 
                                onclick="CheckCheckBoxElement(`checkBox`,'adm_resh_2' )"                              
                        />
                        <span   style="line-height: normal; cursor: pointer;"
                                id="span_adm_resh_2"
                                onclick="CheckCheckBoxElement(`span`,'adm_resh_2' )"                           
                            >Отказ в выдаче свидетельства</span>
                    </div>

                    <div class="d-flex mb-2" >
                                                            
                        <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                type="checkbox" 
                                id="checkbox_adm_resh_3" 
                                onclick="CheckCheckBoxElement(`checkBox`,'adm_resh_3' )"                              
                        />
                        <span   style="line-height: normal; cursor: pointer;"
                                id="span_adm_resh_3"
                                onclick="CheckCheckBoxElement(`span`,'adm_resh_3' )"                           
                            >Отказ в приеме заявления</span>
                    </div>

                </div>
                      
            </div>

        </div>

        <div class="row">
            <div>
                <div class=" mb-2 ml-2 " style="display: flex;">      
                        <div class="mr-3 ">
                            <div>По проводящему оценку</div>
                        </div> 

                            <div class="d-flex mb-2 mr-4" >
                                                            
                                <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                    type="checkbox" 
                                    id="checkbox_guzo_1" 
                                    onclick="CheckCheckBoxElement(`checkBox`,'guzo_1' )"                             
                                />
                                <span 
                                    style="line-height: normal; cursor: pointer;"
                                    id="span_guzo_1"
                                    onclick="CheckCheckBoxElement(`span`,'guzo_1' )"                         
                                    >ГУЗО, Комитет</span>
                            </div>

                            <div class="d-flex mb-2 " >
                                                            
                                <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                    type="checkbox" 
                                    id="checkbox_guzo_2" 
                                    onclick="CheckCheckBoxElement(`checkBox`,'guzo_2' )"                             
                                />
                                <span 
                                    style="line-height: normal; cursor: pointer;"
                                    id="span_guzo_2"
                                    onclick="CheckCheckBoxElement(`span`,'guzo_2' )"                         
                                    >Внутреняя комиссия</span>
                            </div> 
                </div>

            </div>

        </div>

        <div class="row">              

            <div class=" mb-2 ml-2" style="display: flex;" >      
                <div class="mr-3 " style="vertical-align: center; " >
                    <div>Результаты</div>
                </div> 
                <div class="row" id='radio_type_report'>
                    <div class="col d-flex mb-2" >
                                                            
                        <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                type="radio" 
                                checked= 'true'
                                id="checkbox_type_report_1" 
                                onclick="CheckRadioElement(`checkBox`,'1' )"                             
                        />
                        <span   style="line-height: normal; cursor: pointer;min-width: max-content;"
                                id="span_type_report_1"
                                onclick="CheckRadioElement(`span`,'1' )"                         
                            >самоаккредитации</span>
                    </div>

                    <div class="col d-flex mb-2 ml-4" >
                                                            
                        <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                type="radio" 
                                id="checkbox_type_report_2" 
                                onclick="CheckRadioElement(`checkBox`,'2' )"                             
                        />
                        <span   style="line-height: normal; cursor: pointer;min-width: max-content;"
                                id="span_type_report_2"
                                onclick="CheckRadioElement(`span`,'2' )"                         
                            >оценки</span>
                    </div>

                </div>     

            </div>
        </div>

        <div class="row">
            <div >   
                <div class="d-flex mb-2 ml-2" >
                    <div class="mr-2"
                            style="line-height: normal; cursor: pointer;"
                                                 
                    >Отдельно по юр. лицам</div>                                  
                    <input  style="vertical-align: top; margin-right: 0.5rem;" 
                            type="checkbox" 
                            id="flag_yur_lica"                             
                    />
                    
                </div>
            </div>
      
        </div>  
        
        <div class="row d-flex mt-4"  >
            <?php
                $query = "SELECT id_types_tables, name
                          FROM accreditation.z_types_tables
                        ";
                $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                                        
                foreach ($data as $app) {                               
            ?>

            <div class=" mb-2 mr-4 ml-2" style="font-size: 1rem; line-height: 3rem; max-width: 23%;
                    min-width: 360px;"  id="divCrit<?= $app['id_types_tables']?>" >
                <div class=""  style='line-height: normal;
                            text-align: left;'><?= $app['name']?>  
                </div>
                <hr>
                <div class=" " style="max-height: 300px; overflow: auto; " >

                    <?php
                        $id_types_tables =  $app['id_types_tables'];
                        $query1 = "SELECT id_list_tables_criteria, name as name_criteria
                                FROM accreditation.z_list_tables_criteria
                                where id_types_tables= '$id_types_tables'
                                order by level, name
                                ";
                        $result1=mysqli_query($con, $query1) or die ( mysqli_error($con));
                        for ($data1 = []; $row1= mysqli_fetch_assoc($result1); $data1[] = $row1);
                                                                
                        foreach ($data1 as $app1) {
                                                                
                    ?>

                    <div class="d-flex mb-2" id="<?= $app1['id_list_tables_criteria']?>" >
                                                        
                        <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                type="checkbox" 
                                
                                id="checkbox_criteria_<?= $app1['id_list_tables_criteria']?>" 
                                
                                onclick="return false"
                            />
                        <span   style="line-height: normal; cursor: pointer;"
                                id="span_criteria_<?= $app1['id_list_tables_criteria']?>"
                                
                                data-toggle= "modal" data-target="#modalCheckCriteria"
                                onclick="CheckCriteriaVisible(`span`,'<?= $app1['id_list_tables_criteria']?>')"
                                ><?= $app1['name_criteria']?></span>
                    </div>   
                                                                
                    <?php }?>  

                </div>    
        </div>            
                                                       
        <?php }?>
          

        </div>
        
            <div class="row mt-2" id='butnJournal'>
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
                        onclick="printReport2()"
                    >Экспорт в xls</button>
                </div>
                
            </div>

            <div id="reportRow" class="row">
                <div class=" m-3 " style="font-size: 1rem; line-height: 3rem;">
                    
                    <div id="divForTable" ></div>
                </div>
            </div>

    </div>

    <div class="modal fade " id="modalCheckCriteria" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog " style="max-width: 60vw;" role="document">
            <div class="modal-content" >

                <!-- Modal Header -->
                <div class="modal-header">
                    <div style="display: flex">
                        <h4 class="modal-title" id="exampleModalLabel">выбор критерия</h4>
                    </div>

                    <div style="display: flex">

                        <button type="button" class="btn  btn-danger btn-close"
                                
                                data-dismiss="modal">x
                        </button>
                    </div>
                </div>

                <!-- Modal body -->
                <div class="modal-body" id='modalScheduleBody'>


                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn  btn-success btn-close"
                                onclick="addCriteria()"
                                data-dismiss="modal">Выбрать
                    </button>
                </div>

            </div>
        </div>
    </div>

    <!-- onclick="hideModalAddVidProfileOz()" -->

<script src="modules/report/report_criteria/report_criteria.js"></script>

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