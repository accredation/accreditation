let idRole;
let notificationDropdown = document.getElementById("notificationDropdown");
let accountAction = document.getElementById("accountAction");
let log_out = document.getElementById("log_out");
let loginName = document.getElementById("loginName");
let LogIn;


$(document).ready(function () {
    $('#example').DataTable({
        scrollY: '500px',
        scrollCollapse: true,
        paging: false,
        "aaSorting": []
    });
    $('#table-2').DataTable({
        scrollY: 200,
        scrollX: true,
    });

    $.ajax({
        url: "ajax/getRole.php",
        method: "GET",
        data: {role: idRole}
    }).catch(function (xhr, status, error) {
        console.log("fail")
        idRole = undefined;
    }).then((response) => {
        idRole = response;
        if (idRole !== "" && idRole !== undefined) {

            let countOpenWindow = localStorage.getItem('countOpenWindow');
            let i = 1;
            if (countOpenWindow && countOpenWindow>1) {
                console.log('countOpenWindow+1');
                countOpenWindow = Number(countOpenWindow) + 1;
                localStorage.setItem('countOpenWindow', countOpenWindow);
            } else localStorage.setItem('countOpenWindow', '0');

            setInterval(() => checkAuth(), 1000);
        }
    })
    let loginFromCoockie = getCookie("login");
    if (loginFromCoockie.length == "0") {
        loginName.innerHTML = "Гость";
        notificationDropdown.classList.add("hiddentab");
        log_out.insertAdjacentHTML('afterbegin', ret_ex());
    } else {
        loginName.innerHTML = loginFromCoockie;
        notificationDropdown.classList.remove("hiddentab");
        log_out.insertAdjacentHTML('afterbegin', ret_ent());
        accountAction.insertAdjacentHTML('afterbegin', divMsg());
        if (idRole == "12" || loginFromCoockie == "hancharou@rnpcmt.by") {
            accountAction.insertAdjacentHTML('afterbegin', divUsers());
        }
        getNotifications(); //
        checkNotifications();
    }
});
let mylogin;
let myidUser;
let ageSess;
function checkAuth() {

    let ageSession = getCookie('ageSession');
    if(ageSession == ""){
        document.cookie = "login="+mylogin;
        document.cookie = "id_user="+myidUser;

        $.ajax({
            url: "authorization/outAfterClearCookie.php",
            method: "POST",
            data: {id_user: myidUser}
        }).then(() => {
            alert("Ваша сессия окончена, куки очищены");
            location.href = "/login.php"
        })
    }else{
        document.cookie = "login2="+getCookie("login");
        document.cookie = "id_user2="+getCookie("id_user");
        mylogin = getCookie("login2")
        myidUser = getCookie("id_user2")
    }
    let currentDate = new Date();
    let year = currentDate.getFullYear();
    let month = String(currentDate.getMonth() + 1).padStart(2, '0');
    let day = String(currentDate.getDate()).padStart(2, '0');
    let hours = String(currentDate.getHours()).padStart(2, '0');
    let minutes = String(currentDate.getMinutes()).padStart(2, '0');
    let seconds = String(currentDate.getSeconds()).padStart(2, '0');

    let formattedDate = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;

    let dateAgeSession = new Date(ageSession)
    let dateNow = new Date(formattedDate)

    const diffInMs = dateAgeSession - dateNow;
    const diffInSeconds = Math.floor(diffInMs / 1000);
    const minutes1 = Math.floor(diffInSeconds / 60);
    let seconds1 = diffInSeconds % 60;

    seconds1 = seconds1 < 10 ? "0" + seconds1 : seconds1;

    let timeOut = document.getElementById("timeOut");
    timeOut.innerHTML = `Сессия завершится через ${minutes1}:${seconds1}`;

    if (dateAgeSession <= dateNow) {
        //   console.log('тут надо написать выход из аккаунта');
        $.ajax({
            url: "authorization/check.php",
            method: "GET",
            data: {id: getCookie("id_user")},
            success: () => {
                idRole = undefined;
                alert("Ваша сессия закончена");

                let countOpenWindow = localStorage.getItem('countOpenWindow');
                if (countOpenWindow) {
                    countOpenWindow = countOpenWindow - 1;
                    localStorage.setItem('countOpenWindow', countOpenWindow)
                }


                location.href = "/";
            }
        })
    }

    const url = window.location.search;

    if (url === "?users" || url === "?application") {
        let timeLeftSession = document.getElementById("timeLeftSession");
        timeLeftSession.innerHTML = `Сессия завершится через ${minutes1}:${seconds1}`;
    }

}


