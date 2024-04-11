let id_app;
let createrApp;

function newShowModal(id_application) {
    id_app = id_application;
    let formFileReportZakluchenieSootvet = document.getElementById("formFileReportZakluchenieSootvet");

    if (formFileReportZakluchenieSootvet.classList.contains("hiddentab"))
        formFileReportZakluchenieSootvet.classList.add("hiddentab");

    let fileAdminResh = document.getElementById("fileAdminResh");
    $.ajax({
        url: "ajax/getFileAdminResh.php",
        method: "POST",
        data: {id_app: id_app}
    }).then(response => {
        fileAdminResh.innerHTML = response;
        fileAdminResh.href = `docs/documents/${getCookie('login')}/${id_app}/${response}`;
    })

    createrApp = "";

    $.ajax({
        url: "ajax/getCreaterApp.php",
        method: "GET",
        data: {id_application: id_application}
    }).then((response) => {
        createrApp = response;
    })

    let formFileReportSamoocenka = document.getElementById("formFileReportSamoocenka");
    formFileReportSamoocenka.classList.add("hiddentab");
    let formUcomplect = document.getElementById("formUcomplect");
    formUcomplect.style = "display: none";
    let newDivUcomplect = document.createElement("div");
    let btnTableUcomplect = document.createElement("button");
    let labelUcomplect = document.createElement("p");
    labelUcomplect.innerHTML = "Укомплектованность";
    newDivUcomplect.appendChild(labelUcomplect);
    btnTableUcomplect.innerHTML = "Редактировать";
    btnTableUcomplect.classList = "ownUcomp"
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
        btnPrint.title = "Печать самоакредитации";
    } else {
        let btnPrint = document.getElementById("newBtnPrint");
        btnPrint.title = "Печать самоакредитации";
    }


    if (btnPrintReport) {
        btnPrintReport.id = "btnNewPrintReport";
        btnPrintReport.title = "Печать самоакредитации";
    } else {
        let btnPrintReport = document.getElementById("btnNewPrintReport");
        btnPrintReport.title = "Печать самоакредитации";
    }


    let homeTab = document.getElementById("home-tab");
    let btnSen = document.getElementById("newBtnSend");
    let btnSu = document.getElementById("btnSuc");

    if (homeTab.classList.contains("active")) {
        if (idRole !== "15") {
            if (btnSen.classList.contains("hiddentab")) {
                btnSen.classList.remove("hiddentab");
            }
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

    if (idRole === "15") {
        let btnFormApplication = document.getElementById("btnFormApplication");
        if (btnFormApplication) {
            if (!btnFormApplication.classList.contains("hiddentab")) {
                btnFormApplication.classList.add("hiddentab");
            }

            //   btnFormApplication.remove();
        }
        if (btnSen) {
            if (!btnSen.classList.contains("hiddentab")) {
                btnSen.classList.add("hiddentab");
            }
            btnSen.remove();
        }

        addtab.style = "display: none";
        let licoSelect = document.getElementById("lico");
        licoSelect.setAttribute("disabled", true);

        let prikazNaznachSelel = document.getElementById("prikazNaznach");
        prikazNaznachSelel.setAttribute("disabled", true);

        let doverennostSelel = document.getElementById("doverennost");
        doverennostSelel.setAttribute("disabled", true);
// if (reportZakluchenieSootvetSelect) {
//     let reportZakluchenieSootvetSelect = document.getElementById("reportZakluchenieSootvet");
//     reportZakluchenieSootvetSelect.setAttribute("disabled", true);
// }


    }


    let btnSuc = document.getElementById("btnSuc");
    // let btnCalc = document.getElementById("btnCalc");


    //  console.log(aButton);


    document.getElementsByClassName("modal-title")[0].innerHTML = "Редактирование заявления № ";


    let ownUcompBtnClass = document.getElementsByClassName("ownUcomp")[0];
    let number_app = document.getElementById("id_application");
    let naim = document.getElementById("naim");
    naim.setAttribute("readonly", "");
    let sokr = document.getElementById("sokr");
    let unp = document.getElementById("unp");
    let adress = document.getElementById("adress");
    let adressFact = document.getElementById("adressFact");
    let tel = document.getElementById("tel");
    let email = document.getElementById("email");
    let rukovoditel = document.getElementById("rukovoditel");
    let predstavitel = document.getElementById("predstavitel");
    let soprPismo = document.getElementById("soprPismo");
    let orgStrukt = document.getElementById("orgStrukt");
    let ucomplect = document.getElementById("ucomplect");
    let techOsn = document.getElementById("techOsn");
    let fileReport = document.getElementById("fileReport");
    let reportSamoocenka = document.getElementById("reportSamoocenka");
    let reportZakluchenieSootvet = document.getElementById("reportZakluchenieSootvet");
    let doverennost = document.getElementById("doverennost");
    let prikazNaznach = document.getElementById("prikazNaznach");
    let divFileReportDorabotka = document.getElementById("divFileReportDorabotka");
    let divDateDorabotka = document.getElementById("divDateDorabotka");
    let formFileReportDorabotka = document.getElementById("formFileReportDorabotka");
    let formDateDorabotka = document.getElementById("formDateDorabotka");
    let licoSelect = document.getElementById("lico");

    divSoprPismo.style = "display:none";
    divOrgStrukt.style = "display:none";

    let divCopyRaspisanie = document.getElementById("divCopyRaspisanie");
    let divUcomplect = document.getElementById("divUcomplect");
    let divTechOsn = document.getElementById("divTechOsn");
    let divReport = document.getElementById("divReport");
    let divFileReportSamoocenka = document.getElementById("divFileReportSamoocenka");
    let divFileReportZakluchenieSootvet = document.getElementById("divFileReportZakluchenieSootvet");
    let divDoverennost = document.getElementById("divDoverennost");
    let divPrikazNaznach = document.getElementById("divPrikazNaznach");
    number_app.innerHTML = id_application;
    id_app = id_application;
    let modal = document.getElementById("myModal");
    let tablist = document.getElementById("tablist");

    //  naim.value = username;
    if (status == 1 || status == 5) {
        if (formFileReportDorabotka) {
            formFileReportDorabotka.style.display = "block";
            formDateDorabotka.style.display = "block";
        }
        checkUserRole();

    } else {
        number_app.setAttribute("readonly", "");
        naim.setAttribute("readonly", "");
        sokr.setAttribute("readonly", "");
        unp.setAttribute("readonly", "");
        adress.setAttribute("readonly", "");
        adressFact.setAttribute("readonly", "");
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
        ownUcompBtnClass.setAttribute("disabled", "true");
        doverennost.setAttribute("disabled", "true");
        prikazNaznach.setAttribute("disabled", "true");

        licoSelect.setAttribute("disabled", true);

        reportSamoocenka.setAttribute("disabled", "true");
        //   reportZakluchenieSootvet.setAttribute("disabled", "true");
        // formFileReportDorabotka.setAttribute("disabled", "true");
        //   formDateDorabotka.setAttribute("disabled", "true");
        //   formFileReportDorabotka.style.display = "none";
        // formDateDorabotka.style.display = "none";
        addtab.classList.add("hiddentab");
        btnSuc.classList.add("hiddentab");

        if (btnSend)
            btnSend.classList.add("hiddentab");
        // if (btnCalc) {
        //     btnCalc.remove();
        // }
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
            adressFact.value = data[0][18];

            if (data[0][17] != null) {
                divDateDorabotka.insertAdjacentHTML("afterend", "<span>" + data[0][17] + "</span>");
            }
            if (data[0][14] != null) {
                fileReport.insertAdjacentHTML("afterend", "<a target='_blank' href='/docs/documents/" + data[0][13] + "/" + id_application + "/" + data[0][14] + "'>" + data[0][14] + "</a>");
            }
            if (data[0][15] != null) {
                reportSamoocenka.insertAdjacentHTML("afterend", "<a target='_blank' href='/docs/documents/" + data[0][13] + "/" + id_application + "/" + data[0][15] + "'>" + data[0][15] + "</a>");
            }
            if (data[0][16] != null) {
                divFileReportDorabotka.insertAdjacentHTML("afterend", "<a target='_blank' href='/docs/documents/" + "/dorabotka/" + id_application + "/" + data[0][16] + "'>" + data[0][16] + "</a>");
            }
            if (data[0][8] != null) {
                soprPismo.insertAdjacentHTML("afterend", "<a target='_blank' href='/docs/documents/" + data[0][13] + "/" + id_application + "/" + data[0][8] + "'>" + data[0][8] + "</a>");
            }
            if (data[0][9] != null) {
                copyRaspisanie.insertAdjacentHTML("afterend", "<a target='_blank' href='/docs/documents/" + data[0][13] + "/" + id_application + "/" + data[0][9] + "'>" + data[0][9] + "</a>");
            }
            if (data[0][10] != null) {
                orgStrukt.insertAdjacentHTML("afterend", "<a target='_blank' href='/docs/documents/" + data[0][13] + "/" + id_application + "/" + data[0][10] + "'>" + data[0][10] + "</a>");
            }
            if (data[0][11] != null) {
                ucomplect.insertAdjacentHTML("afterend", "<a target='_blank' href='/docs/documents/" + data[0][13] + "/" + id_application + "/" + data[0][11] + "'>" + data[0][11] + "</a>");
            }
            if (data[0][12] != null) {
                techOsn.insertAdjacentHTML("afterend", "<a target='_blank' href='/docs/documents/" + data[0][13] + "/" + id_application + "/" + data[0][12] + "'>" + data[0][12] + "</a>");
            }
            // if (data[0][20] != null) {
            //     reportZakluchenieSootvet.insertAdjacentHTML("afterend", "<a target='_blank' href='/docs/documents/" + data[0][13] + "/" + id_application + "/" + data[0][20] + "'>" + data[0][20] + "</a>");
            // }

            let lico = document.getElementById("lico");
            if (data[0][22] != null) {
                lico.options.selectedIndex = data[0][22];
                chengeLico(lico);
            } else {
                lico.options.selectedIndex = 0;
                chengeLico(lico);
            }

            if (data[0][21] != null) {
                prikazNaznach.insertAdjacentHTML("afterend", "<a target='_blank' href='/docs/documents/" + data[0][13] + "/" + id_application + "/" + data[0][21] + "'>" + data[0][21] + "</a>");
            }

            if (data[0][19] != null) {
                doverennost.insertAdjacentHTML("afterend", "<a target='_blank' href='/docs/documents/" + data[0][13] + "/" + id_application + "/" + data[0][19] + "'>" + data[0][19] + "</a>");
            }

            modal.classList.add("show");
            modal.style = "display: block";

            for (let obj of data[1]) {

                newGetTabs(obj[1], obj[0]);

            }
            let mark_percent = data[2];
            let mainRightCard = document.getElementById("mainRightCard");
            mainRightCard.innerHTML = "Самоаккредитация - " + Math.round(parseFloat(mark_percent).toFixed(2)) + "%";

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
        //   let divZakluchenieSootvet = divFileReportZakluchenieSootvet.getElementsByTagName("a")[0];
        let samoocenka = divFileReportSamoocenka.getElementsByTagName("a")[0];
        //  let fRD = formFileReportDorabotka.querySelectorAll("a");
        let doverennost = divDoverennost.getElementsByTagName("a")[0];
        let prikazNaznach = divPrikazNaznach.getElementsByTagName("a")[0];

        //    let DD = formDateDorabotka.querySelectorAll("span");


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
                        // if (divZakluchenieSootvet) {
                        //     divZakluchenieSootvet.remove();
                        // }
                        // Удалить все найденные элементы с тегом "a"
                        // for (let anchor of fRD) {
                        //     anchor.remove();
                        // }

                        // for (let anchor of DD) {
                        //     anchor.remove();
                        // }
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

                        if (doverennost) {
                            doverennost.remove();
                        }
                        if (prikazNaznach) {
                            prikazNaznach.remove();
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
                // if (divZakluchenieSootvet) {
                //     divZakluchenieSootvet.remove();
                // }
                // Удалить все найденные элементы с тегом "a"
                // for (let anchor of fRD) {
                //     anchor.remove();
                // }

                // for (let anchor of DD) {
                //     anchor.remove();
                // }
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
                if (doverennost) {
                    doverennost.remove();
                }
                if (prikazNaznach) {
                    prikazNaznach.remove();
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
            // if (divZakluchenieSootvet) {
            //     divZakluchenieSootvet.remove();
            // }
            // Удалить все найденные элементы с тегом "a"
            // for (let anchor of fRD) {
            //     anchor.remove();
            // }

            // for (let anchor of DD) {
            //     anchor.remove();
            // }
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
            if (doverennost) {
                doverennost.remove();
            }
            if (prikazNaznach) {
                prikazNaznach.remove();
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
        //   let divZakluchenieSootvet = divFileReportZakluchenieSootvet.getElementsByTagName("a")[0];
        //   let fRD = formFileReportDorabotka.querySelectorAll("a");
        //  let DD = formDateDorabotka.querySelectorAll("span");
        let doverennost = divDoverennost.getElementsByTagName("a")[0];
        let prikazNaznach = divPrikazNaznach.getElementsByTagName("a")[0];

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
                        // if (divZakluchenieSootvet) {
                        //     divZakluchenieSootvet.remove();
                        // }
                        // Удалить все найденные элементы с тегом "a"
                        // for (let anchor of fRD) {
                        //     anchor.remove();
                        // }

                        // for (let anchor of DD) {
                        //     anchor.remove();
                        // }
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
                        if (doverennost) {
                            doverennost.remove();
                        }
                        if (prikazNaznach) {
                            prikazNaznach.remove();
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
                // if (divZakluchenieSootvet) {
                //     divZakluchenieSootvet.remove();
                // }
                // Удалить все найденные элементы с тегом "a"
                // for (let anchor of fRD) {
                //     anchor.remove();
                // }

                // for (let anchor of DD) {
                //     anchor.remove();
                // }
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
                if (doverennost) {
                    doverennost.remove();
                }
                if (prikazNaznach) {
                    prikazNaznach.remove();
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
            // if (divZakluchenieSootvet) {
            //     divZakluchenieSootvet.remove();
            // }
            // Удалить все найденные элементы с тегом "a"
            // for (let anchor of fRD) {
            //     anchor.remove();
            // }

            // for (let anchor of DD) {
            //     anchor.remove();
            // }
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
            if (doverennost) {
                doverennost.remove();
            }
            if (prikazNaznach) {
                prikazNaznach.remove();
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
                    inputCheck.style = "color: black;\n" +
                        "    display: inline-block;\n" +
                        "    background: -webkit-linear-gradient(top, #f9f9f9, #e3e3e3);\n" +
                        "    border: 1px solid #999;\n" +
                        "    border-radius: 3px;\n" +
                        "    padding: 5px 8px;\n" +
                        "    outline: none;\n" +
                        "    white-space: normal;\n" +
                        "    -webkit-user-select: none;\n" +
                        "    cursor: pointer;\n" +
                        "    text-shadow: 1px 1px #fff;\n" +
                        "    font-weight: 700;\n" +
                        "    font-size: 10pt;width:90%;";
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
                    inputCheck.style = "color: black;\n" +
                        "    display: inline-block;\n" +
                        "    background: -webkit-linear-gradient(top, #f9f9f9, #e3e3e3);\n" +
                        "    border: 1px solid #999;\n" +
                        "    border-radius: 3px;\n" +
                        "    padding: 5px 8px;\n" +
                        "    outline: none;\n" +
                        "    white-space: normal;\n" +
                        "    -webkit-user-select: none;\n" +
                        "    cursor: pointer;\n" +
                        "    text-shadow: 1px 1px #fff;\n" +
                        "    font-weight: 700;\n" +
                        "    font-size: 10pt;width:90%;";
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
                    inputCheck.style = "color: black;\n" +
                        "    display: inline-block;\n" +
                        "    background: -webkit-linear-gradient(top, #f9f9f9, #e3e3e3);\n" +
                        "    border: 1px solid #999;\n" +
                        "    border-radius: 3px;\n" +
                        "    padding: 5px 8px;\n" +
                        "    outline: none;\n" +
                        "    white-space: normal;\n" +
                        "    -webkit-user-select: none;\n" +
                        "    cursor: pointer;\n" +
                        "    text-shadow: 1px 1px #fff;\n" +
                        "    font-weight: 700;\n" +
                        "    font-size: 10pt;width:90%;";
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
                    inputCheck.style = "color: black;\n" +
                        "    display: inline-block;\n" +
                        "    background: -webkit-linear-gradient(top, #f9f9f9, #e3e3e3);\n" +
                        "    border: 1px solid #999;\n" +
                        "    border-radius: 3px;\n" +
                        "    padding: 5px 8px;\n" +
                        "    outline: none;\n" +
                        "    white-space: normal;\n" +
                        "    -webkit-user-select: none;\n" +
                        "    cursor: pointer;\n" +
                        "    text-shadow: 1px 1px #fff;\n" +
                        "    font-weight: 700;\n" +
                        "    font-size: 10pt; width:90%;";
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
        }).then(async () => {
            await $.ajax({
                url: "ajax/z_getAllTables.php",
                method: "GET",
                data: {id_sub: openTabId},

            }).then(function (response) {

                let numTab = document.querySelector("#tab" + openTabId + "-");
                let rightCard = numTab.querySelector("#cardRight");
                let cardForAdding = rightCard.querySelector(":first-child");
                let cardForAdding1 = cardForAdding.querySelector(":first-child");
                if (cardForAdding1)
                    cardForAdding1.insertAdjacentHTML("afterbegin", response);


            }).fail(function (jqXHR, textStatus, errorThrown) {
                //
                console.log("AJAX Error: " + textStatus + ", " + errorThrown);
            }).then(() => {
                if (status == 2) {
                    let btnrename = document.getElementsByClassName("btn-rename");
                    let deleteicon = document.getElementsByClassName("delete-icon");
                    [...btnrename].forEach(item => {
                        item.classList.add("hiddentab");
                    });
                    [...deleteicon].forEach(item => {
                        item.classList.add("hiddentab");
                    })
                }
            });
        }).then(() => {
            $.ajax({
                url: "ajax/z_calc_subvision.php",
                method: "GET",
                data: {id_sub: openTabId, id_application: id_app}
            }).then((response) => {
                let thisTab = document.getElementById("tab" + openTabId + "-");
                let divMark = document.createElement("div");
                divMark.id = "markSub";
                let markSub = document.getElementById("markSub");
                if (markSub) {
                    markSub.remove();
                }
                divMark.style = "text-align: right;";

                divMark.innerHTML = "Самоаккредитация - " + Math.round(parseFloat(response).toFixed(2)) + "%";
                thisTab.appendChild(divMark);

            })
        })
    }

    if (idNum == "1") {

        $.ajax({
            url: "ajax/z_calc_application.php",
            method: "GET",
            data: {id_application: id_app}
        }).then((response) => {
            let mainRightCard = document.getElementById("mainRightCard");
            mainRightCard.innerHTML = "Самоакредитация - " + Math.round(parseFloat(response).toFixed(2)) + "%";
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


    let tabContent = document.getElementsByClassName("tab-content tab-transparent-content")[6];
    let tabPane = document.createElement("div");
    tabPane.className = "tab-pane fade show remAccTab";
    tabPane.id = "tab" + id_sub + "-";
    let row1 = document.createElement("div");
    row1.className = "row";
    let col12_1 = document.createElement("div");
    col12_1.className = "col-12 grid-margin";
    let cardLeft = document.createElement("div");
    cardLeft.className = "card";
    if (idRole === "15") {
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
    btnDelete.classList = "btn btn-danger";
    btnDelete.id = "delPodr";
    btnDelete.setAttribute("onclick", "deleteTab('" + id_sub + "')");
    btnDelete.style = "margin-bottom: 15px";
    if (idRole == 15) {

    } else {
        tabPane.appendChild(btnDelete);
    }


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


    if (status == 1) {

    } else {
        cardLeft.classList.add("rolledUp");
        aRollUp.setAttribute("disabled", "true");
        btnDelete.classList.add("hiddentab");
        container.classList.add("hiddentab");

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
                    addHistoryAction(id_application, getCookie('id_user'), 1, `Создано структурное подразделение ${nameTab}`, '', '')
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
        let department = prompt("Введите название отделения");
        if (department !== undefined && department.trim() !== '') {


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
                data: {
                    id_sub: openTabId,
                    id_list_tables_criteria: id_list_tables_criteria,
                    check: check,
                    department: department
                }
            })
                .done(function (response) {
                    // ОТОБРАЖЕНИЕ таблиц критериев по нажатию на чекбокс
                    let numTab = document.getElementById("tab" + openTabId + "-")

                    let chkbName = numTab.querySelector("#checkbox" + id_list_tables_criteria);
                    let lblName = chkbName.nextElementSibling.innerHTML;

                    let rightCard = numTab.querySelector("#cardRight");


                    let cardForAdding = rightCard.querySelector(":first-child");
                    let cardForAdding1 = cardForAdding.querySelector(":first-child");
                    if (cardForAdding1)
                        cardForAdding1.insertAdjacentHTML("afterbegin", response);


                    let nameTab = document.getElementById("button" + openTabId);
                    addHistoryAction(id_app, getCookie('id_user'), 2, `Добавлено отделение ${lblName} в структурное подразделение ${nameTab.innerText}`, openTabId, '')

                });
        } else {
            alert("Вы не ввели название отделения");
        }
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
                    let chkbName = numTab.querySelector("#checkbox" + id_list_tables_criteria);
                    let lblName = chkbName.nextElementSibling.innerHTML;
                    let nameTab = document.getElementById("button" + openTabId);
                    addHistoryAction(id_app, getCookie('id_user'), 2, `Удалено отделение ${lblName} из структурного подразделения ${nameTab.innerText}`, openTabId, '')

                    let tabActive = document.getElementById("tab" + openTabId + "-");
                    let checkboxes = tabActive.querySelectorAll("[id^='checkbox']");
                    checkboxes.forEach(function (checkbox) {
                        let buttonText = checkbox.innerText;
                        let colonIndex = buttonText.indexOf(":");
                        if (colonIndex !== -1) {
                            checkbox.innerText = buttonText.substring(0, colonIndex);
                        }
                    });


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
                if (response === "no") {
                    alert("Такое отделение уже существует");
                } else {
                    alert("Добавлено отделение");
                    let nameTab = document.getElementById("button" + openTabId);
                    addHistoryAction(id_app, getCookie('id_user'), 2, `Добавлено отделение ${department} в структурное подразделение ${nameTab.innerText}`, openTabId, '')

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
                    if (cardForAdding1)
                        cardForAdding1.insertAdjacentHTML("afterbegin", response);
                }
            });
    } else {
        alert("Вы не ввели название отделения");
    }
}

function newCollapseTable(thisDiv) {
    let card = thisDiv.parentElement;
    let thisCollapse = card.querySelector("#collapse" + thisDiv.id.substring(7));
    if (thisCollapse.classList.contains("show")) {
        thisCollapse.classList.remove("show");
    } else {
        thisCollapse.classList.add("show");
    }
    let noteCells = document.querySelectorAll('td[contenteditable="true"]');
    let selpickers = document.querySelectorAll("#selpicker");
    let fileInputs = document.querySelectorAll('input[type="file"]');
    let xDeleteFiles = document.getElementsByClassName("delete-file");
    if (status > 1) {

        [...xDeleteFiles].forEach(item => {
            item.style.display = "none";
        })

        selpickers.forEach((selpicker) => {
            selpicker.disabled = true;
        });

        fileInputs.forEach((fileInput) => {
            fileInput.disabled = true;
        });

        noteCells.forEach((noteCell) => {
            noteCell.removeAttribute("contenteditable");
        });
    } else {
        let selpickers = document.querySelectorAll("#selpicker");
        let fileInputs = document.querySelectorAll('input[type="file"]');

        selpickers.forEach((selpicker) => {
            selpicker.disabled = false;
        });

        fileInputs.forEach((fileInput) => {
            fileInput.disabled = false;
        });

        if (noteCells)
            noteCells.forEach((noteCell) => {
                noteCell.setAttribute("contenteditable", "true");
            });

    }
}

function changeField3(idCrit, idDep, select) {
    $.ajax({
        url: "ajax/changeField3.php",
        method: "GET",
        data: {idCrit: idCrit, idDep: idDep, val: select.options[select.selectedIndex].value, id_sub: openTabId}
    })
        .done(function (response) {

        })
}

function changeField5(idCrit, idDep, text) {
    $.ajax({
        url: "ajax/changeField5.php",
        method: "GET",
        data: {idCrit: idCrit, idDep: idDep, text: text.innerText}
    }).done(function (response) {

    })
}

function addFile(idCrit, idDep, input) {
    let login = getCookie('login');

    let divA = document.getElementById(idCrit + "_" + idDep);
    let arrayDives = divA.childNodes;
    let arrayFiles = [];
    arrayDives.forEach(item => {
        arrayFiles.push(item.children[0].innerText)
    });
    let xhr = new XMLHttpRequest(),
        form = new FormData();
    let addedFile = input.files[0];
    let fileName = addedFile.name;
    if (arrayFiles.indexOf(fileName) < 0) {
        form.append("idCrit", idCrit);
        form.append("idApp", id_app);
        form.append("idDep", idDep);
        form.append("addedFile", addedFile);

        xhr.open("post", "ajax/changeField4.php", true);

        let load = document.createElement("div");
        // load.innerHTML = "Подождите, идет загрузка";
        divA.insertAdjacentElement("afterend", load);

        xhr.upload.onprogress = function (event) {
            if (event.lengthComputable) {
                let progress = (event.loaded / event.total) * 100;
                load.innerHTML = "Загрузка: " + Math.round(progress) + "%";
            }

        };

        xhr.upload.onloadstart = function () {

            let fileName = addedFile.name;
            let extAr = fileName.substring(fileName.lastIndexOf('.'), fileName.length);
            console.log(extAr);
            if (fileName.length > 120) {
                alert('Слишком длинное имя файла');
                xhr.abort();
            } else {
                if (extAr !== ".pdf" && extAr !== ".PDF" && extAr !== ".docx" && extAr !== ".DOCX" &&
                    extAr !== ".DOC" && extAr !== ".doc" && extAr !== ".XLSX" && extAr !== ".xlsx" &&
                    extAr !== ".XLS" && extAr !== ".xls") {
                    alert("Неверный формат. Допустимый формат pdf");
                    xhr.abort();
                } else {
                    load.innerHTML = "Подождите, идет загрузка";
                    input.disabled = "true";
                }
            }
        };

        xhr.upload.onload = function () {
            input.removeAttribute("disabled");
            load.remove();
            let fileContainer = document.createElement('div');
            fileContainer.classList.add('file-container');
            let fileLink = document.createElement('a');
            fileLink.href = `/docs/documents/${createrApp}/${id_app}/${idDep}/${addedFile.name}`;
            fileLink.textContent = addedFile.name;
            let deleteButton = document.createElement('span');
            deleteButton.classList.add('delete-file');
            deleteButton.textContent = '×';
            deleteButton.style.cursor = 'pointer';
            deleteButton.style.paddingLeft = '10px';
            deleteButton.id = 'delete_' + idCrit + '_' + idDep + '_' + addedFile.name;
            deleteButton.onclick = function () {
                z_deleteFile(addedFile.name, idCrit, idDep);
            };
            fileContainer.appendChild(fileLink);
            fileContainer.appendChild(deleteButton);
            divA.appendChild(fileContainer);
        }
        xhr.send(form);
    } else {
        alert("Файл с таким именем уже есть в этой ячейке");
    }
}


function z_deleteFile(fileName, idCrit, idDepartment) {
    if (confirm('Вы уверены, что хотите удалить этот файл?')) {
        let url = 'ajax/z_deleteFile.php?file_name=' + encodeURIComponent(fileName) + '&id_criteria=' + idCrit + '&id_department=' + idDepartment + '&id_application=' + id_app;
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
        let numTab = document.getElementById("tab" + openTabId + "-")
        let depName = numTab.querySelector("[aria-controls='collapse" + id_department + "']");
        let cutName;//= depName.innerHTML.substring(0, depName.innerHTML.lastIndexOf('('));
        if (depName.innerHTML.lastIndexOf('(') > 0) {
            cutName = depName.innerHTML.substring(0, depName.innerHTML.lastIndexOf('('));
        } else {
            cutName = depName.innerHTML
        }

        console.log(cutName);
        $.ajax({
            url: "ajax/z_getTableLevel.php",
            method: "GET",
            data: {id_sub: openTabId, id_department: id_department},
        }).done(function (response) {
            console.log("response", response);
            let parsedResponse = JSON.parse(response);
            console.log("response.level" + parsedResponse.level);
            if (parsedResponse.level == '1') {
                let tabActive = document.getElementById("tab" + openTabId + "-");
                let formCheckInput = document.getElementsByClassName("form-check-input");
                let formButton = document.getElementsByClassName("form-button");
                let inputCheck = tabActive.querySelector("#checkbox" + parsedResponse.id_list_tables_criteria);
                console.log("response.id_list_tables_criteria" + parsedResponse.id_list_tables_criteria);
                console.log("checl" + inputCheck);
                inputCheck.checked = false;
                toggleActiveCheckbox(inputCheck, formCheckInput, formButton);
            } else {
                $.ajax({
                    url: "ajax/z_deleteDepartment.php",
                    method: "GET",
                    data: {id_sub: openTabId, id_department: id_department},
                })
                    .done(function (response) {
                        console.log(response);

                        let id_list_tables_criteria = response;
                        let tabActive = document.getElementById("tab" + openTabId + "-");
                        let countButton = tabActive.querySelector("#checkbox" + id_list_tables_criteria);
                        if (!countButton.innerHTML) {
                            let rightCard = tabActive.querySelector("#cardRight");
                            rightCard.innerHTML = "";
                        } else {
                            let countText = countButton.innerText;
                            let countT = countText.split(":")[1];

                            if (countT) {
                                let count = countT.trim();
                                let newT = countText.replace(count, String(Number(count) - 1));

                                countButton.innerHTML = newT;
                            }
                        }
                        let cardH = document.getElementById("heading" + id_department);

                        let nameTab = document.getElementById("button" + openTabId);
                        addHistoryAction(id_app, getCookie('id_user'), 2, `Удалено отделение ${cutName} из структурного подразделения ${nameTab.innerText}`, openTabId, id_department)
                        if (cardH)
                            cardH.remove();
                        alert("Отделение удалено.");
                    })
                    .fail(function (error) {
                        console.error("Ошибка при удалении отдела:", error);
                    });
            }
        })
    }
}


function renameDepartment(id_department) {
    event.stopPropagation();
    let newDepartmentName = prompt("Введите новое название отделения:");
    if (newDepartmentName !== null && newDepartmentName.trim() !== "") {
        let numTab = document.getElementById("tab" + openTabId + "-")
        let depName = numTab.querySelector("[aria-controls='collapse" + id_department + "']");
        let cutName;//= depName.innerHTML.substring(0, depName.innerHTML.lastIndexOf('('));
        if (depName.innerHTML.lastIndexOf('(') > 0) {
            cutName = depName.innerHTML.substring(0, depName.innerHTML.lastIndexOf('('));
        } else {
            cutName = depName.innerHTML
        }
        $.ajax({
            url: "ajax/z_renameDepartment.php",
            method: "GET",
            data: {id_department: id_department, new_department_name: newDepartmentName, id_sub: openTabId},
        })
            .done(function (response) {
                console.log(response);
                let cardH = document.getElementById("heading" + id_department);
                let button = cardH.querySelector("button");

                let newText = response;
                button.innerText = newText;
                let nameTab = document.getElementById("button" + openTabId);
                addHistoryAction(id_app, getCookie('id_user'), 2, `Переименовано отделение ${cutName} на ${newDepartmentName} в структурном подразделении ${nameTab.innerText}`, openTabId, id_department)
                alert("Отделение переименовано.");
            })
            .fail(function (error) {
                console.error("Ошибка при переименовании отделения:", error);
            });
    } else {
        alert("Вы не написали название отделения")
    }
}


function printNewReport() {
    return new Promise((resolve, reject) => {
        let number_app = document.getElementById("id_application");
        let id_application = number_app.innerHTML;
        let criteriaMark = document.createElement('div');
        criteriaMark.textContent = 'Результат самоаккредитации ';
        criteriaMark.style = "padding-top: 0.5rem; padding-bottom:1rem; ";
        var WinPrint = window.open(`dddd`, ``, 'left=50,top=50,width=800,height=640,toolbar=0,scrollbars=1,status=0');
        WinPrint.document.write('<style> @page {\n' +
            'size: A4 landscape;\n' +
            'margin-bottom: 10mm;\n' +
            'margin-top: 8mm;\n' +
            'margin-left: 10mm;\n' +
            'margin-right: 5mm;\n' +
            '}' +
            'td{ max-width: 10vw;\n' +
            '  word-wrap: break-word;}</style>');

        let divContainer = document.createElement('div');
        divContainer.id = 'container';
        let divContent = document.createElement('div');
        divContent.id = 'content';
        divContent.style = 'max-height:250mm; margin-bottom: 20px;';
        let divFooter = document.createElement('div');
        divFooter.id = 'footer';
        divFooter.style = 'position:fixed; left: 0px; bottom: 0px; right: 0px; font-size:10px; margin-top: 5px;';
        divFooter.innerHTML = 'numeration';
        divContainer.appendChild(divContent);
        divContainer.appendChild(divFooter);


        let textSubCriteriaChecked = '';
        let divTextSubCriteriaChecked = document.createElement('div');
        divTextSubCriteriaChecked.style = "padding-top: 0.5rem; padding-bottom:1rem; font-size:2rem;";
        let headTable;
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
            headTable = createTableForPrintSamoAccred(subCriteriaForReport);

        }).then(() => {
            let mainRightCard = document.getElementById("mainRightCard");
            let mainRightCardText = mainRightCard.innerHTML;
            let naim = document.getElementById('naim');
            criteriaMark.textContent += `${naim.value}` + ` среднее значение групп критериев ` + mainRightCardText.substring(mainRightCardText.lastIndexOf('-') + 1, mainRightCardText.length);

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
        }).then((response) => {
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
            let divReportTitle2 = document.createElement('div');
            let divReportTitle3 = document.createElement('div');
            WinPrint.document.write('<style> th{font-weight: 500; }</style>');
            divReportTitle2.style = "padding-top: 0.5rem; font-size:1.4rem; padding-left:2rem; padding-right: 2rem; text-align:center";
            divReportTitle2.textContent = `Отчет о результатах самоаккредитации`;
            divReportTitle3.style = "padding-bottom:0.5rem; font-size:1.4rem; padding-left:2rem; padding-right: 2rem; text-align:center";
            divReportTitle3.textContent = `${naim.value}  ${formatDate(new Date())}`;
            divReportTitle.appendChild(divReportTitle2);
            divReportTitle.appendChild(divReportTitle3);
            WinPrint.document.write(divReportTitle.innerHTML);
            WinPrint.document.write('<br/>');
            // divTextSubCriteriaChecked.innerHTML = headTable;
            divTextSubCriteriaChecked.appendChild(headTable);
            WinPrint.document.write(divTextSubCriteriaChecked.innerHTML);
            WinPrint.document.write('<br/>');
            WinPrint.document.write(criteriaMark.innerText);

            WinPrint.document.write('<br/>');
            if (table && table.textContent && table.textContent.length > 0) {
                let divReportTitleFieldNo = document.createElement('div');
                let divReportTitleTableCriteriaAll = document.createElement('div');
                divReportTitleTableCriteriaAll.style = "display: inline-block ;padding-top: 0.5rem; padding-bottom:1rem; font-size:1.4rem; margin-top: 2rem; text-align: center";
                divReportTitleTableCriteriaAll.textContent = 'Сведения о соответствии базовым критериям медицинской аккредитации';
                divReportTitleFieldNo.appendChild(divReportTitleTableCriteriaAll);
                WinPrint.document.write(divReportTitleFieldNo.innerHTML);
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

                WinPrint.print();
                WinPrint.close();
            }
            WinPrint.document.close();
            WinPrint.focus();
            let naimOrg = document.getElementById("naim");
            WinPrint.document.title = "Отчет о самоаккредитации_" + naimOrg.value + "_" + new Date().toLocaleDateString().replaceAll(".", "");
            WinPrint.print();
            WinPrint.close();
            resolve();
        }).catch((error) => {
            console.error(error);
        });
    })

}


function createTableForPrintSamoAccred(valueRespons) {

    let divPrintTable = document.createElement('div');

    let table = document.createElement('table');
    table.style = "border-collapse: collapse; border-spacing: 0;width:100%";


    let trHeadMain = document.createElement('tr');
    trHeadMain.style = "font-style: normal"

    let th1 = document.createElement('th');
    th1.innerHTML = '№ п/п';
    th1.style = "border: 1px solid black; width: 10%; font-style: normal";

    let th2 = document.createElement('th');
    th2.innerHTML = 'Название подразделения';
    th2.style = "border: 1px solid black; width: 40%; font-style: normal";

    let th3 = document.createElement('th');
    th3.innerHTML = 'Группа критериев (полное название критерия)';
    th3.style = "border: 1px solid black; width: 30%; font-style: normal";


    let th4 = document.createElement('th');
    th4.innerHTML = 'Результат самоаккредитации,%';
    th4.style = "border: 1px solid black; width: 20%; font-style: normal";


    trHeadMain.appendChild(th1);
    trHeadMain.appendChild(th2);
    trHeadMain.appendChild(th3);
    trHeadMain.appendChild(th4);


    table.appendChild(trHeadMain);


    let tbody = document.createElement('tbody');
    table.appendChild(tbody);


    let id_s = -1;
    let num = 1;
    valueRespons.map((item, index) => {

        if (id_s !== item['id_subvision']) {


            let trNaim = document.createElement('tr');
            let tdNaim = document.createElement('td');
            tdNaim.setAttribute('colspan', '4');
            tdNaim.style = "border: 1px solid black; padding-top: 0.5rem; padding-bottom:0.5rem; padding-left: 2rem; font-weight: bold";
            tdNaim.innerHTML = item['name'];
            trNaim.appendChild(tdNaim);
            tbody.appendChild(trNaim);


            id_s = item['id_subvision'];
        }

        if (id_s == item['id_subvision']) {
            let trNaim2 = document.createElement('tr');
            let tdOtdel1 = document.createElement('td');
            // tdNaim2.setAttribute('colspan', '4');
            tdOtdel1.style = "border: 1px solid black;padding-top: 0.25rem; padding-bottom:0.25rem; text-align: center; vertical-align: baseline";
            tdOtdel1.innerHTML = `${num}`;

            let tdOtdel2 = document.createElement('td');
            tdOtdel2.style = "border: 1px solid black;padding-top: 0.25rem; padding-bottom:0.25rem; padding-left: 0.3rem; vertical-align: baseline";
            let strNameOtdel = '';
            if (item['name_otdel'] !== null) {
                if (item['name_otdel'].indexOf('(') > 0) {
                    strNameOtdel = item['name_otdel'].substring(0, item['name_otdel'].indexOf('(') - 1)
                } else {
                    strNameOtdel = item['name_otdel']
                }
            }

            tdOtdel2.innerHTML = strNameOtdel;

            let tdOtdel3 = document.createElement('td');
            tdOtdel3.style = "border: 1px solid black;padding-top: 0.25rem; padding-bottom:0.25rem;padding-left: 0.3rem; vertical-align: baseline";
            tdOtdel3.innerHTML = item['name_full'];

            let tdOtdel4 = document.createElement('td');
            tdOtdel4.style = "border: 1px solid black;padding-top: 0.25rem; padding-bottom:0.25rem; padding-left: 0.3rem; vertical-align: baseline";
            tdOtdel4.innerHTML = Math.round(parseFloat(item['mark_dpercent']).toFixed(2)) + '%';

            trNaim2.appendChild(tdOtdel1);
            trNaim2.appendChild(tdOtdel2);
            trNaim2.appendChild(tdOtdel3);
            trNaim2.appendChild(tdOtdel4);
            tbody.appendChild(trNaim2);


            num += 1;

        }
        // else {
        //     if (subCriteriaForReport[index + 1]['name'] && subCriteriaForReport[index]['name'] !== subCriteriaForReport[index + 1]['name'])
        //         as += item['name_otdel'] == null ? 'не выбраны отделения' : item['name_otdel'] + ` ${parseFloat(item['mark_dpercent']).toFixed(2)}%` + ".";
        //     else
        //         as += item['name_otdel'] == null ? 'не выбраны отделения' : item['name_otdel'] + ` ${parseFloat(item['mark_dpercent']).toFixed(2)}%` + ", ";
        // }
    });


    divPrintTable.appendChild(table);

    return divPrintTable;
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
    th1_Main.innerHTML = 'Наименование критерия';
    th1_Main.style = "border: 1px solid black; ";
    th1_Main.setAttribute('rowspan', '2');
    /*
        let th2_Main = document.createElement('th');
        th2_Main.innerHTML = 'Класс критерия';
        th2_Main.style = "border: 1px solid black";
        th2_Main.setAttribute('rowspan','2');
    */

    let th3_Main = document.createElement('th');
    th3_Main.innerHTML = 'Сведения о соблюдении критериев (самоакредитация)';
    th3_Main.style = "border: 1px solid black; text-align: center";
    th3_Main.setAttribute('colspan', '3');


    let trHead = document.createElement('tr');
    let th3 = document.createElement('th');
    th3.innerHTML = 'Сведения по самоаккредитации (да, нет, не применяется)';
    th3.style = "border: 1px solid black";

    let th4 = document.createElement('th');
    th4.innerHTML = 'Документы и сведения, на основании которых проведена самоакредитация';
    th4.style = "width: 25%;    word-break: break-word; border: 1px solid black";


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
            th1_Main2.innerHTML = 'Наименование критерия';
            th1_Main2.style = "border: 1px solid black";
            th1_Main2.setAttribute('rowspan', '2');
            /*
                            let th2_Main2 = document.createElement('td');
                            th2_Main2.innerHTML = 'Класс критерия';
                            th2_Main2.style = "border: 1px solid black";
                            th2_Main2.setAttribute('rowspan','2');
            */

            let th3_Main2 = document.createElement('td');
            th3_Main2.innerHTML = 'Сведения о соблюдении критериев (самоакредитация)';
            th3_Main2.style = "border: 1px solid black; text-align: center";
            th3_Main2.setAttribute('colspan', '3');


            let trHead2 = document.createElement('tr');
            let th32 = document.createElement('td');
            th32.innerHTML = 'Сведения по самоаккредитации (да, нет, не применяется)';
            th32.style = "border: 1px solid black";

            let th42 = document.createElement('td');
            th42.innerHTML = 'Документы и сведения, на основании которых проведена самоакредитация';
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

async function printAppForm() {
    return new Promise((resolve, reject) => {
        $.ajax({
            url: "ajax/z_createFormApplication.php",
            method: "GET",
            data: {id_application: id_app}
        }).then((response) => {
            var WinPrint = window.open('', '', 'left=50,top=50,width=1200,height=860,toolbar=0,scrollbars=1,status=0');
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

async function sendApp() {

    let id_application = document.getElementById("id_application");
    let divSoprovodPismo = document.getElementById("divSoprovodPismo");
    let divCopyRaspisanie = document.getElementById("divCopyRaspisanie");
    let divOrgStrukt = document.getElementById("divOrgStrukt");
    let divFileReportSamoocenka = document.getElementById("divFileReportSamoocenka");

    let sokr = document.getElementById("sokr");
    let unp = document.getElementById("unp");
    let adress = document.getElementById("adress");
    let adressFact = document.getElementById("adressFact");
    let tel = document.getElementById("tel");
    let email = document.getElementById("email");
    let rukovoditel = document.getElementById("rukovoditel");
    let predstavitel = document.getElementById("predstavitel");

    let isSend = confirm("После отправления заявки, редактирование будет невозможно. Отправить?");
    if (isSend) {

        $.ajax({
            url: "ajax/validateFieldsBeforeSendApp.php",
            method: "GET",
            data: {id_application: id_application.innerText}
        }).then(response => {
            let objects = JSON.parse(response);
            if (objects.length === 0) {
                let licoSelect = document.getElementById("lico");
                let licoSelectlicoSelectalue = licoSelect.options.selectedIndex;
                let divPrikazNaznach = document.getElementById("divPrikazNaznach");
                let divDoverennost = document.getElementById("divDoverennost");
                let doverennostSel = divDoverennost.getElementsByTagName("a")[0];
                let prikazNaznachSel = divPrikazNaznach.getElementsByTagName("a")[0];

                // ||
                //     divFileReportSamoocenka.getElementsByTagName("a").length == 0
                if (
                    divCopyRaspisanie.getElementsByTagName("a").length == 0
                ) {
                    alert("Не все обязательные документы загружены! Заявление не отправлено.");
                } else if (sokr.value.trim() === "" ||
                    unp.value.trim() === "" ||
                    adress.value.trim() === "" ||
                    adressFact.value.trim() === "" ||
                    tel.value.trim() === "" ||
                    email.value.trim() === "" ||
                    licoSelectlicoSelectalue === 0 ||
                    ((licoSelectlicoSelectalue === 1 && (rukovoditel.value.trim() === "" || prikazNaznachSel === undefined)) ||
                        (licoSelectlicoSelectalue === 2 && (predstavitel.value.trim() === "" || doverennostSel === undefined)))
                ) {
                    alert("Не все обязательные поля заполнены.");

                } else {
                    // printAppForm().then(() => {
                    //     printNewReport().then(() => {
                    $.ajax({
                        url: "ajax/newSendApp.php",
                        method: "GET",
                        data: {id_application: id_application.innerText}
                    })
                        .done(function (response) {
                            if (response === "") {
                                addHistoryAction(id_app, getCookie('id_user'), 1, `Заявление № ${id_app} отправлено`, "", "")
                                alert("Заявление отправлено");
                                location.href = "/index.php?application";
                            } else {
                                alert(response);
                            }
                        });
                    //     })
                    // })


                }
            } else {
                let errMsg = "Допущена ошибка: ";
                let tmpSub = 0;
                let tmpDep = 0;
                objects.map((item) => {

                    if (tmpSub !== item['id_sub']) {
                        errMsg += "\nПодразделение " + item['sub_name'] + ": ";
                    }

                    if (tmpDep !== item['id_department'] && item['id_department'] !== null) {
                        errMsg += "\nОтделение " + item['dep_name'] + ": \n Критерии: ";
                    }

                    if (item['id_department'] === null) {
                        errMsg += 'Нет информации по подразделению'
                    }

                    tmpDep = item['id_department'];
                    tmpSub = item['id_sub'];

                    if (item['pp'] !== null) {
                        errMsg += item['pp'] + ", ";
                    }


                })
                errMsg = errMsg.substring(0, errMsg.length - 2)
                alert(errMsg);
            }
        })
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

function saveCommon(idApp, text, fieldNum) {
    $.ajax({
        url: "ajax/z_saveUcompFieldCommon.php",
        method: "GET",
        data: {idApp: idApp, fieldNum: fieldNum, text: text.innerText.replace(/[^\w\s\+\-%,.]/gi, '')}
    }).then(function (response) {
        let modalUcomplect = document.getElementById("modalUcomplect");
        let modalBody = modalUcomplect.getE("modal-body")[0];

        $.ajax({
            url: "ajax/z_ucomplectTable.php",
            method: "GET",
            data: {id_application: id_app}
        }).then((response) => {
            modalBody.innerHTML = response;
        })
    })
}


function onInputAdressFact() {
    const input = document.getElementById('adressFact');
    if (isAdressValid(input.value)) {
        input.style.borderColor = 'green';
    } else {
        input.style.borderColor = 'green';
    }
}

function printModalContent() {
    var modalBody = document.getElementById('modalUcomplect').querySelector('.modal-body');
    var printWindow = window.open('', '', 'width=1500,height=1100');
    printWindow.document.open();
    printWindow.document.write('<html><head><title>Укомплектованность</title></head><body>');
    printWindow.document.write(modalBody.innerHTML);
    printWindow.document.write('</body></html>');
    printWindow.document.close();
    printWindow.print();
    printWindow.close();
}

function checkUserRole() {
    const inputFieldSokrNaim = document.getElementById("sokr");
    const inputFieldunp = document.getElementById("unp");
    const inputFieldadress = document.getElementById("adress");
    const inputFieldadressFact = document.getElementById("adressFact");
    const inputFieldtel = document.getElementById("tel");
    const inputFieldemail = document.getElementById("email");
    const inputFieldrukovoditel = document.getElementById("rukovoditel");
    const inputFieldpredstavitel = document.getElementById("predstavitel");
    const inputFieldcopyRaspisanie = document.getElementById("copyRaspisanie");
    const inputFieldtechOsn = document.getElementById("techOsn");
    const inputFieldreportSamoocenka = document.getElementById("reportSamoocenka");
    const ownUcompBtn = document.getElementsByClassName("ownUcomp")[0];
    const lico = document.getElementById("lico");

    console.log(idRole);
    if (idRole === "15") {
        inputFieldSokrNaim.disabled = true;
        inputFieldunp.disabled = true;
        inputFieldadress.disabled = true;
        inputFieldadressFact.disabled = true;
        inputFieldtel.disabled = true;
        inputFieldemail.disabled = true;
        inputFieldrukovoditel.disabled = true;
        inputFieldpredstavitel.disabled = true;
        inputFieldcopyRaspisanie.disabled = true;
        inputFieldtechOsn.disabled = true;
        inputFieldreportSamoocenka.disabled = true;
        ownUcompBtn.disabled = true;
        lico.disabled = true;


    } else {

        inputFieldSokrNaim.disabled = false;
        inputFieldunp.disabled = false;
        inputFieldadress.disabled = false;
        inputFieldadressFact.disabled = false;
        inputFieldtel.disabled = false;
        inputFieldemail.disabled = false;
        inputFieldrukovoditel.disabled = false;
        inputFieldpredstavitel.disabled = false;
        inputFieldcopyRaspisanie.disabled = false;
        inputFieldtechOsn.disabled = false;
        inputFieldreportSamoocenka.disabled = false;
        ownUcompBtn.disabled = false;
        lico.disabled = false;
    }
}

document.getElementById("btnFormApplication").onclick = async function () {
    await printAppForm();
};

function chengeLico(select) {
    switch (select.options[select.selectedIndex].value) {
        case "1":
            rukDiv.classList.remove("hiddentab");
            predDiv.classList.add("hiddentab");
            formDoverennost.classList.add("hiddentab");
            formPrikazNaznach.classList.remove("hiddentab");
            break;
        case "2":
            predDiv.classList.remove("hiddentab");
            rukDiv.classList.add("hiddentab");
            formDoverennost.classList.remove("hiddentab");
            formPrikazNaznach.classList.add("hiddentab");
            break;
        case "0":
            predDiv.classList.add("hiddentab");
            rukDiv.classList.add("hiddentab");
            formDoverennost.classList.add("hiddentab");
            formPrikazNaznach.classList.add("hiddentab");
            break;
    }
}

$("#doverennost").on("change", () => {
    let login = getCookie('login');
    let divTechOsn = document.getElementById("divDoverennost");
    let sopr = divTechOsn.getElementsByTagName("a")[0];
    if (sopr) {
        sopr.remove();
    }
    let techOsn = document.getElementById("doverennost");
    techOsn.insertAdjacentHTML("afterend", "<a target='_blank' href='/docs/documents/" + login + "/" + id_app + "/" + techOsn.files[0].name + "'>" + techOsn.files[0].name + "</a>");

    let id_application = document.getElementById("id_application");

    let xhr = new XMLHttpRequest(),
        form = new FormData();
    let techOsnFile = techOsn.files[0];
    form.append("id_application", id_application.innerText);
    form.append("doverennost", techOsnFile);

    xhr.open("post", "ajax/postFileDoverennost.php", true);
    // let techOsndiv = document.getElementById("techOsndiv");
    // if (techOsndiv) {
    //     techOsndiv.remove();
    // }
    let loadSopr = document.getElementById("loadDoverennost");
    if (loadSopr) {
        loadSopr.remove();
    }
    let load = document.createElement("div");
    load.innerHTML = "Подождите, идет загрузка";
    load.id = "loadDoverennost";
    techOsn.insertAdjacentElement("afterend", load);

    xhr.upload.onprogress = function (event) {
        if (event.lengthComputable) {
            let progress = (event.loaded / event.total) * 100;
            load.innerHTML = "Загрузка: " + Math.round(progress) + "%";
        }
    };

    xhr.upload.onloadstart = function () {
        load.innerHTML = "Подождите, идет загрузка";
    };
    xhr.upload.onload = function () {
        load.innerHTML = "Файл загружен";
    }
    xhr.send(form);
});

$("#prikazNaznach").on("change", () => {
    let login = getCookie('login');
    let divTechOsn = document.getElementById("divPrikazNaznach");
    let sopr = divTechOsn.getElementsByTagName("a")[0];
    if (sopr) {
        sopr.remove();
    }
    let techOsn = document.getElementById("prikazNaznach");
    techOsn.insertAdjacentHTML("afterend", "<a target='_blank' href='/docs/documents/" + login + "/" + id_app + "/" + techOsn.files[0].name + "'>" + techOsn.files[0].name + "</a>");

    let id_application = document.getElementById("id_application");

    let xhr = new XMLHttpRequest(),
        form = new FormData();
    let techOsnFile = techOsn.files[0];
    form.append("id_application", id_application.innerText);
    form.append("prikazNaznach", techOsnFile);

    xhr.open("post", "ajax/postFilePrikazNaznach.php", true);
    // let techOsndiv = document.getElementById("techOsndiv");
    // if (techOsndiv) {
    //     techOsndiv.remove();
    // }
    let loadSopr = document.getElementById("loadPrikazNaznach");
    if (loadSopr) {
        loadSopr.remove();
    }
    let load = document.createElement("div");
    load.innerHTML = "Подождите, идет загрузка";
    load.id = "loadPrikazNaznach";
    techOsn.insertAdjacentElement("afterend", load);

    xhr.upload.onprogress = function (event) {
        if (event.lengthComputable) {
            let progress = (event.loaded / event.total) * 100;
            load.innerHTML = "Загрузка: " + Math.round(progress) + "%";
        }
    };

    xhr.upload.onloadstart = function () {
        load.innerHTML = "Подождите, идет загрузка";
    };
    xhr.upload.onload = function () {
        load.innerHTML = "Файл загружен";
    }
    xhr.send(form);
});


//
// $("#btnSend").on("click", async () =>{
//     if(this.id === "newBtnSend") {
//         await sendApp(id_app);
//     }else {
//
//     }
// })

// new Promise(((resolve, reject) => {
//     setTimeout(() => {
//         let files = document.getElementsByClassName("form-control-file");
//         for (let i = 0; i < files.length; i++) {
//             files[i].disabled = "true";
//             console.log(files[i]);
//         }
//     }, 3000);
// }))

