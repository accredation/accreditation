let tab1 = document.getElementById("tab-1");
let tab2 = document.getElementById("tab-2");
let tab3 = document.getElementById("tab-3");
let tab4 = document.getElementById("tab-4");
let tab5 = document.getElementById("tab-5");

let data_old = new Array();

function showTab(element,id_sub){

    let tablist = document.getElementById("tablist");
    for (let item of tablist.children){
        let a = item.children[0];
        a.classList.remove("active");
    }
    element.classList.add("active");
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
    let unp = document.getElementById("unp");
    let dov = document.getElementById("divDoverennost");
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
            unp.value = data[0][2];
            let login = getCookie('login');
            // dov.innerHTML += "<a href='/documents/" + login + "/" + data[1] + "'>" + data[1] + "</a><br/>";
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
        // dov.innerHTML = "<input type=\"file\" name=\"doverennost\" class=\"form-control-file\" id=\"doverennost\">";
        modal.classList.remove("show");
        modal.style = "display: none";
        for(let i = tablist.children.length - 1; i > 0; i--){
            tablist.children[i].remove();
        }

    });
    $(".btn-danger").on("click",() => {
        // dov.innerHTML = "<input type=\"file\" name=\"doverennost\" class=\"form-control-file\" id=\"doverennost\">";
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

function toggleTabs(chkb,idelement){
    let tab = document.getElementById(idelement);
    if(chkb.checked === true) {
        tab.classList.remove("hiddentab");
    }
    else{
        tab.classList.add("hiddentab");
    }
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
    let tablist = document.getElementById("tablist");
    let tab = document.createElement("li");
    tab.classList.add("nav-item");
    let a = document.createElement("a");
    a.className = "nav-link";
    a.setAttribute("data-toggle", "tab");
    a.setAttribute("href", "#");
    a.setAttribute("role", "tab");
    a.setAttribute("aria-selected", "false");
    tab.setAttribute("onclick", "showTab(this,"+id_sub+")");
    a.innerHTML = "Самооценка " + name;
    tab.appendChild(a);
    tab.id = "tab" + id_sub;
    tablist.appendChild(tab);


    let tabContent = document.getElementsByClassName("tab-content tab-transparent-content")[1];
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
    tab.setAttribute("onclick", "showTab(this,"+id_sub+")");
    a.innerHTML = "Самооценка " + name;
    tab.appendChild(a);
    tab.id = "tab" + id_sub;
    tablist.appendChild(tab);


    let tabContent = document.getElementsByClassName("tab-content tab-transparent-content")[1];
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
            console.log(nameTab + " " + id);
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
    let unp = document.getElementById("unp");
    let naimText = naim.value;
    let unpText = unp.value;
    let id_application = number_app.innerText;
    let modal = document.getElementById("myModal");
    modal.classList.add("show");
    modal.style = "display: block";

    // var doverennost = document.getElementById("doverennost"),
   let xhr = new XMLHttpRequest(),
        form = new FormData();
    // var upload_file = doverennost.files[0];
    // form.append("doverennost", upload_file);
    form.append("naimUZ", naimText);
    form.append("unp", unpText);
    form.append("id_application", id_application);

    xhr.open("post", "saveApplication.php", true);
    xhr.send(form);
    alert("Заявление сохранено");
    location.href = "/index.php?application";

});

function saveTab(id_sub){

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



function createAccordionCards(id_sub) {


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


            divCardHeader.onclick=() =>{
                divCollapse.classList.toggle("show");

                let aa = btnCollapse.getAttribute('aria-expanded');
                if(aa == 'false') {
                    btnCollapse.setAttribute('aria-expanded',true);
                    collapseTable(id_criteria, divCardBody,id_sub);
                } else {
                    btnCollapse.setAttribute('aria-expanded',false)
                }



            }
        }
    }


    divAccordion.appendChild(divCard);
    cardRight.appendChild(divAccordion);

}

function collapseTable(id_criteria, divCardBody,id_sub){
    divCardBody.innerHTML = "";


    $.ajax({
        url: "getMark.php",
        method: "GET",
        data: {id_sub: id_sub, id_criteria: id_criteria}
    })
        .done(function( response ) {
            let marks = JSON.parse(response);

            marks.map((item, index) => {
                let newRow = document.createElement('div');
                newRow.className = 'row';

                if (index ==0) {
                    let newHead1 = document.createElement('div');
                    newHead1.className = 'col';
                    newHead1.innerHTML = 'Критерий';


                    let newHead2 = document.createElement('div');
                    newHead2.className = 'col';
                    newHead2.innerHTML = 'Класс критерия';

                    let newHead3 = document.createElement('div');
                    newHead3.className = 'col';
                    newHead3.innerHTML = 'поле 4';

                    let newHeadRow = document.createElement('div');
                    newHeadRow.className = 'row';

                    newHeadRow.appendChild(newHead1);
                    newHeadRow.appendChild(newHead2);
                    newHeadRow.appendChild(newHead3);



                    divCardBody.appendChild(newHeadRow);
                }

                let newCol1 = document.createElement('div');
                newCol1.className = 'col';
                newCol1.innerHTML = item['mark_name'];
                let newCol2 = document.createElement('div');
                newCol2.className = 'col';
                newCol2.innerHTML = item['mark_class'];
                let newCol3 = document.createElement('div');
                newCol3.className = 'col';
                newCol3.innerHTML = item['id_mark'];

                newRow.appendChild(newCol1);
                newRow.appendChild(newCol2);
                newRow.appendChild(newCol3);

                divCardBody.appendChild(newRow);

            });
        });
}


