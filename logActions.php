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

    .dataTables_paginate {
        margin-top: 20px;
        text-align: center;
    }

    div.dataTables_wrapper div.dataTables_paginate{
        margin: 50px;
    }

    .dataTables_paginate .paginate_button {
        padding: 10px 15px;
        margin: 0 5px;
        border: 1px solid #007bff;
        border-radius: 5px;
        background-color: #fff;
        color: #007bff;
        transition: background-color 0.3s, color 0.3s;
    }
    .dataTables_paginate .paginate_button:hover {
        background-color: #007bff;
        color: #fff;
    }
    .dataTables_paginate .paginate_button.current {
        background-color: #007bff;
        color: #fff;
        border: 1px solid #007bff;
    }
    .dataTables_paginate .disabled {
        color: #ccc;
        pointer-events: none;
    }
    .form-container {
        max-width: 1000px; /* Увеличен размер контейнера */
        margin: 0 auto;
        background: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
    .form-row {
        display: flex; /* Используем flexbox для расположения полей в строку */
        flex-wrap: wrap; /* Позволяет переносить поля на следующую строку, если не помещаются */
        margin-bottom: 15px;
    }
    .form-group {
        flex: 1; /* Поля занимают равное пространство */
        min-width: 150px; /* Минимальная ширина поля */
        margin-right: 10px; /* Отступ между полями */
    }
    .form-group:last-child {
        margin-right: 0; /* Убираем отступ у последнего поля */
    }
    .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }
    .form-group input {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
        transition: border-color 0.3s;
    }
    .form-group input:focus {
        border-color: #007BFF;
        outline: none;
    }
    .form-group input::placeholder {
        color: #aaa;
    }
</style>

<h1>Логи действий</h1>
<div class="form-container">
    <div class="form-row">
        <div class="form-group">
            <label for="date_create">Дата и время:</label>
            <input type="text" id="date_create" name="date_create" placeholder="Введите дату и время" oninput="filter()">
        </div>
        <div class="form-group">
            <label for="action">Действие:</label>
            <input type="text" id="action" name="action" placeholder="Введите действие" oninput="filter()">
        </div>
        <div class="form-group">
            <label for="ip_adress">IP адрес:</label>
            <input type="text" id="ip_adress" name="ip_adress" placeholder="Введите IP адрес" oninput="filter()">
        </div>
        <div class="form-group">
            <label for="id_user">ID пользователя:</label>
            <input type="text" id="id_user" name="id_user" placeholder="Введите ID пользователя" oninput="filter()">
        </div>
    </div>
    <div class="form-row">
        <div class="form-group">
            <label for="id_application">ID приложения:</label>
            <input type="text" id="id_application" name="id_application" placeholder="Введите ID приложения" oninput="filter()">
        </div>
        <div class="form-group">
            <label for="id_subvision">ID подразделения:</label>
            <input type="text" id="id_subvision" name="id_subvision" placeholder="Введите ID подразделения" oninput="filter()">
        </div>
        <div class="form-group">
            <label for="id_department">ID отдела:</label>
            <input type="text" id="id_department" name="id_department" placeholder="Введите ID отдела" oninput="filter()">
        </div>
        <div class="form-group">
            <label for="id_answer_criteria">ID критерия ответа:</label>
            <input type="text" id="id_answer_criteria" name="id_answer_criteria" placeholder="Введите ID критерия ответа" oninput="filter()">
        </div>
        <div class="form-group">
            <label for="id_crit">ID критерия:</label>
            <input type="text" id="id_crit" name="id_crit" placeholder="Введите ID критерия" oninput="filter()">
        </div>
    </div>
</div>
<table id="logsTable" class="display">
    <thead>
    <tr>
        <th>Дата и время</th>
        <th>Действие</th>
        <th>IP адрес</th>
        <th>ID пользователя</th>
        <th>ID заявления</th>
        <th>Подразделение</th>
        <th>Отделение</th>
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
                            <td>${row.subvision_name}</td>
                            <td>${row.department_name}</td>
                            <td>${row.id_answer_criteria}</td>
                            <td>${row.id_crit}</td>
                        </tr>
                    `;
                    tbody.append(tr);
                });
                $('#logsTable').DataTable();
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
