let id_app;
function newShowModal(id_application) {
    let formUcomplect = document.getElementById("formUcomplect");
    formUcomplect.style = "display: none";
    let newDivUcomplect = document.createElement("div");
    let btnTableUcomplect = document.createElement("button");
    let labelUcomplect = document.createElement("p");
    labelUcomplect.innerHTML = "Укомплектованность";
    newDivUcomplect.appendChild(labelUcomplect);
    btnTableUcomplect.innerHTML = "Редактировать";
    newDivUcomplect.appendChild(btnTableUcomplect);
    newDivUcomplect.style = "margin-bottom: 20px";
    let prev = formUcomplect.previousElementSibling;
    prev.insertAdjacentElement("afterend", newDivUcomplect);
    let modalUcomplect = document.getElementById("modalUcomplect");
    let modalBody = modalUcomplect.getElementsByClassName("modal-body")[0];
    btnTableUcomplect.onclick = () => {

        modalUcomplect.style = "display: block";
        $.ajax({
            url: "ajax/z_ucomplectTable.php",
            method: "GET",
            data: {id_application: id_app}
        }).then((response) => {
            modalBody.innerHTML = response;
        })
    }

    let closeXucomplect = document.getElementsByClassName("closeXucomplect")[0];
    closeXucomplect.onclick = () => {
        modalUcomplect.style = "display: none";

    }
    let closeUcomplect = document.getElementsByClassName("closeUcomplect")[0];
    closeUcomplect.onclick = () => {
        modalUcomplect.style = "display: none";

    }


    let btnSend = document.getElementById("btnSend");


    let btnPrint = document.getElementById("btnPrint");
    let btnPrintReport = document.getElementById("btnPrintReport");

    if (btnPrint) {
        btnSend.id = "newBtnSend";
        btnPrint.id = "newBtnPrint";
        btnPrint.title = "Печать самооценки";
    }
    else{
        let btnPrint = document.getElementById("newBtnPrint");
        btnPrint.title = "Печать самооценки";
    }


    if(btnPrintReport) {
        btnPrintReport.id = "btnNewPrintReport";
        btnPrintReport.title = "Печать самооценки";
    }else{
        let btnPrintReport = document.getElementById("btnNewPrintReport");
        btnPrintReport.title = "Печать самооценки";
    }


    let homeTab = document.getElementById("home-tab");
    let btnSen = document.getElementById("newBtnSend");
    let btnSu = document.getElementById("btnSuc");
    if (homeTab.classList.contains("active")) {
        if (btnSen.classList.contains("hiddentab")) {
            btnSen.classList.remove("hiddentab");
        }
        if (btnSu.classList.contains("hiddentab")) {
            btnSu.classList.remove("hiddentab");
        }
    }
    let footer = document.getElementsByClassName("modal-footer")[0];
    if (footer.classList.contains('hiddentab')) {
        footer.classList.remove('hiddentab');
    }

    let apppp = document.getElementsByClassName('accordion');

    if (apppp.length !== 0) {
        for (let i = 0; i < apppp.length; i++) {
            apppp[i].remove();
        }
    }

    let remAccTab = document.getElementsByClassName('remAccTab');

    if (remAccTab.length !== 0) {
        for (let i = 0; i < remAccTab.length; i++) {
            remAccTab[i].remove();
        }
    }


    let remSubMark = document.getElementsByClassName('subMark');
    if (remSubMark.length !== 0) {
        for (let i = 0; i < remSubMark.length; i++) {
            remSubMark[i].remove();
        }
    }
    let tab = document.getElementById("tab1");
    tab.setAttribute("onclick", "newShowTab(this," + 1 + ")");
    let pane = document.getElementById("tab1-");
    if (!tab.children[0].classList.contains("active")) {
        tab.children[0].classList.add("active");
        pane.classList.add("active");
    }
    openTabId = 0;
    let mainRightCard = document.getElementById("mainRightCard");

    let addtab = document.getElementById("addtab");

    let btnSuc = document.getElementById("btnSuc");
    let btnCalc = document.getElementById("btnCalc");


    //  console.log(aButton);


    document.getElementsByClassName("modal-title")[0].innerHTML = "Редактирование заявления № ";

    let number_app = document.getElementById("id_application");
    let naim = document.getElementById("naim");
    naim.setAttribute("readonly", "");
    let sokr = document.getElementById("sokr");
    let unp = document.getElementById("unp");
    let adress = document.getElementById("adress");
    let tel = document.getElementById("tel");
    let email = document.getElementById("email");
    let rukovoditel = document.getElementById("rukovoditel");
    let predstavitel = document.getElementById("predstavitel");
    let soprPismo = document.getElementById("soprPismo");
    let copyRaspisanie = document.getElementById("copyRaspisanie");
    let orgStrukt = document.getElementById("orgStrukt");
    let ucomplect = document.getElementById("ucomplect");
    let techOsn = document.getElementById("techOsn");
    let fileReport = document.getElementById("fileReport");
    let reportSamoocenka = document.getElementById("reportSamoocenka");
    let divFileReportDorabotka = document.getElementById("divFileReportDorabotka");
    let divDateDorabotka = document.getElementById("divDateDorabotka");
    let formFileReportDorabotka = document.getElementById("formFileReportDorabotka");
    let formDateDorabotka = document.getElementById("formDateDorabotka");

    let divSoprPismo = document.getElementById("divSoprovodPismo");
    let divCopyRaspisanie = document.getElementById("divCopyRaspisanie");
    let divOrgStrukt = document.getElementById("divOrgStrukt");
    let divUcomplect = document.getElementById("divUcomplect");
    let divTechOsn = document.getElementById("divTechOsn");
    let divReport = document.getElementById("divReport");
    let divFileReportSamoocenka = document.getElementById("divFileReportSamoocenka");
    number_app.innerHTML = id_application;
    id_app = id_application;
    let modal = document.getElementById("myModal");
    let tablist = document.getElementById("tablist");

    //  naim.value = username;
    if (status == 1 || status == 5) {
        formFileReportDorabotka.style.display = "block";
        formDateDorabotka.style.display = "block";

    } else {

        number_app.setAttribute("readonly", "");
        naim.setAttribute("readonly", "");
        sokr.setAttribute("readonly", "");
        unp.setAttribute("readonly", "");
        adress.setAttribute("readonly", "");
        number_app.setAttribute("readonly", "");
        tel.setAttribute("readonly", "");
        email.setAttribute("readonly", "");
        rukovoditel.setAttribute("readonly", "");
        predstavitel.setAttribute("readonly", "");
        soprPismo.setAttribute("disabled", "true");
        copyRaspisanie.setAttribute("disabled", "true");
        orgStrukt.setAttribute("disabled", "true");
        ucomplect.setAttribute("disabled", "true");
        techOsn.setAttribute("disabled", "true");
        reportSamoocenka.setAttribute("disabled", "true");
        formFileReportDorabotka.setAttribute("disabled", "true");
        formDateDorabotka.setAttribute("disabled", "true");
        formFileReportDorabotka.style.display = "none";
        formDateDorabotka.style.display = "none";
        addtab.classList.add("hiddentab");
        btnSuc.classList.add("hiddentab");
        btnSend.classList.add("hiddentab");
        if (btnCalc) {
            btnCalc.remove();
        }
    }

    let data = new Array();
    $.ajax({
        url: "ajax/getApplication.php",
        method: "GET",
        data: {id_application: id_application}
    })
        .done(function (response) {
            for (let i of JSON.parse(response)) {
                data.push(i);
                data_old.push(i);
            }
            let login = getCookie('login');
            naim.value = data[0][0];
            sokr.value = data[0][1];
            unp.value = data[0][2];
            adress.value = data[0][3];
            tel.value = data[0][4];
            email.value = data[0][5];
            rukovoditel.value = data[0][6];
            predstavitel.value = data[0][7];
            if (data[0][17] != null) {
                divDateDorabotka.insertAdjacentHTML("afterend", "<span>" + data[0][17] + "</span>");
            }
            if (data[0][14] != null) {
                fileReport.insertAdjacentHTML("afterend", "<a href='/docs/documents/" + login + "/" + data[0][14] + "'>" + data[0][14] + "</a>");
            }
            if (data[0][15] != null) {
                reportSamoocenka.insertAdjacentHTML("afterend", "<a href='/docs/documents/" + login + "/" + data[0][15] + "'>" + data[0][15] + "</a>");
            }
            if (data[0][16] != null) {
                divFileReportDorabotka.insertAdjacentHTML("afterend", "<a href='/docs/documents/" + "/dorabotka/" + id_application + "/" + data[0][16] + "'>" + data[0][16] + "</a>");
            }
            if (data[0][8] != null) {
                soprPismo.insertAdjacentHTML("afterend", "<a href='/docs/documents/" + login + "/" + data[0][8] + "'>" + data[0][8] + "</a>");
            }
            if (data[0][9] != null) {
                copyRaspisanie.insertAdjacentHTML("afterend", "<a href='/docs/documents/" + login + "/" + data[0][9] + "'>" + data[0][9] + "</a>");
            }
            if (data[0][10] != null) {
                orgStrukt.insertAdjacentHTML("afterend", "<a href='/docs/documents/" + login + "/" + data[0][10] + "'>" + data[0][10] + "</a>");
            }
            if (data[0][11] != null) {
                ucomplect.insertAdjacentHTML("afterend", "<a href='/docs/documents/" + login + "/" + data[0][11] + "'>" + data[0][11] + "</a>");
            }
            if (data[0][12] != null) {
                techOsn.insertAdjacentHTML("afterend", "<a href='/docs/documents/" + login + "/" + data[0][12] + "'>" + data[0][12] + "</a>");
            }
            modal.classList.add("show");
            modal.style = "display: block";

            for (let obj of data[1]) {

                newGetTabs(obj[1], obj[0]);

            }
            let mark_percent =  data[2];
            let mainRightCard = document.getElementById("mainRightCard");
            mainRightCard.innerHTML = "Количественная самооценка - " + parseFloat(mark_percent).toFixed(2) + "%";

    });
    // выводим полученный ответ на консоль браузер

    $(".closeX").on("click", async () => {
        newDivUcomplect.remove();
        let sopr = divSoprPismo.getElementsByTagName("a")[0];
        let copy = divCopyRaspisanie.getElementsByTagName("a")[0];
        let org = divOrgStrukt.getElementsByTagName("a")[0];
        let ucompl = divUcomplect.getElementsByTagName("a")[0];
        let tech = divTechOsn.getElementsByTagName("a")[0];
        let rep = divReport.getElementsByTagName("a")[0];
        let samoocenka = divFileReportSamoocenka.getElementsByTagName("a")[0];
        let fRD = formFileReportDorabotka.querySelectorAll("a");
        let DD = formDateDorabotka.querySelectorAll("span");

        var collapseElement = document.getElementsByClassName('collapse');

        if ((typeof collapseElement !== 'undefined') && (collapseElement !== null)) {
            let collapseElement2 = [...collapseElement];
            let collapseElement3 = collapseElement2.filter((item) => item.classList.contains("show") === true)
            if (collapseElement3.length > 0) {
                var elementcrit = document.querySelector('.collapse.show[id^="collapse"]');
                if (elementcrit) {
                    var idcrit = elementcrit.id.replace('collapse', '');
                    var id_criteria = parseInt(idcrit);

                    // Найти элемент с классом nav-link active
                    var elementsub = document.querySelector('.nav-link.active[id^="button"]');
                    var idsub = elementsub.id.replace('button', '');
                    var id_sub = parseInt(idsub);


                    await updateCollapse(id_criteria, id_sub, 0).then(() => {
                        if (samoocenka) {
                            samoocenka.remove();
                        }
                        // Удалить все найденные элементы с тегом "a"
                        for (let anchor of fRD) {
                            anchor.remove();
                        }

                        for (let anchor of DD) {
                            anchor.remove();
                        }
                        if (rep) {
                            rep.remove();
                        }
                        if (sopr) {
                            sopr.remove();
                        }
                        if (copy) {
                            copy.remove();
                        }
                        if (org) {
                            org.remove();
                        }
                        if (ucompl) {
                            ucompl.remove();
                        }
                        if (tech) {
                            tech.remove();
                        }
                        modal.classList.remove("show");
                        modal.style = "display: none";
                        for (let i = tablist.children.length - 1; i > 0; i--) {
                            tablist.children[i].remove();
                        }
                        let remAccTab = document.getElementsByClassName('remAccTab');

                        if (remAccTab.length !== 0) {
                            for (let i = 0; i < remAccTab.length; i++) {
                                remAccTab[i].remove();
                            }
                        }

                    });
                }

            } else {
                if (samoocenka) {
                    samoocenka.remove();
                }
                // Удалить все найденные элементы с тегом "a"
                for (let anchor of fRD) {
                    anchor.remove();
                }

                for (let anchor of DD) {
                    anchor.remove();
                }
                if (rep) {
                    rep.remove();
                }
                if (sopr) {
                    sopr.remove();
                }
                if (copy) {
                    copy.remove();
                }
                if (org) {
                    org.remove();
                }
                if (ucompl) {
                    ucompl.remove();
                }
                if (tech) {
                    tech.remove();
                }
                modal.classList.remove("show");
                modal.style = "display: none";
                for (let i = tablist.children.length - 1; i > 0; i--) {
                    tablist.children[i].remove();
                }
                let remAccTab = document.getElementsByClassName('remAccTab');

                if (remAccTab.length !== 0) {
                    for (let i = 0; i < remAccTab.length; i++) {
                        remAccTab[i].remove();
                    }
                }
            }
        } else {
            if (samoocenka) {
                samoocenka.remove();
            }
            // Удалить все найденные элементы с тегом "a"
            for (let anchor of fRD) {
                anchor.remove();
            }

            for (let anchor of DD) {
                anchor.remove();
            }
            if (rep) {
                rep.remove();
            }
            if (sopr) {
                sopr.remove();
            }
            if (copy) {
                copy.remove();
            }
            if (org) {
                org.remove();
            }
            if (ucompl) {
                ucompl.remove();
            }
            if (tech) {
                tech.remove();
            }
            modal.classList.remove("show");
            modal.style = "display: none";
            for (let i = tablist.children.length - 1; i > 0; i--) {
                tablist.children[i].remove();
            }
            let remAccTab = document.getElementsByClassName('remAccTab');

            if (remAccTab.length !== 0) {
                for (let i = 0; i < remAccTab.length; i++) {
                    remAccTab[i].remove();
                }
            }
        }

    });
    $(".closeD").on("click", async () => {
        newDivUcomplect.remove();
        let sopr = divSoprPismo.getElementsByTagName("a")[0];
        let copy = divCopyRaspisanie.getElementsByTagName("a")[0];
        let org = divOrgStrukt.getElementsByTagName("a")[0];
        let ucompl = divUcomplect.getElementsByTagName("a")[0];
        let tech = divTechOsn.getElementsByTagName("a")[0];
        let rep = divReport.getElementsByTagName("a")[0];
        let samoocenka = divFileReportSamoocenka.getElementsByTagName("a")[0];
        let fRD = formFileReportDorabotka.querySelectorAll("a");
        let DD = formDateDorabotka.querySelectorAll("span");


        var collapseElement = document.getElementsByClassName('collapse');

        if ((typeof collapseElement !== 'undefined') && (collapseElement !== null)) {
            let collapseElement2 = [...collapseElement];
            let collapseElement3 = collapseElement2.filter((item) => item.classList.contains("show") === true)
            if (collapseElement3.length > 0) {
                var elementcrit = document.querySelector('.collapse.show[id^="collapse"]');
                if (elementcrit) {
                    var idcrit = elementcrit.id.replace('collapse', '');
                    var id_criteria = parseInt(idcrit);
                    // Найти элемент с классом nav-link active
                    var elementsub = document.querySelector('.nav-link.active[id^="button"]');
                    var idsub = elementsub.id.replace('button', '');
                    var id_sub = parseInt(idsub);

                    await updateCollapse(id_criteria, id_sub, 0).then(() => {
                        if (samoocenka) {
                            samoocenka.remove();
                        }
                        // Удалить все найденные элементы с тегом "a"
                        for (let anchor of fRD) {
                            anchor.remove();
                        }

                        for (let anchor of DD) {
                            anchor.remove();
                        }
                        if (rep) {
                            rep.remove();
                        }
                        if (sopr) {
                            sopr.remove();
                        }
                        if (copy) {
                            copy.remove();
                        }
                        if (org) {
                            org.remove();
                        }
                        if (ucompl) {
                            ucompl.remove();
                        }
                        if (tech) {
                            tech.remove();
                        }
                        modal.classList.remove("show");
                        modal.style = "display: none";
                        for (let i = tablist.children.length - 1; i > 0; i--) {
                            tablist.children[i].remove();
                        }
                        let remAccTab = document.getElementsByClassName('remAccTab');

                        if (remAccTab.length !== 0) {
                            for (let i = 0; i < remAccTab.length; i++) {
                                remAccTab[i].remove();
                            }
                        }

                    });
                }

            } else {
                if (samoocenka) {
                    samoocenka.remove();
                }
                // Удалить все найденные элементы с тегом "a"
                for (let anchor of fRD) {
                    anchor.remove();
                }

                for (let anchor of DD) {
                    anchor.remove();
                }
                if (rep) {
                    rep.remove();
                }
                if (sopr) {
                    sopr.remove();
                }
                if (copy) {
                    copy.remove();
                }
                if (org) {
                    org.remove();
                }
                if (ucompl) {
                    ucompl.remove();
                }
                if (tech) {
                    tech.remove();
                }
                modal.classList.remove("show");
                modal.style = "display: none";
                for (let i = tablist.children.length - 1; i > 0; i--) {
                    tablist.children[i].remove();
                }
                let remAccTab = document.getElementsByClassName('remAccTab');

                if (remAccTab.length !== 0) {
                    for (let i = 0; i < remAccTab.length; i++) {
                        remAccTab[i].remove();
                    }
                }
            }
        } else {
            if (samoocenka) {
                samoocenka.remove();
            }
            // Удалить все найденные элементы с тегом "a"
            for (let anchor of fRD) {
                anchor.remove();
            }

            for (let anchor of DD) {
                anchor.remove();
            }
            if (rep) {
                rep.remove();
            }
            if (sopr) {
                sopr.remove();
            }
            if (copy) {
                copy.remove();
            }
            if (org) {
                org.remove();
            }
            if (ucompl) {
                ucompl.remove();
            }
            if (tech) {
                tech.remove();
            }
            modal.classList.remove("show");
            modal.style = "display: none";
            for (let i = tablist.children.length - 1; i > 0; i--) {
                tablist.children[i].remove();
            }
            let remAccTab = document.getElementsByClassName('remAccTab');

            if (remAccTab.length !== 0) {
                for (let i = 0; i < remAccTab.length; i++) {
                    remAccTab[i].remove();
                }
            }
        }

    });

    let divBtnPrintReport = document.getElementById('btnNewPrintReport');
    divBtnPrintReport.onclick = () => {
        printNewReport();
    };
}

