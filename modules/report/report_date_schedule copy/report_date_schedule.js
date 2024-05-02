

let checkContacktValue = false; 
let arrOblastId_journal_rkk = [];
let arrOblastSTR_journal_rkk = [];

function CheckCheckBoxElement(elem, element_name){
    
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


function CheckCheckBoxOblastElement(elem, index){

    let checkBox = document.getElementById(`checkbox_oblast_${index}`);
    if(elem != 'checkBox'){   
        checkBox.checked = !checkBox.checked;
    }

    let oblast = document.getElementsByClassName('oblast');

    if(index===0){
        if (oblast.length !== 0) {
            for (let i = 0; i < oblast.length; i++) {
                let checkBox1 = document.getElementById(`checkbox_oblast_${oblast[i].id}`);
                checkBox1.checked = checkBox.checked;
            }
        }
    }


    if(index!==0){
        let checkBox1 = document.getElementById(`checkbox_oblast_0`);
        checkBox1.checked = false;
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
        period: 0,
        period_at:null,
        period_to:null,
        type_report : 1,
        year_schedule: 0, 
        count_day: 0, 
        checkAllOblast : false,
        checkOblasts : '',
        checkOblastsId : '',

    }

    


    let period_at = document.getElementById(`period_at`).value;
   
    dataParametrs.period_at = period_at;

    let period_to = document.getElementById(`period_to`).value;
    dataParametrs.period_to = period_to;

    let period = validateDate(period_at, period_to, 'period')
    if (period == -1){
        return
    }
    dataParametrs.period = period


    let radio_type_report = document.getElementById(`radio_type_report`);
    let type_report_ = radio_type_report.getElementsByTagName('input');

    for (let i = 1; i <= type_report_.length ; i++) {
        let radio = document.getElementById(`checkbox_type_report_`+i);
        if(radio.checked){
            dataParametrs.type_report = i
        } 
        
    }


    let year_schedule = document.getElementById(`year_schedule`).value;
    dataParametrs.year_schedule = year_schedule;
    
    let count_day = document.getElementById(`count_day`).value;
    dataParametrs.count_day = count_day;

    let checkAllOblast = document.getElementById(`checkbox_oblast_0`).checked;
    dataParametrs.checkAllOblast= checkAllOblast;
   
    ReportCheckedOblast()
    dataParametrs.checkOblasts= arrOblastSTR_journal_rkk.toString();
    dataParametrs.checkOblastsId= arrOblastId_journal_rkk.toString();


    reportPrepere(dataParametrs)

    let reportRow = document.getElementById('reportRow');
    reportRow.style="background-color: white";

    let btnReportPrint = document.getElementById(`btnReportPrint`);
    btnReportPrint.removeAttribute('disabled')
}

function asdasd(){
    ReportCheckedOblast()
    console.log(arrOblastSTR_journal_rkk.toString())
}

function ReportCheckedOblast(){

    arrOblastId_journal_rkk = [];
    arrOblastSTR_journal_rkk = [];

    let oblast = document.getElementsByClassName('oblast');
        if (oblast.length !== 0) {
            for (let i = 1; i < oblast.length; i++) {
                let checkBox = document.getElementById(`checkbox_oblast_${oblast[i].id}`);
                if(checkBox.checked){
                    arrOblastId_journal_rkk = [...arrOblastId_journal_rkk, oblast[i].id];

                    let spanCheckBox = document.getElementById(`span_oblast_${oblast[i].id}`).innerText;
                    arrOblastSTR_journal_rkk = [...arrOblastSTR_journal_rkk, spanCheckBox ]
                }
                
            }
        } 
    

}


function prepereTableReport(dataParametrs){

    let table = document.createElement('table');
    table.id="printMe"
   
    table.style = "border-spacing: 0; border: none";

    let thead1 = document.createElement('thead');

    let trHead = document.createElement('tr');

    let th1 = document.createElement('th');
    th1.innerHTML = '№ заявления';
    th1.id='th1'
    th1.style = "border: 1px solid black;  text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"

    let th2 = document.createElement('th');
    th2.innerHTML = 'Наименование Юр. Лицо';
    th2.id='th2'
    th2.style = "border: 1px solid black; min-width: 400px; text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"

    let th3 = document.createElement('th');
    th3.innerHTML = 'Дата создания заявления';
    th3.id='th3'
    th3.style = "border: 1px solid black; min-width: 125px;  text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"

    let th4 = document.createElement('th');
    th4.innerHTML = 'Статус заявления';
    th4.id='th4'
    th4.style = "border: 1px solid black;  text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"
    
    let th5 = document.createElement('th');
    th5.innerHTML = 'Дата отправки заявления';
    th5.id='th5'
    th5.style = "border: 1px solid black; text-align: left;min-width: 125px;  line-height: normal; padding: 0.2rem 0.75rem;"

    let th6 = document.createElement('th');
    th6.innerHTML = 'Дата по графику';
    th6.id='th6'
    th6.style = "border: 1px solid black; text-align: left;min-width: 125px;  line-height: normal; padding: 0.2rem 0.75rem;"

    let th7 = document.createElement('th');
    th7.innerHTML = 'Юр. Адрес';
    th7.id='th7'
    th7.style = "border: 1px solid black; text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"
    
    let th8 = document.createElement('th');
    th8.innerHTML = 'Фактич. Адрес';
    th8.id='th8'
    th8.style = "border: 1px solid black; text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"
    
    let th9 = document.createElement('th');
    th9.innerHTML = 'телефон';
    th9.id='th9'
    th9.style = "border: 1px solid black; min-width: 200px; text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"
    
    let th10 = document.createElement('th');
    th10.innerHTML = 'Email';
    th10.id='th9'
    th10.style = "border: 1px solid black; text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"  

    let th11 = document.createElement('th');
    th11.innerHTML = 'Регион';
    th11.id='th11'
    th11.style = "border: 1px solid black; text-align: left; line-height: normal; padding: 0.2rem 0.75rem;"


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
    thead1.appendChild(trHead);
    table.appendChild(thead1);

    return table
}


let dataReport = new Array();

function reportPrepere(dataParametrs){

    let period_at = document.getElementById('period_at').value;
    let period_to = document.getElementById('period_to').value;
  
    if((period_at && !period_to) || (!period_at && period_to)){
        alert(`Неверно заполнено поле Отчетный период`)
        return 
    } else {
        if(period_at>period_to) {
            alert(`Неверно заполнено поле Отчетный период`)
            return 
        } 

        if(!period_at && !period_to) {
            alert(`Неверно заполнено поле Отчетный период`)
            return 
        } 
    }


    let year_schedule = document.getElementById('year_schedule').value;
    if((!year_schedule)){
        alert(`Неверно заполнено поле Год подачи заявления по графику`)
        return 
    }

    let divForTable = document.getElementById(`divForTable`);
    divForTable.innerHTML = '';

    console.log(dataParametrs)

    let count = 0
    let table = prepereTableReport(dataParametrs)

    let data = new Array();
    $.ajax({
        url: "modules/report/report_date_schedule/getReportSchedule.php",
        method: "GET",
        data: {
            period : dataParametrs.period,
            period_at : dataParametrs.period_at,
            period_to : dataParametrs.period_to,
            type_report: dataParametrs.type_report,
            year_schedule : dataParametrs.year_schedule, 
            count_day: dataParametrs.count_day, 
            checkAllOblast : dataParametrs.checkAllOblast,
            checkOblasts : dataParametrs.checkOblasts,
            checkOblastsId : dataParametrs.checkOblastsId,
        }
        
    }).done(function (response){
        for (let i of JSON.parse(response)){
            data.push(i);
            dataReport.push(i)
            count = data.length
        }

      //  console.log(JSON.parse(response))

        
        let tbody = document.createElement('tbody');
        table.appendChild(tbody);

        if(data.length > 0){
            console.log('data.length ', data.length)
            data.map((item,index) => {
                
                                                
                let tr = document.createElement('tr');
                let td1 = document.createElement('td');
                td1.innerHTML = item['id_application'];
                td1.className='td1'
                td1.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                let td2 = document.createElement('td');
                td2.innerHTML = item['username'];
                td2.className='td2'
                td2.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";
                              
                let td3 = document.createElement('td');
                td3.innerHTML = item['date_create_app'];
                td3.className='td3'
                td3.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                let td4 = document.createElement('td');
                td4.innerHTML = item['name_status'];
                td4.className='td4'
                td4.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                let td5 = document.createElement('td');
                td5.innerHTML = item['date_send'];
                td5.className='td5'
                td5.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                let td6 = document.createElement('td');
                td6.innerHTML = item['schedule_date'];
                td6.className='td6'
                td6.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                
                    let td7 = document.createElement('td');
                    td7.innerHTML = item['date_on_schedule'];
                    td7.className='td7'
                    td7.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                    let td8 = document.createElement('td');
                    td8.innerHTML = item['fact_adress'];
                    td8.className='td8'
                    td8.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                    let td9 = document.createElement('td');
                    td9.innerHTML = item['tel'];
                    td9.className='td9'
                    td9.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                    let td10 = document.createElement('td');
                    td10.innerHTML = item['email'];
                    td10.className='td10'
                    td10.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";
                

                let td11 = document.createElement('td');
                td11.innerHTML = item['oblast'];
                td11.className='td11'
                td11.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                
                tr.appendChild(td1);
                tr.appendChild(td2);
                tr.appendChild(td3);
                tr.appendChild(td4);
                tr.appendChild(td5);
                tr.appendChild(td6);
                tr.appendChild(td7);
                tr.appendChild(td8);
                tr.appendChild(td9);
                tr.appendChild(td10);
                tr.appendChild(td11);
                tbody.appendChild(tr);

            })
            divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Итого:'+'</b>' + ' ' + count +'<br/>'
       } else {
        
        let divForTable = document.getElementById(`divForTable`);
        divForTable.innerHTML = '';
        divForTable.innerHTML = 'По данным параметрам нет записей';

       }


    })



    let divReportTitle = document.createElement('div');
    divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem; text-align:center";

    divReportTitle.textContent = `Контроль сроков подачи заявлений по графику`;


    let divReportUsl = document.createElement('div');
         divReportUsl.id = 'divReportUsl';
         divReportUsl.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:1.2rem; line-height: normal;";
         divReportUsl.innerHTML = '<b>' + `Условия отбора:`+'</b>' + '<br/>';

        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Отчетный период подачи заявления:'+'</b>' + ' с ' + dataParametrs.period_at + ' по ' + dataParametrs.period_to + '<br/>'
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Год подачи заявления по графику:'+'</b>' + ' ' + dataParametrs.year_schedule + '<br/>'
        divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Количество дней на прохождение самоаккредитации:'+'</b>' + ' ' + dataParametrs.count_day +'<br/>'
        
        
        let radio_type_report = document.getElementById(`radio_type_report`);
        let type_report_ = radio_type_report.getElementsByTagName('input');
    
        for (let i = 1; i <= type_report_.length ; i++) {
            let radio = document.getElementById(`checkbox_type_report_`+i);
            if(radio.checked){
              //  console.log(document.getElementById(`span_type_report_`+i))
                divReportUsl.innerHTML  = divReportUsl.innerHTML +'<b>' +' Вид отчета:'+'</b>' + ' ' + document.getElementById(`span_type_report_`+i).textContent +'<br/>' 
            } 
            
        }


        
         
    divForTable.appendChild(divReportTitle);          
    divForTable.appendChild(divReportUsl);     

    let divTable = document.createElement('div');
    divTable.id = 'divTable'
    let butnJournal = document.getElementById('butnJournal');
    
    let contentWidth = butnJournal.clientWidth - 32;
    
    divTable.style = `overflow-x:auto; max-width: ${contentWidth}px;overflow-block: visible; max-height: 600px;`;
    
    divTable.appendChild(table); 
    
    divForTable.appendChild(divTable); 
    
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