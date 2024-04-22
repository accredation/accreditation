

<script src="modules/component/bootstrap.bundle.js"></script>

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
    max-width: 38vw
}

select>option {
  background-color: transparent;
  border: 0;
  color: red;
  padding-right: 15px;
  height: 31px;
  max-width: 220px;
  text-wrap: wrap;
 padding-left: 31px

}

.modal-backdrop {
  background: #fff;
}

.modal-backdrop.show {
  opacity: .0;
}


</style>

<?php if(isset($_COOKIE['login'])){?>
    <div class="content-wrapper">

            <h2 class="text-dark font-weight-bold mb-4" >Виды и профили ОЗ</h2>

            <div class="mb-2" >  
                
            
                <div class=" mb-2 mr-4 d-flex">
                 
                    <div >
                        

                        <button type="button" class="btn  btn-success btn-fw"
                        data-toggle="modal" data-target="#modalAddVidProfileOz"
                        onclick="showModalAddVidProfileOz()"
                           >Добавить ОЗ с видами и профилями
                        </button>
                    </div>
                </div>

                <div class="row" id='divForTable'>
                    
                </div>
               
                
                <button type="button" class="btn  btn-danger btn-close"
                                onclick="cteateTable()"
                                >x
                        </button>

            </div>
            

    </div>


    <div class="modal fade " id="modalAddVidProfileOz" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog " style="max-width: 60vw;" role="document">
            <div class="modal-content" >

                <!-- Modal Header -->
                <div class="modal-header">
                    <div style="display: flex">
                        <h4 class="modal-title" id="exampleModalLabel">Добавление ОЗ с видами и профилями</h4>
                    </div>

                    <div style="display: flex">

                        <button type="button" class="btn  btn-danger btn-close"
                                onclick="hideModalAddVidProfileOz()"
                                data-dismiss="modal">x
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

    <script src="modules/vid_profile_oz/vid_profile_oz.js"></script>



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




<script>

    $(document).ready(function () {
        // let example_filter = document.getElementById("sotr_th_data");
        // example_filter.click();

        createTable()

        // $.ajax({
        //     url: "modules/vid_profile_oz/getTableOz.php",
        //     method: "GET",
        //     data: {}
        // }).catch(function (xhr, status, error) {
        //     console.log("fail");
        // }).then((response) => {
        //     let divForTable = document.getElementById("divForTable")
          
        //     divForTable.insertAdjacentHTML("afterbegin", response);

        // })
    
    })
     
</script>






