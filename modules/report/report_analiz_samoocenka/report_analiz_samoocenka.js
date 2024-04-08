let arrCriteriaId_report_analiz_samoocenka = [];
let arrCriteriaStr_report_analiz_samoocenka = [];


function CheckCriteria(elem, id_criteria){
    
    if(elem != 'checkBox'){
        let checkBox = document.getElementById(`checkbox_criteria_${id_criteria}`);
        checkBox.checked = !checkBox.checked;
    }
    
    let spanCrit = document.getElementById(`span_criteria_${id_criteria}`);

    let spanCrit_str = spanCrit.textContent;

    if(arrCriteriaId_report_analiz_samoocenka.includes(id_criteria)){
        arrCriteriaId_report_analiz_samoocenka = arrCriteriaId_report_analiz_samoocenka.filter(item => item !== id_criteria);
        arrCriteriaStr_report_analiz_samoocenka = arrCriteriaStr_report_analiz_samoocenka.filter(item => item.id_criteria !== id_criteria);
    } else {
        arrCriteriaId_report_analiz_samoocenka = [...arrCriteriaId_report_analiz_samoocenka, id_criteria];
        arrCriteriaStr_report_analiz_samoocenka = [...arrCriteriaStr_report_analiz_samoocenka, {id_criteria, criteria_name: spanCrit_str} ]
    }

    if(!btnReportPrint.hasAttribute('disabled')){
        btnReportPrint.setAttribute('disabled','true')
    }
}


