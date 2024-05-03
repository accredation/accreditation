
function CheckMultiElement(elem, element_name, name_el_for_str, name_class_for_search){

    let checkBox = document.getElementById(`checkbox_id_${element_name}`);

    if(elem != 'checkBox'){
        
        checkBox.checked = !checkBox.checked;
    }
    
    ReportCheckedOblast(name_el_for_str, name_class_for_search)
}


function ReportCheckedOblast(name_el_for_str, name_class_for_search, report_key_value = false){
    arrOblastId_journal_rkk = [];
    arrOblastSTR_journal_rkk = [];

    let oblast = document.getElementsByClassName(`${name_class_for_search}`);
        if (oblast.length !== 0) {
            for (let i = 0; i < oblast.length; i++) {                       
                let checkBox = document.getElementById(`checkbox_id_${name_class_for_search}_${oblast[i].id}`);
                
                if(checkBox.checked){
                    arrOblastId_journal_rkk = [...arrOblastId_journal_rkk, oblast[i].id];

                    let spanCheckBox = document.getElementById(`span_id_${name_class_for_search}_${oblast[i].id}`).innerText.trim();
                    arrOblastSTR_journal_rkk = [...arrOblastSTR_journal_rkk, spanCheckBox ]
                }
                
            }
        } 
    
        let divElementStr = document.getElementById(`${name_el_for_str}`);
        if(arrOblastSTR_journal_rkk.toString() == ''){
            divElementStr.value = 'Все';
        } else {
            divElementStr.value = arrOblastSTR_journal_rkk.toString();
        }


        
      ////  Передать в обьект по ключу name_class_for_search == область, тип, статус

    if (report_key_value != false){
        return [arrOblastId_journal_rkk, arrOblastSTR_journal_rkk.toString()]
    }

    
}


function CheckTypeReportElement(elem, element_name){
    
    let radio_checked = document.getElementById(`checkbox_type_report_${element_name}`);

    let radio_type_report = document.getElementById(`radio_type_report`);
    let type_report_ = radio_type_report.getElementsByTagName('input');

    for (let i = 1; i <= type_report_.length ; i++) {
        let radio = document.getElementById(`checkbox_type_report_`+i);
        if((radio.checked)&&(i !== element_name)){
            radio.checked = false
        } 
        
    }
    
    let day1 = document.getElementById('day1');
    let day2 = document.getElementById('day2');
    let day3 = document.getElementById('day3');
    let day4 = document.getElementById('day4');
    let day5 = document.getElementById('day5');
    let day6 = document.getElementById('day6');
    let day7 = document.getElementById('day7');
    radio_checked.checked = true

    switch (element_name) {
        case "1":

            if(day1.hasAttribute('hidden')){
                day1.removeAttribute('hidden')
            }
            
            if(!day2.hasAttribute('hidden')){
                day2.setAttribute('hidden', 'true')
            }

            if(!day3.hasAttribute('hidden')){
                day3.setAttribute('hidden', 'true')
            }

            if(!day4.hasAttribute('hidden')){
                day4.setAttribute('hidden', 'true')
            }

            if(!day5.hasAttribute('hidden')){
                day5.setAttribute('hidden', 'true')
            }

            if(!day6.hasAttribute('hidden')){
                day6.setAttribute('hidden', 'true')
            }

            if(!day7.hasAttribute('hidden')){
                day7.setAttribute('hidden', 'true')
            }
           
            break;

        case "2":
            
            if(!day1.hasAttribute('hidden')){
                day1.setAttribute('hidden', 'true')
            }
            
            if(!day2.hasAttribute('hidden')){
                day2.setAttribute('hidden', 'true')
            }

            if(!day3.hasAttribute('hidden')){
                day3.setAttribute('hidden', 'true')
            }

            if(!day4.hasAttribute('hidden')){
                day4.setAttribute('hidden', 'true')
            }

            if(!day5.hasAttribute('hidden')){
                day5.setAttribute('hidden', 'true')
            }

            if(!day6.hasAttribute('hidden')){
                day6.setAttribute('hidden', 'true')
            }

            if(!day7.hasAttribute('hidden')){
                day7.setAttribute('hidden', 'true')
            }
           
            break;

        case "3":
            if(day7.hasAttribute('hidden')){
                day7.removeAttribute('hidden')
            }
            
            if(!day1.hasAttribute('hidden')){
                day1.setAttribute('hidden', 'true')
            }

            if(!day2.hasAttribute('hidden')){
                day2.setAttribute('hidden', 'true')
            }

            if(!day3.hasAttribute('hidden')){
                day3.setAttribute('hidden', 'true')
            }

            if(!day4.hasAttribute('hidden')){
                day4.setAttribute('hidden', 'true')
            }

            if(!day5.hasAttribute('hidden')){
                day5.setAttribute('hidden', 'true')
            }

            if(!day6.hasAttribute('hidden')){
                day6.setAttribute('hidden', 'true')
            }
            break;

        case "4":
            if(day3.hasAttribute('hidden')){
                day3.removeAttribute('hidden')
            }
            
            if(!day1.hasAttribute('hidden')){
                day1.setAttribute('hidden', 'true')
            }

            if(!day2.hasAttribute('hidden')){
                day2.setAttribute('hidden', 'true')
            }

            if(!day4.hasAttribute('hidden')){
                day4.setAttribute('hidden', 'true')
            }

            if(!day5.hasAttribute('hidden')){
                day5.setAttribute('hidden', 'true')
            }

            if(!day6.hasAttribute('hidden')){
                day6.setAttribute('hidden', 'true')
            }

            if(!day7.hasAttribute('hidden')){
                day7.setAttribute('hidden', 'true')
            }
           

            break;
        case "5":
            if(day4.hasAttribute('hidden')){
                day4.removeAttribute('hidden')
            }
            
            if(!day1.hasAttribute('hidden')){
                day1.setAttribute('hidden', 'true')
            }

            if(!day2.hasAttribute('hidden')){
                day2.setAttribute('hidden', 'true')
            }

            if(!day3.hasAttribute('hidden')){
                day3.setAttribute('hidden', 'true')
            }

            if(!day5.hasAttribute('hidden')){
                day5.setAttribute('hidden', 'true')
            }

            if(!day6.hasAttribute('hidden')){
                day6.setAttribute('hidden', 'true')
            }

            if(!day7.hasAttribute('hidden')){
                day7.setAttribute('hidden', 'true')
            }
           
            break;    

        case "6":
            if(day5.hasAttribute('hidden')){
                day5.removeAttribute('hidden')
            }
            
            if(!day1.hasAttribute('hidden')){
                day1.setAttribute('hidden', 'true')
            }

            if(!day2.hasAttribute('hidden')){
                day2.setAttribute('hidden', 'true')
            }

            if(!day3.hasAttribute('hidden')){
                day3.setAttribute('hidden', 'true')
            }

            if(!day4.hasAttribute('hidden')){
                day4.setAttribute('hidden', 'true')
            }

            if(!day6.hasAttribute('hidden')){
                day6.setAttribute('hidden', 'true')
            }

            if(!day7.hasAttribute('hidden')){
                day7.setAttribute('hidden', 'true')
            }
           
            break;  
            
        case "7":
            if(day6.hasAttribute('hidden')){
                day6.removeAttribute('hidden')
            }
            
            if(!day1.hasAttribute('hidden')){
                day1.setAttribute('hidden', 'true')
            }

            if(!day2.hasAttribute('hidden')){
                day2.setAttribute('hidden', 'true')
            }

            if(!day3.hasAttribute('hidden')){
                day3.setAttribute('hidden', 'true')
            }

            if(!day4.hasAttribute('hidden')){
                day4.setAttribute('hidden', 'true')
            }

            if(!day5.hasAttribute('hidden')){
                day5.setAttribute('hidden', 'true')
            }

            if(!day7.hasAttribute('hidden')){
                day7.setAttribute('hidden', 'true')
            }
           
            
            break;    
    }

}

