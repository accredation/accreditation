 <!-- <link rel="stylesheet" href="modules/report/report_application_status/report_application_status.css"> -->
<script src="modules/component/bootstrap.bundle.js"></script>
<?php if(isset($_COOKIE['login'])){?>
    <div class="content-wrapper">

        <h2 class="text-dark font-weight-bold mb-4">Отчет по видам медицинской помощи и профилям ОЗ установленных в перечне</h2>
            
  
        <div class="row">

            <div class="col-sm-7 col-md-6 col-lg-6 mb-2" style="border-right: 2px solid #8e94a9;">   


            <div >    
            
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

            <div class=" mb-2" style="padding-left: 0.6rem ;">
                  
                <div style="justify-content: space-between; display: flex;">
                    <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                        <div id="dateRkkProtcol" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Дата протокола комиссии</div>
                    </div>

                    <div>
                        <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                            <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">с</label>
                            <input type="date" class="form-control"  style="font-size: 1rem;" id="dateRkkProtcol_at" onclick="disablePrint()">
                        </div>
                                
                        <div class="form-group mb-0" style="display: inline-flex;">
                            <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">по</label>
                            <input type="date" class="form-control" style="font-size: 1rem;" id="dateRkkProtcol_to" onclick="disablePrint()">
                        </div>
                    </div>
                </div>

            </div>

            <div class=" mb-2" style="padding-left: 0.6rem ;">
                  
                <div style="justify-content: space-between; display: flex;">
                    <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                        <div id="dateRkkSved" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Срок действия свидетельства</div>
                    </div>

                    <div>
                        <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                            <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">с</label>
                            <input type="date" class="form-control"  style="font-size: 1rem;" id="dateRkkSved_at" onclick="disablePrint()">
                        </div>
                                
                        <div class="form-group mb-0" style="display: inline-flex;">
                            <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">по</label>
                            <input type="date" class="form-control" style="font-size: 1rem;" id="dateRkkSved_to" onclick="disablePrint()">
                        </div>
                    </div>
                </div>

            </div>


                <div class=" mt-2 mb-2 ml-2 " style="display: flex;">      
                        <div class="mr-3 ">
                            <div>Заявления за период</div>
                        </div> 

                        <div class="d-flex mb-2 mr-4" >
                                                            
                                <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                    type="checkbox" 
                                    id="checkbox_pervtor_1" 
                                    onclick="CheckCheckBoxElement(`checkBox`,'pervtor_1' )"                             
                                />
                                <span 
                                    style="line-height: normal; cursor: pointer;"
                                    id="span_pervtor_1"
                                    onclick="CheckCheckBoxElement(`span`,'pervtor_1' )"                         
                                    >первичное</span>
                        </div>

                        <div class="d-flex mb-2" >
                                                            
                                <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                    type="checkbox" 
                                    id="checkbox_pervtor_2" 
                                    onclick="CheckCheckBoxElement(`checkBox`,'pervtor_2' )"                             
                                />
                                <span 
                                    style="line-height: normal; cursor: pointer;"
                                    id="span_pervtor_2"
                                    onclick="CheckCheckBoxElement(`span`,'pervtor_2' )"                         
                                    >повторное</span>
                        </div>
                </div>


                <div class=" mb-2 ml-2 " style="display: flex;">      
                        <div class="mr-3 ">
                            <div>по проводящему оценку</div>
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
        <div class="col-sm-4 col-md-6 col-lg-6 mb-2">  
            
                    <div class=" mb-4" style="display: flex;">      
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
                                <span 
                                    style="line-height: normal; cursor: pointer;"
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
                                <span 
                                    style="line-height: normal; cursor: pointer;"
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
                                <span 
                                    style="line-height: normal; cursor: pointer;"
                                    id="span_adm_resh_3"
                                    onclick="CheckCheckBoxElement(`span`,'adm_resh_3' )"                           
                                    >Отказ в приеме заявления</span>
                            </div>

                        </div>
                        
                        
                        
                    </div>

            <div class="row mb-2" style="padding-left: 9px;">
                
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



                <div class="mb-2 mr-5 " style="font-size: 1rem; line-height: 3rem;">
                    <div class="d-flex ">
                        <span class="mr-2">Статус</span>
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
                                    id="divStatusStr"
                                    />
                                
                            <button class="btn btn-success dropdown-toggle" type="button"  aria-expanded="false">
                                
                            </button>
                            </div>

                            <ul class="dropdown-menu" style="min-width: 300px">
                                <?php
                                    $query = "SELECT id_status, name_status_report
                                    FROM accreditation.status
                                    where id_status not in (5,7,8)
                                    ";
                                    $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);

                                        foreach ($data as $app) {
                                ?>
                                        <li >    
                                            <div class="d-flex ml-2 mr-2 mb-2">
                                                <div class="d-flex status" 
                                                id="<?= $app['id_status']?>">
                                                    <input class="dropdown-item" 
                                                        style="vertical-align: top; margin-right: 0.5rem;" 
                                                        type="checkbox" 
                                                        id="checkbox_id_status_<?= $app['id_status']?>"   
                                                        onclick="CheckMultiElement(`checkBox`,'status_<?= $app['id_status']?>', 'divStatusStr', 'status')"                        
                                                    />
                                                                
                                                    <span 
                                                        style="line-height: normal; cursor: pointer;min-width: max-content" 
                                                        id="span_id_status_<?= $app['id_status']?>" 
                                                        onclick="CheckMultiElement(`span`,'status_<?= $app['id_status']?>', 'divStatusStr', 'status')"        
                                                        ><?= $app['name_status_report']?>
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

                

                
            <div class="row">   
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



<script src="modules/report/report_vid_profile_oz/report_vid_profile_oz.js"></script>

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