function CheckCheckBoxElement(elem, element_name, name_el_for_str, name_class_for_search){

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


function preperaReport(){

    let dataParametrs = {
        
        date_create_at: null,
        date_create_to: null, 
        OblastStr : '',
        OblastsId : '',
        StatusStr : '',
        StatusId : '',
        TypeStr : '',
        TypeId : '',
        criteriaAll : '',
        criteriaAllText: '',
        criteriaIdStr: '',
        criteriaArr: '',

    }

    let reportRow = document.getElementById('reportRow');
    reportRow.style="background-color: white";

    let dateAccept = document.getElementById(`dateAccept`);
    let dateAccept_value = dateAccept.value;
    dataParametrs.date_create_at = dateAccept_value

    let dateComplete = document.getElementById(`dateComplete`);
    let dateComplete_value = dateComplete.value;
    dataParametrs.date_create_to = dateComplete_value

    
    if(!dateAccept_value) {
        alert('Введите дату начала отчетного периода')
        return
    }

    if(!dateComplete_value){
        alert('Введите дату завершения отчетного периода')
        return
    }

    if(dateAccept_value>dateComplete_value) {
        alert('Неверно заданы даты отчетного периода')
        return
    }


    
    let oblast= ReportCheckedOblast( 'divOblastStr', 'oblast', 'report_key_value')
    dataParametrs.OblastsId = oblast[0].toString()
    dataParametrs.OblastStr = oblast[1]
    


    let status= ReportCheckedOblast( 'divStatusStr', 'status', 'report_key_value')
    dataParametrs.StatusId = status[0].toString()
    dataParametrs.StatusStr = status[1]

    let type= ReportCheckedOblast( 'divTypeStr', 'type', 'report_key_value')
    dataParametrs.TypeId = type[0].toString()
    dataParametrs.TypeStr = type[1]
    
    let criteriaAll = document.getElementById(`criteriaAll`);
    let criteriaAll_value = criteriaAll.value;
    let criteriaAll_text = criteriaAll.options[criteriaAll.options.selectedIndex].textContent;
    dataParametrs.criteriaAll = criteriaAll_value
    dataParametrs.criteriaAllText = criteriaAll_text
    dataParametrs.criteriaIdStr =arrCriteriaId_report_analiz_samoocenka.toString()
    dataParametrs.criteriaArr = arrCriteriaStr_report_analiz_samoocenka
    
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

    let table = document.createElement('table');
    table.style = " border-spacing: 0; border: none";


    let trHead2 = document.createElement('tr');


    let th5 = document.createElement('th');
    th5.innerHTML = 'Критерий';
    th5.style = "border: 1px solid black;width: 40%; text-align: left;line-height: normal";
    th5.setAttribute('colspan','2');

    let th6 = document.createElement('th');
    th6.innerHTML = 'Количество';
    th6.style = "border: 1px solid black;width: 25%; text-align: center;line-height: normal";

    let th7 = document.createElement('th');
    th7.innerHTML = 'Cредняя оценка, %';
    th7.style = "border: 1px solid black;width: 25%; text-align: center;line-height: normal";


     trHead2.appendChild(th5);
     trHead2.appendChild(th6);
     trHead2.appendChild(th7);
 
     table.appendChild(trHead2);
    
    let data = new Array();

    $.ajax({
        url: "modules/report/report_analiz_samoocenka/getReportSamoocenkaWithOutYurLica.php",
        method: "GET",
        data: {
            date_create_at: dataParametrs.date_create_at,
            date_create_to: dataParametrs.date_create_to, 
            oblastsId : dataParametrs.OblastsId,
            statusId : dataParametrs.StatusId,
            typeId : dataParametrs.TypeId,
            criteriaAll : dataParametrs.criteriaAll,
            criteriaIdStr: dataParametrs.criteriaIdStr,
        }
        
    }).done(function (response){
        for (let i of JSON.parse(response)){
            data.push(i);
        }
        
       
     
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);

         let id_types_tables = 0;
           if(data.length > 0){
                data.map((item,index) => {
                                        
                    if(id_types_tables !== Number(item['id_types_tables'])){

                      //  console.log('type_criteria', type_criteria);
                        let trNameBlok = document.createElement('tr');
                        let tdNameBlok = document.createElement('td');

                        tdNameBlok.innerHTML = item['type_criteria']
                        
                        tdNameBlok.setAttribute('colspan',3);
    
                        if(index>0){
                            tdNameBlok.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal;  font-style:italic; font-size: 1.2rem; padding-top:0.7rem ";
                        } else {
                            tdNameBlok.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal;  font-style:italic; font-size: 1.2rem ";
                        }
    
    
                        id_types_tables = Number(item['id_types_tables']);

                        trNameBlok.appendChild(tdNameBlok);
                        tbody.appendChild(trNameBlok);
                    }

                    

              //     let type_criteria = item['name_criteria'];

                    
                    let tr2 = document.createElement('tr');
                    let td5 = document.createElement('td');
                    td5.innerHTML = item['name_criteria'];
                    td5.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; ";
                    td5.setAttribute('colspan',2);
                  
                    let td6 = document.createElement('td');
                    td6.innerHTML = item['crit_count'];
                    td6.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                    let td7 = document.createElement('td');
                    td7.innerHTML = item['crit_src'];
                    td7.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                    tr2.appendChild(td5);
                    tr2.appendChild(td6);
                    tr2.appendChild(td7);
                    
                    tbody.appendChild(tr2);

                })
           }else {
        
            let divForTable = document.getElementById(`divForTable`);
            divForTable.innerHTML = '';
            divForTable.innerHTML = 'По данным параметрам нет записей';
    
           }

        
    });

    let divReportTitle = document.createElement('div');
    divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";
   divReportTitle.textContent = `Анализ результатов самооценки организаций здравоохранения`;
   divReportTitle.id='divReportTitle'
  
   
   let divReportUsl = returnReportDivUls(dataParametrs)

    
       divForTable.appendChild(divReportTitle);         
       divForTable.appendChild(divReportUsl);         
       divForTable.appendChild(table); 
    

}