function CheckCheckBoxElement(elem, element_name, ){

    let checkBox = document.getElementById(`checkbox_${element_name}`);

    if(elem != 'checkBox'){
        
        checkBox.checked = !checkBox.checked;
    }

}


function validateDate(date_at, date_to, date_name){
    
    let div_date_name = document.getElementById(date_name).innerText;
  
    if((date_at && !date_to) || (!date_at && date_to)){
        alert(`Неверно заполнено поле ${div_date_name}`)
        return -1
    } else {
        if(date_at>date_to) {
            alert(`Неверно заполнено поле ${div_date_name}`)
            return -1
        } else {
            if(date_at && date_to){
                return 1
            } else {
                alert(`Неверно заполнено поле ${div_date_name}`)
                return -1
            }
        }
    }
   
}



function preperaReport(){

    let dataParametrs = {

        datePeriod_at : '',
        datePeriod_to : '',

        year_schedule: 0, 

        OblastStr : '',
        OblastsId : '',

        guzo : 0,
        checkbox_guzo_1 :false,
        checkbox_guzo_2 : false,

        checkbox_pervtor_1: false,
        checkbox_pervtor_2: false,
        pervtor: 0,

        otz : false,
        otkaz : false,

        type_report: 0,

        count_day_proh: 0,
        count_day_cge: 0,
        count_day_proc: 0,
        count_day_uved: 0,
        count_day_plan:0,
        count_day_app: 0,
        count_day_complite:0,
    }


    let reportRow = document.getElementById('reportRow');
    reportRow.style="background-color: white";

    let datePeriod_at = document.getElementById(`datePeriod_at`).value;
    dataParametrs.datePeriod_at = datePeriod_at;

    let datePeriod_to = document.getElementById(`datePeriod_to`).value;
    dataParametrs.datePeriod_to = datePeriod_to;

    let datePeriod = validateDate(datePeriod_at, datePeriod_to, 'datePeriod')
    if (datePeriod == -1){
        return
    }
   
    let year_schedule = document.getElementById(`year_schedule`).value;
    dataParametrs.year_schedule = year_schedule;


    if((!year_schedule)){
        alert(`Неверно заполнено поле Год подачи заявления по графику`)
        return 
    }



    let oblast= ReportCheckedOblast( 'divOblastStr', 'oblast', 'report_key_value')
    dataParametrs.OblastsId = oblast[0].toString()
    dataParametrs.OblastStr = oblast[1]

   
    let checkbox_guzo_1 = document.getElementById(`checkbox_guzo_1`);
    let checkbox_guzo_1_value = checkbox_guzo_1.checked;
    dataParametrs.checkbox_guzo_1 = checkbox_guzo_1.checked;

    let checkbox_guzo_2 = document.getElementById(`checkbox_guzo_2`);
    let checkbox_guzo_2_value = checkbox_guzo_2.checked;
    dataParametrs.checkbox_guzo_2= checkbox_guzo_2.checked;

    if(checkbox_guzo_2_value || checkbox_guzo_1_value){
        dataParametrs.guzo= 1;
    } else {
        dataParametrs.guzo= 0;  
    }

    let checkbox_pervtor_1 = document.getElementById(`checkbox_pervtor_1`);
    let checkbox_pervtor_1_value = checkbox_pervtor_1.checked;
    dataParametrs.checkbox_pervtor_1 = checkbox_pervtor_1.checked;

    let checkbox_pervtor_2 = document.getElementById(`checkbox_pervtor_2`);
    let checkbox_pervtor_2_value = checkbox_pervtor_2.checked;
    dataParametrs.checkbox_pervtor_2= checkbox_pervtor_2.checked;

    if(checkbox_pervtor_2_value || checkbox_pervtor_1_value){
        dataParametrs.pervtor= 1;
    } else {
        dataParametrs.pervtor= 0;  
    }

    let checkbox_otz = document.getElementById(`checkbox_otz`);
    dataParametrs.otz = checkbox_otz.checked;

    let checkbox_otkaz = document.getElementById(`checkbox_otkaz`);
    dataParametrs.otkaz = checkbox_otkaz.checked;

    let radio_type_report = document.getElementById(`radio_type_report`);
    let type_report_ = radio_type_report.getElementsByTagName('input');

    for (let i = 1; i <= type_report_.length ; i++) {
        let radio = document.getElementById(`checkbox_type_report_`+i);
        if(radio.checked){
            dataParametrs.type_report = i
        } 
        
    }


    let count_day_proh = document.getElementById(`count_day_proh`).value;
    dataParametrs.count_day_proh = count_day_proh;

    let count_day_cge = document.getElementById(`count_day_cge`).value;
    dataParametrs.count_day_cge = count_day_cge;

    let count_day_proc = document.getElementById(`count_day_proc`).value;
    dataParametrs.count_day_proc = count_day_proc;

    let count_day_uved = document.getElementById(`count_day_uved`).value;
    dataParametrs.count_day_uved = count_day_uved;

    let count_day_plan = document.getElementById(`count_day_plan`).value;
    dataParametrs.count_day_plan = count_day_plan;

    let count_day_app = document.getElementById(`count_day_app`).value;
    dataParametrs.count_day_app = count_day_app;

    let count_day_complite = document.getElementById(`count_day_complite`).value;
    dataParametrs.count_day_complite = count_day_complite;
    

    let btnReportPrint = document.getElementById(`btnReportPrint`);
    btnReportPrint.removeAttribute('disabled')

    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';


  //  console.log(dataParametrs)

    // if(flag_yur_lica_value){
    //     reportYurLica(dataParametrs)
        
    // } else {
    //     reportWithOutYurLica(dataParametrs)
    // }

    if(dataParametrs.type_report == 1 ){
        reportReportGraf(dataParametrs)
    } 
    if(dataParametrs.type_report == 2 ){
        reportReportNoSendRkk(dataParametrs)
    } 


    if(dataParametrs.type_report == 3 ){
        reportReportNoOcenka(dataParametrs)
    }

    if(dataParametrs.type_report == 4 ){
        reportReportNoResh(dataParametrs)
    }

    if(dataParametrs.type_report == 5 ){
        reportReportNoAdmin(dataParametrs)
    }

    if(dataParametrs.type_report == 6 ){
        reportReportNoPlan(dataParametrs)
    }

    if(dataParametrs.type_report == 7 ){
        reportReportNoApp(dataParametrs)
    }



    btnReport.removeAttribute('disabled');
}


function prepereTableReport(){

    let table = document.createElement('table');
    table.id="printMe"
   
    table.style = "border-spacing: 0; border: none";

    let thead1 = document.createElement('thead');

    let trHead = document.createElement('tr');

    let th1 = document.createElement('th');
    th1.innerHTML = '№ заявления по РКК';
    th1.id='th1'
    th1.style = "border: 1px solid black; text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"

    let th2 = document.createElement('th');
    th2.innerHTML = 'Наименование Юр. Лицо';
    th2.id='th2'
    th2.style = "border: 1px solid black; text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"

    let th3 = document.createElement('th');
    th3.innerHTML = 'Дата создания заявления';
    th3.id='th3'
    th3.style = "border: 1px solid black; min-width: 120px; text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"
    
    let th4 = document.createElement('th');
    th4.innerHTML = 'первичное/повторное';
    th4.id='th4'
    th4.style = "border: 1px solid black; min-width: 150px; text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"

    let th5 = document.createElement('th');
    th5.innerHTML = 'Статус заявления';
    th5.id='th5'
    th5.style = "border: 1px solid black; text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"


    let th6 = document.createElement('th');
    th6.innerHTML = 'Дата регистрации заявления';
    th6.id='th6'
    th6.style = "border: 1px solid black; min-width: 120px;text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"
    
    let th7 = document.createElement('th');
    th7.innerHTML = 'Дата по графику';
    th7.id='th7'
    th7.style = "border: 1px solid black; min-width: 120px;text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"
    
    let th8 = document.createElement('th');
    th8.innerHTML = 'Заключение ЦГЭ';
    th8.id='th8'
    th8.style = "border: 1px solid black; min-width: 200px; text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"
    
    let th9 = document.createElement('th');
    th9.innerHTML = 'Завершение оценки';
    th9.id='th9'
    th9.style = "border: 1px solid black; text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"  

    let th10 = document.createElement('th');
    th10.innerHTML = 'Дата протокола';
    th10.id='th10'
    th10.style = "border: 1px solid black; min-width: 120px;text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"

    let th11 = document.createElement('th');
    th11.innerHTML = 'Уведомление';
    th11.id='th11'
    th11.style = "border: 1px solid black; text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"
   
    let th12 = document.createElement('th');
    th12.innerHTML = 'Повторная подача';
    th12.id='th12'
    th12.style = "border: 1px solid black; text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"


    trHead.appendChild(th1);
    trHead.appendChild(th2);
    trHead.appendChild(th3);
    trHead.appendChild(th4);
    trHead.appendChild(th5);
    trHead.appendChild(th6);
    trHead.appendChild(th7);
    trHead.appendChild(th8);
    trHead.appendChild(th9);
    trHead.appendChild(th10);
    trHead.appendChild(th11);
    trHead.appendChild(th12);

    thead1.appendChild(trHead);
    table.appendChild(thead1);

    return table
}

