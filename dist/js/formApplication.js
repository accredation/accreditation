// let tab1 = document.getElementById("tab-1");
// let tab2 = document.getElementById("tab-2");
// let tab3 = document.getElementById("tab-3");
// let tab4 = document.getElementById("tab-4");
// let tab5 = document.getElementById("tab-5");

let data_old = new Array();

let status = 1;

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
 //   console.log(OpenSub);
    let tablist = document.getElementById("tablist");


   if(isSavedMarks()) {
      //  console.log(OpenSub);
       // arrChange=false;
       if (saveMarks(OpenSub) === false) {
        //   console.log('OpenSub',OpenSub);
        //   console.log('id_sub',id_sub);

           for (let item of tablist.children){
               let a = item.children[0];
               a.removeAttribute("data-toggle");
               //   a.classList.remove("active");
           }

           let main = document.getElementById('tab1');
           main.children[0].removeAttribute("data-toggle");

           element.classList.add("active");
           element.children[0].setAttribute("data-toggle", "tab");

           /*
            let actTab = document.getElementById("tab"+OpenSub);
            console.log(actTab.getElementsByTagName("a")[0]);
            let a = actTab.getElementsByTagName("a")[0];
            a.setAttribute("aria-selected", "true");
           a.classList.add("active");

            */
           return;
       }
    }

  /*
    let openedDiv =  document.getElementById("collapse"+id_open_criteria);
    if (openedDiv !== null) {
        openedDiv.classList.remove("show");
        console.log(openedDiv);
    }
   */

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
            });

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

function showModal(id_application){
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

    let divSoprPismo = document.getElementById("divSoprovodPismo");
    let divCopyRaspisanie = document.getElementById("divCopyRaspisanie");
    let divOrgStrukt = document.getElementById("divOrgStrukt");
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
            let login = getCookie('login');
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
        if(sopr) {
            sopr.remove();
        }
        if(copy) {
            copy.remove();
        }
        if(org) {
            org.remove();
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
        if(sopr) {
            sopr.remove();
        }
        if(copy) {
            copy.remove();
        }
        if(org) {
            org.remove();
        }
        modal.classList.remove("show");
        modal.style = "display: none";
        for(let i = tablist.children.length - 1; i > 0; i--){
            tablist.children[i].remove();
        }
    });

    $("#btnPrint").on("click", function () {
        let naim = document.getElementById("naim");
        let unp = document.getElementById("unp");
        let naimText = naim.value;
        let unpText = unp.value;
        var WinPrint = window.open('','','left=50,top=50,width=800,height=640,toolbar=0,scrollbars=1,status=0');
        WinPrint.document.write('Наименование организации: ');
        WinPrint.document.write(naimText);
        WinPrint.document.write('<br/>');
        WinPrint.document.write('УНП: ');
        WinPrint.document.write(unpText);
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        WinPrint.close();

    });
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
        input.style.borderColor = 'red';
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
    let a = document.createElement("a");
    a.className = "nav-link";
   a.setAttribute("data-toggle", "tab");
    a.setAttribute("href", "#");
    a.setAttribute("role", "tab");
    a.setAttribute("aria-selected", "false");

   // tab.setAttribute("onclick", "showTab(this,"+id_sub+")");

    a.innerHTML = "Самооценка " + name;
    tab.appendChild(a);
    tab.onclick= () => {
      //  console.log(tab.children[0]);
    //    tab.children[0].setAttribute("data-toggle", "tab");
        if(isSavedMarks()) {
            //  console.log(OpenSub);
            // arrChange=false;
            if (saveMarks(OpenSub) === false) {
                return;
            }

        }
     //   console.log(1);
        showTab(tab,id_sub);
    }
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
    cardLeft.style = "width: 35%";
    let cardBody = document.createElement("div");
    cardBody.className = "card-body";
    let container = document.createElement("div");
    container.className = "container leftSide";
    let row2 = document.createElement("div");
    row2.className = "row";
    let col12_2 = document.createElement("div");
    col12_2.className = "col-12";

    let btnDelete = document.createElement("button");
    btnDelete.innerHTML = "Удалить подразделение";
    btnDelete.setAttribute("onclick", "deleteTab('"+ id_sub +"')");
    btnDelete.style = "margin-bottom: 15px";
    tabPane.appendChild(btnDelete);


    col12_1.style = "display: flex";

    let cardRight = document.createElement("div");
    cardRight.className = "card";
    cardRight.id = "cardRight";
    cardRight.style = "margin-left: 15px; width: 65%";
    cardRight.innerHTML = "подзразделения";

    row2.appendChild(col12_2);
    container.appendChild(row2);
    cardBody.appendChild(container);
    cardLeft.appendChild(cardBody);
    col12_1.appendChild(cardLeft);
    col12_1.appendChild(cardRight);
    row1.appendChild(col12_1);
    tabPane.appendChild(row1);


    let btnSave = document.createElement("button");
    btnSave.innerHTML = "Сохранить информацию о подразделении";
    btnSave.setAttribute("onclick", "saveTab('"+ id_sub +"')");
    tabPane.appendChild(btnSave);

    tabContent.appendChild(tabPane);
}


