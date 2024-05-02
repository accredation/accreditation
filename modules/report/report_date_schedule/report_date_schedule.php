<!-- <link rel="stylesheet" href="modules/report/report_analiz_ocenka/report_analiz_ocenka.css"> -->
<script src="modules/component/bootstrap.bundle.js"></script>            

<?php if(isset($_COOKIE['login'])){?>
    
    <div class="content-wrapper">

            <h2 class="text-dark font-weight-bold mb-4" style='text-align: left'>Контроль сроков подачи заявлений по графику</h2>


            <div  class="row">

            <div class="col-sm-7 col-md-6 col-lg-6 mb-2" style="border-right: 2px solid #8e94a9;">   

                <div class="row">

                    <div class="mb-2" style="padding-left: 0.6rem ;">
                        
                        <div style="justify-content: space-between; display: flex;">
                            <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                <div id="datePeriod" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Отчетный период подачи заявления</div>
                            </div>

                            <div>
                                <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">с</label>
                                    <input type="date" class="form-control"  style="font-size: 1rem;" id="datePeriod_at" >
                                </div>
                                        
                                <div class="form-group mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">по</label>
                                    <input type="date" class="form-control" style="font-size: 1rem;" id="datePeriod_to" >
                                </div>
                            </div>
                        </div>

                    </div>

                </div>

            
                <div class=" mb-3" style="display: flex;">      
                    <div>
                        <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                           <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Год подачи заявления по графику</label>
                           <input type="number" class="form-control" id='year_schedule' style="font-size: 1rem;" min="2024" max="2099" step="1" />
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
                </div>    


                <div class="row">
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
                </div>


            </div>
            
            <div class="col-sm-4 col-md-6 col-lg-6 mb-2">   


            <div class=" mb-3" style="display: flex;" >      
                        <div class="mr-3 " style="vertical-align: center; " >
                            <div>Вид отчета</div>
                        </div> 
                        <div class="row" id='radio_type_report'>
                            <div class="col d-flex mb-2" >
                                                            
                                <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                    type="radio" 
                                    checked= 'true'
                                    id="checkbox_type_report_1" 
                                    onclick="CheckTypeReportElement(`checkBox`,'1' )"                             
                                />
                                <span 
                                    style="line-height: normal; cursor: pointer;min-width: max-content;"
                                    id="span_type_report_1"
                                    onclick="CheckTypeReportElement(`span`,'1' )"                         
                                    >Не создавшие заявление в отчетный период</span>
                            </div>

                            <div class="col d-flex mb-2 ml-4" >
                                                            
                                <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                    type="radio" 
                                    id="checkbox_type_report_2" 
                                    onclick="CheckTypeReportElement(`checkBox`,'2' )"                             
                                />
                                <span 
                                    style="line-height: normal; cursor: pointer;min-width: max-content;"
                                    id="span_type_report_2"
                                    onclick="CheckTypeReportElement(`span`,'2' )"                         
                                    >Не подавшие заявление по графику</span>
                            </div>

                            
                            <div class="col d-flex mb-2 ml-4" >
                                                            
                                <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                    type="radio" 
                                    id="checkbox_type_report_3" 
                                    onclick="CheckTypeReportElement(`checkBox`,'3' )"                             
                                />
                                <span 
                                    style="line-height: normal; cursor: pointer;min-width: max-content;"
                                    id="span_type_report_3"
                                    onclick="CheckTypeReportElement(`span`,'3' )"                         
                                    >Не завершена оценка в срок</span>
                            </div>

                            <div class="col d-flex mb-2 ml-4" >
                                                            
                                    <input  style="vertical-align: top; margin-right: 0.5rem;" 
                                        type="radio" 
                                        id="checkbox_type_report_4" 
                                        onclick="CheckTypeReportElement(`checkBox`,'4' )"                             
                                    />
                                    <span 
                                        style="line-height: normal; cursor: pointer;min-width: max-content;"
                                        id="span_type_report_4"
                                        onclick="CheckTypeReportElement(`span`,'4' )"                         
                                    >Не вынесено решение в срок</span>
                            </div>

                            <div class="col d-flex mb-2 ml-4" >
                                <input  style="vertical-align: top; margin-right: 0.5rem; " 
                                        type="radio" 
                                        id="checkbox_type_report_5" 
                                        onclick="CheckTypeReportElement(`checkBox`,'5' )"                             
                                    />
                                <span 
                                    style="line-height: normal; cursor: pointer;min-width: max-content;"
                                    id="span_type_report_5"
                                    onclick="CheckTypeReportElement(`span`,'5' )"                         
                                    >Не направлено уведомление в срок</span>

                                
                            </div>      

                            <div class="col d-flex mb-2 ml-4" >
                                <input  style="vertical-align: top; margin-right: 0.5rem; " 
                                        type="radio" 
                                        id="checkbox_type_report_6" 
                                        onclick="CheckTypeReportElement(`checkBox`,'6' )"                             
                                    />
                                <span 
                                    style="line-height: normal; cursor: pointer;min-width: max-content;"
                                    id="span_type_report_6"
                                    onclick="CheckTypeReportElement(`span`,'6' )"                         
                                    >Отсутствует план устранения несоответствия</span>

                                
                            </div>

                            <div class="col d-flex mb-2 ml-4" >
                                <input  style="vertical-align: top; margin-right: 0.5rem; " 
                                        type="radio" 
                                        id="checkbox_type_report_7" 
                                        onclick="CheckTypeReportElement(`checkBox`,'7' )"                             
                                    />
                                <span 
                                    style="line-height: normal; cursor: pointer;min-width: max-content;"
                                    id="span_type_report_7"
                                    onclick="CheckTypeReportElement(`span`,'7' )"                         
                                    >Не подали повторное заявление</span>

                                
                            </div>
                        </div>     

                    </div>


                <div class="row ml-3">

                        <div class=" mb-2" style="display: flex;" id='day1'>      
                            <div>
                                <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Количество дней на прохождение самоаккредитации</label>
                                    <input type="number" class="form-control"  style="font-size: 1rem;" id="count_day_proh"  value=30 >
                                </div>

                                
                            </div>
                        </div>

                        <div class=" mb-2" style="display: flex;" id='day2' hidden>      
                            <div>
                                <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Количество дней на представление заключения ЦГЭ</label>
                                    <input type="number" class="form-control"  style="font-size: 1rem;" id="count_day_cge"  value=45 >
                                </div>

                                
                            </div>
                        </div>


                        <div class=" mb-2" style="display: flex;" id='day3' hidden>      
                            <div>
                                <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Количество дней на завершение процедуры</label>
                                    <input type="number" class="form-control"  style="font-size: 1rem;" id="count_day_proc"  value=90 >
                                </div>

                                
                            </div>
                        </div>

                        <div class=" mb-2" style="display: flex;" id='day4' hidden>      
                            <div>
                                <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Количество дней на уведомление</label>
                                    <input type="number" class="form-control"  style="font-size: 1rem;" id="count_day_uved"  value=5 >
                                </div>

                                
                            </div>
                        </div>

                        <div class=" mb-2" style="display: flex;" id='day5' hidden>      
                            <div>
                                <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Количество дней на формирование плана устранения</label>
                                    <input type="number" class="form-control"  style="font-size: 1rem;" id="count_day_plan"  value=20 >
                                </div>

                                
                            </div>
                        </div>

                        <div class=" mb-2" style="display: flex;" id='day6' hidden>      
                            <div>
                                <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                                    <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Количество месяцев для повторной подачи</label>
                                    <input type="number" class="form-control"  style="font-size: 1rem;" id="count_day_app"  value=6 >
                                </div>

                                
                            </div>
                        </div>

                </div>

                
            </div>

            </div>
        
        <div>
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