function reportReportGraf(dataParametrs){

    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';

    let divTableStr = document.createElement('div');
        divTableStr.id = 'divTableStr'
        divTableStr.innerHTML = 'Ожидайте загрузки данных';
    
    let divTable = document.createElement('div');
        divTable.id = 'divTable'
    let butnJournal = document.getElementById('butnJournal');
            
    let contentWidth = butnJournal.clientWidth - 32;
            
        divTable.style = `overflow-x:auto; max-width: ${contentWidth}px;overflow-block: visible; max-height: 600px;`;
     //   divTable.innerHTML = 'Ожидайте загрузки данных';
 
    let table =  prepereTableReport(); 

    let data = new Array();


    $.ajax({
        url: "modules/report/report_date_schedule/getReportGrafic.php",
        method: "GET",
        data: {
            datePeriod_at : dataParametrs.datePeriod_at,
            datePeriod_to : dataParametrs.datePeriod_to,
    
            year_schedule: dataParametrs.year_schedule, 
    
            OblastStr : dataParametrs.OblastStr,
            OblastsId : dataParametrs.OblastsId,
    
            guzo : dataParametrs.guzo,
            checkbox_guzo_1 :dataParametrs.checkbox_guzo_1,
            checkbox_guzo_2 : dataParametrs.checkbox_guzo_2,
    
            checkbox_pervtor_1: dataParametrs.checkbox_pervtor_1,
            checkbox_pervtor_2: dataParametrs.checkbox_pervtor_2,
            pervtor: dataParametrs.pervtor,
    
            otz : dataParametrs.otz,
            otkaz : dataParametrs.otkaz,
    
            type_report: dataParametrs.type_report,
    
            count_day_proh: dataParametrs.count_day_proh,
            count_day_cge: dataParametrs.count_day_cge,
            count_day_proc: dataParametrs.count_day_proc,
            count_day_uved: dataParametrs.count_day_uved,

        }
        
    }).done(function (response){
        divTableStr.innerHTML ='';
      
        for (let i of JSON.parse(response)){
            data.push(i);
        }
        
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);

         let itogo = 0
           if(data.length > 0){
                data.map((item,index) => {
                    let trStr = document.createElement('tr');

                    let td1 = document.createElement('td');
                    td1.innerHTML =  item['id_rkk'] ;
                    td1.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td2 = document.createElement('td');
                    td2.innerHTML =  item['username'] ;
                    td2.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    
                    let td3 = document.createElement('td');
                    td3.innerHTML =  item['date_create_app'] ;
                    td3.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td4 = document.createElement('td');
                    td4.innerHTML =  item['perv_vtor'] ;
                    td4.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td5 = document.createElement('td');
                    td5.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td5.innerHTML =  item['name_status'] ;

                    let td6 = document.createElement('td');
                    td6.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td6.innerHTML =  item['date_reg'] ;

                    let td7 = document.createElement('td');
                    td7.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td7.innerHTML =  item['schedule_date'] ;

                    let td8 = document.createElement('td');
                    td8.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td8.innerHTML =  item['sootvetstvie'] ;

                    let td9 = document.createElement('td');
                    td9.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td9.innerHTML =  item['adm_reah'] ;

                    let td10 = document.createElement('td');
                    td10.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td10.innerHTML =  item['date_protokol'] ;

                    let td11 = document.createElement('td');
                    td11.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td11.innerHTML =  item['info_uved'] ;

                    let td12 = document.createElement('td');
                    td12.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td12.innerHTML =  item['num_rkk'] ;

                    trStr.appendChild(td1);
                    trStr.appendChild(td2);
                    trStr.appendChild(td3);
                    trStr.appendChild(td4);
                    trStr.appendChild(td5);
                    trStr.appendChild(td6);
                    trStr.appendChild(td7);
                    trStr.appendChild(td8);
                    trStr.appendChild(td9);
                    trStr.appendChild(td10);
                    trStr.appendChild(td11);
                    trStr.appendChild(td12);

                    tbody.appendChild(trStr);
                    itogo ++

                })

                let trStrItog = document.createElement('tr');

                    let td1itog = document.createElement('td');
                    td1itog.innerHTML =  'Итого' ;
                    td1itog.style = "border: 1px solid black;  text-align:left; line-height: normal;";
                    td1itog.setAttribute('colspan', 11)

                    let td2itog = document.createElement('td');
                    td2itog.innerHTML =  itogo ;
                    td2itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";

                    trStrItog.appendChild(td1itog);
                    trStrItog.appendChild(td2itog);
                    tbody.appendChild(trStrItog);

           }else {
                divTable.innerHTML = ' ';
                divTableStr.innerHTML = 'По данным параметрам нет записей';
                
           }  
   
    });

            let divReportTitle = document.createElement('div');
            divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";  
            divReportTitle.textContent = `Контроль сроков подачи заявлений по графику`;
            divReportTitle.id='divReportTitle'
            
            divForTable.appendChild(divReportTitle);
            let reportDivUls = returnReportDivUls(dataParametrs);
            divForTable.appendChild(reportDivUls); 
            divForTable.appendChild(divTableStr);       
            
            divForTable.appendChild(divTable); 
            divTable.appendChild(table);  
}


