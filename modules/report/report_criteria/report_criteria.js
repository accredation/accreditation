function CheckMultiElement(elem, element_name, name_el_for_str, name_class_for_search){

    let checkBox = document.getElementById(`checkbox_id_${element_name}`);

    if(elem != 'checkBox'){
        
        checkBox.checked = !checkBox.checked;
    }
    
    ReportCheckedOblast(name_el_for_str, name_class_for_search)

    // if(!btnReportPrint.hasAttribute('disabled')){
    //     btnReportPrint.setAttribute('disabled','true')
    // }
}


function ReportCheckedOblast(name_el_for_str, name_class_for_search, report_key_value = false){

  //  console.log(name_el_for_str, name_class_for_search)

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


function CheckCheckBoxElement(elem, element_name, ){

    let checkBox = document.getElementById(`checkbox_${element_name}`);

    if(elem != 'checkBox'){
        
        checkBox.checked = !checkBox.checked;
    }
    
    // if(!btnReportPrint.hasAttribute('disabled')){
    //     btnReportPrint.setAttribute('disabled','true')
    // }
}

function CheckRadioElement(elem, element_name){
    
    let radio_checked = document.getElementById(`checkbox_type_report_${element_name}`);

    let radio_type_report = document.getElementById(`radio_type_report`);
    let type_report_ = radio_type_report.getElementsByTagName('input');

    for (let i = 1; i <= type_report_.length ; i++) {
        let radio = document.getElementById(`checkbox_type_report_`+i);
        if((radio.checked)&&(i !== element_name)){
            radio.checked = false
        } 
        
    }

    radio_checked.checked = true

}

let arrCriteriaId_report_analiz_ocenka = [];
let arrCriteriaStr_report_analiz_ocenka = [];

function CheckCriteria(elem, id_criteria){
    return false

    /*
    let checkBox = document.getElementById(`checkbox_criteria_${id_criteria}`);
    if(elem != 'checkBox'){  
       // checkBox.checked = !checkBox.checked;
    }
    
    let spanCrit = document.getElementById(`span_criteria_${id_criteria}`);

  
    // if(checkBox.checked) {
    //     spanCrit.setAttribute('data-toggle','modal')
        
    // } else {
    //     if(spanCrit.hasAttribute('data-toggle')){
    //         spanCrit.setAttribute('data-toggle','')  
    //     }
    // }

  
    

    let spanCrit_str = spanCrit.textContent;

    if(arrCriteriaId_report_analiz_ocenka.includes(id_criteria)){
        arrCriteriaId_report_analiz_ocenka = arrCriteriaId_report_analiz_ocenka.filter(item => item !== id_criteria);
        arrCriteriaStr_report_analiz_ocenka = arrCriteriaStr_report_analiz_ocenka.filter(item => item.id_criteria !== id_criteria);
    } else {
        arrCriteriaId_report_analiz_ocenka = [...arrCriteriaId_report_analiz_ocenka, id_criteria];
        arrCriteriaStr_report_analiz_ocenka = [...arrCriteriaStr_report_analiz_ocenka, {id_criteria, criteria_name: spanCrit_str} ]
    }

    if(!btnReportPrint.hasAttribute('disabled')){
        btnReportPrint.setAttribute('disabled','true')
    }
    */
}


function CheckCriteriaVisible(elem, id_criteria){

    let modalCheckCriteria = document.getElementById(`modalCheckCriteria`);
    let spanCrit = document.getElementById(`span_criteria_${id_criteria}`);

    if(modalCheckCriteria.hasAttribute('aria-hidden')){
        selectCriteria(id_criteria)
    }

  
}

// modalScheduleBody

let arrCriteria = [];
let arrlist_tables_criteria = [];

let id_list_tables = 0;

function selectCriteria(id_list_tables_criteria){

    arrCriteria = []
    id_list_tables= id_list_tables_criteria

    let divMain = document.createElement('div')
    divMain.style='max-height: 300px; overflow: auto; '

    
    let table = document.createElement('table');
    table.style = " border-spacing: 0; border: none";
    table.id = 'criteriaTable'
    divMain.appendChild(table)


    let data = new Array();

    $.ajax({
        url: "modules/report/report_criteria/getCriteria.php",
        method: "GET",
        data: {
            id_list_tables_criteria: id_list_tables_criteria,
        }
        
    }).done(function (response){
        for (let i of JSON.parse(response)){
            data.push(i);
        }
            
        let tbody = document.createElement('tbody');
         table.appendChild(tbody);

       
        if(data.length > 0){

            let tr = document.createElement('tr');
                //tr.id=item['id_criteria'];
                
                let td1 = document.createElement('td');
                td1.style = "border: 1px solid black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; ";

                let input = document.createElement('input')
                input.style='vertical-align: center; margin-right: 0.5rem;'
                input.type = 'checkbox'
                input.id=`checkboxCriteriaAll` 
                input.onclick = (e)=> checkedCriteriaAllTable(e.target)
              

                td1.appendChild(input)


                let td2 = document.createElement('td');
                td2.style = "border: 1px solid black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; ";
                td2.innerHTML = 'Все';
                td2.setAttribute('colspan',2);

               // let td3 = document.createElement('td');
               // td3.style = "border: 1px solid black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; ";
                // td3.innerHTML = item['name'];

                tr.appendChild(td1)
                tr.appendChild(td2)
               // tr.appendChild(td3)

                
                tbody.appendChild(tr)


            data.map((item) => {

                let tr = document.createElement('tr');
                tr.id=item['id_criteria'];
                
                let td1 = document.createElement('td');
                td1.style = "border: 1px solid black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; ";

                let input = document.createElement('input')
                input.style='vertical-align: top; margin-right: 0.5rem;'
                input.type = 'checkbox'
                input.id=`criteria_${item['id_criteria']}` 
                input.onclick = ()=> checkedCriteriaTable(item['id_criteria'], id_list_tables_criteria)

                td1.appendChild(input)


                let td2 = document.createElement('td');
                td2.style = "border: 1px solid black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; ";
                td2.id = `criteria_pp_${item['id_criteria']}`
                td2.innerHTML = item['pp'];

                let td3 = document.createElement('td');
                td3.style = "border: 1px solid black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; ";
                td3.innerHTML = item['name'];

                tr.appendChild(td1)
                tr.appendChild(td2)
                tr.appendChild(td3)

                
                tbody.appendChild(tr)

            })

        }
       

        returnCheked()
    });

    let modalScheduleBody = document.getElementById('modalScheduleBody');
    modalScheduleBody.innerHTML='';
    modalScheduleBody.appendChild(divMain)


}


function checkedCriteriaAllTable(elem){
  //  console.log(elem)

    let value = elem.checked

    let criteriaTable = document.getElementById('criteriaTable')

    let input_criteria = criteriaTable.getElementsByTagName('input');

    arrCriteria = [];
    
    for (let i = 1; i <= input_criteria.length -1 ; i++) {
      //  console.log(input_criteria[i])
        let input = document.getElementById(input_criteria[i].id)             
        input.checked = value

        if(value){
            let id_criteria = input_criteria[i].id.substring(9);
            let criteria_pp = document.getElementById(`criteria_pp_${id_criteria}`)         
            arrCriteria = [...arrCriteria, {id_criteria : id_criteria, pp: criteria_pp.textContent}]
        } else {
            arrCriteria = [];
        }
        
        
    }


}

function checkedCriteriaTable(id_criteria, id_list_tables_criteria){
    let checkboxCriteriaAll = document.getElementById('checkboxCriteriaAll')
    let criteriaTable = document.getElementById(`criteria_${id_criteria}`)
    let criteria_pp = document.getElementById(`criteria_pp_${id_criteria}`)    

    if(arrCriteria.filter(item => item.id_criteria == id_criteria).length > 0){
     //   console.log('ttt')
        arrCriteria = arrCriteria.filter(item => item.id_criteria !== id_criteria);
        
    } else {
        arrCriteria = [...arrCriteria, {id_criteria : id_criteria, pp: criteria_pp.textContent}]
    }

    if(checkboxCriteriaAll.checked){
        checkboxCriteriaAll.checked = false
    }

  //  console.log(arrCriteria)
}

function returnCheked(){
    
    if(arrlist_tables_criteria.length>0){
       let  findCrit = arrlist_tables_criteria.filter(item => item.id_list_tables_criteria == id_list_tables);
       if(findCrit.length>0){
      

        findCrit[0].arrCriteria.map(item=>{
            let criteriaTable = document.getElementById(`criteria_${item['id_criteria']}`)
            if(criteriaTable){
                criteriaTable.checked = true
            }

            
        })
       }
       
    }


}

function addCriteria(){
    let checkboxCriteriaAll = document.getElementById('checkboxCriteriaAll').checked;
    let criteriaTable = document.getElementById('criteriaTable')
    let input_criteria = criteriaTable.getElementsByTagName('input');

    arrCriteria = [];
    
    let checkedCrit = false;

    for (let i = 1; i <= input_criteria.length -1 ; i++) {
      //  console.log(input_criteria[i])
        let input = document.getElementById(input_criteria[i].id)             
        if(input.checked){
            let id_criteria = input_criteria[i].id.substring(9);
            let criteria_pp = document.getElementById(`criteria_pp_${id_criteria}`)         
            arrCriteria = [...arrCriteria, {id_criteria : id_criteria, pp: criteria_pp.textContent}]

            checkedCrit = true;
        } 
    }

    let checkbox_criteria = document.getElementById(`checkbox_criteria_${id_list_tables}`)
    if(checkedCrit){
        checkbox_criteria.checked  = true
    } else {
        checkbox_criteria.checked  = false
    }

    let list_tables_criteria_name = document.getElementById(`span_criteria_${id_list_tables}`).textContent

    if(arrlist_tables_criteria.filter(item => item.id_list_tables_criteria == id_list_tables).length > 0){
        arrlist_tables_criteria = arrlist_tables_criteria.filter(item => item.id_list_tables_criteria !== id_list_tables);
        arrlist_tables_criteria = [...arrlist_tables_criteria, {'id_list_tables_criteria': id_list_tables, 'list_tables_criteria_name': list_tables_criteria_name, arrCriteria, 'criteriaAll': checkboxCriteriaAll } ]
        
    } else {
        arrlist_tables_criteria = [...arrlist_tables_criteria, {'id_list_tables_criteria': id_list_tables,'list_tables_criteria_name': list_tables_criteria_name, arrCriteria, 'criteriaAll': checkboxCriteriaAll } ]
    }

    // console.log(arrlist_tables_criteria)

}

let arrTableId = []

function returnArrCtirteriaId(arrCrit){
    arrTableId = []
    let ss=[]
    if(arrCrit.length>0){
        arrCrit.map(item=>{
            arrTableId = [...arrTableId, item['id_list_tables_criteria']]
            item['arrCriteria'].map(critItem =>{
                ss = [...ss, critItem['id_criteria']]
            })
        })
    }

    return ss
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
                return 0
            }
        }
    }
   
}

