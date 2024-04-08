<!-- <link rel="stylesheet" href="modules/report/report_analiz_ocenka/report_analiz_ocenka.css"> -->
              

<?php if(isset($_COOKIE['login'])){?>
    
    <div class="content-wrapper">

            <h2 class="text-dark font-weight-bold mb-4" style='text-align: center'>Контроль сроков подачи заявлений по графику</h2>


            <div >

                            

                    <div class=" mb-3 mr-4">       

                        <div class="mb-1"> 
                            <div style=" display: flex;">
                                <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                    <div id="period"  style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Отчетный период подачи заявления</div>
                            
                                </div>

                                <div>
                                <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">с</label>
                                    <input type="date" class="form-control"  style="font-size: 1rem;"  id="period_at" >
                                </div>
                                
                                <div class="form-group mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">по</label>
                                    <input type="date" class="form-control" style="font-size: 1rem;"  id="period_to" >
                                </div>
                                </div>
                            </div>
                        </div>

                        
                    </div>

                    


                    <div class=" mb-2" style="display: flex;" >      
                        <div class="mr-3 " style="vertical-align: center; " >
                            <div>Тип отчета</div>
                        </div> 
                        <div class="row" id='radio_type_report'>
                            <div class="col d-flex mb-2" >
                                                            
                                <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                    type="radio" 
                                    checked= 'true'
                                    id="checkbox_type_report_1" 
                                    onclick="CheckCheckBoxElement(`checkBox`,'1' )"                             
                                />
                                <span 
                                    style="line-height: normal; cursor: pointer;min-width: max-content;"
                                    id="span_type_report_1"
                                    onclick="CheckCheckBoxElement(`span`,'1' )"                         
                                    >Все созданные заявления</span>
                            </div>

                            <div class="col d-flex mb-2 ml-4" >
                                                            
                                <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                    type="radio" 
                                    id="checkbox_type_report_2" 
                                    onclick="CheckCheckBoxElement(`checkBox`,'2' )"                             
                                />
                                <span 
                                    style="line-height: normal; cursor: pointer;min-width: max-content;"
                                    id="span_type_report_2"
                                    onclick="CheckCheckBoxElement(`span`,'2' )"                         
                                    >Подавшие заявление по графику</span>
                            </div>

                            <div class="col d-flex mb-2 ml-4" >
                                                            
                                <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                    type="radio" 
                                    id="checkbox_type_report_3" 
                                    onclick="CheckCheckBoxElement(`checkBox`,'3' )"                             
                                />
                                <span 
                                    style="line-height: normal; cursor: pointer;min-width: max-content;"
                                    id="span_type_report_3"
                                    onclick="CheckCheckBoxElement(`span`,'3' )"                         
                                    >Подавшие заявление не по графику</span>
                            </div>

                            <div class="col d-flex mb-2 ml-4" >
                                                            
                                <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                    type="radio" 
                                    id="checkbox_type_report_4" 
                                    onclick="CheckCheckBoxElement(`checkBox`,'4' )"                             
                                />
                                <span 
                                    style="line-height: normal; cursor: pointer;min-width: max-content;"
                                    id="span_type_report_4"
                                    onclick="CheckCheckBoxElement(`span`,'4' )"                         
                                    >Не подавшие заявление по графику</span>
                            </div>

                            <div class="col d-flex mb-2 ml-4" >
                                                            
                                    <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                        type="radio" 
                                        id="checkbox_type_report_5" 
                                        onclick="CheckCheckBoxElement(`checkBox`,'5' )"                             
                                    />
                                    <span 
                                        style="line-height: normal; cursor: pointer;min-width: max-content;"
                                        id="span_type_report_5"
                                        onclick="CheckCheckBoxElement(`span`,'5' )"                         
                                    >Не создавшие заявление в отчетный период</span>
                            </div>

                            <div class="col d-flex mb-2 ml-4" >
                                <input  style="vertical-align: top; margin-right: 0.5rem; " 
                                        type="radio" 
                                        id="checkbox_type_report_6" 
                                        onclick="CheckCheckBoxElement(`checkBox`,'6' )"                             
                                    />
                                <span 
                                    style="line-height: normal; cursor: pointer;min-width: max-content;"
                                    id="span_type_report_6"
                                    onclick="CheckCheckBoxElement(`span`,'6' )"                         
                                    >Заявления организаций здравоохранения с пустой датой в графике</span>

                                
                            </div>      

                        </div>     

                    </div>

               
                    <div class=" mb-3" style="display: flex;">      
                        <div>
                            <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                               <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Год подачи заявления по графику</label>
                               <input type="number" class="form-control" id='year_schedule' style="font-size: 1rem;" min="2024" max="2099" step="1" />
                           </div>

                            <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Количество дней на прохождение самоаккредитации</label>
                                <input type="number" class="form-control"  style="font-size: 1rem;" id="count_day"  value=30 >
                            </div>

                            
                        </div>
                    </div>


                  
      
                    


                    <div class=" mb-3 d-flex" >      
                         

                        <span>Регион</span>

                        <div class="row " style="display: contents;" onclick="asdasd()">
                          

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



<script src="modules/report/report_date_schedule/report_date_schedule.js"></script>

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