function reportReportNoSendRkk(dataParametrs){

    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';

    let divTableStr = document.createElement('div');
        divTableStr.id = 'divTableStr'
        divTableStr.innerHTML = 'Ожидайте загрузки данных';
    
    let divTable = document.createElement('div');
        divTable.id = 'divTable'
    let butnJournal = document.getElementById('butnJournal');
            
    let contentWidth = butnJournal.clientWidth - 32;
            
        divTable.style = `overflow-x:auto; max-width: ${contentWidth}px;overflow-block: visible; max-height: 600px;`;
     //   divTable.innerHTML = 'Ожидайте загрузки данных';
 
    let table =  prepereTableReport(); 

    let data = new Array();


    $.ajax({
        url: "modules/report/report_date_schedule/getReportReportNoSendRkk.php",
        method: "GET",
        data: {
            datePeriod_at : dataParametrs.datePeriod_at,
            datePeriod_to : dataParametrs.datePeriod_to,
    
            year_schedule: dataParametrs.year_schedule, 
    
            OblastStr : dataParametrs.OblastStr,
            OblastsId : dataParametrs.OblastsId,
    
            guzo : dataParametrs.guzo,
            checkbox_guzo_1 :dataParametrs.checkbox_guzo_1,
            checkbox_guzo_2 : dataParametrs.checkbox_guzo_2,
    
            checkbox_pervtor_1: dataParametrs.checkbox_pervtor_1,
            checkbox_pervtor_2: dataParametrs.checkbox_pervtor_2,
            pervtor: dataParametrs.pervtor,
    
            otz : dataParametrs.otz,
            otkaz : dataParametrs.otkaz,
    
            type_report: dataParametrs.type_report,
    
            count_day_proh: dataParametrs.count_day_proh,
            count_day_cge: dataParametrs.count_day_cge,
            count_day_proc: dataParametrs.count_day_proc,
            count_day_uved: dataParametrs.count_day_uved,

        }
        
    }).done(function (response){
        divTableStr.innerHTML ='';
      
        for (let i of JSON.parse(response)){
            data.push(i);
        }
        
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);
        let itogo=0
           if(data.length > 0){
                data.map((item,index) => {
                    let trStr = document.createElement('tr');

                    let td1 = document.createElement('td');
                    td1.innerHTML =  item['id_rkk'] ;
                    td1.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td2 = document.createElement('td');
                    td2.innerHTML =  item['username'] ;
                    td2.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    
                    let td3 = document.createElement('td');
                    td3.innerHTML =  item['date_create_app'] ;
                    td3.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td4 = document.createElement('td');
                    td4.innerHTML =  item['perv_vtor'] ;
                    td4.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td5 = document.createElement('td');
                    td5.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td5.innerHTML =  item['name_status'] ;

                    let td6 = document.createElement('td');
                    td6.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td6.innerHTML =  item['date_reg'] ;

                    let td7 = document.createElement('td');
                    td7.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td7.innerHTML =  item['schedule_date'] ;

                    let td8 = document.createElement('td');
                    td8.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td8.innerHTML =  item['sootvetstvie'] ;

                    let td9 = document.createElement('td');
                    td9.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td9.innerHTML =  item['adm_reah'] ;

                    let td10 = document.createElement('td');
                    td10.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td10.innerHTML =  item['date_protokol'] ;

                    let td11 = document.createElement('td');
                    td11.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td11.innerHTML =  item['info_uved'] ;

                    let td12 = document.createElement('td');
                    td12.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td12.innerHTML =  item['num_rkk'] ;



                    trStr.appendChild(td1);
                    trStr.appendChild(td2);
                    trStr.appendChild(td3);
                    trStr.appendChild(td4);
                    trStr.appendChild(td5);
                    trStr.appendChild(td6);
                    trStr.appendChild(td7);
                    trStr.appendChild(td8);
                    trStr.appendChild(td9);
                    trStr.appendChild(td10);
                    trStr.appendChild(td11);
                    trStr.appendChild(td12);

                    tbody.appendChild(trStr);
                    itogo++

                })
                let trStrItog = document.createElement('tr');

                    let td1itog = document.createElement('td');
                    td1itog.innerHTML =  'Итого' ;
                    td1itog.style = "border: 1px solid black;  text-align:left; line-height: normal;";
                    td1itog.setAttribute('colspan', 11)

                    let td2itog = document.createElement('td');
                    td2itog.innerHTML =  itogo ;
                    td2itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";

                    trStrItog.appendChild(td1itog);
                    trStrItog.appendChild(td2itog);
                    tbody.appendChild(trStrItog);

           }else {
                divTable.innerHTML = ' ';
                divTableStr.innerHTML = 'По данным параметрам нет записей';
                
           }  
   
    });

            let divReportTitle = document.createElement('div');
            divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";  
            divReportTitle.textContent = `Контроль сроков подачи заявлений по графику`;
            divReportTitle.id='divReportTitle'
            
            divForTable.appendChild(divReportTitle);
            let reportDivUls = returnReportDivUls(dataParametrs);
            divForTable.appendChild(reportDivUls); 
            divForTable.appendChild(divTableStr);       
            
            divForTable.appendChild(divTable); 
            divTable.appendChild(table);  
}

function reportReportNoCGE(dataParametrs){

    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';

    let divTableStr = document.createElement('div');
        divTableStr.id = 'divTableStr'
        divTableStr.innerHTML = 'Ожидайте загрузки данных';
    
    let divTable = document.createElement('div');
        divTable.id = 'divTable'
    let butnJournal = document.getElementById('butnJournal');
            
    let contentWidth = butnJournal.clientWidth - 32;
            
        divTable.style = `overflow-x:auto; max-width: ${contentWidth}px;overflow-block: visible; max-height: 600px;`;
     //   divTable.innerHTML = 'Ожидайте загрузки данных';
 
    let table =  prepereTableReport(); 

    let data = new Array();


    $.ajax({
        url: "modules/report/report_date_schedule/getReportReportNoSendRkk.php",
        method: "GET",
        data: {
            datePeriod_at : dataParametrs.datePeriod_at,
            datePeriod_to : dataParametrs.datePeriod_to,
    
            year_schedule: dataParametrs.year_schedule, 
    
            OblastStr : dataParametrs.OblastStr,
            OblastsId : dataParametrs.OblastsId,
    
            guzo : dataParametrs.guzo,
            checkbox_guzo_1 :dataParametrs.checkbox_guzo_1,
            checkbox_guzo_2 : dataParametrs.checkbox_guzo_2,
    
            checkbox_pervtor_1: dataParametrs.checkbox_pervtor_1,
            checkbox_pervtor_2: dataParametrs.checkbox_pervtor_2,
            pervtor: dataParametrs.pervtor,
    
            otz : dataParametrs.otz,
            otkaz : dataParametrs.otkaz,
    
            type_report: dataParametrs.type_report,
    
            count_day_proh: dataParametrs.count_day_proh,
            count_day_cge: dataParametrs.count_day_cge,
            count_day_proc: dataParametrs.count_day_proc,
            count_day_uved: dataParametrs.count_day_uved,

        }
        
    }).done(function (response){
        divTableStr.innerHTML ='';
      
        for (let i of JSON.parse(response)){
            data.push(i);
        }
        
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);
        let itogo=0
           if(data.length > 0){
                data.map((item,index) => {
                    let trStr = document.createElement('tr');

                    let td1 = document.createElement('td');
                    td1.innerHTML =  item['id_rkk'] ;
                    td1.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td2 = document.createElement('td');
                    td2.innerHTML =  item['username'] ;
                    td2.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    
                    let td3 = document.createElement('td');
                    td3.innerHTML =  item['date_create_app'] ;
                    td3.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td4 = document.createElement('td');
                    td4.innerHTML =  item['perv_vtor'] ;
                    td4.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td5 = document.createElement('td');
                    td5.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td5.innerHTML =  item['name_status'] ;

                    let td6 = document.createElement('td');
                    td6.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td6.innerHTML =  item['date_reg'] ;

                    let td7 = document.createElement('td');
                    td7.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td7.innerHTML =  item['schedule_date'] ;

                    let td8 = document.createElement('td');
                    td8.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td8.innerHTML =  item['sootvetstvie'] ;

                    let td9 = document.createElement('td');
                    td9.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td9.innerHTML =  item['adm_reah'] ;

                    let td10 = document.createElement('td');
                    td10.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td10.innerHTML =  item['date_protokol'] ;

                    let td11 = document.createElement('td');
                    td11.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td11.innerHTML =  item['info_uved'] ;

                    let td12 = document.createElement('td');
                    td12.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td12.innerHTML =  item['num_rkk'] ;



                    trStr.appendChild(td1);
                    trStr.appendChild(td2);
                    trStr.appendChild(td3);
                    trStr.appendChild(td4);
                    trStr.appendChild(td5);
                    trStr.appendChild(td6);
                    trStr.appendChild(td7);
                    trStr.appendChild(td8);
                    trStr.appendChild(td9);
                    trStr.appendChild(td10);
                    trStr.appendChild(td11);
                    trStr.appendChild(td12);

                    tbody.appendChild(trStr);
                    itogo ++


                })
                let trStrItog = document.createElement('tr');

                    let td1itog = document.createElement('td');
                    td1itog.innerHTML =  'Итого' ;
                    td1itog.style = "border: 1px solid black;  text-align:left; line-height: normal;";
                    td1itog.setAttribute('colspan', 11)

                    let td2itog = document.createElement('td');
                    td2itog.innerHTML =  itogo ;
                    td2itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";

                    trStrItog.appendChild(td1itog);
                    trStrItog.appendChild(td2itog);
                    tbody.appendChild(trStrItog);

           }else {
                divTable.innerHTML = ' ';
                divTableStr.innerHTML = 'По данным параметрам нет записей';
                
           }  
   
    });

            let divReportTitle = document.createElement('div');
            divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";  
            divReportTitle.textContent = `Контроль сроков подачи заявлений по графику`;
            divReportTitle.id='divReportTitle'
            
            divForTable.appendChild(divReportTitle);
            let reportDivUls = returnReportDivUls(dataParametrs);
            divForTable.appendChild(reportDivUls); 
            divForTable.appendChild(divTableStr);       
            
            divForTable.appendChild(divTable); 
            divTable.appendChild(table);  
}

