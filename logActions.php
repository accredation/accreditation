<style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
        padding: 0;
        background-color: #f4f4f4;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
        background-color: #fff;
    }
    th, td {
        padding: 12px;
        border: 1px solid #ddd;
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
    }
    tr:hover {
        background-color: #f1f1f1;
    }
</style>

<h1>Логи действий</h1>
<div>
    <label>Дата и время:</label>
    <input type="text" name="date_create" oninput="filter()">
    <label>Действие:</label>
    <input type="text" name="action" oninput="filter()">
    <label>IP адрес:</label>
    <input type="text" name="ip_adress" oninput="filter()">
    <label>ID пользователя:</label>
    <input type="text" name="id_user" oninput="filter()">
    <label>ID приложения:</label>
    <input type="text" name="id_application" oninput="filter()">
    <label>ID подразделения:</label>
    <input type="text" name="id_subvision" oninput="filter()">
    <label>ID отдела:</label>
    <input type="text" name="id_department" oninput="filter()">
    <label>ID критерия ответа:</label>
    <input type="text" name="id_answer_criteria" oninput="filter()">
    <label>ID критерия:</label>
    <input type="text" name="id_crit" oninput="filter()">
</div>
<table id="logsTable">
    <thead>
    <tr>
        <th>Дата и время</th>
        <th>Действие</th>
        <th>IP адрес</th>
        <th>ID пользователя</th>
        <th>ID приложения</th>
        <th>ID подразделения</th>
        <th>ID отдела</th>
        <th>ID критерия ответа</th>
        <th>ID критерия</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>

<script>
    function filter() {
        const params = {};
        $('input[type="text"]').each(function() {
            if ($(this).val()) {
                params[$(this).attr('name')] = $(this).val();
            }
        });
        $.ajax({
            url: 'ajax/getFromActionsHistory.php',
            type: 'GET',
            data: params,
            dataType: 'json',
            success: function(data) {
                const tbody = $('#logsTable tbody');
                tbody.empty();
                if (data.error) {
                    console.error('Ошибка:', data.error);
                    return;
                }
                data.forEach(row => {
                    const tr = `
                    <tr>
                        <td>${row.date_create}</td>
                        <td>${row.action}</td>
                        <td>${row.ip_adress}</td>
                        <td>${row.id_user}</td>
                        <td>${row.id_application}</td>
                        <td>${row.id_subvision}</td>
                        <td>${row.id_department}</td>
                        <td>${row.id_answer_criteria}</td>
                        <td>${row.id_crit}</td>
                    </tr>
                `;
                    tbody.append(tr);
                });
            },
            error: function(xhr, status, error) {
                console.error('Ошибка:', error);
            }
        });
    }

    $(document).ready(function() {
        filter();
    });
</script>