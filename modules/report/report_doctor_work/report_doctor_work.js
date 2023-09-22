
function preperaReport(){

    let reportRow = document.getElementById('reportRow');
    reportRow.style="background-color: white";

    let status = document.getElementById(`status`);
    let status_value = status.value;
    let status_text = status.options[status_value].textContent;

    let dateAccept = document.getElementById(`dateAccept`);
    let dateAccept_value = dateAccept.value;

    let dateComplete = document.getElementById(`dateComplete`);
    let dateComplete_value = dateComplete.value;

    if(status_value!=1){
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
    }
    
   
    let btnReport = document.getElementById(`btnReport`);
    btnReport.setAttribute('disabled', 'true');

    let btnReportPrint = document.getElementById(`btnReportPrint`);
    btnReportPrint.removeAttribute('disabled')

    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';

    reportDoctorWork(status_value,status_text, dateAccept_value, dateComplete_value)  

    btnReport.removeAttribute('disabled');
}


function reportDoctorWork(status_value,status_text, dateAccept_value, dateComplete_value){
    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';

    
    let data = new Array();

    $.ajax({
        url: "modules/report/report_doctor_work/getReportDoctorWork.php",
        method: "GET",
        data: {id_status: status_value, dateAccept: dateAccept_value, dateComplete: dateComplete_value}
        
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
        th1.innerHTML = 'ФИО врача-эксперта';
        th1.style = "border: 1px solid black;width: 10%; text-align: center;line-height: normal;";

        let th2 = document.createElement('th');
        th2.innerHTML = 'Количество ОЗ, всего';
        th2.style = "border: 1px solid black;width: 10%; text-align: center;line-height: normal";

        let th3 = document.createElement('th');
        th3.innerHTML = 'Количество критериев, всего';
        th3.style = "border: 1px solid black;width: 25%; text-align: center;line-height: normal";

        let th4 = document.createElement('th');
       // th4.innerHTML = 'Количество критериев, всего';
        th4.style = "border: 1px solid black;width: 25%; text-align: center;line-height: normal";


        let th5 = document.createElement('th');
       // th5.innerHTML = 'Количество критериев, всего';
        th5.style = "border: 1px solid black;width: 25%; text-align: center;line-height: normal";

        let th6 = document.createElement('th');
        th6.innerHTML = 'Результат оценки, % ';
        th6.style = "border: 1px solid black;width: 25%; text-align: center;line-height: normal";

         trHead.appendChild(th1);
         trHead.appendChild(th2);
         trHead.appendChild(th3);
         trHead.appendChild(th4);
         trHead.appendChild(th5);
         trHead.appendChild(th6);
     
         table.appendChild(trHead);
     
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);

         let type_criteria = 0;
         let user_id = 0;
         let app_id =0;
           if(data.length > 0){
                data.map((item,index) => {
                    
                    if(user_id!== Number(item['id_user'])) {
                        let trDoctor = document.createElement('tr');
                        trDoctor.style = 'margin-top: 1rem'

                        let tdDoctor = document.createElement('td');
                        tdDoctor.innerHTML = item['username'];

                        let countCrit = data.filter(filitem => filitem.id_user == item['id_user'])
                       

                        let id_app = 0;
                        let countOZ = 0; 
                        countCrit.map(itemOZ => {
                            if(id_app !== Number(itemOZ.id_application)){
                                id_app = Number(itemOZ.id_application)
                                countOZ ++
                            }
                        })
                                
                       //console.log(countOZ)

                        let tdDoctorOZ = document.createElement('td');
                        tdDoctorOZ.innerHTML = countOZ;
                      
                        let tdDoctorCrit = document.createElement('td');
                        tdDoctorCrit.innerHTML = countCrit.length;
                      
                        let tdDoctor1 = document.createElement('td');
                    //    tdDoctor1.innerHTML = countCrit.length;
                      
                        let tdDoctor2 = document.createElement('td');
                   //     tdDoctor2.innerHTML = item['crit_src'];
                      
                        let tdDoctor3 = document.createElement('td');
                   //     tdDoctor3.innerHTML = item['crit_src'];
                       


                        if(index>0){
                            tdDoctor.style = " padding: 0.2rem 0.75rem;text-align:left;line-height: normal; font-style: italic; font-weight: 700; font-size: 1.2rem; padding-top:1rem ";
                            tdDoctorOZ.style = "padding: 0.2rem 0.75rem;text-align:center;line-height: normal; font-style: italic; font-weight: 700; font-size: 1.2rem; padding-top:1rem";
                            tdDoctorCrit.style = "padding: 0.2rem 0.75rem;text-align:center;line-height: normal; font-style: italic; font-weight: 700; font-size: 1.2rem; padding-top:1rem";
                            tdDoctor1.style = " padding: 0.2rem 0.75rem;text-align:left;line-height: normal; font-style: italic; font-weight: 700; font-size: 1.2rem; padding-top:1rem";
                            tdDoctor2.style = " padding: 0.2rem 0.75rem;text-align:left;line-height: normal; font-style: italic; font-weight: 700; font-size: 1.2rem; padding-top:1rem";
                            tdDoctor3.style = " padding: 0.2rem 0.75rem;text-align:left;line-height: normal; font-style: italic; font-weight: 700; font-size: 1.2rem; padding-top:1rem";
                            
                        } else {
                            tdDoctor.style = " padding: 0.2rem 0.75rem;text-align:left;line-height: normal; font-style: italic; font-weight: 700; font-size: 1.2rem; ";
                            tdDoctorOZ.style = "padding: 0.2rem 0.75rem;text-align:center;line-height: normal; font-style: italic; font-weight: 700; font-size: 1.2rem;";
                            tdDoctorCrit.style = "padding: 0.2rem 0.75rem;text-align:center;line-height: normal; font-style: italic; font-weight: 700; font-size: 1.2rem;";
                            tdDoctor1.style = " padding: 0.2rem 0.75rem;text-align:center;line-height: normal;";
                            tdDoctor2.style = " padding: 0.2rem 0.75rem;text-align:center;line-height: normal;";
                            tdDoctor3.style = " padding: 0.2rem 0.75rem;text-align:center;line-height: normal;";
                        }

                        trDoctor.appendChild(tdDoctor);
                        trDoctor.appendChild(tdDoctorOZ);
                        trDoctor.appendChild(tdDoctorCrit);
                        trDoctor.appendChild(tdDoctor1);
                        trDoctor.appendChild(tdDoctor2);
                        trDoctor.appendChild(tdDoctor3);

                        
                        tbody.appendChild(trDoctor);
                        user_id =  Number(item['id_user']);
                        type_criteria = 0;
                        app_id = 0;
                        num_str_org = 1;
                    }


                    if( app_id !== Number(item['id_application'])) {
                        let trOz = document.createElement('tr');
                        trOz.style = 'margin-top: 1rem'

                        let tdOz1 = document.createElement('td');
                        tdOz1.innerHTML = num_str_org +'. '+ item['naim'];
                        tdOz1.style = "padding: 0.2rem 0.75rem;text-align:left;line-height: normal; font-style: italic; font-weight: 700;";
                        tdOz1.setAttribute('colspan',2);
                    
                        let tdOz2 = document.createElement('td');
                        tdOz2.innerHTML = item['date_accept'];
                        tdOz2.style = " padding: 0.2rem 0.75rem;text-align:center;line-height: normal; font-style: italic; font-weight: 700;";

                        let tdOz3 = document.createElement('td');
                        tdOz3.innerHTML = item['date_complete'];
                        tdOz3.style = " padding: 0.2rem 0.75rem;text-align:center;line-height: normal; font-style: italic; font-weight: 700;";

                        let tdOz4 = document.createElement('td');
                        tdOz4.innerHTML = item['date_council'];
                        tdOz4.style = " padding: 0.2rem 0.75rem;text-align:center;line-height: normal; font-style: italic; font-weight: 700;";

                        let tdOz5 = document.createElement('td');
                        tdOz5.innerHTML = item['app_ocenka'];
                        tdOz5.style = " padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                        let tdOz6 = document.createElement('td');
                      //  tdOz6.innerHTML = num_str_org;
                        tdOz6.style = "  ";


                            tdOz1.style = "border-bottom: 1px solid black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; font-style: italic;  font-size: 1.2rem; padding-top:1rem ";
                            tdOz2.style = "border-bottom: 1px solid black;padding: 0.2rem 0.75rem;text-align:left;line-height: normal; font-style: italic;  font-size: 1.2rem; padding-top:1rem";
                            tdOz3.style = "border-bottom: 1px solid black;padding: 0.2rem 0.75rem;text-align:left;line-height: normal; font-style: italic;  font-size: 1.2rem; padding-top:1rem";
                            tdOz4.style = "border-bottom: 1px solid black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; font-style: italic;  font-size: 1.2rem; padding-top:1rem";
                            tdOz5.style = "border-bottom: 1px solid black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; font-style: italic;  font-size: 1.2rem; padding-top:1rem";
                            tdOz6.style = "border-bottom: 1px solid black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; font-style: italic;  font-size: 1.2rem; padding-top:1rem";
                            

                     //   trOz.appendChild(tdOz6);
                        trOz.appendChild(tdOz1);
                        trOz.appendChild(tdOz2);
                        trOz.appendChild(tdOz3);
                        trOz.appendChild(tdOz4);
                        trOz.appendChild(tdOz5);
                        

                        
                        tbody.appendChild(trOz);
                        user_id =  Number(item['id_user']);
                        type_criteria = 0;
                        app_id = Number(item['id_application']);
                        num_str_org ++;
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
                        
                        tdNameBlok.setAttribute('colspan',6);
    
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

              // $username, id_user $id_application, $naim , $date_accept, $date_complete, $date_council, $name_criteria, $type_criteria, $id_criteria, $crit_src, $app_ocenka; 
              
              
                    let tr2 = document.createElement('tr');
                    let td5 = document.createElement('td');
                    td5.innerHTML = item['name_criteria'];
                    td5.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; ";
                    td5.setAttribute('colspan',2);
                  
                    let td6 = document.createElement('td');
                  //  td6.innerHTML = item['date_accept'];
                    td6.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                    let td7 = document.createElement('td');
               //     td7.innerHTML = item['date_complete'];
                    td7.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                    let td8 = document.createElement('td');
                //    td8.innerHTML = item['date_council'];
                    td8.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                    let td9 = document.createElement('td');
                    td9.innerHTML = item['crit_src'];
                    td9.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                    tr2.appendChild(td5);
                    tr2.appendChild(td6);
                    tr2.appendChild(td7);
                    tr2.appendChild(td8);
                    tr2.appendChild(td9);

                    
                    tbody.appendChild(tr2);

                })
           }

         let divReportTitle = document.createElement('div');
         divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";

       
        let select2 = document.getElementById("status");
        let value2 = select2.options[select2.selectedIndex].innerText;

        let date1 = document.getElementById("dateAccept");
        let date2 = document.getElementById("dateComplete");
       

        divReportTitle.textContent = `Нагрузка врачей-экспертов`;
        //: регион "` + value1 +`", со статусом "` + value2 + `", в период с `+  new Date(date1.value).toLocaleDateString() +` по ` +  new Date(date2.value).toLocaleDateString() +`; тип организации "` + value3 +`"`;

         let divReportUsl = document.createElement('div');
         divReportUsl.id = 'divReportUsl';
         divReportUsl.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:1.2rem; line-height: normal;";
         divReportUsl.textContent = '<b>' + `Условия отбора:`+'</b>';
         divReportUsl.innerHTML = divReportUsl.textContent + '<br/>'

         divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +' Статус: '+'</b>' + status_text + '<br/>'
         divReportUsl.innerHTML = divReportUsl.innerHTML + '<b>' +' Период:'+'</b>' + ' с ' + dateAccept_value + ' по ' + dateComplete_value + '<br/>'       

           divReportUsl.setAttribute('hidden','true');

         
            divForTable.appendChild(divReportTitle);         
            divForTable.appendChild(divReportUsl);         
            divForTable.appendChild(table); 
         

    });
}



function printReport(){    

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
let itemA = document.querySelector("[href=\"/index.php?report_doctor_work\"]");
itemA.style = "color: #39ff39; padding: 0rem 0rem 0rem 2rem;";