function reportReportNoOcenka(dataParametrs){

    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';

    let divTableStr = document.createElement('div');
        divTableStr.id = 'divTableStr'
        divTableStr.innerHTML = 'Ожидайте загрузки данных';
    
    let divTable = document.createElement('div');
        divTable.id = 'divTable'
    let butnJournal = document.getElementById('butnJournal');
            
    let contentWidth = butnJournal.clientWidth - 32;
            
        divTable.style = `overflow-x:auto; max-width: ${contentWidth}px;overflow-block: visible; max-height: 600px;`;
     //   divTable.innerHTML = 'Ожидайте загрузки данных';
 
    let table =  prepereTableReport(); 

    let data = new Array();


    $.ajax({
        url: "modules/report/report_date_schedule/getReportReportNoOcenka.php",
        method: "GET",
        data: {
            datePeriod_at : dataParametrs.datePeriod_at,
            datePeriod_to : dataParametrs.datePeriod_to,
    
            year_schedule: dataParametrs.year_schedule, 
    
            OblastStr : dataParametrs.OblastStr,
            OblastsId : dataParametrs.OblastsId,
    
            guzo : dataParametrs.guzo,
            checkbox_guzo_1 :dataParametrs.checkbox_guzo_1,
            checkbox_guzo_2 : dataParametrs.checkbox_guzo_2,
    
            checkbox_pervtor_1: dataParametrs.checkbox_pervtor_1,
            checkbox_pervtor_2: dataParametrs.checkbox_pervtor_2,
            pervtor: dataParametrs.pervtor,
    
            otz : dataParametrs.otz,
            otkaz : dataParametrs.otkaz,
    
            type_report: dataParametrs.type_report,
    
            count_day_complite: dataParametrs.count_day_complite,

        }
        
    }).done(function (response){
        divTableStr.innerHTML ='';
      
        for (let i of JSON.parse(response)){
            data.push(i);
        }
        
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);
         let itogo=0
           if(data.length > 0){
                data.map((item,index) => {
                    let trStr = document.createElement('tr');

                    let td1 = document.createElement('td');
                    td1.innerHTML =  item['id_rkk'] ;
                    td1.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td2 = document.createElement('td');
                    td2.innerHTML =  item['username'] ;
                    td2.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    
                    let td3 = document.createElement('td');
                    td3.innerHTML =  item['date_create_app'] ;
                    td3.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td4 = document.createElement('td');
                    td4.innerHTML =  item['perv_vtor'] ;
                    td4.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td5 = document.createElement('td');
                    td5.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td5.innerHTML =  item['name_status'] ;

                    let td6 = document.createElement('td');
                    td6.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td6.innerHTML =  item['date_reg'] ;

                    let td7 = document.createElement('td');
                    td7.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td7.innerHTML =  item['schedule_date'] ;

                    let td8 = document.createElement('td');
                    td8.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td8.innerHTML =  item['sootvetstvie'] ;

                    let td9 = document.createElement('td');
                    td9.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td9.innerHTML =  item['adm_reah'] ;

                    let td10 = document.createElement('td');
                    td10.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td10.innerHTML =  item['date_protokol'] ;

                    let td11 = document.createElement('td');
                    td11.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td11.innerHTML =  item['info_uved'] ;

                    let td12 = document.createElement('td');
                    td12.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td12.innerHTML =  item['num_rkk'] ;



                    trStr.appendChild(td1);
                    trStr.appendChild(td2);
                    trStr.appendChild(td3);
                    trStr.appendChild(td4);
                    trStr.appendChild(td5);
                    trStr.appendChild(td6);
                    trStr.appendChild(td7);
                    trStr.appendChild(td8);
                    trStr.appendChild(td9);
                    trStr.appendChild(td10);
                    trStr.appendChild(td11);
                    trStr.appendChild(td12);

                    tbody.appendChild(trStr);
                    itogo ++


                })
                let trStrItog = document.createElement('tr');

                    let td1itog = document.createElement('td');
                    td1itog.innerHTML =  'Итого' ;
                    td1itog.style = "border: 1px solid black;  text-align:left; line-height: normal;";
                    td1itog.setAttribute('colspan', 11)

                    let td2itog = document.createElement('td');
                    td2itog.innerHTML =  itogo ;
                    td2itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";

                    trStrItog.appendChild(td1itog);
                    trStrItog.appendChild(td2itog);
                    tbody.appendChild(trStrItog);

           }else {
                divTable.innerHTML = ' ';
                divTableStr.innerHTML = 'По данным параметрам нет записей';
                
           }  
   
    });

            let divReportTitle = document.createElement('div');
            divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";  
            divReportTitle.textContent = `Контроль сроков подачи заявлений по графику`;
            divReportTitle.id='divReportTitle'
            
            divForTable.appendChild(divReportTitle);
            let reportDivUls = returnReportDivUls(dataParametrs);
            divForTable.appendChild(reportDivUls); 
            divForTable.appendChild(divTableStr);       
            
            divForTable.appendChild(divTable); 
            divTable.appendChild(table);  
}

