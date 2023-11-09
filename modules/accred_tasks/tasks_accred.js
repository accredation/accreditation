let day = new Date();
day.setDate(day.getDate());
day = day.toLocaleDateString().slice(0, 5);
let nowdateli = document.getElementById("nowDateli");
nowdateli.setAttribute("data-duration", day + "-" + day);

let id_app;

let table = document.getElementsByTagName("table")[0];
let btns = table.getElementsByTagName("button");
let slcts = table.getElementsByTagName("select");

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
if(getCookie("predsedatel") !== "1" && getCookie("secretar") !== "1") {

        [...btns].forEach(item => {
            item.disabled = true;
        });

        [...slcts].forEach(item => {
            item.disabled = true;
        });

}

let id_user = getCookie("id_user");
[...slcts].forEach(item => {
    if(item.value == id_user ) {
        let td = item.parentElement.parentElement;
        td.classList.add('trColor');

        // td.classList.add('trGreen');

        let id = td.classList[1].substring(7,td.classList[1].length)
        let mainTd = document.getElementById(id);
        mainTd.classList.add('tdMainColor');
    } else {
    }
});

document.querySelectorAll("td").forEach( item => {
    if (item.innerText === "готово ")
        item.classList.add('trGreen');

});

let dateAccept = document.getElementById("dateAccept");
let dateComplete = document.getElementById("dateComplete");
let dateCouncil = document.getElementById("dateCouncil");

function showModal(id_app){
    let btnSave = document.getElementById("btnSave");
    if (getCookie("predsedatel") !== "1" && getCookie("secretar") !== "1"){
        btnSave.classList.add("hidden");
    }
    this.id_app = id_app;

    let parent = document.getElementById(`${id_app}`);
    if(parent.classList.contains('open')){
        collapsTable(id_app);
    }

    let data = new Array();


    $.ajax({
        url: "modules/accred_tasks/getTask.php",
        method: "GET",
        data: {id_application: id_app}
    }).done(function (response){
        for (let i of JSON.parse(response)){
            data.push(i);
        }
        dateAccept.value = data[0];
        dateComplete.value = data[1];
        dateCouncil.value = data[2];
    });

    let predsedatel = document.getElementById('predsedatel');
    predsedatel.innerHTML = "";
    let arrPreds = new Array();
    $.ajax({
        url: "modules/accred_tasks/getPredsedatel.php",
        method: "GET",
        data: {}
    }).done(function (response){
        for (let i of JSON.parse(response)){

            arrPreds.push(i);
            let newOption = document.createElement('option');
            newOption.id="pr" + i['id_user'];
            newOption.innerHTML = i['username'];
            predsedatel.appendChild(newOption);

        }
        dateAccept.value = data[0];
        dateComplete.value = data[1];
        dateCouncil.value = data[2];
    });
    // let data2 = data.filter((item)=> item.id_criteria===id_criteria)
    // data2.map((item)=>{
    //     // let newOption = document.createElement('option');
    //     // newOption.id=item.user_id;
    //     // newOption.value=item.username;
    //     // predsedatel.appendChild(newOption);
    // })



    let modal = document.getElementById("modalTask");
    let id_application = document.getElementById("id_application");
    modal.classList.add("show");
    id_application.innerHTML = id_app;

    $(".btn-close").on("click",() => {

        modal.classList.remove("show");


    });
    $(".btn-danger").on("click",() => {

        modal.classList.remove("show");

    });
}

