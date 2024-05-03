


function CheckCheckBoxElement(elem, element_name, ){

    let checkBox = document.getElementById(`checkbox_${element_name}`);

    if(elem != 'checkBox'){
        
        checkBox.checked = !checkBox.checked;
    }
    
    // if(!btnReportPrint.hasAttribute('disabled')){
    //     btnReportPrint.setAttribute('disabled','true')
    // }
}


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

        dateRkkProtcol : 0,
        dateRkkProtcol_at : '',
        dateRkkProtcol_to : '',

        dateRkkSved : 0,
        dateRkkSved_at : '',
        dateRkkSved_to : '',

        guzo : 0,
        checkbox_guzo_1 :false,
        checkbox_guzo_2 : false,

        checkbox_pervtor_1: false,
        checkbox_pervtor_2: false,
        pervtor: 0,

        checkbox_adm_resh_1: false, 
        checkbox_adm_resh_2: false, 
        checkbox_adm_resh_3: false, 
        adm_resh:0,

        OblastStr : '',
        OblastsId : '',
        StatusStr : '',
        StatusId : '',
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


    let dateRkkProtcol_at = document.getElementById(`dateRkkProtcol_at`).value;
    dataParametrs.dateRkkProtcol_at = dateRkkProtcol_at;

    let dateRkkProtcol_to = document.getElementById(`dateRkkProtcol_to`).value;
    dataParametrs.dateRkkProtcol_to = dateRkkProtcol_to;

    let dateRkkProtcol = validateDate(dateRkkProtcol_at, dateRkkProtcol_to, 'dateRkkProtcol')
    if (dateRkkProtcol == -1){
        return
    }
    dataParametrs.dateRkkProtcol = dateRkkProtcol


    let dateRkkSved_at = document.getElementById(`dateRkkSved_at`).value;
    dataParametrs.dateRkkSved_at = dateRkkSved_at;

    let dateRkkSved_to = document.getElementById(`dateRkkSved_to`).value;
    dataParametrs.dateRkkSved_to = dateRkkSved_to;

    let dateRkkSved = validateDate(dateRkkSved_at, dateRkkSved_to, 'dateRkkSved')
    if (dateRkkSved == -1){
        return
    }
    dataParametrs.dateRkkSved = dateRkkSved



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

  
    
    let oblast= ReportCheckedOblast( 'divOblastStr', 'oblast', 'report_key_value')
    dataParametrs.OblastsId = oblast[0].toString()
    dataParametrs.OblastStr = oblast[1]
    


    let status= ReportCheckedOblast( 'divStatusStr', 'status', 'report_key_value')
    dataParametrs.StatusId = status[0].toString()
    dataParametrs.StatusStr = status[1]


   
    let flag_yur_lica = document.getElementById(`flag_yur_lica`);
    let flag_yur_lica_value = flag_yur_lica.checked;
  

 //   let btnReport = document.getElementById(`btnReport`);
 //   btnReport.setAttribute('disabled', 'true');

    let btnReportPrint = document.getElementById(`btnReportPrint`);
    btnReportPrint.removeAttribute('disabled')

    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';


    if(!flag_yur_lica_value){
        reportWithOutYurLica(dataParametrs)
    } else {
        reportYurLica(dataParametrs)
    }

    btnReport.removeAttribute('disabled');
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
     //   table.classList.add('table-striped');
      //  table.classList.add('table-bordered');
        table.style = "border: none; border-spacing: 0;";

        let trHead = document.createElement('tr');
  
        let th1 = document.createElement('th');
        th1.innerHTML = 'Область';
        th1.style = "border: 1px solid black; text-align: left;line-height: normal";
       // th5.setAttribute('colspan','2');

        let th2 = document.createElement('th');
        th2.innerHTML = 'Количество ОЗ заявились всего';
        th2.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th3 = document.createElement('th');
        th3.innerHTML = 'Из них, заявились в соответствии с перечнем (виды) ';
        th3.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th4 = document.createElement('th');
        th4.innerHTML = 'Из них, заявились в соответствии с перечнем (профили) ';
        th4.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th5 = document.createElement('th');
        th5.innerHTML = 'Из них, не заявились по перечню (виды)';
        th5.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th6 = document.createElement('th');
        th6.innerHTML = 'Из них, не заявились по перечню (профили)';
        th6.style = "border: 1px solid black; text-align: left;line-height: normal";


        let th7 = document.createElement('th');
        th7.innerHTML = 'Заявились дополнительно к перечню (виды)';
        th7.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th8 = document.createElement('th');
        th8.innerHTML = 'Заявились дополнительно к перечню (профили)';
        th8.style = "border: 1px solid black; text-align: left;line-height: normal";


        let th9 = document.createElement('th');
        th9.innerHTML = 'Получили свидетельство';
        th9.style = "border: 1px solid black; text-align: left;line-height: normal";

       
        let th10 = document.createElement('th');
        th10.innerHTML = 'В свидетельство включены все виды по перечню';
        th10.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th11 = document.createElement('th');
        th11.innerHTML = 'В свидетельство включены все профили по перечню';
        th11.style = "border: 1px solid black; text-align: left;line-height: normal";


        let th12 = document.createElement('th');
        th12.innerHTML = 'В свидетельство включены не все виды по перечню';
        th12.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th13 = document.createElement('th');
        th13.innerHTML = 'В свидетельство включены не все профили по перечню';
        th13.style = "border: 1px solid black; text-align: left;line-height: normal";


        let th14 = document.createElement('th');
        th14.innerHTML = 'В свидетельство включены дополнительно к перечню виды';
        th14.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th15 = document.createElement('th');
        th15.innerHTML = 'В свидетельство включены дополнительно к перечню профили';
        th15.style = "border: 1px solid black; text-align: left;line-height: normal";
        

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
         trHead.appendChild(th13);
         trHead.appendChild(th14);
         trHead.appendChild(th15);


         table.appendChild(trHead);


    let data = new Array();


    let itog_count_uz = 0;
    let itog_count_vid = 0;
    let itog_count_vid_not = 0;
    let itog_count_vid_lishn = 0;
    let itog_count_profile = 0; 
    let itog_count_profile_not = 0; 
    let itog_count_profile_lishn = 0; 
    let itog_count_sved = 0; 
    let itog_count_vid_sved = 0; 
    let itog_count_vid_not_sved = 0; 
    let itog_count_vid_lishn_sved = 0; 
    let itog_count_profile_sved = 0; 
    let itog_count_profile_not_sved = 0; 
    let itog_count_profile_lishn_sved = 0;  

    $.ajax({
        url: "modules/report/report_vid_profile_oz/getReportVidProfile.php",
        method: "GET",
        data: {
            dateRkkReg : dataParametrs.dateRkkReg,
            dateRkkReg_at : dataParametrs.dateRkkReg_at,
            dateRkkReg_to : dataParametrs.dateRkkReg_to,

            dateRkkProtcol : dataParametrs.dateRkkProtcol,
            dateRkkProtcol_at : dataParametrs.dateRkkProtcol_at,
            dateRkkProtcol_to : dataParametrs.dateRkkProtcol_to,

            dateRkkSved : dataParametrs.dateRkkSved,
            dateRkkSved_at : dataParametrs.dateRkkSved_at,
            dateRkkSved_to : dataParametrs.dateRkkSved_to,

            guzo : dataParametrs.guzo,
            checkbox_guzo_1 :dataParametrs.checkbox_guzo_1,
            checkbox_guzo_2 : dataParametrs.checkbox_guzo_2,

            checkbox_pervtor_1 : dataParametrs.checkbox_pervtor_1,
            checkbox_pervtor_2 : dataParametrs.checkbox_pervtor_2,
            pervtor: dataParametrs.pervtor,

            checkbox_adm_resh_1 : dataParametrs.checkbox_adm_resh_1, 
            checkbox_adm_resh_2 : dataParametrs.checkbox_adm_resh_2, 
            checkbox_adm_resh_3 : dataParametrs.checkbox_adm_resh_3, 
            adm_resh : dataParametrs.adm_resh,

            OblastsId : dataParametrs.OblastsId,
            StatusId : dataParametrs.StatusId
        }
        
    }).done(function (response){
        divTableStr.innerHTML ='';
      
        for (let i of JSON.parse(response)){
            data.push(i);
        }
        
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);


         let type_criteria = 0;
           if(data.length > 0){
                data.map((item,index) => {

                    let trStr = document.createElement('tr');

                    let td1 = document.createElement('td');
                    td1.innerHTML =  item['oblast'] ;
                    td1.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td2 = document.createElement('td');
                    td2.innerHTML =  item['count_uz'] ;
                    td2.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    itog_count_uz = itog_count_uz + Number(item['count_uz']);

                    let td3 = document.createElement('td');
                    td3.innerHTML =  item['count_vid'] ;
                    td3.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    itog_count_vid = itog_count_vid + Number(item['count_vid']);

                    let td4 = document.createElement('td');
                    td4.innerHTML =  item['count_profile'] ;
                    td4.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    itog_count_profile = itog_count_profile + Number(item['count_profile']);

                    let td5 = document.createElement('td');
                    td5.innerHTML =  item['count_vid_not'] ;
                    td5.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    itog_count_vid_not = itog_count_vid_not + Number(item['count_vid_not']);

                    let td6 = document.createElement('td');
                    td6.innerHTML =  item['count_profile_not'] ;
                    td6.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    itog_count_profile_not = itog_count_profile_not + Number(item['count_profile_not']);

                    let td7 = document.createElement('td');
                    td7.innerHTML =  item['count_vid_lishn'] ;
                    td7.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    itog_count_vid_lishn = itog_count_vid_lishn + Number(item['count_vid_lishn']);

                    let td8 = document.createElement('td');
                    td8.innerHTML =  item['count_profile_lishn'] ;
                    td8.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    itog_count_profile_lishn = itog_count_profile_lishn + Number(item['count_profile_lishn']);

                    let td9 = document.createElement('td');
                    td9.innerHTML =  item['count_sved'] ;
                    td9.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    itog_count_sved = itog_count_sved + Number(item['count_sved']);

                    let td10 = document.createElement('td');
                    td10.innerHTML =  item['count_vid_sved'] ;
                    td10.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    itog_count_vid_sved = itog_count_vid_sved + Number(item['count_vid_sved']);

                    let td11 = document.createElement('td');
                    td11.innerHTML =  item['count_profile_sved'] ;
                    td11.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    itog_count_profile_sved = itog_count_profile_sved+  Number(item['count_profile_sved']);

                    let td12 = document.createElement('td');
                    td12.innerHTML =  item['count_vid_not_sved'] ;
                    td12.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    itog_count_vid_not_sved = itog_count_vid_not_sved + Number(item['count_vid_not_sved']);

                    let td13 = document.createElement('td');
                    td13.innerHTML =  item['count_profile_not_sved'] ;
                    td13.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    itog_count_profile_not_sved = itog_count_profile_not_sved + Number(item['count_profile_not_sved']);                  
                    
                    let td14 = document.createElement('td');
                    td14.innerHTML =  item['count_vid_lishn_sved'] ;
                    td14.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    itog_count_vid_lishn_sved = itog_count_vid_lishn_sved + Number(item['count_vid_lishn_sved']);  

                    let td15 = document.createElement('td');
                    td15.innerHTML =  item['count_profile_lishn_sved'] ;
                    td15.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    itog_count_profile_lishn_sved = itog_count_profile_lishn_sved+ Number(item['count_profile_lishn_sved']);  


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
                    trStr.appendChild(td13);
                    trStr.appendChild(td14);
                    trStr.appendChild(td15);

                    tbody.appendChild(trStr);


                })


                let trStrItog = document.createElement('tr');

                let td1Itog = document.createElement('td');
                td1Itog.innerHTML =  'Итого' ;
                td1Itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";
                        
                let td2Itog = document.createElement('td');
                td2Itog.innerHTML =  itog_count_uz ;
                td2Itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";

                let td3Itog = document.createElement('td');
                td3Itog.innerHTML =  itog_count_vid ;
                td3Itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";
                
                let td4Itog = document.createElement('td');
                td4Itog.innerHTML =  itog_count_profile ;
                td4Itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";

                let td5Itog = document.createElement('td');
                td5Itog.innerHTML =  itog_count_vid_not ;
                td5Itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";
                
                let td6Itog = document.createElement('td');
                td6Itog.innerHTML =  itog_count_profile_not ;
                td6Itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";

                let td7Itog = document.createElement('td');
                td7Itog.innerHTML =  itog_count_vid_lishn ;
                td7Itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";

                let td8Itog = document.createElement('td');
                td8Itog.innerHTML =  itog_count_profile_lishn ;
                td8Itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";

                let td9Itog = document.createElement('td');
                td9Itog.innerHTML = itog_count_sved ;
                td9Itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";

                let td10Itog = document.createElement('td');
                td10Itog.innerHTML =  itog_count_vid_sved;
                td10Itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";

                let td11Itog = document.createElement('td');
                td11Itog.innerHTML =  itog_count_profile_sved ;
                td11Itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";

                let td12Itog = document.createElement('td');
                td12Itog.innerHTML =  itog_count_vid_not_sved;
                td12Itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";

                let td13Itog = document.createElement('td');
                td13Itog.innerHTML =  itog_count_profile_not_sved ;
                td13Itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";                  
                
                let td14Itog = document.createElement('td');
                td14Itog.innerHTML =  itog_count_vid_lishn_sved;
                td14Itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";
                
                let td15Itog = document.createElement('td');
                td15Itog.innerHTML =  itog_count_profile_lishn_sved;
                td15Itog.style = "border: 1px solid black;  text-align:center; line-height: normal;";

                trStrItog.appendChild(td1Itog);
                trStrItog.appendChild(td2Itog);
                trStrItog.appendChild(td3Itog);
                trStrItog.appendChild(td4Itog);
                trStrItog.appendChild(td5Itog);
                trStrItog.appendChild(td6Itog);
                trStrItog.appendChild(td7Itog);
                trStrItog.appendChild(td8Itog);
                trStrItog.appendChild(td9Itog);
                trStrItog.appendChild(td10Itog);
                trStrItog.appendChild(td11Itog);
                trStrItog.appendChild(td12Itog);
                trStrItog.appendChild(td13Itog);
                trStrItog.appendChild(td14Itog);
                trStrItog.appendChild(td15Itog);

                tbody.appendChild(trStrItog);

           }else {
                divTable.innerHTML = ' ';
                divTableStr.innerHTML = 'По данным параметрам нет записей';
                
           }  
   
    });

            let divReportTitle = document.createElement('div');
            divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";  
            divReportTitle.textContent = `Отчет по видам медицинской помощи и профилям ОЗ установленных в перечне`;
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

    if(dataParametrs.dateRkkProtcol > 0) {
        divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +'Дата протокола комиссии:'+'</b>' + ' с ' + dataParametrs.dateRkkProtcol_at + ' по ' + dataParametrs.dateRkkProtcol_to + '<br/>' 
    }

    if(dataParametrs.dateRkkSved > 0) {
        divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +'Срок действия свидетельства:'+'</b>' + ' с ' + dataParametrs.dateRkkSved_at + ' по ' + dataParametrs.dateRkkSved_to + '<br/>' 
    }

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


    if(dataParametrs.pervtor == 1) {
    //    divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Заявление:'+'</b>'
        if(dataParametrs.checkbox_pervtor_1 === true){
            divReportUsl.innerHTML  = divReportUsl.innerHTML + ' первичное'
        }
        if(dataParametrs.checkbox_pervtor_2 === true){
            if(dataParametrs.checkbox_pervtor_1 === true){
                divReportUsl.innerHTML  = divReportUsl.innerHTML + ', '
            } 
            divReportUsl.innerHTML  = divReportUsl.innerHTML + ' повторное'
        }
       
        divReportUsl.innerHTML  = divReportUsl.innerHTML + '<br/>'
    } 

      let uslStatus = 'Все'; 
    if(dataParametrs.StatusStr !== ''){
       uslStatus = dataParametrs.StatusStr
    }
    divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +' Статус: '+'</b>' + uslStatus + '<br/>'
     
    let uslOblast = 'Все'; 
    if(dataParametrs.OblastStr !== ''){
       uslOblast = dataParametrs.OblastStr
    }
      divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' + ' Область:'+'</b>' + uslOblast + '<br/>'


    return divReportUsl    
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
     //   table.classList.add('table-striped');
      //  table.classList.add('table-bordered');
        table.style = "border: none; border-spacing: 0;";

        let trHead = document.createElement('tr');
  
        let th1 = document.createElement('th');
        th1.innerHTML = 'Область';
        th1.style = "border: 1px solid black; text-align: left;line-height: normal";
       // th5.setAttribute('colspan','2');

        let th2 = document.createElement('th');
        th2.innerHTML = 'Количество ОЗ заявились всего';
        th2.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th3 = document.createElement('th');
        th3.innerHTML = 'Из них, заявились в соответствии с перечнем (виды) ';
        th3.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th4 = document.createElement('th');
        th4.innerHTML = 'Из них, заявились в соответствии с перечнем (профили) ';
        th4.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th5 = document.createElement('th');
        th5.innerHTML = 'Из них, не заявились по перечню (виды)';
        th5.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th6 = document.createElement('th');
        th6.innerHTML = 'Из них, не заявились по перечню (профили)';
        th6.style = "border: 1px solid black; text-align: left;line-height: normal";


        let th7 = document.createElement('th');
        th7.innerHTML = 'Заявились дополнительно к перечню (виды)';
        th7.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th8 = document.createElement('th');
        th8.innerHTML = 'Заявились дополнительно к перечню (профили)';
        th8.style = "border: 1px solid black; text-align: left;line-height: normal";


        let th9 = document.createElement('th');
        th9.innerHTML = 'Получили свидетельство';
        th9.style = "border: 1px solid black; text-align: left;line-height: normal";

       
        let th10 = document.createElement('th');
        th10.innerHTML = 'В свидетельство включены все виды по перечню';
        th10.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th11 = document.createElement('th');
        th11.innerHTML = 'В свидетельство включены все профили по перечню';
        th11.style = "border: 1px solid black; text-align: left;line-height: normal";


        let th12 = document.createElement('th');
        th12.innerHTML = 'В свидетельство включены не все виды по перечню';
        th12.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th13 = document.createElement('th');
        th13.innerHTML = 'В свидетельство включены не все профили по перечню';
        th13.style = "border: 1px solid black; text-align: left;line-height: normal";


        let th14 = document.createElement('th');
        th14.innerHTML = 'В свидетельство включены дополнительно к перечню виды';
        th14.style = "border: 1px solid black; text-align: left;line-height: normal";

        let th15 = document.createElement('th');
        th15.innerHTML = 'В свидетельство включены дополнительно к перечню профили';
        th15.style = "border: 1px solid black; text-align: left;line-height: normal";
        

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
         trHead.appendChild(th13);
         trHead.appendChild(th14);
         trHead.appendChild(th15);


         table.appendChild(trHead);


    let data = new Array();

    $.ajax({
        url: "modules/report/report_vid_profile_oz/getReportVidProfileWithYurLica.php",
        method: "GET",
        data: {
            dateRkkReg : dataParametrs.dateRkkReg,
            dateRkkReg_at : dataParametrs.dateRkkReg_at,
            dateRkkReg_to : dataParametrs.dateRkkReg_to,

            dateRkkProtcol : dataParametrs.dateRkkProtcol,
            dateRkkProtcol_at : dataParametrs.dateRkkProtcol_at,
            dateRkkProtcol_to : dataParametrs.dateRkkProtcol_to,

            dateRkkSved : dataParametrs.dateRkkSved,
            dateRkkSved_at : dataParametrs.dateRkkSved_at,
            dateRkkSved_to : dataParametrs.dateRkkSved_to,

            guzo : dataParametrs.guzo,
            checkbox_guzo_1 :dataParametrs.checkbox_guzo_1,
            checkbox_guzo_2 : dataParametrs.checkbox_guzo_2,

            checkbox_pervtor_1 : dataParametrs.checkbox_pervtor_1,
            checkbox_pervtor_2 : dataParametrs.checkbox_pervtor_2,
            pervtor: dataParametrs.pervtor,

            checkbox_adm_resh_1 : dataParametrs.checkbox_adm_resh_1, 
            checkbox_adm_resh_2 : dataParametrs.checkbox_adm_resh_2, 
            checkbox_adm_resh_3 : dataParametrs.checkbox_adm_resh_3, 
            adm_resh : dataParametrs.adm_resh,

            OblastsId : dataParametrs.OblastsId,
            StatusId : dataParametrs.StatusId
        }
        
    }).  
    done(function (response){
        divTableStr.innerHTML ='';
      
        for (let i of JSON.parse(response)){
            data.push(i);
        }
    
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);


         let type_criteria = 0;
           if(data.length > 0){
                data.map((item,index) => {

                    let trStr = document.createElement('tr');
                    let trCount = document.createElement('tr');

                    let td1 = document.createElement('td');
                    td1.innerHTML =  item['oblast'] ;
                    td1.style = " text-align:center; line-height: normal;";

                    let td1_count = document.createElement('td');
                    td1_count.innerHTML =  '' ;
                    td1_count.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    
                    let td2 = document.createElement('td');
                    td2.innerHTML =  item['username'] ;
                    td2.style = " text-align:center; line-height: normal;";

                    let td2_count = document.createElement('td');
                    td2_count.innerHTML =  item['count_app'] ;
                    td2_count.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td3 = document.createElement('td');
                    td3.innerHTML =  item['vid_name'] ;
                    td3.style = " text-align:center; line-height: normal;";

                    let td3_count = document.createElement('td');
                    td3_count.innerHTML =  item['vid_count'] ;
                    td3_count.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
                    
                    let td4 = document.createElement('td');
                    td4.innerHTML =  item['profile_name'] ;
                    td4.style = " text-align:center; line-height: normal;";

                    let td4_count = document.createElement('td');
                    td4_count.innerHTML =  item['profile_count'] ;
                    td4_count.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td5 = document.createElement('td');
                    td5.innerHTML =  item['vid_lishn_name'] ;
                    td5.style = " text-align:center; line-height: normal;";

                    let td5_count = document.createElement('td');
                    td5_count.innerHTML =  item['vid_lishn_count'] ;
                    td5_count.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";
   
                    let td6 = document.createElement('td');
                    td6.innerHTML =  item['profile_lishn_name'] ;
                    td6.style = " text-align:center; line-height: normal;";

                    let td6_count = document.createElement('td');
                    td6_count.innerHTML =  item['profile_lishn_count'] ;
                    td6_count.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";


                    let td7 = document.createElement('td');
                    td7.innerHTML =  item['name_vid_not_in'] ;
                    td7.style = " text-align:center; line-height: normal;";

                    let td7_count = document.createElement('td');
                    td7_count.innerHTML =  item['count_vid_not_in'] ;
                    td7_count.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td8 = document.createElement('td');
                    td8.innerHTML =  item['name_profile_not_in'] ;
                    td8.style = " text-align:center; line-height: normal;";

                    let td8_count = document.createElement('td');
                    td8_count.innerHTML =  item['count_profile_not_in'] ;
                    td8_count.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td9 = document.createElement('td');
                    td9.innerHTML =  item['sved_name'] ;
                    td9.style = " text-align:center; line-height: normal;";

                    let td9_count = document.createElement('td');
                    td9_count.innerHTML =  item['sved_count'] ;
                    td9_count.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";


                    let td10 = document.createElement('td');
                    td10.innerHTML =  item['vid_sved_name'] ;
                    td10.style = " text-align:center; line-height: normal;";

                    let td10_count = document.createElement('td');
                    td10_count.innerHTML =  item['vid_sved_count'] ;
                    td10_count.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td11 = document.createElement('td');
                    td11.innerHTML =  item['profile_sved_name'] ;
                    td11.style = " text-align:center; line-height: normal;";
       
                    let td11_count = document.createElement('td');
                    td11_count.innerHTML =  item['profile_sved_count'] ;
                    td11_count.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td12 = document.createElement('td');
                    td12.innerHTML =  item['name_vid_sved_not_in'] ;
                    td12.style = " text-align:center; line-height: normal;";

                    let td12_count = document.createElement('td');
                    td12_count.innerHTML =  item['count_vid_sved_not_in'] ;
                    td12_count.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    let td13 = document.createElement('td');
                    td13.innerHTML =  item['name_profile_sved_not_in'] ;
                    td13.style = " text-align:center; line-height: normal;";

                    let td13_count = document.createElement('td');
                    td13_count.innerHTML =  item['count_profile_sved_not_in'] ;
                    td13_count.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";                  

                    
                    let td14 = document.createElement('td');
                    td14.innerHTML =   item['vid_sved_lishn_name'] ;
                    td14.style = " text-align:center; line-height: normal;";

                    let td14_count = document.createElement('td');
                    td14_count.innerHTML =   item['vid_sved_lishn_count'] ;
                    td14_count.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";

                    
                    let td15 = document.createElement('td');
                    td15.innerHTML =  item['profile_sved_lishn_name'] ;
                    td15.style = " text-align:center; line-height: normal;";

                    let td15_count = document.createElement('td');
                    td15_count.innerHTML =  item['profile_sved_lishn_count'] ;
                    td15_count.style = "border-bottom: 1px dashed black;  text-align:center; line-height: normal;";



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
                    trStr.appendChild(td13);
                    trStr.appendChild(td14);
                    trStr.appendChild(td15);

                    trCount.appendChild(td1_count);
                    trCount.appendChild(td2_count);
                    trCount.appendChild(td3_count);
                    trCount.appendChild(td4_count);
                    trCount.appendChild(td5_count);
                    trCount.appendChild(td6_count);
                    trCount.appendChild(td7_count);
                    trCount.appendChild(td8_count);
                    trCount.appendChild(td9_count);
                    trCount.appendChild(td10_count);
                    trCount.appendChild(td11_count);
                    trCount.appendChild(td12_count);
                    trCount.appendChild(td13_count);
                    trCount.appendChild(td14_count);
                    trCount.appendChild(td15_count);

                    tbody.appendChild(trStr);
                    tbody.appendChild(trCount);


                })
           }else {
                divTable.innerHTML = ' ';
                divTableStr.innerHTML = 'По данным параметрам нет записей';
                
           }
   
    });

            let divReportTitle = document.createElement('div');
            divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";  
            divReportTitle.textContent = `Отчет по видам медицинской помощи и профилям ОЗ установленных в перечне`;
            divReportTitle.id='divReportTitle'
            
            divForTable.appendChild(divReportTitle); 
            let reportDivUls = returnReportDivUls(dataParametrs);
            divForTable.appendChild(reportDivUls); 
            divForTable.appendChild(divTableStr);       
            
            divForTable.appendChild(divTable); 
            divTable.appendChild(table);  
        
}


