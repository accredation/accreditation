

<?php if(isset($_COOKIE['login'])){?>
    <div class="content-wrapper">

            <h2 class="text-dark font-weight-bold mb-4" style='text-align: center'>Журнал РКК</h2>


            <div class="row">

                <div class="col-sm-7 col-md-6 col-lg-6 mb-2" style="border-right: 2px solid #8e94a9;">   



                    <div class=" mb-4  mr-4 d-flex">  
                        <div class="mb-2 mr-4" >
                            Журнал                              
                        </div>     

                        <div>
                        <div class="d-flex mb-2" >
                                                        
                            <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                type="checkbox" 
                                id="checkbox_with_contact" 
                                onclick="CheckCheckBoxElement(`checkBox`,'with_contact' )"                            
                            />
                            <span 
                                style="line-height: normal; cursor: pointer;"
                                id="span_with_contact"
                                onclick="CheckCheckBoxElement(`span`,'with_contact' )"                       
                                >С контактами</span>
                        </div>

                        <div class="d-flex mb-2" >
                                                        
                            <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                type="checkbox" 
                                id="checkbox_zaregal" 
                                onclick="CheckCheckBoxElement(`checkBox`,'zaregal' )"                                 
                            />
                            <span 
                                style="line-height: normal; cursor: pointer;"
                                id="span_zaregal"
                                onclick="CheckCheckBoxElement(`span`,'zaregal' )"                           
                                >ФИО, зарегистрировавшего заявление</span>
                        </div>

                        <div class="d-flex mb-2" >
                                                        
                            <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                type="checkbox" 
                                id="checkbox_info" 
                                onclick="CheckCheckBoxElement(`checkBox`,'info' )"                                
                            />
                            <span 
                                style="line-height: normal; cursor: pointer;"
                                id="span_info"
                                onclick="CheckCheckBoxElement(`span`,'info' )"                               
                                >С датами выдачи свидетельства и информацией о незаявленных профилях</span>
                        </div>
                        
                        </div>
                    </div>

                

                    <div class=" mb-2 mr-4">       

                        <div class="mb-1"> 
                            <div style="justify-content: space-between; display: flex;">
                                <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                    <div id="date_reg"  style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Дата регистрации</div>
                            
                                </div>

                                <div>
                                <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">с</label>
                                    <input type="date" class="form-control"  style="font-size: 1rem;" id="date_reg_at" onclick="disablePrint()">
                                </div>
                                
                                <div class="form-group mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">по</label>
                                    <input type="date" class="form-control" style="font-size: 1rem;" id="date_reg_to" onclick="disablePrint()">
                                </div>
                                </div>
                            </div>
                        </div>


                        <div class="mb-1">  
                            <div style="justify-content: space-between; display: flex;">
                                <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                    <div id="date_protokol" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Дата протокола</div>
                                </div>

                                <div>
                                <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">с</label>
                                    <input type="date" class="form-control"  style="font-size: 1rem;" id="date_protokol_at" onclick="disablePrint()">
                                </div>
                                
                                <div class="form-group mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">по</label>
                                    <input type="date" class="form-control" style="font-size: 1rem;" id="date_protokol_to" onclick="disablePrint()">
                                </div>
                                </div>
                            </div>  
                        </div>


                        <div class="mb-1">   
                            <div style="justify-content: space-between; display: flex;">
                                <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                    <div id="date_admin_resh" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Дата уведомления</div>
                                </div>

                                <div>
                                <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">с</label>
                                    <input type="date" class="form-control"  style="font-size: 1rem;" id="date_admin_resh_at" onclick="disablePrint()">
                                </div>
                                
                                <div class="form-group mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">по</label>
                                    <input type="date" class="form-control" style="font-size: 1rem;" id="date_admin_resh_to" onclick="disablePrint()">
                                </div>
                                </div>
                            </div>    
                        </div>

                        <div class="mb-1"> 
                            <div style="justify-content: space-between; display: flex;">
                                <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                    <div id="date_sved" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Срок действия свидетельства</div>
                                </div>

                                <div>
                                <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">с</label>
                                    <input type="date" class="form-control"  style="font-size: 1rem;" id="date_sved_at" onclick="disablePrint()">
                                </div>
                                
                                <div class="form-group mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">по</label>
                                    <input type="date" class="form-control" style="font-size: 1rem;" id="date_sved_to" onclick="disablePrint()">
                                </div>
                                </div>
                            </div>   
                        </div>

                        <div class="mb-1"> 
                            <div style="justify-content: space-between; display: flex;">
                                <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                    <div id="date_delo" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Дата снятия с контроля</div>
                                </div>

                                <div>
                                <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">с</label>
                                    <input type="date" class="form-control"  style="font-size: 1rem;" id="date_delo_at" onclick="disablePrint()">
                                </div>
                                
                                <div class="form-group mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">по</label>
                                    <input type="date" class="form-control" style="font-size: 1rem;" id="date_delo_to" onclick="disablePrint()">
                                </div>
                                </div>
                            </div>   
                        </div>            

                        
                        
                    </div>

                </div>



                <div class="col-sm-4 col-md-6 col-lg-6 mb-2">   
      
                    <div class=" mb-4 ml-2 " style="display: flex;">      
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


                    <div class=" mb-4 ml-2 d-flex" >      
                         

                        <span>Регион</span>

                        <div class="row " style="display: contents;">
                          

                                <?php
                                    $index=1;
                                    $query = "SELECT id_oblast, oblast
                                                FROM spr_oblast
                                                order by order_num
                                                ";
                                    $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);

                                        foreach ($data as $app) {
                                        if($index==1){
                                ?>
                                        <div class="ml-2 col-sm-4 col-md-3 col-lg-3">
                                    <?php   
                                        }                                       
                                    ?>
                                        <div class="d-flex mb-2 oblast" id=<?= $app['id_oblast']?> >
                                                                
                                            <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                                    type="checkbox" 
                                                    id="checkbox_oblast_<?= $app['id_oblast']?>"
                                                    checked=true
                                                       
                                                    onclick="CheckCheckBoxOblastElement(`checkBox`,<?= $app['id_oblast']?> )"                       
                                            />
                                            <span 
                                                    style="line-height: normal; cursor: pointer;"
                                                    id="span_oblast_<?= $app['id_oblast']?>"
                                                    onclick="CheckCheckBoxOblastElement(`span`,<?= $app['id_oblast']?> )"                                        
                                            ><?= $app['oblast']?></span>
                                        </div>

                                    <?php
                                        if($index==3){
                                        $index=0;
                                    ?>
                                        </div>
                                    <?php   
                                        }                                       
                                    ?>    
                                    
                                <?php 
                                $index++;                           
                                }?>

                            
                            </div>
                        
                        
                        
                    </div>



                    <div class=" mb-4 ml-2 " style="display: flex;">      
                        <div class="mr-3 ">
                            <div>Заявление</div>
                        </div> 

                        <div class="row">
                            <div class="col-sm-8 col-md-8 col-lg-8 ">

                            <div class="d-flex mb-2" >
                                                            
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

                            <div class="col-sm-3 col-md-3 col-lg-3 ml-3 ">

                            <div class="d-flex mb-2" >
                                                            
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
                        </div>
                    </div>


                    <div class=" mb-4 ml-2 d-flex hiddentab" id="rkkotzyv_hide" >      
                         

                        <span>Основание для повторного</span>

                        <div class="row " style="display: contents;">
                          

                                <?php
                                    $index=1;
                                    $query = "SELECT id_rkkotzyv, rkkotzyv_str
                                                FROM accreditation.spr_rkkotzyv
                                                order by id_rkkotzyv
                                                ";
                                    $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);

                                        foreach ($data as $app) {
                                        if($index==1){
                                ?>
                                        <div class="ml-2 col-sm-4 col-md-3 col-lg-3">
                                    <?php   
                                        }                                       
                                    ?>
                                        <div class="d-flex mb-2 rkkotzyv" id=<?= $app['id_rkkotzyv']?> >
                                                                
                                            <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                                    type="checkbox" 
                                                    id="checkbox_rkkotzyv_<?= $app['id_rkkotzyv']?>"
                                                    checked=true
                                                       
                                                    onclick="CheckCheckBoxRkkotzyvElement(`checkBox`,<?= $app['id_rkkotzyv']?> )"                       
                                            />
                                            <span 
                                                    style="line-height: normal; cursor: pointer;"
                                                    id="span_rkkotzyv_<?= $app['id_rkkotzyv']?>"
                                                    onclick="CheckCheckBoxRkkotzyvElement(`span`,<?= $app['id_rkkotzyv']?> )"                                        
                                            ><?= $app['rkkotzyv_str']?></span>
                                        </div>

                                    <?php
                                        if($index==3){
                                        $index=0;
                                    ?>
                                        </div>
                                    <?php   
                                        }                                       
                                    ?>    
                                    
                                <?php 
                                $index++;                           
                                }?>

                            
                            </div>
                        
                        
                        
                    </div>


                    <div class=" mb-4 ml-2 " style="display: flex;">                             

                            <div class="d-flex mb-2" >
                                                            
                                <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                    type="checkbox" 
                                    id="checkbox_otz" 
                                    onclick="CheckCheckBoxElement(`checkBox`,'otz' )"                             
                                />
                                <span 
                                    style="line-height: normal; cursor: pointer;"
                                    id="span_potz"
                                    onclick="CheckCheckBoxElement(`span`,'otz' )"                         
                                    >Отозванные заявления</span>
                            </div>

                            <div class="d-flex mb-2 ml-4" >
                                                            
                                <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                    type="checkbox" 
                                    id="checkbox_otkaz" 
                                    onclick="CheckCheckBoxElement(`checkBox`,'otkaz' )"                             
                                />
                                <span 
                                    style="line-height: normal; cursor: pointer;"
                                    id="span_otkaz"
                                    onclick="CheckCheckBoxElement(`span`,'otkaz' )"                         
                                    >Отказ в приеме заявления</span>
                            </div>


                       
                        



                            
                        
                        
                    </div>


                    <div class=" mb-4 ml-2 row" style="display: flex; ">      
                                <div class="mr-3 p-0 col"  style="max-width: 65px;">
                                    <div class="d-flex mb-2" >
                                                                    
                                        <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                            type="checkbox" 
                                            id="checkbox_search_1" 
                                            onclick="CheckCheckBoxSearch(`checkBox`)"                                       
                                        />
                                        <span 
                                            style="line-height: normal; cursor: pointer;"
                                            id="span_search_1"
                                            onclick="CheckCheckBoxSearch(`span`)"                             
                                            >Поиск</span>
                                    </div>
                                </div> 

                                <div id="radio_journal" class="col" style="max-width: 235px;">

                                    <div class="d-flex mb-2" >
                                                                    
                                        <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                            type="radio" 
                                            checked="true"
                                            id="radio_search_1" 
                                            disabled
                                            onclick="CheckRadioElement(`radio`,'search_1' )"                                       
                                        />
                                        <span 
                                            style="line-height: normal; cursor: pointer;"
                                            id="span_search_1"
                                            
                                            onclick="CheckRadioElement(`span`,'search_1' )"                             
                                            >№ свидетельства</span>
                                    </div>

                                    <div class="d-flex mb-2 " >
                                                                    
                                        <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                            type="radio" 
                                            id="radio_search_2" 
                                            disabled
                                            onclick="CheckRadioElement(`radio`,'search_2' )"                              
                                        />
                                        <span 
                                            style="line-height: normal; cursor: pointer;"
                                            id="span_search_2"
                                            onclick="CheckRadioElement(`span`,'search_2' )"                           
                                            >По названию организации</span>
                                    </div>


                                    

                                    

                                </div>

                                <div class="form-group mb-2 ml-2 col" >
                                                                    
                                        <input  class="form-control" 
                                            type="text" 
                                            disabled
                                            id="search_text"                              
                                        />
                                        
                                    </div>
                            

                        
                        
                    </div>

                


                </div>


            </div>


        
            <div class="row" id='butnJournal'>
                <div class="col-sm-6 col-md-3 col-lg-3 mb-2 mr-2" style="font-size: 1rem; line-height: 3rem;">
                    <button 
                        id="btnReport"
                        class="btn btn-success btn-fw"
                        onclick="preperaReport()"
                    >Сформировать</button>

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
                                
                        <div id="divForTable"  class="page-break"></div>
   
                </div>
            </div>

    </div>



<script src="modules/journal_rkk/journal_rkk.js"></script>


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