// let tab1 = document.getElementById("tab-1");
// let tab2 = document.getElementById("tab-2");
// let tab3 = document.getElementById("tab-3");
// let tab4 = document.getElementById("tab-4");
// let tab5 = document.getElementById("tab-5");

let data_old = new Array();
let openTabId = 0;

let status = 2;

let marks_app = {
    arr_marks : new Array(),
    getArr(){
        return this.arr_marks;
    },
    setArr(arr){
        this.arr_marks.push(arr);
    },
    setValueByIndex(index,name_field, value){
        this.arr_marks[index][name_field] = value;
    },
    arClear(){
        for (let i=this.arr_marks.length-1; i>-1 ; i--) {
            //  console.log(marks_app[i]);
            this.arr_marks.pop();
        }
    }
};

let mark = {
    id_mark: 0,
    id_mark_rating: 0,
    mark_name: 0,
    mark_class: 0,
    field4: 0,
    field5: 0,
    field6: 0
}

let OpenSub = 0;


function showTab(element,id_sub){

    openTabId = id_sub;
    let tablist = document.getElementById("tablist");

    if(isSavedMarks()) {
        //  console.log(OpenSub);
        // arrChange=false;
      //  saveMarks(OpenSub);
        if (saveMarks(OpenSub) === false) {
            return;
        }
    }

    arrChange=false;
    OpenSub=0;
    id_open_criteria = 0;


    for (let item of tablist.children){
        let a = item.children[0];
        a.removeAttribute("data-toggle");
     //   a.classList.remove("active");
    }
    // element.classList.add("active");
    element.children[0].setAttribute("data-toggle", "tab");

    let main = document.getElementById('tab1');
    main.children[0].setAttribute("data-toggle", "tab");

    let id = element.id;
    let tabDiv = document.getElementById(id+"-");
    let myModal = document.getElementById("myModal");
    let activeTabDiv = myModal.getElementsByClassName("tab-pane fade show active")[0];
    if(tabDiv && activeTabDiv) {
        activeTabDiv.classList.remove("active");
        tabDiv.classList.add("active");
    }
    let data = new Array();
    let idNum = id.substring(3);
    if(idNum > 1){
        let row = tabDiv.getElementsByClassName("col-12")[1];


        row.innerHTML = "";
        $.ajax({
            url: "getCrits.php",
            method: "GET",
            data: {id_sub: id_sub}
        })
            .done(function( response ) {
                for (let i of JSON.parse(response)){
                    data.push(i);

                }

                    let data_main = new Array();
                    data_main = data.filter(item => item[2] == '1');

                    let divFormGroup = document.createElement("div");
                    let label_1 = document.createElement("label");
                    label_1.innerHTML = "Общие критерии";
                    divFormGroup.appendChild(label_1);
                    row.appendChild(divFormGroup);

                for (let i = 0;  i<data_main.length ; i++) {
                    let divFormGroup = document.createElement("div");
                    divFormGroup.className = "form-group";
                    let divFormCheck = document.createElement("div");
                    divFormCheck.className = "form-check margleft";
                    let inputCheck = document.createElement("input");
                    inputCheck.className = "form-check-input";
                    inputCheck.setAttribute("type", "checkbox");
                    inputCheck.setAttribute("id", "checkbox"+data_main[i][0]);
                    if(data_main[i][4] == 1){
                        inputCheck.checked = true;
                    }
                    else{
                        inputCheck.checked = false;
                    }
                    let labelCheck = document.createElement("label");
                    labelCheck.className = "form-check-label";
                    labelCheck.setAttribute("for", "checkbox"+data_main[i][0]);
                    labelCheck.innerHTML = data_main[i][1] + " (" + data_main[i][3] + ")";
                    divFormCheck.appendChild(inputCheck);
                    divFormCheck.appendChild(labelCheck);
                    divFormGroup.appendChild(divFormCheck);
                    row.appendChild(divFormGroup);
                }

                data_main = data.filter(item => item[2] == '2');

                let divFormGroup2 = document.createElement("div");
                let label_2 = document.createElement("label");
                    label_2.innerHTML = "По видам оказания медицинской помощи";
                    divFormGroup2.appendChild(label_2);
                    row.appendChild(divFormGroup2);

                for (let i = 0;  i<data_main.length ; i++) {
                    let divFormGroup = document.createElement("div");
                    divFormGroup.className = "form-group";
                    let divFormCheck = document.createElement("div");
                    divFormCheck.className = "form-check margleft";
                    let inputCheck = document.createElement("input");
                    inputCheck.className = "form-check-input";
                    inputCheck.setAttribute("type", "checkbox");
                    inputCheck.setAttribute("id", "checkbox"+data_main[i][0]);
                    if(data_main[i][4] == 1){
                        inputCheck.checked = true;
                    }
                    else{
                        inputCheck.checked = false;
                    }
                    let labelCheck = document.createElement("label");
                    labelCheck.className = "form-check-label";
                    labelCheck.setAttribute("for", "checkbox"+data_main[i][0]);
                    labelCheck.innerHTML = data_main[i][1] + " (" + data_main[i][3] + ")";
                    divFormCheck.appendChild(inputCheck);
                    divFormCheck.appendChild(labelCheck);
                    divFormGroup.appendChild(divFormCheck);
                    row.appendChild(divFormGroup);
                }


                data_main = data.filter(item => item[2] == '3')

                let divFormGroup3 = document.createElement("div");
                let label_3 = document.createElement("label");
                    label_3.innerHTML = "Вспомогательные подразделения (диагностические)";
                    divFormGroup3.appendChild(label_3);
                    row.appendChild(divFormGroup3);

                for (let i = 0;  i<data_main.length ; i++) {
                    let divFormGroup = document.createElement("div");
                    divFormGroup.className = "form-group";
                    let divFormCheck = document.createElement("div");
                    divFormCheck.className = "form-check margleft";
                    let inputCheck = document.createElement("input");
                    inputCheck.className = "form-check-input";
                    inputCheck.setAttribute("type", "checkbox");
                    inputCheck.setAttribute("id", "checkbox"+data_main[i][0]);
                    if(data_main[i][4] == 1){
                        inputCheck.checked = true;
                    }
                    else{
                        inputCheck.checked = false;
                    }
                    let labelCheck = document.createElement("label");
                    labelCheck.className = "form-check-label";
                    labelCheck.setAttribute("for", "checkbox"+data_main[i][0]);
                    labelCheck.innerHTML = data_main[i][1] + " (" + data_main[i][3] + ")";
                    divFormCheck.appendChild(inputCheck);
                    divFormCheck.appendChild(labelCheck);
                    divFormGroup.appendChild(divFormCheck);
                    row.appendChild(divFormGroup);
                }
                createAccordionCards(id_sub);

                let mainTab = document.getElementById("button1");

                let footer = document.getElementsByClassName("modal-footer")[0];
                if(!mainTab.classList.contains("active")){

                    footer.classList.add("hiddentab");

                }
                else{
                    footer.classList.remove("hiddentab");
                }
            });
        let submark = document.getElementById("subMark"+id_sub);
        if(submark){
            submark.remove();
        }
        let calcSubMark = document.createElement('div');
        calcSubMark.id = "subMark"+id_sub;
        calcSubMark.style = "text-align: right";
        let id_application = document.getElementById("id_application").innerText;
        let calcRow = document.getElementById("tab"+id_sub+"-");
        $.ajax({
            url: "getCalcSubMark.php",
            method: "GET",
            data: {id_application: id_application, id_sub: id_sub}
        })
            .done(function( response ) {

                let criteriaMark ='';
                let criteriaMarkAccred ='';

                let marksSub = JSON.parse(response);
                 
                criteriaMark = criteriaMark + 'Количественная самооценка ' + marksSub['otmetka_all_count_yes'] + '/('  
                                        + marksSub['otmetka_all_count_all'] + ' - ' + marksSub['otmetka_all_count_not_need'] + ') = ' + marksSub['otmetka_all'] +'%';
                criteriaMark += ' По 1 классу ' + marksSub['otmetka_class_1_count_yes'] + '/('  
                + marksSub['otmetka_class_1_count_all'] + ' - ' + marksSub['otmetka_class_1_count_not_need'] + ') = ' + marksSub['otmetka_class_1'] +'%';
                criteriaMark +=  ' По 2 классу ' + marksSub['otmetka_class_2_count_yes'] + '/('  
                + marksSub['otmetka_class_2_count_all'] + ' - ' + marksSub['otmetka_class_2_count_not_need'] + ') = ' + marksSub['otmetka_class_2'] +'%';
                criteriaMark +=  ' По 3 классу ' + marksSub['otmetka_class_3_count_yes'] + '/('  
                + marksSub['otmetka_class_3_count_all'] + ' - ' + marksSub['otmetka_class_3_count_not_need'] + ') = ' + marksSub['otmetka_class_3'] +'%';

                criteriaMarkAccred = criteriaMarkAccred + 'Количественная оценка ' + marksSub['otmetka_accred_all_count_yes'] + '/('  
                + marksSub['otmetka_accred_all_count_all'] + ' - ' + marksSub['otmetka_accred_all_count_not_need'] + ') = ' + marksSub['otmetka_accred_all'] +'%';
                criteriaMarkAccred += ' Верификация результатов самооценки ' + marksSub['otmetka_verif_count_yes'] + '/('  
                + marksSub['otmetka_verif_count_all'] + ' - ' + marksSub['otmetka_verif_count_not_need'] + ') = ' + marksSub['otmetka_verif'] +'%';
                criteriaMarkAccred += ' По 1 классу ' + marksSub['otmetka_accred_class_1_count_yes'] + '/('  
                + marksSub['otmetka_accred_class_1_count_all'] + ' - ' + marksSub['otmetka_accred_class_1_count_not_need'] + ') = ' + marksSub['otmetka_accred_class_1'] +'%';
                criteriaMarkAccred +=  ' По 2 классу ' + marksSub['otmetka_accred_class_2_count_yes'] + '/('  
                + marksSub['otmetka_accred_class_2_count_all'] + ' - ' + marksSub['otmetka_accred_class_2_count_not_need'] + ') = ' + marksSub['otmetka_accred_class_2'] +'%';
                criteriaMarkAccred +=  ' По 3 классу ' + marksSub['otmetka_accred_class_3_count_yes'] + '/('  
                + marksSub['otmetka_accred_class_3_count_all'] + ' - ' + marksSub['otmetka_accred_class_3_count_not_need'] + ') = ' + marksSub['otmetka_accred_class_3'] +'%';


                // JSON.parse(response).map((item, index) =>{
                //     console.log(item);
                //     if(item !== 0){
                //         if(index == 0){
                //             criteriaMark = criteriaMark + 'Количественная оценка самооценки=' + item +'%';
                //         }
                //         if(index == 1){
                //             criteriaMark += ' По 1 классу ='  + item +'%';
                //         }
                //         if(index == 2){
                //             criteriaMark +=  ' По 2 классу ='  + item +'%';
                //         }
                //         if(index == 3){
                //             criteriaMark +=  ' По 3 классу ='  + item +'%';
                //         }


                //         if(index == 4){
                //             criteriaMarkAccred = criteriaMarkAccred + 'Количественная оценка оценки=' + item +'%';
                //         }
                //         if(index == 5){
                //             criteriaMarkAccred += ' Верификация результатов самооценки ='  + item +'%';
                //         }
                //         if(index == 6){
                //             criteriaMarkAccred += ' По 1 классу ='  + item +'%';
                //         }
                //         if(index == 7){
                //             criteriaMarkAccred +=  ' По 2 классу ='  + item +'%';
                //         }
                //         if(index == 8){
                //             criteriaMarkAccred +=  ' По 3 классу ='  + item +'%';
                //         }
                //     }
                // });
                // let isBtnPrint = document.getElementById("btnPrint");
                // if(isBtnPrint){
                //     isBtnPrint.remove();
                // }

               calcSubMark.innerHTML = criteriaMark + "<br/>";
               calcSubMark.innerHTML += criteriaMarkAccred + "<br/><br/>";
               //  let btnPrint = document.createElement("button");
               //  btnPrint.setAttribute("type", "submit");
               //  btnPrint.className = "btn btn-light btn-fw";
               //  btnPrint.id = "btnPrint";
               //  btnPrint.innerHTML = "Печать";
               //  btnPrint.style = "float: right";
               // btnPrint.onclick = () => print();
                calcRow.appendChild(calcSubMark);
               // calcSubMark.insertAdjacentElement("afterend", btnPrint);


            });
    }
    let mainTab = document.getElementById("button1");

    let footer = document.getElementsByClassName("modal-footer")[0];
    // console.log(mainTab.classList.contains("active"));
    if(footer.classList.contains("hiddentab")){

        footer.classList.remove("hiddentab");

    }
}