async function newShowTab(element, id_sub) {
    openTabId = id_sub;
    let tablist = document.getElementById("tablist");
    let mainSearch = document.getElementById("tab1");


    for (let item of tablist.children) {
        let a = item.children[0];
        a.removeAttribute("data-toggle");
    }
    element.children[0].setAttribute("data-toggle", "tab");

    let main = document.getElementById('tab1');
    main.children[0].setAttribute("data-toggle", "tab");

    let id = element.id;
    let tabDiv = document.getElementById(id + "-");
    let myModal = document.getElementById("myModal");
    let activeTabDiv = myModal.getElementsByClassName("tab-pane fade show active")[0];
    if (tabDiv && activeTabDiv) {
        activeTabDiv.classList.remove("active");
        tabDiv.classList.add("active");
    }
    let data = new Array();
    let idNum = id.substring(3);
    if (idNum > 1) {
        let row = tabDiv.getElementsByClassName("col-12")[1];
        let formCheckInput = document.getElementsByClassName("form-check-input");
        let formButton = document.getElementsByClassName("form-button");

        row.innerHTML = "";
        $.ajax({
            url: "ajax/newGetListTables.php",
            method: "GET",
            data: {id_sub: id_sub}
        }).done(function (response) {
            let data = JSON.parse(response);
            let idType1Data = data.filter(item => item.id_type === '1');
            let idType2Data = data.filter(item => item.id_type === '2');
            let idType3Data = data.filter(item => item.id_type === '3');
            let idType4Data = data.filter(item => item.id_type === '4');


//первый тип
            let divFormGroup1 = document.createElement("div");
            divFormGroup1.style = "margin-bottom: 10px";
            let label_1 = document.createElement("label");
            label_1.innerHTML = "Первичная медицинская помощь";
            label_1.style.fontWeight = "600";
            label_1.style.textAlign = "left";
            label_1.style.cursor = "pointer";
            let hr1 = document.createElement("hr");
            hr1.style.margin = "0";
            divFormGroup1.appendChild(label_1);
            divFormGroup1.appendChild(hr1);
            divFormGroup1.onclick = () => {
                let group1 = document.getElementsByClassName("group1");
                [...group1].forEach(item => {
                    if (item.classList.contains("hiddentab"))
                        item.classList.remove("hiddentab");
                    else
                        item.classList.add("hiddentab");
                })
            }
            row.appendChild(divFormGroup1);

            for (let i = 0; i < idType1Data.length; i++) {

                let divFormGroup = document.createElement("div");
                divFormGroup.className = "form-group group1 hiddentab";
                let divFormCheck = document.createElement("div");
                divFormCheck.className = "form-check margleft";

                if (idType1Data[i].level === '1') {
                    let inputCheck = document.createElement("input");
                    inputCheck.className = "form-check-input";
                    inputCheck.setAttribute("type", "checkbox");
                    inputCheck.setAttribute("id", "checkbox" + idType1Data[i].id);

                    let labelCheck = document.createElement("label");
                    labelCheck.className = "form-check-label";
                    labelCheck.style.textAlign = "left";
                    // labelCheck.setAttribute("for", "checkbox" + idType1Data[i].id);
                    labelCheck.innerHTML = idType1Data[i].name === undefined ? "" : idType1Data[i].name;
                    inputCheck.onclick = () => {
                        toggleActiveCheckbox(inputCheck, formCheckInput, formButton)
                    };
                    divFormCheck.appendChild(inputCheck);
                    divFormCheck.appendChild(labelCheck);
                } else {
                    let inputCheck = document.createElement("button");
                    inputCheck.className = "form-button";
                    inputCheck.setAttribute("disabled", true);
                    inputCheck.onclick = () => {
                        buttonSelected(inputCheck)
                    };
                    inputCheck.setAttribute("id", "checkbox" + idType1Data[i].id);
                    inputCheck.innerHTML = idType1Data[i].name === undefined ? "" : idType1Data[i].name;
                    divFormCheck.appendChild(inputCheck);
                }

                divFormGroup.appendChild(divFormCheck);
                row.appendChild(divFormGroup);
            }


//второй тип
            let divFormGroup2 = document.createElement("div");
            divFormGroup2.style = "margin-bottom: 10px";
            let label_2 = document.createElement("label");
            label_2.innerHTML = "Специализированная и/или высокотехнологичная медицинская помощь";
            label_2.style.fontWeight = "600";
            label_2.style.textAlign = "left";
            label_2.style.cursor = "pointer";
            let hr2 = document.createElement("hr");
            hr2.style.margin = "0";
            divFormGroup2.appendChild(label_2);
            divFormGroup2.appendChild(hr2);
            divFormGroup2.onclick = () => {
                let group2 = document.getElementsByClassName("group2");
                [...group2].forEach(item => {
                    if (item.classList.contains("hiddentab"))
                        item.classList.remove("hiddentab");
                    else
                        item.classList.add("hiddentab");
                })
            }
            row.appendChild(divFormGroup2);

            for (let i = 0; i < idType2Data.length; i++) {
                let divFormGroup = document.createElement("div");
                divFormGroup.className = "form-group group2 hiddentab";
                let divFormCheck = document.createElement("div");
                divFormCheck.className = "form-check margleft";

                if (idType2Data[i].level === '1') {
                    let inputCheck = document.createElement("input");
                    inputCheck.className = "form-check-input";
                    inputCheck.setAttribute("type", "checkbox");
                    inputCheck.setAttribute("id", "checkbox" + idType2Data[i].id);

                    let labelCheck = document.createElement("label");
                    labelCheck.className = "form-check-label";
                    labelCheck.style.textAlign = "left";
                    // labelCheck.setAttribute("for", "checkbox" + idType2Data[i].id);
                    let condition = idType2Data[i].name === undefined ? "" : idType2Data[i].name;
                    labelCheck.innerHTML = condition;
                    inputCheck.onclick = () => {
                        toggleActiveCheckbox(inputCheck, formCheckInput, formButton)
                    };
                    divFormCheck.appendChild(inputCheck);
                    divFormCheck.appendChild(labelCheck);
                } else {
                    let inputCheck = document.createElement("button");
                    inputCheck.className = "form-button";
                    inputCheck.setAttribute("disabled", true);
                    inputCheck.onclick = () => {
                        buttonSelected(inputCheck)
                    };
                    inputCheck.setAttribute("id", "checkbox" + idType2Data[i].id);
                    inputCheck.innerHTML = idType2Data[i].name === undefined ? "" : idType2Data[i].name;
                    divFormCheck.appendChild(inputCheck);
                }

                divFormGroup.appendChild(divFormCheck);
                row.appendChild(divFormGroup);
            }

//третий тип
            let divFormGroup3 = document.createElement("div");
            divFormGroup3.style = "margin-bottom: 10px";
            let label_3 = document.createElement("label");
            label_3.innerHTML = "Паллиативная медицинская помощь";
            label_3.style.fontWeight = "600";
            label_3.style.textAlign = "left";
            label_3.style.cursor = "pointer";
            let hr3 = document.createElement("hr");
            hr3.style.margin = "0";
            divFormGroup3.appendChild(label_3);
            divFormGroup3.appendChild(hr3);
            divFormGroup3.onclick = () => {
                let group3 = document.getElementsByClassName("group3");
                [...group3].forEach(item => {
                    if (item.classList.contains("hiddentab"))
                        item.classList.remove("hiddentab");
                    else
                        item.classList.add("hiddentab");
                })
            }
            row.appendChild(divFormGroup3);

            for (let i = 0; i < idType3Data.length; i++) {
                let divFormGroup = document.createElement("div");
                divFormGroup.className = "form-group group3 hiddentab";
                let divFormCheck = document.createElement("div");
                divFormCheck.className = "form-check margleft";

                if (idType3Data[i].level === '1') {
                    let inputCheck = document.createElement("input");
                    inputCheck.className = "form-check-input";
                    inputCheck.setAttribute("type", "checkbox");
                    inputCheck.setAttribute("id", "checkbox" + idType3Data[i].id);

                    let labelCheck = document.createElement("label");
                    labelCheck.className = "form-check-label";
                    labelCheck.style.textAlign = "left";
                    let condition = idType3Data[i].name === undefined ? "" : idType3Data[i].name;
                    labelCheck.innerHTML = condition;
                    inputCheck.onclick = () => {
                        toggleActiveCheckbox(inputCheck, formCheckInput, formButton)
                    };
                    divFormCheck.appendChild(inputCheck);
                    divFormCheck.appendChild(labelCheck);
                } else {
                    let inputCheck = document.createElement("button");
                    inputCheck.className = "form-button";
                    inputCheck.setAttribute("disabled", true);
                    inputCheck.onclick = () => {
                        buttonSelected(inputCheck)
                    };
                    inputCheck.setAttribute("id", "checkbox" + idType3Data[i].id);
                    inputCheck.innerHTML = idType3Data[i].name === undefined ? "" : idType3Data[i].name;
                    divFormCheck.appendChild(inputCheck);
                }

                divFormGroup.appendChild(divFormCheck);
                row.appendChild(divFormGroup);
            }


//4ый тип
            let divFormGroup4 = document.createElement("div");
            divFormGroup4.style = "margin-bottom: 10px";
            let label_4 = document.createElement("label");
            label_4.innerHTML = "Медико-социальная помощь";
            label_4.style.fontWeight = "600";
            label_4.style.textAlign = "left";
            label_4.style.cursor = "pointer";
            let hr4 = document.createElement("hr");
            hr4.style.margin = "0";
            divFormGroup4.appendChild(label_4);
            divFormGroup4.appendChild(hr4);

            row.appendChild(divFormGroup4);
            divFormGroup4.onclick = () => {
                let group4 = document.getElementsByClassName("group4");

                [...group4].forEach(item => {
                    if (item.classList.contains("hiddentab"))
                        item.classList.remove("hiddentab");
                    else
                        item.classList.add("hiddentab");
                })
            }
            for (let i = 0; i < idType4Data.length; i++) {
                let divFormGroup = document.createElement("div");
                divFormGroup.className = "form-group group4 hiddentab";
                let divFormCheck = document.createElement("div");
                divFormCheck.className = "form-check margleft";

                if (idType4Data[i].level === '1') {
                    let inputCheck = document.createElement("input");
                    inputCheck.className = "form-check-input";
                    inputCheck.setAttribute("type", "checkbox");
                    inputCheck.setAttribute("id", "checkbox" + idType4Data[i].id);

                    let labelCheck = document.createElement("label");
                    labelCheck.className = "form-check-label";
                    labelCheck.style.textAlign = "left";
                    // labelCheck.setAttribute("for", "checkbox" + idType4Data[i].id);
                    let condition = idType4Data[i].name === undefined ? "" : idType4Data[i].name;
                    labelCheck.innerHTML = condition;
                    inputCheck.onclick = () => {
                        toggleActiveCheckbox(inputCheck, formCheckInput, formButton)
                    };
                    divFormCheck.appendChild(inputCheck);
                    divFormCheck.appendChild(labelCheck);
                } else {
                    let inputCheck = document.createElement("button");
                    inputCheck.className = "form-button";
                    inputCheck.setAttribute("disabled", true);
                    inputCheck.onclick = () => {
                        buttonSelected(inputCheck)
                    };
                    inputCheck.setAttribute("id", "checkbox" + idType4Data[i].id);
                    inputCheck.innerHTML = idType4Data[i].name === undefined ? "" : idType4Data[i].name;
                    divFormCheck.appendChild(inputCheck);
                }

                divFormGroup.appendChild(divFormCheck);
                row.appendChild(divFormGroup);
            }
            createAccordionCards(id_sub);
        }).then(async () => {
            await $.ajax({
                url: "ajax/newGetActiveListTables.php",
                method: "GET",
                data: {id_sub: id_sub}
            }).then(function (response) {
                let activeTables = JSON.parse(response);

                let numTab = document.getElementById("tab" + id_sub + "-")
                activeTables.forEach(item => {

                    let checkB = numTab.querySelector("#checkbox" + item.id_list_tables);

                    if (item.lev === "1") {
                        if (item.coun == 1) {
                            checkB.checked = true;
                            checkB.removeAttribute("disabled");
                            [...formCheckInput].forEach(item1 => {
                                if (item1.checked === false) {
                                    item1.setAttribute("disabled", true);
                                }
                            });
                            [...formButton].forEach(item2 => {
                                item2.removeAttribute("disabled");
                            })
                        }
                    } else {
                        let coun = item.coun == null ? 0 : item.coun;
                        checkB.innerHTML += ": " + coun;
                    }
                })
            }).fail(function (jqXHR, textStatus, errorThrown) {
                alert("Некоторые элементы не были дозагружены, Дождитесь загрузки, либо обновите страницу");
            })
        }).fail(function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus + ": " + errorThrown);
        }).then(()=>{
            $.ajax({
                url: "ajax/z_getAllTables.php",
                method: "GET",
                data: { id_sub: openTabId }
            }).then(function(response) {

                let numTab = document.querySelector("#tab" + openTabId + "-");
                let rightCard = numTab.querySelector("#cardRight");
                let cardForAdding = rightCard.querySelector(":first-child");
                let cardForAdding1 = cardForAdding.querySelector(":first-child");
                if(cardForAdding1)
                    cardForAdding1.insertAdjacentHTML("afterbegin",response);





            }).fail(function(jqXHR, textStatus, errorThrown) {
                //
                console.log("AJAX Error: " + textStatus + ", " + errorThrown);
            });
        }).then(() =>{
                $.ajax({
                    url: "ajax/z_calc_subvision.php",
                    method: "GET",
                    data: { id_sub: openTabId, id_application: id_app }
                }).then((response) => {
                    let thisTab = document.getElementById("tab"+openTabId+"-");
                    let divMark = document.createElement("div");
                    divMark.id = "markSub";
                    let markSub = document.getElementById("markSub");
                    if(markSub){
                        markSub.remove();
                    }
                    divMark.style = "text-align: right;";

                    divMark.innerHTML = "Количественная самооценка - " + parseFloat(response).toFixed(2) + "%";
                    thisTab.appendChild(divMark);
            })
        })
    }

    if(idNum == "1"){

            $.ajax({
                url: "ajax/z_calc_application.php",
                method: "GET",
                data: {id_application: id_app}
            }).then((response) => {
                let mainRightCard = document.getElementById("mainRightCard");
                mainRightCard.innerHTML = "Количественная самооценка - " + parseFloat(response).toFixed(2) + "%";
            })


    }

}