function getCookie(cname) {
    let name = cname + "=";
    let decodedCookie = decodeURIComponent(document.cookie);
    let ca = decodedCookie.split(';');
    for (let i = 0; i < ca.length; i++) {
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

function checkNotifications() {
    let symbol = document.getElementById("symb");
    if (symbol.innerHTML === "") {
        symbol.style.display = "none";
    } else {
        symbol.style.display = "block";
    }
}

function getNotifications() {
    let id_user = getCookie('id_user');
    let notif = document.getElementById("notifications");
    let symbol = document.getElementById("symb");
    $.ajax({
        url: "ajax/getNotifications.php",
        method: "GET",
        data: {id_user: id_user}

    })
        .done(function (response) {
            // Очистка уведомлений
            notif.innerHTML = " <h6 class='p-3 mb-0 bg-primary text-white py-4'>Уведомления</h6><div class='dropdown-divider'></div>";

            var notifications = JSON.parse(response);
            console.log(notifications);
            if (notifications.length === 0) {
                symbol.style.display = "none";
                notif.innerHTML += "<p class='text-muted p-3'>Нет уведомлений</p>";
            } else {
                symbol.style.display = "block";
                for (var i = 0; i < notifications.length; i++) {
                    var notification = notifications[i];
                    let idNot = notification['id_notifications'];
                    var html = "<a class='dropdown-item preview-item' onclick='markAsRead(" + idNot + ")'>";
                    html += '<div class="preview-thumbnail">';
                    html += '<div class="preview-icon bg-success">';
                    html += '<i class="mdi mdi-calendar"></i>';
                    html += '</div>';
                    html += '</div>';
                    html += '<div class="preview-item-content d-flex align-items-start flex-column justify-content-center">';
                    html += '<h6 class="preview-subject font-weight-normal mb-1">Новое уведомление</h6>';
                    html += '<p class="text-gray ellipsis mb-0" style="text-wrap: wrap; min-width: 250px">' + notification['text_notifications'] + '</p>';
                    html += '</div>';
                    html += '</a>';
                    html += '<div class="dropdown-divider"></div>';
                    notif.innerHTML += html;
                }
            }
        });
}


// Вызов функции getNotifications при нажатии на колокольчик
notificationDropdown.onclick = function () {
    getNotifications();
};


function markAsRead(notificationId) {

    $.ajax({
        url: "ajax/markNotificationAsRead.php",
        method: "POST",
        data: {notificationId: notificationId}
    })
        .done(function (response) {
            // Обновляем список уведомлений после изменений
            getNotifications();
        });
}

function ret_ent() {
    return '<a class="dropdown-item py-1 d-flex align-items-center justify-content-between" href="/index.php?logout" id="exit"> <span>Выйти</span><i class="mdi mdi-logout ml-1"></i></a>'
}

function ret_ex() {
    return '<a class="dropdown-item py-1 d-flex align-items-center justify-content-between" href="/login.php" id="enter"><span>Войти</span><i class="mdi mdi-lock ml-1"></i></a>'
}

function divMsg() {
    return ' <a class="dropdown-item py-1 d-flex align-items-center justify-content-between" href="/index.php?messages_users"> <i class="fa fa-envelope-open"></i>Мои сообщения </a>'
}

function divUsers() {
    return ' <a class="dropdown-item py-1 d-flex align-items-center justify-content-between" href="support/edit_type_organization.php"><i class="fa fa-user "></i>Пользователи </a>'
}


window.addEventListener("unload", async (event) => {
    let countOpenWindow = localStorage.getItem('countOpenWindow');
    countOpenWindow = countOpenWindow - 1;

    if (countOpenWindow < 1 || !countOpenWindow) {
        await $.ajax({
            url: "authorization/check.php",
            method: "GET",
            data: {id: getCookie("id_user")}
        }).done(function (response) {
            idRole = undefined;
            localStorage.removeItem('countOpenWindow');
            location.href = "/";
        })

    } else localStorage.setItem('countOpenWindow', countOpenWindow);

    // await $.ajax({
    //     url: "authorization/check.php",
    //     method: "GET",
    //     data: {id: getCookie("id_user")}
    // }).done(function(response){
    //     idRole = undefined;
    //     location.href = "/";
    // })

    event.preventDefault();
    //   event.returnValue ='';
})




//
// window.addEventListener("beforeunload", async (event) => {
//
//
//     event.preventDefault();
//
//     await $.ajax({
//         url: "authorization/check.php",
//         method: "GET",
//     }).done(function(response){
//         idRole = undefined;
//         location.href = "/";
//     })
//
//   //  await collapseUpdateOpened(id_open_criteria,openTabId);
//
// });
