function closeJournal() {
    let journalActions = document.getElementById('journalActions');
   
    journalActions.remove();

    
}

let id_application;

function showModalAction(id_app) {
    

    let journalActions = document.getElementById('tableActions');
    journalActions.innerHTML = "Ожидайте. Идет подготовка журнала"
    id_application = id_app;

    let journalHeader = document.getElementById('journalHeader');
    journalHeader.innerHTML = `Журнал событий заявления №${id_application}`;
    prepereTableAction(id_application);

}

function refreshJournal() {
    

    let journalActions = document.getElementById('tableActions');
    journalActions.innerHTML = "Ожидайте. Идет подготовка журнала"
  
    prepereTableAction(id_application);

}

async function prepereTableAction(id_app) {
    
    let journalActions = document.getElementById('tableActions');
    journalActions.innerHTML = "Ожидайте. Идет подготовка журнала"

    let data = new Array();



    await $.ajax({
        url: "/ajax/journal_actions_table.php",
        method: "GET",
        data: {id_app: id_app},

    }).then(function (response) {
        
        console.log()

        for (let i of JSON.parse(response)){
            data.push(i);
        }


        let table = document.createElement('table');
        table.style = " border-spacing: 0; border: none; width:100%";

        let trHead = document.createElement('tr');

        let th1 = document.createElement('th');
        th1.innerHTML = 'Пользователь';
        th1.style = "border: 1px solid black;width: 25%; text-align: center;line-height: normal";
      
        let th2 = document.createElement('th');
        th2.innerHTML = 'Дата';
        th2.style = "border: 1px solid black;width: 10%; text-align: center;line-height: normal";

        let th3 = document.createElement('th');
        th3.innerHTML = 'Время';
        th3.style = "border: 1px solid black;width: 10%; text-align: center;line-height: normal";


        let th4 = document.createElement('th');
        th4.innerHTML = 'Действие';
        th4.style = "border: 1px solid black;width: 55%; text-align: center;line-height: normal";


        trHead.appendChild(th1);
        trHead.appendChild(th2);
        trHead.appendChild(th3);
        trHead.appendChild(th4);
     
         table.appendChild(trHead);
     
         let tbody = document.createElement('tbody');
         table.appendChild(tbody);

           if(data.length > 0){
                data.map((item) => {
                                                            
                    let tr = document.createElement('tr');
                    
                    let td1 = document.createElement('td');
                    td1.innerHTML = item['login'];
                    td1.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:left;line-height: normal; ";
                                    
                    let td2 = document.createElement('td');
                    td2.innerHTML = item['date_action'];
                    td2.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                    let td3 = document.createElement('td');
                    td3.innerHTML = item['time_action'];
                    td3.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                    let td4 = document.createElement('td');
                    td4.innerHTML = item['action'];
                    td4.style = "border-bottom: 1px dashed black; padding: 0.2rem 0.75rem;text-align:center;line-height: normal; ";

                    tr.appendChild(td1);
                    tr.appendChild(td2);
                    tr.appendChild(td3);
                    tr.appendChild(td4);
                    
                    tbody.appendChild(tr);
                })
           }

        journalActions.innerHTML = "";   
        journalActions.appendChild(table); 


    }).fail(function (jqXHR, textStatus, errorThrown) {
        journalActions.innerHTML = "Ошибка. Повторите попытку"
    })
}



