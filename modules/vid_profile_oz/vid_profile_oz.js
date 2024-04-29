function cteateTable(){
    $.ajax({
        url: "modules/vid_profile_oz/getTableOz.php",
        method: "GET",
        data: {}
    }).catch(function (xhr, status, error) {
        console.log("fail");
    }).then((response) => {
        let divForTable = document.getElementById("divForTable")
        divForTable.innerHTML = '';
        divForTable.insertAdjacentHTML("afterbegin", response);

    })
    
}



function showModalAddVidProfileOz(state_value = false){
    checkedOzId = 0; 
    prepereOzForSchedule(state_value)
 }
 
 
 function hideModalAddVidProfileOz(){
 
    let  modalScheduleBody = document.getElementById('modalScheduleBody')
    let  divSelect = document.getElementById('divSelect')
    if(divSelect){
        modalScheduleBody.removeChild(divSelect)
    }
     
     let tableScheduleOZ = document.getElementById(`tableScheduleOZ`);
     let childTableScheduleOZ = document.getElementById(`childTableScheduleOZ`);
     if(childTableScheduleOZ){
        tableScheduleOZ.removeChild(childTableScheduleOZ)
     }
 
     cteateTable()
 }
 
 
 function prepereOzForSchedule(state_value, id_uz_vid_profile=0, id_uz = 0, id_vid_str = '', id_profile_str = ''){
     let data = new Array();
 
     let divSelect = document.createElement('div');
             divSelect.classList = ' mb-2'
             divSelect.style="font-size: 1rem; line-height: 3rem;"
             divSelect.id='divSelect'


        let spisOz = prepereOz(state_value, id_uz)
        divSelect.appendChild(spisOz)

        let div2 =  document.createElement('div')
        let vid = prepereVidOz(state_value,id_vid_str)
        div2.appendChild(vid)

        let profile = prepereProfileOz(state_value,id_profile_str)
        div2.appendChild(profile)
        divSelect.appendChild(div2)
                 

        let div = document.createElement('div')


        let exampleModalLabel = document.getElementById('exampleModalLabel')

        let button = document.createElement('button');
        button.classList = ' btn btn-success btn-fw '
        button.id="btnAddOzSchedule"
        if(state_value){
            button.onclick=()=>UpdateOz(id_uz_vid_profile) 
            button.innerText = 'Обновить данные ОЗ'

            exampleModalLabel.innerText = 'Редактирование видов и профилей ОЗ'
        } else {
            button.onclick=()=>AddOz() 
            button.innerText = 'Добавить в список ОЗ'

            exampleModalLabel.innerText = 'Добавление ОЗ с видами и профилями'
        }
        
        
                 
        div.appendChild(button)
        divSelect.appendChild(div)
 
        let  modalScheduleBody = document.getElementById('modalScheduleBody')
        modalScheduleBody.appendChild(divSelect)
 
 }

  function prepereOz(state_value,id_uz){
    let data = new Array();

    let divMainGroup = document.createElement('div');
        divMainGroup.classList = 'btn-group'
        divMainGroup.id = 'spisOz';
        divMainGroup.style="color: black;"


    let divSelect1 = document.createElement('div');
           // divSelect.classList = 'btn-group'
        divSelect1.style="min-width: 300px; display: flex;"
        if(state_value == false){
            divSelect1.setAttribute('data-bs-toggle','dropdown')  
        }
        

    let textarea = document.createElement('textarea');
        textarea.style="line-height: normal; border: 1px solid rgba(151, 151, 151, 0.3); border-radius: 2px; min-width: 55vw; padding: 0 1.375rem;"
         //   textarea.style="min-width: 55vw;"
        textarea.setAttribute('readonly','true')  
        textarea.id="divUzStr"

    let buttonSelect = document.createElement('button');
        buttonSelect.classList = 'btn btn-success dropdown-toggle'
        buttonSelect.id='btnSpisUz'
        buttonSelect.type = 'button'
        
        buttonSelect.setAttribute('aria-expanded','false')  

        divSelect1.appendChild(textarea)
        divSelect1.appendChild(buttonSelect)

        divMainGroup.appendChild(divSelect1)  
    
    if(state_value == false){
        $.ajax({
            url: "modules/vid_profile_oz/getOzForAddVidProfileNotIn.php",
            method: "GET",
            data: {}
        })
            .done(function (response) {
                for (let i of JSON.parse(response)){
                    data.push(i);    
                }
       
    
                let ulSelect = document.createElement('ul');
                ulSelect.classList = 'dropdown-menu'
                ulSelect.style="max-height: 300px; overflow: scroll;"
    
    
                if(data.length > 0){
                   data.map((item) => {
                       let liSelect = document.createElement('li');
    
                       let divLiMain = document.createElement('div');
                       divLiMain.classList = 'd-flex ml-2 mr-2 mb-2 uzNameStyle'
                       divLiMain.style="max-height: 300px;overflow: auto;"
                       divLiMain.id = item['id_uz']
    
                       let divLi = document.createElement('div');
                       divLi.classList = 'd-flex uzName'
                       divLi.id=item['id_uz']
    
                       let divName = document.createElement('div');
                       divName.style="line-height: normal; cursor: pointer;min-width: 200px"
                       divName.id='id_uz_'+item['id_uz']
                       divName.onclick=()=>ReportCheckedUz(item['id_uz'])
                       divName.textContent = item['username']
    
                       divLi.appendChild(divName)
                       divLiMain.appendChild(divLi)
                       liSelect.appendChild(divLiMain)
                       ulSelect.appendChild(liSelect)
    
                   })
               }
    
                
    
                    divMainGroup.appendChild(ulSelect)                 
            });
    }  
    
    if(state_value == true){
        buttonSelect.disabled = true
        let uz_name = document.getElementById(`uz_name_${id_uz}`).textContent
        textarea.value = uz_name;     
    } 

        return divMainGroup

}


 function prepereVidOz(state_value,id_vid_str){
    let data = new Array();


    let div = document.createElement('div');
    div.classList ="mb-2 row mr-2 ml-2 mt-3" 

    let divSpan = document.createElement('div');
    divSpan.textContent = 'Выберите ВИД ОЗ'

    let div2 = document.createElement('div');
    div2.classList ="row ml-3" 

    let col1 = document.createElement('div');
    col1.classList ="col" 

    let col2 = document.createElement('div');
    col2.classList ="col" 

    
    div2.appendChild(col2)
    div2.appendChild(col1)

    div.appendChild(divSpan)
    div.appendChild(div2)

    $.ajax({
        url: "modules/vid_profile_oz/getVidOz.php",
        method: "GET",
        data: {}
    })
        .done(function (response) {
            for (let i of JSON.parse(response)){
                data.push(i);    
            }

           

            if(data.length > 0){
               data.map((item, index) => {
                    

                    let divCheckVid = document.createElement('div');
                    divCheckVid.classList ="d-flex vidUz mb-3" 
                    divCheckVid.id=item['id_types_tables']

                    
                    

                    let inputCheckVid = document.createElement('input');
                    inputCheckVid.type = "checkbox" 
                    inputCheckVid.style="vertical-align: top; margin-right: 0.5rem;" 
                    inputCheckVid.id="checkbox_id_vid_"+item['id_types_tables']  
                    inputCheckVid.onclick=()=>CheckCheckBoxElement(`checkbox`,'id_vid_'+item['id_types_tables'])   

                    if(state_value == true){
                        let idx = id_vid_str.filter(elem =>  elem == item['id_types_tables']) 
                        if(idx[0]){
                            inputCheckVid.checked = true
                            
                        } 
                        
                    }
                    
                    let spanCheckVid = document.createElement('div');
                    spanCheckVid.style="line-height: normal; cursor: pointer;max-width: 300px" 
                    spanCheckVid.id="span_id_vid_"+item['id_types_tables']  
                    spanCheckVid.textContent = item['name']
                    spanCheckVid.onclick=()=>CheckCheckBoxElement(`span`,'id_vid_'+item['id_types_tables'])   

                  //  ()=>ReportCheckedUz(item['id_uz'])
                    divCheckVid.appendChild(inputCheckVid)
                    divCheckVid.appendChild(spanCheckVid)
                    
                    if(data.length/2 > index ) {
                      //  col1
                        col2.appendChild(divCheckVid)
                    } else {
                        
                        col1.appendChild(divCheckVid)
                    }
                    
                  //  div2.appendChild(divCheckVid)
                   
                    
            //    div2.appendChild(divCheckVid)
                            
               })
           }

         
        });

        return div

}


 function prepereProfileOz(state_value,id_profile_str){
    let data = new Array();


    let div = document.createElement('div');
    div.classList ="m-2" 

    let divSpan = document.createElement('div');
    divSpan.textContent = 'Выберите ПРОФИЛЬ ОЗ'

   // div.appendChild(divSpan)

    let div2 = document.createElement('div');
    div2.classList ="row ml-3" 

    let col1 = document.createElement('div');
    col1.classList ="col" 
    col1.id='col1'

    let col2 = document.createElement('div');
    col2.classList ="col" 
    col2.id='col2'

    let col3 = document.createElement('div');
    col3.classList ="col" 
    col3.id='col3'
   
    div2.appendChild(col1)
    div2.appendChild(col2)
    div2.appendChild(col3)
   
    div.appendChild(divSpan)
    div.appendChild(div2)


    $.ajax({
        url: "modules/vid_profile_oz/getProfileOz.php",
        method: "GET",
        data: {}
    })
        .done(function (response) {
            for (let i of JSON.parse(response)){
                data.push(i);    
            }

            if(data.length > 0){
               data.map((item, index) => {
                    let divCheckVid = document.createElement('div');
                    divCheckVid.classList ="d-flex profileUz mb-2" 
                    divCheckVid.id=item['id_profile']

                    let inputCheckVid = document.createElement('input');
                    inputCheckVid.type = "checkbox" 
                    inputCheckVid.style="vertical-align: top; margin-right: 0.5rem;" 
                    inputCheckVid.id="checkbox_id_profile_"+item['id_profile']  
                    inputCheckVid.onclick=()=>CheckCheckBoxElement(`checkbox`,'id_profile_'+item['id_profile'])   

                    if(state_value == true){
                        let idx = id_profile_str.filter(elem =>  elem == item['id_profile']) 
                        if(idx[0]){
                            inputCheckVid.checked = true
                            
                        } 
                        
                    }
                    
                    let spanCheckVid = document.createElement('div');
                    spanCheckVid.style="line-height: normal; cursor: pointer;min-width: 250px" 
                    spanCheckVid.id="span_id_profile_"+item['id_profile']  
                    spanCheckVid.textContent = item['profile_name']
                    spanCheckVid.onclick=()=>CheckCheckBoxElement(`span`,'id_profile_'+item['id_profile']) 
              //      onclick="CheckCheckBoxElement(`span`,'oblast_<?= $app['id_oblast']?>', 'divOblastStr', 'oblast')"   

                    divCheckVid.appendChild(inputCheckVid)
                    divCheckVid.appendChild(spanCheckVid)

                    if(index < (data.length/3)){
                        col1.appendChild(divCheckVid)
                    } else {
                        if(index < (data.length - (data.length/3))) {
                            col2.appendChild(divCheckVid)
                        } else {
                            col3.appendChild(divCheckVid)
                        }
                        
                    }
                   
                            
               })
           }

         
        });

        return div

}