function newGetTabs(name, id_sub) {   // создание subvision и cardBody

    let tablist = document.getElementById("tablist");
    let tab = document.createElement("li");
    tab.classList.add("nav-item");
    let a = document.createElement("button");
    a.className = "nav-link";
    a.id = 'button' + id_sub;
    a.setAttribute("data-toggle", "tab");
    a.setAttribute("href", "#");
    a.setAttribute("role", "tab");
    a.setAttribute("aria-selected", "false");

    tab.setAttribute("onclick", "newShowTab(this," + id_sub + ")");

    a.innerHTML = "" + name;
    tab.appendChild(a);

    tab.id = "tab" + id_sub;
    tablist.appendChild(tab);


    let tabContent = document.getElementsByClassName("tab-content tab-transparent-content")[5];
    let tabPane = document.createElement("div");
    tabPane.className = "tab-pane fade show remAccTab";
    tabPane.id = "tab" + id_sub + "-";
    let row1 = document.createElement("div");
    row1.className = "row";
    let col12_1 = document.createElement("div");
    col12_1.className = "col-12 grid-margin";
    let cardLeft = document.createElement("div");
    cardLeft.className = "card";
    if(idRole === "15"){
        cardLeft.classList.add("hiddentab");
    }

    let divRollUp = document.createElement("div");
    divRollUp.className = "d-md-block d-none";
    divRollUp.style = "text-align: end;margin-top: 5px;";
    let aRollUp = document.createElement("a");
    aRollUp.href = "#";
    aRollUp.className = "text-light p-1";
    aRollUp.id = "rollUp";
    let iconRollUp = document.createElement("i");
    iconRollUp.className = "mdi mdi-view-dashboard";

    aRollUp.appendChild(iconRollUp);


    divRollUp.appendChild(aRollUp);
    cardLeft.appendChild(divRollUp);

    aRollUp.onclick = () => {
        cardLeft.classList.toggle("rolledUp");
        cardLeft.getElementsByClassName("card-body")[0].classList.toggle("hiddentab");
        cardRight.classList.toggle("rightCardFS");
    }

    let cardBody = document.createElement("div");
    cardBody.className = "card-body";
    let container = document.createElement("div");
    container.className = "container leftSide";
    let row2 = document.createElement("div");
    row2.className = "row";
    let col12_2 = document.createElement("div");
    col12_2.className = "col-12";

    let btnDelete = document.createElement("button");
    btnDelete.innerHTML = "Удалить подразделение";
    btnDelete.setAttribute("onclick", "deleteTab('" + id_sub + "')");
    btnDelete.style = "margin-bottom: 15px";
    tabPane.appendChild(btnDelete);


    col12_1.style = "display: flex";

    let cardRight = document.createElement("div");
    cardRight.className = "card rightCard65";
    cardRight.id = "cardRight";
    cardRight.style = "margin-left: 15px;";
    cardRight.innerHTML = "подзразделения";

    row2.appendChild(col12_2);
    container.appendChild(row2);
    cardBody.appendChild(container);
    cardLeft.appendChild(cardBody);
    col12_1.appendChild(cardLeft);
    col12_1.appendChild(cardRight);
    row1.appendChild(col12_1);
    tabPane.appendChild(row1);


    let btnSave = document.createElement("button");
    btnSave.innerHTML = "Сохранить выбранные пункты";
    btnSave.className = "btn btn-outline-primary";
    btnSave.id = "btnSaveInfoCriteriaMain";
    btnSave.setAttribute("onclick", "saveTab('" + id_sub + "')");
    tabPane.appendChild(btnSave);
    if (status == 1) {

    } else {
        cardLeft.classList.add("rolledUp");
        aRollUp.setAttribute("disabled", "true");
        btnDelete.classList.add("hiddentab");
        container.classList.add("hiddentab");
        btnSave.classList.add("hiddentab");
    }
    tabContent.appendChild(tabPane);
}

