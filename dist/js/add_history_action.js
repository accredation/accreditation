function addHistoryAction(id_application, id_user, type_action, action ) {
    $.ajax({
        url: "ajax/addHistoryAction.php",
        method: "GET",
        data: {id_application: id_application, id_user: id_user, type_action: type_action,action:action}
    })
        .done(function (response) {
        
        });    
}