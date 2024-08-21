let idRole;
let notificationDropdown = document.getElementById("notificationDropdown");
let accountAction = document.getElementById("accountAction");
let log_out = document.getElementById("log_out");
let loginName = document.getElementById("loginName");
let LogIn;
let countNots;


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

            // let countOpenWindow = localStorage.getItem('countOpenWindow');
            // let i = 1;
            // if (countOpenWindow && countOpenWindow>1) {
            //     console.log('countOpenWindow+1');
            //     countOpenWindow = Number(countOpenWindow) + 1;
            //     localStorage.setItem('countOpenWindow', countOpenWindow);
            // } else localStorage.setItem('countOpenWindow', '0');

            // checkAuth();
        }
        let loginFromCoockie = getCookie("login");
        if (loginFromCoockie.length == "0") {
            loginName.innerHTML = "Гость";
            notificationDropdown.classList.add("hiddentab");
            log_out.insertAdjacentHTML('afterbegin', ret_ex());
        } else {
            loginName.innerHTML = loginFromCoockie;
            console.log("LOGIN", idRole);
            notificationDropdown.classList.remove("hiddentab");
            log_out.insertAdjacentHTML('afterbegin', ret_ent());
            accountAction.insertAdjacentHTML('afterbegin', divMsg());
            if (idRole == "12" || loginFromCoockie == "hancharou@rnpcmt.by") {
                accountAction.insertAdjacentHTML('afterbegin', divUsers());
            }
            getNotifications(); //
            checkNotifications();
        }
    })

});
let mylogin;
let myidUser;
let ageSess;


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

//localStorage.setItem('countNots', notifications.length);
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
                countNots = notifications.length;
                if (countNots == localStorage.getItem('countNots')) {
                    symbol.style.display = "none";
                    notif.innerHTML += "<p class='text-muted p-3'>Нет уведомлений</p>";
                }
                else {
                    symbol.style.display = "block";
                    for (var i = 0; i < notifications.length; i++) {
                        var notification = notifications[i];
                        let idNot = notification['id_notifications'];
                        var html = "<a class='dropdown-item preview-item' onclick='markAsRead(" + idNot + ", countNots )'>";
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
            }
        });
}


// Вызов функции getNotifications при нажатии на колокольчик
notificationDropdown.onclick = function () {

    getNotifications();
};


function markAsRead(notificationId) {

    localStorage.setItem('countNots', countNots);

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
    // let countOpenWindow = localStorage.getItem('countOpenWindow');
    // countOpenWindow = countOpenWindow - 1;
    //
    // if (countOpenWindow < 1 || !countOpenWindow) {
    //     await $.ajax({
    //         url: "authorization/check.php",
    //         method: "GET",
    //         data: {id: getCookie("id_user")}
    //     }).done(function (response) {
    //         idRole = undefined;
    //         localStorage.removeItem('countOpenWindow');
    //         location.href = "/";
    //     })
    //
    // } else localStorage.setItem('countOpenWindow', countOpenWindow);

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