function newAddTab() {    // добавление subvision
    let nameTab = prompt("Введите название структурного подразделения");


    if (nameTab !== null) {
        if (nameTab.trim() !== '') {

            let number_app = document.getElementById("id_application");
            let id_application = number_app.innerHTML;
            $.ajax({
                url: "ajax/addSubvision.php",
                method: "POST",
                data: {id_application: id_application, name: nameTab}
            })
                .done(function (response) {
                    let id = response;

                    newGetTabs(nameTab, id);
                });
        } else {
            alert('Введите название подразделения');
        }


    }


}

function toggleActiveCheckbox(inputCheck, formCheckInput, formButton) {   // добавление таблицы по чекбоксу

    let check = inputCheck.checked === true ? 1 : 0;
    let str = inputCheck.id;
    let id_list_tables_criteria = str.replace(/\D/g, ''); // Удаление всех символов, кроме цифр


    if (check == 1) {
        [...formCheckInput].forEach(item => {
            if (item.checked === false) {
                item.setAttribute("disabled", true);
            }
        });
        [...formButton].forEach(item => {
            item.removeAttribute("disabled");
        })

        $.ajax({
            url: "ajax/saveListTablesCheckbox.php",
            method: "GET",
            data: {id_sub: openTabId, id_list_tables_criteria: id_list_tables_criteria, check: check}
        })
            .done(function (response) {
                // ОТОБРАЖЕНИЕ таблиц критериев по нажатию на чекбокс
                let numTab = document.getElementById("tab" + openTabId + "-")

                let rightCard = numTab.querySelector("#cardRight");
                let cardForAdding = rightCard.querySelector(":first-child");
                let cardForAdding1 = cardForAdding.querySelector(":first-child");
                if(cardForAdding1)
                    cardForAdding1.insertAdjacentHTML("afterbegin",response);

            });

    } else {

        if (confirm("Осторожно! Все таблицы отделений будут удалены. Вы уверены, что хотите удалить?")) {

            $.ajax({
                url: "ajax/deleteListTablesCheckbox.php",
                method: "GET",
                data: {id_sub: openTabId}
            })
                .done(function (response) {
                    let numTab = document.getElementById("tab" + openTabId + "-")

                    let rightCard = numTab.querySelector("#cardRight");
                    let cardForAdding = rightCard.querySelector(":first-child");
                    let cardForAdding1 = cardForAdding.querySelector(":first-child");
                    cardForAdding1.innerHTML = "";
                });
            [...formCheckInput].forEach(item => {
                if (item.checked === false) {
                    item.removeAttribute("disabled");
                }
            });
            [...formButton].forEach(item => {
                item.setAttribute("disabled", true);
            })
        } else {
            inputCheck.checked = true;
        }

    }

}