function preperaReport(){

    let dataParametrs = {

        dateRkkReg : 0,
        dateRkkReg_at : '',
        dateRkkReg_to : '',

        OblastStr : '',
        OblastsId : '',
        TypeStr : '',
        TypeId : '',

        checkbox_adm_resh_1: false, 
        checkbox_adm_resh_2: false, 
        checkbox_adm_resh_3: false, 
        adm_resh:0,
       
        guzo : 0,
        checkbox_guzo_1 :false,
        checkbox_guzo_2 : false,

        type_report: 0,

        arrCriteria: '', 
        arrCriteriaStr: '', 
        arrTableId: '',
        tyte_count: false,

        critAll : '',
    }


    let reportRow = document.getElementById('reportRow');
    reportRow.style="background-color: white";

    let dateRkkReg_at = document.getElementById(`dateRkkReg_at`).value;
    dataParametrs.dateRkkReg_at = dateRkkReg_at;

    let dateRkkReg_to = document.getElementById(`dateRkkReg_to`).value;
    dataParametrs.dateRkkReg_to = dateRkkReg_to;

    let dateRkkReg = validateDate(dateRkkReg_at, dateRkkReg_to, 'dateRkkReg')
    if (dateRkkReg == -1){
        return
    }
    dataParametrs.dateRkkReg = dateRkkReg

    let oblast= ReportCheckedOblast( 'divOblastStr', 'oblast', 'report_key_value')
    dataParametrs.OblastsId = oblast[0].toString()
    dataParametrs.OblastStr = oblast[1]

    let type= ReportCheckedOblast( 'divTypeStr', 'type', 'report_key_value')
    dataParametrs.TypeId = type[0].toString()
    dataParametrs.TypeStr = type[1]

   
    let checkbox_adm_resh_1 = document.getElementById(`checkbox_adm_resh_1`);
    let checkbox_adm_resh_1_value = checkbox_adm_resh_1.checked;
    dataParametrs.checkbox_adm_resh_1 = checkbox_adm_resh_1_value;

    let checkbox_adm_resh_2 = document.getElementById(`checkbox_adm_resh_2`);
    let checkbox_adm_resh_2_value = checkbox_adm_resh_2.checked;
    dataParametrs.checkbox_adm_resh_2 = checkbox_adm_resh_2_value;
    
    let checkbox_adm_resh_3 = document.getElementById(`checkbox_adm_resh_3`);
    let checkbox_adm_resh_3_value = checkbox_adm_resh_3.checked;
    dataParametrs.checkbox_adm_resh_3 = checkbox_adm_resh_3_value;

    let adm_resh = 0
    if(checkbox_adm_resh_1_value || checkbox_adm_resh_2_value || checkbox_adm_resh_3_value){
        adm_resh = 1 
    }
    dataParametrs.adm_resh = adm_resh;


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
   

    let radio_type_report = document.getElementById(`radio_type_report`);
    let type_report_ = radio_type_report.getElementsByTagName('input');

    for (let i = 1; i <= type_report_.length ; i++) {
        let radio = document.getElementById(`checkbox_type_report_`+i);
        if(radio.checked){
            dataParametrs.type_report = i
        } 
        
    }


   // let aa =  returnArrCtirteriaId(arrlist_tables_criteria)

    // dataParametrs.arrCriteria =
    // dataParametrs.arrCriteriaStr =

   
    let flag_yur_lica = document.getElementById(`flag_yur_lica`);
    let flag_yur_lica_value = flag_yur_lica.checked;
  

 //   let btnReport = document.getElementById(`btnReport`);
 //   btnReport.setAttribute('disabled', 'true');

    let btnReportPrint = document.getElementById(`btnReportPrint`);
    btnReportPrint.removeAttribute('disabled')

    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';




    dataParametrs.arrCriteria = returnArrCtirteriaId(arrlist_tables_criteria).toString()
    dataParametrs.arrTableId = arrTableId.toString()

    dataParametrs.critAll =  arrlist_tables_criteria
       

    if(dataParametrs.arrCriteria.length == 0 ){
        alert(`Выберите критерий`)
        return -1
    }    

    if(flag_yur_lica_value){
        reportYurLica(dataParametrs)
        
    } else {
        reportWithOutYurLica(dataParametrs)
    }

    btnReport.removeAttribute('disabled');
}

