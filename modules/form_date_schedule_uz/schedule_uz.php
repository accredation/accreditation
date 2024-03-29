<style>
.show{
    display: block;
}

.form-select-my { 
    height: 2.875rem;
    padding: 0.5rem 1.375rem;  
    font-weight: 400;
    line-height: 1;
    border: 1px solid rgba(151, 151, 151, 0.3);
    border-radius: 2px;
    font-family: "nunito-regular", sans-serif;
    font-size:1rem;
}


</style>

<?php if(isset($_COOKIE['login'])){?>
    <div class="content-wrapper">

            <h2 class="text-dark font-weight-bold mb-4" >График подачи заявлений организациями здравоохранения</h2>

            <div class="mb-2" >   
               
               <div class=" mb-2 mr-4">       

                   <div class="mb-1"> 
                       <div style="justify-content: space-between; display: flex;">

                           <div class="form-group mr-3 mb-0" style="display: inline-flex;">
                               <label for="inputDate" style="font-size: 1rem; min-width: fit-content; line-height: 3rem;" class="mr-2">Год подачи заявления по графику</label>
                               <input type="number" class="form-control" id='year_schedule' style="font-size: 1rem;" min="2024" max="2099" step="1" />
                           </div>
                           
                    
                       </div>
                   </div>

                   
                   
               </div>

               
                <div class="mb-2 mr-2" style="font-size: 1rem; line-height: 3rem;">
                   

                       <button 
                           id="btnReportPrint"
                           class="btn btn-success btn-fw"
                           onclick="showOZ()"
                       >Сформировать список ОЗ</button>

                   
                </div>
               

                <div class="row  mr-2" style="background-color: white;">
                    <div class="card-body" id='tableScheduleOZ'>
                        
                    </div>
                </div>
                

            </div>
            

    </div>


    <div class="modal" id="modalAddScheduleDateOz">
        <div class="modal-dialog " style="max-width: 60vw;">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <div style="display: flex">
                        <h4 class="modal-title">Добавление ОЗ в график</h4>
                    </div>

                    <div style="display: flex">

                        <button type="button" class="btn  btn-danger btn-close"
                                onclick="hideModalAddScheduleDateOz()"
                                data-bs-dismiss="modal">x
                        </button>
                    </div>
                </div>

                <!-- Modal body -->
                <div class="modal-body" id='modalScheduleBody'>


                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    
                </div>

            </div>
        </div>
    </div>

    <script src="modules/form_date_schedule_uz/schedule_uz.js"></script>


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