function getCookie(cname) {
    let name = cname + "=";
    let decodedCookie = decodeURIComponent(document.cookie);
    let ca = decodedCookie.split(';');
    for(let i = 0; i <ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function createApplication(){
    $.ajax({
        url: "createApplication.php",
        method: "POST",
        data: ""
    })
        .done(function( response ) {
            console.log(response);
        });
    alert("Заявление создано");
    location.href = "/index.php?application";
}


function showModal(id_application, strMarks, strMarksAccred){

    let btnChecking = document.getElementById("btnChecking");
    let btnOk = document.getElementById("btnOk");
    let btnNeOk = document.getElementById("btnNeOk");

    let tabOdobrenie = document.getElementById("odobrennie-tab");
    let tabNeodobrennie = document.getElementById("neodobrennie-tab");
    let tabRassmotrenie = document.getElementById("rassmotrenie-tab");
    let tabHome = document.getElementById("home-tab");

    if(tabOdobrenie.classList.contains("active")){
        btnChecking.classList.remove("hiddentab");
        btnNeOk.classList.remove("hiddentab");
    }else if(tabNeodobrennie.classList.contains("active")){
        btnChecking.classList.remove("hiddentab");
        btnOk.classList.remove("hiddentab");
    }
    else if(tabRassmotrenie.classList.contains("active")){
        // btnNeOk.classList.remove("hiddentab");
        btnOk.classList.remove("hiddentab");
    }
    else{
        btnNeOk.classList.remove("hiddentab");
        // btnOk.classList.remove("hiddentab");
        btnChecking.classList.remove("hiddentab");
    }

    let mainRightCard = document.getElementById("mainRightCard");


    mainRightCard.innerHTML = strMarks + "<br/>" + strMarksAccred;
    openTabId=0;
    document.getElementsByClassName("modal-title")[0].innerHTML = "Изменение заяления";
    let number_app = document.getElementById("id_application");
    let naim = document.getElementById("naim");
    let sokr = document.getElementById("sokr");
    let unp = document.getElementById("unp");
    let adress = document.getElementById("adress");
    let tel = document.getElementById("tel");
    let email = document.getElementById("email");
    let rukovoditel = document.getElementById("rukovoditel");
    let predstavitel = document.getElementById("predstavitel");
    let soprPismo = document.getElementById("soprPismo");
    let copyRaspisanie = document.getElementById("copyRaspisanie");
    let orgStrukt = document.getElementById("orgStrukt");
    let fileReport = document.getElementById("fileReport");
    let reportSamoocenka = document.getElementById("reportSamoocenka");

    let divSoprPismo = document.getElementById("divSoprovodPismo");
    let divCopyRaspisanie = document.getElementById("divCopyRaspisanie");
    let divOrgStrukt = document.getElementById("divOrgStrukt");
    let divReport = document.getElementById("divReport");
    let divReportSamoocenka = document.getElementById("divReportSamoocenka");
    number_app.innerHTML = id_application;
    let modal = document.getElementById("myModal");
    let tablist = document.getElementById("tablist");
    let data = new Array();
    $.ajax({
        url: "getApplication.php",
        method: "GET",
        data: {id_application: id_application}
    })
        .done(function( response ) {
            for (let i of JSON.parse(response)){
                data.push(i);
                data_old.push(i);
            }
            naim.value = data[0][0];
            sokr.value = data[0][1];
            unp.value = data[0][2];
            adress.value = data[0][3];
            tel.value = data[0][4];
            email.value = data[0][5];
            rukovoditel.value = data[0][6];
            predstavitel.value = data[0][7];
            let login = data[0][11];
            if(data[0][13] != null) {
                reportSamoocenka.insertAdjacentHTML("afterend", "<a href='/documents/" + login + "/" + data[0][13] + "'>" + data[0][13] + "</a>");
            }
            if(data[0][12] != null) {
                fileReport.insertAdjacentHTML("afterend", "<a href='/documents/Отчеты/" + data[0][12] + "'>" + data[0][12] + "</a>");
            }

            if(data[0][8] != null) {
                soprPismo.insertAdjacentHTML("afterend", "<a href='/documents/" + login + "/" + data[0][8] + "'>" + data[0][8] + "</a>");
            }
            if(data[0][9] != null) {
                copyRaspisanie.insertAdjacentHTML("afterend", "<a href='/documents/" + login + "/" + data[0][9] + "'>" + data[0][9] + "</a>");
            }
            if(data[0][10] != null) {
                orgStrukt.insertAdjacentHTML("afterend", "<a href='/documents/" + login + "/" + data[0][10] + "'>" + data[0][10] + "</a>");
            }
            modal.classList.add("show");
            modal.style = "display: block";
            let j = 0;
            for(let obj of data[1]){
                if(j==0){
                    getMainTab(obj[1],obj[0]);
                }else {
                    getTabs(obj[1], obj[0]);
                }
                j++;
            }
        });
     // выводим полученный ответ на консоль браузер

    $(".btn-close").on("click",() => {
        let sopr = divSoprPismo.getElementsByTagName("a")[0];
        let copy = divCopyRaspisanie.getElementsByTagName("a")[0];
        let org = divOrgStrukt.getElementsByTagName("a")[0];
        let rep = divReport.getElementsByTagName("a")[0];
        let sam = divReportSamoocenka.getElementsByTagName("a")[0];
        if(sam) {
            sam.remove();
        }
        if(sopr) {
            sopr.remove();
        }
        if(copy) {
            copy.remove();
        }
        if(org) {
            org.remove();
        }
        if(rep) {
            rep.remove();
        }
        modal.classList.remove("show");
        modal.style = "display: none";
        for(let i = tablist.children.length - 1; i > 0; i--){
            tablist.children[i].remove();
        }

    });
    $(".btn-danger").on("click",() => {
        let sopr = divSoprPismo.getElementsByTagName("a")[0];
        let copy = divCopyRaspisanie.getElementsByTagName("a")[0];
        let org = divOrgStrukt.getElementsByTagName("a")[0];
        let rep = divReport.getElementsByTagName("a")[0];
        let sam = divReportSamoocenka.getElementsByTagName("a")[0];
        if(sam) {
            sam.remove();
        }
        if(sopr) {
            sopr.remove();
        }
        if(copy) {
            copy.remove();
        }
        if(org) {
            org.remove();
        }
        if(rep) {
            rep.remove();
        }
        modal.classList.remove("show");
        modal.style = "display: none";
        for(let i = tablist.children.length - 1; i > 0; i--){
            tablist.children[i].remove();
        }
    });


    let divBtnPrintReport = document.getElementById('btnPrintReport');
    divBtnPrintReport.onclick = ()=> {
        printReport();
    };

}

function printReport(){
    let number_app = document.getElementById("id_application");
    let id_application = number_app.innerHTML;

    $.ajax({
        url: "getAppForPrintAcredReport.php",
        method: "GET",
        data: {id_app: id_application}
    })
        .done(function( response ) {
            //  console.log(response);
            let tableForPrint = JSON.parse(response);

            if(tableForPrint.length !==0){
                let naim = document.getElementById("naim");
                let unp = document.getElementById("unp");
                let naimText = naim.value;
                let unpText = unp.value;
                var WinPrint = window.open('','','left=50,top=50,width=800,height=640,toolbar=0,scrollbars=1,status=0');

                WinPrint.document.write('<style>@page {\n' +
                    'margin: 1rem;\n' +
                    '}</style>');  // убрать колонтитул
                // WinPrint.document.write('Наименование организации: ');
                // WinPrint.document.write(naimText);
                // WinPrint.document.write('<br/>');
                // WinPrint.document.write('УНП: ');
                // WinPrint.document.write(unpText);

                let table = createTableForPrintNo(tableForPrint);

                WinPrint.document.write('<br/>');
                WinPrint.document.write(table.innerHTML);

                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();
                WinPrint.close();
            } else {
                alert('Ничего нет под выбранные условия');
            }


        });
}

//function print()
    $("#btnPrint").on("click", () => {


  //  console.log('openTabId =',openTabId);
    let number_app = document.getElementById("id_application");
    let id_application = number_app.innerHTML;

    $.ajax({
        url: "getAppForPrint.php",
        method: "GET",
        data: {id_app: id_application}
    })
        .done(function( response ) {
            //  console.log(response);
            let tableForPrint = JSON.parse(response);


            let naim = document.getElementById("naim");
            let unp = document.getElementById("unp");
            let naimText = naim.value;
            let unpText = unp.value;
            var WinPrint = window.open('','','left=50,top=50,width=800,height=640,toolbar=0,scrollbars=1,status=0');

            WinPrint.document.write('<style>@page {\n' +
                'margin: 1rem;\n' +
                '}</style>');  // убрать колонтитул
            // WinPrint.document.write('Наименование организации: ');
            // WinPrint.document.write(naimText);
            // WinPrint.document.write('<br/>');
            // WinPrint.document.write('УНП: ');
            // WinPrint.document.write(unpText);

            let table = createTableForPrint(tableForPrint);



            WinPrint.document.write('<br/>');
            WinPrint.document.write(table.innerHTML);


            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();

        });




});

function createTableForPrint(tableForPrint){

    let divPrintTable = document.createElement('div');

    let divNameSubTable = document.createElement('div');
    divNameSubTable.textContent = tableForPrint[0]['name'];
    divNameSubTable.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:1.8rem; font-weight: 600";

    divPrintTable.appendChild(divNameSubTable);

    let divNameCriteriaTable = document.createElement('div');
    divNameCriteriaTable.textContent = tableForPrint[0]['name_criteria'];
    divNameCriteriaTable.style = "padding-top: 1rem; padding-bottom:2rem";

    divPrintTable.appendChild(divNameCriteriaTable);

    let table = document.createElement('table');
    table.style = "border-collapse: collapse; border-spacing: 0;";
    

    let trHeadMain = document.createElement('tr');

    let thNum = document.createElement('th');
    thNum.innerHTML = '№ п/п';
    thNum.style = "border: 1px solid black";
    thNum.setAttribute('rowspan','2');

    let th1_Main = document.createElement('th');
    th1_Main.innerHTML = 'Критерий';
    th1_Main.style = "border: 1px solid black";
    th1_Main.setAttribute('rowspan','2');

    let th2_Main = document.createElement('th');
    th2_Main.innerHTML = 'Класс критерия';
    th2_Main.style = "border: 1px solid black";
    th2_Main.setAttribute('rowspan','2');


    let th3_Main = document.createElement('th');
    th3_Main.innerHTML = 'Сведения о соблюдении критериев (самооценка)';
    th3_Main.style = "border: 1px solid black; text-align: center";
    th3_Main.setAttribute('colspan','3');

    let th4_Main = document.createElement('th');
    th4_Main.innerHTML = 'Сведения об оценке критериев';
    th4_Main.style = "border: 1px solid black; text-align: center";
    th4_Main.setAttribute('colspan','2');

    let trHead = document.createElement('tr');
    let th3 = document.createElement('th');
    th3.innerHTML = 'Сведения по самооценке ОЗ';
    th3.style = "border: 1px solid black";

    let th4 = document.createElement('th');
    th4.innerHTML = 'Документы и сведения, на основании которых проведена самооценка';
    th4.style = "width:350px; border: 1px solid black";


    let th5 = document.createElement('th');
    th5.innerHTML = 'Примечание';
    th5.style = "border: 1px solid black";

    let th6 = document.createElement('th');
    th6.innerHTML = 'Сведения по оценке соответствия';
    th6.style = "border: 1px solid black";

    let th7 = document.createElement('th');
    th7.innerHTML = 'Документы и сведения, на основании которых проведена оценка соответствия';
    th7.style = "border: 1px solid black";
   
    trHeadMain.appendChild(thNum);
    trHeadMain.appendChild(th1_Main);
    trHeadMain.appendChild(th2_Main);
    trHeadMain.appendChild(th3_Main);
    trHeadMain.appendChild(th4_Main);


    table.appendChild(trHeadMain);
    trHead.appendChild(th3);
    trHead.appendChild(th4);
    trHead.appendChild(th5);
    trHead.appendChild(th6);
    trHead.appendChild(th7);


    table.appendChild(trHead);
    
    let tbody = document.createElement('tbody');
    table.appendChild(tbody);

    numCriteria=0;
    numSub = 0;
    tableForPrint.map((item, index) => {


            if((numCriteria !== item['id_criteria']) && (index !==0))  {

                if(numSub !== item['id_subvision']){

                    let trNaimSub = document.createElement('tr');
                    let tdNaimSub  = document.createElement('td');
                    tdNaimSub.setAttribute('colspan','6');
                    tdNaimSub.style = "padding-top: 2rem; padding-bottom:1rem; font-size:1.8rem; font-weight: 600";
                    tdNaimSub.innerHTML = item['name'];
                    trNaimSub.appendChild(tdNaimSub);
                    tbody.appendChild(trNaimSub);

                }

                if(item['id_criteria'] !== null) {
                    let trNaim = document.createElement('tr');
                    let tdNaim = document.createElement('td');
                    tdNaim.setAttribute('colspan','6');
                    tdNaim.style = "padding-top: 1rem; padding-bottom:1rem";
                    tdNaim.innerHTML = item['name_criteria'];
                    trNaim.appendChild(tdNaim);
                    tbody.appendChild(trNaim);
    
    
    
                    let trHeadMain2 = document.createElement('tr');
    
                    let thNum = document.createElement('th');
                    thNum.innerHTML = '№ п/п';
                    thNum.style = "border: 1px solid black";
                    thNum.setAttribute('rowspan','2');
    
                    let th1_Main2 = document.createElement('td');
                    th1_Main2.innerHTML = 'Критерий';
                    th1_Main2.style = "border: 1px solid black";
                    th1_Main2.setAttribute('rowspan','2');
            
                    let th2_Main2 = document.createElement('td');
                    th2_Main2.innerHTML = 'Класс критерия';
                    th2_Main2.style = "border: 1px solid black";
                    th2_Main2.setAttribute('rowspan','2');
            
            
                    let th3_Main2 = document.createElement('td');
                    th3_Main2.innerHTML = 'Сведения о соблюдении критериев (самооценка)';
                    th3_Main2.style = "border: 1px solid black; text-align: center";
                    th3_Main2.setAttribute('colspan','3');

                    let th4_Main2 = document.createElement('td');
                    th4_Main2.innerHTML = 'Сведения об оценке критериев';
                    th4_Main2.style = "border: 1px solid black; text-align: center";
                    th4_Main2.setAttribute('colspan','2');
                    
            
                    let trHead2 = document.createElement('tr');
                    let th32 = document.createElement('td');
                    th32.innerHTML = 'Сведения по самооценке ОЗ';
                    th32.style = "border: 1px solid black";
            
                    let th42 = document.createElement('td');
                    th42.innerHTML = 'Документы и сведения, на основании которых проведена самооценка';
                    th4.style = "width:350px; border: 1px solid black";
            
            
                    let th52 = document.createElement('td');
                    th52.innerHTML = 'Примечание';
                    th52.style = "border: 1px solid black";

                    let th62 = document.createElement('td');
                    th62.innerHTML = 'Сведения по оценке соответствия';
                    th62.style = "border: 1px solid black";

                    let th72 = document.createElement('td');
                    th72.innerHTML = 'Документы и сведения, на основании которых проведена оценка соответствия';
                    th72.style = "border: 1px solid black";
            
                    trHeadMain2.appendChild(thNum);
                    trHeadMain2.appendChild(th1_Main2);
                    trHeadMain2.appendChild(th2_Main2);
                    trHeadMain2.appendChild(th3_Main2);
                    trHeadMain2.appendChild(th4_Main2);
                   
                    
                    tbody.appendChild(trHeadMain2);
                    trHead2.appendChild(th32);
                    trHead2.appendChild(th42);
                    trHead2.appendChild(th52);
                    trHead2.appendChild(th62);
                    trHead2.appendChild(th72);
            
                    tbody.appendChild(trHead2);
                }

              
                

            }

            numCriteria =  -1;

            if(item['id_criteria'] !== null) {

                let tr = document.createElement('tr');

                let tdNum = document.createElement('td');
                tdNum.innerHTML = item['str_num'];
                tdNum.style = "border: 1px solid black";
    
                let td1 = document.createElement('td');
                td1.innerHTML = item['mark_name'];
                td1.style = "border: 1px solid black; padding: 0.2rem 0.75rem";
    
                let td2 = document.createElement('td');
                td2.innerHTML = item['mark_class'];
                td2.style = "border: 1px solid black; padding: 0.2rem 0.75rem";
          
                let td3 = document.createElement('td');
                td3.style = "border: 1px solid black; padding: 0.2rem 0.75rem";
                td3.innerHTML = item['field4'];
           
                let td4 = document.createElement('td');
                td4.style = "border: 1px solid black; padding: 0.2rem 0.75rem";
                td4.innerHTML = item['field5'];
    
                let td5 = document.createElement('td');
                td5.style = "border: 1px solid black; padding: 0.2rem 0.75rem";
                td5.innerHTML = item['field6'];

                let td6 = document.createElement('td');
                td6.style = "border: 1px solid black; padding: 0.2rem 0.75rem";
                td6.innerHTML = item['field7'];

                let td7 = document.createElement('td');
                td7.style = "border: 1px solid black; padding: 0.2rem 0.75rem";
                td7.innerHTML = item['field8'];
    
    
                tr.appendChild(tdNum);
                tr.appendChild(td1);
                tr.appendChild(td2);
                tr.appendChild(td3);
    
                tr.appendChild(td4);
                tr.appendChild(td5);
                tr.appendChild(td6);
                tr.appendChild(td7);

                tbody.appendChild(tr);
     
                numCriteria = item['id_criteria'];
             }

             
            numSub = item['id_subvision']
         })


    divPrintTable.appendChild(table);

    return divPrintTable;
}

function createTableForPrintNo(tableForPrint){

    let divPrintTable = document.createElement('div');

    let divNameSubTable = document.createElement('div');
    divNameSubTable.textContent = tableForPrint[0]['name'];
    divNameSubTable.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:1.8rem; font-weight: 600";

    divPrintTable.appendChild(divNameSubTable);

    let divNameCriteriaTable = document.createElement('div');
    divNameCriteriaTable.textContent = tableForPrint[0]['name_criteria'];
    divNameCriteriaTable.style = "padding-top: 1rem; padding-bottom:2rem";

    divPrintTable.appendChild(divNameCriteriaTable);

    let table = document.createElement('table');
    table.style = "border-collapse: collapse; border-spacing: 0;";


    let trHeadMain = document.createElement('tr');

    let thNum = document.createElement('th');
    thNum.innerHTML = '№ п/п';
    thNum.style = "border: 1px solid black";
    thNum.setAttribute('rowspan','2');

    let th1_Main = document.createElement('th');
    th1_Main.innerHTML = 'Критерий';
    th1_Main.style = "border: 1px solid black";
    th1_Main.setAttribute('rowspan','2');

    let th2_Main = document.createElement('th');
    th2_Main.innerHTML = 'Класс критерия';
    th2_Main.style = "border: 1px solid black";
    th2_Main.setAttribute('rowspan','2');


    let th3_Main = document.createElement('th');
    th3_Main.innerHTML = 'Сведения о соблюдении критериев (самооценка)';
    th3_Main.style = "border: 1px solid black; text-align: center";
    th3_Main.setAttribute('colspan','3');

    let th4_Main = document.createElement('th');
    th4_Main.innerHTML = 'Сведения об оценке критериев';
    th4_Main.style = "border: 1px solid black; text-align: center";
    th4_Main.setAttribute('colspan','2');

    let trHead = document.createElement('tr');
    let th3 = document.createElement('th');
    th3.innerHTML = 'Сведения по самооценке ОЗ';
    th3.style = "border: 1px solid black";

    let th4 = document.createElement('th');
    th4.innerHTML = 'Документы и сведения, на основании которых проведена самооценка';
    th4.style = "width:350px; border: 1px solid black";


    let th5 = document.createElement('th');
    th5.innerHTML = 'Примечание';
    th5.style = "border: 1px solid black";

    let th6 = document.createElement('th');
    th6.innerHTML = 'Сведения по оценке соответствия';
    th6.style = "border: 1px solid black";

    let th7 = document.createElement('th');
    th7.innerHTML = 'Документы и сведения, на основании которых проведена оценка соответствия';
    th7.style = "border: 1px solid black";

    trHeadMain.appendChild(thNum);
    trHeadMain.appendChild(th1_Main);
    trHeadMain.appendChild(th2_Main);
    trHeadMain.appendChild(th3_Main);
    trHeadMain.appendChild(th4_Main);


    table.appendChild(trHeadMain);
    trHead.appendChild(th3);
    trHead.appendChild(th4);
    trHead.appendChild(th5);
    trHead.appendChild(th6);
    trHead.appendChild(th7);


    table.appendChild(trHead);

    let tbody = document.createElement('tbody');
    table.appendChild(tbody);

    numCriteria=0;
    numSub = tableForPrint[0]['id_subvision'];
    tableForPrint.map((item, index) => {

        if(numSub !== item['id_subvision']){
        if((numCriteria !== item['id_criteria']) && (index !==0))  {




            }

            let trNaimSub = document.createElement('tr');
            let tdNaimSub  = document.createElement('td');
            tdNaimSub.setAttribute('colspan','6');
            tdNaimSub.style = "padding-top: 2rem; padding-bottom:1rem; font-size:1.8rem; font-weight: 600";
            tdNaimSub.innerHTML = item['name'];
            trNaimSub.appendChild(tdNaimSub);
            tbody.appendChild(trNaimSub);
            if(item['id_criteria'] !== null) {
                let trNaim = document.createElement('tr');
                let tdNaim = document.createElement('td');
                tdNaim.setAttribute('colspan','6');
                tdNaim.style = "padding-top: 1rem; padding-bottom:1rem";
                tdNaim.innerHTML = item['name_criteria'];
                trNaim.appendChild(tdNaim);
                tbody.appendChild(trNaim);



                let trHeadMain2 = document.createElement('tr');

                let thNum = document.createElement('th');
                thNum.innerHTML = '№ п/п';
                thNum.style = "border: 1px solid black";
                thNum.setAttribute('rowspan','2');

                let th1_Main2 = document.createElement('td');
                th1_Main2.innerHTML = 'Критерий';
                th1_Main2.style = "border: 1px solid black";
                th1_Main2.setAttribute('rowspan','2');

                let th2_Main2 = document.createElement('td');
                th2_Main2.innerHTML = 'Класс критерия';
                th2_Main2.style = "border: 1px solid black";
                th2_Main2.setAttribute('rowspan','2');


                let th3_Main2 = document.createElement('td');
                th3_Main2.innerHTML = 'Сведения о соблюдении критериев (самооценка)';
                th3_Main2.style = "border: 1px solid black; text-align: center";
                th3_Main2.setAttribute('colspan','3');

                let th4_Main2 = document.createElement('td');
                th4_Main2.innerHTML = 'Сведения об оценке критериев';
                th4_Main2.style = "border: 1px solid black; text-align: center";
                th4_Main2.setAttribute('colspan','2');


                let trHead2 = document.createElement('tr');
                let th32 = document.createElement('td');
                th32.innerHTML = 'Сведения по самооценке ОЗ';
                th32.style = "border: 1px solid black";

                let th42 = document.createElement('td');
                th42.innerHTML = 'Документы и сведения, на основании которых проведена самооценка';
                th4.style = "width:350px; border: 1px solid black";


                let th52 = document.createElement('td');
                th52.innerHTML = 'Примечание';
                th52.style = "border: 1px solid black";

                let th62 = document.createElement('td');
                th62.innerHTML = 'Сведения по оценке соответствия';
                th62.style = "border: 1px solid black";

                let th72 = document.createElement('td');
                th72.innerHTML = 'Документы и сведения, на основании которых проведена оценка соответствия';
                th72.style = "border: 1px solid black";

                trHeadMain2.appendChild(thNum);
                trHeadMain2.appendChild(th1_Main2);
                trHeadMain2.appendChild(th2_Main2);
                trHeadMain2.appendChild(th3_Main2);
                trHeadMain2.appendChild(th4_Main2);


                tbody.appendChild(trHeadMain2);
                trHead2.appendChild(th32);
                trHead2.appendChild(th42);
                trHead2.appendChild(th52);
                trHead2.appendChild(th62);
                trHead2.appendChild(th72);

                tbody.appendChild(trHead2);
            }




        }

        numCriteria =  -1;

        if(item['id_criteria'] !== null) {

            let tr = document.createElement('tr');

            let tdNum = document.createElement('td');
            tdNum.innerHTML = item['str_num'];
            tdNum.style = "border: 1px solid black";

            let td1 = document.createElement('td');
            td1.innerHTML = item['mark_name'];
            td1.style = "border: 1px solid black; padding: 0.2rem 0.75rem";

            let td2 = document.createElement('td');
            td2.innerHTML = item['mark_class'];
            td2.style = "border: 1px solid black; padding: 0.2rem 0.75rem";

            let td3 = document.createElement('td');
            td3.style = "border: 1px solid black; padding: 0.2rem 0.75rem";
            td3.innerHTML = item['field4'];

            let td4 = document.createElement('td');
            td4.style = "border: 1px solid black; padding: 0.2rem 0.75rem";
            td4.innerHTML = item['field5'];

            let td5 = document.createElement('td');
            td5.style = "border: 1px solid black; padding: 0.2rem 0.75rem";
            td5.innerHTML = item['field6'];

            let td6 = document.createElement('td');
            td6.style = "border: 1px solid black; padding: 0.2rem 0.75rem";
            td6.innerHTML = item['field7'];

            let td7 = document.createElement('td');
            td7.style = "border: 1px solid black; padding: 0.2rem 0.75rem";
            td7.innerHTML = item['field8'];


            tr.appendChild(tdNum);
            tr.appendChild(td1);
            tr.appendChild(td2);
            tr.appendChild(td3);

            tr.appendChild(td4);
            tr.appendChild(td5);
            tr.appendChild(td6);
            tr.appendChild(td7);

            tbody.appendChild(tr);

            numCriteria = item['id_criteria'];
        }


        numSub = item['id_subvision']
    })


    divPrintTable.appendChild(table);

    return divPrintTable;
}



const EMAIL_REGEXP = /^(([^<>()[\].,;:\s@"]+(\.[^<>()[\].,;:\s@"]+)*)|(".+"))@(([^<>()[\].,;:\s@"]+\.)+[^<>()[\].,;:\s@"]{2,})$/iu;
const UNP_REGEXP = /^([0-9]{9})$/iu;
const ADRESS_REGEXP = /^(\d{4,6}\s[А-Яа-яЁё0-9,. ]{1,})$/iu;


function onInputEmail() {
    const input = document.getElementById('email');
    if (isEmailValid(input.value)) {
        input.style.borderColor = 'green';
    } else {
        input.style.borderColor = 'red';
    }
}
function isEmailValid(value) {
    return EMAIL_REGEXP.test(value);
}

function onInputUnp() {
    const input = document.getElementById('unp');
    if (isUnpValid(input.value)) {
        input.style.borderColor = 'green';
    } else {
        input.style.borderColor = 'red';
    }
}
function isUnpValid(value) {
    return UNP_REGEXP.test(value);
}

function onInputAdress() {
    const input = document.getElementById('adress');
    if (isAdressValid(input.value)) {
        input.style.borderColor = 'green';
    } else {
        input.style.borderColor = 'green';
    }
}
function isAdressValid(value) {
    return ADRESS_REGEXP.test(value);
}

let formDoverennost = document.getElementById("formDoverennost");
function showDoverennost(element){
    formDoverennost.classList.remove("hiddentab");
};

function deleteDoverennost(element){
    formDoverennost.classList.add("hiddentab");
};

function getTabs(name, id_sub){

/*
    if(isSavedMarks()) {
        //  console.log(OpenSub);
        // arrChange=false;
        if (saveMarks(OpenSub) === false) {
            return;
        }

    }
*/

    let tablist = document.getElementById("tablist");
    let tab = document.createElement("li");
    tab.classList.add("nav-item");
    let a = document.createElement("button");
    a.className = "nav-link";
    a.id = 'button' + id_sub;
   a.setAttribute("data-toggle", "tab");
    a.setAttribute("href", "#");
    a.setAttribute("role", "tab");
    a.setAttribute("aria-selected", "false");

    tab.setAttribute("onclick", "showTab(this,"+id_sub+")");

    a.innerHTML = "Самооценка " + name;
    tab.appendChild(a);
   
    tab.id = "tab" + id_sub;
    tablist.appendChild(tab);


    let tabContent = document.getElementsByClassName("tab-content tab-transparent-content")[4];
    let tabPane = document.createElement("div");
    tabPane.className = "tab-pane fade show";
    tabPane.id = "tab" + id_sub + "-";
    let row1 = document.createElement("div");
    row1.className = "row";
    let col12_1 = document.createElement("div");
    col12_1.className = "col-12 grid-margin";
    let cardLeft = document.createElement("div");
    cardLeft.className = "card";


    let divRollUp = document.createElement("div");
    divRollUp.className = "d-md-block d-none";
    divRollUp.style = "text-align: end;margin-top: 5px;";
    let aRollUp = document.createElement("a");
    aRollUp.href = "#";
    aRollUp.className = "text-light p-1";
    aRollUp.id = "rollUp";
    let iconRollUp = document.createElement("i");
    iconRollUp.className = "mdi mdi-view-dashboard";
    cardLeft.style = "display: none";
    aRollUp.appendChild(iconRollUp);
    divRollUp.appendChild(aRollUp);
    cardLeft.appendChild(divRollUp);

    aRollUp.onclick = () => {
        cardLeft.classList.toggle("rolledUp");
        cardLeft.getElementsByClassName("card-body")[0].classList.toggle("hiddentab");
        cardRight.classList.toggle("rightCardFS");
    }

    let cardBody = document.createElement("div");
    cardBody.className = "card-body";
    let container = document.createElement("div");
    container.className = "container leftSide";
    let row2 = document.createElement("div");
    row2.className = "row";
    let col12_2 = document.createElement("div");
    col12_2.className = "col-12";

    // let btnDelete = document.createElement("button");
    // btnDelete.innerHTML = "Удалить подразделение";
    // btnDelete.setAttribute("onclick", "deleteTab('"+ id_sub +"')");
    // btnDelete.style = "margin-bottom: 15px";
    // tabPane.appendChild(btnDelete);


    col12_1.style = "display: flex";

    let cardRight = document.createElement("div");
    cardRight.className = "card rightCard65";
    cardRight.id = "cardRight";
    cardRight.style = "margin-left: 15px;";
    cardRight.innerHTML = "подзразделения";

    row2.appendChild(col12_2);
    container.appendChild(row2);
    cardBody.appendChild(container);
    cardLeft.appendChild(cardBody);
    col12_1.appendChild(cardLeft);
    col12_1.appendChild(cardRight);
    row1.appendChild(col12_1);
    tabPane.appendChild(row1);


    // let btnSave = document.createElement("button");
    // btnSave.innerHTML = "Сохранить информацию о подразделении";
    // btnSave.setAttribute("onclick", "saveTab('"+ id_sub +"')");
    // tabPane.appendChild(btnSave);

    tabContent.appendChild(tabPane);

}


function getMainTab(name, id_sub){

    let tablist = document.getElementById("tablist");
    let tab = document.createElement("li");
    tab.classList.add("nav-item");
    let a = document.createElement("button");
    a.className = "nav-link";
    a.id = 'button' + id_sub;
    a.setAttribute("data-toggle", "tab");
    a.setAttribute("href", "#");
    a.setAttribute("role", "tab");
    a.setAttribute("aria-selected", "false");
    tab.setAttribute("onclick", "showTab(this,"+id_sub+")");
    a.innerHTML = "Самооценка " + name;
    tab.appendChild(a);
    tab.id = "tab" + id_sub;
    tablist.appendChild(tab);


    let tabContent = document.getElementsByClassName("tab-content tab-transparent-content")[4];
    let tabPane = document.createElement("div");
    tabPane.className = "tab-pane fade show";
    tabPane.id = "tab" + id_sub + "-";
    let row1 = document.createElement("div");
    row1.className = "row";
    let col12_1 = document.createElement("div");
    col12_1.className = "col-12 grid-margin";
    let cardLeft = document.createElement("div");
    cardLeft.className = "card";
    cardLeft.id = "leftCardMain";

    let divRollUp = document.createElement("div");
    divRollUp.className = "d-md-block d-none";
    divRollUp.style = "text-align: end;margin-top: 5px;";
    let aRollUp = document.createElement("a");
    aRollUp.href = "#";
    aRollUp.className = "text-light p-1";
    aRollUp.id = "rollUpMain";
    let iconRollUp = document.createElement("i");
    iconRollUp.className = "mdi mdi-view-dashboard";

    aRollUp.appendChild(iconRollUp);
    divRollUp.appendChild(aRollUp);
    cardLeft.appendChild(divRollUp);

    aRollUp.onclick = () => {
        cardLeft.classList.toggle("rolledUp");
        cardLeft.getElementsByClassName("card-body")[0].classList.toggle("hiddentab");
        cardRight.classList.toggle("rightCardFS");
    }

    let cardBody = document.createElement("div");
    cardBody.className = "card-body";
    let container = document.createElement("div");
    container.className = "container leftSide";
    let row2 = document.createElement("div");
    row2.className = "row";
    let col12_2 = document.createElement("div");
    col12_2.className = "col-12";
    col12_1.style = "display: flex";

    let cardRight = document.createElement("div");
    cardRight.className = "card rightCard65";
    cardRight.id = "cardRight";
    cardRight.style = "margin-left: 15px;";
    cardRight.innerHTML = "главная";
    cardLeft.style = "display: none";
    row2.appendChild(col12_2);
    container.appendChild(row2);
    cardBody.appendChild(container);
    cardLeft.appendChild(cardBody);
    col12_1.appendChild(cardLeft);
    col12_1.appendChild(cardRight);
    row1.appendChild(col12_1);
    tabPane.appendChild(row1);

    // let btnSave = document.createElement("button");
    // btnSave.innerHTML = "Сохранить информацию о подразделении";
    // btnSave.setAttribute("onclick", "saveTab('"+ id_sub +"')");
    // tabPane.appendChild(btnSave);

    tabContent.appendChild(tabPane);


}




function addTab(){
    let nameTab = prompt("Введите название структурного подразделения");

    let number_app = document.getElementById("id_application");
    let id_application = number_app.innerHTML;
    $.ajax({
        url: "addSubvision.php",
        method: "POST",
        data: {id_application: id_application, name: nameTab}
    })
        .done(function( response ) {
            let id = response;
         //   console.log(nameTab + " " + id);
            getTabs(nameTab, id);
        });



}

function deleteTab(id_sub){
    $.ajax({
        url: "deleteTab.php",
        method: "POST",
        data: {id_sub: id_sub}
    })
        .done(function( response ) {

        });


    let thisTab = document.getElementById("tab"+id_sub);
    let thisTab1 = document.getElementById("tab"+id_sub+"-");
    thisTab.remove();
    thisTab1.remove();

    let mainTabDiv = document.getElementById("tab1-");
    let mainTab = document.getElementById("tab1");
    mainTabDiv.classList.add("active");
    mainTab.children[0].classList.add("active");


}

$("#btnSuc").on("click", function () {
    let number_app = document.getElementById("id_application");
    let naim = document.getElementById("naim");
    let sokr = document.getElementById("sokr");
    let unp = document.getElementById("unp");
    let adress = document.getElementById("adress");
    let tel = document.getElementById("tel");
    let email = document.getElementById("email");
    let rukovoditel = document.getElementById("rukovoditel");
    let predstavitel = document.getElementById("predstavitel");
    let soprPismo = document.getElementById("soprPismo");
    let copyRaspisanie = document.getElementById("copyRaspisanie");
    let orgStrukt = document.getElementById("orgStrukt");

    let naimText = naim.value;
    let sokrText = sokr.value;
    let unpText = unp.value;
    let adressText = adress.value;
    let telText = tel.value;
    let emailText = email.value;
    let rukovoditelText = rukovoditel.value;
    let predstavitelText = predstavitel.value;

    let id_application = number_app.innerText;
    let modal = document.getElementById("myModal");
    modal.classList.add("show");
    modal.style = "display: block";

    // var doverennost = document.getElementById("doverennost"),
   let xhr = new XMLHttpRequest(),
        form = new FormData();
    // var doverennost = doverennost.files[0];
    // form.append("doverennost", doverennost);
    form.append("naimUZ", naimText);
    form.append("sork", sokrText);
    form.append("unp", unpText);
    form.append("id_application", id_application);
    form.append("adress", adressText);
    form.append("tel", telText);
    form.append("email", emailText);
    form.append("rukovoditel", rukovoditelText);
    form.append("predstavitel", predstavitelText);

    let soprPismoFile = soprPismo.files[0];
    form.append("soprPismo", soprPismoFile);
    let copyRaspisanieFile = copyRaspisanie.files[0];
    form.append("copyRaspisanie", copyRaspisanieFile);
    let orgStruktFile = orgStrukt.files[0];
    form.append("orgStrukt", orgStruktFile);

    xhr.open("post", "saveApplication.php", true);
    xhr.send(form);
    alert("Заявление сохранено");
    location.href = "/index.php?application";

});

function saveTab(id_sub){

    if(isSavedMarks()) {
        //  console.log(OpenSub);
        // arrChange=false;
      //  saveMarks(OpenSub);
        if (saveMarks(OpenSub) === false) {
            return;
        }
    }
    arrChange=false;
    OpenSub=0;

    let thisTab = document.getElementById("tab"+id_sub+"-");
    let arrCheckInputs = thisTab.getElementsByClassName("form-check-input");
    let arrIdCriterias = new Array();
    for (let input of arrCheckInputs){
        let id_criteria = input.id.substring(8);

        if(input.checked === true ){
            let item = {
                id_criteria : id_criteria,
                value : 1
            };
            arrIdCriterias.push(item);
        }
        // else{
        //     let item = {
        //         id_criteria : id_criteria,
        //         value : 0
        //     };
        //     arrIdCriterias.push(item);
        // }
    }


    $.ajax({
        url: "saveTab.php",
        method: "POST",
        data: {id_sub: id_sub, arr_id_criterias: arrIdCriterias}
    })
        .done(function( response ) {

        });

    createAccordionCards(id_sub);
}

let id_open_criteria = 0;

function createAccordionCards(id_sub) {

 //   let marks_app = [];
/*
    for (let i=marks_app.length-1; i>-1 ; i--) {
        //  console.log(marks_app[i]);
        marks_app.pop();
    }
*/
    marks_app.arClear();

    let thisTab = document.getElementById("tab" + id_sub + "-");
    let cardRight = thisTab.querySelector("#cardRight");
    cardRight.innerHTML = "";
    let arrCheckInputs = thisTab.getElementsByClassName("form-check-input");
    let arrIdCriterias = new Array();

    let divAccordion = document.createElement("div");
    divAccordion.className = "accordion";
    let divCard = document.createElement("div");
    divCard.className = "card";
    for (let input of arrCheckInputs) {

        if (input.checked === true) {
            let id_criteria = input.id.substring(8);
            let name_criteria = document.querySelector("label[for='checkbox"+id_criteria+"']")


            let divCardHeader = document.createElement("div");
            divCardHeader.className = "card-header";
            divCardHeader.id = "heading" + id_criteria;
            divCardHeader.style = "justify-content: center; display: inline-grid;";


            let id_applicationEl = document.getElementById("id_application");
            let id_application = id_applicationEl.innerText;

            let divCardHeaderMark = document.createElement("div");

            $.ajax({
                url: "getReportCriteria.php",
                method: "GET",
                data: {id_application: id_application, id_sub: id_sub, id_criteria: id_criteria}
            })
                .done(function( response ) {

                    let criteriaMark ='';
                    let criteriaMarkAccred ='';
                    let marksSub = JSON.parse(response);
                 
                    criteriaMark = criteriaMark + 'Количественная самооценка ' + marksSub['otmetka_all_count_yes'] + '/('  
                                            + marksSub['otmetka_all_count_all'] + ' - ' + marksSub['otmetka_all_count_not_need'] + ') = ' + marksSub['otmetka_all'] +'%';
                    criteriaMark += ' По 1 классу ' + marksSub['otmetka_class_1_count_yes'] + '/('  
                    + marksSub['otmetka_class_1_count_all'] + ' - ' + marksSub['otmetka_class_1_count_not_need'] + ') = ' + marksSub['otmetka_class_1'] +'%';
                    criteriaMark +=  ' По 2 классу ' + marksSub['otmetka_class_2_count_yes'] + '/('  
                    + marksSub['otmetka_class_2_count_all'] + ' - ' + marksSub['otmetka_class_2_count_not_need'] + ') = ' + marksSub['otmetka_class_2'] +'%';
                    criteriaMark +=  ' По 3 классу ' + marksSub['otmetka_class_3_count_yes'] + '/('  
                    + marksSub['otmetka_class_3_count_all'] + ' - ' + marksSub['otmetka_class_3_count_not_need'] + ') = ' + marksSub['otmetka_class_3'] +'%';
    
                    criteriaMarkAccred = criteriaMarkAccred + 'Количественная оценка ' + marksSub['otmetka_accred_all_count_yes'] + '/('  
                    + marksSub['otmetka_accred_all_count_all'] + ' - ' + marksSub['otmetka_accred_all_count_not_need'] + ') = ' + marksSub['otmetka_accred_all'] +'%';
                    criteriaMarkAccred += ' Верификация результатов самооценки ' + marksSub['otmetka_verif_count_yes'] + '/('  
                    + marksSub['otmetka_verif_count_all'] + ' - ' + marksSub['otmetka_verif_count_not_need'] + ') = ' + marksSub['otmetka_verif'] +'%';
                    criteriaMarkAccred += ' По 1 классу ' + marksSub['otmetka_accred_class_1_count_yes'] + '/('  
                    + marksSub['otmetka_accred_class_1_count_all'] + ' - ' + marksSub['otmetka_accred_class_1_count_not_need'] + ') = ' + marksSub['otmetka_accred_class_1'] +'%';
                    criteriaMarkAccred +=  ' По 2 классу ' + marksSub['otmetka_accred_class_2_count_yes'] + '/('  
                    + marksSub['otmetka_accred_class_2_count_all'] + ' - ' + marksSub['otmetka_accred_class_2_count_not_need'] + ') = ' + marksSub['otmetka_accred_class_2'] +'%';
                    criteriaMarkAccred +=  ' По 3 классу ' + marksSub['otmetka_accred_class_3_count_yes'] + '/('  
                    + marksSub['otmetka_accred_class_3_count_all'] + ' - ' + marksSub['otmetka_accred_class_3_count_not_need'] + ') = ' + marksSub['otmetka_accred_class_3'] +'%';

                    
                    divCardHeaderMark.innerHTML = criteriaMark + "<br/>";
                    divCardHeaderMark.innerHTML += criteriaMarkAccred + "<br/><br/>";

                    divCardHeader.appendChild(divCardHeaderMark);
                    // let marks = JSON.parse(response);

                  //  console.log(JSON.parse(response));
                    //  marks.map((item, index) => {

                    //  });

                });



            let btnCollapse = document.createElement("button");
            btnCollapse.className = "btn btn-link";
            btnCollapse.setAttribute("data-toggle", "collapse");
            btnCollapse.setAttribute("data-target", "#collapse"+id_criteria);
            btnCollapse.setAttribute("aria-expanded", "false");
            btnCollapse.setAttribute("aria-controls", "collapse"+id_criteria);
            btnCollapse.innerHTML = name_criteria.innerHTML;
            btnCollapse.style = "text-decoration: none; color: black; font-size: 0.9rem;";


            divCardHeader.appendChild(btnCollapse);



          //  divCardHeader.innerHTML += "<br/>";
            divCard.appendChild(divCardHeader);

            let divCollapse = document.createElement("div");
            divCollapse.className = "collapse";
            divCollapse.id = "collapse"+id_criteria;
            divCollapse.setAttribute("aria-labelledby", "heading"+id_criteria);
            divCollapse.setAttribute("data-parent", "#accordion");
            let divCardBody = document.createElement("div");
            divCardBody.className = "card-body";
            divCardBody.id = "cardBody"+id_criteria;

            divCollapse.appendChild(divCardBody);
            divCard.appendChild(divCollapse);
         //   let marks_app = [];
            divCardHeader.onclick=() =>{
                let collapses = divCard.getElementsByClassName("collapse");

             //   console.log(thisTab.getElementsByClassName('collapse show'));

                if (arrChange == false) {
                    let openedDiv = thisTab.getElementsByClassName('collapse show');
                    //  document.getElementById("collapse"+id_open_criteria);
                    if (openedDiv.length >0) {

                        if (id_open_criteria == id_criteria) {
                            divCollapse.classList.toggle('show');
                        } else {
                            openedDiv[0].classList.remove('show');
                        }
                    } else {
                        divCollapse.classList.toggle('show');
                    }

                    if (id_open_criteria != id_criteria) {
                        divCollapse.classList.add('show');
                    }


                 //   divCollapse.classList.toggle("show");
                    collapseTable(id_criteria, divCardBody,id_sub);
                    id_open_criteria = id_criteria;

                } else {
                    if(isSavedMarks()) {

                     //   saveMarks(id_sub);
                        if (saveMarks(OpenSub) === false) {
                            return;
                        }

                        let openedDiv = thisTab.getElementsByClassName('collapse show');
                        //  document.getElementById("collapse"+id_open_criteria);
                        if (openedDiv.length >0) {

                            if (id_open_criteria == id_criteria) {
                                divCollapse.classList.toggle('show');
                            } else {
                                openedDiv[0].classList.remove('show');
                            }
                        } else {
                            divCollapse.classList.toggle('show');
                        }

                        if (id_open_criteria != id_criteria) {
                            divCollapse.classList.add('show');
                        }

                    //    collapseTable(id_criteria, divCardBody,id_sub);
                    //    id_open_criteria = id_criteria;
                        collapseTable(id_criteria, divCardBody,id_sub);
                        id_open_criteria = id_criteria;

                    } else {
                        arrChange = false;
                    }


                }


            }


        }
    }


    divAccordion.appendChild(divCard);
    cardRight.appendChild(divAccordion);

}



function collapseTable(id_criteria, divCardBody,id_sub){
   // marks_app.splice(0, marks_app.length);
/*
    for (let i=marks_app.length-1; i>-1 ; i--) {
      //  console.log(marks_app[i]);
        marks_app.pop();
    }

 */

   // console.log('status',status);

    marks_app.arClear();

    divCardBody.innerHTML = "";
    divCardBody.style = "padding: 0";

    let table = document.createElement('table');
    table.style = "border: 1px solid black; width:100%";

    let trHeadMain = document.createElement('tr');
    let th1_Main = document.createElement('th');
    th1_Main.innerHTML = 'Критерий';
    th1_Main.style = "border: 1px solid black; width: 20%";
    th1_Main.setAttribute('rowspan','2');

    let th2_Main = document.createElement('th');
    th2_Main.innerHTML = 'Класс критерия';
    th2_Main.style = "border: 1px solid black; width: 3%";
    th2_Main.setAttribute('rowspan','2');


    let th3_Main = document.createElement('th');
    th3_Main.innerHTML = 'Сведения о соблюдении критериев (самооценка)';
    th3_Main.style = "border: 1px solid black; text-align: center; ";
    th3_Main.setAttribute('colspan','3');

    let th4_Main = document.createElement('th');
    th4_Main.innerHTML = 'Сведения об оценке критериев';
    th4_Main.style = "border: 1px solid black; text-align: center";
    th4_Main.setAttribute('colspan','2');
    

    let trHead = document.createElement('tr');
    //trHead.style = "border: 1px solid black; width:100%";

  //  let trHead = document.createElement('trHead');
    let th1 = document.createElement('td');
    th1.innerHTML = 'Критерий';
    th1.style = "border: 1px solid black";

    let th2 = document.createElement('td');
    th2.innerHTML = 'Класс критерия';
    th2.style = "border: 1px solid black";

    let th3 = document.createElement('th');
    th3.innerHTML = 'Сведения по самооценке ОЗ';
    th3.style = "border: 1px solid black; width: 5%";

    let th4 = document.createElement('th');
    th4.innerHTML = 'Документы и сведения, на основании которых проведена самооценка';
    th4.style = "width:350px; border: 1px solid black";


    let th5 = document.createElement('th');
    th5.innerHTML = 'Примечание';
    th5.style = "border: 1px solid black";

    let th6 = document.createElement('th');
    th6.innerHTML = 'Сведения по оценке соответствия';
    th6.style = "border: 1px solid black; width: 5%; text-align: 5%";

    let th7 = document.createElement('th');
    th7.innerHTML = 'Документы и сведения, на основании которых проведена оценка соответствия';
    th7.style = "border: 1px solid black";
    
    let thNum = document.createElement('th');
    thNum.innerHTML = '№ п/п';
    thNum.style = "border: 1px solid black";
    thNum.setAttribute('rowspan','2');
    trHeadMain.appendChild(thNum);

    // trHead.appendChild(th1);
    // trHead.appendChild(th2);
    trHeadMain.appendChild(th1_Main);
    trHeadMain.appendChild(th2_Main);
    trHeadMain.appendChild(th3_Main);
    trHeadMain.appendChild(th4_Main);
    
    table.appendChild(trHeadMain);
    // trHead.appendChild(th1);
    // trHead.appendChild(th2);
    trHead.appendChild(th3);
    trHead.appendChild(th4);
    trHead.appendChild(th5);
    trHead.appendChild(th6);
    trHead.appendChild(th7);

    table.appendChild(trHead);

    

    let tbody = document.createElement('tbody');
    table.appendChild(tbody);


    $.ajax({
        url: "getMarkStatus2.php",
        method: "GET",
        data: {id_sub: id_sub, id_criteria: id_criteria}
    })
        .done(function( response ) {

            let marks = JSON.parse(response);

            marks.map((item, index) => {

                marks_app.setArr(item);//   push(item);



                let tr = document.createElement('tr');

                let td1 = document.createElement('td');
                td1.innerHTML = item['mark_name'];
                td1.style = "border: 1px solid black; padding: 0.2rem 0.75rem; text-align: left";

                let td2 = document.createElement('td');
                td2.innerHTML = item['mark_class'];
                td2.style = "border: 1px solid black; text-align: center";
                let td3 = document.createElement('td');
              //  td3.innerHTML = item['filed4'];
                td3.style = "border: 1px solid black";
                let divTd3 = document.createElement("div");
                divTd3.style = "display: flex; justify-content: center;";
                td3.appendChild(divTd3);
                let td4 = document.createElement('td');
                td4.style = "border: 1px solid black";
                let input4 = document.createElement("textarea");
                input4.setAttribute("rows","3");

                    input4.setAttribute("disabled","true");

                input4.style = "width:100%";
                input4.value = item['field5'];

                let arr;
                input4.oninput =() => ChangeValue(id_criteria,item['id_mark'], 'field5', input4.value, item['id_mark_rating'], index,id_sub);
            //    input4.setAttribute("type","text");
                td4.appendChild(input4);
                let td5 = document.createElement('td');
                td5.style = "border: 1px solid black";
                let input5 = document.createElement("textarea");
                 // input4.setAttribute("disabled","true");
                input5.style = "width:100%";
                input5.setAttribute("rows","3");
                input5.value = item['field6'];
                input5.setAttribute("disabled","true");
                input5.oninput = ()=>{ChangeValue(id_criteria,item['id_mark'],'field6', input5.value, item['id_mark_rating'], index,id_sub)};
              //  input5.setAttribute("type","text-area");
                td5.appendChild(input5);
                


                let td6 = document.createElement('td');
                //  td3.innerHTML = item['filed4'];
                  td6.style = "border: 1px solid black";
                  let divTd6 = document.createElement("div");
                  divTd6.style = "display: flex; justify-content: center;";
                  td6.appendChild(divTd6);


                let td7 = document.createElement('td');
                td7.style = "border: 1px solid black";
                let input7 = document.createElement("textarea");

                    if ((status == 2) || (status == 3)) {
                    } else {
                        input7.setAttribute("disabled","true");
                    }

                input7.style = "width:100%; height: 100%";
                input7.setAttribute("rows","3");
                input7.value = item['field8'];
                input7.oninput = ()=>{ChangeValue(id_criteria,item['id_mark'],'field8', input7.value, item['id_mark_rating'], index,id_sub)};
              //  input5.setAttribute("type","text-area");
                let divtd8 = document.createElement("div");
                divtd8.style = "height: 15rem";

                divtd8.appendChild(input7);
                td7.appendChild(divtd8);


                let tdNum = document.createElement('td');
                tdNum.innerHTML = item['str_num'];
                tdNum.style = "border: 1px solid black;text-align: center";

                tr.appendChild(tdNum);
                tr.appendChild(td1);
                tr.appendChild(td2);
                tr.appendChild(td3);

                tr.appendChild(td4);
                tr.appendChild(td5);
                tr.appendChild(td6);
                tr.appendChild(td7);

                createSelectMark(id_criteria,item['id_mark'], divTd3, item['field4'], item['id_mark_rating'], index,id_sub,'field4');
                createSelectMark(id_criteria,item['id_mark'], divTd6, item['field7'], item['id_mark_rating'], index,id_sub,'field7');
                tbody.appendChild(tr);

            });
       //     console.log(marks_app);

        });
    divCardBody.appendChild(table);

    let bunt = document.createElement('button');
    bunt.onclick=() => saveMarks(id_sub);
    bunt.innerHTML='Сохранить результаты оценки критериев';
    bunt.className = "btn btn-success";
    bunt.style = "margin-top: 1rem";
    divCardBody.appendChild(bunt);
    if(status == 4 || status == 5){bunt.remove();}

    //  return marks_app;
}



function createSelectMark(id_criteria,id_mark, nameColumn, value, id_mark_rating, index,id_sub, name_field){
    let newSelect = document.createElement('select');
   // newSelect.disabled =true;
    let optEmpty  = document.createElement('option');
    let opt1  = document.createElement('option');
    let opt2  = document.createElement('option');
    let opt3  = document.createElement('option');

    optEmpty.value = null;
    optEmpty.text = '';
    opt1.value = '1';
    opt1.text = 'Да';
    opt2.value = '2';
    opt2.text = 'Нет';
    opt3.value = '3';
    opt3.text = 'Не требуется';

    newSelect.add(optEmpty);
    newSelect.add(opt1);
    newSelect.add(opt2);
    newSelect.add(opt3);
let arr;

    newSelect.onchange = ()=>{ChangeValue(id_criteria,id_mark, name_field, newSelect.options.selectedIndex, id_mark_rating, index,id_sub) };

    if ((id_mark_rating !== null) && (value !== null)) {
        newSelect.selectedIndex = Number(value);
    }

    if ((status == 2) || (status == 3)) {
   // if ((status == 4) || (status == 5) || (status == 1)) {
    } else {
        newSelect.setAttribute("disabled","");
    }

    if(name_field === 'field4') {
        newSelect.setAttribute("disabled","");
    }

    nameColumn.appendChild(newSelect);
}

let arrChange= false;


function ChangeValue(id_criteria,id_mark, field_name, value, id_mark_rating, index,id_sub) {

   // arrChange.id_criteria = id_criteria;
    arrChange = true;

    marks_app.getArr().forEach((item, index) => {
        if (Number(item['id_mark']) == id_mark ) {
            marks_app.setValueByIndex([index],[field_name],value);
        }
    })
  //  console.log(marks_app.getArr());
    OpenSub = id_sub;
    setDisabledOnChange(true);
}

function isSavedMarks(){
    if (arrChange == true) {
        let res = confirm("Есть несохраненные данные, при выходе они будут потеряны. Сохранить?"); 
        console.log('res',res);
        if(res == false){
            console.log('check');
            setDisabledOnChange(false);
        }

        return res
                 
    } else return false;

    // if (arrChange == true) {
    //     return confirm("Есть несохраненные данные, при выходе они будут потеряны. Сохранить?");
    // } else return false;

}

function setDisabledOnChange(value){
    if (value == true) {
        let clickElel = document.getElementById('button1');
        clickElel.setAttribute('disabled', "true");
    } else {
        let clickElel = document.getElementById('button1');
        clickElel.removeAttribute('disabled');
    }
}

let flagSave = true;


function validateDataMarks(){
   let result = true;

   let vall = marks_app.getArr().filter(item =>  ((Number(item['field4'])===2) || (Number(item['field4'])===3)) && (item['field6'].trim()=='') );

   // let emptyVall = marks_app.getArr().filter(item =>  (Number(item['field4'])===0) );

 //  console.log(emptyVall);

   if(vall.length >0){
       alert(`Не заполнено поле "Примечание" в критерии ${vall[0]['mark_name']}`);
       flagSave= false;
       result = false;
   } else {
       // if(emptyVall.length>0) {
       //     alert(`Не заполнено поле "Сведения по самооценке ОЗ" в критерии ${emptyVall[0]['mark_name']}`);
       //     flagSave= false;
       //     result = false;
       // }
   }

  // return flagSave;

  return result;
}


function saveMarks(id_sub){

    let arr = new Array();

    marks_app.getArr().map(item => {
        arr.push(item);
    })

    console.log(arr);

    let result = true;

    if (validateDataMarks()===false) {
        result = false;
    } else  {
        $.ajax({
            url: "saveMarksAccred.php",
            method: "POST",
            data: {id_sub: id_sub, marks: arr}
        })
            .done(function( response ) {
                alert("Сохранено!");
                setDisabledOnChange(false);
                arrChange=false;
            });

        result = true;
    }

    return result;

}
let allTabsMainPage = document.getElementsByClassName("tab-content tab-transparent-content");

$("#home-tab").on("click", () => {
    for (let i = 0 ; i < 4; i++){
        allTabsMainPage[i].children[0].classList.remove("show");
        allTabsMainPage[i].children[0].classList.remove("active");
    }
    allTabsMainPage[0].children[0].classList.add("show");
    allTabsMainPage[0].children[0].classList.add("show");
    status = 1;
  //  console.log(status);
});

$("#rassmotrenie-tab").on("click", () => {

    for (let i = 0 ; i < 4; i++){
        allTabsMainPage[i].children[0].classList.remove("show");
        allTabsMainPage[i].children[0].classList.remove("active");
    }
    allTabsMainPage[1].children[0].classList.add("show");
    allTabsMainPage[1].children[0].classList.add("active");
    status = 2;
  //  console.log(status);

});

$("#odobrennie-tab").on("click", () => {

    for (let i = 0 ; i < 4; i++){
        allTabsMainPage[i].children[0].classList.remove("show");
        allTabsMainPage[i].children[0].classList.remove("active");
    }
    allTabsMainPage[2].children[0].classList.add("show");
    allTabsMainPage[2].children[0].classList.add("active");
    status = 4;
  //  console.log(status);

});

$("#neodobrennie-tab").on("click", () => {

    for (let i = 0 ; i < 4; i++){
        allTabsMainPage[i].children[0].classList.remove("show");
        allTabsMainPage[i].children[0].classList.remove("active");
    }
    allTabsMainPage[3].children[0].classList.add("show");
    allTabsMainPage[3].children[0].classList.add("active");
    status = 5;
 //   console.log(status);

});

$("#btnChecking").on("click", () => {
    let id_application = document.getElementById("id_application");

    $.ajax({
        url: "changeStatusChecking.php",
        method: "GET",
        data: {id_application: id_application.innerText}
    })
        .done(function( response ) {

            alert("Заявка проверяется");
            location.href = "/index.php?users";
        });

});

$("#btnOk").on("click", () => {
    let id_application = document.getElementById("id_application");
    let divReport = document.getElementById("divReport");
    let a = divReport.getElementsByTagName("a")[0];
    if(a) {
        $.ajax({
            url: "changeStatusOk.php",
            method: "GET",
            data: {id_application: id_application.innerText}
        })
            .done(function (response) {

                alert("Заявка принята");
                location.href = "/index.php?users";
            });
    }
    else
        alert("Не прикреплен отчет!");
});

$("#btnNeOk").on("click", () => {
    let id_application = document.getElementById("id_application");

    $.ajax({
        url: "changeStatusNeOk.php",
        method: "GET",
        data: {id_application: id_application.innerText}
    })
        .done(function( response ) {

            alert("Заявка отклонена");
            location.href = "/index.php?users";
        });

});

$("#btnCalc").on("click", () => {
    let id_application = document.getElementById("id_application");

    $.ajax({
        url: "getCalcAccred.php",
        method: "GET",
        data: {id_application: id_application.innerText}
    })
        .done(function( response ) {
            location.href = "/index.php?users";
        });
});

$("#formReport").on("change", () =>{
    let divReport = document.getElementById("divReport");
    let sopr = divReport.getElementsByTagName("a")[0];
    if(sopr)
        sopr.remove();
    let fileReport = document.getElementById("fileReport");
    fileReport.insertAdjacentHTML("afterend", "<a href='/documents/Отчеты/" + fileReport.files[0].name + "'>" + fileReport.files[0].name + "</a>");

    let id_application = document.getElementById("id_application");

    let xhr = new XMLHttpRequest(),
        form = new FormData();
    let orgStructFile = fileReport.files[0];
    form.append("id_application", id_application.innerText);
    form.append("fileReport", orgStructFile);

    xhr.open("post", "postFileReport.php", true);
    xhr.send(form);
});