function reportYurLica(dataParametrs){

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
 
    let table = document.createElement('table');
        table.style = "border: none; border-spacing: 0;";

        let trHead = document.createElement('tr');
  
        let th1 = document.createElement('th');
        th1.innerHTML = 'Организация здравоохранения';
        th1.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th2 = document.createElement('th');
        th2.innerHTML = 'Таблица';
        th2.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th3 = document.createElement('th');
        th3.innerHTML = '№';
        th3.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th4 = document.createElement('th');
        th4.innerHTML = 'Текст критерия';
        th4.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th5 = document.createElement('th');
        th5.innerHTML = 'Варианты «Да»';
        th5.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th6 = document.createElement('th');
        th6.innerHTML = 'Варианты «Нет»';
        th6.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th7 = document.createElement('th');
        th7.innerHTML = 'Варианты «Не требуется»';
        th7.style = "border: 1px solid black; text-align: left;line-height: normal";

        
        let th8 = document.createElement('th');
        th8.innerHTML = 'Удельный вес «Да»';
        th8.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th9 = document.createElement('th');
        th9.innerHTML = 'Удельный вес «Нет»';
        th9.style = "border: 1px solid black; text-align: left;line-height: normal";


         trHead.appendChild(th1);
         trHead.appendChild(th2);
         trHead.appendChild(th3);
         trHead.appendChild(th4);
         trHead.appendChild(th5);
         trHead.appendChild(th6);
         trHead.appendChild(th7);
         trHead.appendChild(th8);
         trHead.appendChild(th9);

         table.appendChild(trHead);


    let data = new Array();


    $.ajax({
        url: "modules/report/report_criteria/getReportCriteriaWithYurLica.php",
        method: "GET",
        data: {
            dateRkkReg : dataParametrs.dateRkkReg,
            dateRkkReg_at : dataParametrs.dateRkkReg_at,
            dateRkkReg_to : dataParametrs.dateRkkReg_to,

            OblastsId : dataParametrs.OblastsId,
            TypeId : dataParametrs.TypeId,

            checkbox_adm_resh_1: dataParametrs.checkbox_adm_resh_1, 
            checkbox_adm_resh_2: dataParametrs.checkbox_adm_resh_2, 
            checkbox_adm_resh_3: dataParametrs.checkbox_adm_resh_3, 
            adm_resh: dataParametrs.adm_resh,
        
            guzo : dataParametrs.guzo,
            checkbox_guzo_1 : dataParametrs.checkbox_guzo_1,
            checkbox_guzo_2 : dataParametrs.checkbox_guzo_2,

            type_report: dataParametrs.type_report,

            arrCriteria: dataParametrs.arrCriteria, 
            arrTableId: dataParametrs.arrTableId
        }
        
    }).done(function (response){
        divTableStr.innerHTML ='';
      
        for (let i of JSON.parse(response)){
            data.push(i);
        }
        
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);

           if(data.length > 0){
                data.map((item,index) => {
                    let trStr = document.createElement('tr');

                    let td1 = document.createElement('td');
                    td1.innerHTML =  item['username'] ;
                    td1.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td2 = document.createElement('td');
                    td2.innerHTML =  item['name'] ;
                    td2.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    

                    let td3 = document.createElement('td');
                    td3.innerHTML =  item['pp'] ;
                    td3.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td4 = document.createElement('td');
                    td4.innerHTML =  item['criteria_name'] ;
                    td4.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td5 = document.createElement('td');
                    td5.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td6 = document.createElement('td');
                    td6.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td7 = document.createElement('td');
                    td7.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td8 = document.createElement('td');
                    td8.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td9 = document.createElement('td');
                    td9.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    let ynCount = 0;
                    if(dataParametrs.type_report ==1){
                        td5.innerHTML =  item['count_yes'] ;
                        td6.innerHTML =  item['count_no'] ;
                        td7.innerHTML =  item['count_not_need'] ;
                        ynCount = Number(item['count_yes']) + Number(item['count_no'])

                        if(item['count_yes'] > 0) {
                            
                            td8.innerHTML =  (item['count_yes'] / ynCount *100).toFixed(2) ;
                            td8.innerHTML = td8.innerHTML  + ' %';
                        } else td8.innerHTML =  0;

                        if(item['count_no'] > 0) {
                            td9.innerHTML =  (item['count_no'] / ynCount *100).toFixed(2)  ;
                            td9.innerHTML = td9.innerHTML  + ' %';
                        } else td9.innerHTML =  0;

                    } else {
                        td5.innerHTML =  item['count_yes_accred'] ;
                        td6.innerHTML =  item['count_no_accred'] ; 
                        td7.innerHTML =  item['count_not_need_accred'] ;
                        ynCount = Number(item['count_yes_accred']) + Number(item['count_no_accred'])
                        if(item['count_yes_accred'] > 0) {
                            td8.innerHTML =  (item['count_yes_accred'] / ynCount *100).toFixed(2) ;
                            td8.innerHTML = td8.innerHTML  + ' %';
                        } else td8.innerHTML =  0;

                        if(item['count_no_accred'] > 0) {
                            td9.innerHTML =  (item['count_no_accred'] / ynCount *100).toFixed(2) ;
                            td9.innerHTML = td9.innerHTML  + ' %';
                        } else td9.innerHTML =  0;


                    }
      

                    trStr.appendChild(td1);
                    trStr.appendChild(td2);
                    trStr.appendChild(td3);
                    trStr.appendChild(td4);
                    trStr.appendChild(td5);
                    trStr.appendChild(td6);
                    trStr.appendChild(td7);
                    trStr.appendChild(td8);
                    trStr.appendChild(td9);
                    tbody.appendChild(trStr);


                })

           }else {
                divTable.innerHTML = ' ';
                divTableStr.innerHTML = 'По данным параметрам нет записей';
                
           }  
   
    });

            let divReportTitle = document.createElement('div');
            divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";  
            divReportTitle.textContent = `Анализ результатов по отдельным критериям`;
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



    if(dataParametrs.dateRkkReg > 0) {
        divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +'Дата регистрации заявления:'+'</b>' + ' с ' + dataParametrs.dateRkkReg_at + ' по ' + dataParametrs.dateRkkReg_to + '<br/>' 
    }

    
     
    let uslOblast = 'Все'; 
    if(dataParametrs.OblastStr !== ''){
       uslOblast = dataParametrs.OblastStr
    }
      divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' + ' Область:'+'</b>' + uslOblast + '<br/>'


    let uslType = 'Все'; 
    if(dataParametrs.TypeStr !== ''){
        uslType = dataParametrs.TypeStr
    }
    divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +' Тип организации: '+'</b>' + uslType + '<br/>'  


    if(dataParametrs.adm_resh == 1) {
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Вид административного решения:'+'</b>'
        if(dataParametrs.checkbox_adm_resh_1 === true){
            divReportUsl.innerHTML  = divReportUsl.innerHTML + ' Выдача свидетельства'
        }
        if(dataParametrs.checkbox_adm_resh_2 === true){
            if(dataParametrs.checkbox_adm_resh_1 === true){
                divReportUsl.innerHTML  = divReportUsl.innerHTML + ', '
            } 
            divReportUsl.innerHTML  = divReportUsl.innerHTML + ' Отказ в выдаче свидетельства'
        }
        if(dataParametrs.checkbox_adm_resh_3 === true){
            if((dataParametrs.checkbox_adm_resh_1 === true)||(dataParametrs.checkbox_adm_resh_2 === true)){
                divReportUsl.innerHTML  = divReportUsl.innerHTML + ', '
            } 
            divReportUsl.innerHTML  = divReportUsl.innerHTML + ' Отказ в приеме заявления'
        }
       
        divReportUsl.innerHTML  = divReportUsl.innerHTML + '<br/>'
    } 

    if((dataParametrs.guzo == 1) || (dataParametrs.pervtor == 1)){
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Заявление:'+'</b>'
    }

    if(dataParametrs.guzo == 1) {
   //     divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Заявление:'+'</b>'
        if(dataParametrs.checkbox_guzo_1 === true){
            divReportUsl.innerHTML  = divReportUsl.innerHTML + ' ГУЗО, Комитет'
        }
        if(dataParametrs.checkbox_guzo_2 === true){
            if(dataParametrs.checkbox_guzo_1 === true){
                divReportUsl.innerHTML  = divReportUsl.innerHTML + ', '
            } 
            divReportUsl.innerHTML  = divReportUsl.innerHTML + ' Внутреняя комиссия'
        }
       
        if(dataParametrs.pervtor != 1){
        divReportUsl.innerHTML  = divReportUsl.innerHTML + '<br/>'
        }
    }

    if(dataParametrs.type_report == 1){
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Результаты:'+'</b> самоаккредитации' 
    } else {
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Результаты:'+'</b> оценки' 
    }

    divReportUsl.innerHTML  = divReportUsl.innerHTML + '<br/>'
    divReportUsl.innerHTML  = divReportUsl.innerHTML + '<b>' +' По критериям:'+'</b>' 


    dataParametrs.critAll.map(itemTable=>{
        divReportUsl.innerHTML  = divReportUsl.innerHTML + ' ' + itemTable['list_tables_criteria_name'] +':'
        if(itemTable['criteriaAll']){
            divReportUsl.innerHTML  = divReportUsl.innerHTML + ' все пункты; ' 
        } else {
            let  strPP = ''
            itemTable['arrCriteria'].map(item=>{
                strPP = strPP + item['pp']+','
            })
            strPP = strPP.slice(0, -1)
            divReportUsl.innerHTML  = divReportUsl.innerHTML + ' ' +strPP+'; '
        }
    })



    return divReportUsl    
}