function buttonSelected(inputCheck) {  // добавление отделений (кнопки) - добавление таблиц отделений по кнопкам

    let department = prompt("Введите названия отделения");
    if (department !== undefined && department.trim() !== '') {
        let str = inputCheck.id;
        let id_list_tables_criteria = str.replace(/\D/g, ''); // Удаление всех символов, кроме цифр

        $.ajax({
            url: "ajax/saveListTables.php",
            method: "GET",
            data: {id_sub: openTabId, id_list_tables_criteria: id_list_tables_criteria, department: department}
        })
            .done(function (response) {
                alert("Добавлено отделение");
                let number;
                let incrementedNumber;
                let buttonText = inputCheck.textContent;
                if (buttonText.includes(":")) {
                    number = parseInt(buttonText.split(":")[1].trim());
                    let incrementedNumber = number + 1;
                    inputCheck.textContent = buttonText.replace(number, incrementedNumber);
                } else {
                    inputCheck.textContent = buttonText + ": 1";
                }
                let numTab = document.getElementById("tab" + openTabId + "-")

                let rightCard = numTab.querySelector("#cardRight");
                let cardForAdding = rightCard.querySelector(":first-child");
                let cardForAdding1 = cardForAdding.querySelector(":first-child");
                if(cardForAdding1)
                    cardForAdding1.insertAdjacentHTML("afterbegin",response);
            });
    } else {

    }
}