function printReport(){
    let flag_yur_lica = document.getElementById(`flag_yur_lica`);
    let flag_yur_lica_value = flag_yur_lica.checked;

    

    var WinPrint = window.open('','','left=50,top=50,width=800,height=640,toolbar=0,scrollbars=1,status=0');

    // if(flag_yur_lica_value == true){
    //     WinPrint.document.write('<style>@page {\n' +
    //     'size: A4 landscape;\n' +
    //     'margin: 1rem;\n' +
    //     '}</style>');
    // } else {
    //     WinPrint.document.write('<style>@page {\n' +
    //     'size: A4 portrait;\n' +
    //     'margin: 1rem;\n' +
    //     '}</style>');
    // }

    WinPrint.document.write('<style>@page {\n' +
        'size: A4 portrait;\n' +
        'margin: 1rem;\n' +
        '}</style>');
    
 
   // WinPrint.document.write(divReportTitle.innerHTML);    
    let divForTable = document.getElementById('divForTable');    

    let divReportUsl = document.getElementById('divReportUsl');    
    divReportUsl.removeAttribute('hidden');
        
    WinPrint.document.write(divForTable.innerHTML);
   

    WinPrint.document.close();
    WinPrint.focus();
    WinPrint.print();
    WinPrint.close();

    divReportUsl.setAttribute('hidden','true');
}

function disablePrint(){
    let btnReportPrint = document.getElementById(`btnReportPrint`);

    if(!btnReportPrint.hasAttribute('disabled')){
        btnReportPrint.setAttribute('disabled','true')
    }


}


function printReport2(data){

    let printMe = document.getElementById('divForTable');  
    let usl = document.getElementById('divReportTitle'); 
    usl.style.textAlign = 'left' 

    let dateNow = new Date;
    tableToExcel(printMe,'Отчет по видам медицинской помощи и профилям ОЗ установленных в перечне', `Отчет_по_видам_медицинской_помощи_и_профилям_ОЗ_установленных_в_перечне_${new Date().toLocaleDateString()}.xls`)
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
let itemA = document.querySelector("[href=\"/index.php?report_vid_profile_oz\"]");
itemA.style = "color: #39ff39; padding: 0rem 0rem 0rem 2rem;";