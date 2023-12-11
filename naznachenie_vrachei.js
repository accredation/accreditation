
let id_user;
let id_role;

let table = document.getElementsByTagName("table")[0];
let svoboda = document.querySelectorAll("#svoboda");
let addbtn = document.getElementById("addoctor");
let svyazka = document.querySelectorAll("#svyazka");

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


function getUserId(id_user) {

    $.ajax({
        url: "ajax/getUserId.php",
        method: "POST",
        data: {id_user: id_user},
        success: function(response) {

            id_role = response;
            checkPermissions();
        }
    });
}
function checkPermissions() {
    if (getCookie("predsedatel") !== "1" && getCookie("secretar") !== "1") {
        if (id_role != 12) {
            [...svoboda].forEach(item => {
                item.disabled = true;
            });
            addbtn.disabled = true;

            [...svyazka].forEach(item => {
                item.innerHTML = "Связанные критерии";
                item.disabled = true;
            });

            let checkboxes = document.querySelector("#modalvrachi").querySelectorAll("input[type=checkbox]");
            checkboxes.forEach(item => {
                item.disabled = true;
            });

        }
    }
}
id_user = getCookie("id_user");
getUserId(id_user);


document.getElementById("modalvrachi").addEventListener("show.bs.modal", function() {
    checkPermissions();
});

function showModal(id_user){
    this.id_user = id_user;
    let modal = document.getElementById("modalvrachi");
    modal.classList.add("show");
   let mass = new Array();
    $.ajax({
        url:"ajax/showCheckedcriteria.php",
        method:"POST",
        data:{id_user: this.id_user }

    }).done(function (response){
        let checkedCriteria = JSON.parse(response);
        let allCheckboxes = document.querySelectorAll('input[type="checkbox"]');
        for (let checkbox of allCheckboxes) {
            checkbox.checked = false;
        }
        if (checkedCriteria.length > 0) {
            for (let i of checkedCriteria) {

                let check = document.getElementById("criteri" + i);
                check.checked = true;
                mass.push(i);
            }
        }


        console.log(mass);
    });


    $(".btn-close").on("click",() => {

        modal.classList.remove("show");


    });
    $(".btn-danger").on("click",() => {

        modal.classList.remove("show");

    });
}


// document.querySelectorAll('input[name="crit"]').forEach(function(checkbox) {
//     checkbox.addEventListener('change', function() {
//         if (this.checked) {
//             saveCheckboxCriteria(this.value);
//         } else {
//             deleteCheckboxCriteria(this.value);
//         }
//     });
// });


function addDoctor(){
    let modal = document.getElementById("modalnewvrach");
    modal.classList.add("show");




    $(".btn-close").on("click",() => {

        modal.classList.remove("show");


    });
    $(".btn-danger").on("click",() => {

        modal.classList.remove("show");

    });
}





function saveCheckboxCriteria(el,criteriaId) {
    //var userId = document.getElementById('id_user').innerText;
    if (el.checked) {
        console.log("userId" , this.id_user , "criteriaId" , criteriaId);

        $.ajax({
            url:"ajax/saveAllcriteria.php",
            method:"POST",
            data:{id_user: this.id_user,
                id_criteria: criteriaId}

        }).done(function (response){
            console.log('save');
        });
    } else {
        console.log("userId" , this.id_user , "criteriaId" , criteriaId);
        $.ajax({
            url:"ajax/deleteAllcriteria.php",
            method:"POST",
            data:{id_user: this.id_user,
                id_criteria: criteriaId}
        }).done(function (response){
            console.log('delete');

        });
    }
}




function saveVrach(id_user) {
    //var userId = document.getElementById('id_user').innerText;
        console.log("usersId" , id_user );
        $.ajax({
            url:"ajax/createVrach.php",
            method:"POST",
            data:{id_users: id_user}

        }).done(function (response){

            console.log('savevrach' + response);
            alert("Добавлен врач-эксперт");

        });

        let ntr = document.createElement("tr");
        ntr.id = "optname"+id_user;
        let ntd1 = document.createElement("td");
        let ntd2 = document.createElement("td");
        let ntd3 = document.createElement("td");
        let tble = document.getElementById('example1');
        let tbody = tble.getElementsByTagName("tbody")[0];

        let td = document.getElementById("nam"+id_user);
        ntd1.innerHTML = td.innerText;
        ntd1.id = "usnam" + id_user;
        ntr.appendChild(ntd1);


        let nbutton1 = document.createElement("button");
        ntd2.style = "text-align: center";
        nbutton1.className = "btn btn-success";
        nbutton1.setAttribute("onclick" , `showModal('${id_user}')`)
        nbutton1.innerHTML = 'Связать критерии';
        ntd2.appendChild(nbutton1);
        ntr.appendChild(ntd2);



        let nbutton2 = document.createElement("button");
        ntd3.style = "text-align: center";
        nbutton2.className = "btn btn-success";
        nbutton2.setAttribute("onclick" , `deleteDoctor('${id_user}')`)
        nbutton2.innerHTML = 'Освободить';
        ntd3.appendChild(nbutton2);
        ntr.appendChild(ntd3);
        tbody.appendChild(ntr);

        td.parentElement.remove();



    }


function deleteDoctor(id_user) {
    //var userId = document.getElementById('id_user').innerText;
    let isDelete = confirm("Выбранный врач-эксперт будет освобожден. Освободить?");
    if(isDelete) {
        $.ajax({
            url: "ajax/deleteVrach.php",
            method: "POST",
            data: {id_user: id_user}

        }).done(function (response) {
            console.log('deletevrach' + response);
            alert("Удален врач-эксперт");
        });


        let ntr = document.getElementById("optname" + id_user);


        let td = document.getElementById("nam" + id_user);
        let ustd = document.getElementById("usnam" + id_user);
        let tablenewdoctor = document.getElementById("newdoctor");
        let newtr = document.createElement("tr");
        let newtd1 = document.createElement("td");
        let newtd2 = document.createElement("td");
        let tbody = tablenewdoctor.getElementsByTagName("tbody")[0];
        newtd1.style = "text-align: center";
        newtd1.innerHTML = ustd.innerText;
        newtr.appendChild(newtd1);


        let nbutton1 = document.createElement("button");
        newtd2.style = "text-align: center";
        nbutton1.className = "btn btn-success";
        nbutton1.setAttribute("onclick", `saveVrach('${id_user}')`)
        nbutton1.innerHTML = 'Добавить';
        newtd2.appendChild(nbutton1);
        newtr.appendChild(newtd2);
        tbody.appendChild(newtr);
        newtd1.id = "nam" + id_user;


        ntr.remove();
    }


}

var modals = document.getElementsByClassName("modal");

function attachModalDrag(modal) {
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

    // header.addEventListener("mousedown", startDrag);
}

for (var i = 0; i < modals.length; i++) {
    attachModalDrag(modals[i]);
}