function CheckCheckBoxElement(elem, element_name){
    let checkBox = document.getElementById(`checkbox_${element_name}`);
    if(elem != 'checkbox'){
        checkBox.checked = !checkBox.checked;
       
    }   
   // ReportCheckedOblast(name_el_for_str, name_class_for_search)
}


function returnCheckedId(classElemName, eleNameSearch){
    arrId = [];

    let mainElem = document.getElementsByClassName(`${classElemName}`);
        if (mainElem.length !== 0) {
            for (let i = 0; i < mainElem.length; i++) {                       
                let checkBox = document.getElementById(`checkbox_id_${eleNameSearch}_${mainElem[i].id}`);
                
                if(checkBox.checked){
                    arrId = [...arrId, mainElem[i].id];
                }
                
            }
        }

    return  arrId;
}



  let checkedOzId= 0;


 function ReportCheckedUz(id_uz){
    checkedOzId = id_uz;

     // console.log('ReportCheckedUz')
    let divUzStr = document.getElementById(`divUzStr`);
    let checkedUzName = document.getElementById(`id_uz_${id_uz}`); 
    divUzStr.value = checkedUzName.textContent.trim();
  

    let usBgColor = document.getElementsByClassName(`uzNameStyle`);
        if (usBgColor.length !== 0) {
            for (let i = 0; i < usBgColor.length; i++) {   
                if( usBgColor[i].id == id_uz) {
                    usBgColor[i].style.backgroundColor = 'deepskyblue'
                } else {
                    usBgColor[i].style.backgroundColor = 'white'
                }                    
               
                
            }
        } 
    
      
  }

  function deleteVidProfileOz(id_uz_vid_profile, id_uz){


   
    if (confirm("Запись будет удалена. Удалить?")) {
        $.ajax({
            url: "modules/vid_profile_oz/deleteVidProfileOz.php",
            method: "GET",
            data: {id_uz_vid_profile: id_uz_vid_profile, id_uz:id_uz}

        })
            .done(function (response) {
             //   alert("Пользователь удален.");
                createTable()
             //   location.href = "/index.php?myusers";
            })
    }

  }


  function updateVidProfileOz(id_uz_vid_profile, id_uz, id_vid_str, id_profile_str){

     checkedOzId = id_uz;
     prepereOzForSchedule(true, id_uz_vid_profile, id_uz, id_vid_str, id_profile_str)

  }


  function checkedIdForElCheckBox(classElemName, eleNameSearch, id_str){
    let mainElem = document.getElementsByClassName(`${classElemName}`);

    console.log(mainElem.length, '  checkedIdForElCheckBox')


        if (mainElem.length !== 0) {
            for (let i = 0; i < mainElem.length; i++) {                       
                let checkBox = document.getElementById(`checkbox_id_${eleNameSearch}_${mainElem[i].id}`);
                let idx =  id_str.indexOf(`mainElem[i].id`) != -1;

                console.log(idx)
                console.log(checkBox)

                if(idx == true){
                    checkBox.checked = true;
                }
                
            }
        }

}

  function createTable(){
    let divForTable = document.getElementById("divForTable")
    divForTable.innerHTML = '';
    $.ajax({
        url: "modules/vid_profile_oz/getTableOz.php",
        method: "GET",
        data: {}
    }).catch(function (xhr, status, error) {
        console.log("fail");
    }).then((response) => {
        
      
        divForTable.insertAdjacentHTML("afterbegin", response);

    })
  }

 
 function AddOz(){
    if(checkedOzId == 0){
        alert(`Выберите Организацию зравоохранения`)
        return;
    }
    
    let idVidStr = returnCheckedId('vidUz', 'vid')
    if(idVidStr.length == 0){
        alert(`Выберите ТИП`)
        return;
    }
   
     let idProfileStr = returnCheckedId('profileUz', 'profile')
    // if(idProfileStr.length == 0){
    //     alert(`Выберите Профиль`)
    //     return;
    // }


    $.ajax({
        url: "modules/vid_profile_oz/setInsertVidProfileOz.php",
        method: "POST",
        data: {id_uz: checkedOzId, idProfileStr: idProfileStr.toString(), idVidStr: idVidStr.toString()}
    })
        .done(function (response) {
            let spisOz  = document.getElementById('spisOz')
            spisOz.remove()

            let divSelect = document.getElementById('divSelect')

            let spisOzAjax = prepereOz(false, 0)
            divSelect.insertAdjacentElement('afterBegin',spisOzAjax)            
         //   document.getElementById(`id_schedule_${id_schedule}`).value = '';
        });

 }

 function UpdateOz(id_uz_vid_profile){
    if(checkedOzId == 0){
        alert(`Выберите Организацию зравоохранения`)
        return;
    }
    
    let idVidStr = returnCheckedId('vidUz', 'vid')
    if(idVidStr.length == 0){
        alert(`Выберите ТИП`)
        return;
    }
     let idProfileStr = returnCheckedId('profileUz', 'profile')
    // if(idProfileStr.length == 0){
    //     alert(`Выберите Профиль`)
    //     return;
    // }


    $.ajax({
        url: "modules/vid_profile_oz/setUpdateVidProfileOz.php",
        method: "POST",
        data: {id_uz_vid_profile: id_uz_vid_profile, idProfileStr: idProfileStr.toString(), idVidStr: idVidStr.toString(), id_uz: checkedOzId}
    })
        .done(function (response) {
            alert(`Данные обновлены`)     
         //   document.getElementById(`id_schedule_${id_schedule}`).value = '';
        });

 }

 