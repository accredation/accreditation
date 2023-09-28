let arrCriteriaId_report_analiz_ocenka = [];
let arrCriteriaStr_report_analiz_ocenka = [];


function CheckCriteria(elem, id_criteria){
    
    if(elem != 'checkBox'){
        let checkBox = document.getElementById(`checkbox_criteria_${id_criteria}`);
        checkBox.checked = !checkBox.checked;
    }
    
    let spanCrit = document.getElementById(`span_criteria_${id_criteria}`);

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
}

function preperaReport(){

    let reportRow = document.getElementById('reportRow');
    reportRow.style="background-color: white";

    let status = document.getElementById(`status`);
    let status_value = status.value;
    let status_text = status.options[status.options.selectedIndex].textContent;

    let dateAccept = document.getElementById(`dateAccept`);
    let dateAccept_value = dateAccept.value;

    let dateComplete = document.getElementById(`dateComplete`);
    let dateComplete_value = dateComplete.value;

    if(status_value!=1){
        if(!dateAccept_value) {
            alert('Введите дату начала периода подачи заявления')
            return
        }
    
        if(!dateComplete_value){
            alert('Введите дату завершения периода подачи заявления')
            return
        }

        if(dateAccept_value>dateComplete_value) {
            alert('Неверно заданы даты отчетного периода')
            return
        }
    }
    
   
    let btnReport = document.getElementById(`btnReport`);
    btnReport.setAttribute('disabled', 'true');

    let btnReportPrint = document.getElementById(`btnReportPrint`);
    btnReportPrint.removeAttribute('disabled')

    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';

    let oblast = document.getElementById(`oblast`);
    let oblast_value = oblast.value;
    let oblast_text = oblast.options[oblast.options.selectedIndex].textContent;
    
    let typeOrg = document.getElementById(`typeOrg`);
    let typeOrg_value = typeOrg.value;
    let typeOrg_text = typeOrg.options[typeOrg.options.selectedIndex].textContent;

    let criteriaAll = document.getElementById(`criteriaAll`);
    let criteriaAll_value = criteriaAll.value;
    let criteriaAll_text = criteriaAll.options[criteriaAll.options.selectedIndex].textContent;


    let flag_yur_lica = document.getElementById(`flag_yur_lica`);
    let flag_yur_lica_value = flag_yur_lica.checked;
    

    if(flag_yur_lica_value){
        reportYurLica(oblast_value,oblast_text, status_value,status_text, dateAccept_value, dateComplete_value, typeOrg_value,typeOrg_text, criteriaAll_value,criteriaAll_text, arrCriteriaId_report_analiz_ocenka.toString())
    } else {
        reportWithOutYurLica(oblast_value,oblast_text, status_value,status_text, dateAccept_value, dateComplete_value, typeOrg_value,typeOrg_text, criteriaAll_value,criteriaAll_text, arrCriteriaId_report_analiz_ocenka.toString())
    }

    btnReport.removeAttribute('disabled');
}


