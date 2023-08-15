let day = new Date("2023-10-01");
day.setDate(day.getDate());
day = day.toLocaleDateString().slice(0, 5);
let nowdateli = document.getElementById("nowDateli");
nowdateli.setAttribute("data-duration", day + "-" + day);

function createChart(e) {
    const days = document.querySelectorAll(".chart-values li");
    const tasks = document.querySelectorAll(".chart-bars li");
    const tasks2 = document.querySelectorAll(".chart-barsV li ");
    const daysArray = [...days];
    let widthPrev = 0;
    tasks.forEach((el, index) => {
        const duration = el.dataset.duration.split("-");
        const startDay = duration[0];
        const endDay = duration[1];
        let left = 0,
            width = 0;

        if (tasks[index - 1] !== undefined) {
            if (el.nextElementSibling !== null) {
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
            } else {
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
                if (index === 0) {
                    width = 0;
                    left = left + 25;
                }
            }
            widthPrev = width;
        }

        el.style.left = `${left}px`;
        el.style.width = `${width}px`;

        if (e.type == "load") {
            el.style.backgroundColor = el.dataset.color;
            el.style.opacity = 1;
        }
    });



}
window.addEventListener("load", createChart);
window.addEventListener("resize", createChart);





function collapsTable(id) {
    let myUl = document.getElementById("ul" + id);
    if (myUl.classList.contains("hidden")) {
        myUl.classList.remove("hidden");
        myUl.classList.add("visib");
    } else {
        myUl.classList.remove("visib");
        myUl.classList.add("hidden");
    }


    let parent = document.getElementById(`${id}`);
    let hidden = document.getElementsByClassName(`hidden_${id}`);

    let arrHiden = [...hidden];

    let table = parent.parentElement;

    let arrEl = [...table.getElementsByClassName('question')];

    if (arrEl.length > 0) {
        arrEl.forEach((item) => {
            if ((item.classList.contains('open') && (item.id != id))) {

                item.classList.remove('open');

                let arrHiden2 = [...document.getElementsByClassName(`hidden_${item.id}`)];

                console.log(item);
                if (arrHiden2.length > 0) {
                    arrHiden2.forEach((hidenItem) => {

                        hidenItem.style = 'display:none';
                    });
                }

                document.getElementById("ul" + item.id).classList.remove("visib");
                document.getElementById("ul" + item.id).classList.add("hidden");

            }
        });
    }



    if (parent.classList.contains('open')) {
        parent.classList.remove('open');
        //  hidden.style='display:none';

        if (arrHiden.length > 0) {
            arrHiden.forEach((item) => {
                item.style = 'display:none';
            });
        }

    } else {
        parent.classList.add('open');


        if (arrHiden.length > 0) {
            arrHiden.forEach((item) => {
                item.style = 'display:revert; ';
            });
        }


    }






    let ulhline = document.getElementById("nowDate");
    let hline = ulhline.getElementsByTagName("li")[0];

    let mytask = document.getElementById("mytask");
    hline.style.height = (mytask.offsetHeight + 20).toString() + 'px';





}





//скрипт формируем даты
var startDate = new Date('2023-08-01'); // текущая дата yy mm dd
var endDate = new Date('2023-10-31'); // конечная дата
// startDate.setMonth(startDate.getMonth()-2);
// endDate.setMonth(endDate.getMonth() + 2); // добавляем 2 мес

var currentDate = startDate;
while (currentDate <= endDate) {
    // получаем дату в формате

    var date = currentDate.toLocaleDateString().slice(0, 5);

    //  в список
    var li = document.createElement('li');
    li.textContent = date;
    li.id = date; // добавляем id

    document.querySelector('.chart-values').appendChild(li);

    // увеличиваем тек дату на 1
    currentDate.setDate(currentDate.getDate() + 1);
}



var targetElement = document.getElementById(day);
window.onload = () => {

    console.log(nowdateli.getAttribute("data-duration"));
    // Проверяем, находится ли элемент в видимой области экрана
    if (!targetElement.getBoundingClientRect().top >= 0 && targetElement.getBoundingClientRect().bottom <= window.innerHeight) {
        targetElement.scrollIntoViewIfNeeded({
            block: "center",
            behavior: "smooth"
        });
    }
    console.log(day);
}