function saveChanges(btn){
    let trId = document.getElementById(this.id_app);
    let selectPreds = document.getElementById("predsedatel");
    let ulId = document.getElementById("ul"+this.id_app);
    let dateAc;
    if(dateAccept.value === ''){
        dateAc = '';
    } else {
        dateAc = new Date(dateAccept.value);
    }

    let dateCompl
    if(dateComplete.value === ''){
        dateCompl = '';
    } else {
        dateCompl = new Date(dateComplete.value);
    }

    let dateCounc
    if(dateCouncil.value === ''){
        dateCounc = '';
    } else {
        dateCounc = new Date(dateCouncil.value);
    }

    let id_responsible = selectPreds.options[selectPreds.selectedIndex].id.substring(2);
    let predsName = selectPreds.options[selectPreds.selectedIndex].value;

    if (new Date(dateAccept.value) > new Date(dateComplete.value)) {
        alert("Дата начала проверки не может быть больше даты завершения проверки");
        return;
    }

    if (new Date(dateComplete.value) > new Date(dateCouncil.value)) {
        alert("Дата совета не может быть меньше даты завершения проверки");
        return;
    }


    if ((new Date(dateCouncil.value)) && (dateComplete.value ==='')) {
        alert("Дата завершения проверки не заполнена");
        return;
    }


     // if(dateCouncil.value !== "")
    // if (new Date(dateComplete.value) < new Date(dateCouncil.value)) {
    //     if(dateCouncil.value === "" && dateComplete.value !== "") {
            $.ajax({
                url: "modules/accred_tasks/saveTask.php",
                method: "POST",
                data: {
                    id_application: this.id_app,
                    date_accept: dateAccept.value,
                    date_complete: dateComplete.value,
                    date_council: dateCouncil.value,
                    id_responsible: id_responsible
                }
            }).done(function (response) {
                trId.children[4].innerHTML = predsName;
                trId.children[5].innerHTML = dateAccept.value;
                trId.children[6].innerHTML = dateComplete.value;
                trId.children[7].innerHTML = dateCouncil.value;

                let startDate2 = new Date(); // текущая дата yy mm dd
                let endDate2 = new Date(); // конечная дата
                startDate2.setMonth(startDate2.getMonth() - 5);
                endDate2.setMonth(endDate2.getMonth() + 5);

                let dateAcF = dateAc; //.toLocaleString('ru-RU').slice(0, 10) ;
                let dateComplF = dateCompl;//.toLocaleDateString();
                let dateCouncF = dateCounc;//.toLocaleDateString();

                // console.log('dateStartF2', typeof dateAcF);
                // console.log('dateStartF2', dateAcF);
                //    console.log(new Date(dateAcF.trim())<  new Date(dateStartF.trim()));
                if (dateAcF === '') {
                    dateAcF = day;
                } else {
                    if (dateAcF.toISOString() < startDate2.toISOString()) {
                        dateAcF = startDate2
                    }
                }

                if (dateComplF === '') {
                    dateComplF = day;
                } else {
                    if (dateComplF.toISOString() > endDate2.toISOString()) {
                        dateComplF = endDate2
                    }
                }


                if (dateCouncF === '') {
                    dateCouncF = day;
                } else {
                    if (dateCouncF.toISOString() > endDate2.toISOString()) {
                        dateCouncF = endDate2
                    }
                }

                ulId.children[0].setAttribute("data-duration", dateAcF.toLocaleString('ru-RU').slice(0, 5) + "-" + dateComplF.toLocaleString('ru-RU').slice(0, 5));
                if (dateCouncil.value === "") {
                    if (dateCompl === "") {
                        dateCompl = new Date();
                    }
                    ulId.children[1].setAttribute("data-duration", dateComplF.toLocaleString('ru-RU').slice(0, 5) + "-" + dateComplF.toLocaleString('ru-RU').slice(0, 5));
                    ulId.children[1].style.backgroundColor = "#CE3F31";
                } else {
                    ulId.children[1].setAttribute("data-duration", dateCouncF.toLocaleString('ru-RU').slice(0, 5) + "-" + dateCouncF.toLocaleString('ru-RU').slice(0, 5));
                    ulId.children[1].style.backgroundColor = "#8A231A";
                }
                btn.addEventListener("mouseout", createChart);

                alert("Задача сохранена");

                modal.classList.remove("show");
            });
    //     }
    // }
    // else alert("Дата совета не может быть меньше даты завершения проверки");
}

