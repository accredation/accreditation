function addHistoryAction(id_application, id_user, type_action, action, id_subvision, id_department ) {
    $.ajax({
        url: "ajax/addHistoryAction.php",
        method: "GET",
        data: {id_application: id_application, id_user: id_user, type_action: type_action,action:action, id_subvision:id_subvision, id_department:id_department}
    })
        .done(function (response) {
        
        });    
}

function addHistoryChangePassword(id_user, newPass, type_action, name_action) {
    let url;
    switch(type_action) {
        case 1:
            url = "../ajax/changeUserPassword.php";
            break;
        case 2:
            url = "ajax/addHistoryChangePassAccred.php";
            break;
    }
    $.ajax({
        url: url,
        method: "POST",
        data: {id_user: id_user, newPass: newPass, name_action: name_action}
    })
        .done(function (response) {
            alert("Пароль изменен");
        });
}
