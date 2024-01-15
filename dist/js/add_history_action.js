function addHistoryAction(id_application, id_user, type_action, action, id_subvision, id_department ) {
    $.ajax({
        url: "ajax/addHistoryAction.php",
        method: "GET",
        data: {id_application: id_application, id_user: id_user, type_action: type_action,action:action, id_subvision:id_subvision, id_department:id_department}
    })
        .done(function (response) {
        
        });    
}