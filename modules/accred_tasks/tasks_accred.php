<style>
    :root {
        --white: #fff;
        --divider: lightgrey;
        --body: #f5f7f8;
    }
    .question{
        padding: 5px 20px;
        border-bottom: 1px solid #d1d1d1;
        max-width: 100%;
        margin-bottom: 10px;
        width: 100%;
        text-align: left;
        font-size: 19px;
        font-weight: 600;
    }
    .content1 {
        text-align: left;
        font-size: 14px;
        font-weight: 300;
        display:none
    }

    .hidden{
        display: none;
    }
    .visib{
        display: flex;
    }

    ul {
        list-style: none;
    }

    a {
        text-decoration: none;
        color: inherit;
    }


    .chart-wrapper {
        max-width: 100%;
        padding: 0 10px;
        margin: 0 auto;
    }


    /* CHART-VALUES
    –––––––––––––––––––––––––––––––––––––––––––––––––– */
    .chart-wrapper .chart-values {
        position: relative;
        display: flex;
        margin-bottom: 20px;
        font-weight: bold;
        font-size: 0.8rem;
    }

    .chart-wrapper .chart-values li {
        flex: 1;
        min-width: 50px;
        text-align: center;
    }


    .chart-wrapper .chart-values li:not(:last-child) {
        position: relative;
    }

    .chart-wrapper .chart-values li:not(:last-child)::before {
        content: '';
        position: absolute;
        right: 0;
        height: 100%;
        border-right: 1px solid var(--divider);
    }


    /* CHART-BARS
    –––––––––––––––––––––––––––––––––––––––––––––––––– */
    .chart-wrapper .chart-bars li {
        position: relative;
        color: var(--white);
        margin-bottom: 15px;
        font-size: 12px;
        border-radius: 20px;
        padding: 5px 20px;
        width: 0;
        opacity: 0;
        transition: all 0.65s linear 0.2s;
    }

    .chart-wrapper .chart-barsV{
        display: flex;

    }

    @media screen and (max-width: 600px) {
        .chart-wrapper .chart-bars li {
            padding: 10px;
        }
    }


    /* FOOTER
    –––––––––––––––––––––––––––––––––––––––––––––––––– */
    .page-footer {
        font-size: 0.85rem;
        padding: 10px;
        text-align: right;
        color: var(--black);
    }

    .page-footer span {
        color: #e31b23;
    }