function reportWithOutYurLica(dataParametrs){

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
 
    let table = document.createElement('table');
        table.style = "border: none; border-spacing: 0;";

        let trHead = document.createElement('tr');
  
        let th2 = document.createElement('th');
        th2.innerHTML = 'Таблица';
        th2.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th3 = document.createElement('th');
        th3.innerHTML = '№';
        th3.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th4 = document.createElement('th');
        th4.innerHTML = 'Текст критерия';
        th4.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th5 = document.createElement('th');
        th5.innerHTML = 'Варианты «Да»';
        th5.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th6 = document.createElement('th');
        th6.innerHTML = 'Варианты «Нет»';
        th6.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th7 = document.createElement('th');
        th7.innerHTML = 'Варианты «Не требуется»';
        th7.style = "border: 1px solid black; text-align: left;line-height: normal";

        
        let th8 = document.createElement('th');
        th8.innerHTML = 'Удельный вес «Да»';
        th8.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th9 = document.createElement('th');
        th9.innerHTML = 'Удельный вес «Нет»';
        th9.style = "border: 1px solid black; text-align: left;line-height: normal";


         trHead.appendChild(th2);
         trHead.appendChild(th3);
         trHead.appendChild(th4);
         trHead.appendChild(th5);
         trHead.appendChild(th6);
         trHead.appendChild(th7);
         trHead.appendChild(th8);
         trHead.appendChild(th9);

         table.appendChild(trHead);


    let data = new Array();


    $.ajax({
        url: "modules/report/report_criteria/getReportCriteriaWithOutYurLica.php",
        method: "GET",
        data: {
            dateRkkReg : dataParametrs.dateRkkReg,
            dateRkkReg_at : dataParametrs.dateRkkReg_at,
            dateRkkReg_to : dataParametrs.dateRkkReg_to,

            OblastsId : dataParametrs.OblastsId,
            TypeId : dataParametrs.TypeId,

            checkbox_adm_resh_1: dataParametrs.checkbox_adm_resh_1, 
            checkbox_adm_resh_2: dataParametrs.checkbox_adm_resh_2, 
            checkbox_adm_resh_3: dataParametrs.checkbox_adm_resh_3, 
            adm_resh: dataParametrs.adm_resh,
        
            guzo : dataParametrs.guzo,
            checkbox_guzo_1 : dataParametrs.checkbox_guzo_1,
            checkbox_guzo_2 : dataParametrs.checkbox_guzo_2,

            type_report: dataParametrs.type_report,

            arrCriteria: dataParametrs.arrCriteria, 
            arrTableId: dataParametrs.arrTableId
        }
        
    }).done(function (response){
        divTableStr.innerHTML ='';
      
        for (let i of JSON.parse(response)){
            data.push(i);
        }
        
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);

           if(data.length > 0){
                data.map((item,index) => {
                    let trStr = document.createElement('tr');

                    let td2 = document.createElement('td');
                    td2.innerHTML =  item['name'] ;
                    td2.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    

                    let td3 = document.createElement('td');
                    td3.innerHTML =  item['pp'] ;
                    td3.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td4 = document.createElement('td');
                    td4.innerHTML =  item['criteria_name'] ;
                    td4.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td5 = document.createElement('td');
                    
                    
                    td5.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td6 = document.createElement('td');
                    
                    td6.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td7 = document.createElement('td');
                    
                    td7.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";


                    let td8 = document.createElement('td');
                    td8.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td9 = document.createElement('td');
                    td9.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let ynCount = 0;
                    if(dataParametrs.type_report == 1){
                        td5.innerHTML =  item['count_yes'] ;
                        td6.innerHTML =  item['count_no'] ;
                        td7.innerHTML =  item['count_not_need'] ;
                        ynCount = Number(item['count_yes']) + Number(item['count_no']);

                        if(item['count_yes'] > 0) {
                            td8.innerHTML =  (item['count_yes']  / ynCount  *100).toFixed(2);
                            td8.innerHTML = td8.innerHTML  + ' %';
                        } else td8.innerHTML =  0;

                        if(item['count_no'] > 0) {
                            td9.innerHTML =  (item['count_no']   / ynCount  *100).toFixed(2) ;
                            td9.innerHTML = td9.innerHTML  + ' %';
                        } else td9.innerHTML =  0;

                    } else {
                        td5.innerHTML =  item['count_yes_accred'] ;
                        td6.innerHTML =  item['count_no_accred'] ; 
                        td7.innerHTML =  item['count_not_need_accred'] ;
                        ynCount = Number(item['count_yes_accred']) + Number(item['count_no_accred']);
                        if(item['count_yes_accred'] > 0) {
                            td8.innerHTML =  (item['count_yes_accred']  / ynCount  *100).toFixed(2) ;
                            td8.innerHTML = td8.innerHTML  + ' %';
                        } else td8.innerHTML =  0;

                        if(item['count_no_accred'] > 0) {
                            td9.innerHTML =  (item['count_no_accred']  / ynCount  *100).toFixed(2) ;
                            td9.innerHTML = td9.innerHTML  + ' %';
                        } else td9.innerHTML =  0;
                    }

                    trStr.appendChild(td2);
                    trStr.appendChild(td3);
                    trStr.appendChild(td4);
                    trStr.appendChild(td5);
                    trStr.appendChild(td6);
                    trStr.appendChild(td7);
                    trStr.appendChild(td8);
                    trStr.appendChild(td9);
                    tbody.appendChild(trStr);


                })

           }else {
                divTable.innerHTML = ' ';
                divTableStr.innerHTML = 'По данным параметрам нет записей';
                
           }  
   
    });

            let divReportTitle = document.createElement('div');
            divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";  
            divReportTitle.textContent = `Анализ результатов по отдельным критериям`;
            divReportTitle.id='divReportTitle'
            
            divForTable.appendChild(divReportTitle);
            let reportDivUls = returnReportDivUls(dataParametrs);
            divForTable.appendChild(reportDivUls); 
            divForTable.appendChild(divTableStr);       
            
            divForTable.appendChild(divTable); 
            divTable.appendChild(table);  
}




function printReport2(data){

    let printMe = document.getElementById('divForTable');  
    let usl = document.getElementById('divReportTitle'); 
    usl.style.textAlign = 'left' 

    let dateNow = new Date;
    tableToExcel(printMe,'Анализ результатов по отдельным критериям', `Анализ_результатов_по_отдельным_критериям_${new Date().toLocaleDateString()}.xls`)
    usl.style.textAlign = 'center' 
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
let itemA = document.querySelector("[href=\"/index.php?report_criteria\"]");
itemA.style = "color: #39ff39; padding: 0rem 0rem 0rem 2rem;";