function newCollapseTable(thisDiv){
    let card = thisDiv.parentElement;
    let thisCollapse = card.querySelector("#collapse" + thisDiv.id.substring(7));
    if(thisCollapse.classList.contains("show")){
        thisCollapse.classList.remove("show");
    }else{
        thisCollapse.classList.add("show");
    }
}

function changeField3(idCrit, idDep, select){
    $.ajax({
        url: "ajax/changeField3.php",
        method: "GET",
        data: {idCrit: idCrit, idDep: idDep, val: select.options[select.selectedIndex].value, id_sub: openTabId}
    })
        .done(function (response) {

        })
}

function changeField5(idCrit, idDep, text){
    $.ajax({
        url: "ajax/changeField5.php",
        method: "GET",
        data: {idCrit: idCrit, idDep: idDep, text: text.innerText.replace(/[^\w\s]/gi, '')}
    }).done(function (response) {

        })
}

function addFile(idCrit, idDep, input){
    let login = getCookie('login');

    let divA = document.getElementById(idCrit+"_"+idDep);

    let xhr = new XMLHttpRequest(),
        form = new FormData();
    let addedFile = input.files[0];
    form.append("idCrit", idCrit);
    form.append("idDep", idDep);
    form.append("addedFile", addedFile);

    xhr.open("post", "ajax/changeField4.php", true);

    let load = document.createElement("div");
    load.innerHTML = "Подождите, идет загрузка";
    divA.insertAdjacentElement("afterend", load);

    xhr.upload.onprogress = function(event) {
        if (event.lengthComputable) {
            let progress = (event.loaded / event.total) * 100;
            load.innerHTML = "Загрузка: " + Math.round(progress) + "%";
        }
    };

    xhr.upload.onloadstart = function() {
        load.innerHTML = "Подождите, идет загрузка";
    };

    xhr.upload.onload = function () {
        load.remove();
        let fileContainer = document.createElement('div');
        fileContainer.classList.add('file-container');
        let fileLink = document.createElement('a');
        fileLink.href = `/docs/documents/${login}/${idDep}/${addedFile.name}`;
        fileLink.textContent = addedFile.name;
        let deleteButton = document.createElement('span');
        deleteButton.classList.add('delete-file');
        deleteButton.textContent = '×';
        deleteButton.style.cursor = 'pointer';
        deleteButton.style.paddingLeft = '10px';
        deleteButton.id = 'delete_' + idCrit + '_' + idDep + '_' + addedFile.name;
        deleteButton.onclick = function() {
            z_deleteFile(addedFile.name, idCrit, idDep);
        };
        fileContainer.appendChild(fileLink);
        fileContainer.appendChild(deleteButton);
        divA.appendChild(fileContainer);
    }
    xhr.send(form);
}


function z_deleteFile(fileName, idCrit, idDepartment) {
    if (confirm('Вы уверены, что хотите удалить этот файл?')) {
        let url = 'ajax/z_deleteFile.php?file_name=' + encodeURIComponent(fileName) + '&id_criteria=' + idCrit + '&id_department=' + idDepartment;
        fetch(url)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const fileContainers = document.getElementsByClassName('file-container');
                    for (let i = 0; i < fileContainers.length; i++) {
                        if (fileContainers[i].contains(document.getElementById('delete_' + idCrit + '_' + idDepartment + '_' + fileName))) {
                            fileContainers[i].remove();
                            break;
                        }
                    }
                } else {
                    alert('Не удалось удалить файл. Попробуйте снова.');
                }
            })
            .catch((error) => {
                console.error('Ошибка при удалении файла:', error);
                alert('Ошибка при удалении файла.');
            });
    }
}


function deleteDepartment(id_department) {
    event.stopPropagation();
    let confirmDelete = confirm("Вы действительно хотите удалить отделение?");
    if (confirmDelete) {
        $.ajax({
            url: "ajax/z_deleteDepartment.php",
            method: "GET",
            data: {id_sub: openTabId, id_department: id_department},
        })
            .done(function (response) {
                console.log(response);
                alert("Отделение удалено.");
                let id_list_tables_criteria = response;
                let countButton = document.querySelector("#checkbox" + id_list_tables_criteria);
                let countText = countButton.innerText;
                let count = parseInt(countText.split(":")[1].trim());
                count--;
                countButton.innerText = countText.replace(count, count - 1);
                let cardH  = document.getElementById("heading" + id_department);
                cardH.remove();
            })
            .fail(function (error) {
                console.error("Ошибка при удалении отдела:", error);
            });
    }
}