function reportReportNoResh(dataParametrs){

    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';

    let divTableStr = document.createElement('div');
        divTableStr.id = 'divTableStr'
        divTableStr.innerHTML = 'Ожидайте загрузки данных';
    
    let divTable = document.createElement('div');
        divTable.id = 'divTable'
    let butnJournal = document.getElementById('butnJournal');
            
    let contentWidth = butnJournal.clientWidth - 32;
            
        divTable.style = `overflow-x:auto; max-width: ${contentWidth}px;overflow-block: visible; max-height: 600px;`;
     //   divTable.innerHTML = 'Ожидайте загрузки данных';
 
    let table =  prepereTableReport(); 

    let data = new Array();


    $.ajax({
        url: "modules/report/report_date_schedule/getReportReportNoResh.php",
        method: "GET",
        data: {
            datePeriod_at : dataParametrs.datePeriod_at,
            datePeriod_to : dataParametrs.datePeriod_to,
    
            year_schedule: dataParametrs.year_schedule, 
    
            OblastStr : dataParametrs.OblastStr,
            OblastsId : dataParametrs.OblastsId,
    
            guzo : dataParametrs.guzo,
            checkbox_guzo_1 :dataParametrs.checkbox_guzo_1,
            checkbox_guzo_2 : dataParametrs.checkbox_guzo_2,
    
            checkbox_pervtor_1: dataParametrs.checkbox_pervtor_1,
            checkbox_pervtor_2: dataParametrs.checkbox_pervtor_2,
            pervtor: dataParametrs.pervtor,
    
            otz : dataParametrs.otz,
            otkaz : dataParametrs.otkaz,
    
            type_report: dataParametrs.type_report,
    
            count_day_proh: dataParametrs.count_day_proh,
            count_day_cge: dataParametrs.count_day_cge,
            count_day_proc: dataParametrs.count_day_proc,
            count_day_uved: dataParametrs.count_day_uved,

        }
        
    }).done(function (response){
        divTableStr.innerHTML ='';
      
        for (let i of JSON.parse(response)){
            data.push(i);
        }
            let itogo=0
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);

           if(data.length > 0){
                data.map((item,index) => {
                    let trStr = document.createElement('tr');

                    let td1 = document.createElement('td');
                    td1.innerHTML =  item['id_rkk'] ;
                    td1.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td2 = document.createElement('td');
                    td2.innerHTML =  item['username'] ;
                    td2.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    
                    let td3 = document.createElement('td');
                    td3.innerHTML =  item['date_create_app'] ;
                    td3.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td4 = document.createElement('td');
                    td4.innerHTML =  item['perv_vtor'] ;
                    td4.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td5 = document.createElement('td');
                    td5.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td5.innerHTML =  item['name_status'] ;

                    let td6 = document.createElement('td');
                    td6.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td6.innerHTML =  item['date_reg'] ;

                    let td7 = document.createElement('td');
                    td7.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td7.innerHTML =  item['schedule_date'] ;

                    let td8 = document.createElement('td');
                    td8.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td8.innerHTML =  item['sootvetstvie'] ;

                    let td9 = document.createElement('td');
                    td9.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td9.innerHTML =  item['adm_reah'] ;

                    let td10 = document.createElement('td');
                    td10.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td10.innerHTML =  item['date_protokol'] ;

                    let td11 = document.createElement('td');
                    td11.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td11.innerHTML =  item['info_uved'] ;

                    let td12 = document.createElement('td');
                    td12.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td12.innerHTML =  item['num_rkk'] ;



                    trStr.appendChild(td1);
                    trStr.appendChild(td2);
                    trStr.appendChild(td3);
                    trStr.appendChild(td4);
                    trStr.appendChild(td5);
                    trStr.appendChild(td6);
                    trStr.appendChild(td7);
                    trStr.appendChild(td8);
                    trStr.appendChild(td9);
                    trStr.appendChild(td10);
                    trStr.appendChild(td11);
                    trStr.appendChild(td12);

                    tbody.appendChild(trStr);
                    itogo ++


                })

                let trStrItog = document.createElement('tr');

                    let td1itog = document.createElement('td');
                    td1itog.innerHTML =  'Итого' ;
                    td1itog.style = "border: 1px solid black;  text-align:left; line-height: normal;";
                    td1itog.setAttribute('colspan', 11)

                    let td2itog = document.createElement('td');
                    td2itog.innerHTML =  itogo ;
                    td2itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";

                    trStrItog.appendChild(td1itog);
                    trStrItog.appendChild(td2itog);
                    tbody.appendChild(trStrItog);
           }else {
                divTable.innerHTML = ' ';
                divTableStr.innerHTML = 'По данным параметрам нет записей';
                
           }  
   
    });

            let divReportTitle = document.createElement('div');
            divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";  
            divReportTitle.textContent = `Контроль сроков подачи заявлений по графику`;
            divReportTitle.id='divReportTitle'
            
            divForTable.appendChild(divReportTitle);
            let reportDivUls = returnReportDivUls(dataParametrs);
            divForTable.appendChild(reportDivUls); 
            divForTable.appendChild(divTableStr);       
            
            divForTable.appendChild(divTable); 
            divTable.appendChild(table);  
}


function reportReportNoAdmin(dataParametrs){

    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';

    let divTableStr = document.createElement('div');
        divTableStr.id = 'divTableStr'
        divTableStr.innerHTML = 'Ожидайте загрузки данных';
    
    let divTable = document.createElement('div');
        divTable.id = 'divTable'
    let butnJournal = document.getElementById('butnJournal');
            
    let contentWidth = butnJournal.clientWidth - 32;
            
        divTable.style = `overflow-x:auto; max-width: ${contentWidth}px;overflow-block: visible; max-height: 600px;`;
     //   divTable.innerHTML = 'Ожидайте загрузки данных';
 
    let table =  prepereTableReport(); 

    let data = new Array();


    $.ajax({
        url: "modules/report/report_date_schedule/getReportReportNoAdmin.php",
        method: "GET",
        data: {
            datePeriod_at : dataParametrs.datePeriod_at,
            datePeriod_to : dataParametrs.datePeriod_to,
    
            year_schedule: dataParametrs.year_schedule, 
    
            OblastStr : dataParametrs.OblastStr,
            OblastsId : dataParametrs.OblastsId,
    
            guzo : dataParametrs.guzo,
            checkbox_guzo_1 :dataParametrs.checkbox_guzo_1,
            checkbox_guzo_2 : dataParametrs.checkbox_guzo_2,
    
            checkbox_pervtor_1: dataParametrs.checkbox_pervtor_1,
            checkbox_pervtor_2: dataParametrs.checkbox_pervtor_2,
            pervtor: dataParametrs.pervtor,
    
            otz : dataParametrs.otz,
            otkaz : dataParametrs.otkaz,
    
            type_report: dataParametrs.type_report,
    
            count_day_proh: dataParametrs.count_day_proh,
            count_day_cge: dataParametrs.count_day_cge,
            count_day_proc: dataParametrs.count_day_proc,
            count_day_uved: dataParametrs.count_day_uved,

        }
        
    }).done(function (response){
        divTableStr.innerHTML ='';
      
        for (let i of JSON.parse(response)){
            data.push(i);
        }
        
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);
        let itogo=0
           if(data.length > 0){
                data.map((item,index) => {
                    let trStr = document.createElement('tr');

                    let td1 = document.createElement('td');
                    td1.innerHTML =  item['id_rkk'] ;
                    td1.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td2 = document.createElement('td');
                    td2.innerHTML =  item['username'] ;
                    td2.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    
                    let td3 = document.createElement('td');
                    td3.innerHTML =  item['date_create_app'] ;
                    td3.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td4 = document.createElement('td');
                    td4.innerHTML =  item['perv_vtor'] ;
                    td4.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td5 = document.createElement('td');
                    td5.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td5.innerHTML =  item['name_status'] ;

                    let td6 = document.createElement('td');
                    td6.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td6.innerHTML =  item['date_reg'] ;

                    let td7 = document.createElement('td');
                    td7.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td7.innerHTML =  item['schedule_date'] ;

                    let td8 = document.createElement('td');
                    td8.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td8.innerHTML =  item['sootvetstvie'] ;

                    let td9 = document.createElement('td');
                    td9.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td9.innerHTML =  item['adm_reah'] ;

                    let td10 = document.createElement('td');
                    td10.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td10.innerHTML =  item['date_protokol'] ;

                    let td11 = document.createElement('td');
                    td11.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td11.innerHTML =  item['info_uved'] ;

                    let td12 = document.createElement('td');
                    td12.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td12.innerHTML =  item['num_rkk'] ;



                    trStr.appendChild(td1);
                    trStr.appendChild(td2);
                    trStr.appendChild(td3);
                    trStr.appendChild(td4);
                    trStr.appendChild(td5);
                    trStr.appendChild(td6);
                    trStr.appendChild(td7);
                    trStr.appendChild(td8);
                    trStr.appendChild(td9);
                    trStr.appendChild(td10);
                    trStr.appendChild(td11);
                    trStr.appendChild(td12);

                    tbody.appendChild(trStr);
                    itogo ++


                })

                let trStrItog = document.createElement('tr');

                    let td1itog = document.createElement('td');
                    td1itog.innerHTML =  'Итого' ;
                    td1itog.style = "border: 1px solid black;  text-align:left; line-height: normal;";
                    td1itog.setAttribute('colspan', 11)

                    let td2itog = document.createElement('td');
                    td2itog.innerHTML =  itogo ;
                    td2itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";

                    trStrItog.appendChild(td1itog);
                    trStrItog.appendChild(td2itog);
                    tbody.appendChild(trStrItog);

           }else {
                divTable.innerHTML = ' ';
                divTableStr.innerHTML = 'По данным параметрам нет записей';
                
           }  
   
    });

            let divReportTitle = document.createElement('div');
            divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";  
            divReportTitle.textContent = `Контроль сроков подачи заявлений по графику`;
            divReportTitle.id='divReportTitle'
            
            divForTable.appendChild(divReportTitle);
            let reportDivUls = returnReportDivUls(dataParametrs);
            divForTable.appendChild(reportDivUls); 
            divForTable.appendChild(divTableStr);       
            
            divForTable.appendChild(divTable); 
            divTable.appendChild(table);  
}


