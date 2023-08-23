<link rel="stylesheet" href="modules/accred_tasks/tasks_accred.css">
    <div class="content-wrapper">

            <h2 class="text-dark font-weight-bold mb-2"> Задачи </h2>
            <div class="row">
                <div class="col-12 grid-margin">
                    <div class="card">
                        <div class="card-body">

                            <table border="1" style="border-color: #dee2e6; width: 100%">
                                <thead>
                                    <th> Наименование</th>
                                    <th>Статус</th>
                                    <th>Дата подачи</th>
                                    <th>ФИО ответственного</th>
                                    <th>Начало проверки</th>
                                    <th>Завершение проверки</th>
                                    <th>Дата совета</th>
                                    <th>Прогресс</th>
                                    <th></th>
                                </thead>
                                <tbody>


                                <?php
                                $id_user = $_COOKIE['id_user'];
                                $query = "SELECT u1.username as preds,a.*, u.username, s.name_status, a.id_application as app_id
                                                                FROM applications a
                                                                left outer join status s on a.id_status=s.id_status    
                                                                left outer join users u on a.id_user =u.id_user 
                                                                left outer join users u1 on a.id_responsible =u1.id_user 
                                                                

                                                                where a.id_status = 3 or a.id_status = 4";
                                $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);

                                foreach ($data as $app) {
                                    $app_id = $app['app_id'];
                                    $date_accept = $app['date_accept'];
                                    $date_complete = $app['date_complete'];

                                    ?>
                                    <tr class="question" id="<?= $app_id?>" style=" background-color: #a8e9e9; ">
                                        <td onclick="collapsTable(<?= $app_id?>)" style="cursor: pointer;text-align: center" ><?= $app['username']?> №<?= $app_id ?></td>
                                        <td style ="text-align: center"><?= $app['name_status']?></td>
                                        <td><?= $app['date_send']?></td>
                                        <td style ="text-align: center"><?= $app['preds']?></td>
                                        <td id="date_accept_<?= $app_id?>" style ="text-align: center"><?=$app['date_accept']?></td>
                                        <td id="date_complete_<?= $app_id?>" style ="text-align: center"><?=$app['date_complete']?></td>
                                        <td id="date_council_<?= $app_id?>" style ="text-align: center"><?=$app['date_council']?></td>
                                        <td style ="text-align: center">progress</td>
                                        <td style ="text-align: center"><button class="btn btn-success" onclick="showModal('<?= $app_id?>')">Изменить</button></td>
                                    </tr>
                                    <?php
                                    $query1 = "SELECT s.id_subvision, `name`, CONCAT(IFNULL(count_crit_complit.countt,0), '/', IFNULL(count_crit.countt,0)) as progress
                                                FROM subvision s  
                                                left outer join (SELECT count(*) as countt, rc.id_subvision 
                                                FROM `rating_criteria` rc
                                                left outer join subvision s on rc.id_subvision=s.id_subvision
                                                WHERE id_application='$app_id' and rc.status=1
                                                group by rc.id_subvision 
                                                    ) count_crit_complit on s.id_subvision=count_crit_complit.id_subvision
                                                
                                                
                                                left outer join (SELECT count(*) as countt, rc.id_subvision 
                                                FROM `rating_criteria` rc
                                                left outer join subvision s on rc.id_subvision=s.id_subvision
                                                WHERE id_application='$app_id'
                                                group by rc.id_subvision 
                                                    ) count_crit on s.id_subvision=count_crit.id_subvision
                                                    
                                                where id_application = '$app_id'";
                                    $result1=mysqli_query($con, $query1) or die ( mysqli_error($con));
                                    for ($data1 = []; $row = mysqli_fetch_assoc($result1); $data1[] = $row);

                                    foreach ($data1 as $app1) {
                                        $id_subvision = $app1['id_subvision'];
                                    ?>
                                        <tr  class="content1 hidden_<?= $app_id?> fill_sub" style="margin-left:2rem; margin-top: 1rem; background-color: #a2e7d6" >
                                            <td><?= $app1['name']?></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td class = "progr"><?= $app1['progress']?></td>

                                        </tr>


                                        <?php
                                        $query2 = "SELECT id_rating_criteria, c.id_criteria,  CONCAT(c.name, IFNUll(CONCAT(' (', con.conditions,')'),'') ) as name_criteria, status, date_complete, id_otvetstvennogo, u.username
                                                                FROM rating_criteria rc
                                                                left outer join criteria c on rc.id_criteria=c.id_criteria 
                                                                left outer join conditions con on c.conditions_id=con.conditions_id
                                                                left outer join users u on rc.id_otvetstvennogo=u.id_user
                                                                where rc.id_subvision = '$id_subvision'
                                                                order by name_criteria
                                                                ";
                                        $result2=mysqli_query($con, $query2) or die ( mysqli_error($con));
                                        for ($data2 = []; $row = mysqli_fetch_assoc($result2); $data2[] = $row);

                                        foreach ($data2 as $app2) {
                                            $id_otvetstvennogo = $app2['id_otvetstvennogo'];

                                            ?>
                                            <tr  class="content1 hidden_<?= $app_id?>" style="margin-left:2rem; margin-top: 1rem;" >
                                                <td style="max-width: 400px" id="cr<?= $app2['id_criteria']?>"><?= $app2['name_criteria']?></td>
                                                <td><?= $app2['status'] == 1 ? 'готово' : 'не готово' ?> </td>
                                                <td></td>
                                                <td><select onchange="changeOtv(this)" id="rt<?= $app2['id_rating_criteria']?>">
                                                        <?php

                                                        if(isset($id_otvetstvennogo)){?>
                                                             <option id="otv0" value="0">             </option>
                                                             <option selected id="otv<?= $id_otvetstvennogo?>" value="<?=$id_otvetstvennogo?>"><?= $app2['username']?></option>
                                                        <?php } else { ?>
                                                            <option id="otv0" value="0">             </option>
                                                        <?php }

                                                        ?>

                                                    </select></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td><?= $app2['status'] ==1 ? $app2['date_complete'] : '' ?> </td>

                                            </tr>




                                        <?php }?>



                                    <?php }?>
                                    <?php
                                }
                                ?>


                                </tbody>
                            </table>



                    </div>
                </div>

        </div>
        <div class="chart-wrapper" style="width: 100%; overflow: auto" >

            <ul class="chart-values">

            </ul>

            <div style="display: flex; position: relative; z-index: 100; top:-25px">
                <ul class="chart-bars visib"  id = "nowDate" style="margin: 0">
                    <li data-duration="" data-color="red" id = "nowDateli"
                        style="margin: 0; position: absolute; padding: 1px;  width: 0; height: 0px; z-index: 1"></li>
                </ul>
            </div>

            <div id="mytask" style="width: fit-content">
                <?php
                $query = "SELECT a.*, u.username, s.name_status, a.id_application as app_id
                                                                FROM applications a
                                                                left outer join status s on a.id_status=s.id_status    
                                                                left outer join users u on a.id_user =u.id_user 
                                                                where a.id_status = 3 or a.id_status = 4";
                $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);

                foreach ($data as $app) {
                    $app_id = $app['app_id'];
                    $date_accept = $app['date_accept'];
                    $startDate = date('Y-m-d', strtotime("-5 month"));

                    if($date_accept < $startDate ) {
                        $date_accept = $startDate;
                    }

                    if($date_accept==''){$date_accept='';}



                    $date_complete = $app['date_complete'];
                    $endDate = date('Y-m-d', strtotime("5 month"));
                    if($date_complete > $endDate ) {
                        $date_complete = $endDate;
                    }

                    if($date_complete==''){$date_complete='';}
                    $date_council = $app['date_council'];
                    if($date_council==''){$date_council='';}
                    if($date_council > $endDate ) {
                        $date_council = $endDate;
                    }

                ?>
                    <ul class="chart-bars hidden"  id = "ul<?= $app_id?>" >
                        <li  data-duration="<?=substr(date_format(date_create($date_accept), "d.m.Y"), 0, 5) . "-" . substr(date_format(date_create($date_complete), "d.m.Y"), 0, 5)?>" data-color="#4464a1" style="padding: 5px 10px; z-index: 9999 ">Задание заявления №<?= $app_id?></li>
                <?php
                    if(($date_council != null || $date_council != "")&&($date_council != $endDate)){
                ?>
                        <li data-duration="<?=substr(date_format(date_create($date_council), "d.m.Y"), 0, 5) . "-" . substr(date_format(date_create($date_council), "d.m.Y"), 0, 5)?>" data-color="#6a478f" style="padding: 5px 10px; z-index: 9999 "></li>
                        <?php
                    } else {
                        ?>
                        <li data-duration="<?=substr(date_format(date_create($date_complete), "d.m.Y"), 0, 5) . "-" . substr(date_format(date_create($date_complete), "d.m.Y"), 0, 5)?>" data-color="#4464a1" style="padding: 5px 10px; z-index: 9999; "></li>
                   <?php
                    }
                ?>
                    </ul>
                <?php
                }
                ?>



            </div>



        </div>


    </div>
    </div>