function reportWithOutYurLica(oblast_value,oblast_text, status_value,status_text, dateAccept_value, dateComplete_value, typeOrg_value,typeOrg_text, criteriaAll_value,criteriaAll_text, arrCriteriaId_str){
    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';

    
    let data = new Array();

    $.ajax({
        url: "modules/report/report_analiz_ocenka/getReportOcenkaWithOutYurLica.php",
        method: "GET",
        data: {id_oblast: oblast_value, id_status: status_value, dateAccept: dateAccept_value, 
            dateComplete: dateComplete_value, id_type_org: typeOrg_value, criteriaAll: criteriaAll_value, id_scriteria_str: arrCriteriaId_str}
        
    }).done(function (response){
        for (let i of JSON.parse(response)){
            data.push(i);
        }
        
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
     
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);

         let type_criteria = 0;
           if(data.length > 0){
                data.map((item,index) => {
                                        
                    if(type_criteria !== Number(item['type_criteria'])){

                      //  console.log('type_criteria', type_criteria);
                        let trNameBlok = document.createElement('tr');
                        let tdNameBlok = document.createElement('td');

                        if(item['type_criteria'] == '1'){
                            tdNameBlok.innerHTML = 'Общие критерии';
                        }
                        if(item['type_criteria'] == '2'){
                            tdNameBlok.innerHTML = 'Профильные критерии';
                        }
                        if(item['type_criteria'] == '3'){
                            tdNameBlok.innerHTML = 'Дополнительные критерии';
                        }
                        
                        tdNameBlok.setAttribute('colspan',3);
    
                        if(index>0){
                            tdNameBlok.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal;  font-style:italic; font-size: 1.2rem; padding-top:0.7rem ";
                        } else {
                            tdNameBlok.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal;  font-style:italic; font-size: 1.2rem ";
                        }
    
    
                        type_criteria = Number(item['type_criteria']);

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
           }

         let divReportTitle = document.createElement('div');
         divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";

        let select1 = document.getElementById("oblast");
        let value1 = select1.options[select1.selectedIndex].innerText;

        let select2 = document.getElementById("status");
        let value2 = select2.options[select2.selectedIndex].innerText;

        let date1 = document.getElementById("dateAccept");
        let date2 = document.getElementById("dateComplete");
        let typeO = document.getElementById("typeOrg");
        let value3 = typeO.options[typeO.selectedIndex].innerText;

        divReportTitle.textContent = `Анализ результатов медицинской аккредитации`;
        //: регион "` + value1 +`", со статусом "` + value2 + `", в период с `+  new Date(date1.value).toLocaleDateString() +` по ` +  new Date(date2.value).toLocaleDateString() +`; тип организации "` + value3 +`"`;

         let divReportUsl = document.createElement('div');
         divReportUsl.id = 'divReportUsl';
         divReportUsl.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:1.2rem; line-height: normal;";
         divReportUsl.textContent = '<b>' + `Условия отбора:`+'</b>';
         divReportUsl.innerHTML = divReportUsl.textContent + '<br/>'

           divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +' Статус: '+'</b>' + status_text + '<br/>'

           if(status_value!=1) {
            divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +' Период:'+'</b>' + ' с' + dateAccept_value + ' по ' + dateComplete_value + '<br/>'
           }

           divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' + ' Область:'+'</b>' + oblast_text + '<br/>'
           divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +' Тип организации: '+'</b>' + typeOrg_text + '<br/>'
           
           
           divReportUsl.innerHTML = divReportUsl.innerHTML +   '<b>' +' Таблицы критериев: '+'</b>' + criteriaAll_text;
          
           if((criteriaAll_value == 1) && (arrCriteriaStr_report_analiz_ocenka.length>0)) {
                let arr =  arrCriteriaStr_report_analiz_ocenka.map(item=>{
                    return item.criteria_name
                })
            divReportUsl.innerHTML = divReportUsl.innerHTML + '<br/>'+   '<b>' +' По критериям: '+'</b>' + arr;
           }
           

        //   divReportUsl.setAttribute('hidden','true');

         
            divForTable.appendChild(divReportTitle);         
            divForTable.appendChild(divReportUsl);         
            divForTable.appendChild(table); 
         

    });
}

function reportYurLica(oblast_value,oblast_text, status_value,status_text, dateAccept_value, dateComplete_value, typeOrg_value,typeOrg_text, criteriaAll_value,criteriaAll_text, arrCriteriaId_str){
    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';

    let data = new Array();

    $.ajax({
        url: "modules/report/report_analiz_samoocenka/getReportSamoocenkaWithYurLica.php",
        method: "GET",
        data: {id_oblast: oblast_value, id_status: status_value, dateAccept: dateAccept_value, 
            dateComplete: dateComplete_value, id_type_org: typeOrg_value, criteriaAll: criteriaAll_value, id_scriteria_str: arrCriteriaId_str}
        
    }).done(function (response){
        for (let i of JSON.parse(response)){
            data.push(i);
        }


     //   console.log(data);

         
        
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
        th41.innerHTML = 'Оценка, %';
        th41.style = "border: 1px solid black;width: 55%; text-align: center;line-height: normal";
      //  th41.setAttribute('rowspan','2');

        let trHead2 = document.createElement('tr');
        let th5 = document.createElement('th');
        th5.innerHTML = 'Критерий';
        th5.style = "border: 1px solid black;width: 40%; text-align: center;line-height: normal";
        th5.setAttribute('colspan','3');

        let th6 = document.createElement('th');
        th6.innerHTML = 'Количество';
        th6.style = "border: 1px solid black;width: 25%; text-align: center;line-height: normal";

        let th7 = document.createElement('th');
        th7.innerHTML = 'Cредняя оценка, %';
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
     
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);


         let type_criteria = 0;
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


                    if(type_criteria !== Number(item['type_criteria'])){

                        //  console.log('type_criteria', type_criteria);
                          let trNameBlok = document.createElement('tr');
                          let tdNameBlok = document.createElement('td');
  
                          if(item['type_criteria'] == '1'){
                              tdNameBlok.innerHTML = 'Общие критерии';
                          }
                          if(item['type_criteria'] == '2'){
                              tdNameBlok.innerHTML = 'Профильные критерии';
                          }
                          if(item['type_criteria'] == '3'){
                              tdNameBlok.innerHTML = 'Дополнительные критерии';
                          }
                          
                          tdNameBlok.setAttribute('colspan',3);
      
                          if(index>0){
                              tdNameBlok.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal;  font-style:italic; font-size: 1.2rem; padding-top:0.7rem ";
                          } else {
                              tdNameBlok.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal;  font-style:italic; font-size: 1.2rem ";
                          }
      
      
                          type_criteria = Number(item['type_criteria']);
  
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
         //  trItogOZ.appendChild(tdItog3);  
           tbody.appendChild(trItogOZ); 

           let trItogCrit = document.createElement('tr');
           let tdItogCrit = document.createElement('td');
           tdItogCrit.innerHTML = 'Всего критериев:';
           tdItogCrit.style = "border: 1px solid black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; font-weight: 700;";
           tdItogCrit.setAttribute('colspan',3);

           let tdItogCrit2 = document.createElement('td');
           tdItogCrit2.innerHTML = itogCrit;
           tdItogCrit2.style = "border: 1px solid black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; font-weight: 700;";
           tdItogCrit.setAttribute('colspan',2);

           let tdItogCrit3 = document.createElement('td');
           tdItogCrit3.style = "border: 1px solid black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; font-weight: 700;";

           trItogCrit.appendChild(tdItogCrit);
           trItogCrit.appendChild(tdItogCrit2);   
         //  trItogCrit.appendChild(tdItogCrit3);   

           tbody.appendChild(trItogCrit);


         let divReportTitle = document.createElement('div');
         divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";
        let select1 = document.getElementById("oblast");
        let value1 = select1.options[select1.selectedIndex].innerText;

        let select2 = document.getElementById("status");
        let value2 = select2.options[select2.selectedIndex].innerText;

        let date1 = document.getElementById("dateAccept");
        let date2 = document.getElementById("dateComplete");
        let typeO = document.getElementById("typeOrg");
        let value3 = typeO.options[typeO.selectedIndex].innerText;

        divReportTitle.textContent = `Анализ результатов медицинской аккредитации`;
         // : регион "` + value1 +`", со статусом "` + value2 + `", в период с `+  new Date(date1.value).toLocaleDateString() +` по ` +  new Date(date2.value).toLocaleDateString() +`; тип организации "` + value3 +`"`;


        let divReportUsl = document.createElement('div');
         divReportUsl.id = 'divReportUsl';
         divReportUsl.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:1.2rem; line-height: normal;";
         divReportUsl.textContent = '<b>' + `Условия отбора:`+'</b>';
         divReportUsl.innerHTML = divReportUsl.textContent + '<br/>'

           
           divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +' Статус: '+'</b>' + status_text + '<br/>'

           if(status_value!=1) {
            divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +' Период:'+'</b>' + ' с ' + dateAccept_value + ' по ' + dateComplete_value + '<br/>'
           }

           divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' + ' Область:'+'</b>' + oblast_text + '<br/>'
           divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +' Тип организации: '+'</b>' + typeOrg_text + '<br/>'
           divReportUsl.innerHTML = divReportUsl.innerHTML +   '<b>' +' Таблицы критериев: '+'</b>' + criteriaAll_text;
          
           if((criteriaAll_value == 1) && (arrCriteriaStr_report_analiz_ocenka.length>0)) {
                let arr =  arrCriteriaStr_report_analiz_ocenka.map(item=>{
                    return item.criteria_name
                })
            divReportUsl.innerHTML = divReportUsl.innerHTML + '<br/>'+   '<b>' +' По критериям: '+'</b>' + arr;
           }
           

        //   divReportUsl.setAttribute('hidden','true');

         
            divForTable.appendChild(divReportTitle);         
            divForTable.appendChild(divReportUsl);         
            divForTable.appendChild(table); 

    });
}

function chengeAllCrit(value){
    let divCrit1 = document.getElementById(`divCrit1`);  
    let divCrit2 = document.getElementById(`divCrit2`);  
    let divCrit3 = document.getElementById(`divCrit3`);  
    
    if(value==0){
      
        divCrit1.setAttribute('hidden','true');
        divCrit2.setAttribute('hidden','true');
        divCrit3.setAttribute('hidden','true');
    
    } else {
       
            divCrit1.removeAttribute('hidden');
            divCrit2.removeAttribute('hidden');
            divCrit3.removeAttribute('hidden');
           
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

let ui_reports = document.getElementById("ui-reports");
ui_reports.classList.add("show");
let itemMenu = document.querySelector("[href=\"#ui-reports\"]");
itemMenu.classList.add("collapsed");
itemMenu.setAttribute("aria-expanded", "true");
itemMenu.children[1].style = "color: #00e735";
document.getElementById("nav1").classList.remove("active");
let itemA = document.querySelector("[href=\"/index.php?report_analiz_ocenka\"]");
itemA.style = "color: #39ff39; padding: 0rem 0rem 0rem 2rem;";