function createChart(e) {
    const days = document.querySelectorAll(".chart-values li");
    const tasks = document.querySelectorAll(".chart-bars li");
    const tasks2 = document.querySelectorAll(".chart-barsV li ");
    const daysArray = [...days];
    let widthPrev = 0;
    tasks.forEach((el, index) => {
        const duration = el.dataset.duration.split("-");
        const startDay = duration[0];
        const endDay = duration[1];
        let left = 0,
            width = 0;

        if (tasks[index - 1] !== undefined) {
            if (el.nextElementSibling !== null) {
                if (startDay.endsWith("½")) {
                    const filteredArray = daysArray.filter(day => day.textContent == startDay.slice(0, -1));
                    left = filteredArray[0].offsetLeft + filteredArray[0].offsetWidth / 2;
                } else {
                    const filteredArray = daysArray.filter(day => day.textContent == startDay);
                    left = filteredArray[0].offsetLeft;
                }

                if (endDay.endsWith("½")) {
                    const filteredArray = daysArray.filter(day => day.textContent == endDay.slice(0, -1));
                    width = filteredArray[0].offsetLeft + filteredArray[0].offsetWidth / 2 - left - 10;
                } else {
                    const filteredArray = daysArray.filter(day => day.textContent == endDay);

                    width = filteredArray[0].offsetLeft + filteredArray[0].offsetWidth - left - 30;

                }
                widthPrev = width;
            } else {
                if (startDay.endsWith("½")) {
                    const filteredArray = daysArray.filter(day => day.textContent == startDay.slice(0, -1));
                    left = filteredArray[0].offsetLeft + filteredArray[0].offsetWidth / 2;
                } else {
                    const filteredArray = daysArray.filter(day => day.textContent == startDay);
                    left = filteredArray[0].offsetLeft - widthPrev;
                }

                if (endDay.endsWith("½")) {
                    const filteredArray = daysArray.filter(day => day.textContent == endDay.slice(0, -1));
                    width = filteredArray[0].offsetLeft + filteredArray[0].offsetWidth / 2 - left - 10;
                } else {
                    const filteredArray = daysArray.filter(day => day.textContent == endDay);

                    width = filteredArray[0].offsetLeft + filteredArray[0].offsetWidth - left - 30 - widthPrev;

                }
            }

        } else {
            if (startDay.endsWith("½")) {
                const filteredArray = daysArray.filter(day => day.textContent == startDay.slice(0, -1));
                left = filteredArray[0].offsetLeft + filteredArray[0].offsetWidth / 2;
            } else {
                const filteredArray = daysArray.filter(day => day.textContent == startDay);
                left = filteredArray[0].offsetLeft;
            }

            if (endDay.endsWith("½")) {
                const filteredArray = daysArray.filter(day => day.textContent == endDay.slice(0, -1));
                width = filteredArray[0].offsetLeft + filteredArray[0].offsetWidth / 2 - left - 10;
            } else {
                const filteredArray = daysArray.filter(day => day.textContent == endDay);
                width = filteredArray[0].offsetLeft + filteredArray[0].offsetWidth - left - 30;
                if (index === 0) {
                    width = 0;
                    left = left + 25;
                }
            }
            widthPrev = width;
        }

        el.style.left = `${left}px`;
        el.style.width = `${width}px`;

        if (e.type == "load") {
            el.style.backgroundColor = el.dataset.color;
            el.style.opacity = 1;

        }

        let ulZ = el.parentElement;
        let idApp = ulZ.id.substring(2);
        if(Number(idApp)) {

            let tdAc = document.getElementById("date_accept_" + idApp);
            let tdCompl = document.getElementById("date_complete_" + idApp);

            if ((tdCompl.innerText=='' || tdAc.innerText=='')) {
                el.style.opacity = 0;
            } else {
                el.style.opacity = 1;
            }
        }
    });



}
window.addEventListener("load", createChart);
window.addEventListener("resize", createChart);





