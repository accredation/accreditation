let day = new Date();
day.setDate(day.getDate());
day = day.toLocaleDateString().slice(0, 5);
let nowdateli = document.getElementById("nowDateli");
nowdateli.setAttribute("data-duration", day + "-" + day);

let id_app;


let dateAccept = document.getElementById("dateAccept");
let dateComplete = document.getElementById("dateComplete");
let dateCouncil = document.getElementById("dateCouncil");

function showModal(id_app){
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
        console.log(arrPreds);
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
    let dateAc = new Date(dateAccept.value);
    let dateCompl = new Date(dateComplete.value);
    let dateCounc = new Date(dateCouncil.value);
    let id_responsible = selectPreds.options[selectPreds.selectedIndex].id.substring(2);
    let predsName = selectPreds.options[selectPreds.selectedIndex].value;

    console.log('dateAccept.value ', dateAccept.value);

    $.ajax({
        url: "modules/accred_tasks/saveTask.php",
        method: "POST",
        data: {id_application: this.id_app, date_accept: dateAccept.value, date_complete: dateComplete.value, date_council: dateCouncil.value, id_responsible: id_responsible}
    }).done(function (response){
        trId.children[3].innerHTML = predsName;
        trId.children[4].innerHTML = dateAccept.value;
        trId.children[5].innerHTML = dateComplete.value;
        trId.children[6].innerHTML = dateCouncil.value;


        ulId.children[0].setAttribute("data-duration", dateAc.toLocaleDateString().slice(0,5) + "-" + dateCompl.toLocaleDateString().slice(0,5));
        if(dateCouncil.value === "") {
            if(dateCompl === ""){
                dateCompl = new Date();
            }
            ulId.children[1].setAttribute("data-duration", dateCompl.toLocaleDateString().slice(0, 5) + "-" + dateCompl.toLocaleDateString().slice(0, 5));
            ulId.children[1].style.backgroundColor = "#4464a1";
        }else{
            ulId.children[1].setAttribute("data-duration", dateCounc.toLocaleDateString().slice(0, 5) + "-" + dateCounc.toLocaleDateString().slice(0, 5));
            ulId.children[1].style.backgroundColor = "#6a478f";
        }
        btn.addEventListener("mouseout", createChart);

        alert("Задача сохранена");
    });
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
                myUl.classList.remove("hidden");
                myUl.classList.add("visib");
            } else {
                myUl.classList.remove("visib");
                myUl.classList.add("hidden");
            }
        }





    let parent = document.getElementById(`${id}`);
    let hidden = document.getElementsByClassName(`hidden_${id}`);

    let arrHiden = [...hidden];

    let  filteredHidden = arrHiden.filter((item)=> item.classList.contains("fill_sub") === false)


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
                let idCr = hidenTrItem.children[0].id.substring(2);

                let select = hidenTrItem.getElementsByTagName('select')[0];
              //  select.innerHTML ='';

                let filtDoctor = arrOtv.filter((item)=>item['id_criteria'] == idCr);

                if(filtDoctor.length>0){
                    filtDoctor.map(item=>{
                        let newOption = document.createElement('option');
                        newOption.id="otv" + item['id_user'];
                        newOption.value= item['id_user'];
                        newOption.text = item['username'];
                        select.appendChild(newOption);
                    })
                }


            });
        }

    });


    let table = parent.parentElement;

    let arrEl = [...table.getElementsByClassName('question')];

    if (arrEl.length > 0) {
        arrEl.forEach((item) => {
            if ((item.classList.contains('open') && (item.id != id))) {

                item.classList.remove('open');

                let arrHiden2 = [...document.getElementsByClassName(`hidden_${item.id}`)];

                console.log(item);
                if (arrHiden2.length > 0) {
                    arrHiden2.forEach((hidenItem) => {

                        hidenItem.style = 'display:none';
                    });
                }
                if(date_accept!=='' && date_complete!=='') {
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
        let ulhline = document.getElementById("nowDate");
        let hline = ulhline.getElementsByTagName("li")[0];

        let mytask = document.getElementById("mytask");
        hline.style.height = (mytask.offsetHeight + 20).toString() + 'px';
    }
}





//скрипт формируем даты
var startDate = new Date('2023-08-01'); // текущая дата yy mm dd
var endDate = new Date('2023-10-31'); // конечная дата
// startDate.setMonth(startDate.getMonth()-2);
// endDate.setMonth(endDate.getMonth() + 2); // добавляем 2 мес

var currentDate = startDate;
while (currentDate <= endDate) {
    // получаем дату в формате

    var date = currentDate.toLocaleDateString().slice(0, 5);

    //  в список
    var li = document.createElement('li');
    li.textContent = date;
    li.id = date; // добавляем id

    document.querySelector('.chart-values').appendChild(li);

    // увеличиваем тек дату на 1
    currentDate.setDate(currentDate.getDate() + 1);
}



var targetElement = document.getElementById(day);
window.onload = () => {

    console.log(nowdateli.getAttribute("data-duration"));
    // Проверяем, находится ли элемент в видимой области экрана
    if (!targetElement.getBoundingClientRect().top >= 0 && targetElement.getBoundingClientRect().bottom <= window.innerHeight) {
        targetElement.scrollIntoViewIfNeeded({
            block: "center",
            behavior: "smooth"
        });
    }
    console.log(day);
}