function reportYurLica(dataParametrs){
    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';

    let table = document.createElement('table');
     //   table.classList.add('table-striped');
      //  table.classList.add('table-bordered');
        table.style = "border: none; border-spacing: 0;";

        let trHead = document.createElement('tr');
        let th1 = document.createElement('th');
        th1.innerHTML = 'Статус';
        th1.style = "border: 1px solid black;width: 10%; text-align: center;line-height: normal;";

        let th2 = document.createElement('th');
        th2.innerHTML = 'Дата подачи';
        th2.style = "border: 1px solid black;width: 10%; text-align: center;line-height: normal";

        let th3 = document.createElement('th');
        th3.innerHTML = 'Тип организации';
        th3.style = "border: 1px solid black;width: 25%; text-align: center;line-height: normal";

        let th4 = document.createElement('th');
        th4.innerHTML = 'Наименование Юр. Лица';
        th4.style = "border: 1px solid black;width: 55%; text-align: center;line-height: normal";

        let th41 = document.createElement('th');
        th41.innerHTML = 'Самооценка, %';
        th41.style = "border: 1px solid black;width: 55%; text-align: center;line-height: normal";
      //  th41.setAttribute('rowspan','2');

        let trHead2 = document.createElement('tr');
        let th5 = document.createElement('th');
        th5.innerHTML = 'Критерий';
        th5.style = "border: 1px solid black;width: 40%; text-align: center;line-height: normal";
        th5.setAttribute('colspan','3');

        let th6 = document.createElement('th');
        th6.innerHTML = 'количество';
        th6.style = "border: 1px solid black;width: 25%; text-align: center;line-height: normal";

        let th7 = document.createElement('th');
        th7.innerHTML = 'Cредняя самооценка, %';
        th7.style = "border: 1px solid black;width: 55%; text-align: center;line-height: normal";
       // th41.setAttribute('rowspan','2');

         trHead.appendChild(th4);
         trHead.appendChild(th2);
         trHead.appendChild(th3);
         trHead.appendChild(th1);
         trHead.appendChild(th41);
         table.appendChild(trHead);
         
         trHead2.appendChild(th5);
         trHead2.appendChild(th6);
         trHead2.appendChild(th7);
         table.appendChild(trHead2);

    let data = new Array();

    $.ajax({
        url: "modules/report/report_analiz_samoocenka/getReportSamoocenkaWithYurLica.php",
        method: "GET",
        data: {
            date_create_at: dataParametrs.date_create_at,
            date_create_to: dataParametrs.date_create_to, 
            oblastsId : dataParametrs.OblastsId,
            statusId : dataParametrs.StatusId,
            typeId : dataParametrs.TypeId,
            criteriaAll : dataParametrs.criteriaAll,
            criteriaIdStr: dataParametrs.criteriaIdStr,
        }
        
    }).done(function (response){
        for (let i of JSON.parse(response)){
            data.push(i);
        }
    
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);


         let id_types_tables = 0;
           if(data.length > 0){
                data.map((item,index) => {
                   

                    let idx = index-1;
                    if(index === 0){
                        idx=0;
                    }

                    let strFlag = true;

                    if(index>0){
                        if ((data[idx].status) == item['status']) {
                            if ((data[idx].date_send) == item['date_send']) {
                                if ((data[idx].type_org_name) == item['type_org_name']) {
                                    if ((data[idx].naim) == item['naim']) {
                                        strFlag = false
                                    } else {
                                        strFlag = true
                                    }
                                } else {
                                    strFlag = true
                                }

                            } else {
                                strFlag = true
                            }
                        }else {
                            strFlag = true
                        }
                       
                    }
                               
                    

                    if(strFlag == true){

                    let tr = document.createElement('tr');

                    let td1 = document.createElement('td');
                    td1.innerHTML = (index != 0)  ? ((Number(item['id_application']) == Number(data[idx].id_application)) ?  ''  : item['status']  ) : item['status'] ;
                  //  td1.style = "border: 1px solid black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; ";

                    let td2 = document.createElement('td');
                    td2.innerHTML = (index != 0) ? (item['id_application'] != data[idx].id_application) ? item['date_send'] : ''  : item['date_send'];
                 //   td2.style = "border: 1px solid black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; ";

                    let td3 = document.createElement('td');
                    td3.innerHTML = (index != 0) ? (item['id_application'] != data[idx].id_application) ? item['type_org_name'] : ''  : item['type_org_name'];
                 //   td3.style = "border: 1px solid black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; ";

                    let td4 = document.createElement('td');
                    td4.innerHTML = (index != 0) ? (item['id_application'] != data[idx].id_application) ? item['naim'] : ''  : item['naim'];
                 //   td4.style = "border: 1px solid black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; ";

                    let td41 = document.createElement('td');
                    td41.innerHTML = (index != 0) ? (item['id_application'] != data[idx].id_application) ? item['app_ocenka'] : ''  : item['app_ocenka'];

                    if(index>0){
                        td1.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal;  font-style:italic; font-size: 1.2rem; padding-top:0.7rem ";
                        td2.style = "padding: 0.2rem 0.75rem; text-align:center; line-height: normal; font-style:italic; font-size: 1.2rem; padding-top:0.7rem";
                        td3.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal; font-style:italic; font-size: 1.2rem; padding-top:0.7rem";
                        td4.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal; font-style:italic; font-size: 1.2rem; padding-top:0.7rem";
                        td41.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal; font-style:italic; font-size: 1.2rem; padding-top:0.7rem";

                    } else {
                        td1.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal;  font-style:italic; font-size: 1.2rem;  ";
                        td2.style = "padding: 0.2rem 0.75rem; text-align:center; line-height: normal; font-style:italic; font-size: 1.2rem; ";
                        td3.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal; font-style:italic; font-size: 1.2rem; ";
                        td4.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal; font-style:italic; font-size: 1.2rem; ";
                        td41.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal; font-style:italic; font-size: 1.2rem; ";
                    }

                    

                    tr.appendChild(td4);
                    
                    tr.appendChild(td2);
                    tr.appendChild(td3);
                    tr.appendChild(td1);
                    tr.appendChild(td41);
                    tbody.appendChild(tr);

                        string = item['status'] + ' ' + item['date_send'] + ' ' +item['type_org_name'] + '' +item['naim'];
                    }


                    if(id_types_tables !== Number(item['id_types_tables'])){

                        //  console.log('type_criteria', type_criteria);
                          let trNameBlok = document.createElement('tr');
                          let tdNameBlok = document.createElement('td');
  
                          tdNameBlok.innerHTML = item['type_criteria']                          
                          tdNameBlok.setAttribute('colspan',3);
      
                          if(index>0){
                              tdNameBlok.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal;  font-style:italic; font-size: 1.2rem; padding-top:0.7rem ";
                          } else {
                              tdNameBlok.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal;  font-style:italic; font-size: 1.2rem ";
                          }
      
      
                          id_types_tables = Number(item['id_types_tables']);
  
                          trNameBlok.appendChild(tdNameBlok);
                          tbody.appendChild(trNameBlok);
                      }


                    let tr2 = document.createElement('tr');
                    let td5 = document.createElement('td');
                    td5.innerHTML = item['name_criteria'];
                    td5.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; ";
                    td5.setAttribute('colspan',3);

                    let td6 = document.createElement('td');
                    td6.innerHTML = item['crit_count'];
                    td6.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                    let td7 = document.createElement('td');
                    td7.innerHTML = item['crit_src'];
                    td7.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                   
                    tr2.appendChild(td5);
                    tr2.appendChild(td6);
                    tr2.appendChild(td7);
    
                    
                    tbody.appendChild(tr2);

                })
           }

           itogOz = 0;
           itogCrit = 0;

           if(data.length > 0){
            data.map(itemOZ => {
                itogCrit = Number(itogCrit) + Number(itemOZ.crit_count)
            })

                let id_app = 0;
                data.map(itemOZ => {
                    if(id_app !== Number(itemOZ.id_application)){
                        id_app = Number(itemOZ.id_application)
                        itogOz ++
                    }
                })
   }else {
        
    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';
    divForTable.innerHTML = 'По данным параметрам нет записей';

   }

           let trItogOZ = document.createElement('tr');
           let tdItog = document.createElement('td');
           tdItog.innerHTML = 'Всего ОЗ:';
           tdItog.style = "border: 1px solid black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; font-weight: 700;";
           tdItog.setAttribute('colspan',3);

           let tdItog2 = document.createElement('td');
           tdItog2.innerHTML = itogOz;
           tdItog2.style = "border: 1px solid black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; font-weight: 700;";
           tdItog2.setAttribute('colspan',2); 

           let tdItog3 = document.createElement('td');
          // tdItog2.innerHTML = itogOz;
           tdItog3.style = "border: 1px solid black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; font-weight: 700;";

           trItogOZ.appendChild(tdItog);
           trItogOZ.appendChild(tdItog2);  
          // trItogOZ.appendChild(tdItog3);  
           tbody.appendChild(trItogOZ); 

           let trItogCrit = document.createElement('tr');
           let tdItogCrit = document.createElement('td');
           tdItogCrit.innerHTML = 'Всего критериев:';
           tdItogCrit.style = "border: 1px solid black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; font-weight: 700;";
           tdItogCrit.setAttribute('colspan',3);

           let tdItogCrit2 = document.createElement('td');
           tdItogCrit2.innerHTML = itogCrit;
           tdItogCrit2.style = "border: 1px solid black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; font-weight: 700;";
           tdItogCrit2.setAttribute('colspan',2); 

           let tdItogCrit3 = document.createElement('td');
           tdItogCrit3.style = "border: 1px solid black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; font-weight: 700;";

           trItogCrit.appendChild(tdItogCrit);
           trItogCrit.appendChild(tdItogCrit2);   
        //   trItogCrit.appendChild(tdItogCrit3);   

           tbody.appendChild(trItogCrit);



        

    });

    let divReportTitle = document.createElement('div');
    divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";
    divReportTitle.id = 'divReportTitle'
    let divReportUsl = returnReportDivUls(dataParametrs)
   //   divReportUsl.setAttribute('hidden','true');

    
       divForTable.appendChild(divReportTitle);         
       divForTable.appendChild(divReportUsl);         
       divForTable.appendChild(table); 
}

