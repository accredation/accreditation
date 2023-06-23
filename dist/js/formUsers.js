function showModalApps(username){
    document.getElementsByClassName("modal-title")[0].innerHTML = "Заявления пользователя";

    let modal = document.getElementById("myModal");
    let table = document.getElementById("table-apps");
    let tbody = table.getElementsByTagName('tbody')[0];
    modal.classList.add("show");
    modal.style = "display: block";

    $.ajax({
        url: "getUserApplications.php",
        method: "GET",
        data: {username: username}
    })
        .done(function( response ) {
            for (let i of JSON.parse(response)){
                console.log(i);
                let tr = document.createElement("tr");
                tr.setAttribute("onclick", "showModalApp('"+ i +"')");
                let td = document.createElement("td");
                td.innerHTML = i;
                tr.appendChild(td);
                tbody.appendChild(tr);
            }
        });
    // выводим полученный ответ на консоль браузер

    $(".btn-close").on("click",() => {
        tbody.innerHTML = "";
        modal.classList.remove("show");
        modal.style = "display: none";

    });
    $(".btn-danger").on("click",() => {
        tbody.innerHTML = "";
        modal.classList.remove("show");
        modal.style = "display: none";


    });
}

function showModalApp(naim) {
    let modal = document.getElementById("modalApp");
    modal.getElementsByClassName("modal-title")[0].innerHTML = "Изменение заяления";
    let naimEl = modal.querySelector("#naim");
    let dov = modal.querySelector("#divDoverennost");
    naimEl.innerHTML = naim;
    showDoverennost(dov);
    modal.classList.add("show");
    modal.style = "display: block";
    let data = new Array();
    $.ajax({
        url: "getApp.php",
        method: "GET",
        data: {naim: naim}
    })
        .done(function( response ) {
            for (let i of JSON.parse(response)){
                data.push(i);
            }
            naimEl.value = data[1];
            let login = data[0];
            dov.innerHTML += "<a href='/documents/" + login + "/" + data[2] + "'>" + data[2] + "</a><br/>";
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

function showDoverennost(element){
    formDoverennost.classList.remove("hiddentab");
};