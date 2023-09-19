let arrCriteriaId = [];
let arrCriteriaStr = [];


function CheckCriteria(elem, id_criteria){
    
    if(elem != 'checkBox'){
        let checkBox = document.getElementById(`checkbox_criteria_${id_criteria}`);
        checkBox.checked = !checkBox.checked;
    }
    
    let spanCrit = document.getElementById(`span_criteria_${id_criteria}`);

    //console.log(spanCrit.textContent);
    let spanCrit_str = spanCrit.textContent;

    if(arrCriteriaId.includes(id_criteria)){
        arrCriteriaId = arrCriteriaId.filter(item => item !== id_criteria);
        arrCriteriaStr = arrCriteriaStr.filter(item => item.id_criteria !== id_criteria);
    } else {
        arrCriteriaId = [...arrCriteriaId, id_criteria];
        arrCriteriaStr = [...arrCriteriaStr, {id_criteria, criteria_name: spanCrit_str} ]
    }


    if(!btnReportPrint.hasAttribute('disabled')){
        btnReportPrint.setAttribute('disabled','true')
    }
}

function preperaReport(){

    let status = document.getElementById(`status`);
    let status_value = status.value;
    let status_text = status.options[status_value].textContent;

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
    }
    
   
    let btnReport = document.getElementById(`btnReport`);
    btnReport.setAttribute('disabled', 'true');

    let btnReportPrint = document.getElementById(`btnReportPrint`);
    btnReportPrint.removeAttribute('disabled')

    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';

    let oblast = document.getElementById(`oblast`);
    let oblast_value = oblast.value;
    let oblast_text = oblast.options[oblast_value].textContent;
    
    let typeOrg = document.getElementById(`typeOrg`);
    let typeOrg_value = typeOrg.value;
    let typeOrg_text = typeOrg.options[typeOrg_value].textContent;

    let criteriaAll = document.getElementById(`criteriaAll`);
    let criteriaAll_value = criteriaAll.value;
    let criteriaAll_text = criteriaAll.options[criteriaAll_value].textContent;


    let flag_yur_lica = document.getElementById(`flag_yur_lica`);
    let flag_yur_lica_value = flag_yur_lica.checked;
    
 //   console.log(oblast_value, status_value, dateAccept_value, dateComplete_value, typeOrg_value, criteriaAll_value)

    if(flag_yur_lica_value){
        console.log('1');
        reportWithOutYurLica(oblast_value,oblast_text, status_value,status_text, dateAccept_value, dateComplete_value, typeOrg_value,typeOrg_text, criteriaAll_value,criteriaAll_text, arrCriteriaId.toString())
    } else {
        console.log('2');
        reportYurLica(oblast_value,oblast_text, status_value,status_text, dateAccept_value, dateComplete_value, typeOrg_value,typeOrg_text, criteriaAll_value,criteriaAll_text, arrCriteriaId.toString())
    }

    btnReport.removeAttribute('disabled');
}


