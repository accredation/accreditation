
function showModalApps(username){
    document.getElementsByClassName("modal-title")[0].innerHTML = "Заявления пользователя";

    let modal = document.getElementById("myModal");

    let table = document.getElementById("table-apps");
    let tbody = table.getElementsByTagName('tbody')[0];


    $.ajax({
        url: "ajax/getUserApplications.php",
        method: "GET",
        data: {username: username}
    })
        .done(function( response ) {
            for (let i of JSON.parse(response)){
                console.log(i);
                let tr = document.createElement("tr");
                tr.style = "cursor: pointer;";
                tr.setAttribute("onclick", "showModalApp('"+ i +"')");
                let td = document.createElement("td");
                td.innerHTML = i;
                tr.appendChild(td);
                tbody.appendChild(tr);
            }
            modal.classList.add("show");
            modal.style = "display: block";
        });
    // выводим полученный ответ на консоль браузер

    $("div#myModalHeader > button.btn-close").on("click",() => {
        tbody.innerHTML = "";
        modal.classList.remove("show");
        modal.style = "display: none";

    });
    $("div#myModalFooter > button.btn-danger").on("click",() => {
        tbody.innerHTML = "";
        modal.classList.remove("show");
        modal.style = "display: none";


    });
}

function showModalApp(naim) {
    let modal = document.getElementById("modalApp");
    modal.getElementsByClassName("modal-title")[0].innerHTML = "Просмотр заяления";
    let naimEl = modal.querySelector("#naim");
    let unpEl = modal.querySelector("#unp");
    let dov = modal.querySelector("#divDoverennost");
    let data = new Array();
    $.ajax({
        url: "ajax/getApp.php",
        method: "GET",
        data: {naim: naim}
    })
        .done(function (response) {
            for (let i of JSON.parse(response)) {
                data.push(i);
            }

            //  naimEl.innerHTML = naim;


            naimEl.value = data[1];
            unpEl.value = data[3];
            let login = data[0];
            dov.innerHTML += "<a href='/docs/documents/" + login + "/" + data[2] + "'>" + data[2] + "</a><br/>";
            modal.classList.add("show");
            modal.style = "display: block";
            showDoverennost(dov);
        });
    // выводим полученный ответ на консоль браузер

    $("div#modalAppHeader > button.btn-close").on("click", () => {
        dov.innerHTML = "<input type=\"file\" name=\"doverennost\" class=\"form-control-file\" id=\"doverennost\">";
        modal.classList.remove("show");
        modal.style = "display: none";

    });
    $("div#modalAppFooter > button.btn-danger").on("click", () => {
        dov.innerHTML = "<input type=\"file\" name=\"doverennost\" class=\"form-control-file\" id=\"doverennost\">";
        modal.classList.remove("show");
        modal.style = "display: none";


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
        // $.ajax({
        //     url: "print.php",
        //     method: "GET",
        //     data: {naim: naimText, unp: unpText}
        // })
        //     .done(function (response) {
        //
        //         window.print(naim);
        //     });

    });
}


function showDoverennost(element){
    formDoverennost.classList.remove("hiddentab");
};
function deleteDoverennost(element){
    formDoverennost.classList.add("hiddentab");
};