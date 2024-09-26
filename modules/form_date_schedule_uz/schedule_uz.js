function showOZ(){
    
    let yearSchedule = document.getElementById(`year_schedule`);

    if(!yearSchedule.value) {
        alert(`Неверно заполнено поле Год подачи заявления по графику `)
        return;
    }

    cteateTable(yearSchedule.value)
}


function cteateTable(year_value){
    let data = new Array();

    let  table = document.createElement('table');
        table.id="example";
        table.className = "table table-striped table-bordered";
        
        let  thead = document.createElement('thead');

	let  th_num = document.createElement('th');
        th_num.innerHTML = '№ п/п';

        let  th = document.createElement('th');
        th.innerHTML = 'Организация озравоохранения';

        let  th1 = document.createElement('th');
        th1.innerHTML = 'Дата по графику';

        let  th2 = document.createElement('th');
       // th2.innerHTML = 'Очистить поле даты';

       let  th3 = document.createElement('th');
        
	thead.appendChild(th_num)
        thead.appendChild(th)
        thead.appendChild(th1)
        thead.appendChild(th2)
        thead.appendChild(th3)
        
        table.appendChild(thead)
        
              
        let tbody = document.createElement('tbody');
        table.appendChild(tbody);


    $.ajax({
        url: "modules/form_date_schedule_uz/getAllScheduleOz.php",
        method: "GET",
        data: { year: year_value }
        
    }).done(function (response){
        for (let i of JSON.parse(response)){
            data.push(i);

            
        }

      //  console.log(JSON.parse(response))
     // console.log(data)
        

        if(data.length > 0){
            data.map((item,index) => {

                let tr = document.createElement('tr');
                tr.id = 'tr_schedule_'+item['id_schedule']
               // tr.style.cursor="pointer"

		let td_num = document.createElement('td');
                td_num.innerHTML = index +1 ;
                

                let td1 = document.createElement('td');
                td1.innerHTML = item['username'];
                td1.className='td1'
              //  td1.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";
                
                let td2 = document.createElement('td');
                //td2.innerHTML = item['schedule_date'];

                    let div = document.createElement('div');
                    div.className = "form-group mr-3 mb-0"
                    div.style="display: inline-flex;"

                    let input = document.createElement('input');
                    input.type = "date" 
                    input.className = "form-control"
                    input.id = 'id_schedule_'+item['id_schedule'];
                    input.value =item['schedule_date'];
                    input.style="font-size: 1rem;"
                    input.onblur  = (e) => {
                        saveDateScheduleForOz(item['id_schedule'], e.target.value)
                    }

                    div.appendChild(input)
                    td2.appendChild(div)

                let td3 = document.createElement('td'); 
                    let div1 = document.createElement('div');
                    div1.className = "form-group mr-3 mb-0"
                    div1.style="display: inline-flex; justify-content: center;"

                    let button = document.createElement('button');
                    button.type="button" 
                    button.classList="btn  btn-danger btn-close" 
                    button.textContent= 'Очистить поле даты'
                    button.onclick = ()=>{
                        clearDateScheduleForOz(item['id_schedule'])
                    }

                    div1.appendChild(button);
                    td3.appendChild(div1)


                let td4 = document.createElement('td'); 
                    let div2 = document.createElement('div');
                    div2.className = "form-group mr-3 mb-0"
                    div2.style="display: inline-flex; justify-content: center;"

                    let buttonDel = document.createElement('button');
                    buttonDel.type="button" 
                    buttonDel.classList="btn  btn-danger btn-close" 
                    buttonDel.textContent= 'Удалить из графика'
                    buttonDel.onclick = ()=>{
                        deleteOzFromSchedule(item['id_schedule'])
                    }

                    div2.appendChild(buttonDel);
                    td4.appendChild(div2)    


		tr.appendChild(td_num);
                tr.appendChild(td1);
                tr.appendChild(td2);
                tr.appendChild(td3);
                tr.appendChild(td4);
                
                tbody.appendChild(tr);

            })
       } 


    })


  //  console.log(table)

    let divBtnAddOZ = document.createElement('div');

    let buttonAdd = document.createElement('button');
    buttonAdd.type="button" 
    buttonAdd.classList="btn btn-success btn-fw mb-2" 
    buttonAdd.textContent= 'Добавить организацию в список'
    buttonAdd.onclick = ()=>{
          //  clearDateScheduleForOz(item['id_schedule'])
          showModalAddScheduleDateOz(year_value)
        }

    divBtnAddOZ.appendChild(buttonAdd);


    let divSpis = document.createElement('div');
    divSpis.id='childTableScheduleOZ'


    let tableScheduleOZ = document.getElementById(`tableScheduleOZ`);

    divSpis.appendChild(divBtnAddOZ);
    divSpis.appendChild(table);
    tableScheduleOZ.appendChild(divSpis);


    
}


function saveDateScheduleForOz(id_schedule, date_value){
    
    let schedule_date=  new Date(date_value)
    

    if(schedule_date === NaN){
      //  alert(`Неверный формат даты`)
        return;
    } 

    let dateNow = new Date()

    if(schedule_date.getFullYear() < dateNow.getFullYear()){
          alert(`Год по графику не может быть меньше текущего`)
          return;
    } 

  
    $.ajax({
        url: "modules/form_date_schedule_uz/setScheduleDateOz.php",
        method: "POST",
        data: {id_schedule: id_schedule, schedule_date: date_value}
    })
        .done(function (response) {
       //     let yearSchedule = document.getElementById(`year_schedule`);
      //      cteateTable(yearSchedule.value)
        });


}