function renameDepartment(id_department) {
    event.stopPropagation();
    let newDepartmentName = prompt("Введите новое название отделения:");
    if (newDepartmentName !== null && newDepartmentName.trim() !== "") {
        $.ajax({
            url: "ajax/z_renameDepartment.php",
            method: "GET",
            data: { id_department: id_department, new_department_name: newDepartmentName, id_sub:openTabId },
        })
            .done(function (response) {
                console.log(response);
                let cardH = document.getElementById("heading" + id_department);
                let button = cardH.querySelector("button");
                let buttonText = button.innerText;
                let newText = newDepartmentName + buttonText.substring(buttonText.indexOf("(самооценка"));
                button.innerText = newText;
                alert("Отделение переименовано.");
            })
            .fail(function (error) {
                console.error("Ошибка при переименовании отделения:", error);
            });
    }
}




 function printNewReport() {
     return new Promise((resolve, reject) => {
         let number_app = document.getElementById("id_application");
         let id_application = number_app.innerHTML;
         let criteriaMark = document.createElement('div');
         criteriaMark.textContent = '<strong>Достигнуты следующие результаты</strong><br/>';
         criteriaMark.style = "padding-top: 0.5rem; padding-bottom:1rem; ";
         var WinPrint = window.open('', '', 'left=50,top=50,width=800,height=640,toolbar=0,scrollbars=1,status=0');
         WinPrint.document.write('<style>@page {\n' +
             'margin: 1rem;\n' +
             '}</style>');

         let textSubCriteriaChecked = '';
         let divTextSubCriteriaChecked = document.createElement('div');
         divTextSubCriteriaChecked.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem;";

         $.ajax({
             url: "ajax/getCalc.php",
             method: "GET",
             data: {id_application: id_application}
         }).then(() => {
             return $.ajax({
                 url: "ajax/z_getSubForPrintReport.php",
                 method: "GET",
                 data: {id_application: id_application}
             });
         }).then((response) => {
             let subCriteriaForReport = JSON.parse(response);
             let id_s = -1;
             let as = '';
             subCriteriaForReport.map((item, index) => {
                 if (id_s !== item['id_subvision']) {
                     if (index != 0) {
                         textSubCriteriaChecked += `<div>${as}</div>`;
                     }
                     as = '';
                     id_s = item['id_subvision'];
                     as = `Самооценка ${item['name']} проведена по следующим отделениям медицинской аккредитации: `;
                 }
                 if (index === subCriteriaForReport.length - 1) {
                     as += item['name_otdel'] == null ? 'не выбраны отделения' : item['name_otdel'] + ".";
                     textSubCriteriaChecked += `<div>${as}</div>`;
                 } else {
                     if (subCriteriaForReport[index + 1]['name'] && subCriteriaForReport[index]['name'] !== subCriteriaForReport[index + 1]['name'])
                         as += item['name_otdel'] == null ? 'не выбраны отделения' : item['name_otdel'] + ".";
                     else
                         as += item['name_otdel'] == null ? 'не выбраны отделения' : item['name_otdel'] + ", ";
                 }
             });
         }).then(() => {
             let mainRightCard = document.getElementById("mainRightCard");
             let mainRightCardText = mainRightCard.innerHTML;
             criteriaMark.textContent += mainRightCardText;
             let table;
             return $.ajax({
                 url: "ajax/z_getAppForPrintNo.php",
                 method: "GET",
                 data: {id_app: id_application}
             });
         }).then((response) => {
             let tableForPrint = JSON.parse(response);
             if (tableForPrint.length !== 0) {
                 let naim = document.getElementById("naim");
                 let unp = document.getElementById("unp");
                 let naimText = naim.value;
                 let unpText = unp.value;
                 table = createTableForPrintNo(tableForPrint);
             }
         }).then(() => {
             let sokr = document.getElementById('sokr');
             let naim = document.getElementById('naim');

             function formatDate(date) {
                 var dd = date.getDate();
                 if (dd < 10) dd = '0' + dd;
                 var mm = date.getMonth() + 1;
                 if (mm < 10) mm = '0' + mm;
                 var yy = date.getFullYear() % 100;
                 if (yy < 10) yy = '0' + yy;
                 return dd + '.' + mm + '.' + yy;
             }

             let divReportTitle = document.createElement('div');
             divReportTitle.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem;";
             divReportTitle.textContent = `Результат самооценки ${naim.value} (${sokr.value}) ${formatDate(new Date())}`;
             WinPrint.document.write(divReportTitle.innerHTML);
             WinPrint.document.write('<br/>');
             WinPrint.document.write('<br/>');
             divTextSubCriteriaChecked.innerHTML = textSubCriteriaChecked;
             WinPrint.document.write(divTextSubCriteriaChecked.innerHTML);
             WinPrint.document.write('<br/>');
             WinPrint.document.write(criteriaMark.innerText);
             WinPrint.document.write('<br/>');
             if (table && table.textContent && table.textContent.length > 0) {
                 let divReportTitleFieldNo = document.createElement('div');
                 divReportTitleFieldNo.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem;";
                 divReportTitleFieldNo.textContent = '<strong>Установлено несоответствие по следующим критериям:</strong>';
                 WinPrint.document.write(divReportTitleFieldNo.textContent);
                 WinPrint.document.write('<br/>');
                 WinPrint.document.write('<br/>');
                 WinPrint.document.write(table.innerHTML);
             } else {
                 WinPrint.document.write(divReportTitle.innerHTML);
                 WinPrint.document.write('<br/>');
                 WinPrint.document.write('<br/>');
                 divTextSubCriteriaChecked.innerHTML = textSubCriteriaChecked;
                 WinPrint.document.close();
                 WinPrint.focus();
                 let naimOrg = document.getElementById("naim");
                 WinPrint.document.title = "Результат самооценки_" + naimOrg.value + "_№" + id_application + "_" + new Date().toLocaleDateString().replaceAll(".", "");
                 WinPrint.print();
                 WinPrint.close();
             }
             WinPrint.document.close();
             WinPrint.focus();
             WinPrint.print();
             WinPrint.close();
             resolve();
         }).catch((error) => {
             console.error(error);
         });
     })

}

$("#newBtnPrint").on("click", function () {

    newPrint();
});

function newPrint() {


    let number_app = document.getElementById("id_application");
    let id_application = number_app.innerHTML;


    $.ajax({
        url: "ajax/z_getAppForPrint.php",
        method: "GET",
        data: {id_app: id_application}
    })
        .done(function (response) {
            //  console.log(response);
            let tableForPrint = JSON.parse(response);


            let naim = document.getElementById("naim");
            let unp = document.getElementById("unp");
            let naimText = naim.value;
            let unpText = unp.value;

            var WinPrint = window.open('', '', 'left=50,top=50,width=800,height=640,toolbar=0,scrollbars=1,status=0');

            WinPrint.document.write('<style>@page {\n' +
                'margin: 1rem;\n' +
                '}</style>');  // убрать колонтитул


            let table = newCreateTableForPrint(tableForPrint);


            WinPrint.document.write('<br/>');
            WinPrint.document.write(table.innerHTML);


            WinPrint.document.close();
            WinPrint.focus();
            let naimOrg = document.getElementById("naim");
            WinPrint.document.title = naimOrg.value + "_№" + id_application + "_" + new Date().toLocaleDateString().replaceAll(".", "");
            WinPrint.print();
            WinPrint.close();

        });


}


