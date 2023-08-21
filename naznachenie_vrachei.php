<style>
    .rolledUp{
        width: 25px;
        transition: 2s linear;
    }

    .rightCardFS{
        width: 100%;
        transition: 2s linear;
    }

    .rightCard65{
        width: 100%;
        transition: 2s linear;
    }

    .hiddentab{
        display: none;
    }
    .margleft{
        padding-left: 20px;
    }
</style>

<style>

    .container {
        padding: 0rem 0rem;
    }

    .leftSide {
        margin-left: 0;
        margin-right: 0;
    }

    h4 {
        margin: 2rem 0rem 1rem;
    }

    .table-image {
    td, th {
        vertical-align: middle;
    }
    }

</style>

<link rel="stylesheet" href="naznachenie_vrachi.css">
<?php if(isset($_COOKIE['login'])){?>
    <div class="content-wrapper">
        <div class="row" id="proBanner">
            <div class="col-12">
                <!--    -->
            </div>
        </div>
        <div class="d-xl-flex justify-content-between align-items-start">
            <h2 class="text-dark font-weight-bold mb-2"> Назначение врачей-экспертов </h2>
            <div class="d-sm-flex justify-content-xl-between align-items-center mb-2">
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="d-sm-flex justify-content-between align-items-center transaparent-tab-border ">
                    <ul class="nav nav-tabs tab-transparent" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="all-question-tab" data-toggle="tab" href="#allQuestions" role="tab" aria-selected="true">Все врачи</a>
                        </li>
                    </ul>
                    <div class="d-md-block d-none">

                    </div>
                </div>
                <div class="tab-content tab-transparent-content">
                    <div class="tab-pane fade show active" id="allQuestions" role="tabpanel" aria-labelledby="all-question-tab">

                        <div class="row">
                            <div class="col-12 grid-margin">
                                <div class="card">
                                    <div class="card-body">
                                        <button class="btn btn-primary" onclick="addDoctor()">Добавить врача</button>
                                        <?php
                                        $query = "SELECT * FROM users AS us WHERE us.doctor_expert = 1";

                                        $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                        for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
                                        ?>

                                        <table id="vsevrachi" class="table table-striped table-bordered" style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>Пользователь</th>
                                                <th>Критерии</th>
                                                <th>Освободить</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php

                                            foreach ($data as $app) {
                                                ?>

                                                <tr  id = "optname<?= $app['id_user'] ?>"  style="cursor: pointer; height: 100px;">
                                                    <td id = "usnam<?= $app['id_user']; ?>" ><?= $app['username'] ?></td>
                                                    <td style ="text-align: center"><button class="btn btn-success" onclick="showModal('<?= $app['id_user']?>')">Связать критерии</button></td>
                                                    <td  style ="text-align: center"><button class="btn btn-success" onclick="deleteDoctor('<?= $app['id_user']?>')">Освободить</button></td>
                                                </tr>
                                                <?php
                                            }
                                            ?>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>




    <div class="modal" id="modalvrachi">
        <div class="modal-dialog modal-lg" >
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Изменение врача</h4><h4 class="modal-title hiddentab" id="id_user"></h4>
                    <button type="button" class="btn  btn-danger btn-close" data-bs-dismiss="modal">x</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">



                    <?php

                    $query = "SELECT * FROM criteria";
                    $result=mysqli_query($con, $query) or die ( mysqli_error($con));

                    while ($row = mysqli_fetch_assoc($result)) {
                    $id_criteria = $row['id_criteria'];
                    $name_crit = $row['name'];
                    $cond_id = $row['conditions_id'];

                        ?>
                        <div>
                            <input onchange="saveCheckboxCriteria(this,'<?= $id_criteria ?>')" type="checkbox" name="crit" id="criteri<?= $id_criteria ?>"  />
                            <label for="criteri+<?= $id_criteria ?>"> <?= $name_crit ?><?= ($cond_id == 1) ? '(амбулаторная)' : (($cond_id == 2) ? '(стационарная)' : '') ?></label>
                        </div>
                        <?php
                    }
                    ?>





                </div>

                <!-- Modal footer -->
                <div class="modal-footer">

                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Закрыть</button>
                </div>

            </div>
        </div>
    </div>




    <div class="modal" id="modalnewvrach">
    <div class="modal-dialog modal-lg" >
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Добавление врача</h4><h4 class="modal-title hiddentab" id="id_user"></h4>
                <button type="button" class="btn  btn-danger btn-close" data-bs-dismiss="modal">x</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">

                <?php
                $query = "SELECT * FROM users WHERE id_role IN ('2','5','6','7','8','9','10','11') AND (doctor_expert IS NULL OR doctor_expert = '' OR doctor_expert = '0');";
                $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                ?>

                <table id = "newdoctor">
                    <tr>
                        <th>Имя врача</th>
                        <th>Действие</th>
                    </tr>
                    <?php while ($row = mysqli_fetch_assoc($result)) { ?>
                        <tr>
                            <td id = "nam<?= $row['id_user']; ?>" style ="text-align: center"><?php echo $row['username']; ?></td>
                            <td   style ="text-align: center" ><button  class="btn btn-success" onclick="saveVrach('<?= $row['id_user']; ?>')">Добавить</button></td>
                        </tr>
                    <?php } ?>
                </table>

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Закрыть</button>
            </div>

        </div>
    </div>
    </div>





    <script src="/naznachenie_vrachei.js"></script>
<?php }

?>