function returnReportDivUls(dataParametrs){
    let divReportUsl = document.createElement('div');
    divReportUsl.id = 'divReportUsl';
    divReportUsl.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:1.2rem; line-height: normal;";
    divReportUsl.textContent = '<b>' + `Условия отбора:`+'</b>';
    divReportUsl.innerHTML = divReportUsl.textContent + '<br/>'
    divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +'Отчетный период:'+'</b>' + ' с ' + dataParametrs.date_create_at + ' по ' + dataParametrs.date_create_to + '<br/>'
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
     
      let uslType = 'Все'; 
      if(dataParametrs.TypeStr !== ''){
         uslType = dataParametrs.TypeStr
      }  
      divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +' Тип организации: '+'</b>' + uslType + '<br/>'
     
      divReportUsl.innerHTML = divReportUsl.innerHTML +   '<b>' +' Таблицы критериев: '+'</b>' + dataParametrs.criteriaAllText;
     
      if((dataParametrs.criteriaAll == 1) && (dataParametrs.criteriaArr.length>0)) {
           let arr =  dataParametrs.criteriaArr.map(item=>{
               return item.criteria_name
           })
        
       divReportUsl.innerHTML = divReportUsl.innerHTML + '<br/>'+   '<b>' +' По критериям: '+'</b>' + arr;
        }

    return divReportUsl    
}

function chengeAllCrit(value){
    let divCrit1 = document.getElementById(`divCrit1`);  
    let divCrit2 = document.getElementById(`divCrit2`);  
    let divCrit3 = document.getElementById(`divCrit3`);  
     let divCrit4 = document.getElementById(`divCrit4`);  
     
     
     if(value==0){
       
        divCrit1.setAttribute('hidden','true');
        divCrit2.setAttribute('hidden','true');
        divCrit3.setAttribute('hidden','true');
         divCrit4.setAttribute('hidden','true');  
     
     
     } else {
        
            divCrit1.removeAttribute('hidden');
            divCrit2.removeAttribute('hidden');
            divCrit3.removeAttribute('hidden');
             divCrit4.removeAttribute('hidden');
            
     }
    
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
    tableToExcel(printMe,'Анализ результатов самооценки организаций здравоохранения', `Анализ_результатов_самооценки_организаций_здравоохранения_${new Date().toLocaleDateString()}.xls`)
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
let itemA = document.querySelector("[href=\"/index.php?report_analiz_samoocenka\"]");
itemA.style = "color: #39ff39; padding: 0rem 0rem 0rem 2rem;";