</style>
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
                                $query = "SELECT a.*, u.username, s.name_status, ram.*, a.id_application as app_id
                                                                FROM applications a
                                                                left outer join status s on a.id_status=s.id_status    
                                                               left outer join report_application_mark ram on a.id_application=ram.id_application
                                                                left outer join users u on a.id_user =u.id_user 
                                                                
                                                                where a.id_status = 3";
                                $result=mysqli_query($con, $query) or die ( mysqli_error($con));
                                for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);

                                foreach ($data as $app) {
                                    ?>
                                    <tr class="question" id="<?= $app['app_id']?>" >
                                        <td onclick="collapsTable(<?= $app['app_id']?>)" style="cursor: pointer" ><?= $app['username']?> №<?= $app['app_id'] ?></td>
                                        <td><?= $app['name_status']?></td>
                                        <td><?= $app['date_send']?></td>
                                        <td>FIO otvetstennogo</td>
                                        <td>data_work_begin</td>
                                        <td>data_work_end</td>
                                        <td>data_sovet</td>
                                        <td>progress</td>
                                    </tr>
                                    <tr id="hidden_<?= $app['app_id']?>"  class="content1" style="margin-left:2rem; margin-top: 1rem;" >
                                        <td>sub</td>
                                        <td>status</td>
                                        <td>date_send</td>
                                        <td>FIO otvetstennogo</td>
                                        <td>data_work_begin</td>
                                        <td>data_work_end</td>
                                        <td>data_sovet</td>
                                        <td>progress</td>
                                    </tr>
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

<!---->
<!--<ul class="chart-bars">-->
<!--    <li data-duration="tue½-wed" data-color="#b03532">Task1</li>-->
<!--    <li data-duration="wed-sat" data-color="#33a8a5">Task2</li>-->
<!--                   <li data-duration="01.08-06.08" data-color="#30997a">Task</li>-->
<!--                   <li data-duration="06.08-06.08" data-color="#4464a1">дата совета</li>-->
<!--    <li data-duration="tue½-thu" data-color="#6a478f">Task3</li>-->
<!--    <li data-duration="mon-tue½" data-color="#da6f2b">Task4</li>-->
<!--    <li data-duration="wed-wed" data-color="#3d8bb1">Task5</li>-->
<!--    <li data-duration="thu-06.08½" data-color="#e03f3f">Task6</li>-->
<!--    <li data-duration="01.08½-wed½" data-color="#59a627">Task7</li>-->
<!--    <li data-duration="06.08-sat" data-color="#4464a1">Task8</li>-->
<!--    <li data-duration="01.08-06.08" data-color="#4464a1">-->
<!--        <span style="background-color: #148a8a">asd</span>-->
<!--        <span style="background-color: #0c84ff">xcvb</span>-->
<!--    </li>-->
<!--    <li data-duration="01.08-01.08" data-color="#4464a1">Task11</li>-->
<!--    <li data-duration="06.08-06.08" data-color="#e03f3f" > Task23</li>-->
<!--</ul>-->


<script>
    let day = new Date("2023-10-01");
    day.setDate(day.getDate());
    day = day.toLocaleDateString().slice(0, 5);
    let nowdateli = document.getElementById("nowDateli");
    nowdateli.setAttribute("data-duration", day+"-"+day);

    function createChart(e) {
        const days = document.querySelectorAll(".chart-values li");
        const tasks = document.querySelectorAll(".chart-bars li");
        const tasks2 = document.querySelectorAll(".chart-barsV li ");
        const daysArray = [...days];
        let widthPrev = 0;
        tasks.forEach((el,index) => {
           // if(index!==0){
                const duration = el.dataset.duration.split("-");
                const startDay = duration[0];
                const endDay = duration[1];
                let left = 0,
                    width = 0;

                if(tasks[index-1] !== undefined) {
                    if(el.nextElementSibling !== null){
                        if (startDay.endsWith("½")) {
                            const filteredArray = daysArray.filter(day => day.textContent == startDay.slice(0, -1));
                            left = filteredArray[0].offsetLeft + filteredArray[0].offsetWidth / 2;
                        } else {
                            const filteredArray = daysArray.filter(day => day.textContent == startDay);
                            left = filteredArray[0].offsetLeft;
                        }

                        if (endDay.endsWith("½")) {
                            const filteredArray = daysArray.filter(day => day.textContent == endDay.slice(0, -1));
                            width = filteredArray[0].offsetLeft + filteredArray[0].offsetWidth / 2 - left - 10;
                        } else {
                            const filteredArray = daysArray.filter(day => day.textContent == endDay);

                                width = filteredArray[0].offsetLeft + filteredArray[0].offsetWidth - left - 30;

                        }
                        widthPrev = width;
                    }
                    else {
                        if (startDay.endsWith("½")) {
                            const filteredArray = daysArray.filter(day => day.textContent == startDay.slice(0, -1));
                            left = filteredArray[0].offsetLeft + filteredArray[0].offsetWidth / 2;
                        } else {
                            const filteredArray = daysArray.filter(day => day.textContent == startDay);
                            left = filteredArray[0].offsetLeft - widthPrev;
                        }

                        if (endDay.endsWith("½")) {
                            const filteredArray = daysArray.filter(day => day.textContent == endDay.slice(0, -1));
                            width = filteredArray[0].offsetLeft + filteredArray[0].offsetWidth / 2 - left - 10;
                        } else {
                            const filteredArray = daysArray.filter(day => day.textContent == endDay);

                            width = filteredArray[0].offsetLeft + filteredArray[0].offsetWidth - left - 30 - widthPrev;

                        }
                    }

                } else {
                    if (startDay.endsWith("½")) {
                        const filteredArray = daysArray.filter(day => day.textContent == startDay.slice(0, -1));
                        left = filteredArray[0].offsetLeft + filteredArray[0].offsetWidth / 2;
                    } else {
                        const filteredArray = daysArray.filter(day => day.textContent == startDay);
                        left = filteredArray[0].offsetLeft;
                    }

                    if (endDay.endsWith("½")) {
                        const filteredArray = daysArray.filter(day => day.textContent == endDay.slice(0, -1));
                        width = filteredArray[0].offsetLeft + filteredArray[0].offsetWidth / 2 - left - 10;
                    } else {
                        const filteredArray = daysArray.filter(day => day.textContent == endDay);
                        width = filteredArray[0].offsetLeft + filteredArray[0].offsetWidth - left - 30;
                        if(index ===0) {
                            width = 0;
                            left = left+ 25;
                        }
                    }
                    widthPrev = width;
                }

                // apply css
                el.style.left = `${left}px`;
                el.style.width = `${width}px`;

                // let dd = document.getElementById('mytask');
                // console.log(dd);
                // if(el.parentElement.id==='nowDate'){
                //     el.style.width = '1px';
                //     el.style.height = dd.style.height;
                //     el.style.padding = '0';
                //
                // }

                if (e.type == "load") {
                    el.style.backgroundColor = el.dataset.color;
                    el.style.opacity = 1;
                }
            // } else {
            //     const duration = el.dataset.duration.split("-");
            //     const startDay = duration[0];
            //     const endDay = duration[1];
            //
            //     const filteredArray1 = daysArray.filter(day => day.textContent == startDay);
            //     let left = filteredArray1[0].offsetLeft;
            //     let  width = 5;
            //
            //     el.style.left = `${left}px`;
            //     el.style.width = `${width}px`;
            //     el.style.height = '100px';
            //
            //     console.log('123');
            // }



        });



    }
    window.addEventListener("load", createChart);
    window.addEventListener("resize", createChart);




    function collaps(el){
        let id_app = el.getAttribute("id_app");

        let myUl = document.getElementById("ul"+id_app);
        if(myUl.classList.contains("hidden")){
            myUl.classList.remove("hidden");
            myUl.classList.add("visib");
        }
        else{
            myUl.classList.remove("visib");
            myUl.classList.add("hidden");
        }

        // if(myUl.style === "display: none;") {
        //
        // }else{
        //     myUl.style = "display: none;";
        // }

      //  el.parent().find('.content1').toggle(200); //скрытие, показ ответа
        if (el.parentElement.parentElement.classList.contains('open')) {
            el.parentElement.parentElement.classList.remove('open');
            let arrEl = [...el.parentElement.parentElement.getElementsByClassName('content1')];
            arrEl.forEach((item)=>item.style='display:none');
        } else {
            el.parentElement.parentElement.classList.add('open');
           //  el.parentElement.style='animation-timing-function: linear; cursor: pointer';
           let arrEl = [...el.parentElement.parentElement.getElementsByClassName('content1')];
            arrEl.forEach((item)=>item.style='display:flex; margin-left:2rem; margin-top: 1rem');
        };


        let ulhline = document.getElementById("nowDate");
        let hline = ulhline.getElementsByTagName("li")[0];

        let mytask = document.getElementById("mytask");
        hline.style.height = (mytask.offsetHeight + 20).toString()+'px';
        //
        // let dateAt = new Date('2023-01-01');
        // let dateTo = new Date('2023-01-04');
        //
        // while(dateAt < dateTo){
        //     console.log(dateAt.toLocaleDateString().slice(0,5));
        //     dateAt.setDate(dateAt.getDate() + 1);
        // }
        //
        //
        // console.log(dateAt.toLocaleDateString());
        // console.log(dateAt.getDay());


    }


    function collapsTable(id){
        let myUl = document.getElementById("ul"+id);
        if(myUl.classList.contains("hidden")){
            myUl.classList.remove("hidden");
            myUl.classList.add("visib");
        }
        else{
            myUl.classList.remove("visib");
            myUl.classList.add("hidden");
        }

       // console.log(el);
       // let parent = el.parentElement;
        let parent = document.getElementById(`${id}`);
        let hidden = document.getElementById(`hidden_${id}`);

        let table = parent.parentElement;

        let arrEl = [...table.getElementsByClassName('question')];
        if(arrEl.length>0){
            arrEl.forEach((item)=> {
                if((item.classList.contains('open') && (item.id != id ) )){
                    item.classList.remove('open');
                    document.getElementById(`hidden_${item.id}`).style='display:none';

                    document.getElementById("ul"+item.id).classList.remove("visib");
                    document.getElementById("ul"+item.id).classList.add("hidden");

                }
            } );
        }

        if(parent.classList.contains('open')){
            parent.classList.remove('open');
            hidden.style='display:none';
        } else {
            parent.classList.add('open');
            hidden.style='display:contents';
        }



//        console.log(hidden);


        // if (el.parentElement.parentElement.classList.contains('open')) {
        //     el.parentElement.parentElement.classList.remove('open');
        //     let arrEl = [...el.parentElement.parentElement.getElementsByClassName('content1')];
        //     arrEl.forEach((item)=>item.style='display:none');
        // } else {
        //     el.parentElement.parentElement.classList.add('open');
        //     //  el.parentElement.style='animation-timing-function: linear; cursor: pointer';
        //     let arrEl = [...el.parentElement.parentElement.getElementsByClassName('content1')];
        //     arrEl.forEach((item)=>item.style='display:flex; margin-left:2rem; margin-top: 1rem');
        // };


        let ulhline = document.getElementById("nowDate");
        let hline = ulhline.getElementsByTagName("li")[0];

        let mytask = document.getElementById("mytask");
        hline.style.height = (mytask.offsetHeight + 20).toString()+'px';

    }



    //
    // $('.question').click(function() {
    //     $(this).find('.content1').toggle(200); //скрытие, показ ответа
    //     if ($(this).hasClass('open')) {
    //         $(this).removeClass('open');
    //     } else {
    //         $(this).addClass('open');
    //     };
    // });
</script>

        <script>
            //скрипт формируем даты
            var startDate = new Date('2023-08-01'); // текущая дата yy mm dd
            var endDate = new Date('2023-10-31'); // конечная дата
            // startDate.setMonth(startDate.getMonth()-2);
            // endDate.setMonth(endDate.getMonth() + 2); // добавляем 2 мес

            var currentDate = startDate;
            while (currentDate <= endDate) {
                // получаем дату в формате

                var date = currentDate.toLocaleDateString().slice(0,5);

                //  в список
                var li = document.createElement('li');
                li.textContent = date;
                li.id = date; // добавляем id

                document.querySelector('.chart-values').appendChild(li);

                // увеличиваем тек дату на 1
                currentDate.setDate(currentDate.getDate() + 1);
            }

        </script>

        <script>

            var targetElement = document.getElementById(day);
            window.onload = () =>{

                console.log(nowdateli.getAttribute("data-duration"));
                // Проверяем, находится ли элемент в видимой области экрана
                if (!targetElement.getBoundingClientRect().top >= 0 && targetElement.getBoundingClientRect().bottom <= window.innerHeight) {
                    targetElement.scrollIntoViewIfNeeded({block: "center", behavior: "smooth"});
                }
                console.log(day);
            }

        </script>