function clearDateScheduleForOz(id_schedule){
    
    $.ajax({
        url: "modules/form_date_schedule_uz/setClearDateSchedule.php",
        method: "POST",
        data: {id_schedule: id_schedule}
    })
        .done(function (response) {
            document.getElementById(`id_schedule_${id_schedule}`).value = '';
        });


}

function deleteOzFromSchedule(id_schedule){
    
    $.ajax({
        url: "modules/form_date_schedule_uz/deleteOzFromSchedule.php",
        method: "GET",
        data: {id_schedule: id_schedule}
    })
        .done(function (response) {
           document.getElementById(`tr_schedule_${id_schedule}`).remove();
        });


}





function showModalAddScheduleDateOz(date_schedule){
   let  modalAddScheduleDateOz = document.getElementById('modalAddScheduleDateOz')
   modalAddScheduleDateOz.classList.add('show'); 

   prepereOzForSchedule(date_schedule)
}


function hideModalAddScheduleDateOz(){
   let  modalAddScheduleDateOz = document.getElementById('modalAddScheduleDateOz')
   modalAddScheduleDateOz.classList.remove("show");

   let  modalScheduleBody = document.getElementById('modalScheduleBody')
   let  divSelect = document.getElementById('divSelect')
        modalScheduleBody.removeChild(divSelect)

   
    let yearSchedule = document.getElementById(`year_schedule`);  
    
    let tableScheduleOZ = document.getElementById(`tableScheduleOZ`);
    let childTableScheduleOZ = document.getElementById(`childTableScheduleOZ`);
    tableScheduleOZ.removeChild(childTableScheduleOZ)

    

    cteateTable(yearSchedule.value)
}


function prepereOzForSchedule(year_value){
    let data = new Array();

    let divSelect = document.createElement('div');
            divSelect.classList = ' mb-2'
            divSelect.style="font-size: 1rem; line-height: 3rem;"
            divSelect.id='divSelect'


    $.ajax({
        url: "modules/form_date_schedule_uz/getOzForScheduleNotIn.php",
        method: "GET",
        data: {year: year_value}
    })
        .done(function (response) {
            for (let i of JSON.parse(response)){
                data.push(i);    
            }

            


            let span = document.createElement('span');
            span.classList = ' mr-2'
            span.innerText = 'Выберите ОЗ'

            let select = document.createElement('select');
            select.id='SpisOz'
            select.classList = ' form-select-my'

            let option1 = document.createElement('option');
            option1.value = '0'
            option1.textContent = 'Выберите ОЗ'

            select.appendChild(option1);

          //  divSelect.appendChild(span);
            divSelect.appendChild(select);

                if(data.length > 0){
                    data.map((item) => {

                        let option = document.createElement('option');
                        option.value = item['id_uz']
                        option.textContent = item['username']
                        
                        select.appendChild(option);

                    })
                } 


                let button = document.createElement('button');
                button.classList = ' btn btn-success btn-fw ml-2'
                button.id="btnAddOzSchedule"
                button.onclick=()=>AddOz(year_value) 
                button.innerText = 'Добавить в список ОЗ'               
                                  
                


                let div = document.createElement('div');
                div.className = "form-group mr-2 mb-0 ml-2"
                div.style="display: inline-flex;"

                let input = document.createElement('input');
                input.type = "date" 
                input.className = "form-control"
                input.id = 'add_schedule_date';
            //    input.value =item['schedule_date'];
                input.style="font-size: 1rem;"
                
                div.appendChild(input)    
            
                divSelect.appendChild(div);

                divSelect.appendChild(button);
        });


        

        let  modalScheduleBody = document.getElementById('modalScheduleBody')
        modalScheduleBody.appendChild(divSelect)

/*
        
        */
}

function AddOz(year_value){

    let SpisOz = document.getElementById(`SpisOz`);
    let SpisOz_value = SpisOz.value;

    if(SpisOz_value == '0'){
        alert(`Выберите Организацию зравоохранения`)
        return;
    }

    

    let date_value = document.getElementById(`add_schedule_date`).value;

    let schedule_date=  new Date(date_value)
    
 //   console.log(schedule_date)
    
    if((schedule_date === NaN)||(date_value == '')){
        alert(`Дата не может быть пустой`)
        return;
    } 

    let dateNow = new Date()

    if(schedule_date.getFullYear() < dateNow.getFullYear()){
          alert(`Год по графику не может быть меньше текущего`)
          return;
    } 


    console.log(SpisOz_value, year_value,  date_value)

    $.ajax({
        url: "modules/form_date_schedule_uz/setOzInSchedule.php",
        method: "POST",
        data: {id_uz: SpisOz_value, year: year_value, schedule_date: date_value}
    })
        .done(function (response) {
         //   document.getElementById(`id_schedule_${id_schedule}`).value = '';
        });

    let  modalScheduleBody = document.getElementById('modalScheduleBody')
    let  divSelect = document.getElementById('divSelect')
         modalScheduleBody.removeChild(divSelect)

    prepereOzForSchedule(year_value)    

}