<div class="modal" id="modalTask">
    <div class="modal-dialog modal-xs" >
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Изменение задачи №</h4><h4 class="modal-title" id="id_application"></h4>
                <button type="button" class="btn  btn-danger btn-close" data-bs-dismiss="modal">x</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">

                <form>
                    <div class="form-group">
                        <label for="inputDate">Дата начала проверки</label>
                        <input type="date" class="form-control" id="dateAccept">
                    </div>
                </form>
                <form>
                    <div class="form-group">
                        <label for="inputDate" >Дата завершения проверки</label>
                        <input type="date" class="form-control" id="dateComplete">
                    </div>
                </form>
                <form>
                    <div class="form-group">
                        <label for="inputDate" >Дата совета</label>
                        <input type="date" class="form-control" id="dateCouncil">
                    </div>
                </form>

                <form>
                    <div class="form-group">
                        <label for="inputDate" >Председатель</label>
                        <select name="predsedatel" id="predsedatel">

                        </select>
                    </div>
                </form>




            </div>
            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="submit" class="btn btn-success btn-fw" id="btnSave" onclick="saveChanges(this)">Сохранить</button>
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Закрыть</button>
            </div>

        </div>
    </div>
</div>

<script src="modules/accred_tasks/tasks_accred.js"></script>

