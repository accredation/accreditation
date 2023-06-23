let tab1 = document.getElementById("tab-1");
let tab2 = document.getElementById("tab-2");
let tab3 = document.getElementById("tab-3");
let tab4 = document.getElementById("tab-4");
let tab5 = document.getElementById("tab-5");

function showTab1(){
    tab1.classList.add("active");
    tab2.classList.remove("active");
    tab3.classList.remove("active");
    tab4.classList.remove("active");
    tab5.classList.remove("active");
}

function showTab2(){
    tab1.classList.remove("active");
    tab2.classList.add("active");
    tab3.classList.remove("active");
    tab4.classList.remove("active");
    tab5.classList.remove("active");
}

function showTab3(){
    tab1.classList.remove("active");
    tab2.classList.remove("active");
    tab3.classList.add("active");
    tab4.classList.remove("active");
    tab5.classList.remove("active");
}

function showTab4(){
    tab1.classList.remove("active");
    tab2.classList.remove("active");
    tab3.classList.remove("active");
    tab4.classList.add("active");
    tab5.classList.remove("active");
}

function showTab5(){
    tab1.classList.remove("active");
    tab2.classList.remove("active");
    tab3.classList.remove("active");
    tab4.classList.remove("active");
    tab5.classList.add("active");
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
    let dov = document.getElementById("divDoverennost");
    number_app.innerHTML = id_application;
    let modal = document.getElementById("myModal");
    modal.classList.add("show");
    modal.style = "display: block";
    let data = new Array();
    $.ajax({
        url: "getFiles.php",
        method: "GET",
        data: {id_application: id_application}
    })
        .done(function( response ) {
            for (let i of JSON.parse(response)){
                data.push(i);
            }
            naim.value = data[0];
            let login = getCookie('login');
            dov.innerHTML += "<a href='/documents/" + login + "/" + data[1] + "'>" + data[1] + "</a><br/>";
        });
     // выводим полученный ответ на консоль браузер

    $(".btn-close").on("click",() => {
        dov.innerHTML = "<input type=\"file\" name=\"doverennost\" class=\"form-control-file\" id=\"doverennost\">";
        modal.classList.remove("show");
        modal.style = "display: none";

    });
    $(".btn-danger").on("click",() => {
        dov.innerHTML = "<input type=\"file\" name=\"doverennost\" class=\"form-control-file\" id=\"doverennost\">";
        modal.classList.remove("show");
        modal.style = "display: none";


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