function reportReportNoPlan(dataParametrs){

    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';

    let divTableStr = document.createElement('div');
        divTableStr.id = 'divTableStr'
        divTableStr.innerHTML = 'Ожидайте загрузки данных';
    
    let divTable = document.createElement('div');
        divTable.id = 'divTable'
    let butnJournal = document.getElementById('butnJournal');
            
    let contentWidth = butnJournal.clientWidth - 32;
            
        divTable.style = `overflow-x:auto; max-width: ${contentWidth}px;overflow-block: visible; max-height: 600px;`;
     //   divTable.innerHTML = 'Ожидайте загрузки данных';
 
    let table =  prepereTableReport(); 

    let data = new Array();


    $.ajax({
        url: "modules/report/report_date_schedule/getReportReportNoPlan.php",
        method: "GET",
        data: {
            datePeriod_at : dataParametrs.datePeriod_at,
            datePeriod_to : dataParametrs.datePeriod_to,
    
            year_schedule: dataParametrs.year_schedule, 
    
            OblastStr : dataParametrs.OblastStr,
            OblastsId : dataParametrs.OblastsId,
    
            guzo : dataParametrs.guzo,
            checkbox_guzo_1 :dataParametrs.checkbox_guzo_1,
            checkbox_guzo_2 : dataParametrs.checkbox_guzo_2,
    
            checkbox_pervtor_1: dataParametrs.checkbox_pervtor_1,
            checkbox_pervtor_2: dataParametrs.checkbox_pervtor_2,
            pervtor: dataParametrs.pervtor,
    
            otz : dataParametrs.otz,
            otkaz : dataParametrs.otkaz,
    
            type_report: dataParametrs.type_report,
    
            count_day_proh: dataParametrs.count_day_proh,
            count_day_cge: dataParametrs.count_day_cge,
            count_day_proc: dataParametrs.count_day_proc,
            count_day_uved: dataParametrs.count_day_uved,
            count_day_plan: dataParametrs.count_day_plan

        }
        
    }).done(function (response){
        divTableStr.innerHTML ='';
      
        for (let i of JSON.parse(response)){
            data.push(i);
        }
        
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);
        let itogo=0
           if(data.length > 0){
                data.map((item,index) => {
                    let trStr = document.createElement('tr');

                    let td1 = document.createElement('td');
                    td1.innerHTML =  item['id_rkk'] ;
                    td1.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td2 = document.createElement('td');
                    td2.innerHTML =  item['username'] ;
                    td2.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    
                    let td3 = document.createElement('td');
                    td3.innerHTML =  item['date_create_app'] ;
                    td3.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td4 = document.createElement('td');
                    td4.innerHTML =  item['perv_vtor'] ;
                    td4.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td5 = document.createElement('td');
                    td5.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td5.innerHTML =  item['name_status'] ;

                    let td6 = document.createElement('td');
                    td6.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td6.innerHTML =  item['date_reg'] ;

                    let td7 = document.createElement('td');
                    td7.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td7.innerHTML =  item['schedule_date'] ;

                    let td8 = document.createElement('td');
                    td8.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td8.innerHTML =  item['sootvetstvie'] ;

                    let td9 = document.createElement('td');
                    td9.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td9.innerHTML =  item['adm_reah'] ;

                    let td10 = document.createElement('td');
                    td10.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td10.innerHTML =  item['date_protokol'] ;

                    let td11 = document.createElement('td');
                    td11.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td11.innerHTML =  item['info_uved'] ;

                    let td12 = document.createElement('td');
                    td12.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td12.innerHTML =  item['num_rkk'] ;



                    trStr.appendChild(td1);
                    trStr.appendChild(td2);
                    trStr.appendChild(td3);
                    trStr.appendChild(td4);
                    trStr.appendChild(td5);
                    trStr.appendChild(td6);
                    trStr.appendChild(td7);
                    trStr.appendChild(td8);
                    trStr.appendChild(td9);
                    trStr.appendChild(td10);
                    trStr.appendChild(td11);
                    trStr.appendChild(td12);

                    tbody.appendChild(trStr);
                    itogo ++


                })

                let trStrItog = document.createElement('tr');

                    let td1itog = document.createElement('td');
                    td1itog.innerHTML =  'Итого' ;
                    td1itog.style = "border: 1px solid black;  text-align:left; line-height: normal;";
                    td1itog.setAttribute('colspan', 11)

                    let td2itog = document.createElement('td');
                    td2itog.innerHTML =  itogo ;
                    td2itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";

                    trStrItog.appendChild(td1itog);
                    trStrItog.appendChild(td2itog);
                    tbody.appendChild(trStrItog);

           }else {
                divTable.innerHTML = ' ';
                divTableStr.innerHTML = 'По данным параметрам нет записей';
                
           }  
   
    });

            let divReportTitle = document.createElement('div');
            divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";  
            divReportTitle.textContent = `Контроль сроков подачи заявлений по графику`;
            divReportTitle.id='divReportTitle'
            
            divForTable.appendChild(divReportTitle);
            let reportDivUls = returnReportDivUls(dataParametrs);
            divForTable.appendChild(reportDivUls); 
            divForTable.appendChild(divTableStr);       
            
            divForTable.appendChild(divTable); 
            divTable.appendChild(table);  
}


function reportReportNoApp(dataParametrs){

    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';

    let divTableStr = document.createElement('div');
        divTableStr.id = 'divTableStr'
        divTableStr.innerHTML = 'Ожидайте загрузки данных';
    
    let divTable = document.createElement('div');
        divTable.id = 'divTable'
    let butnJournal = document.getElementById('butnJournal');
            
    let contentWidth = butnJournal.clientWidth - 32;
            
        divTable.style = `overflow-x:auto; max-width: ${contentWidth}px;overflow-block: visible; max-height: 600px;`;
     //   divTable.innerHTML = 'Ожидайте загрузки данных';
 
    let table =  prepereTableReport(); 

    let data = new Array();


    $.ajax({
        url: "modules/report/report_date_schedule/getReportReportNoApp.php",
        method: "GET",
        data: {
            datePeriod_at : dataParametrs.datePeriod_at,
            datePeriod_to : dataParametrs.datePeriod_to,
    
            year_schedule: dataParametrs.year_schedule, 
    
            OblastStr : dataParametrs.OblastStr,
            OblastsId : dataParametrs.OblastsId,
    
            guzo : dataParametrs.guzo,
            checkbox_guzo_1 :dataParametrs.checkbox_guzo_1,
            checkbox_guzo_2 : dataParametrs.checkbox_guzo_2,
    
            checkbox_pervtor_1: dataParametrs.checkbox_pervtor_1,
            checkbox_pervtor_2: dataParametrs.checkbox_pervtor_2,
            pervtor: dataParametrs.pervtor,
    
            otz : dataParametrs.otz,
            otkaz : dataParametrs.otkaz,
    
            type_report: dataParametrs.type_report,
            count_day_app: dataParametrs.count_day_app

        }
        
    }).done(function (response){
        divTableStr.innerHTML ='';
      
        for (let i of JSON.parse(response)){
            data.push(i);
        }
        
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);
        let itogo =0
           if(data.length > 0){
                data.map((item,index) => {
                    let trStr = document.createElement('tr');

                    let td1 = document.createElement('td');
                    td1.innerHTML =  item['id_rkk'] ;
                    td1.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td2 = document.createElement('td');
                    td2.innerHTML =  item['username'] ;
                    td2.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    
                    let td3 = document.createElement('td');
                    td3.innerHTML =  item['date_create_app'] ;
                    td3.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td4 = document.createElement('td');
                    td4.innerHTML =  item['perv_vtor'] ;
                    td4.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td5 = document.createElement('td');
                    td5.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td5.innerHTML =  item['name_status'] ;

                    let td6 = document.createElement('td');
                    td6.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td6.innerHTML =  item['date_reg'] ;

                    let td7 = document.createElement('td');
                    td7.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td7.innerHTML =  item['schedule_date'] ;

                    let td8 = document.createElement('td');
                    td8.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td8.innerHTML =  item['sootvetstvie'] ;

                    let td9 = document.createElement('td');
                    td9.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td9.innerHTML =  item['adm_reah'] ;

                    let td10 = document.createElement('td');
                    td10.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td10.innerHTML =  item['date_protokol'] ;

                    let td11 = document.createElement('td');
                    td11.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td11.innerHTML =  item['info_uved'] ;

                    let td12 = document.createElement('td');
                    td12.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    td12.innerHTML =  item['num_rkk'] ;



                    trStr.appendChild(td1);
                    trStr.appendChild(td2);
                    trStr.appendChild(td3);
                    trStr.appendChild(td4);
                    trStr.appendChild(td5);
                    trStr.appendChild(td6);
                    trStr.appendChild(td7);
                    trStr.appendChild(td8);
                    trStr.appendChild(td9);
                    trStr.appendChild(td10);
                    trStr.appendChild(td11);
                    trStr.appendChild(td12);

                    tbody.appendChild(trStr);
                    itogo ++


                })

                let trStrItog = document.createElement('tr');

                    let td1itog = document.createElement('td');
                    td1itog.innerHTML =  'Итого' ;
                    td1itog.style = "border: 1px solid black;  text-align:left; line-height: normal;";
                    td1itog.setAttribute('colspan', 11)

                    let td2itog = document.createElement('td');
                    td2itog.innerHTML =  itogo ;
                    td2itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";

                    trStrItog.appendChild(td1itog);
                    trStrItog.appendChild(td2itog);
                    tbody.appendChild(trStrItog);

           }else {
                divTable.innerHTML = ' ';
                divTableStr.innerHTML = 'По данным параметрам нет записей';
                
           }  
   
    });

            let divReportTitle = document.createElement('div');
            divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";  
            divReportTitle.textContent = `Контроль сроков подачи заявлений по графику`;
            divReportTitle.id='divReportTitle'
            
            divForTable.appendChild(divReportTitle);
            let reportDivUls = returnReportDivUls(dataParametrs);
            divForTable.appendChild(reportDivUls); 
            divForTable.appendChild(divTableStr);       
            
            divForTable.appendChild(divTable); 
            divTable.appendChild(table);  
}

