<?php
include "../../ajax/connection.php";


// $query = "SELECT uvp.id_uz_vid_profile, uz.username 
//             FROM accreditation.uz_vid_profile uvp
//             left outer join accreditation.uz uz on uvp.id_uz=uz.id_uz  ";
// $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));


// <ul class="nav nav-tabs tab-transparent" role="tablist">
//     <li class="nav-item">
//     <a class="nav-link active" id="home-tab" data-toggle="tab" href="#allApps" role="tab" aria-selected="true">Самоаккредитация</a>
//     </li>
                
// </ul>

echo '
<div class="col-md-12">
<div class="d-sm-flex justify-content-between align-items-center transaparent-tab-border ">

<div class="d-md-block d-none">
</div>
</div>
<div class="tab-content tab-transparent-content">
<div class="tab-pane fade show active" id="allApps" role="tabpanel" aria-labelledby="home-tab">

    <div class="row">
    <div class="col-12 grid-margin">
        <div class="card">
            <div class="card-body">

            <table id="example" class="table table-striped table-bordered" style="width:100%">
            <thead>
                <tr>
                <th>Заявления</th>
                <th></th>
                <th></th>
                </tr>
            </thead>
            <tbody>        
            ';

    $query = "SELECT uvp.id_uz_vid_profile, uz.username, uvp.id_profile_str, uvp.id_vid_str, uvp.id_uz  
                 FROM accreditation.uz_vid_profile uvp
                 left outer join accreditation.uz uz on uvp.id_uz=uz.id_uz";
    $result = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));


    while ($row = mysqli_fetch_assoc($result)) {
         $id_uz_vid_profile = $row["id_uz_vid_profile"];
         $username = $row["username"];
         $id_vid_str = $row["id_vid_str"];
         $id_profile_str = $row["id_profile_str"];
         $id_uz = $row["id_uz"];
        

        echo '
                 <tr >
                    <td id="uz_name_'.$id_uz.'">'.$username.'</td>
                    <td>
                        <div>
                            <button type="button" class="btn  btn-success "
                            data-toggle="modal" data-target="#modalAddVidProfileOz"
                                    onclick="updateVidProfileOz('.$id_uz_vid_profile.', '.$id_uz.', ['.$id_vid_str.'], ['.$id_profile_str.'])"
                                    >Изменить
                            </button>
                        </div>
                    </td>
                    <td>
                        <div>
                            <button type="button" class="btn  btn-danger"
                                    onclick="deleteVidProfileOz('.$id_uz_vid_profile.', '.$id_uz.')"
                                    >Удалить
                            </button>
                        </div>
                    </td>
                 </tr>  
        ';
    }

    echo '</tbody>

    </table>           

    </div>
</div>
</div>
</div>
</div>

</div>

</div>';