function collapsTable(id) {
        //console.log(id, date_accept, date_complete);
        let date_accept = document.getElementById('date_accept_'+id);
        let date_complete = document.getElementById('date_complete_'+id);

             // console.log(date_accept.innerText)
        date_accept =  date_accept.innerText;
        date_complete=  date_complete.innerText;

        if(date_accept!=='' && date_complete!==''){



            let myUl = document.getElementById("ul" + id);
            if (myUl.classList.contains("hidden")) {
                // myUl.classList.remove("hidden");
                // myUl.classList.add("visib");
            } else {
                // myUl.classList.remove("visib");
                // myUl.classList.add("hidden");
            }
        }


    let parent = document.getElementById(`${id}`);
    let hidden = document.getElementsByClassName(`hidden_${id}`);

    let arrHiden = [...hidden];

    let  filteredHidden = arrHiden.filter((item) => item.classList.contains("fill_sub") === false)

    if(getCookie("isMA") === "1") {
    let arrOtv = new Array();
    $.ajax({
        url: "modules/accred_tasks/getDoctorExpert.php",
        method: "GET",
        data: {id_application: id}
    }).done(function (response){
        for (let i of JSON.parse(response)){
            arrOtv.push(i);
        }


        if (arrOtv.length > 0) {
            filteredHidden.forEach((hidenTrItem) => {

                let idCr = hidenTrItem.children[1].id.substring(2);

                let select = hidenTrItem.getElementsByTagName('select')[0];
                let selInd = select.value;


                let opt = [...select.options];

                let firstOption = document.createElement('option');
                firstOption.id = "otv" + 0;
                firstOption.value = "0";
                firstOption.text = "";

                let filtDoctor = arrOtv.filter((item) => item['id_criteria'] == idCr);
                let newarr = [...filtDoctor];

                opt.map(optItem=> {
                    newarr = newarr.filter((item) => item['id_user'] != optItem.value);
                })

                if (newarr.length > 0) {
                    newarr.map(item => {
                        let newOption = document.createElement('option');
                        newOption.id = "otv" + item['id_user'];
                        newOption.value = item['id_user'];
                        newOption.text = item['username'];
                        select.appendChild(newOption);
                    })
                }
                select.value = selInd;

            });

        }

    });

    }

    let table = parent.parentElement;

    let arrEl = [...table.getElementsByClassName('question')];

    if (arrEl.length > 0) {
        arrEl.forEach((item) => {
            if ((item.classList.contains('open') && (item.id != id))) {

                item.classList.remove('open');

                let arrHiden2 = [...document.getElementsByClassName(`hidden_${item.id}`)];

                if (arrHiden2.length > 0) {
                    arrHiden2.forEach((hidenItem) => {

                        hidenItem.style = 'display:none';
                    });
                }
                if(date_accept!=='' || date_complete!=='') {
                    document.getElementById("ul" + item.id).classList.remove("visib");
                    document.getElementById("ul" + item.id).classList.add("hidden");
                }

            }
        });
    }



    if (parent.classList.contains('open')) {
        parent.classList.remove('open');
        //  hidden.style='display:none';

        if (arrHiden.length > 0) {
            arrHiden.forEach((item) => {
                item.style = 'display:none';
            });
        }

    } else {
        parent.classList.add('open');


        if (arrHiden.length > 0) {
            arrHiden.forEach((item) => {
                item.style = 'display:revert; ';
            });
        }


    }

    if(date_accept!=='' && date_complete!=='') {

    }
}


let ulhline = document.getElementById("nowDate");
let hline = ulhline.getElementsByTagName("li")[0];

let mytask = document.getElementById("mytask");
let qq1 = document.getElementsByClassName("chart-wrapper")[0];
let clH1 = qq1.clientHeight;
hline.style.height = clH1 + "px";/*(mytask.offsetHeight -90).toString() + 'px';*/


//скрипт формируем даты
var startDate = new Date(); // текущая дата yy mm dd
var endDate = new Date(); // конечная дата
startDate.setMonth(startDate.getMonth() - 5);
endDate.setMonth(endDate.getMonth() + 5);

