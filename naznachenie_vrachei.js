
let id_user;

function showModal(id_user){
    this.id_user = id_user;
    let modal = document.getElementById("modalvrachi");
    modal.classList.add("show");
   let mass = new Array();
    $.ajax({
        url:"showCheckedcriteria.php",
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
            url:"saveAllcriteria.php",
            method:"POST",
            data:{id_user: this.id_user,
                id_criteria: criteriaId}

        }).done(function (response){
            console.log('save');
        });
    } else {
        console.log("userId" , this.id_user , "criteriaId" , criteriaId);
        $.ajax({
            url:"deleteAllcriteria.php",
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
            url:"createVrach.php",
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
        let tble = document.getElementById('example');
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
    console.log("usersId" , id_user );
    $.ajax({
        url:"deleteVrach.php",
        method:"POST",
        data:{id_user: id_user}

    }).done(function (response){
        console.log('deletevrach' + response);
        alert("Удален врач-эксперт");
    });


    let ntr = document.getElementById("optname"+id_user);



    let td = document.getElementById("nam"+id_user);
    let ustd = document.getElementById("usnam"+id_user);
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
    nbutton1.setAttribute("onclick" , `saveVrach('${id_user}')`)
    nbutton1.innerHTML = 'Добавить';
    newtd2.appendChild(nbutton1);
    newtr.appendChild(newtd2);
    tbody.appendChild(newtr);
    newtd1.id = "nam"+id_user;


    ntr.remove();


}