function returnReportDivUls(dataParametrs){

    let divReportUsl = document.createElement('div');
    divReportUsl.id = 'divReportUsl';
    divReportUsl.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:1.2rem; line-height: normal;";
    divReportUsl.textContent = '<b>' + `Условия отбора:`+'</b>';
    divReportUsl.innerHTML = divReportUsl.textContent + '<br/>'

    divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +'Отчетный период подачи заявления:'+'</b>' + ' с ' + dataParametrs.datePeriod_at + ' по ' + dataParametrs.datePeriod_to + '<br/>' 
    divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Год подачи заявления по графику:'+'</b>' + ' ' + dataParametrs.year_schedule + '<br/>'     
    
    if(dataParametrs.type_report == 1){
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Вид отчета:'+'</b> Не создавшие заявление в отчетный период' + '<br/>'
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Количество дней на прохождение самоаккредитации:'+'</b>' + dataParametrs.count_day_proh  + '<br/>'  
    } 

    if(dataParametrs.type_report == 2){
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Вид отчета:'+'</b> Не подавшие заявление по графику' + '<br/>'
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Количество дней на прохождение самоаккредитации:'+'</b>' + dataParametrs.count_day_proh  + '<br/>'  
    } 

    if(dataParametrs.type_report == 3){
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Вид отчета:'+'</b> Не завершена оценка в срок' + '<br/>'
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Количество дней на завершение процедуры:'+'</b>' + dataParametrs.count_day_proc  + '<br/>'  
    } 

    if(dataParametrs.type_report == 4){
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Вид отчета:'+'</b> Не вынесено решение в срок' + '<br/>'
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Количество дней на завершение процедуры:'+'</b>' + dataParametrs.count_day_proc  + '<br/>'  
    } 

    if(dataParametrs.type_report == 5){
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Вид отчета:'+'</b> Не направлено уведомление в срок' + '<br/>'
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Количество дней на уведомление:'+'</b>' + dataParametrs.count_day_uved  + '<br/>'  
    } 

    if(dataParametrs.type_report == 6){
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Вид отчета:'+'</b> Отсутствует план устранения несоответствия' + '<br/>'
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Количество дней на формирование плана устранения:'+'</b>' + dataParametrs.count_day_plan  + '<br/>'  
    } 

    if(dataParametrs.type_report == 7){
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Вид отчета:'+'</b> Не подали повторное заявление' + '<br/>'
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Количество месяцев для повторной подачи:'+'</b>' + dataParametrs.count_day_app  + '<br/>'  
    }
    

    let uslOblast = 'Все'; 
    if(dataParametrs.OblastStr !== ''){
       uslOblast = dataParametrs.OblastStr
    }
      divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' + ' Область:'+'</b>' + uslOblast + '<br/>'

   

    if(dataParametrs.guzo == 1) {
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' По проводящему оценку:'+'</b>'
        if(dataParametrs.checkbox_guzo_1 === true){
            divReportUsl.innerHTML  = divReportUsl.innerHTML + ' ГУЗО, Комитет'
        }
        if(dataParametrs.checkbox_guzo_2 === true){
            if(dataParametrs.checkbox_guzo_1 === true){
                divReportUsl.innerHTML  = divReportUsl.innerHTML + ', '
            } 
            divReportUsl.innerHTML  = divReportUsl.innerHTML + ' Внутреняя комиссия'
        }
    }

    if(dataParametrs.pervtor == 1) {
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Заявления за период:'+'</b>'
        if(dataParametrs.checkbox_pervtor_1 === true){
            divReportUsl.innerHTML  = divReportUsl.innerHTML + ' первичное'
        }
        if(dataParametrs.checkbox_pervtor_2 === true){
            if(dataParametrs.checkbox_pervtor_1 === true){
                divReportUsl.innerHTML  = divReportUsl.innerHTML + ', '
            } 
            divReportUsl.innerHTML  = divReportUsl.innerHTML + ' повторное'
        }
    }

    if(dataParametrs.otz === true) {
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Отозванные заявления'+'</b>'+ '<br/>'      
    } 
    
    if(dataParametrs.otkaz === true) {
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Отказ в приеме заявления'+'</b>'+ '<br/>'      
    } 


    return divReportUsl    
}






function printReport2(data){

        let printMe = document.getElementById('divForTable');  
        let dateNow = new Date;
        tableToExcel(printMe,'Отчет_по_срокам_подачи_заявлений', `Контроль_сроков_подачи_заявлений_по_графику_${new Date().toLocaleDateString()}.xls`)
}

var tableToExcel = (function() {
    var uri = 'data:application/vnd.ms-excel;base64,'
    , template = '<html  ><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--><meta http-equiv="content-type" content="text/plain; charset=UTF-8"/></head><body><table>{table}</table></body></html>'
    , base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) }
    , format = function(s, c) { 	    	 
        return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; }) 
    }
    , downloadURI = function(uri, name) {
        var link = document.createElement("a");
        link.download = name;
        link.href = uri;
        link.click();
    }

    return function(table, name, fileName) {
        if (!table.nodeType) table = document.getElementById(table)
            var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML}
        var resuri = uri + base64(format(template, ctx))
        downloadURI(resuri, fileName);
    }
})();  


let ui_reports = document.getElementById("ui-reports");
ui_reports.classList.add("show");
let itemMenu = document.querySelector("[href=\"#ui-reports\"]");
itemMenu.classList.add("collapsed");
itemMenu.setAttribute("aria-expanded", "true");
itemMenu.children[1].style = "color: #00e735";
document.getElementById("nav1").classList.remove("active");
let itemA = document.querySelector("[href=\"/index.php?report_date_schedule\"]");
itemA.style = "color: #39ff39; padding: 0rem 0rem 0rem 2rem;";