function reportYurLica(oblast_value,oblast_text, status_value,status_text, dateAccept_value, dateComplete_value, typeOrg_value,typeOrg_text, criteriaAll_value,criteriaAll_text, arrCriteriaId_str){
    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';

    
    let data = new Array();

    $.ajax({
        url: "modules/report/report_first/getReportFirstYurLica.php",
        method: "GET",
        data: {id_oblast: oblast_value, id_status: status_value, dateAccept: dateAccept_value, 
            dateComplete: dateComplete_value, id_type_org: typeOrg_value, criteriaAll: criteriaAll_value, id_scriteria_str: arrCriteriaId_str}
        
    }).done(function (response){
        for (let i of JSON.parse(response)){
            data.push(i);
        }
        
        let table = document.createElement('table');
    //    table.classList.add('table-striped');
    //    table.classList.add('table-bordered');
        table.style = " border-spacing: 0; border: none";

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


        let trHead2 = document.createElement('tr');


        let th5 = document.createElement('th');
        th5.innerHTML = 'Критерий';
        th5.style = "border: 1px solid black;width: 40%; text-align: left;line-height: normal";
        th5.setAttribute('colspan','2');

        let th6 = document.createElement('th');
        th6.innerHTML = 'количество';
        th6.style = "border: 1px solid black;width: 25%; text-align: center;line-height: normal";

         trHead.appendChild(th1);
         trHead.appendChild(th2);
         trHead.appendChild(th3);

         trHead2.appendChild(th5);
         trHead2.appendChild(th6);
     
         table.appendChild(trHead);
         table.appendChild(trHead2);
     
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);

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
                                    strFlag = false
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
                        td1.innerHTML = item['status'];                        
                        
                        let td2 = document.createElement('td');
                        td2.innerHTML = (index != 0) ? (item['date_send'] != data[idx].date_send) ? item['date_send'] : ''  : item['date_send'];                        
                       
                        let td3 = document.createElement('td');
                        td3.innerHTML = item['type_org_name'] ;                        
                        
                        if(index>0){
                            td1.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal;  font-style:italic; font-size: 1.2rem; padding-top:0.7rem ";
                            td2.style = "padding: 0.2rem 0.75rem; text-align:center; line-height: normal; font-style:italic; font-size: 1.2rem; padding-top:0.7rem";
                            td3.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal; font-style:italic; font-size: 1.2rem; padding-top:0.7rem";

                        } else {
                            td1.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal;  font-style:italic; font-size: 1.2rem ";
                            td2.style = "padding: 0.2rem 0.75rem; text-align:center; line-height: normal; font-style:italic; font-size: 1.2rem";
                            td3.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal; font-style:italic; font-size: 1.2rem";
                        }

                        tr.appendChild(td1);
                        tr.appendChild(td2);
                        tr.appendChild(td3);
                        tbody.appendChild(tr);

                        string = item['status'] + ' ' + item['date_send'] + ' ' +item['type_org_name'];
                       
                    }

                    
                    let tr2 = document.createElement('tr');
                    let td5 = document.createElement('td');
                    td5.innerHTML = item['name_criteria'];
                    td5.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; ";
                    td5.setAttribute('colspan',2);
                  
                    let td6 = document.createElement('td');
                    td6.innerHTML = item['crit_count'];
                    td6.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; ";

                    tr2.appendChild(td5);
                    tr2.appendChild(td6);
                    
                    tbody.appendChild(tr2);

                })
           }

         let divReportTitle = document.createElement('div');
         divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";
         divReportTitle.textContent = `Отчет`;

         let divReportUsl = document.createElement('div');
         divReportUsl.id = 'divReportUsl';
         divReportUsl.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:1.2rem; line-height: normal;";
         divReportUsl.textContent = '<b>' + `Условия отбора:`+'</b>';
         divReportUsl.innerHTML = divReportUsl.textContent + '<br/>'

           if(status_value!=0) {
            divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +' Статус: '+'</b>' + status_text + '<br/>'
           }

           if(status_value!=1) {
            divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +' Период:'+'</b>' + ' с' + dateAccept_value + ' по ' + dateComplete_value + '<br/>'
           }

           if(oblast_value!=0) {
            divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' + ' Область:'+'</b>' + oblast_text + '<br/>'
           }

           if(typeOrg_value!=0) {
            divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +' Тип организации: '+'</b>' + typeOrg_text + '<br/>'
           }

           
           divReportUsl.innerHTML = divReportUsl.innerHTML +   '<b>' +' Таблицы критериев: '+'</b>' + criteriaAll_text;
          
           if((criteriaAll_value == 1) && (arrCriteriaStr.length>0)) {
                let arr =  arrCriteriaStr.map(item=>{
                    return item.criteria_name
                })
            divReportUsl.innerHTML = divReportUsl.innerHTML + '<br/>'+   '<b>' +' По критериям: '+'</b>' + arr;
           }
           

           divReportUsl.setAttribute('hidden','true');

         
            divForTable.appendChild(divReportTitle);         
            divForTable.appendChild(divReportUsl);         
            divForTable.appendChild(table); 
         

    });
}