function getMainTab(name, id_sub){

    let tablist = document.getElementById("tablist");
    let tab = document.createElement("li");
    tab.classList.add("nav-item");
    let a = document.createElement("a");
    a.className = "nav-link";
    a.setAttribute("data-toggle", "tab");
    a.setAttribute("href", "#");
    a.setAttribute("role", "tab");
    a.setAttribute("aria-selected", "false");
  //  tab.setAttribute("onclick", "showTab(this,"+id_sub+")");
    tab.onclick= () => {
    //    tab.children[0].setAttribute("data-toggle", "tab");
        if(isSavedMarks()) {
            //  console.log(OpenSub);
            // arrChange=false;
            if (saveMarks(OpenSub) === false) {
                return;
            }

        }
       // console.log(2);
        showTab(tab,id_sub);
    }
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
    cardLeft.style = "width: 35%";
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
    cardRight.className = "card";
    cardRight.id = "cardRight";
    cardRight.style = "margin-left: 15px; width: 65%";
    cardRight.innerHTML = "главная";

    row2.appendChild(col12_2);
    container.appendChild(row2);
    cardBody.appendChild(container);
    cardLeft.appendChild(cardBody);
    col12_1.appendChild(cardLeft);
    col12_1.appendChild(cardRight);
    row1.appendChild(col12_1);
    tabPane.appendChild(row1);

    let btnSave = document.createElement("button");
    btnSave.innerHTML = "Сохранить информацию о подразделении";
    btnSave.setAttribute("onclick", "saveTab('"+ id_sub +"')");
    tabPane.appendChild(btnSave);

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
            divCardHeader.style = "justify-content: center; display: flex;";
            let btnCollapse = document.createElement("button");
            btnCollapse.className = "btn btn-link";
            btnCollapse.setAttribute("data-toggle", "collapse");
            btnCollapse.setAttribute("data-target", "#collapse"+id_criteria);
            btnCollapse.setAttribute("aria-expanded", "false");
            btnCollapse.setAttribute("aria-controls", "collapse"+id_criteria);
            btnCollapse.innerHTML = name_criteria.innerHTML;
            btnCollapse.style = "text-decoration: none; color: black; font-size: 0.9rem;";


            divCardHeader.appendChild(btnCollapse);
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
    let trHead = document.createElement('tr');
    //trHead.style = "border: 1px solid black; width:100%";

  //  let trHead = document.createElement('trHead');
    let th1 = document.createElement('td');
    th1.innerHTML = 'Критерий';
    th1.style = "border: 1px solid black";

    let th2 = document.createElement('td');
    th2.innerHTML = 'Класс критерия';
    th2.style = "border: 1px solid black";

    let th3 = document.createElement('td');
    th3.innerHTML = 'Сведения по самооценке ОЗ';
    th3.style = "border: 1px solid black";

    let th4 = document.createElement('td');
    th4.innerHTML = 'Документы и сведения, на основании которых проведена самооценка';
    th4.style = "width:350px; border: 1px solid black";


    let th5 = document.createElement('td');
    th5.innerHTML = 'Примечание';
    th5.style = "border: 1px solid black";

    trHead.appendChild(th1);
    trHead.appendChild(th2);
    trHead.appendChild(th3);
    trHead.appendChild(th4);
    trHead.appendChild(th5);

    table.appendChild(trHead);

    let tbody = document.createElement('tbody');
    table.appendChild(tbody);


    $.ajax({
        url: "getMark.php",
        method: "GET",
        data: {id_sub: id_sub, id_criteria: id_criteria}
    })
        .done(function( response ) {

            let marks = JSON.parse(response);

            marks.map((item, index) => {

              //  console.log('item ', item['id_mark']);
            //    console.log(mark);
/*
                let ff = false;

                console.log('marks_app');
                console.log(marks_app);

                 marks_app.map(element => {
                    console.log('element ', element['id_mark']);
                   ff =  false;
                   if (element['id_mark'] == item['id_mark']) {
                        ff =  true;
                   }
                });

                console.log('ff1',ff)

                if (ff == false) {
                    marks_app.push(item);
                 //   console.log('push',item);
                }
*/
                marks_app.setArr(item);//   push(item);



                let tr = document.createElement('tr');

                let td1 = document.createElement('td');
                td1.innerHTML = item['mark_name'];
                td1.style = "border: 1px solid black";

                let td2 = document.createElement('td');
                td2.innerHTML = item['mark_class'];
                td2.style = "border: 1px solid black";
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
                if (status == 1) {
                } else {
                    input4.setAttribute("readonly","");
                }
                input4.style = "width:100%";
                input4.value = item['field5'];

                let arr;
                input4.oninput =() => ChangeValue(id_criteria,item['id_mark'], 'field5', input4.value, item['id_mark_rating'], index,id_sub);
            //    input4.setAttribute("type","text");
                td4.appendChild(input4);
                let td5 = document.createElement('td');
                td5.style = "border: 1px solid black";
                let input5 = document.createElement("textarea");
                if (status == 1) {
                } else {
                    input5.setAttribute("readonly","");
                }
                input5.style = "width:100%";
                input5.setAttribute("rows","3");
                input5.value = item['field6'];
                input5.oninput = ()=>{ChangeValue(id_criteria,item['id_mark'],'field6', input5.value, item['iid_mark_rating'], index,id_sub)};
              //  input5.setAttribute("type","text-area");
                td5.appendChild(input5);
              //  td5.innerHTML = item['field6'];

                tr.appendChild(td1);
                tr.appendChild(td2);
                tr.appendChild(td3);

                tr.appendChild(td4);
                tr.appendChild(td5);

                createSelectMark(id_criteria,item['id_mark'], divTd3, item['field4'], item['id_mark_rating'], index,id_sub );

                tbody.appendChild(tr);

            });
       //     console.log(marks_app);

        });
    divCardBody.appendChild(table);

    let bunt = document.createElement('button');
    bunt.onclick=() => saveMarks(id_sub);
    bunt.innerHTML='BUTTON';
    divCardBody.appendChild(bunt);
  //  return marks_app;
}