var currentDate = startDate;
let dayZ = 0;
while (currentDate <= endDate) {
    // получаем дату в формате

    var date = currentDate.toLocaleDateString().slice(0, 5);

    //  в список
    var li = document.createElement('li');
    li.textContent = date;
    li.id = date; // добавляем id
    let li1 = document.createElement("li");
    const options = { weekday: 'long' };
    const dayOfWeek = startDate.toLocaleString('en-US', options);

    if(dayOfWeek === "Saturday" || dayOfWeek === "Sunday"){
        li.style = "background-color: rgb(227 227 227); height: 100%";
        li1.setAttribute("data-duration",date+"-"+date);
        let qq = document.getElementsByClassName("chart-wrapper")[0];
        let clH = qq.clientHeight;
        li1.style = "margin: 0px; position: absolute; padding: 1px; height:"+ clH + "px; z-index: 1; background-color: rgb(227 227 227); opacity: 1; min-width: 50px; border-radius: 0"
        document.querySelector('.chart-bars').appendChild(li1);
    }
    dayZ++;
    document.querySelector('.chart-values').appendChild(li);


    // увеличиваем тек дату на 1
    currentDate.setDate(currentDate.getDate() + 1);
}



var targetElement = document.getElementById(day);
window.onload = () => {


    // Проверяем, находится ли элемент в видимой области экрана
    if (!targetElement.getBoundingClientRect().top >= 0 && targetElement.getBoundingClientRect().bottom <= window.innerHeight) {
        targetElement.scrollIntoViewIfNeeded({
            block: "center",
            behavior: "smooth"
        });
    }
    let apps = document.getElementsByClassName("question");
    let arrIdApps = new Array();
    [...apps].forEach(el => {
        arrIdApps.push(el.id);
    })
    let arrStrProgs = new Array();
    let trsApp;
    let arrsResult = new Array();
    arrIdApps.forEach(id =>{
        trsApp = document.getElementsByClassName(`hidden_${id} fill_sub`);
        let res = 0;
        let lrs = 0;
        let rrs = 0;
        [...trsApp].forEach(el => {

            let strRes = el.getElementsByClassName("progr")[0].innerText;
            arrStrProgs.push(strRes);
            let lr = strRes.split("/");
            lrs += Number(lr[0]);
            rrs += Number(lr[1]);
        })
        res = ( lrs/ rrs) ;
        if(Number(res)){
            document.getElementById(`${id}`).children[8].innerHTML = (res * 100).toFixed(2) +'%' ;
            document.getElementById("ul"+`${id}`).children[0].innerHTML += " Прогресс: " + (res * 100).toFixed(2) +'%';

        } else {
            document.getElementById(`${id}`).children[8].innerHTML = '0' +'%';
        }

    });
}
function changeOtv(el){
    let id = el.id.substring(2);
    let id_userotv = el.options[el.selectedIndex].value;
    $.ajax({
        url:"modules/accred_tasks/update_otvetstveni.php",
        method:"POST",
        data:{id_cr:id, id_userotv:id_userotv}

    }).done(function (response){

    })
}
var modal = document.getElementById("modalTask");

var header = modal.querySelector(".modal-header");
var mouseX = 0;
var mouseY = 0;
var modalLeft = 0;
var modalTop = 0;

function startDrag(event) {

    mouseX = event.clientX;
    mouseY = event.clientY;
    modalLeft = parseInt(window.getComputedStyle(modal).getPropertyValue("left"));
    modalTop = parseInt(window.getComputedStyle(modal).getPropertyValue("top"));


    document.addEventListener("mousemove", dragModal);
    document.addEventListener("mouseup", stopDrag);
}


function dragModal(event) {

    var deltaX = event.clientX - mouseX;
    var deltaY = event.clientY - mouseY;

    modal.style.left = modalLeft + deltaX + "px";
    modal.style.top = modalTop + deltaY + "px";
}