function reportWithOutYurLica(oblast_value,oblast_text, status_value,status_text, dateAccept_value, dateComplete_value, typeOrg_value,typeOrg_text, criteriaAll_value,criteriaAll_text, arrCriteriaId_str){
    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';
    
    let data = new Array();

    $.ajax({
        url: "modules/report/report_first/getReportFirst.php",
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

        let trHead2 = document.createElement('tr');
        let th5 = document.createElement('th');
        th5.innerHTML = 'Критерий';
        th5.style = "border: 1px solid black;width: 40%; text-align: center;line-height: normal";
        th5.setAttribute('colspan','3');

        let th6 = document.createElement('th');
        th6.innerHTML = 'количество';
        th6.style = "border: 1px solid black;width: 25%; text-align: center;line-height: normal";

         trHead.appendChild(th1);
         trHead.appendChild(th2);
         trHead.appendChild(th3);
         trHead.appendChild(th4);
         table.appendChild(trHead);
         
         trHead2.appendChild(th5);
         trHead2.appendChild(th6);
         table.appendChild(trHead2);
     
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);


        
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
                                    strFlag = false
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

                    if(index>0){
                        td1.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal;  font-style:italic; font-size: 1.2rem; padding-top:0.7rem ";
                        td2.style = "padding: 0.2rem 0.75rem; text-align:center; line-height: normal; font-style:italic; font-size: 1.2rem; padding-top:0.7rem";
                        td3.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal; font-style:italic; font-size: 1.2rem; padding-top:0.7rem";
                        td4.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal; font-style:italic; font-size: 1.2rem; padding-top:0.7rem";

                    } else {
                        td1.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal;  font-style:italic; font-size: 1.2rem;  ";
                        td2.style = "padding: 0.2rem 0.75rem; text-align:center; line-height: normal; font-style:italic; font-size: 1.2rem; ";
                        td3.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal; font-style:italic; font-size: 1.2rem; ";
                        td4.style = " padding: 0.2rem 0.75rem; text-align:center; line-height: normal; font-style:italic; font-size: 1.2rem; ";
                    }

                    

                    tr.appendChild(td1);
                    tr.appendChild(td2);
                    tr.appendChild(td3);
                    tr.appendChild(td4);
                    tbody.appendChild(tr);

                    }

                    let tr2 = document.createElement('tr');
                    let td5 = document.createElement('td');
                    td5.innerHTML = item['name_criteria'];
                    td5.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; ";
                    td5.setAttribute('colspan',3);

                    let td6 = document.createElement('td');
                    td6.innerHTML = item['crit_count'];
                    td6.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; ";

                   
                    tr2.appendChild(td5);
                    tr2.appendChild(td6);
    
                    
                    tbody.appendChild(tr2);

                })
           }

         let divReportTitle = document.createElement('div');
         divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";
         divReportTitle.textContent = `Отчет`;

         let divReportUsl = document.createElement('div');
         divReportUsl.id = 'divReportUsl';
         divReportUsl.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:1.2rem; line-height: normal;";
         divReportUsl.textContent = '<b>' + `Условия отбора:`+'</b>';
         divReportUsl.innerHTML = divReportUsl.textContent + '<br/>'

           if(status_value!=0) {
            divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +' Статус: '+'</b>' + status_text + '<br/>'
           }

           if(status_value!=1) {
            divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +' Период:'+'</b>' + ' с' + dateAccept_value + ' по ' + dateComplete_value + '<br/>'
           }

           if(oblast_value!=0) {
            divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' + ' Область:'+'</b>' + oblast_text + '<br/>'
           }

           if(typeOrg_value!=0) {
            divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +' Тип организации: '+'</b>' + typeOrg_text + '<br/>'
           }

           
           divReportUsl.innerHTML = divReportUsl.innerHTML +   '<b>' +' Таблицы критериев: '+'</b>' + criteriaAll_text;
          
           if((criteriaAll_value == 1) && (arrCriteriaStr.length>0)) {
                let arr =  arrCriteriaStr.map(item=>{
                    return item.criteria_name
                })
            divReportUsl.innerHTML = divReportUsl.innerHTML + '<br/>'+   '<b>' +' По критериям: '+'</b>' + arr;
           }
           

           divReportUsl.setAttribute('hidden','true');

         
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