function createSelectMark(id_criteria,id_mark, nameColumn, value, id_mark_rating, index,id_sub){
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
    newSelect.onchange = ()=>{ChangeValue(id_criteria,id_mark, 'field4', newSelect.options.selectedIndex, id_mark_rating, index,id_sub) };

    if ((id_mark_rating !== null) && (value !== null)) {
        newSelect.selectedIndex = Number(value);
    }

    if (status == 1) {
    } else {
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

  //  retArr(marks_app);
    //return marks_app;
}

function isSavedMarks(){

    if (arrChange == true) {



        return confirm("Есть несохраненные данные, при выходе они будут потеряны. Сохранить?");
    } else return false;

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

   // validateDataMarks();
   // console.log(arrChange);
   // console.log(validateDataMarks());

    marks_app.getArr().map(item => {
        arr.push(item);
      //  console.log(item);

    })

    let result = true;

    if (validateDataMarks()===false) {
        result = false;
    } else  {
        $.ajax({
            url: "saveMarks.php",
            method: "POST",
            data: {id_sub: id_sub, marks: arr}
        })
            .done(function( response ) {
                alert("Сохранено!");
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

$("#btnSend").on("click", () => {
    let id_application = document.getElementById("id_application");

    $.ajax({
        url: "sendApp.php",
        method: "GET",
        data: {id_application: id_application.innerText}
    })
        .done(function( response ) {

                alert("Заявление отправлено");
                location.href = "/index.php?application";
            });

});