function stopDrag() {
    document.removeEventListener("mousemove", dragModal);
    document.removeEventListener("mouseup", stopDrag);
}

function printReprot() {
    let tableMain = document.getElementById('table');

    let table = tableMain.cloneNode(true)

    let thead = table.getElementsByTagName('thead')[0]
    let trHead = thead.getElementsByTagName('tr')[0]
    let th = trHead.getElementsByTagName('th')[trHead.getElementsByTagName('th').length-1]
    th.setAttribute('hidden', 'true')

    let tbody = table.getElementsByTagName('tbody')[0]
    let trBody = tbody.getElementsByTagName('tr')
    
    for (let item of trBody){
        if(item.classList.contains('question')){
            item.style = 'font-weight: 700';
            let tdq = item.getElementsByTagName('td')[item.getElementsByTagName('td').length-1]
            tdq.setAttribute('hidden', 'true')
        }

        let tdq = item.getElementsByTagName('td')
        for(let tdItem of tdq){
          if(tdItem.getElementsByTagName('select')[1]){
            let div = document.createElement('div');
            div.innerHTML = tdItem.getElementsByTagName('select')[0].textContent;
            let select = tdItem.getElementsByTagName('select')[0];
            select.setAttribute('hidden', 'true');
          }
        }

        if(item.classList.contains('fill_sub')){
            
            item.style = 'font-style: italic;'
           // console.log(style)
        }


    }

 
    var WinPrint = window.open('','','left=50,top=50,width=800,height=640,toolbar=0,scrollbars=1,status=0');

    WinPrint.document.write('<style>@page {\n' +
        'size: A4 landscape;\n' +
        'margin: 1rem;\n' +
        '}</style>');
        

    let divReportTitle = document.createElement('div');
    divReportTitle.innerHTML = 'График работы медицинской аккредитации'
    divReportTitle.style = 'text-align: center; font-size: 18px; margin-bottom: 2rem; font-weight:700'

    WinPrint.document.write(divReportTitle.outerHTML);
    WinPrint.document.write(table.outerHTML);
   
    WinPrint.document.close();
    WinPrint.focus();
    WinPrint.print();
    WinPrint.close();

    
}

function handleColorChange(colorPicker, appId) {
    let ulId = document.getElementById("ul"+this.id_app);
    const selectedColor = colorPicker.value;

    const targetTd = document.querySelector(`.question[id='${appId}'] td:first-child`);
    if (targetTd) {
        targetTd.style.backgroundColor = selectedColor;
    }


    const targetChartBar = document.querySelector(`#ul${appId} li:nth-child(2)[data-duration]`);
    if (targetChartBar) {
        targetChartBar.setAttribute('data-color', selectedColor);
        targetChartBar.style.backgroundColor = selectedColor;
    }

    const xhr = new XMLHttpRequest();
    xhr.open('POST', 'modules/accred_tasks/save_color.php', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.send(`app_id=${appId}&color=${selectedColor}`);
}

window.addEventListener('DOMContentLoaded', () => {


    const xhr = new XMLHttpRequest();

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            const colors = JSON.parse(xhr.responseText);
            colors.forEach((colorData) => {
                const { appId, color } = colorData;

                const targetSelect = document.querySelector(`.question[id='${appId}'] .color-picker`);
                const selectedItem = targetSelect.querySelector(`option[value='${color}']`);

                if (selectedItem) {
                    selectedItem.selected = true;
                }

                const targetChartBar = document.querySelector(`#ul${appId} li:nth-child(2)[data-duration]`);
                if (targetChartBar) {
                    targetChartBar.setAttribute('data-color', color);
                    targetChartBar.style.backgroundColor = color;
                }

                const targetTd = document.querySelector(`.question[id='${appId}'] td:first-child`);
                if (targetTd) {
                    targetTd.style.backgroundColor = color;
                }
            });
        }
    };

    xhr.open('GET', 'modules/accred_tasks/load_colors.php', true);
    xhr.send(null);


});

//header.addEventListener("mousedown", startDrag);