function newCreateTableForPrint(tableForPrint) {

    let divPrintTable = document.createElement('div');

    let divNameSubTable = document.createElement('div');
    divNameSubTable.textContent = tableForPrint[0]['name'];
    divNameSubTable.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:1.8rem; font-weight: 600";

    divPrintTable.appendChild(divNameSubTable);

    let divNameCriteriaTable = document.createElement('div');
    divNameCriteriaTable.textContent = tableForPrint[0]['name_criteria'];
    divNameCriteriaTable.style = "padding-top: 1rem; padding-bottom:2rem";

    divPrintTable.appendChild(divNameCriteriaTable);

    let table = document.createElement('table');
    table.style = "border-collapse: collapse; border-spacing: 0;";


    let trHeadMain = document.createElement('tr');

    let thNum = document.createElement('th');
    thNum.innerHTML = '№ п/п';
    thNum.style = "border: 1px solid black";
    thNum.setAttribute('rowspan', '2');

    let th1_Main = document.createElement('th');
    th1_Main.innerHTML = 'Критерий';
    th1_Main.style = "border: 1px solid black; ";
    th1_Main.setAttribute('rowspan', '2');
    /*
        let th2_Main = document.createElement('th');
        th2_Main.innerHTML = 'Класс критерия';
        th2_Main.style = "border: 1px solid black";
        th2_Main.setAttribute('rowspan','2');
    */

    let th3_Main = document.createElement('th');
    th3_Main.innerHTML = 'Сведения о соблюдении критериев (самооценка)';
    th3_Main.style = "border: 1px solid black; text-align: center";
    th3_Main.setAttribute('colspan', '3');


    let trHead = document.createElement('tr');
    let th3 = document.createElement('th');
    th3.innerHTML = 'Сведения по самооценке ОЗ';
    th3.style = "border: 1px solid black";

    let th4 = document.createElement('th');
    th4.innerHTML = 'Документы и сведения, на основании которых проведена самооценка';
    th4.style = "width:350px; border: 1px solid black";


    let th5 = document.createElement('th');
    th5.innerHTML = 'Примечание';
    th5.style = "border: 1px solid black";


    trHeadMain.appendChild(thNum);
    trHeadMain.appendChild(th1_Main);
    //  trHeadMain.appendChild(th2_Main);
    trHeadMain.appendChild(th3_Main);


    table.appendChild(trHeadMain);
    trHead.appendChild(th3);
    trHead.appendChild(th4);
    trHead.appendChild(th5);


    table.appendChild(trHead);

    let tbody = document.createElement('tbody');
    table.appendChild(tbody);

    numCriteria = 0;
    numSub = 0;
    tableForPrint.map((item, index) => {


        if (numSub !== item['id_subvision'] && (index !== 0)) {

            let trNaimSub = document.createElement('tr');
            let tdNaimSub = document.createElement('td');
            tdNaimSub.setAttribute('colspan', '6');
            tdNaimSub.style = "padding-top: 2rem; padding-bottom:1rem; font-size:1.8rem; font-weight: 600";
            tdNaimSub.innerHTML = item['name'];
            trNaimSub.appendChild(tdNaimSub);
            tbody.appendChild(trNaimSub);
            numCriteria = -1;

        }

        if ((numCriteria !== item['id_criteria']) && (index !== 0)) {
            let trNaim = document.createElement('tr');
            let tdNaim = document.createElement('td');
            tdNaim.setAttribute('colspan', '6');
            tdNaim.style = "padding-top: 1rem; padding-bottom:1rem";
            tdNaim.innerHTML = item['name_criteria'];
            trNaim.appendChild(tdNaim);
            tbody.appendChild(trNaim);


            let trHeadMain2 = document.createElement('tr');

            let thNum = document.createElement('th');
            thNum.innerHTML = '№ п/п';
            thNum.style = "border: 1px solid black";
            thNum.setAttribute('rowspan', '2');

            let th1_Main2 = document.createElement('td');
            th1_Main2.innerHTML = 'Критерий';
            th1_Main2.style = "border: 1px solid black";
            th1_Main2.setAttribute('rowspan', '2');
            /*
                            let th2_Main2 = document.createElement('td');
                            th2_Main2.innerHTML = 'Класс критерия';
                            th2_Main2.style = "border: 1px solid black";
                            th2_Main2.setAttribute('rowspan','2');
            */

            let th3_Main2 = document.createElement('td');
            th3_Main2.innerHTML = 'Сведения о соблюдении критериев (самооценка)';
            th3_Main2.style = "border: 1px solid black; text-align: center";
            th3_Main2.setAttribute('colspan', '3');


            let trHead2 = document.createElement('tr');
            let th32 = document.createElement('td');
            th32.innerHTML = 'Сведения по самооценке ОЗ';
            th32.style = "border: 1px solid black";

            let th42 = document.createElement('td');
            th42.innerHTML = 'Документы и сведения, на основании которых проведена самооценка';
            th4.style = "width:350px; border: 1px solid black";


            let th52 = document.createElement('td');
            th52.innerHTML = 'Примечание';
            th52.style = "border: 1px solid black";


            trHeadMain2.appendChild(thNum);
            trHeadMain2.appendChild(th1_Main2);
            //      trHeadMain2.appendChild(th2_Main2);
            trHeadMain2.appendChild(th3_Main2);


            tbody.appendChild(trHeadMain2);
            trHead2.appendChild(th32);
            trHead2.appendChild(th42);
            trHead2.appendChild(th52);

            tbody.appendChild(trHead2);
        }


        numCriteria = -1;

        if (item['id_criteria'] !== null) {

            let tr = document.createElement('tr');

            let tdNum = document.createElement('td');
            tdNum.innerHTML = item['str_num'];
            tdNum.style = "border: 1px solid black";

            let td1 = document.createElement('td');
            td1.innerHTML = item['mark_name'];
            td1.style = "border: 1px solid black; padding: 0.2rem 0.75rem";
            /*
                        let td2 = document.createElement('td');
                        td2.innerHTML = item['mark_class'];
                        td2.style = "border: 1px solid black; padding: 0.2rem 0.75rem";
            */
            let td3 = document.createElement('td');
            td3.style = "border: 1px solid black; padding: 0.2rem 0.75rem";
            td3.innerHTML = item['field4'];

            let td4 = document.createElement('td');
            td4.style = "border: 1px solid black; padding: 0.2rem 0.75rem";
            td4.innerHTML = item['field5'];

            let td5 = document.createElement('td');
            td5.style = "border: 1px solid black; padding: 0.2rem 0.75rem";
            td5.innerHTML = item['field6'];


            tr.appendChild(tdNum);
            tr.appendChild(td1);
            //    tr.appendChild(td2);
            tr.appendChild(td3);

            tr.appendChild(td4);
            tr.appendChild(td5);

            tbody.appendChild(tr);

            numCriteria = item['id_criteria'];
        }


        numSub = item['id_subvision']
    })


    divPrintTable.appendChild(table);

    return divPrintTable;
}

async function printAppForm(){
    return new Promise((resolve, reject) => {
        $.ajax({
            url: "ajax/z_createFormApplication.php",
            method: "GET",
            data: { id_application: id_app }
        }).then((response) => {
            var WinPrint = window.open('', '', 'left=50,top=50,width=800,height=640,toolbar=0,scrollbars=1,status=0');
            WinPrint.document.write('<style>@page {\n' +
                'margin: 1rem;\n' +
                '}</style>');
            WinPrint.document.write('<br/>');
            WinPrint.document.write(response);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.document.title = "Заявление_№" + id_app + "_" + new Date().toLocaleDateString().replaceAll(".", "");
            WinPrint.print();
            WinPrint.close();

            resolve();
        })
    });
}

async function sendApp(){

    let id_application = document.getElementById("id_application");
    let divSoprovodPismo = document.getElementById("divSoprovodPismo");
    let divCopyRaspisanie = document.getElementById("divCopyRaspisanie");
    let divOrgStrukt = document.getElementById("divOrgStrukt");
    let divFileReportSamoocenka = document.getElementById("divFileReportSamoocenka");

    let sokr = document.getElementById("sokr");
    let unp = document.getElementById("unp");
    let adress = document.getElementById("adress");
    let tel = document.getElementById("tel");
    let email = document.getElementById("email");
    let rukovoditel = document.getElementById("rukovoditel");
    let predstavitel = document.getElementById("predstavitel");

    let isSend = confirm("После отправления заявки, редактирование будет невозможно. Отправить?");
    if (isSend) {

        if (divSoprovodPismo.getElementsByTagName("a").length == 0 ||
            divCopyRaspisanie.getElementsByTagName("a").length == 0 ||
            divOrgStrukt.getElementsByTagName("a").length == 0 ||
            divFileReportSamoocenka.getElementsByTagName("a").length == 0
        ) {
            alert("Не все обязательные документы загружены! Заявление не отправлено.");
        } else if (sokr.value.trim() === "" ||
            unp.value.trim() === "" ||
            adress.value.trim() === "" ||
            tel.value.trim() === "" ||
            email.value.trim() === "" ||
            rukovoditel.value.trim() === "" ||
            predstavitel.value.trim() === ""
        ) {
            alert("Не все обязательные поля заполнены.");

        } else {
            printAppForm().then(()=> {
                printNewReport().then(() => {
                    $.ajax({
                        url: "ajax/sendApp.php",
                        method: "GET",
                        data: {id_application: id_application.innerText}
                    })
                        .done(function (response) {
                            if (response == "") {
                                alert("Заявление отправлено");
                                location.href = "/index.php?application";
                            } else {
                                alert(response);
                            }
                        });
                })
            })


        }
    }
}


function saveUcompField(idSub, idDep, text, fieldNum) {
    $.ajax({
        url: "ajax/z_saveUcompField.php",
        method: "GET",
        data: {idSub: idSub, idDep: idDep, fieldNum: fieldNum, text: text.innerText.replace(/[^\w\s\+\-%,.]/gi, '')}
    }).then(function (response) {
        let modalUcomplect = document.getElementById("modalUcomplect");
        let modalBody = modalUcomplect.getElementsByClassName("modal-body")[0];

            $.ajax({
                url: "ajax/z_ucomplectTable.php",
                method: "GET",
                data: {id_application: id_app}
            }).then((response) => {
                modalBody.innerHTML = response;
            })
    })
}



//
// $("#btnSend").on("click", async () =>{
//     if(this.id === "newBtnSend") {
//         await sendApp(id_app);
//     }else {
//
//     }
// })