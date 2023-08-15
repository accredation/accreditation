<link rel="stylesheet" href="modules/accred_tasks/tasks_accred.css">
    <div class="content-wrapper">

            <h2 class="text-dark font-weight-bold mb-2"> Задачи </h2>
            <div class="row">
                <div class="col-12 grid-margin">
                    <div class="card">
                        <div class="card-body">

                            <table border="1" style="border-color: #dee2e6">
                                <thead>

                                </thead>
                                <tbody>


                                <?php
                                $query = "SELECT a.*, u.username, s.name_status, a.id_application as app_id
                                                                FROM applications a
                                                                left outer join status s on a.id_status=s.id_status    
                                                                left outer join users u on a.id_user =u.id_user 
                                                                

                                                                where a.id_status = 3";
                                $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);

                                foreach ($data as $app) {
                                    $app_id = $app['app_id'];
                                    ?>
                                    <tr class="question" id="<?= $app_id?>" >
                                        <td onclick="collapsTable(<?= $app_id?>)" style="cursor: pointer" ><?= $app['username']?> №<?= $app_id ?></td>
                                        <td><?= $app['name_status']?></td>
                                        <td><?= $app['date_send']?></td>
                                        <td>FIO otvetstennogo</td>
                                        <td>data_work_begin</td>
                                        <td>data_work_end</td>
                                        <td>data_sovet</td>
                                        <td>progress</td>
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
                                        <tr  class="content1 hidden_<?= $app_id?> fill_sub" style="margin-left:2rem; margin-top: 1rem; background-color: lightslategrey" >
                                            <td><?= $app1['name']?></td>
                                            <td></td>
                                            <td></td>
                                            <td>FIO otvetstennogo</td>
                                            <td>data_work_begin</td>
                                            <td>data_work_end</td>
                                            <td></td>
                                            <td><?= $app1['progress']?></td>

                                        </tr>


                                        <?php
                                        $query2 = "SELECT id_rating_criteria,  CONCAT(c.name, IFNUll(CONCAT(' (', con.conditions,')'),'') ) as name_criteria, status, date_complete
                                                                FROM rating_criteria rc
                                                                left outer join criteria c on rc.id_criteria=c.id_criteria 
                                                                left outer join conditions con on c.conditions_id=con.conditions_id
                                                                where rc.id_subvision = '$id_subvision'
                                                                order by name_criteria
                                                                ";
                                        $result2=mysqli_query($con, $query2) or die ( mysqli_error($con));
                                        for ($data2 = []; $row = mysqli_fetch_assoc($result2); $data2[] = $row);

                                        foreach ($data2 as $app2) {

                                            ?>
                                            <tr  class="content1 hidden_<?= $app_id?>" style="margin-left:2rem; margin-top: 1rem;" >
                                                <td style="max-width: 400px"><?= $app2['name_criteria']?></td>
                                                <td><?= $app2['status'] == 1 ? 'готово' : 'не готово' ?> </td>
                                                <td></td>
                                                <td>FIO otvetstennogo</td>
                                                <td>data_work_begin</td>
                                                <td>data_work_end</td>
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
                    <li data-duration="30.08-30.08" data-color="red" id = "nowDateli"
                        style="margin: 0; position: absolute; padding: 1px;  width: 0; height: 0px; z-index: 1"></li>
                </ul>
            </div>

            <div id="mytask" style="width: fit-content">
                <ul class="chart-bars hidden"  id = "ul48" >
                    <li data-duration="02.08-30.08" data-color="#4464a1" style="padding: 5px 10px; z-index: 9999 ">Task11</li>

                </ul>
                <ul class="chart-bars hidden"  id = "ul50">
                    <li data-duration="03.08-05.08" data-color="#4464a1" style="padding: 5px 10px">Task12</li>
                    <li data-duration="06.08-06.08" data-color="#6a478f" style="padding: 5px 10px" ></li>
                </ul>
                <ul class="chart-bars hidden" id = "ul52">
                    <li data-duration="10.08-12.08" data-color="#4464a1" style="padding: 5px 10px">Task13</li>
                    <li data-duration="19.08-19.08" data-color="#6a478f" style="padding: 5px 10px" ></li>
                </ul>


            </div>



        </div>


    </div>
    </div>

<script src="modules/accred_tasks/tasks_accred.js"></script>


