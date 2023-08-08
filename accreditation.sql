-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Авг 08 2023 г., 11:16
-- Версия сервера: 8.0.30
-- Версия PHP: 8.0.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `accreditation`
--

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`%` PROCEDURE `callc_criteria` (IN `id_app` INT, IN `id_sub` INT, IN `id_crit` INT)   BEGIN

delete from report_criteria_mark
where id_application = id_app and
id_subvision =id_sub and 
id_criteria = id_crit;

CREATE TEMPORARY table temp_criteria_sub (id_sub int, mark_class int, id_criteria int, id_mark int, field4 int);
insert into temp_criteria_sub (id_sub , mark_class , id_criteria , id_mark , field4)
SELECT sub.id_subvision, case when m.mark_class is null then 0 else m.mark_class end, rc.id_criteria, m.id_mark,
case when mr.field4 is null then 0 else mr.field4 end
FROM `subvision` sub
left outer join rating_criteria rc on sub.id_subvision=rc.id_subvision
left outer join mark m on rc.id_criteria=m.id_criteria
left outer join mark_rating mr on sub.id_subvision=mr.id_subvision and m.id_mark=mr.id_mark
left outer join applications a on sub.id_application=a.id_application
WHERE sub.id_subvision= id_sub and 
m.id_criteria=id_crit and m.id_mark is not null and (m.date_close is null or (m.date_close is not null and ( m.date_close > IFNULL(a.date_send, CURDATE()) )));

set @all_mark = 0;
set @all_mark_3 = 0;
set  @all_mark_1 =0;
set @otmetka_all =0;

set @all_mark_class_1 = 0;
set @all_mark_3_class_1= 0;
set  @all_mark_1_class_1 =0;
set @otmetka_all_class_1 =0;

set @all_mark_class_2 = 0;
set @all_mark_3_class_2 = 0;
set  @all_mark_1_class_2 =0;
set @otmetka_all_class_2=0;

set @all_mark_class_3 = 0;
set @all_mark_3_class_3 = 0;
set  @all_mark_1_class_3 =0;
set @otmetka_all_class_3=0;

set @all_mark = (select count(*)
from temp_criteria_sub);

set @all_mark_3 = ( select count(*)
from temp_criteria_sub
where field4 =3);

set  @all_mark_1 =( select count(*)
from temp_criteria_sub
where field4 =1);

set @otmetka_all =  (@all_mark_1/(@all_mark-@all_mark_3))*100;

set @all_mark_class_1 = (select  count(*)
from temp_criteria_sub
where mark_class=1);


set @all_mark_3_class_1=(select count(*)
from temp_criteria_sub
where field4 =3 and  mark_class=1);

set @all_mark_1_class_1 =(select  count(*)
from temp_criteria_sub
where field4 =1 and  mark_class=1);

set @otmetka_all_class_1 = (@all_mark_1_class_1/(@all_mark_class_1-@all_mark_3_class_1))*100;

set @all_mark_class_2 = (select  count(*)
from temp_criteria_sub
where mark_class=2);


set @all_mark_3_class_2 = (select count(*)
from temp_criteria_sub
where field4 =3 and  mark_class=2);

set @all_mark_1_class_2 = (select count(*) 
from temp_criteria_sub
where field4 =1 and  mark_class=2);

set @otmetka_all_class_2 = (@all_mark_1_class_2/(@all_mark_class_2-@all_mark_3_class_2))*100;

set @all_mark_class_3 = (select count(*)
from temp_criteria_sub
where mark_class=3);


set @all_mark_3_class_3 =(select  count(*)
from temp_criteria_sub
where field4 =3 and  mark_class=3);

set @all_mark_1_class_3= (select  count(*)
from temp_criteria_sub
where field4 =1 and  mark_class=3);

set @otmetka_all_class_3 = (@all_mark_1_class_3/(@all_mark_class_3-@all_mark_3_class_3))*100;

INSERT INTO report_criteria_mark(id_application, id_subvision, id_criteria, otmetka_all, otmetka_all_count_yes, otmetka_all_count_all, otmetka_all_count_not_need, otmetka_class_1, otmetka_class_1_count_yes, otmetka_class_1_count_all, otmetka_class_1_count_not_need,otmetka_class_2, otmetka_class_2_count_yes, otmetka_class_2_count_all, otmetka_class_2_count_not_need,otmetka_class_3,otmetka_class_3_count_yes, otmetka_class_3_count_all, otmetka_class_3_count_not_need) 
VALUES(id_app, id_sub, id_crit, IFNULL(@otmetka_all,0),
IFNULL(@all_mark_1,0),IFNULL(@all_mark,0),IFNULL(@all_mark_3,0), IFNULL(@otmetka_all_class_1,0), 
IFNULL(@all_mark_1_class_1,0),IFNULL(@all_mark_class_1,0),IFNULL(@all_mark_3_class_1,0),
IFNULL(@otmetka_all_class_2,0), 
IFNULL(@all_mark_1_class_2,0),IFNULL(@all_mark_class_2,0),IFNULL(@all_mark_3_class_2,0),
IFNULL(@otmetka_all_class_3,0),
IFNULL(@all_mark_1_class_3,0),IFNULL(@all_mark_class_3,0),IFNULL(@all_mark_3_class_3,0));

DROP TEMPORARY TABLE temp_criteria_sub;

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `cursor_for_application` (IN `id_app` INT)   BEGIN

update applications
set activ_cursor=true
where id_application=id_app;

delete
from report_application_mark
where id_application= id_app;

delete
from report_subvision_mark
where id_application= id_app;

delete
from report_criteria_mark
where id_application= id_app;

CREATE TEMPORARY table temp_criteria (id_sub int, mark_class int, id_criteria int, id_mark int, field4 int);

insert into temp_criteria (id_sub , mark_class , id_criteria , id_mark , field4)
SELECT sub.id_subvision, case when m.mark_class is null then 0 else m.mark_class end, rc.id_criteria, m.id_mark,
case when mr.field4 is null then 0 else mr.field4 end
FROM `subvision` sub
left outer join rating_criteria rc on sub.id_subvision=rc.id_subvision
left outer join mark m on rc.id_criteria=m.id_criteria
left outer join mark_rating mr on sub.id_subvision=mr.id_subvision and m.id_mark=mr.id_mark
left outer join applications a on sub.id_application=a.id_application
WHERE sub.id_application= id_app and m.id_mark is not null and (m.date_close is null or (m.date_close is not null and ( m.date_close > IFNULL(a.date_send, CURDATE()) )));


set @all_mark = (select count(*)
from temp_criteria);

set @all_mark_3 = ( select count(*)
from temp_criteria
where field4 =3);

set  @all_mark_1 =( select count(*)
from temp_criteria
where field4 =1);

set @otmetka_all =  (@all_mark_1/(@all_mark-@all_mark_3))*100;

set @all_mark_class_1 = (select  count(*)
from temp_criteria
where mark_class=1);


set @all_mark_3_class_1=(select count(*)
from temp_criteria
where field4 =3 and  mark_class=1);

set @all_mark_1_class_1 =(select  count(*)
from temp_criteria
where field4 =1 and  mark_class=1);

set @otmetka_all_class_1 = (@all_mark_1_class_1/(@all_mark_class_1-@all_mark_3_class_1))*100;


set @all_mark_class_2 = (select  count(*)
from temp_criteria
where mark_class=2);


set @all_mark_3_class_2 = (select count(*)
from temp_criteria
where field4 =3 and  mark_class=2);

set @all_mark_1_class_2 = (select count(*) 
from temp_criteria
where field4 =1 and  mark_class=2);

set @otmetka_all_class_2 = (@all_mark_1_class_2/(@all_mark_class_2-@all_mark_3_class_2))*100;

set @all_mark_class_3 = (select count(*)
from temp_criteria
where mark_class=3);


set @all_mark_3_class_3 =(select  count(*)
from temp_criteria
where field4 =3 and  mark_class=3);

set @all_mark_1_class_3= (select  count(*)
from temp_criteria
where field4 =1 and  mark_class=3);

set @otmetka_all_class_3 = (@all_mark_1_class_3/(@all_mark_class_3-@all_mark_3_class_3))*100;

INSERT INTO report_application_mark(id_application, otmetka_all, otmetka_all_count_yes, otmetka_all_count_all, otmetka_all_count_not_need, otmetka_class_1, otmetka_class_1_count_yes, otmetka_class_1_count_all, otmetka_class_1_count_not_need,otmetka_class_2, otmetka_class_2_count_yes, otmetka_class_2_count_all, otmetka_class_2_count_not_need,otmetka_class_3,otmetka_class_3_count_yes, otmetka_class_3_count_all, otmetka_class_3_count_not_need) 
VALUES(id_app,  IFNULL(@otmetka_all,0),
IFNULL(@all_mark_1,0),IFNULL(@all_mark,0),IFNULL(@all_mark_3,0), IFNULL(@otmetka_all_class_1,0), 
IFNULL(@all_mark_1_class_1,0),IFNULL(@all_mark_class_1,0),IFNULL(@all_mark_3_class_1,0),
IFNULL(@otmetka_all_class_2,0), 
IFNULL(@all_mark_1_class_2,0),IFNULL(@all_mark_class_2,0),IFNULL(@all_mark_3_class_2,0),
IFNULL(@otmetka_all_class_3,0),
IFNULL(@all_mark_1_class_3,0),IFNULL(@all_mark_class_3,0),IFNULL(@all_mark_3_class_3,0));

DROP TEMPORARY TABLE temp_criteria;

call cursor_for_subvision(id_app);

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `cursor_for_application_acred` (IN `id_app` INT)   BEGIN


CREATE TEMPORARY table temp_criteria (id_sub int, mark_class int, id_criteria int, id_mark int, field7 int, field4 int);

insert into temp_criteria (id_sub , mark_class , id_criteria , id_mark , field7, field4)
SELECT sub.id_subvision, case when m.mark_class is null then 0 else m.mark_class end, rc.id_criteria, m.id_mark,
case when mr.field7 is null then 0 else mr.field7 end,
case when mr.field4 is null then 0 else mr.field4 end
FROM `subvision` sub
left outer join rating_criteria rc on sub.id_subvision=rc.id_subvision
left outer join mark m on rc.id_criteria=m.id_criteria
left outer join mark_rating mr on sub.id_subvision=mr.id_subvision and m.id_mark=mr.id_mark
left outer join applications a on sub.id_application=a.id_application
WHERE sub.id_application= id_app and m.id_mark is not null and (m.date_close is null or (m.date_close is not null and ( m.date_close > a.date_send))) and (m.date_open is null or (m.date_open is not null and (m.date_open <= a.date_send )));

set @all_mark = (select count(*)
from temp_criteria);

set @all_mark_3 = ( select count(*)
from temp_criteria
where field7 =3);

set  @all_mark_1 =( select count(*)
from temp_criteria
where field7 =1);

set @mark_verif = (select count(*)
from temp_criteria
where field7<>field4
);

set @otmetka_verif =  (@mark_verif /(@all_mark-@all_mark_3))*100;

set @otmetka_all =  (@all_mark_1/(@all_mark-@all_mark_3))*100;

set @all_mark_class_1 = (select  count(*)
from temp_criteria
where mark_class=1);


set @all_mark_3_class_1=(select count(*)
from temp_criteria
where field7 =3 and  mark_class=1);

set @all_mark_1_class_1 =(select  count(*)
from temp_criteria
where field7 =1 and  mark_class=1);

set @otmetka_all_class_1 = (@all_mark_1_class_1/(@all_mark_class_1-@all_mark_3_class_1))*100;


set @all_mark_class_2 = (select  count(*)
from temp_criteria
where mark_class=2);


set @all_mark_3_class_2 = (select count(*)
from temp_criteria
where field7 =3 and  mark_class=2);

set @all_mark_1_class_2 = (select count(*) 
from temp_criteria
where field7 =1 and  mark_class=2);

set @otmetka_all_class_2 = (@all_mark_1_class_2/(@all_mark_class_2-@all_mark_3_class_2))*100;

set @all_mark_class_3 = (select count(*)
from temp_criteria
where mark_class=3);


set @all_mark_3_class_3 =(select  count(*)
from temp_criteria
where field7 =3 and  mark_class=3);

set @all_mark_1_class_3= (select  count(*)
from temp_criteria
where field7 =1 and  mark_class=3);

set @otmetka_all_class_3 = (@all_mark_1_class_3/(@all_mark_class_3-@all_mark_3_class_3))*100;

update report_application_mark
set otmetka_accred_all = IFNULL(@otmetka_all,0), 
otmetka_accred_all_count_yes=IFNULL(@all_mark_1,0), 
otmetka_accred_all_count_all=IFNULL(@all_mark,0),
otmetka_accred_all_count_not_need=IFNULL(@all_mark_3,0),
otmetka_accred_class_1=IFNULL(@otmetka_all_class_1,0), 
otmetka_accred_class_1_count_yes=IFNULL(@all_mark_1_class_1,0),otmetka_accred_class_1_count_all=IFNULL(@all_mark_class_1,0), otmetka_accred_class_1_count_not_need=IFNULL(@all_mark_3_class_1,0),
otmetka_accred_class_2=IFNULL(@otmetka_all_class_2,0), 
otmetka_accred_class_2_count_yes= 
IFNULL(@all_mark_1_class_2,0),otmetka_accred_class_2_count_all=IFNULL(@all_mark_class_2,0),
otmetka_accred_class_2_count_not_need=IFNULL(@all_mark_3_class_2,0),
otmetka_accred_class_3=IFNULL(@otmetka_all_class_3,0),

otmetka_accred_class_3_count_yes=IFNULL(@all_mark_1_class_3,0),
otmetka_accred_class_3_count_all= IFNULL(@all_mark_class_3,0),otmetka_accred_class_3_count_not_need=IFNULL(@all_mark_3_class_3,0),
otmetka_verif=IFNULL(@otmetka_verif,0),
otmetka_verif_count_yes= IFNULL(@mark_verif,0),otmetka_verif_count_all= IFNULL(@all_mark,0),otmetka_verif_count_not_need=IFNULL(@all_mark_3,0)
where id_application=id_app;

DROP TEMPORARY TABLE temp_criteria;

call cursor_for_subvision_acred(id_app);

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `cursor_for_criteria` (IN `id_app` INT, IN `id_sub` INT)   BEGIN
DECLARE is_done_criteria integer default 0;
DECLARE id_criteria_temp integer default 0;

DECLARE criteria_cursor CURSOR FOR
SELECT DISTINCT rc.id_criteria
FROM rating_criteria rc
WHERE rc.id_subvision=id_sub;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET is_done_criteria = 1;
OPEN criteria_cursor;

get_Criteria: LOOP
FETCH criteria_cursor INTO id_criteria_temp;
IF is_done_criteria = 1 THEN 
LEAVE get_Criteria;
END IF;


CREATE TEMPORARY table temp_criteria_sub (id_sub int, mark_class int, id_criteria int, id_mark int, field4 int);


insert into temp_criteria_sub (id_sub , mark_class , id_criteria , id_mark , field4)
SELECT sub.id_subvision, case when m.mark_class is null then 0 else m.mark_class end, rc.id_criteria, m.id_mark,
case when mr.field4 is null then 0 else mr.field4 end
FROM `subvision` sub
left outer join rating_criteria rc on sub.id_subvision=rc.id_subvision
left outer join mark m on rc.id_criteria=m.id_criteria
left outer join mark_rating mr on sub.id_subvision=mr.id_subvision and m.id_mark=mr.id_mark
left outer join applications a on sub.id_application=a.id_application
WHERE sub.id_subvision= id_sub and 
m.id_criteria=id_criteria_temp and m.id_mark is not null and (m.date_close is null or (m.date_close is not null and ( m.date_close > IFNULL(a.date_send, CURDATE()) )));

set @all_mark = 0;
set @all_mark_3 = 0;
set  @all_mark_1 =0;
set @otmetka_all =0;

set @all_mark_class_1 = 0;
set @all_mark_3_class_1= 0;
set  @all_mark_1_class_1 =0;
set @otmetka_all_class_1 =0;

set @all_mark_class_2 = 0;
set @all_mark_3_class_2 = 0;
set  @all_mark_1_class_2 =0;
set @otmetka_all_class_2=0;

set @all_mark_class_3 = 0;
set @all_mark_3_class_3 = 0;
set  @all_mark_1_class_3 =0;
set @otmetka_all_class_3=0;

set @all_mark = (select count(*)
from temp_criteria_sub);

set @all_mark_3 = ( select count(*)
from temp_criteria_sub
where field4 =3);

set  @all_mark_1 =( select count(*)
from temp_criteria_sub
where field4 =1);

set @otmetka_all =  (@all_mark_1/(@all_mark-@all_mark_3))*100;

set @all_mark_class_1 = (select  count(*)
from temp_criteria_sub
where mark_class=1);


set @all_mark_3_class_1=(select count(*)
from temp_criteria_sub
where field4 =3 and  mark_class=1);

set @all_mark_1_class_1 =(select  count(*)
from temp_criteria_sub
where field4 =1 and  mark_class=1);

set @otmetka_all_class_1 = (@all_mark_1_class_1/(@all_mark_class_1-@all_mark_3_class_1))*100;

set @all_mark_class_2 = (select  count(*)
from temp_criteria_sub
where mark_class=2);


set @all_mark_3_class_2 = (select count(*)
from temp_criteria_sub
where field4 =3 and  mark_class=2);

set @all_mark_1_class_2 = (select count(*) 
from temp_criteria_sub
where field4 =1 and  mark_class=2);

set @otmetka_all_class_2 = (@all_mark_1_class_2/(@all_mark_class_2-@all_mark_3_class_2))*100;

set @all_mark_class_3 = (select count(*)
from temp_criteria_sub
where mark_class=3);


set @all_mark_3_class_3 =(select  count(*)
from temp_criteria_sub
where field4 =3 and  mark_class=3);

set @all_mark_1_class_3= (select  count(*)
from temp_criteria_sub
where field4 =1 and  mark_class=3);

set @otmetka_all_class_3 = (@all_mark_1_class_3/(@all_mark_class_3-@all_mark_3_class_3))*100;

INSERT INTO report_criteria_mark(id_application, id_subvision, id_criteria, otmetka_all, otmetka_all_count_yes, otmetka_all_count_all, otmetka_all_count_not_need, otmetka_class_1, otmetka_class_1_count_yes, otmetka_class_1_count_all, otmetka_class_1_count_not_need,otmetka_class_2, otmetka_class_2_count_yes, otmetka_class_2_count_all, otmetka_class_2_count_not_need,otmetka_class_3,otmetka_class_3_count_yes, otmetka_class_3_count_all, otmetka_class_3_count_not_need) 
VALUES(id_app, id_sub, id_criteria_temp, IFNULL(@otmetka_all,0),
IFNULL(@all_mark_1,0),IFNULL(@all_mark,0),IFNULL(@all_mark_3,0), IFNULL(@otmetka_all_class_1,0), 
IFNULL(@all_mark_1_class_1,0),IFNULL(@all_mark_class_1,0),IFNULL(@all_mark_3_class_1,0),
IFNULL(@otmetka_all_class_2,0), 
IFNULL(@all_mark_1_class_2,0),IFNULL(@all_mark_class_2,0),IFNULL(@all_mark_3_class_2,0),
IFNULL(@otmetka_all_class_3,0),
IFNULL(@all_mark_1_class_3,0),IFNULL(@all_mark_class_3,0),IFNULL(@all_mark_3_class_3,0));

DROP TEMPORARY TABLE temp_criteria_sub;

END LOOP get_Criteria;
CLOSE criteria_cursor;

update applications
set activ_cursor=false
where id_application=id_app;

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `cursor_for_criteria_acred` (IN `id_app` INT, IN `id_sub` INT)   BEGIN
DECLARE is_done_criteria integer default 0;
DECLARE id_criteria_temp integer default 0;

DECLARE criteria_cursor CURSOR FOR
SELECT DISTINCT rc.id_criteria
FROM rating_criteria rc
WHERE rc.id_subvision=id_sub;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET is_done_criteria = 1;
OPEN criteria_cursor;

get_Criteria: LOOP
FETCH criteria_cursor INTO id_criteria_temp;
IF is_done_criteria = 1 THEN 
LEAVE get_Criteria;
END IF;


CREATE TEMPORARY table temp_criteria_sub (id_sub int, mark_class int, id_criteria int, id_mark int, field7 int, field4 int);


insert into temp_criteria_sub (id_sub , mark_class , id_criteria , id_mark , field7, field4)
SELECT sub.id_subvision, case when m.mark_class is null then 0 else m.mark_class end, rc.id_criteria, m.id_mark,
case when mr.field7 is null then 0 else mr.field7 end,
case when mr.field4 is null then 0 else mr.field4 end
FROM `subvision` sub
left outer join rating_criteria rc on sub.id_subvision=rc.id_subvision
left outer join mark m on rc.id_criteria=m.id_criteria
left outer join mark_rating mr on sub.id_subvision=mr.id_subvision and m.id_mark=mr.id_mark
left outer join applications a on sub.id_application=a.id_application
WHERE sub.id_subvision= id_sub and 
m.id_criteria=id_criteria_temp and m.id_mark is not null and (m.date_close is null or (m.date_close is not null and ( m.date_close > a.date_send))) and (m.date_open is null or (m.date_open is not null and (m.date_open <= a.date_send )));

set @all_mark = 0;
set @all_mark_3 = 0;
set  @all_mark_1 =0;
set @otmetka_all =0;

set @mark_verif =0;
set @otmetka_verif =0;

set @all_mark_class_1 = 0;
set @all_mark_3_class_1= 0;
set  @all_mark_1_class_1 =0;
set @otmetka_all_class_1 =0;

set @all_mark_class_2 = 0;
set @all_mark_3_class_2 = 0;
set  @all_mark_1_class_2 =0;
set @otmetka_all_class_2=0;

set @all_mark_class_3 = 0;
set @all_mark_3_class_3 = 0;
set  @all_mark_1_class_3 =0;
set @otmetka_all_class_3=0;

set @all_mark = (select count(*)
from temp_criteria_sub);

set @all_mark_3 = ( select count(*)
from temp_criteria_sub
where field7 =3);

set  @all_mark_1 =( select count(*)
from temp_criteria_sub
where field7 =1);

set @otmetka_all =  (@all_mark_1/(@all_mark-@all_mark_3))*100;

set @mark_verif = (select count(*)
from temp_criteria_sub 
where field7<>field4
);

set @otmetka_verif =  (@mark_verif /(@all_mark-@all_mark_3))*100;

set @all_mark_class_1 = (select  count(*)
from temp_criteria_sub
where mark_class=1);


set @all_mark_3_class_1=(select count(*)
from temp_criteria_sub
where field7 =3 and  mark_class=1);

set @all_mark_1_class_1 =(select  count(*)
from temp_criteria_sub
where field7 =1 and  mark_class=1);

set @otmetka_all_class_1 = (@all_mark_1_class_1/(@all_mark_class_1-@all_mark_3_class_1))*100;

set @all_mark_class_2 = (select  count(*)
from temp_criteria_sub
where mark_class=2);


set @all_mark_3_class_2 = (select count(*)
from temp_criteria_sub
where field7 =3 and  mark_class=2);

set @all_mark_1_class_2 = (select count(*) 
from temp_criteria_sub
where field7 =1 and  mark_class=2);

set @otmetka_all_class_2 = (@all_mark_1_class_2/(@all_mark_class_2-@all_mark_3_class_2))*100;

set @all_mark_class_3 = (select count(*)
from temp_criteria_sub
where mark_class=3);


set @all_mark_3_class_3 =(select  count(*)
from temp_criteria_sub
where field7 =3 and  mark_class=3);

set @all_mark_1_class_3= (select  count(*)
from temp_criteria_sub
where field7 =1 and  mark_class=3);

set @otmetka_all_class_3 = (@all_mark_1_class_3/(@all_mark_class_3-@all_mark_3_class_3))*100;

update report_criteria_mark
set otmetka_accred_all = IFNULL(@otmetka_all,0), 
otmetka_accred_all_count_yes=IFNULL(@all_mark_1,0), 
otmetka_accred_all_count_all=IFNULL(@all_mark,0),
otmetka_accred_all_count_not_need=IFNULL(@all_mark_3,0),
otmetka_accred_class_1=IFNULL(@otmetka_all_class_1,0), 
otmetka_accred_class_1_count_yes=IFNULL(@all_mark_1_class_1,0),otmetka_accred_class_1_count_all=IFNULL(@all_mark_class_1,0), otmetka_accred_class_1_count_not_need=IFNULL(@all_mark_3_class_1,0),
otmetka_accred_class_2=IFNULL(@otmetka_all_class_2,0), 
otmetka_accred_class_2_count_yes= 
IFNULL(@all_mark_1_class_2,0),otmetka_accred_class_2_count_all=IFNULL(@all_mark_class_2,0),
otmetka_accred_class_2_count_not_need=IFNULL(@all_mark_3_class_2,0),
otmetka_accred_class_3=IFNULL(@otmetka_all_class_3,0),
otmetka_accred_class_3_count_yes=IFNULL(@all_mark_1_class_3,0),
otmetka_accred_class_3_count_all= IFNULL(@all_mark_class_3,0),otmetka_accred_class_3_count_not_need=IFNULL(@all_mark_3_class_3,0),
otmetka_verif=IFNULL(@otmetka_verif,0),
otmetka_verif_count_yes= IFNULL(@mark_verif,0),otmetka_verif_count_all= IFNULL(@all_mark,0),otmetka_verif_count_not_need=IFNULL(@all_mark_3,0)
where id_application=id_app and id_subvision=id_sub and id_criteria=id_criteria_temp;


DROP TEMPORARY TABLE temp_criteria_sub;

END LOOP get_Criteria;
CLOSE criteria_cursor;

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `cursor_for_subvision` (IN `id_app` INT)   BEGIN

DECLARE is_done integer default 0;
DECLARE id_sub_temp integer default 0;

DECLARE mark_cursor CURSOR FOR
SELECT id_subvision from subvision where id_application=id_app;


DECLARE CONTINUE HANDLER FOR NOT FOUND SET is_done = 1;
OPEN mark_cursor;

get_Sub: LOOP
FETCH mark_cursor INTO id_sub_temp;
IF is_done = 1 THEN 
LEAVE get_Sub;
END IF;


CREATE TEMPORARY table temp_mark_sub (id_sub int, mark_class int, id_criteria int, id_mark int, field4 int);

insert into temp_mark_sub (id_sub , mark_class , id_criteria , id_mark , field4)
SELECT sub.id_subvision, case when m.mark_class is null then 0 else m.mark_class end, rc.id_criteria, m.id_mark,
case when mr.field4 is null then 0 else mr.field4 end
FROM `subvision` sub
left outer join rating_criteria rc on sub.id_subvision=rc.id_subvision
left outer join mark m on rc.id_criteria=m.id_criteria
left outer join mark_rating mr on sub.id_subvision=mr.id_subvision and m.id_mark=mr.id_mark
left outer join applications a on sub.id_application=a.id_application
WHERE sub.id_subvision= id_sub_temp and m.id_mark is not null and (m.date_close is null or (m.date_close is not null and ( m.date_close > IFNULL(a.date_send, CURDATE()) )));


set @all_mark = 0;
set @all_mark_3 = 0;
set  @all_mark_1 =0;
set @otmetka_all =0;

set @all_mark_class_1 = 0;
set @all_mark_3_class_1= 0;
set  @all_mark_1_class_1 =0;
set @otmetka_all_class_1 =0;

set @all_mark_class_2 = 0;
set @all_mark_3_class_2 = 0;
set  @all_mark_1_class_2 =0;
set @otmetka_all_class_2=0;

set @all_mark_class_3 = 0;
set @all_mark_3_class_3 = 0;
set  @all_mark_1_class_3 =0;
set @otmetka_all_class_3=0;

set @all_mark = (select count(*)
from temp_mark_sub);


set @all_mark_3 = ( select count(*)
from temp_mark_sub
where field4 =3);

set  @all_mark_1 =( select count(*)
from temp_mark_sub
where field4 =1);

set @otmetka_all =  (@all_mark_1/(@all_mark-@all_mark_3))*100;





set @all_mark_class_1 = (select  count(*)
from temp_mark_sub
where mark_class=1);


set @all_mark_3_class_1=(select count(*)
from temp_mark_sub
where field4 =3 and  mark_class=1);

set @all_mark_1_class_1 =(select  count(*)
from temp_mark_sub
where field4 =1 and  mark_class=1);

set @otmetka_all_class_1 = (@all_mark_1_class_1/(@all_mark_class_1-@all_mark_3_class_1))*100;


set @all_mark_class_2 = (select  count(*)
from temp_mark_sub
where mark_class=2);


set @all_mark_3_class_2 = (select count(*)
from temp_mark_sub
where field4 =3 and  mark_class=2);

set @all_mark_1_class_2 = (select count(*) 
from temp_mark_sub
where field4 =1 and  mark_class=2);

set @otmetka_all_class_2 = (@all_mark_1_class_2/(@all_mark_class_2-@all_mark_3_class_2))*100;

set @all_mark_class_3 = (select count(*)
from temp_mark_sub
where mark_class=3);


set @all_mark_3_class_3 =(select  count(*)
from temp_mark_sub
where field4 =3 and  mark_class=3);

set @all_mark_1_class_3= (select  count(*)
from temp_mark_sub
where field4 =1 and  mark_class=3);

set @otmetka_all_class_3 = (@all_mark_1_class_3/(@all_mark_class_3-@all_mark_3_class_3))*100;

INSERT INTO report_subvision_mark(id_application, id_subvision, otmetka_all, otmetka_all_count_yes, otmetka_all_count_all, otmetka_all_count_not_need, otmetka_class_1, otmetka_class_1_count_yes, otmetka_class_1_count_all, otmetka_class_1_count_not_need,otmetka_class_2, otmetka_class_2_count_yes, otmetka_class_2_count_all, otmetka_class_2_count_not_need,otmetka_class_3,otmetka_class_3_count_yes, otmetka_class_3_count_all, otmetka_class_3_count_not_need) 
VALUES(id_app, id_sub_temp, IFNULL(@otmetka_all,0),
IFNULL(@all_mark_1,0),IFNULL(@all_mark,0),IFNULL(@all_mark_3,0), IFNULL(@otmetka_all_class_1,0), 
IFNULL(@all_mark_1_class_1,0),IFNULL(@all_mark_class_1,0),IFNULL(@all_mark_3_class_1,0),
IFNULL(@otmetka_all_class_2,0), 
IFNULL(@all_mark_1_class_2,0),IFNULL(@all_mark_class_2,0),IFNULL(@all_mark_3_class_2,0),
IFNULL(@otmetka_all_class_3,0),
IFNULL(@all_mark_1_class_3,0),IFNULL(@all_mark_class_3,0),IFNULL(@all_mark_3_class_3,0));

call cursor_for_criteria(id_app, id_sub_temp);

DROP TEMPORARY TABLE temp_mark_sub;

END LOOP get_Sub;
CLOSE mark_cursor;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `cursor_for_subvision_acred` (IN `id_app` INT)   BEGIN

DECLARE is_done integer default 0;
DECLARE id_sub_temp integer default 0;

DECLARE mark_cursor CURSOR FOR
SELECT id_subvision from subvision where id_application=id_app;


DECLARE CONTINUE HANDLER FOR NOT FOUND SET is_done = 1;
OPEN mark_cursor;

get_Sub: LOOP
FETCH mark_cursor INTO id_sub_temp;
IF is_done = 1 THEN 
LEAVE get_Sub;
END IF;


CREATE TEMPORARY table temp_mark_sub (id_sub int, mark_class int, id_criteria int, id_mark int, field7 int, field4 int);

insert into temp_mark_sub (id_sub , mark_class , id_criteria , id_mark , field7, field4)
SELECT sub.id_subvision, case when m.mark_class is null then 0 else m.mark_class end, rc.id_criteria, m.id_mark,
case when mr.field7 is null then 0 else mr.field7 end,
case when mr.field4 is null then 0 else mr.field4 end
FROM `subvision` sub
left outer join rating_criteria rc on sub.id_subvision=rc.id_subvision
left outer join mark m on rc.id_criteria=m.id_criteria
left outer join mark_rating mr on sub.id_subvision=mr.id_subvision and m.id_mark=mr.id_mark
left outer join applications a on sub.id_application=a.id_application
WHERE sub.id_subvision= id_sub_temp and m.id_mark is not null and (m.date_close is null or (m.date_close is not null and ( m.date_close > a.date_send))) and (m.date_open is null or (m.date_open is not null and (m.date_open <= a.date_send )));


set @all_mark = 0;
set @all_mark_3 = 0;
set  @all_mark_1 =0;
set @otmetka_all =0;

set @mark_verif =0;
set @otmetka_verif =0;

set @all_mark_class_1 = 0;
set @all_mark_3_class_1= 0;
set  @all_mark_1_class_1 =0;
set @otmetka_all_class_1 =0;

set @all_mark_class_2 = 0;
set @all_mark_3_class_2 = 0;
set  @all_mark_1_class_2 =0;
set @otmetka_all_class_2=0;

set @all_mark_class_3 = 0;
set @all_mark_3_class_3 = 0;
set  @all_mark_1_class_3 =0;
set @otmetka_all_class_3=0;

set @all_mark = (select count(*)
from temp_mark_sub);


set @all_mark_3 = ( select count(*)
from temp_mark_sub
where field7 =3);

set  @all_mark_1 =( select count(*)
from temp_mark_sub
where field7 =1);

set @otmetka_all =  (@all_mark_1/(@all_mark-@all_mark_3))*100;


set @mark_verif = (select count(*)
from temp_mark_sub
where field7<>field4
);

set @otmetka_verif =  (@mark_verif /(@all_mark-@all_mark_3))*100;


set @all_mark_class_1 = (select  count(*)
from temp_mark_sub
where mark_class=1);


set @all_mark_3_class_1=(select count(*)
from temp_mark_sub
where field7 =3 and  mark_class=1);

set @all_mark_1_class_1 =(select  count(*)
from temp_mark_sub
where field7 =1 and  mark_class=1);

set @otmetka_all_class_1 = (@all_mark_1_class_1/(@all_mark_class_1-@all_mark_3_class_1))*100;


set @all_mark_class_2 = (select  count(*)
from temp_mark_sub
where mark_class=2);


set @all_mark_3_class_2 = (select count(*)
from temp_mark_sub
where field7 =3 and  mark_class=2);

set @all_mark_1_class_2 = (select count(*) 
from temp_mark_sub
where field7 =1 and  mark_class=2);

set @otmetka_all_class_2 = (@all_mark_1_class_2/(@all_mark_class_2-@all_mark_3_class_2))*100;

set @all_mark_class_3 = (select count(*)
from temp_mark_sub
where mark_class=3);


set @all_mark_3_class_3 =(select  count(*)
from temp_mark_sub
where field7 =3 and  mark_class=3);

set @all_mark_1_class_3= (select  count(*)
from temp_mark_sub
where field7 =1 and  mark_class=3);

set @otmetka_all_class_3 = (@all_mark_1_class_3/(@all_mark_class_3-@all_mark_3_class_3))*100;


update report_subvision_mark
set otmetka_accred_all = IFNULL(@otmetka_all,0), 
otmetka_accred_all_count_yes=IFNULL(@all_mark_1,0), 
otmetka_accred_all_count_all=IFNULL(@all_mark,0),
otmetka_accred_all_count_not_need=IFNULL(@all_mark_3,0),
otmetka_accred_class_1=IFNULL(@otmetka_all_class_1,0), 
otmetka_accred_class_1_count_yes=IFNULL(@all_mark_1_class_1,0),otmetka_accred_class_1_count_all=IFNULL(@all_mark_class_1,0), otmetka_accred_class_1_count_not_need=IFNULL(@all_mark_3_class_1,0),
otmetka_accred_class_2=IFNULL(@otmetka_all_class_2,0), 
otmetka_accred_class_2_count_yes= 
IFNULL(@all_mark_1_class_2,0),otmetka_accred_class_2_count_all=IFNULL(@all_mark_class_2,0),
otmetka_accred_class_2_count_not_need=IFNULL(@all_mark_3_class_2,0),
otmetka_accred_class_3=IFNULL(@otmetka_all_class_3,0),
otmetka_accred_class_3_count_yes=IFNULL(@all_mark_1_class_3,0),
otmetka_accred_class_3_count_all= IFNULL(@all_mark_class_3,0),otmetka_accred_class_3_count_not_need=IFNULL(@all_mark_3_class_3,0),
otmetka_verif=IFNULL(@otmetka_verif,0),
otmetka_verif_count_yes= IFNULL(@mark_verif,0),otmetka_verif_count_all= IFNULL(@all_mark,0),otmetka_verif_count_not_need=IFNULL(@all_mark_3,0)
where id_application=id_app and id_subvision=id_sub_temp;

call cursor_for_criteria_acred(id_app, id_sub_temp);


DROP TEMPORARY TABLE temp_mark_sub;

END LOOP get_Sub;
CLOSE mark_cursor;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `applications`
--

CREATE TABLE `applications` (
  `id_application` int NOT NULL,
  `naim` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sokr_naim` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `unp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ur_adress` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `rukovoditel` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `predstavitel` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `soprovod_pismo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `copy_rasp` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `org_structure` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `id_user` int NOT NULL,
  `id_status` int DEFAULT NULL,
  `date_send` date DEFAULT NULL,
  `date_accept` date DEFAULT NULL,
  `date_complete` date DEFAULT NULL,
  `fileReport` varchar(555) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fileReportSamoocenka` varchar(555) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `activ_cursor` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `applications`
--

INSERT INTO `applications` (`id_application`, `naim`, `sokr_naim`, `unp`, `ur_adress`, `tel`, `email`, `rukovoditel`, `predstavitel`, `soprovod_pismo`, `copy_rasp`, `org_structure`, `id_user`, `id_status`, `date_send`, `date_accept`, `date_complete`, `fileReport`, `fileReportSamoocenka`, `activ_cursor`) VALUES
(42, '36gp', 'Жлобинская ЦРБ', '400080424', 'Республика Беларусь, 247210, Гомельская область, Жлобинский район, г. Жлобин, ул. Воровского, д. 1', '+375 2334 4-25-40', 'zhlcrb@zhlcrb.by', 'Топчий Евгений Николаевич', 'Малиновский Евгений Леонидович', 'Брестский район_26-06-2023_12-16-13.csv', 'download.pdf', 'Справка по работе в РТМС консультирующихся организаций здравоохранения за 2023 год.xlsx', 2, 1, '2023-07-20', '2023-07-31', '2023-07-18', NULL, 'Структура таблиц критериев из приказа.docx', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `cells`
--

CREATE TABLE `cells` (
  `id_cell` int NOT NULL,
  `id_criteria` int NOT NULL,
  `id_column` int NOT NULL,
  `cell` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_application` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `columns`
--

CREATE TABLE `columns` (
  `id_column` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `conditions`
--

CREATE TABLE `conditions` (
  `conditions_id` int NOT NULL,
  `conditions` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `conditions`
--

INSERT INTO `conditions` (`conditions_id`, `conditions`) VALUES
(1, 'Амбулаторная'),
(2, 'Стационарная');

-- --------------------------------------------------------

--
-- Структура таблицы `criteria`
--

CREATE TABLE `criteria` (
  `id_criteria` int NOT NULL,
  `name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type_criteria` int NOT NULL COMMENT '1 - общий 2 - по видам оказания 3 - вспомогательные подразделения',
  `conditions_id` int DEFAULT NULL COMMENT '1-амбулаторно 2 - стационарно'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `criteria`
--

INSERT INTO `criteria` (`id_criteria`, `name`, `type_criteria`, `conditions_id`) VALUES
(39, 'Больничная организация  здравоохранения (диспансер, центр)', 1, NULL),
(40, 'Кардиология', 2, 2),
(41, 'Неврология', 2, 2),
(42, 'Хирургия', 2, 2),
(43, 'Эндокринология', 2, 2),
(44, 'Акушерство и гинекология', 2, 1),
(45, 'Акушерство и гинекология', 2, 2),
(46, 'Анестезиологии и реаниматологии', 2, 2),
(47, 'Терапия (терапевтический профиль)', 2, 2),
(48, 'Реабилитация', 2, 2),
(49, 'Стоматология', 2, 2),
(50, 'Педиатрия', 2, 2),
(51, 'Эндоскопия', 3, NULL),
(52, 'Рентгенография, радионуклидная диагностика', 3, NULL),
(53, 'Ультразвуковая диагностика', 3, NULL),
(54, 'Функциональная диагностика', 3, NULL),
(55, 'Лабораторная диагностика', 3, 2),
(56, 'Фельдшерско-акушерский пункт', 1, NULL),
(57, 'Врачебная амбулатория', 1, NULL),
(58, 'Участковая больница', 1, NULL),
(59, 'Детская больничная организация здравоохранения (центр)', 1, NULL),
(60, 'Амбулаторно-поликлиническая организация здравоохранения (диспансер, центр)', 1, NULL),
(61, 'Детская амбулаторно-поликлиническая организация здравоохранения (центр)', 1, NULL),
(62, 'Республиканский научно-практический центр', 1, NULL),
(63, 'Организация здравоохранения, оказывающая паллиативную помощь', 1, NULL),
(64, 'Больница сестринского ухода', 1, NULL),
(65, 'Дом ребенка', 1, NULL),
(66, 'Организация службы крови (центр, станция)', 1, NULL),
(67, 'Центр и станция скорой медицинской помощи', 1, NULL),
(68, 'Коммунальное унитарное предприятие по оказанию стоматологической помощи', 1, NULL),
(69, 'Кардиология', 2, 1),
(70, 'Неврология', 2, 1),
(71, 'Хирургия', 2, 1),
(72, 'Травмотология', 2, 1),
(73, 'Травмотология', 2, 2),
(74, 'Онкология', 2, NULL),
(75, 'Офтальмология', 2, 1),
(76, 'Офтальмология', 2, 2),
(77, 'Анестезиология', 2, 1),
(78, 'Оториноларингология', 2, 1),
(79, 'Оториноларингология', 2, 2),
(80, 'Реабилитация', 2, 1),
(81, 'Эндокринология', 2, 1),
(82, 'Гастроэнтерология', 2, 1),
(83, 'Гастроэнтерология', 2, 2),
(84, 'Фтизиатрия', 2, 1),
(85, 'Фтизиатрия', 2, 2),
(86, 'Пульмонология', 2, 1),
(87, 'Пульмонология', 2, 2),
(88, 'Отделение общей врачебной практики', 2, NULL),
(89, 'Педиатрия', 2, 1),
(90, 'Инфекционные заболевания', 2, 1),
(91, 'Инфекционные заболевания', 2, 2),
(92, 'Отделение скорой медицинской помощи в структуре больничной организации здравоохранения', 2, NULL),
(93, 'Стоматология', 2, 1),
(94, 'Детская хирургия', 2, 1),
(95, 'Детская хирургия', 2, 2),
(96, 'Психиатрия и наркология', 2, 1),
(97, 'Психиатрия и наркология', 2, 2),
(98, 'Кабинет (отделение) трансфузиологической помощи', 2, NULL),
(99, 'КТ, МРТ-диагностика', 3, NULL),
(100, 'Лабораторная диагностика', 3, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `mark`
--

CREATE TABLE `mark` (
  `id_mark` int NOT NULL,
  `str_num` int DEFAULT NULL,
  `mark_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `mark_class` int DEFAULT NULL,
  `id_criteria` int DEFAULT NULL,
  `date_close` date DEFAULT NULL,
  `date_open` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `mark`
--

INSERT INTO `mark` (`id_mark`, `str_num`, `mark_name`, `mark_class`, `id_criteria`, `date_close`, `date_open`) VALUES
(143, 1, '	Деятельность неврологического отделения осуществляется в соответствии с положением о структурном подразделении', 3, 41, NULL, NULL),
(144, 2, '	Руководителем организации здравоохранения определены ответственные лица за организацию оказания неврологической помощи в учреждении здравоохранения', 3, 41, NULL, NULL),
(145, 3, '	Руководителем неврологического отделения ежеквартально анализируются основные показатели деятельности структурного подразделения', 3, 41, NULL, NULL),
(146, 4, 'Штатная численность должностей служащих неврологического отделения утверждена руководителем ОЗ с учетом примерных штатных нормативов численности медицинских и иных работников, оказывающих медицинскую помощь в стационарных условиях и норм нагрузок труда работников, установленных в ОЗ', 2, 41, NULL, NULL),
(147, 5, '	В соответствии со штатным расписанием на каждую должность медицинского работника руководителем ОЗ утверждена должностная инструкция с указанием квалификационных требований и функций, прав и обязанностей медицинских работников. Медицинские работники ознакомлены с должностной инструкцией', 3, 41, NULL, NULL),
(148, 6, 'Квалификация медицинских работников структурного подразделения соответствует требованиям должностной инструкции к занимаемой должности служащего', 2, 41, NULL, NULL),
(149, 7, '	Укомплектованность неврологического отделения врачами-неврологами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей-неврологов укомплектованность не менее 96 % по занятым должностям', 1, 41, NULL, NULL),
(150, 8, '	Укомплектованность неврологического отделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям ', 1, 41, NULL, NULL),
(151, 9, '	Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 41, NULL, NULL),
(152, 10, '	Медицинские работники неврологического отделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев.\r\nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 41, NULL, NULL),
(153, 11, '	Медицинские работники неврологического отделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков.\r\nМедицинские работники неврологического отделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 41, NULL, NULL),
(154, 12, '	Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 41, NULL, NULL),
(155, 13, '	Оснащение неврологического отделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой в объеме, достаточном для оказания неврологической помощи в соответствии с профилем отделения, уровнем оказания медицинской помощи', 3, 41, NULL, NULL),
(156, 14, '	В неврологическом отделении имеются ЛС, предусмотренные для оказания медицинской помощи в соответствии с клиническими протоколами', 2, 41, NULL, NULL),
(157, 15, '	Медицинская техника, находящаяся в эксплуатации в неврологическом отделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание	', 3, 41, NULL, NULL),
(158, 16, '	Порядок оказания медицинской помощи в неврологическом отделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь.\r\nСоблюдается порядок (алгоритмы, «дорожные карты») оказания срочной и плановой медицинской помощи при неврологической патологии	', 2, 41, NULL, NULL),
(159, 17, '	Обеспечена круглосуточная работа врачей-неврологов при условии оказания экстренной специализированной помощи в структурном подразделении.\r\nВ круглосуточном режиме, в том числе в выходные праздничные дни доступен осмотр дежурного врача', 2, 41, NULL, NULL),
(160, 18, '	Круглосуточно обеспечена возможность оказания анестезиолого-реанимационной помощи. Критерий применяется для структурных подразделений межрайонного, городского, областного, республиканского уровня', 1, 41, NULL, NULL),
(161, 19, '	Обеспечена преемственность с амбулаторно-поликлиническими организациями здравоохранения. Обеспечена передача эпикриза, содержащего рекомендации по дальнейшему медицинскому наблюдению в территориальную амбулаторно-поликлиническую организацию', 2, 41, NULL, NULL),
(162, 20, '	В неврологическом отделении при оказании медицинской помощи пациентам диагностические исследования проводятся в соответствии с клиническими протоколами	', 1, 41, NULL, NULL),
(163, 21, '	В неврологическом отделении при оказании медицинской помощи пациентам лечение осуществляется в соответствии с клиническими протоколами', 1, 41, NULL, NULL),
(164, 22, '	Оформление медицинской карты стационарного пациента соответствует установленной форме', 3, 41, NULL, NULL),
(165, 23, '	В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 41, NULL, NULL),
(166, 24, '	Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 3, 41, NULL, NULL),
(167, 25, '	Профильность работы структурного подразделения для районного и городского уровня оказания помощи не менее 60 %, для областного и республиканского не менее 80 %	', 2, 41, NULL, NULL),
(168, 26, '	Определен порядок госпитализации пациентов в неврологическое отделение, утвержденный приказом руководителя ОЗ', 2, 41, NULL, NULL),
(169, 27, '	Показатели среднегодовой занятости койки, оборота койки неврологического отделения общего профиля сопоставимы со средними значениями по области/г. Минску', 2, 41, NULL, NULL),
(170, 28, '	Обеспечено круглосуточное проведение лабораторных и рентгенологических исследований в соответствии с клиническими протоколами', 1, 41, NULL, NULL),
(171, 29, '	Обеспечено круглосуточное оказание анестезиолого-реанимационной помощи', 1, 41, NULL, NULL),
(172, 30, '	Обеспечено проведение рентгеновской компьютерной томографии (далее – КТ), магнитно-резонансной томографии (далее – МРТ) или имеется установленный порядок\r\nнаправления пациентов на данные исследования в другие ОЗ в соответствии с клиническими протоколами, в том числе по экстренным показаниям круглосуточно	', 1, 41, NULL, NULL),
(173, 31, '	Обеспечена возможность проведения ультразвукового исследования (далее – УЗИ), дуплексного сканирования прецеребральных артерий, эхокардиографии, холтеровского мониторирования ЭКГ, суточного мониторирования АД, электроэнцефалографии (далее – ЭЭГ), электронейромиографии (далее – ЭНМГ) или имеется установленный порядок направления пациентов в другие ОЗ в соответствии с клиническими протоколами', 2, 41, NULL, NULL),
(174, 32, '	Обеспечено оказание нейрохирургической помощи по показаниям или имеется установленный порядок направления пациентов в другие ОЗ', 1, 41, NULL, NULL),
(175, 33, '	Обеспечена возможность проведения консультаций врача-офтальмолога, врача-терапевта, врача-оториноларинголога, врача психиатра-нарколога	', 2, 41, NULL, NULL),
(176, 34, '	Обеспечена доступность телемедицинского консультирования на областном уровне, консультативное заключение находится в медицинской карте стационарного пациента', 2, 41, NULL, NULL),
(177, 35, '	Объем обследований аналогичен районному уровню.\r\nНа базе ОЗ обеспечено проведение ЭНМГ, ЭЭГ, КТ/МРТ с контрастированием или утвержден алгоритм доставки пациента для нейровизуализации в ближайшую организацию здравоохранения при отсутствии возможности выполнения данного вида исследования', 1, 41, NULL, NULL),
(178, 36, '	При оказании медицинской помощи пациентам лечение осуществляется в соответствии с клиническими протоколами, в том числе обеспечено проведение иммуномодулирующей терапии, ботулинотерапии, плазмафереза и др. методов лечения', 1, 41, NULL, NULL),
(179, 37, '	Объем обследований аналогичен областному уровню. Дополнительно обеспечено проведение суточного мониторирования ЭЭГ, видео-ЭЭГ мониторирования, мониторинга концентрации антиконвульсантов в крови, исследования вызванных потенциалов различной модальности и др. обследований в соответствии с диагнозом и утвержденными клиническими протоколами для республиканского уровня', 1, 41, NULL, NULL),
(180, 38, '	При оказании медицинской помощи пациентам лечение осуществляется в соответствии с клиническими протоколами, в том числе обеспечено проведение иммуномодулирующей терапии, ботулинотерапии, плазмафереза, высокотехнологичных методов лечения (нейромодуляция и др.)', 1, 41, NULL, NULL),
(181, 39, '	Определен порядок госпитализации пациентов в неврологическое отделение, утвержденный приказом руководителя ОЗ', 2, 41, NULL, NULL),
(182, 40, '	Показатели среднегодовой занятости койки, оборота койки, общей летальности и летальности от ОНМК неврологического отделения для инсультных больных сопоставимы со средними значениями по области/г. Минску', 2, 41, NULL, NULL),
(183, 41, '	Круглосуточно обеспечено проведение КТ (в том числе КТ с внутривенным контрастированием) или МРТ. Утвержден алгоритм доставки пациента для нейровизуализации в ближайшую организацию здравоохранения при отсутствии возможности выполнения данного вида исследования', 1, 41, NULL, NULL),
(184, 42, '	В инсультном отделении обеспечено круглосуточное дежурство врачей-неврологов	', 1, 41, NULL, NULL),
(185, 43, '	Обеспечено круглосуточное проведение лабораторных и рентгенологических исследований в соответствии с клиническими протоколами, в том числе для проведения тромболитической терапии и рентгенэндоваскулярных методов лечения', 1, 41, NULL, NULL),
(186, 44, '	Обеспечена круглосуточная возможность проведения тромболитической терапии в соответствии с клиническими протоколами', 1, 41, NULL, NULL),
(187, 45, '	Обеспечено оказание рентгеноэндоваскулярной хирургической помощи по показаниям или имеется установленный порядок направления пациентов в другие ОЗ', 1, 41, NULL, NULL),
(188, 46, '	Обеспечено оказание нейрохирургической помощи по показаниям или имеется установленный порядок направления пациентов в другие ОЗ', 1, 41, NULL, NULL),
(189, 47, '	Обеспечена возможность проведения консультаций врача-офтальмолога, врача-терапевта, врача-оториноларинголога, врача-кардиолога, врача психиатра-нарколога, соответствии с диагнозом и утвержденными клиническими протоколами', 2, 41, NULL, NULL),
(190, 48, 'Обеспечена возможность выполнения УЗИ-сердца, суточного мониторирования АД, холтеровского мониторирования ЭКГ соответствии с клиническими протоколами', 2, 41, NULL, NULL),
(191, 49, '	Обеспечена доступность телемедицинского консультирования на областном уровне, консультативное заключение находится в медицинской карте стационарного пациента', 3, 41, NULL, NULL),
(192, 50, '	Удельный вес пациентов с ИМ и ВМК, которым проведено КТ или МРТ головного мозга достигает 100 %', 1, 41, NULL, NULL),
(193, 51, '	Проводится профилактика и лечение осложнений: тромбоэмболия легочной артерии, пневмония, тромбоэмболия глубоких вен нижних конечностей, пролежни, острые пептические язвы и эрозии желудочно-кишечного тракта', 2, 41, NULL, NULL),
(194, 52, '	Обеспечено проведение медицинской реабилитации пациентов, оформление индивидуальной программы и плана медицинской реабилитации в соответствии с установленным порядком проведения медицинской реабилитации, соблюден порядок направления пациентов на медицинскую реабилитацию', 3, 41, NULL, NULL),
(195, 53, '	Круглосуточно обеспечена возможность для проведения тромболитической терапии/рентгенэндоваскулярных методов диагностики и лечения', 1, 41, NULL, NULL),
(196, 54, '	Круглосуточно обеспечена возможность оказания анестезиолого-реанимационной помощи пациентам с инсультом (ПИТ/ПРИТ, нейрореанимация)', 1, 41, NULL, NULL),
(197, 55, '	Обеспечена доступность телемедицинского консультирования на областном/республиканском уровне, заключение находится в медицинской карте стационарного пациента', 3, 41, NULL, NULL),
(198, 56, '	Обеспечено оказание нейрохирургической помощи. В ОЗ, не оказывающей нейрохирургическую помощь, или имеется установленный порядок направления пациентов в другие ОЗ', 2, 41, NULL, NULL),
(199, 57, '	В круглосуточном режиме организовано дистанционное консультирование врачом-неврологом медицинских работников, оказывающих помощь пациентам с ОНМК на догоспитальном этапе', 3, 41, NULL, NULL),
(200, 58, '	Объем обследований аналогичен межрайонному уровню. Дополнительно обеспечено проведение исследований на гемостазиопатии, системные поражения соединительной ткани и др. в соответствии с диагнозом и утвержденными клиническими протоколами для областного уровня', 2, 41, NULL, NULL),
(201, 59, '	При оказании медицинской помощи пациентам лечение осуществляется в соответствии с клиническими протоколами, в том числе обеспечено проведение ренгтенэндоваскулярных вмешательств и других методов лечения в сложных случаях в соответствии с диагнозом и утвержденными клиническими протоколами для областного уровня', 1, 41, NULL, NULL),
(202, 60, '	Объем обследований аналогичен областному уровню. Дополнительно проведение высокотехнологичных методов обследования в соответствии с диагнозом и утвержденными клиническими протоколами для республиканского уровня', 2, 41, NULL, NULL),
(203, 61, '	При оказании медицинской помощи пациентам лечение осуществляется в соответствии с клиническими протоколами, в том числе обеспечено проведение сложных высокотехнологичных ренгтенэндоваскулярных и др. вмешательств в соответствии с диагнозом и утвержденными клиническими протоколами для республиканского уровня', 1, 41, NULL, NULL),
(251, 1, '   Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 40, NULL, NULL),
(252, 2, '   Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей. Результаты анализа документируются, предоставляются лицу, ответственному за организацию кардиологической помощи.\r\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 40, NULL, NULL),
(253, 3, '   Укомплектованность структурного подразделения врачами-кардиологами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей-кардиологов укомплектованность не менее 96 % по занятым должностям', 1, 40, NULL, NULL),
(254, 4, '   Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 40, NULL, NULL),
(255, 5, '   Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего', 1, 40, NULL, NULL),
(256, 6, '   Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 40, NULL, NULL),
(257, 7, '   Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев.\r\nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 40, NULL, NULL),
(258, 8, '   Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков.\r\nМедицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 40, NULL, NULL),
(259, 9, '   Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 40, NULL, NULL),
(260, 10, '   Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой', 2, 40, NULL, NULL),
(261, 11, '   Порядок оказания медицинской помощи в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь.\r\nСоблюдается порядок (алгоритмы) оказания срочной и плановой медицинской помощи при кардиологической патологии', 2, 40, NULL, NULL),
(262, 12, '   Работа структурного подразделения обеспечена в сменном режиме', 2, 40, NULL, NULL),
(263, 13, '   Определен порядок оказания медицинской помощи пациентам с заболеваниями кардиологического профиля на период отсутствия в организации здравоохранения врача-кардиолога', 1, 40, NULL, NULL),
(264, 14, '   Соблюдается порядок медицинского наблюдения пациентов кардиологического профиля в амбулаторных условиях.\r\nВедется учет пациентов, подлежащих медицинскому наблюдению врачом-кардиологом.\r\nРуководителем структурного подразделения (ответственным лицом) осуществляется анализ результатов медицинского наблюдения пациентов', 1, 40, NULL, NULL),
(265, 15, '   Соблюдается установленный нормативно-правовым актом органа управления здравоохранением административной территории порядок («дорожная карта») оказания специализированной кардиологической помощи при острых коронарных синдромах.  \r\nСотрудники структурного подразделения, осуществляющего оказание специализированной кардиологической помощи, ознакомлены с данным нормативно-правовым актом', 1, 40, NULL, NULL),
(266, 16, '   Организовано направление пациентов для проведения рентгенэндоваскулярных методов диагностики и лечения в комиссию по отбору пациентов (далее – комиссия) на плановую коронарографию (далее – КАГ).\r\nОрганизовано ведение «листов ожидания» для проведения КАГ и своевременный обмен информацией с комиссией', 1, 40, NULL, NULL),
(267, 17, '   Обеспечена преемственность с больничными организациями здравоохранения. Определен порядок направления на плановую и экстренную госпитализацию пациентов кардиологического профиля. Обеспечено выполнение на амбулаторном этапе рекомендаций по дальнейшему медицинскому наблюдению после выписки', 2, 40, NULL, NULL),
(268, 18, '   Обеспечено назначение лечения пациентам в амбулаторных условиях согласно клиническим протоколам', 1, 40, NULL, NULL),
(269, 19, '   Оформление медицинской карты амбулаторного больного соответствует установленной форме', 3, 40, NULL, NULL),
(270, 20, '   В организации здравоохранения разработан алгоритм при отказе пациента (или его законного представителя) от оказания медицинской помощи или ее отдельных видов', 2, 40, NULL, NULL),
(271, 21, '   В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 40, NULL, NULL),
(272, 22, '   Осуществляется выписка электронных рецептов на лекарственные средства', 2, 40, NULL, NULL),
(273, 23, '   Для врачей-специалистов структурного подразделения обеспечена доступность проведения телемедицинского консультирования, результаты которого документируются и находятся в медицинской карте', 2, 40, NULL, NULL),
(274, 24, '   Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 3, 40, NULL, NULL),
(275, 25, '   Обеспечена доступность и условия для выполнения электрокардиограммы и оказания неотложной помощи в течение всего периода работы амбулаторно-поликлинической организации здравоохранения', 1, 40, NULL, NULL),
(276, 26, '   В рамках получения пациентом кардиологической помощи, в случаях, предусмотренных клиническими протоколами диагностики и лечения, обеспечена возможность проведения консультаций врача-офтальмолога, врача-эндокринолога, врача-невролога, врача-хирурга, врача-кардиохирурга, врача-ангиохирурга, в том числе с использованием телемедицинских технологий, с использованием собственных ресурсов организации здравоохранения или по договорам с другими организациями (центрами коллективного пользования, специализированными центрами)', 1, 40, NULL, NULL),
(277, 27, '   Обеспечена возможность проведения полного спектра лабораторных исследований, предусмотренных клиническими протоколами диагностики и лечения болезней системы кровообращения на амбулаторном этапе, с использованием собственных возможностей организации или по договорам с другими организациями здравоохранения (центрами коллективного пользования, специализированными центрами)', 1, 40, NULL, NULL),
(278, 28, '   Обеспечена возможность проведения диагностических исследований, предусмотренных клиническими протоколами диагностики и лечения болезней системы кровообращения на амбулаторном этапе: эхокардиографии, холтеровского мониторирования, велоэргометрии или тредмил-теста, суточного мониторирования ЭКГ и артериального давления, ультразвукового исследования почек, сосудов, – с использованием собственных возможностей организации или по договорам с другими организациями здравоохранения (центрами коллективного пользования, специализированными центрами).\r\nСредние сроки ожидания перечисленных выше функциональных и диагностических исследований, выполняемых в плановом порядке при амбулаторном лечении, не превышают 4 недель от даты установления показаний к их проведению, если иное не предусмотрено по плану медицинского наблюдения пациента', 1, 40, NULL, NULL),
(279, 29, '   Обеспечено выполнение функции врачебной должности не менее 90%', 2, 40, NULL, NULL),
(280, 30, '   Количество выполненных плановых КАГ на 10 тысяч закрепленного населения не ниже среднеобластного показателя за предыдущий отчетный период', 2, 40, NULL, NULL),
(281, 31, '   Организация здравоохранения, осуществляющая организационно-методическое руководство деятельностью кардиологической службы региона, обеспечивает доступность проведения телемедицинского консультирования и (или) консилиума по заявкам территориальных организаций здравоохранения.\r\nФакт проведения консилиума и (или) телемедицинского консультирования документируется', 1, 40, NULL, NULL),
(282, 32, '   Организация здравоохранения, осуществляющая организационно-методическое руководство деятельностью кардиологической службы региона, осуществляет планирование и проведение мероприятий по повышению уровня профессиональных знаний специалистов организаций здравоохранения курируемого региона. Проведение данных мероприятий документируется', 1, 40, NULL, NULL),
(283, 33, '   Планирование и анализ объемов оказанной специализированной помощи населению проводится в разрезе закрепленных территорий.\r\nПланирование и анализ объемов осуществляется с учетом обеспечения равной доступности населению всех закрепленных территорий', 1, 40, NULL, NULL),
(284, 34, '   Организация здравоохранения, осуществляющая организационно-методическое руководство деятельностью кардиологической службы региона, организует работу по оказанию методической помощи закрепленным организациям здравоохранения, в т.ч. с выездом на места.\r\nПроведенные мероприятия документируются', 1, 40, NULL, NULL),
(285, 35, '   Осуществляется взаимодействие и совместная работа с профильными кафедрами (университетами) согласно Положению о клинической организации здравоохранения, Положению об университетской клинике.\r\nСовместные мероприятия в рамках лечебно-диагностической, инновационной, научной деятельности, подбору кадров документируются', 1, 40, NULL, NULL),
(286, 1, '			Деятельность структурного подразделения осуществляется в соответствии с положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении и имеют постоянный доступ к его содержанию', 3, 43, NULL, NULL),
(287, 2, '			Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей.\r\nРезультаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по эндокринологии.\r\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 43, NULL, NULL),
(288, 3, '			Укомплектованность структурного подразделения врачами-эндокринологами не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей врачей-эндокринологов укомплектованность не менее 96 % по занятым должностям', 1, 43, NULL, NULL),
(289, 4, '			Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 43, NULL, NULL),
(290, 5, '			Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего', 1, 43, NULL, NULL),
(291, 6, '			Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 43, NULL, NULL),
(292, 7, '			Наличие первой, высшей категории у врачей-эндокринологов эндокринологических отделений:\r\nне менее 30% на межрайонном уровне\r\nне менее 50% на областном уровне\r\nне менее 80% на республиканском уровне', 3, 43, NULL, NULL),
(293, 8, '			Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев.\r\nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 43, NULL, NULL),
(294, 9, '			Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков.\r\nМедицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 43, NULL, NULL),
(295, 10, '			Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 43, NULL, NULL),
(296, 11, '			Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой', 2, 43, NULL, NULL),
(297, 12, '			Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 43, NULL, NULL),
(298, 13, '			В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники.\r\nПроведение обучения документируется', 3, 43, NULL, NULL),
(299, 14, '			Порядок оказания медицинской помощи в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь.\r\nСоблюдается порядок (алгоритмы, «дорожные карты») оказания срочной и плановой медицинской помощи при эндокринной патологии', 2, 43, NULL, NULL),
(300, 15, '			Обеспечена круглосуточная работа врачей-эндокринологов при условии оказания экстренной специализированной помощи в структурном подразделении.\r\nВ круглосуточном режиме, в том числе в выходные праздничные дни доступен осмотр дежурного врача', 2, 43, NULL, NULL),
(301, 16, '			Круглосуточно обеспечена возможность оказания анестезиолого-реанимационной помощи. Критерий применяется для структурных подразделений межрайонного, городского, областного, республиканского уровня', 1, 43, NULL, NULL),
(302, 17, '			Обеспечена преемственность с амбулаторно-поликлиническими организациями здравоохранения. Обеспечена передача эпикриза, содержащего рекомендации по дальнейшему медицинскому наблюдению в территориальную амбулаторно-поликлиническую организацию', 2, 43, NULL, NULL),
(303, 18, '			В рамках получения пациентом стационарной помощи, в случаях, предусмотренных протоколами диагностики и лечения, обеспечена возможность проведения консультаций врачей-специалистов, в том числе с использованием телемедицинских технологий, с использованием собственных ресурсов организации здравоохранения или другими организациями (центрами коллективного пользования, специализированными центрами) в соответствии с установленным порядком', 1, 43, NULL, NULL),
(304, 19, '			Обеспечена возможность проведения лабораторных исследований в соответствии с клиническими протоколами диагностики и лечения', 1, 43, NULL, NULL),
(305, 20, '			Обеспечена возможность проведения диагностики в соответствии с клиническими протоколами (в организации здравоохранения или определен порядок направления в другие организации здравоохранения)', 1, 43, NULL, NULL),
(306, 21, '			Назначение лекарственных препаратов соответствует установленному диагнозу, требованиям клинических протоколов, инструкции по медицинскому применению лекарственного препарата', 1, 43, NULL, NULL),
(307, 22, '			Оформление медицинской карты стационарного пациента соответствует установленной форме', 3, 43, NULL, NULL),
(308, 23, '			В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 43, NULL, NULL),
(309, 24, '			В структурном подразделении имеются условия для выписки электронных рецептов на лекарственные средства', 2, 43, NULL, NULL),
(310, 25, '			Для врачей-специалистов структурного подразделения обеспечена доступность проведения телемедицинского консультирования, результаты которого документируется и находится в медицинской карте', 2, 43, NULL, NULL),
(311, 26, '			Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 3, 43, NULL, NULL),
(312, 27, '			Показатель среднегодовой занятости койки структурного подразделения на основании годовой отчетности за последние 3 года не менее 300', 3, 43, NULL, NULL),
(313, 28, '			Профильность работы структурного подразделения для районного и городского уровня оказания помощи не менее 60 %, для областного и республиканского не менее 80%', 2, 43, NULL, NULL),
(314, 29, '			В структурном подразделении выполняются запланированные объемы специализированной медицинской помощи, предоставляемой за счет бюджета (число проведенных койко-дней, средняя длительность лечения)', 3, 43, NULL, NULL),
(315, 30, '			Планирование объемов медицинской помощи для структурных подразделений, являющихся межрайонными, осуществляется с учетом обеспечения равной доступности населению всех закрепленных территорий.\r\nУдельный вес пациентов закрепленных территорий для районного уровня не менее 30%, для городского и областного уровня не менее 60%', 2, 43, NULL, NULL),
(316, 31, '			В организации здравоохранения имеется возможность контроля тироидных гормонов (районный, межрайонный, областной/городской, республиканский уровни)', 1, 43, NULL, NULL),
(317, 32, '			В организации здравоохранения имеется возможность контроля половых гормонов, кортизола (межрайонный, областной/городской, республиканский уровни)', 1, 43, NULL, NULL),
(318, 33, '			В организации здравоохранения имеется возможность контроля «редких» гормонов (областной/городской, республиканский уровни)', 1, 43, NULL, NULL),
(319, 34, '			Организовано проведение постоянного мониторирования гликемии (республиканский уровень)', 3, 43, NULL, NULL),
(320, 35, '			Организовано проведение фармакологических диагностических проб (областной, республиканский уровень)', 3, 43, NULL, NULL),
(321, 36, '			Организован проведение (либо направление в другую организацию здравоохранения) лучевых методов диагностики (КТ, МРТ) заболеваний эндокринной системы (областной, республиканский уровень)', 2, 43, NULL, NULL),
(322, 37, '			Организовано проведение (либо направление в другую организацию здравоохранения) радиоизотопных методов исследования (областной, республиканский уровень)', 2, 43, NULL, NULL),
(323, 38, '			Организовано ведение пациентов на помповой инсулинотерапии (республиканский уровень)', 2, 43, NULL, NULL),
(324, 39, '			Участие в проведении клинических испытаний препаратов для лечения заболеваний эндокринной системы (республиканский уровень)', 3, 43, NULL, NULL),
(325, 40, '			Организовано проведение консультаций профессорско-преподавательского состава кафедр медицинских ВУЗов (республиканский уровень)', 3, 43, NULL, NULL),
(326, 41, '			Проведение оперативных вмешательств на щитовидной железе (доброкачественная патология) и паращитовидных железах (областной, республиканский уровни)', 2, 43, NULL, NULL),
(327, 42, '			Проведение операций на щитовидной железе (злокачественная патология) (республиканский уровень (Республиканский центр опухолей щитовидной железы))', 2, 43, NULL, NULL),
(328, 43, '			Проведение операций на надпочечниках (республиканский уровень (ГУ «РНПЦ радиационной медицины и экологии человека»))', 2, 43, NULL, NULL),
(329, 44, '			Проведение операций на гипофизе (республиканский уровень (ГУ «РНПЦ неврологии и нейрохирургии»)', 2, 43, NULL, NULL),
(330, 45, '			Организована работа «Школы сахарного диабета» (районный, межрайонный, областной, республиканский уровень)', 2, 43, NULL, NULL),
(331, 46, '			Внедрение новых методов диагностики и лечения заболеваний эндокринной системы (областной, республиканский уровни)', 3, 43, NULL, NULL),
(332, 47, '			Определен перечень лекарственных средств, необходимых для оказания стационарной медицинской помощи, включая скорую, при заболеваниях эндокринной системы, утвержденный приказом руководителя организации здравоохранения (районный, межрайонный, областной, республиканский уровень)', 1, 43, NULL, NULL),
(333, 48, '			Имеется утвержденный руководителем запас лекарственных средств в количестве, необходимом для оказания стационарной медицинской помощи, включая скорую, при заболеваниях эндокринной системы (районный, межрайонный, областной, республиканский уровень)', 1, 43, NULL, NULL),
(334, 49, '			При выписке из больничного учреждения осуществляется выписка рецептов врача формы №1 на лекарственные средства для лечения пациентов с эндокринными заболеваниями (районный, межрайонный, областной, республиканский уровень)', 1, 43, NULL, NULL),
(335, 1, '    Деятельность структурного подразделения осуществляется в соответствии с положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении и имеют постоянный доступ к его содержанию', 3, 42, NULL, NULL),
(336, 2, '    Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей.\r\nРезультаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по хирургии.\r\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 42, NULL, NULL),
(337, 3, '    Укомплектованность структурного подразделения врачами-хирургами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей-хирургов укомплектованность не менее 96 % по занятым должностям', 1, 42, NULL, NULL),
(338, 4, '    Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 42, NULL, NULL),
(339, 5, '    Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего', 1, 42, NULL, NULL),
(340, 6, '    Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 42, NULL, NULL),
(341, 7, '   Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев.\r\nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 42, NULL, NULL),
(342, 8, '    Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков.\r\nМедицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 42, NULL, NULL),
(343, 9, '    Врачи-хирурги, работающие в центральных районных больницах, прошли повышение квалификации или стажировку на рабочем месте по профилю оказываемой медицинской помощи в структурном подразделении (травматология, урология, детская хирургия, сосудистая хирургия и др.)', 1, 42, NULL, NULL),
(344, 10, '    Минимальный состав и площади отдельных помещений структурного подразделения соответствуют приложению 1 к санитарным нормам и правилам «Санитарно-эпидемиологические требования к организациям, оказывающим медицинскую помощь, в том числе к организациям и проведению санитарно-противоэпидемических мероприятий по профилактике инфекционных заболеваний в этих организациях», утвержденным  постановлением Министерства здравоохранения от 5 июля 2017 г. № 73', 1, 42, NULL, NULL),
(345, 11, '    Обеспечено соблюдение требований к профилактике инфекционных заболеваний при проведении хирургических и оперативных вмешательств, перевязок (пп. 154-163 Постановление Совета Министров Республики Беларусь от 3 марта 2020 г. № 130 «Специфические санитарно-эпидемические требования к содержанию и эксплуатации организаций здравоохранения, иных организаций и индивидуальных предпринимателей, которых осуществляют медицинскую, фармацевтическую деятельность»)', 1, 42, NULL, NULL),
(346, 12, '    Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 42, NULL, NULL),
(347, 13, '    Оснащение хирургического отделения и операционного блока медицинской техникой соответствует утвержденному табелю оснащения и соответствует объемам и видам оказываемой хирургической помощи', 2, 42, NULL, NULL),
(348, 14, '    Структурное подразделение оснащено изделиями медицинского назначения, расходными материалами в достаточном количестве для оказания специализированной медицинской помощи на период не менее 6 месяцев для всех уровней', 1, 42, NULL, NULL),
(349, 15, '    Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 42, NULL, NULL),
(350, 16, '    В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники.\r\nПроведение обучения документируется', 3, 42, NULL, NULL),
(351, 17, '    В организации здравоохранения имеется локальный акт по оформлению контрольного перечня мер по обеспечению хирургической безопасности в операционной', 1, 42, NULL, NULL),
(352, 18, '    Порядок оказания медицинской помощи в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь.\r\nСоблюдается порядок (алгоритмы, «дорожные карты») оказания срочной и плановой медицинской помощи при хирургической патологии', 2, 42, NULL, NULL),
(353, 19, '    Обеспечена круглосуточная работа врачей-хирургов при условии оказания экстренной специализированной помощи в структурном подразделении.\r\nВ круглосуточном режиме, в том числе в выходные праздничные дни доступен осмотр дежурного врача', 2, 42, NULL, NULL),
(354, 20, '    В организации здравоохранения обеспечено круглосуточное выполнение экстренных хирургических вмешательств, либо транспортировка пациента в другой стационар в течение 60 минут', 1, 42, NULL, NULL),
(355, 21, '    В структурном подразделении обеспечена возможность одновременного участия 2 врачей-хирургов при выполнении полостных хирургических вмешательств', 1, 42, NULL, NULL),
(356, 22, '    Круглосуточно обеспечена возможность оказания анестезиолого-реанимационной помощи. Критерий применяется для структурных подразделений межрайонного, городского, областного, республиканского уровня', 1, 42, NULL, NULL),
(357, 23, '    В организации здравоохранения обеспечивается необходимый объем и структура резервного запаса продуктов крови, ее компонентов, место и условия хранения, назначены ответственные медицинские работники', 1, 42, NULL, NULL),
(358, 24, '    В структурном подразделении в обязательном порядке осуществляется направление операционного (биопсийного) материала и биологических жидкостей на патогистологическое (бактериологическое) исследование', 1, 42, NULL, NULL),
(359, 25, '    В организации здравоохранения межрайонного, областного, республиканского уровней обеспечено круглосуточное проведение диагностических и лечебных рентгенэндоваскулярных вмешательств или обеспечена транспортировка пациента в течение 60 минут в другой стационар, имеющий дежурную службу рентгенэндоваскулярной хирургии', 1, 42, NULL, NULL),
(360, 26, '    Обеспечена преемственность с амбулаторно-поликлиническими организациями здравоохранения. Обеспечена передача эпикриза, содержащего рекомендации по дальнейшему медицинскому наблюдению в территориальную амбулаторно-поликлиническую организацию', 2, 42, NULL, NULL),
(361, 27, '    В рамках получения пациентом стационарной помощи, в случаях, предусмотренных протоколами диагностики и лечения, обеспечена возможность проведения консультаций врачей-хирургов, в том числе с использованием телемедицинских технологий, с использованием собственных ресурсов организации здравоохранения или другими организациями (центрами коллективного пользования, специализированными центрами) в соответствии с установленным порядком', 1, 42, NULL, NULL),
(362, 28, '    Обеспечена возможность проведения лабораторных исследований в соответствии с клиническими протоколами диагностики и лечения', 1, 42, NULL, NULL),
(363, 29, '    Обеспечена возможность проведения диагностики в соответствии с клиническими протоколами (в организации здравоохранения или определён порядок направления в другие организации здравоохранения)', 1, 42, NULL, NULL),
(364, 30, '    Назначение лекарственных препаратов соответствует установленному диагнозу, требованиям клинических протоколов, инструкции по медицинскому применению лекарственного препарата', 1, 42, NULL, NULL),
(365, 31, '    Оформление медицинской карты стационарного пациента соответствует установленной форме', 3, 42, NULL, NULL),
(366, 32, '   В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 42, NULL, NULL),
(367, 33, '    В медицинской карте стационарного больного оформлен предоперационный эпикриз, указываются обоснование хирургического вмешательства с учетом установленного диагноза, способа обезболивания, вида оперативного доступа, возможных рисков', 1, 42, NULL, NULL),
(368, 34, '    Протоколы хирургических вмешательств оформляются в журнале записи оперативных вмешательств, либо в электронном виде с внесением в медицинскую карту стационарного больного', 2, 42, NULL, NULL),
(369, 35, '    В структурном подразделении имеются условия для выписки электронных рецептов на лекарственные средства', 2, 42, NULL, NULL),
(370, 36, '    Для врачей-специалистов структурного подразделения обеспечена доступность проведения телемедицинского консультирования, результаты которого документируется и находится в медицинской карте', 2, 42, NULL, NULL),
(371, 37, '    Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 3, 42, NULL, NULL),
(372, 38, '    Число хирургических вмешательств на 1 штатную должность врача-хирурга в год не менее 10 на 1 развернутую хирургическую койку на районном, не менее 20 на межрайонном (городском), областном и республиканском уровнях', 2, 42, NULL, NULL),
(373, 39, '    Число хирургических (ассистенций) вмешательств в год не менее 100 на одну штатную должность', 2, 42, NULL, NULL),
(374, 40, '    Хирургическая активность не менее 40 % на районном, не менее 60% на межрайонном, областном, и республиканском уровнях', 2, 42, NULL, NULL),
(375, 41, '    Доля лапароскопических вмешательств при остром аппендиците не менее 30 % (при наличии лапароскопической стойки)', 3, 42, NULL, NULL),
(376, 42, '    Доля лапароскопических вмешательств при остром холецистите не менее 70 % (при наличии лапароскопической стойки)', 3, 42, NULL, NULL),
(377, 43, '    Доля лапароскопических вмешательств при хроническом холецистите не менее 80 % (при наличии лапароскопической стойки)', 3, 42, NULL, NULL),
(378, 44, '    Показатель среднегодовой занятости койки структурного подразделения на основании годовой отчетности за последние 3 года не менее 300', 3, 42, NULL, NULL),
(379, 45, '    Профильность работы структурного подразделения для районного и городского уровня оказания помощи не менее 60 %, для областного и республиканского не менее 80 %', 2, 42, NULL, NULL),
(380, 46, '   В структурном подразделении выполняются запланированные объемы специализированной медицинской помощи, предоставляемой за счет бюджета (число проведенных койко-дней, средняя длительность лечения)', 3, 42, NULL, NULL),
(381, 47, '    Планирование объемов медицинской помощи для структурных подразделений, являющихся межрайонными, осуществляется с учетом обеспечения равной доступности населению всех закрепленных территорий.\r\nУдельный вес пациентов закрепленных территорий для районного уровня не менее 30 %, для городского и областного уровня не менее 60 %', 2, 42, NULL, NULL),
(382, 1, '   Деятельность структурного подразделения осуществляется в соответствии с положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении и имеют постоянный доступ к его содержанию', 3, 45, NULL, NULL);
INSERT INTO `mark` (`id_mark`, `str_num`, `mark_name`, `mark_class`, `id_criteria`, `date_close`, `date_open`) VALUES
(383, 2, '   Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей.\r\nРезультаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по акушерству и гинекологии.\r\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 45, NULL, NULL),
(384, 3, '   Укомплектованность структурного подразделения врачами-акушерами-гинекологами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей-акушеров-гинекологов укомплектованность не менее 96 % по занятым должностям', 1, 45, NULL, NULL),
(385, 4, '   Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 45, NULL, NULL),
(386, 5, '   Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего', 1, 45, NULL, NULL),
(387, 6, '   Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 45, NULL, NULL),
(388, 7, '   Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев.\r\nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 45, NULL, NULL),
(389, 8, '   Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков.\r\nМедицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 45, NULL, NULL),
(390, 9, '   Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 45, NULL, NULL),
(391, 10, '   Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой', 2, 45, NULL, NULL),
(392, 11, '   Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 45, NULL, NULL),
(393, 12, '   В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники.\r\nПроведение обучения документируется', 3, 45, NULL, NULL),
(394, 13, '   Порядок оказания медицинской помощи в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи, требованиями инструкции по организации разноуровневой системы акушерско-гинекологической и перинатальной помощи и клиническими протоколами, законодательством Республики Беларусь.\r\nСоблюдается порядок (алгоритмы, «дорожные карты») оказания срочной и плановой медицинской помощи', 2, 45, NULL, NULL),
(395, 14, '   Обеспечена круглосуточная работа врачей-акушеров-гинекологов при условии оказания экстренной специализированной помощи в структурном подразделении.\r\nВ круглосуточном режиме, в том числе в выходные, праздничные дни доступен осмотр дежурного врача', 2, 45, NULL, NULL),
(396, 15, '   Круглосуточно обеспечена возможность оказания анестезиолого-реанимационной помощи. Критерий применяется для структурных подразделений межрайонного, городского, областного, республиканского уровня', 1, 45, NULL, NULL),
(397, 16, '   Обеспечена преемственность с амбулаторно-поликлиническими организациями здравоохранения. Обеспечена передача эпикриза, содержащего рекомендации по дальнейшему медицинскому наблюдению, в территориальную амбулаторно-поликлиническую организацию', 2, 45, NULL, NULL),
(398, 17, '   В рамках получения пациентом стационарной помощи, в случаях, предусмотренных протоколами диагностики и лечения, обеспечена возможность проведения консультаций врачей-специалистов, в том числе с использованием телемедицинских технологий, с использованием собственных ресурсов организации здравоохранения или другими организациями (центрами коллективного пользования, специализированными центрами) в соответствии с установленным порядком', 1, 45, NULL, NULL),
(399, 18, '   Обеспечена возможность проведения лабораторных исследований в соответствии с клиническими протоколами диагностики и лечения', 1, 45, NULL, NULL),
(400, 19, '   Обеспечена возможность проведения диагностики в соответствии с клиническими протоколами (в организации здравоохранения или определён порядок направления в другие организации здравоохранения)', 1, 45, NULL, NULL),
(401, 20, '   Назначение лекарственных препаратов соответствует установленному диагнозу, требованиям клинических протоколов, инструкции по медицинскому применению лекарственного препарата', 1, 45, NULL, NULL),
(402, 21, '   Оформление медицинской карты стационарного пациента соответствует установленной форме', 3, 45, NULL, NULL),
(403, 22, '   В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 45, NULL, NULL),
(404, 23, '   В структурном подразделении имеются условия для выписки электронных рецептов на лекарственные средства', 2, 45, NULL, NULL),
(405, 24, '   Для врачей-специалистов структурного подразделения обеспечена доступность проведения телемедицинского консультирования, результаты которого документируются и находятся в медицинской карте', 2, 45, NULL, NULL),
(406, 25, '   Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 3, 45, NULL, NULL),
(407, 26, '   Показатель среднегодовой занятости койки структурного подразделения на основании годовой отчетности за последние 3 года не менее 300', 3, 45, NULL, NULL),
(408, 27, '   Профильность работы структурного подразделения для районного и городского уровня оказания помощи не менее 60 %, для областного и республиканского не менее 80 %', 2, 45, NULL, NULL),
(409, 28, '   В структурном подразделении выполняются запланированные объемы специализированной медицинской помощи, предоставляемой за счет бюджета (число проведенных койко-дней, средняя длительность лечения)', 3, 45, NULL, NULL),
(410, 29, '   Планирование объемов медицинской помощи для структурных подразделений, являющихся межрайонными, осуществляется с учетом обеспечения равной доступности населению всех закрепленных территорий.\r\nУдельный вес пациентов закрепленных территорий для районного уровня не менее 30%, для городского и областного уровня не менее 60%', 2, 45, NULL, NULL),
(411, 30, '   Врачебные консультации (консилиумы) и их решения оформляются в соответствии с требованиями инструкции о порядке проведения врачебных консультаций (консилиумов)', 3, 45, NULL, NULL),
(412, 31, '   В организации здравоохранения круглосуточно обеспечено проведение лабораторных исследований', 2, 45, NULL, NULL),
(413, 32, '   В организации здравоохранения круглосуточно обеспечено проведение ультразвуковых исследований', 1, 45, NULL, NULL),
(414, 33, '   В организации здравоохранения круглосуточно обеспечено проведение кардиотокографии ', 1, 45, NULL, NULL),
(415, 34, '   В организации здравоохранения в период нахождения пациента на стационарном лечении обеспечена возможность проведения кольпоскопии', 3, 45, NULL, NULL),
(416, 35, '   В составе акушерского отделения выделен отдельный 24-часовой акушерский пост для ведения родов (критерий применяется для стационарных организаций здравоохранения при оказании медицинской помощи по родовспоможению)', 1, 45, NULL, NULL),
(417, 36, '   В акушерском отделении при проведении родов имеется возможность наблюдения за состоянием плода (проводится кардиотокография плода)', 1, 45, NULL, NULL),
(418, 37, '   В структурном подразделении (в организации здравоохранения) имеется врач-неонатолог либо определено лицо, на которое возложены обязанности по оказанию медицинской помощи новорожденному (критерий применяется для стационарных организаций здравоохранения при оказании медицинской помощи по родовспоможению)', 1, 45, NULL, NULL),
(419, 38, '   Наблюдение за родильницей в родовом отделении (блоке) осуществляется в течение 2 часов после родов (пульс, артериальное давление, цвет кожи и слизистых, размеры, положение и плотность матки, контроль количества выделений из половых путей) каждые 20–30 мин. Перевод в послеродовую палату осуществляется через 2 часа после завершения медицинской помощи по родовспоможению', 1, 45, NULL, NULL),
(420, 39, '   В акушерских отделениях организована работа по грудному вскармливанию', 3, 45, NULL, NULL),
(421, 40, '   Организован аудиологический скрининг для новорожденных', 2, 45, NULL, NULL),
(422, 41, '   Организована работа по обеспечению проведения скрининга новорожденных по ранней диагностике ретинопатии недоношенных (организации здравоохранения III-IV технологических уровней оказания акушерско-гинекологической и перинатальной помощи (далее – технологический уровень)', 2, 45, NULL, NULL),
(423, 42, '   Удельный вес лапароскопического доступа при плановых абдоминальных хирургических вмешательствах составляет не менее:\r\n50% для II технологического уровня\r\n60% для III технологического уровня\r\n70% для IV технологического уровня', 3, 45, NULL, NULL),
(424, 43, '   В структурном подразделении обеспечена возможность одновременного участия 2 врачей-хирургов (один из которых врач-акушер-гинеколог) при выполнении хирургических вмешательств', 2, 45, NULL, NULL),
(425, 44, '   В структурном подразделении хирургическая (оперативная) активность не менее:\r\n50 % на I – II технологическом уровне\r\n70 % на III – IV технологическом уровне', 2, 45, NULL, NULL),
(426, 45, '   В организации здравоохранения обеспечено выполнение сложных и (или) высокотехнологичных хирургических вмешательств (III-IV технологический уровень)', 2, 45, NULL, NULL),
(427, 46, '   В организации здравоохранения III-IV технологического уровня обеспечено проведение телемедицинского консультирования для пациентов организаций здравоохранения I – III технологических уровней', 2, 45, NULL, NULL),
(428, 47, '   В организации здравоохранения обеспечено проведение компьютерной и магнитно-резонансной томографии (IV технологический уровень)', 2, 45, NULL, NULL),
(429, 1, '	Деятельность структурного подразделения осуществляется в соответствии с положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении и имеют постоянный доступ к его содержанию', 3, 46, NULL, NULL),
(430, 2, '   Руководителем организации здравоохранения определены ответственные лица за организацию оказания специализированной медицинской помощи', 3, 46, NULL, NULL),
(431, 3, '    Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей.\r\nРезультаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по экстренной и неотложной патологии.\r\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 46, NULL, NULL),
(432, 4, '    Укомплектованность структурного подразделения врачами анестезиологами-реаниматологами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей анестезиологов-реаниматологов укомплектованность не менее 96 % по занятым должностям', 1, 46, NULL, NULL),
(433, 5, '    Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 46, NULL, NULL),
(434, 6, '    Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего', 1, 46, NULL, NULL),
(435, 7, '    Наличие квалификационных категорий у врачей анестезиологов-реаниматологов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 46, NULL, NULL),
(436, 8, '   Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев.\r\nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 46, NULL, NULL),
(437, 9, '    Руководителем отделения анестезиологии и реаниматологии осуществляется систематическое обучение сотрудников смежных отделений методам оказания медицинской помощи при развитии неотложных, терминальных состояний, производится обучение проведению комплекса сердечно-легочной реанимации, ведется учет результатов обучения', 2, 46, NULL, NULL),
(438, 10, '    Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков.\r\nМедицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 46, NULL, NULL),
(439, 11, '    Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 46, NULL, NULL),
(440, 12, '    Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой', 2, 46, NULL, NULL),
(441, 13, '    Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 46, NULL, NULL),
(442, 14, '    Медицинская техника, подлежащая метрологическому контролю, проходит периодическую поверку и калибровку согласно графику, утвержденному руководителем организации здравоохранения', 3, 46, NULL, NULL),
(443, 15, '    В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники.\r\nПроведение обучения документируется', 3, 46, NULL, NULL),
(444, 16, '    Порядок оказания медицинской помощи в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь.\r\nСоблюдается порядок (алгоритмы, «дорожные карты») оказания срочной медицинской помощи при экстренной и неотложной патологии', 2, 46, NULL, NULL),
(445, 17, '    Обеспечена возможность осмотра пациентов при возникновении состояний, требующих оказания неотложной медицинской помощи или необходимости оказания анестезиологического пособия врачом анестезиологом-реаниматологом в рабочее время', 1, 46, NULL, NULL),
(446, 18, '    Назначение лекарственных препаратов соответствует установленному диагнозу, требованиям клинических протоколов, инструкции по медицинскому применению лекарственного препарата', 1, 46, NULL, NULL),
(447, 19, '    Ведение первичной медицинской документации в отделении анестезиологии и реаниматологии в соответствии с требованиями законодательства', 2, 46, NULL, NULL),
(448, 20, '    Согласие пациента или его законного представителя на проведение медицинских вмешательств оформляется в медицинских документах в соответствии с требованиями законодательства', 2, 46, NULL, NULL),
(449, 21, '        В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 46, NULL, NULL),
(450, 22, '    Организовано наблюдение пациентов в послеоперационном периоде (палата пробуждения или послеоперационная палата, которая оснащена в соответствии с требованиями нормативных правовых актов).', 1, 46, NULL, NULL),
(451, 23, '    Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи', 2, 46, NULL, NULL),
(452, 24, '    Ведется журнал оценки готовности рабочего места врача анестезиолога-реаниматолога. Осуществляется информирование ответственных лиц о неисправности медицинской техники, медицинских изделий, отсутствии медицинских изделий, лекарственных препаратов', 2, 46, NULL, NULL),
(453, 25, '    Созданы условия для обеспечения медицинскими газами', 1, 46, NULL, NULL),
(454, 1, '	Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 44, NULL, NULL),
(455, 2, '	Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей.\r\nРезультаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по акушерству и гинекологии.\r\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 44, NULL, NULL),
(456, 3, '	Укомплектованность структурного подразделения врачами-акушерами-гинекологами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей-акушеров-гинекологов укомплектованность не менее 96 % по занятым должностям ', 1, 44, NULL, NULL),
(457, 4, '	Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 44, NULL, NULL),
(458, 5, 'Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего ', 1, 44, NULL, NULL),
(459, 6, '	Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 44, NULL, NULL),
(460, 7, '	Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев.\r\nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 44, NULL, NULL),
(461, 8, 'Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков.\r\nМедицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи ', 3, 44, NULL, NULL),
(462, 9, '	Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 44, NULL, NULL),
(463, 10, '	Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой', 2, 44, NULL, NULL),
(464, 11, '	Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 44, NULL, NULL),
(465, 12, '	В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники.\r\nПроведение обучения документируется', 3, 44, NULL, NULL),
(466, 13, '	Порядок оказания медицинской помощи в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь.\r\nСоблюдается порядок (алгоритмы) оказания срочной и плановой медицинской помощи при патологии', 2, 44, NULL, NULL),
(467, 14, '	Работа структурного подразделения обеспечена в сменном режиме ', 2, 44, NULL, NULL),
(468, 15, '	Определен порядок оказания медицинской помощи пациентам с гинекологическими заболеваниями, беременным на период отсутствия в организации здравоохранения врача-специалиста (районный, городской уровень)', 1, 44, NULL, NULL),
(469, 16, '	Соблюдается порядок медицинского наблюдения пациентов с гинекологическими заболеваниями в амбулаторных условиях. Руководителем структурного подразделения осуществляется анализ результатов медицинского наблюдения пациентов', 1, 44, NULL, NULL),
(470, 17, '	Соблюдается порядок медицинского наблюдения беременных, женщин в послеродовом периоде. Руководителем структурного подразделения осуществляется анализ результатов медицинского наблюдения беременных', 1, 44, NULL, NULL),
(471, 18, '	Обеспечена преемственность с больничными организациями здравоохранения, в том числе, оказывающими медицинскую помощь беременным, роженицам, родильницам. Определен порядок направления на плановую и экстренную госпитализацию пациентов гинекологического профиля, беременных, рожениц, родильниц. Обеспечено выполнение на амбулаторном этапе рекомендаций по дальнейшему медицинскому наблюдению после выписки\r\nНаправление на госпитализацию беременных, рожениц, родильниц и пациентов гинекологического профиля осуществляется в соответствии с требованиями инструкции по организации разноуровневой системы акушерско-гинекологической и перинатальной помощи', 2, 44, NULL, NULL),
(472, 19, '	Обеспечена возможность консультаций врачей-специалистов в соответствии с клиническими протоколами диагностики и лечения (в организации здравоохранения или определён порядок направления в другие организации здравоохранения)', 1, 44, NULL, NULL),
(473, 20, '	Обеспечена возможность проведения диагностики в соответствии с клиническими протоколами, регламентирующими оказание акушерско-гинекологической помощи в амбулаторных условиях (в организации здравоохранения или определён порядок направления в другие организации здравоохранения)', 1, 44, NULL, NULL),
(474, 21, '	Обеспечено назначение лечения пациентам, ведение беременных в амбулаторных условиях согласно клиническим протоколам', 1, 44, NULL, NULL),
(475, 22, '	Оформление медицинской карты амбулаторного больного, индивидуальной карты беременной и родильницы соответствует установленной форме', 3, 44, NULL, NULL),
(476, 23, '	В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 44, NULL, NULL),
(477, 24, '	Осуществляется выписка электронных рецептов на лекарственные средства', 2, 44, NULL, NULL),
(478, 25, '	Для врачей-специалистов структурного подразделения обеспечена доступность проведения телемедицинского консультирования, результаты которого документируется\r\nи находится в медицинской карте', 2, 44, NULL, NULL),
(479, 26, '	Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 3, 44, NULL, NULL),
(480, 27, '	Обеспечено выполнение функции врачебной должности не менее 90%', 2, 44, NULL, NULL),
(481, 28, '	Врачебные консультации (консилиумы) и их решения оформляются в соответствии с требованиями инструкции о порядке проведения врачебных консультаций (консилиумов)', 2, 44, NULL, NULL),
(482, 29, '	Диспансеризация женщин соответствует требованиям нормативных документов', 1, 44, NULL, NULL),
(483, 30, '	Организована работа по профилактическим медицинским осмотрам, оказанию медицинской помощи (медицинскому наблюдению, диагностике и лечению) врачами-акушерами-гинекологами детей (девочек) в возрасте до 18 лет', 1, 44, NULL, NULL),
(484, 31, '	Обеспечена работа по оказанию специализированной медицинской помощи женщинам с соматическими заболеваниями во время прегравидарной подготовки, беременности и в послеродовом периоде в городских (областных) центрах «Соматические заболевания и беременность»', 2, 44, NULL, NULL),
(485, 32, '	Организована пренатальная диагностика врожденных пороков развития на межрайонном (городском), областном (городском), республиканском технологических уровнях оказания акушерско-гинекологической и перинатальной помощи (далее – технологический уровень) (в соответствии с локальными правовыми актами)', 1, 44, NULL, NULL),
(486, 33, '	Организована работа по проведению республиканского врачебного консилиума по пренатальным проблемам у плода (IV технологический уровень)	', 1, 44, NULL, NULL),
(487, 34, '	Организована преемственность по медицинскому наблюдению женщин (в том числе в период беременности) между амбулаторной и стационарной службой', 1, 44, NULL, NULL),
(488, 35, '	Организована работа по обследованию и лечению бесплодных пар (в организациях здравоохранения, определенных локальными правовыми актами)', 2, 44, NULL, NULL),
(489, 36, '	В структурном подразделении определен порядок организации оказания экстренной и неотложной медицинской помощи пациентам с тромбоэмболическими и геморрагическими осложнениями, эклампсией, с болезнями системы кровообращения, пациентам с анафилаксией. Алгоритмы оказания экстренной медицинской и неотложной помощи, в том числе комплекса мероприятий сердечно-легочной реанимации, соответствуют условиям оказания медицинской помощи в структурном подразделении и утверждены локальным правовым актом', 1, 44, NULL, NULL),
(490, 37, '	В структурном подразделении имеются лекарственные препараты и медицинские изделия для оказания экстренной медицинской помощи в соответствии с требованиями клинических протоколов	', 2, 44, NULL, NULL),
(491, 38, '	В структурном подразделении проводятся занятия с медицинскими работниками по освоению теоретических и практических навыков оказания экстренной и неотложной медицинской помощи, в том числе оказанию сердечно-легочной реанимации с последующим контролем знаний с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев', 2, 44, NULL, NULL),
(492, 39, '	В структурном подразделении обеспечено проведение лабораторных исследований', 2, 44, NULL, NULL),
(493, 40, '	В структурном подразделении обеспечено проведение ультразвуковых исследований', 1, 44, NULL, NULL),
(494, 41, '	В структурном подразделении обеспечено проведение кардиотокографии', 1, 44, NULL, NULL),
(495, 42, '	В структурном подразделении обеспечена возможность проведения кольпоскопии	', 3, 44, NULL, NULL),
(496, 43, '	В структурном подразделении организована работа Школы матери, обучение навыкам грудного вскармливания', 3, 44, NULL, NULL),
(497, 1, '     Деятельность структурного подразделения осуществляется в соответствии с положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении и имеют постоянный доступ к его содержанию', 3, 47, NULL, NULL),
(498, 2, '     Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей.\r\nРезультаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по профилю.\r\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 47, NULL, NULL),
(499, 3, '     Укомплектованность структурного подразделения врачами-специалистами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей-специалистов укомплектованность не менее 96 % по занятым должностям', 1, 47, NULL, NULL),
(500, 4, '     Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 47, NULL, NULL),
(501, 5, '     Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего', 1, 47, NULL, NULL),
(502, 6, '     Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 47, NULL, NULL),
(503, 7, '     Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев.\r\nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 47, NULL, NULL),
(504, 8, '     Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков.\r\nМедицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 47, NULL, NULL),
(505, 9, '    Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 1, 47, NULL, NULL),
(506, 10, '      Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой', 2, 47, NULL, NULL),
(507, 11, '     Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 47, NULL, NULL),
(508, 12, '      В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники.\r\nПроведение обучения документируется', 3, 47, NULL, NULL),
(509, 13, '      Порядок оказания медицинской помощи в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь.\r\nСоблюдается порядок (алгоритмы, «дорожные карты») оказания срочной и плановой медицинской помощи', 2, 47, NULL, NULL),
(510, 14, '      Обеспечена круглосуточная работа врачей-специалистов отделения при условии оказания экстренной специализированной помощи в структурном подразделении.\r\nВ круглосуточном режиме, в том числе в выходные, праздничные дни доступен осмотр дежурного врача', 2, 47, NULL, NULL),
(511, 15, '     Круглосуточно обеспечена возможность оказания анестезиолого-реанимационной помощи. Критерий применяется для структурных подразделений межрайонного, городского, областного, республиканского уровня', 1, 47, NULL, NULL),
(512, 16, '     Обеспечена преемственность с амбулаторно-поликлиническими организациями здравоохранения. Обеспечена передача эпикриза, содержащего рекомендации по дальнейшему медицинскому наблюдению, в территориальную амбулаторно-поликлиническую организацию', 2, 47, NULL, NULL),
(513, 17, '     В рамках получения пациентом стационарной помощи, в случаях, предусмотренных протоколами диагностики и лечения, обеспечена возможность проведения консультаций врачей-специалистов, в том числе с использованием телемедицинских технологий, с использованием собственных ресурсов организации здравоохранения или другими организациями (центрами коллективного пользования, специализированными центрами) в соответствии с установленным порядком', 1, 47, NULL, NULL),
(514, 18, '     Обеспечена возможность проведения лабораторных исследований в соответствии с клиническими протоколами диагностики и лечения', 1, 47, NULL, NULL),
(515, 19, '      Обеспечена возможность проведения диагностики в соответствии с клиническими протоколами (в организации здравоохранения или определён порядок направления в другие организации здравоохранения)', 1, 47, NULL, NULL),
(516, 20, '      Назначение лекарственных препаратов соответствует установленному диагнозу, требованиям клинических протоколов, инструкции по медицинскому применению лекарственного препарата', 1, 47, NULL, NULL),
(517, 21, '     Оформление медицинской карты стационарного пациента соответствует установленной форме', 3, 47, NULL, NULL),
(518, 22, '      В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 1, 47, NULL, NULL),
(519, 23, '      В структурном подразделении имеются условия для выписки электронных рецептов на лекарственные средства', 2, 47, NULL, NULL),
(520, 24, '     Для врачей-специалистов структурного подразделения обеспечена доступность проведения телемедицинского консультирования, результаты которого документируются и находятся в медицинской карте', 2, 47, NULL, NULL),
(521, 25, '     Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 3, 47, NULL, NULL),
(522, 26, '     Показатель среднегодовой занятости койки структурного подразделения на основании годовой отчетности за последние 3 года не менее 300', 3, 47, NULL, NULL),
(523, 27, '     Профильность работы структурного подразделения для районного и городского уровня оказания помощи не менее 60 %, для областного и республиканского не менее 80 %', 2, 47, NULL, NULL),
(524, 28, '      В структурном подразделении выполняются запланированные объемы специализированной медицинской помощи, предоставляемой за счет бюджета (число проведенных койко-дней, средняя длительность лечения)', 3, 47, NULL, NULL),
(525, 29, '      Планирование объемов медицинской помощи для структурных подразделений, являющихся межрайонными, осуществляется с учетом обеспечения равной доступности населению всех закрепленных территорий.\r\nУдельный вес пациентов закрепленных территорий для районного уровня не менее 30 %, для городского и областного уровня не менее 60 %', 2, 47, NULL, NULL),
(526, 30, '     В структурном подразделении проводится анкетирование пациентов для оценки удовлетворенности качеством оказания медицинской помощи.\r\nРезультаты анкетирования используются для проведения мероприятий по улучшению деятельности структурного подразделения', 3, 47, NULL, NULL),
(527, 31, '      В организации здравоохранения обеспечена возможность установки зонда для кормления (критерий применим начиная с отделений терапевтического профиля ЦРБ)', 2, 47, NULL, NULL),
(528, 32, '      В организации здравоохранения обеспечено выполнение диагностического и лечебного парацентеза, плевральной пункции (критерий применим начиная с отделений терапевтического профиля ЦРБ)', 1, 47, NULL, NULL),
(529, 33, '      Обеспечено проведение оценки выраженности боли\r\nс помощью визуально-аналоговой шкалы (ВАШ) или других шкал', 1, 47, NULL, NULL),
(530, 34, '      Обеспечено купирование боли в соответствии с протоколом лечения', 1, 47, NULL, NULL),
(531, 35, '      Наличие лекарственных препаратов и медицинских изделий в соответствии с требованиями клинических протоколов и с формуляром лекарственных средств, утвержденных руководителем организации здравоохранения', 3, 47, NULL, NULL),
(532, 36, '      Обеспечена возможность оказания экстренной и неотложной медицинской помощи', 2, 47, NULL, NULL),
(533, 37, '       В структурном подразделении имеются лекарственные препараты и медицинские изделия для оказания экстренной и неотложной медицинской помощи в соответствии с требованиями клинических протоколов', 2, 47, NULL, NULL),
(534, 38, '     В организации здравоохранения круглосуточно обеспечена возможность оказания хирургической помощи пациентам терапевтического профиля (критерий применим начиная с отделений терапевтического профиля ЦРБ)', 2, 47, NULL, NULL),
(535, 39, '      В обязательном порядке осуществляется направление операционного (биопсийного) материала на патологоанатомическое исследование', 2, 47, NULL, NULL),
(536, 1, '                  	Деятельность организации здравоохранения осуществляется в соответствии с Уставом	', 2, 39, NULL, NULL),
(537, 2, '                 	Наличие документов в соответствии с номенклатурой дел и выполнение утвержденных руководителем организации документов и локальных правовых актов (далее – ЛПА):\r\nкомплексный план основных организационных мероприятий;\r\nо режиме работы организации здравоохранения, структурных подразделений;\r\nЛПА о распределении обязанностей между заместителями руководителя;\r\nо трудовой и исполнительской дисциплине;\r\nправила внутреннего трудового распорядка.', 2, 39, NULL, NULL),
(538, 3, '                      	Деятельность структурных подразделений осуществляется в соответствии с утвержденным положением о структурном подразделении, имеется ознакомление  работников с положениями о структурных подразделениях	', 3, 39, NULL, NULL),
(539, 4, '                      	Руководителем организации здравоохранения определены ответственные лица за организацию оказания специализированной медицинской помощи	', 3, 39, NULL, NULL),
(540, 5, '                      	Выполнение плановых показателей деятельности и проведение их анализа с принятием организационно-управленческих решений.  Выполнение управленческих решений по улучшению качества медицинской помощи за последний отчетный период или год	', 1, 39, NULL, NULL),
(541, 6, '                    	Наличие и выполнение в организации здравоохранения ЛПА, регламентирующего порядок по организации и проведении клинических конференций. Проведение в организации здравоохранения клинических конференций; оформление протоколов проведения клинических конференций.	', 2, 39, NULL, NULL),
(542, 7, '                    	Проводится обучение и контроль знаний медицинских работников клинических протоколов по профилям заболеваний, состояниям, синдромам, порядков и методов оказания медицинской помощи (далее – клинические протоколы), соответствующих профилю оказываемой медицинской помощи	', 2, 39, NULL, NULL),
(543, 8, '                   	Наличие на рабочих местах врачей-специалистов клинических протоколов, соответствующих профилю оказываемой медицинской помощи, либо обеспечен постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи	', 3, 39, NULL, NULL),
(544, 9, '                      	Внедрение в практику работы новых методов оказания медицинской помощи и (или) малоинвазивных методик диагностики и лечения за последний отчетный период или год	', 3, 39, NULL, NULL),
(545, 10, '                  	Проводится планирование и осуществление мероприятий по обеспечению радиационной безопасности в соответствии с законодательством. Имеется лицензия на данный вид деятельности.', 1, 39, NULL, NULL),
(546, 11, '                  	Обеспечено проведение предабортного психологического консультирования женщин, обратившихся за проведением искусственного прерывания беременности	', 2, 39, NULL, NULL),
(547, 12, '                  	Наличие на информационных стендах в организации здравоохранения информации о правилах внутреннего распорядка для пациентов	', 3, 39, NULL, NULL),
(548, 13, '                   	Наличие и выполнение в организации здравоохранения ЛПА, регламентирующего порядок организации работы по защите персональных данных. Имеется политика организации в отношении обработки персональных данных. Проводится контроль за обработкой персональных данных; имеется информированное согласие пациента на обработку персональных данных	', 2, 39, NULL, NULL),
(549, 14, '                 	Наличие и выполнение требований системы управления охраной труда, обеспечивающей идентификацию опасностей, оценку профессиональных рисков, определение мер управления профессиональными рисками и анализ их результативности. Проводятся первичный, повторный, целевые (при необходимости) инструктажи с сотрудниками структурного подразделения. Разрабатываются инструкции по охране труда для профессий рабочих и (или) отдельных видов работ. Осуществляется контроль за соблюдением требований по охране труда	', 2, 39, NULL, NULL),
(550, 15, '                 	Наличие и выполнение общеобъектовой инструкции по пожарной безопасности. Определены лица, ответственные за пожарную безопасность, проводится  обучение по  программе пожарно-технического минимума с последующей проверкой знаний.  Осуществляется контроль за соблюдением требований  по пожарной безопасности	', 2, 39, NULL, NULL),
(551, 16, '                  	Отсутствие фактов нарушения  правил охраны труда, техники безопасности и пожарной безопасности работниками организации здравоохранения за последний отчетный период или год исполнительской и трудовой дисциплины, обоснованных жалоб  в организации здравоохранения за последний отчетный период или год	', 3, 39, NULL, NULL),
(552, 17, '                  	Организована работа комиссии по вопросам медицинской этики и деонтологии организации здравоохранения.	', 2, 39, NULL, NULL),
(553, 18, '                  	Наличие в организации здравоохранения ЛПА, регламентирующего порядок по обеспечению доступности медицинской помощи', 3, 39, NULL, NULL),
(554, 19, '                   	График работы врачей-специалистов обеспечивает доступность специализированной медицинской помощи по профилю заболевания', 1, 39, NULL, NULL),
(555, 20, '                   	Наличие в  приемном отделении порядка (алгоритма) распределения потоков пациентов при  обращении в  организацию здравоохранения	', 3, 39, NULL, NULL),
(556, 21, '                   	Обеспечена доступность проведения телемедицинского консультирования, результаты которого документируются\r\n и находятся в медицинской карте ', 2, 39, NULL, NULL),
(557, 22, '                     	Наличие информации о деятельности организации здравоохранения, размещенной на информационных стендах и на официальном интернет-сайте организации здравоохранения	', 2, 39, NULL, NULL),
(558, 23, '                      	Официальный интернет-сайт организации здравоохранения функционирует в порядке, установленном законодательством	', 2, 39, NULL, NULL),
(559, 24, '                     	Наличие на информационных стендах в организации здравоохранения информации о лицах, имеющих право на внеочередное, первоочередное оказание медицинской помощи	', 3, 39, NULL, NULL),
(560, 25, '                     	Наличие и функционирование на официальном интернет-сайте организации здравоохранения дистанционных способов взаимодействия с получателями медицинских услуг:\r\n электронных сервисов (в том числе раздел «Часто задаваемые вопросы», раздел «Вопрос-Ответ»);\r\n обеспечение технической возможности выражения получателями медицинских услуг мнения о качестве и доступности медицинской помощи (наличие анкеты для опроса граждан или гиперссылки на нее)	', 3, 39, NULL, NULL),
(561, 26, '                      	Территория, прилегающая к организации здравоохранения, и ее помещения оборудованы с учетом доступности для лиц с ограниченными возможностями:\r\n оборудование входных групп пандусами (подъемными платформами); наличие выделенных стоянок для автотранспортных средств лиц с ограниченными возможностями; наличие поручней, расширенных проемов; наличие кресел-колясок	', 3, 39, NULL, NULL),
(562, 27, '                      	Наличие в организации здравоохранения условий, позволяющих лицам с ограниченными возможностями получать медицинские услуги наравне с другими пациентами, включая:\r\nналичие и доступность санитарно-гигиенических помещений;\r\n дублирование надписей, знаков и иной текстовой и графической информации знаками, выполненными рельефно-точечным шрифтом Брайля;\r\nналичие алгоритмов сопровождения лиц с ограниченными возможностями работниками организации здравоохранения	', 2, 39, NULL, NULL),
(563, 28, '                     	Наличие на информационных стендах и на официальном интернет-сайте организации здравоохранения информации о порядке работы с обращениями граждан и юридических лиц, включая графики личного приема граждан, их представителей, представителей юридических лиц руководителем организации здравоохранения и его заместителями (далее – личный прием), график проведения «прямых телефонных линий»,  информации о наименовании, месте нахождения и режиме работы вышестоящих организаций	', 2, 39, NULL, NULL),
(564, 29, '                     	Организовано проведение личного приема и «прямых телефонных линий» руководителем организации здравоохранения,  его заместителями,  руководителями структурных подразделений организации  в соответствии с графиком и законодательством об обращениях граждан и юридических лиц ', 2, 39, NULL, NULL),
(565, 30, '                     	Работа с обращениями граждан и юридических лиц ведется в соответствии с законодательством об обращениях граждан и юридических лиц:\r\n наличие ответственного лица за работу с обращениями граждан и юридических лиц; регистрация обращений граждан и юридических лиц ведется в установленном порядке; соблюдение сроков рассмотрения обращений граждан и юридических лиц; поступившие обращения граждан и юридических лиц рассматриваются в полном объеме и по существу поставленных вопросов	', 2, 39, NULL, NULL),
(566, 31, '                   	Соблюдение требований законодательства об обращениях граждан и юридических лиц по хранению, выдаче и ведению книги замечаний и предложений:\r\nналичие ответственного лица за хранение, выдачу и ведение книги замечаний и предложений;\r\nналичие копий ответов заявителям в месте хранения книги замечаний и предложений', 2, 39, NULL, NULL),
(567, 32, '                   	Осуществляется анализ работы с обращениями граждан и юридических лиц (вопросы рассматриваются на производственных (административных, рабочих) совещаниях, клинических конференциях с принятием управленческих решений)', 3, 39, NULL, NULL),
(568, 33, '                   	Наличие в организации здравоохранения ЛПА, регламентирующего порядок организации работы по проведению анкетирования пациентов (с частотой, определяемой руководителем организации здравоохранения) с целью изучения удовлетворенности населения доступностью и качеством медицинской помощи. Проводится анализ проведенного анкетирования; принимаемые меры по результатам проведенного анкетирования; рассматриваются результаты анкетирования на производственных (административных, рабочих) совещаниях с принятием управленческих решений	', 2, 39, NULL, NULL);
INSERT INTO `mark` (`id_mark`, `str_num`, `mark_name`, `mark_class`, `id_criteria`, `date_close`, `date_open`) VALUES
(569, 34, '                    	Наличие в организации здравоохранения ЛПА, регламентирующего порядок организации работы по проведению анкетирования работников организации здравоохранения (с частотой, определяемой руководителем организации здравоохранения) с целью изучения социальных вопросов, в том числе психологического климата в организации здравоохранения, справедливости материального стимулирования. Проводится анализ проведенного анкетирования; принимаемые меры по результатам проведенного анкетирования; рассматриваются результаты анкетирования на производственных (административных, рабочих) совещаниях с принятием управленческих решений	', 2, 39, NULL, NULL),
(570, 35, '                     	Вопросы соблюдения законодательства об обращениях граждан и юридических лиц отражены в правилах внутреннего трудового распорядка, должностных инструкциях и других локальных правовых актах	', 3, 39, NULL, NULL),
(571, 36, '                     	Наличие на информационных стендах и на официальном интернет-сайте организации здравоохранения информации о порядке осуществления и видах административных процедур в организации здравоохранения	', 3, 39, NULL, NULL),
(572, 37, '                     	Работа по осуществлению административных процедур оргРаздел 5. Организация работы по соблюдению законодательства о борьбе с коррупцией ', 3, 39, NULL, NULL),
(573, 38, '                    	Наличие и выполнение в организации здравоохранения ЛПА, регламентирующего работу комиссии по противодействию коррупции; положения об урегулировании конфликта интересов', 2, 39, NULL, NULL),
(574, 39, '                    	Наличие в организации здравоохранения перечня должностей, занимаемых (претендующих на занятие) государственными должностными лицами, которые обязаны подписать обязательство по соблюдению ограничений, установленных законодательством Республики Беларусь.	', 2, 39, NULL, NULL),
(575, 40, '                     	Наличие на официальном интернет-сайте организации здравоохранения информации о плане работы комиссии по противодействию коррупции в организации здравоохранения.	', 2, 39, NULL, NULL),
(576, 41, '                     	Вопросы соблюдения законодательства о борьбе с коррупцией отражены в должностных инструкциях и других ЛПА	', 3, 39, NULL, NULL),
(577, 42, '                    	Осуществляется анализ работы по противодействию коррупции в организации здравоохранения (вопросы рассматриваются на производственных (административных, рабочих) совещаниях с принятием управленческих решений)	', 2, 39, NULL, NULL),
(578, 43, '                    	Отсутствие коррупционных правонарушений за последний отчетный период или год', 2, 39, NULL, NULL),
(579, 44, '                    	Штатная численность должностей служащих (профессий рабочих) утверждена руководителем организации здравоохранения с учетом норм нагрузок труда работников, установленных в организации здравоохранения, и является достаточной для оказания планируемых объемов медицинской помощи.  Штатное расписание составляется и пересматривается ежегодно, на основании анализа кадрового потенциала организации здравоохранения, фактического объема оказываемой медицинской помощи	', 2, 39, NULL, NULL),
(580, 45, '                  	В соответствии со штатным расписанием на каждую должность медицинского работника руководителем  учреждения здравоохранения утверждена должностная инструкция с указанием квалификационных требований и функций, прав и обязанностей медицинских работников. Медицинские работники ознакомлены с должностной инструкцией', 2, 39, NULL, NULL),
(581, 46, '                   	Квалификация медицинских работников соответствует требованиям должностной инструкции к  занимаемой должности служащих	', 1, 39, NULL, NULL),
(582, 47, '                     	В организации здравоохранения проводится работа по обучению/повышению квалификации персонала (определяется потребность персонала в обучении/повышении квалификации, осуществляется планирование и контроль его прохождения).	', 2, 39, NULL, NULL),
(583, 48, '                    	Укомплектованность структурного подразделения врачами-специалистами не менее 75 % по физическим лицам	', 2, 39, NULL, NULL),
(584, 49, '                    	Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам	', 2, 39, NULL, NULL),
(585, 50, '                    	Обеспечение кадровой потребности в специалистах с высшим медицинским, фармацевтическим образованием (укомплектованность) по занятым должностям служащих не менее 96 %	', 2, 39, NULL, NULL),
(586, 51, '                   	Обеспечение кадровой потребности в специалистах со средним медицинским, фармацевтическим образованием (укомплектованность) по занятым должностям служащих не менее 96 %', 2, 39, NULL, NULL),
(587, 52, '                   	Закрепление молодых специалистов на рабочих местах после завершения срока работы по распределению (направлению на работу) не менее 90 %	', 2, 39, NULL, NULL),
(588, 53, '                   	Наличие квалификационных категорий у специалистов с высшим медицинским, фармацевтическим образованием 100 % от лиц, подлежащих к профессиональной аттестации	', 2, 39, NULL, NULL),
(589, 54, '                   	Наличие квалификационных категорий у специалистов со средним медицинским, фармацевтическим образованием 100 % от лиц, подлежащих к профессиональной аттестации', 2, 39, NULL, NULL),
(590, 55, '                   	Коэффициент совместительства медицинских работников с высшим медицинским, фармацевтическим образованием не более 1,25	', 2, 39, NULL, NULL),
(591, 56, '                    	Коэффициент совместительства медицинских работников со средним медицинским, фармацевтическим образованием не более 1,25', 2, 39, NULL, NULL),
(592, 57, '                    	Текучесть медицинских кадров с высшим медицинским, фармацевтическим образованием не более 7 %	', 3, 39, NULL, NULL),
(593, 58, '                    	Текучесть медицинских кадров со средним медицинским, фармацевтическим образованием не более 7 %	', 3, 39, NULL, NULL),
(594, 59, '                    	Наличие и выполнение в организации здравоохранения ЛПА, регламентирующих порядок работы по:\r\nорганизации работы фармакотерапевтической комиссии по вопросам управления лекарственными  препаратами;\r\nпо приобретению, хранению, реализации, отпуску (распределения) наркотических средств и психотропных веществ  и их прекурсоров	', 1, 39, NULL, NULL),
(595, 60, '                    	Осуществляется рациональное назначение, контроль за обоснованностью назначений и медицинского применения лекарственных препаратов	', 2, 39, NULL, NULL),
(596, 61, '                    	Организовано обеспечение лекарственными препаратами в соответствии с Республиканским формуляром лекарственных препаратов	', 1, 39, NULL, NULL),
(597, 62, '                    	Соблюдается порядок учета лекарственных препратов, подлежащих предметно-количественному учету, и изделий медицинского назначения	', 2, 39, NULL, NULL),
(598, 63, '                 	Определяется потребность, составляются и выполняются заявки на лекарственные  препараты, изделия медицинского назначения в соответствии с  Республиканским формуляром лекарственных препаратов. Имеется список  лекарственных средств для закупки на следующий календарный год на основании Республиканского формуляра лекарственных средств в соответствии с профилем и структурой заболеваемости пациентов	', 1, 39, NULL, NULL),
(599, 64, '                     	Проведение ABC/VEN анализа расхода бюджетных средств на лекарственные  препараты. Проведение DDD анализа потребления антибактериальных препаратов резерва в соответствии с Республиканским формуляром лекарственных средств. Определение порядка представления информации о выявленных нежелательных реакциях на лекарственные препараты	', 3, 39, NULL, NULL),
(600, 65, '                     	Организована выписка рецептов врача в соответствии с Инструкцией о порядке выписывания рецепта врача и создания электронных рецептов врача, утвержденной постановлением Министерства здравоохранения Республики Беларусь от 31 октября 2007 г. № 99:\r\n наличие бланков рецептов врача для выписки лекарственных препаратов, реализуемых в аптеке за полную стоимость, на льготных условиях, в том числе бесплатно, использование иных (компьютерных) способов выписывания рецептов;\r\nналичие и учет бланков рецептов врача для выписки наркотических средств;\r\nналичие и учет бланков рецептов врача для выписки психотропных веществ и лекарственных препаратов, обладающих анаболической активностью ', 2, 39, NULL, NULL),
(601, 66, '                   	Обеспечение хранения лекарственных  препаратов  в соответствии с требованиями законодательства. Проводится контроль за условиями хранения и сроками годности	', 1, 39, NULL, NULL),
(602, 67, '                    	Помещения для хранения  лекарственных  препаратов оснащены средствами измерений для регистрации температуры и относительной влажности окружающей среды, прошедших государственную поверку (термогигрометры и (или) другие электронные устройства).	', 2, 39, NULL, NULL),
(603, 68, '                   	Материально-техническая база организации здравоохранения соответствует табелю оснащения изделиями медицинского назначения и медицинской техникой, утвержденному руководителем организации здравоохранения	', 2, 39, NULL, NULL),
(604, 69, '                   	Наличие и выполнение в организации здравоохранения ЛПА, определяющего ответственных лиц за техническое обслуживание и ремонт медицинской техники	', 3, 39, NULL, NULL),
(605, 70, '                   	Обеспечено ведение учета медицинской техники	', 3, 39, NULL, NULL),
(606, 71, '                    	Оснащение  организации   здравоохранения  медицинскими  изделиями и  медицинской техникой в  объеме, достаточном для оказания медицинской помощи, в том числе  специализированной	', 2, 39, NULL, NULL),
(607, 72, '                    	Наличие своевременной государственной поверки средств измерений	', 2, 39, NULL, NULL),
(608, 73, '                    	Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и (или) ремонтом. Техническое обслуживание и (или) ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на выполнение данных услуг	', 1, 39, NULL, NULL),
(609, 74, '                    	Обеспечена эффективность использования медицинской техники  с учетом сменности; отсутствуют случая необоснованного простоя	', 1, 39, NULL, NULL),
(610, 75, '                     	Проводится и документируется обучение медицинских работников правилам эксплуатации медицинской техники при вводе в эксплуатацию', 2, 39, NULL, NULL),
(611, 76, '                    	Обеспечение организации здравоохранения медицинскими газами, назначены ответственные лица. Имеются договоры на  обслуживание оборудования	', 1, 39, NULL, NULL),
(612, 77, '                   	Обеспечена информатизация организации здравоохранения:\r\n обеспечение медицинской информационной системой, автоматизированными информационными системами;\r\n внедрение системы межведомственного документооборота;\r\n обеспечение информатизации рабочих мест (наличие персонального компьютера, электронной цифровой подписи);\r\nосуществляется ведение электронной медицинской карты пациента	', 2, 39, NULL, NULL),
(613, 78, '                     	Наличие нормативного документа, регламентирующего порядок госпитализации в учреждение	', 1, 39, NULL, NULL),
(614, 79, '                    	Обеспечение разделения потоков плановых, экстренных пациентов, организация отдельного приёма для детского населения (при необходимости)	', 2, 39, NULL, NULL),
(615, 80, '                   	Наличие положения об ответственном дежурном враче больницы', 1, 39, NULL, NULL),
(616, 81, '                  	Наличие системы аудио и видеонаблюдения в приёмном отделении	', 2, 39, NULL, NULL),
(617, 82, '                   	Обеспечение готовности приёмного отделения к работе в условиях чрезвычайных ситуаций мирного и военного времени: наличие нормативных документов, тренинги персонала	', 1, 39, NULL, NULL),
(618, 83, '                     	Наличие в приёмном отделении современных автоматизированных систем учёта и регистрациии пациента	', 2, 39, NULL, NULL),
(619, 84, '                    	Определение порядка использования санитарного автотранспорта в соответствии с действующими нормативными документами ', 2, 39, NULL, NULL),
(620, 85, '                  	Наличие алгоритма идентификации личности пациентов, в том числе не владеющих государственными языками, при поступлении (переводе) ', 2, 39, NULL, NULL),
(621, 86, '                    	Наличие алгоритма идентификации личности находящегося в бессознательном состоянии пациента без документов и сопровождающих, включая порядок обращения в органы внутренних дел', 2, 39, NULL, NULL),
(622, 87, '                    	Наличие алгоритма идентификации личности находящегося в бессознательном состоянии пациента с документами и сопровождающими	', 2, 39, NULL, NULL),
(623, 88, '                    	Наличие и выполнение в организации здравоохранения ЛПА, регламентирующих порядки организации и проведения в соответствии  с требованиями законодательства:\r\n1.      медицинских осмотров, врачебных консультаций и  врачебных консилиумов;\r\n2.      медицинского наблюдения пациентов;\r\n3.      организации проведения диагностических  исследований;\r\n4.      раннего выявления онкологических заболеваний;\r\n5.  	паллиативной медицинской помощи;\r\nмедицинской реабилитации	', 2, 39, NULL, NULL),
(624, 89, '                   	В организации здравоохранения круглосуточно обеспечено проведение лабораторных, ультразвуковых, эндоскопических,  рентгенологических, функциональных исследований. Круглосуточность подтверждается графиком работы, дежурств на дому, привлечением закрепленных специалистов других организаций здравоохранения	', 1, 39, NULL, NULL),
(625, 90, '                   	Осуществляется внутрилабораторный контроль качества лабораторных исследований с использованием контрольных материалов ', 1, 39, NULL, NULL),
(626, 91, '                   	Обеспечение клинической лаборатории реагентами и расходными материалами в соответствии применяемыми методами исследования	', 2, 39, NULL, NULL),
(627, 92, '                   	Обеспечение постоянного контроля условий хранения реагентов и расходных материалов в клинической лаборатории в соответствии с требованиями производителя	', 2, 39, NULL, NULL),
(628, 93, '                  	Госпитализация пациентов осуществляется в соответствии с медицинскими показаниями	', 1, 39, NULL, NULL),
(629, 94, '                   	Длительность предоперационного пребывания плановых пациентов в стационарных условиях не превышает 2 суток, кроме случаев, где требуется проведение дополнительной диагностики', 1, 39, NULL, NULL),
(630, 95, '                   	Назначение диагностических  исследований в соответствии с требованиями клинических протоколов	', 1, 39, NULL, NULL),
(631, 96, '                   	Назначение лекарственных препаратов  в соответствии с требованиями клинических протоколов и инструкциями по медицинскому применению лекарственного препарата	', 1, 39, NULL, NULL),
(632, 97, '                   	Осуществляется патологоанатомическое исследование биопсийного (операционного) материала при проведении оперативного вмешательства в 100 % случаев	', 1, 39, NULL, NULL),
(633, 98, '                   	Патологоанатомические вскрытия проводятся в 100 % от числа умерших, подлежащих обязательному патологоанатомическому вскрытию', 2, 39, NULL, NULL),
(634, 99, '                   	Участие врачей-специалистов в патологоанатомическом вскрытии пациентов, умерших в организациях здравоохранения, оказывающих медицинскую помощь в стационарных условиях	', 2, 39, NULL, NULL),
(635, 100, '               	Направление эпикризов в организацию здравоохранения по месту жительства (месту пребывания) на электронном или бумажном носителе	', 2, 39, NULL, NULL),
(636, 101, '                 	Отсутствие роста послеоперационных летальных исходов при экстренной хирургической патологии;  летальных исходов;  случаев расхождения клинических и патологоанатомических диагнозов по основному заболеванию 2-3 категории	', 2, 39, NULL, NULL),
(637, 102, '                  	Оформление медицинских документов осуществляется по установленным формам	', 2, 39, NULL, NULL),
(638, 103, '                 	Организовано обеспечение пациентов лечебным питанием в соответствии с требованиями законодательства	', 1, 39, NULL, NULL),
(639, 104, '                 	Обеспечено функционирование специализированных тематических школ (школ здоровья)', 3, 39, NULL, NULL),
(640, 105, '                 	Наличие и выполнение в организации здравоохранения ЛПА, регламентирующего порядок организации оказания экстренной и неотложной медицинской помощи пациентам. Утверждены алгоритмы оказания экстренной медицинской и неотложной помощи, в том числе комплекса мероприятий сердечно-легочной реанимации, соответствующие условиям оказания медицинской помощи в структурных подразделениях учреждения здравоохранения	', 1, 39, NULL, NULL),
(641, 106, '                 	Наличие и выполнение в организации здравоохранения ЛПА, определяющего перечень лиц, осуществляющих контроль за наличием необходимых лекарственных препаратов, МИ  для  оказания экстренной медицинской помощи, своевременное их пополнение и  соблюдение сроков годности. В структурном подразделении определены лица, осуществляющие контроль за наличием необходимых лекарственных препаратов, медицинских изделий для оказания экстренной медицинской помощи, своевременное их пополнение и соблюдение сроков годности ', 2, 39, NULL, NULL),
(642, 107, '                 	Наличие лекарственных препаратов, медицинских изделий, медицинской техники, крови и ее компонентов для оказания экстренной и неотложной медицинской помощи в  соответствии с требованиями клинических протоколов	', 1, 39, NULL, NULL),
(643, 108, '                 	Наличие  и обеспечение хранения лекарственных препаратов, иммунобиологических лекарственных средств, изделий медицинского назначения, медицинской техники, компонентов и препаратов крови для оказания неотложной медицинской помощи в соответствии с требованиями  нормативных правовых актов', 2, 39, NULL, NULL),
(644, 109, '                  	Организовано проведение занятий с медицинскими работниками по освоению теоретических и практических навыков оказания экстренной медицинской помощи с последующим контролем знаний с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев	', 1, 39, NULL, NULL),
(645, 110, '                  	Наличие и выполнение в организации здравоохранения ЛПА, регламентирующего порядок по проведению экспертизы временной нетрудоспособности (далее – экспертизы ВН) в организации здравоохранения, в том числе определяющего получение, хранение, учет, списание и уничтожение бланков листков нетрудоспособности, справок о временной нетрудоспособности в соответствии с требованиями нормативных документов	', 3, 39, NULL, NULL),
(646, 111, '                 	Бухгалтерский учет и использование бланков строгой отчетности (листков нетрудоспособности) осуществляется в соответствии с Инструкцией о порядке использования и бухгалтерского учета бланков строгой отчетности	', 1, 39, NULL, NULL),
(647, 112, '                 	Организована работа врачебно-консультационных комиссий в соответствии с требования законодательства Республики Беларусь	', 2, 39, NULL, NULL),
(648, 113, '                 	Проводятся инструктажи по вопросам проведения экспертизы ВН и контроль знаний	', 2, 39, NULL, NULL),
(649, 114, '                 	Проводится анализ статистических показателей заболеваемости с временной нетрудоспособностью с выявлением причин их отклонения	', 3, 39, NULL, NULL),
(650, 115, '                 	Осуществляется выдача и оформление листков нетрудоспособности и справок о временной нетрудоспособности в соответствии с требованиями Инструкции о порядке выдачи и  оформления листков нетрудоспособности и справок о временной нетрудоспособности	', 1, 39, NULL, NULL),
(651, 116, '             	Наличие и выполнение в организации здравоохранения ЛПА по порядку организации  и деятельности медицинской водительской комиссии в  соответствии с требованиями законодательства ', 3, 39, NULL, NULL),
(652, 117, '                 	Наличие и выполнение в организации здравоохранения ЛПА, регламентирующего порядок организации и  проведения экспертизы качества медицинской помощи (далее  – экспертиза качества), оценки качества медицинской помощи и  медицинских экспертиз (далее – оценка качества) в  соответствии с требованиями законодательства. Определены лица, ответственные за  организацию и проведение экспертизы качества, оценки качества	', 3, 39, NULL, NULL),
(653, 118, '                	Оценка качества проводится в соответствии с планом, утвержденным руководителем организации   здравоохранения.', 1, 39, NULL, NULL),
(654, 119, '                	По результатам экспертизы качества и (или) оценки качества оформляется заключение	', 1, 39, NULL, NULL),
(655, 120, '                 	Результаты экспертизы качества, оценки качества рассматриваются на врачебно-консультационных комиссиях, клинических конференциях, принимаются меры по устранению причин и условий, повлекших снижение качества медицинской помощи, медицинских экспертиз	', 2, 39, NULL, NULL),
(656, 121, '                 	Наличие специальных медицинских изделий для профилактики и лечения пролежней	', 2, 39, NULL, NULL),
(657, 122, '                	Определены функциональные обязанности работников структурных подразделений по осуществлению мероприятий по уходу за лежачими пациентами	', 1, 39, NULL, NULL),
(658, 123, '               	Осуществление комплекса профилактических мероприятий по предупреждению развития пролежней, проведение лечения пролежней с оформлением медицинских документов', 1, 39, NULL, NULL),
(659, 124, '               	Обеспечено устранение в срок рекомендаций по устранению нарушений, предписаний об устранении нарушений, выданных территориальными центрами гигиены и эпидемиологии	', 1, 39, NULL, NULL),
(660, 125, '              	Обеспечены условия для разделения потоков пациентов имеющих и не имеющих признаки острых инфекционных заболеваний согласно законодательству в области санитарно-эпидемиологических требований	', 2, 39, NULL, NULL),
(661, 126, '                  	Осуществляется выполнение разработанной и утвержденной руководителем организации здравоохранения программы производственного контроля. Сроки и кратность проведения лабораторного производственного контроля соблюдаются согласно установленным в программе производственного контроля на протяжении 3-х последних лет ', 2, 39, NULL, NULL),
(662, 127, '                	В организации здравоохранения оборудована и функционирует система приточно-вытяжной вентиляции. Профилактический ремонт, обслуживание и ремонт системы вентиляции проводится не реже одного раза в 3 года	', 2, 39, NULL, NULL),
(663, 128, '                	Имеется функционирующая система проточного холодного и горячего водоснабжения, система водоотведения (канализации). Умывальники в помещениях, к которым предъявляется данное требование, оснащены кранами с локтевым (бесконтактным, педальным и прочим некистевым) управлением. В помещениях, к которым предъявляется данное требование, имеется резервное горячее водоснабжение, в том числе обеспечена его работоспособность	', 2, 39, NULL, NULL),
(664, 129, '                	Отопление организации здравоохранения осуществляется централизованно или с помощью локальных (автономных) систем, В зимнее время система отопления обеспечивает нормируемые показатели температуры воздуха в помещении', 2, 39, NULL, NULL),
(665, 130, '                 	Установлены и находятся в функционирующем состоянии медицинские изделия для очистки воздуха в помещениях, к которым предъявляется данное требование ', 2, 39, NULL, NULL),
(666, 131, '                	Внутренняя отделка помещений, в том числе поверхности дверей, окон и нагревательных приборов, выполнена в соответствии с функциональным назначением помещений и устойчива к моющим и дезинфицирующим средствам	', 2, 39, NULL, NULL),
(667, 132, '                 	Отсутствует в использовании мебель с дефектами покрытия и (или) неисправная мебель, неисправные санитарно-технические изделия и оборудование, медицинские изделия', 2, 39, NULL, NULL),
(668, 133, '                  	Дезинфекция, стерилизация проводятся в соответствии с законодательством актами Республики Беларусь. Стерилизация осуществляется в централизованном стерилизационном отделении и (или) в стерилизационной. Отсутствуют места организации стерилизации в лечебных кабинетах (манипуляционных, перевязочных, кабинетах приема врачей-специалистов или в других приспособленных местах). Отсутствуют в использовании простерилизованные медицинские изделия с истекшим сроком стерильности либо хранившиеся с нарушением условий сохранения стерильности	', 2, 39, NULL, NULL),
(669, 134, '                 	В наличии имеется достаточное количество средств индивидуальной защиты, антисептиков и дезинфектантов	', 1, 39, NULL, NULL),
(670, 135, '                 	Утвержден и внедрен порядок действий работников при аварийном контакте с биологическим материалом пациента, загрязнении биологическим материалом объектов внешней среды	', 2, 39, NULL, NULL),
(671, 136, '                 	Информация о выявленных инфекционных заболеваниях своевременно предоставляется в территориальные центры гигиены и эпидемиологии ', 3, 39, NULL, NULL),
(672, 137, '                 	Осуществляется регистрация всех выявленных инфекций, связанных с оказанием медицинской помощи, с проведением анализа и принятием управленческих решений	', 2, 39, NULL, NULL),
(673, 138, '                 	Отработанные медицинские изделия подвергаются дезинфекции химическим или физическим методом	', 1, 39, NULL, NULL),
(674, 139, '                 	Сбор медицинских отходов осуществляется в промаркированной одноразовой и (или) непрокалываемой многоразовой таре. Сбор острых, колющих и режущих отработанных медицинских изделий осуществляется в непрокалываемой одноразовой таре, снабженной плотно прилегающей крышкой	', 2, 39, NULL, NULL),
(675, 140, '                 	Для упорядоченного временного хранения медицинских отходов созданы условия, исключающие прямой контакт с медицинскими отходами пациентов и работников (специально выделенное место, помещение, шкаф или другое)', 2, 39, NULL, NULL),
(676, 141, '                  	Стирка белья, санитарной одежды, полотенец, салфеток осуществляется в прачечной, прачечной общего типа и (или) мини-прачечных в отделении организации. Белье и постельные принадлежности (матрасы, подушки, одеяла) подвергаются дезинфекции в случаях, предусмотренных законодательством', 2, 39, NULL, NULL),
(677, 142, '                  	Обеспечено раздельное хранение личной и санитарной одежды в изолированных секциях шкафов. Не допускается стирка санитарной одежды в домашних условиях	', 2, 39, NULL, NULL),
(678, 143, '                 	Территория и помещения организации здравоохранения содержатся в чистоте, соблюдается утвержденный порядок уборок	', 2, 39, NULL, NULL),
(679, 144, '                 	Техническое обслуживание, текущий и капитальный ремонты зданий и помещений организаций, инженерных систем (в том числе отопления, горячего и холодного водоснабжения, водоотведения (канализации), вентиляции, санитарно-технического оборудования) проводится в зависимости от их санитарно-технического состояния и в сроки, установленные планом мероприятий, разработанным и утвержденным руководителем организации	', 2, 39, NULL, NULL),
(680, 145, '                 	Подлежащие работники проходят обязательные медицинские осмотры и гигиеническое обучение', 2, 39, NULL, NULL),
(681, 146, '	Минимальный состав и площади отдельных помещений соответствуют приложению 1 к санитарным нормам и правилам «Санитарно-эпидемиологические требования к организациям, оказывающим медицинскую помощь, в том числе к организации и проведению санитарно-противоэпидемических мероприятий по профилактике инфекционных заболеваний в этих организациях», утвержденных постановлением Министерства здравоохранения от 5 июля 2017 г. № 73	', 2, 39, NULL, NULL),
(682, 147, '	Дезинфекция высокого уровня и (или) стерилизация эндоскопического оборудования осуществляется механизированным способом. Организация здравоохранения оснащена достаточным количеством моечно-дезинфекционных машин и шкафов для асептического хранения эндоскопического оборудования\r\n*Указанный критерий применяется только в отношении тех организаций, где проводятся эндоскопические вмешательства на нестерильных полостях организма.	2Раздел 17.  Дополнительные критерии для  больничной организации здравоохранения (центра, диспансера), выполняющей функции по организационно-методическому руководству службами региона ', 2, 39, NULL, NULL),
(683, 148, '	Проводится аналитическая работа по оценке состояния здоровья населения области с внесением предложений по совершенствованию организации оказания специализированной медицинской помощи	', 1, 39, NULL, NULL),
(684, 149, '	Проводится работа по обеспечению преемственности и маршрутизации оказания медицинской помощи на различных уровнях ', 1, 39, NULL, NULL),
(685, 150, '	Участие в проведении оценки качества медицинской помощи и медицинских экспертиз, экспертизы качества медицинской помощи, оказываемой в организациях здравоохранения 1-2 уровня, с разработкой плана мероприятий по совершенствованию оказания специализированной медицинской помощи  ', 2, 39, NULL, NULL),
(686, 151, '	Участие в работе экспертных, проблемных, межведомственных комиссий, рабочих групп (по проблемам здравоохранения, подготовке клинических протоколов и др. нормативных правовых актов) ', 2, 39, NULL, NULL),
(687, 152, '	Участие в заседаниях лечебно-контрольного совета главного управления по здравоохранению облисполкома (комитета по здравоохранению Мингорисполкома)	', 2, 39, NULL, NULL),
(688, 153, '	Участие в мониторинге, работе комиссий по проверке организации здравоохранения, подготовке справок (отчетов) по результатам проверок организаций здравоохранения ', 2, 39, NULL, NULL),
(689, 154, '	Оказание организационно-методической и плановой консультативной помощи организациям здравоохранения, в т.ч. с выездами врачей-специалистов.  Проведенные мероприятия документируются	', 2, 39, NULL, NULL),
(690, 155, '	Обеспечена доступность проведения телемедицинского консультирования и (или) консилиума по заявкам территориальных организаций здравоохранения.\r\nФакт проведения консилиума и (или)  телемедицинского консультирования документируется  ', 1, 39, NULL, NULL),
(691, 156, '	Экстренные выезды в организации здравоохранения через государственное учреждение «Республиканский центр организации медицинского реагирования»	', 2, 39, NULL, NULL),
(692, 157, '	Проведение образовательных семинаров (лекции, выступления), обучающих мастер-классов	', 1, 39, NULL, NULL),
(693, 158, '	Участие в разработке, рецензировании нормативных документов ', 2, 39, NULL, NULL),
(694, 159, '	Осуществляется взаимодействие и совместная работа с профильными кафедрами (университетами) согласно Положению о клинической организации здравоохранения, Положению об университетской клинике.\r\nСовместные мероприятия в рамках лечебно-диагностической, инновационной, научной  деятельности, подбору кадров документируются.	', 1, 39, NULL, NULL),
(695, 160, '	В составе штата организации здравоохранения есть работники высшей научной квалификации, имеющие степень кандидата или доктора наук, соискатели ученой степени кандидата или доктора наук	', 1, 39, NULL, NULL),
(696, 161, 'Участие в выполнении государственных программ, государственных программ научных исследований, государственных научно-технических программ, региональных научно-технических программ, отраслевых научно-технических программ, межгосударственных программ, проектов в рамках конкурсов Белорусского республиканского фонда фундаментальных исследований, инновационных проектов, выполняемых в рамках Государственной программы инновационного развития Республики Беларусь', 1, 39, NULL, NULL),
(697, 162, '	Публикация результатов научно-исследовательских работ (статьи в отечественных и международных журналах, сборниках, материалах конференций и т.д.);	', 1, 39, NULL, NULL),
(698, 163, '	Разработка и внедрение новых методов и алгоритмов оказания медицинской помощи (диагностики, лечения, профилактики, реабилитации) и инструкции по их применению, стандартов диагностики и лечения (клинические протоколы и др.)', 1, 39, NULL, NULL),
(699, 164, '	Проведение изобретательской, рационализаторской и патентно-лицензионной работы (подача заявок и/или получение патентов на изобретение, полезную модель Республики Беларусь, СНГ, других стран, промышленные образцы, товарные знаки, компьютерные программы, получение свидетельств на рационализаторские предложения)', 1, 39, NULL, NULL),
(700, 165, '	Проведение съездов, конференций, симпозиумов, семинаров, круглых столов и др., выставочная деятельность	', 1, 39, NULL, NULL),
(701, 166, '	Наличие локальных правовых актов, регламентирующих порядок проведения клинических исследований (испытаний) лекарственных средств, изделий медицинского назначения', 2, 39, NULL, NULL),
(702, 167, '	Соответствие условий для проведения клинических исследований (испытаний) требованиям Правил надлежащей клинической практики	', 1, 39, NULL, NULL),
(703, 168, '	Соответствие квалификации исследователей требованиям Правил надлежащей клинической практики	', 1, 39, NULL, NULL),
(704, 169, '	Проведение клинических испытаний лекарственных средств, изделий медицинского назначения согласно утвержденных программ клинических исследований (испытаний) 	', 2, 39, NULL, NULL),
(705, 170, '	Реализация образовательных программ повышения квалификации	', 1, 39, NULL, NULL),
(706, 171, '	Реализация образовательных программ стажировок, обучающих курсов	', 1, 39, NULL, NULL),
(707, 172, '	Организована работа по проведению стажировок врачей-специалистов на рабочем месте в учреждении	', 1, 39, NULL, NULL),
(708, 1, '     Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении и имеют постоянный доступ к его содержанию', 3, 49, NULL, NULL),
(709, 2, '     Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей.', 3, 49, NULL, NULL),
(710, 2, '     Результаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по стоматологии.\r\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 49, NULL, NULL),
(711, 3, '     Укомплектованность структурного подразделения врачами-стоматологами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей-стоматологов укомплектованность не менее 96 % по занятым должностям', 1, 49, NULL, NULL),
(712, 4, '     Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 49, NULL, NULL),
(713, 5, '     Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего', 1, 49, NULL, NULL),
(714, 6, '     Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 49, NULL, NULL),
(715, 7, '     Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев.\r\nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 49, NULL, NULL),
(716, 8, '     Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков.\r\nМедицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 49, NULL, NULL),
(717, 9, '     Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой', 2, 49, NULL, NULL),
(718, 10, '      Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 49, NULL, NULL),
(719, 11, '      В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники.\r\nПроведение обучения документируется', 3, 49, NULL, NULL),
(720, 12, '      Порядок оказания медицинской помощи в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь.\r\nСоблюдается порядок (алгоритмы, «дорожные карты») оказания срочной и плановой медицинской помощи', 2, 49, NULL, NULL),
(721, 13, '      Обеспечена круглосуточная работа врачей-стоматологов при условии оказания экстренной специализированной помощи в структурном подразделении.\r\nВ круглосуточном режиме, в том числе в выходные, праздничные дни доступен осмотр дежурного врача', 2, 49, NULL, NULL),
(722, 14, '      Круглосуточно обеспечена возможность оказания анестезиолого-реанимационной помощи. Критерий применяется для структурных подразделений межрайонного, городского, областного, республиканского уровня', 1, 49, NULL, NULL),
(723, 15, '      Обеспечена преемственность с амбулаторно-поликлиническими организациями здравоохранения. Обеспечена передача эпикриза, содержащего рекомендации по дальнейшему медицинскому наблюдению, в территориальную амбулаторно-поликлиническую организацию', 2, 49, NULL, NULL),
(724, 16, '      В рамках получения пациентом стационарной помощи, в случаях, предусмотренных протоколами диагностики и лечения, обеспечена возможность проведения консультаций врачей-специалистов, в том числе с использованием телемедицинских технологий, с использованием собственных ресурсов организации здравоохранения или другими организациями (центрами коллективного пользования, специализированными центрами) в соответствии с установленным порядком', 1, 49, NULL, NULL),
(725, 17, '       Обеспечена возможность проведения лабораторных исследований в соответствии с клиническими протоколами диагностики и лечения', 1, 49, NULL, NULL),
(726, 18, '      Обеспечена возможность проведения диагностики в соответствии с клиническими протоколами (в организации здравоохранения или определён порядок направления в другие организации здравоохранения)', 1, 49, NULL, NULL),
(727, 19, '      Назначение лекарственных препаратов соответствует установленному диагнозу, требованиям клинических протоколов, инструкции по медицинскому применению лекарственного препарата', 1, 49, NULL, NULL),
(728, 20, '      Оформление медицинской карты стационарного пациента соответствует установленной форме', 3, 49, NULL, NULL),
(729, 21, '      В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 49, NULL, NULL),
(730, 22, '      В структурном подразделении имеются условия для выписки электронных рецептов на лекарственные средства', 2, 49, NULL, NULL),
(731, 23, '      Для врачей-специалистов структурного подразделения обеспечена доступность проведения телемедицинского консультирования, результаты которого документируются и находятся в медицинской карте', 2, 49, NULL, NULL),
(732, 24, '      Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 3, 49, NULL, NULL),
(733, 25, '      Показатель среднегодовой занятости койки структурного подразделения на основании годовой отчетности за последние 3 года не менее 300', 3, 49, NULL, NULL),
(734, 26, '      Профильность работы структурного подразделения для районного и городского уровня оказания помощи не менее 60 %, для областного и республиканского не менее 80 %', 2, 49, NULL, NULL),
(735, 27, '      В структурном подразделении выполняются запланированные объемы специализированной медицинской помощи, предоставляемой за счет бюджета (число проведенных койко-дней, средняя длительность лечения)', 3, 49, NULL, NULL),
(736, 28, '      Планирование объемов медицинской помощи для структурных подразделений, являющихся межрайонными, осуществляется с учетом обеспечения равной доступности населению всех закрепленных территорий.\r\nУдельный вес пациентов закрепленных территорий для районного уровня не менее 30%, для городского и областного уровня не менее 60%', 2, 49, NULL, NULL),
(737, 29, '      В организации здравоохранения обеспечена возможность проведения рентгенологических видов исследований. Имеется установленный порядок направления пациентов на данные исследования в другие организации здравоохранения', 2, 49, NULL, NULL),
(738, 30, '      В организации здравоохранения согласно графику работы учреждения обеспечено проведение рентгенологических исследований', 2, 49, NULL, NULL),
(739, 31, '      В структурном подразделении в обязательном порядке осуществляется направление операционного (биопсийного) материала на патологоанатомическое исследование', 3, 49, NULL, NULL),
(740, 32, '      В медицинской карте пациента, получающего медицинскую помощь в стационарных условиях, указываются обоснование оперативного вмешательства с учетом установленного диагноза, вид оперативного доступа и вид предоставляемого анестезиологического пособия', 1, 49, NULL, NULL),
(741, 33, '      Журнал записи оперативных вмешательств в стационаре оформляется с описанием протокола операции', 3, 49, NULL, NULL),
(815, 1, '     Деятельность структурного подразделения осуществляется в соответствии с положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении и имеют постоянный доступ к его содержанию', 3, 50, NULL, NULL),
(816, 2, '  Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей.\r\nРезультаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по детскому населению.\r\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 50, NULL, NULL),
(817, 3, '  Укомплектованность структурного подразделения врачами-педиатрами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей-педиатров укомплектованность не менее 96 % по занятым должностям', 1, 50, NULL, NULL),
(818, 4, '  Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 50, NULL, NULL),
(819, 5, '  Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего', 1, 50, NULL, NULL),
(820, 6, '  Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 50, NULL, NULL),
(821, 7, '  Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев.\r\nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 50, NULL, NULL),
(822, 8, '  Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков.\r\nМедицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 50, NULL, NULL),
(823, 9, '  Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 50, NULL, NULL),
(824, 10, '   Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой', 2, 50, NULL, NULL),
(825, 11, '  Порядок оказания медицинской помощи в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь.\r\nСоблюдается порядок (алгоритмы, «дорожные карты») оказания срочной и плановой медицинской помощи', 2, 50, NULL, NULL),
(826, 12, '  Обеспечена круглосуточная работа врачей-специалистов при условии оказания экстренной специализированной помощи в структурном подразделении.\r\nВ круглосуточном режиме, в том числе в выходные, праздничные дни доступен осмотр дежурного врача', 2, 50, NULL, NULL),
(827, 13, '   Круглосуточно обеспечена возможность оказания анестезиолого-реанимационной помощи. Критерий применяется для структурных подразделений межрайонного, городского, областного, республиканского уровня', 1, 50, NULL, NULL),
(828, 14, '  Обеспечена преемственность с амбулаторно-поликлиническими организациями здравоохранения. Обеспечена передача эпикриза, содержащего рекомендации по дальнейшему медицинскому наблюдению, в территориальную амбулаторно-поликлиническую организацию', 2, 50, NULL, NULL),
(829, 15, '  В рамках получения пациентом стационарной помощи, в случаях, предусмотренных протоколами диагностики и лечения, обеспечена возможность проведения консультаций врачей-специалистов, в том числе с использованием телемедицинских технологий, с использованием собственных ресурсов организации здравоохранения или другими организациями (центрами коллективного пользования, специализированными центрами) в соответствии с установленным порядком', 1, 50, NULL, NULL),
(830, 16, '  Обеспечена возможность проведения лабораторных исследований в соответствии с клиническими протоколами диагностики и лечения', 1, 50, NULL, NULL),
(831, 17, '  Обеспечена возможность проведения диагностики в соответствии с клиническими протоколами (в организации здравоохранения или определён порядок направления в другие организации здравоохранения)', 1, 50, NULL, NULL),
(832, 18, '   Назначение лекарственных препаратов соответствует установленному диагнозу, требованиям клинических протоколов, инструкции по медицинскому применению лекарственного препарата', 1, 50, NULL, NULL),
(833, 19, '  Оформление медицинской карты стационарного пациента соответствует установленной форме', 3, 50, NULL, NULL),
(834, 20, '   В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 50, NULL, NULL),
(835, 21, '  В структурном подразделении имеются условия для выписки электронных рецептов на лекарственные средства', 2, 50, NULL, NULL),
(836, 22, '   Для врачей-специалистов структурного подразделения обеспечена доступность проведения телемедицинского консультирования, результаты которого документируются и находятся в медицинской карте', 2, 50, NULL, NULL),
(837, 23, '   Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 3, 50, NULL, NULL),
(838, 24, '   Показатель среднегодовой занятости койки структурного подразделения на основании годовой отчетности за последние 3 года не менее 300', 3, 50, NULL, NULL),
(839, 25, '   В структурном подразделении выполняются запланированные объемы первичной и специализированной медицинской помощи, предоставляемой за счет бюджета (число проведенных койко-дней, средняя длительность лечения)', 3, 50, NULL, NULL),
(840, 26, '  Планирование объемов медицинской помощи для структурных подразделений, являющихся межрайонными, осуществляется с учетом обеспечения равной доступности населению всех закрепленных территорий.\r\nУдельный вес пациентов закрепленных территорий для районного уровня не менее 30%, для городского и областного уровня не менее 60%', 2, 50, NULL, NULL),
(841, 27, '  Медицинские осмотры пациентов проводятся в соответствии с Инструкцией о порядке проведения медицинских осмотров с оформлением записи в медицинских документах ', 2, 50, NULL, NULL);
INSERT INTO `mark` (`id_mark`, `str_num`, `mark_name`, `mark_class`, `id_criteria`, `date_close`, `date_open`) VALUES
(842, 28, '  Организация и проведение врачебных консультаций (консилиумов) в соответствии с требованиями Инструкции о порядке проведения врачебных консультаций (консилиумов), утвержденной Министерством здравоохранения Республики Беларусь', 2, 50, NULL, NULL),
(843, 29, '  Организация и обеспечение пациентов в зависимости от возраста диетическим питанием соответствии с требованиями законодательства', 2, 50, NULL, NULL),
(844, 30, '   Обеспечено функционирование специализированных тематических школ (школ здоровья) ', 3, 50, NULL, NULL),
(845, 1, '      Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении  ', 3, 52, NULL, NULL),
(846, 2, '     Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей.\r\nРезультаты анализа документируются, предоставляются лицу, ответственному за организацию рентгендиагностики.\r\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета   ', 2, 52, NULL, NULL),
(847, 3, '    Штатная численность должностей (врачебных и среднего медицинского персонала) рентгенологического отделения (кабинета) обеспечивает доступность проведения рентгенологических исследований   ', 2, 52, NULL, NULL),
(848, 4, '    Укомплектованность структурного подразделения врачами-рентгенологами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей-эндоскопистов укомплектованность не менее 96 % по занятым должностям     ', 1, 52, NULL, NULL),
(849, 5, '    Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям    ', 1, 52, NULL, NULL),
(850, 6, '    Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего    ', 1, 52, NULL, NULL),
(851, 7, '     Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации   ', 2, 52, NULL, NULL),
(852, 8, '     Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев.\r\nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий  ', 1, 52, NULL, NULL),
(853, 9, '     Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков.\r\nМедицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи    ', 3, 52, NULL, NULL),
(854, 10, '     Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности   ', 2, 52, NULL, NULL),
(855, 11, '      Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой согласно перечню выполняемых рентгенологических исследований   ', 2, 52, NULL, NULL),
(856, 12, '      Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание    ', 2, 52, NULL, NULL),
(857, 13, '      В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники.\r\nПроведение обучения документируется  ', 3, 52, NULL, NULL),
(858, 14, '      Порядок проведения рентгенологических исследований в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь  ', 2, 52, NULL, NULL),
(859, 15, '     Работа структурного подразделения обеспечена в сменном режиме при оказании помощи амбулаторным пациентам ', 2, 52, NULL, NULL),
(860, 16, '     Определен порядок оказания рентгенологических исследований пациентам на период отсутствия в организации здравоохранения врача-специалиста (при наличии в штате одного врача-рентгенолога), неисправности рентгенологического оборудования    ', 1, 52, NULL, NULL),
(861, 17, '     В больничной организации здравоохранения срочные рентгенологические исследования выполняются круглосуточно  ', 2, 52, NULL, NULL),
(862, 18, '     В больничной организации здравоохранения обеспечена возможность проведения рентгенологических исследований в отделении анестезиологии и реанимации  ', 2, 52, NULL, NULL),
(863, 19, '     Перечень рентгенологических исследований выполняется согласно профилю оказываемой помощи организацией здравоохранения   ', 2, 52, NULL, NULL),
(864, 20, '     Наличие специального разрешения (лицензии) на право осуществления деятельности в области использования источников ионизирующего излучения (далее – ИИИ), выданного Министерством по чрезвычайным ситуациям Республики Беларусь   ', 1, 52, NULL, NULL),
(865, 21, '      Назначены из числа работников организации здравоохранения (руководителей, специалистов) не менее двух лиц, ответственных за безопасное выполнение работ и (или) оказание услуг, для которых работа у данного нанимателя не является работой по совместительству. Ответственным лицом ежегодно заполняется радиационно-гигиенический паспорт пользователя ИИИ, утверждается руководителем организации   ', 3, 52, NULL, NULL),
(866, 22, '     Индивидуальная доза облучения работника вносится в карточку учета индивидуальных доз облучения лиц, работающих с ИИИ, отсутствует превышение граничных доз профессионального облучения  ', 1, 52, NULL, NULL),
(867, 23, '     Работники (ответственные лица, персонал) проходят обучения и проверки (оценки) знаний по вопросам радиационной безопасности в порядке, установленном постановлением Министерства по чрезвычайным ситуациям от 16 апреля 2020 г. № 18 «Об обучении и проверке (оценке) знаний по вопросам ядерной и радиационной безопасности». Перечень лиц, отнесенных к категории «персонал», допущенных к работе с ИИИ, утверждается приказом по организации  ', 2, 52, NULL, NULL),
(868, 24, '      Право работы с ИИИ подтверждено санитарным паспортом   ', 3, 52, NULL, NULL),
(869, 25, '      В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе   ', 2, 52, NULL, NULL),
(870, 26, '     Для врачей-рентгенологов рентгенологического отделения (кабинета) обеспечена доступность проведения телемедицинского консультирования, результаты которого документируются и находятся в медицинской карте   ', 2, 52, NULL, NULL),
(871, 27, '     Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»    ', 2, 52, NULL, NULL),
(872, 28, '     Наличие журнала (бумажный и (или) электронный носитель) регистрации рентгенологических исследований согласно утверждённой форме. Электронный носитель допускается при наличии в организации здравоохранения автоматизированной системы управления и сервера, базы данных, позволяющих централизовать, формировать и сохранять информацию  ', 2, 52, NULL, NULL),
(873, 29, '     Обеспечена преемственность в соответствии с установленным порядком по передаче результатов рентгенологического исследования в другие отделения, организации здравоохранения, направившие пациентов на рентгенологическое исследование. При наличии возможности используется медицинская информационная система    ', 1, 52, NULL, NULL),
(874, 30, '     Обеспечено выполнение функции врачебной должности не менее 90 %   ', 2, 52, NULL, NULL),
(875, 31, '     Согласие пациента или его законного представителя на проведение рентгенологического исследования оформляется в медицинских документах в соответствии с требованиями законодательства    ', 2, 52, NULL, NULL),
(902, 1, '     Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 51, NULL, NULL),
(903, 2, '     Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей.\r\nРезультаты анализа документируются, предоставляются лицу, ответственному за организацию эндоскопической помощи.', 3, 51, NULL, NULL),
(904, 3, '     Штатная численность должностей (врачебных и среднего медицинского персонала) эндоскопического отделения (кабинета) обеспечивает доступность оказания эндоскопической медицинской помощи', 2, 51, NULL, NULL),
(905, 4, '     Штатная численность должностей (врача-эндоскописта и медицинских работников, имеющих среднее специальное медицинское образование) эндоскопического отделения (кабинета) соответствует соотношению 1:1.5', 2, 51, NULL, NULL),
(906, 5, '     Укомплектованность структурного подразделения врачами-эндоскопистами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей-эндоскопистов укомплектованность не менее 96 % по занятым должностям', 1, 51, NULL, NULL),
(907, 6, '     Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 51, NULL, NULL),
(908, 7, '     Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего', 1, 51, NULL, NULL),
(909, 8, '     Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 51, NULL, NULL),
(910, 9, '     Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев.\r\nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 51, NULL, NULL),
(911, 10, '      Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков.\r\nМедицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 51, NULL, NULL),
(912, 11, '      Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 51, NULL, NULL),
(913, 12, '      Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой согласно перечню выполняемых эндоскопических вмешательств', 2, 51, NULL, NULL),
(914, 13, '      Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 51, NULL, NULL),
(915, 14, '      В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники\r\nПроведение обучения документируется', 3, 51, NULL, NULL),
(916, 15, '      Порядок оказания эндоскопической медицинской помощи в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь', 2, 51, NULL, NULL),
(917, 16, '      Работа структурного подразделения обеспечена в сменном режиме при оказании помощи амбулаторным пациентам', 2, 51, NULL, NULL),
(918, 17, '      Проведение плановых эндоскопических медицинских вмешательств осуществляется по предварительной записи с указанием  даты и времени проводимого вмешательства', 2, 51, NULL, NULL),
(919, 18, '      Определен порядок оказания эндоскопической медицинской помощи пациентам на период отсутствия в организации здравоохранения врача-специалиста (при наличии в штате одного врача-эндоскописта), неисправности эндоскопического оборудования', 1, 51, NULL, NULL),
(920, 19, '       При оказании в больничной организации здравоохранения хирургической помощи, срочные эндоскопические медицинские вмешательства выполняются круглосуточно', 2, 51, NULL, NULL),
(921, 20, '      В больничной организации здравоохранения обеспечена возможность проведения эндоскопических медицинских вмешательств в отделении анестезиологии и реанимации', 2, 51, NULL, NULL),
(922, 21, '      Перечень эндоскопических вмешательств выполняется согласно профилю оказываемой помощи организацией здравоохранения', 2, 51, NULL, NULL),
(923, 22, '      Обеспечено проведение эндоскопических вмешательств с анестезиологическим обеспечением (при наличии в структуре организации здравоохранения анестезиологической службы)', 2, 51, NULL, NULL),
(924, 23, '      Наличие оснащения для проведения щипцевой биопсии. Обеспечено количество щипцов с учётом потребности в одну рабочую смену', 2, 51, NULL, NULL),
(925, 24, '      Наличие оснащения для проведения эндоскопического гемостаза при кровотечениях', 3, 51, NULL, NULL),
(926, 25, '      Имеется в наличии специальное оборудование (моечно-дезинфекционные машины, специализированные ёмкости) для проведения обработки эндоскопов', 2, 51, NULL, NULL),
(927, 26, '      Имеется помещение для выполнения процесса обработки эндоскопического оборудования в соответствии с актами законодательства', 2, 51, NULL, NULL),
(928, 27, '      Соблюдаются условия хранения эндоскопического оборудования в соответствии с актами законодательства', 2, 51, NULL, NULL),
(929, 28, '      Разработан и выполняется алгоритм по стерилизации изделий медицинского назначения (в соответствии с выбором организации здравоохранения)', 2, 51, NULL, NULL),
(930, 29, '      Соблюдаются условия хранения изделий медицинского назначения', 2, 51, NULL, NULL),
(931, 30, '      В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 51, NULL, NULL),
(932, 31, '      Для врачей-эндоскопистов эндоскопического отделения (кабинета) обеспечена доступность проведения телемедицинского консультирования, результаты которого документируются и находятся в медицинской карте', 2, 51, NULL, NULL),
(933, 32, '      Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи» ', 2, 51, NULL, NULL),
(934, 33, '      Наличие журнала (бумажный и (или) электронный носитель) регистрации эндоскопических вмешательств согласно утверждённой форме. Электронный носитель допускается при наличии в организации здравоохранения автоматизированной системы управления и сервера, базы данных, позволяющих централизовать, формировать и сохранять информацию', 2, 51, NULL, NULL),
(935, 34, '      Наличие журнала (бумажный и (или) электронный носитель) регистрации биопсийного (операционного) материала, направляемого на патогистологическое исследование согласно утверждённой форме. Электронный носитель допускается при наличии в организации здравоохранения автоматизированной системы управления и сервера, базы данных, позволяющих централизовать, формировать и сохранять информацию', 1, 51, NULL, NULL),
(936, 35, '      Обеспечена преемственность в соответствии с установленным порядком по передаче результатов патогистологического исследования в другие отделения, организации здравоохранения, направившие пациентов на эндоскопическое вмешательство. При наличии возможности используется медицинская информационная система', 1, 51, NULL, NULL),
(937, 36, '      Плановое эндоскопическое медицинское вмешательство выполняется после получения результатов проведенных лабораторных и инструментальных методов исследования', 2, 51, NULL, NULL),
(938, 37, '      Обеспечено выполнение функции врачебной должности не менее 95 %', 2, 51, NULL, NULL),
(939, 38, '      Обеспечено выполнение проведения забора биопсийного материала согласно клиническим протоколам', 2, 51, NULL, NULL),
(940, 39, '      Протокол эндоскопического медицинского вмешательства оформляется согласно утверждённой формы', 3, 51, NULL, NULL),
(941, 40, '      Согласие пациента или его законного представителя на проведение эндоскопического медицинского вмешательства оформляется в медицинских документах в соответствии с требованиями законодательства', 2, 51, NULL, NULL),
(942, 1, '     Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 53, NULL, NULL),
(943, 2, '     Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей.\r\nРезультаты анализа документируются, предоставляются лицу, ответственному за организацию ультразвуковой диагностики.\r\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению,  решениями медицинского совета', 2, 53, NULL, NULL),
(944, 3, '     Укомплектованность структурного подразделения врачами-эндоскопистами не менее 75% по физическим лицам. При наличии в  штатном расписании неполных должностей врачей-эндоскопистов укомплектованность не менее 96 % по занятым должностям', 1, 53, NULL, NULL),
(945, 4, '     Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75% по физическим лицам. При наличии в  штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 53, NULL, NULL),
(946, 5, '     Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 53, NULL, NULL),
(947, 6, '     Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев.\r\nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 53, NULL, NULL),
(948, 7, '     Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков.\r\nМедицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 53, NULL, NULL),
(949, 8, '     Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 53, NULL, NULL),
(950, 9, '     Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой согласно перечню выполняемых УЗ исследований по профилям оказываемой в организации здравоохранения помощи', 2, 53, NULL, NULL),
(951, 10, '     Соблюдаются минимальные требования к оснащению ультразвуковыми диагностическими системами (класс используемой ультразвуковой диагностической системы) согласно актам законодательства и профилям  оказываемой помощи организацией здравоохранения', 1, 53, NULL, NULL),
(952, 11, '     Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 53, NULL, NULL),
(953, 12, '     В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники.\r\nПроведение обучения документируется', 3, 53, NULL, NULL),
(954, 13, '     Порядок проведения ультразвуковой диагностики в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь.', 2, 53, NULL, NULL),
(955, 14, '     Работа структурного подразделения обеспечена в сменном режиме при оказании помощи амбулаторным пациентам', 2, 53, NULL, NULL),
(956, 15, '      Проведение плановой ультразвуковой диагностики осуществляется по предварительной записи с указанием даты и времени проводимого вмешательства', 2, 53, NULL, NULL),
(957, 16, '     Определен порядок оказания ультразвуковой диагностики пациентам на период отсутствия в организации здравоохранения врача-специалиста (при наличии в штате одного врача – УЗД), неисправности УЗ оборудования', 1, 53, NULL, NULL),
(958, 17, '     При оказании в больничной организации здравоохранения хирургической помощи, срочные УЗ исследования выполняются круглосуточно', 2, 53, NULL, NULL),
(959, 18, '     Выполняется минимальный обязательный набора методов и методик ультразвуковых исследований, согласно актам законодательства и профилям  оказываемой помощи организацией здравоохранения', 2, 53, NULL, NULL),
(960, 19, '     Разработан и выполняется алгоритм по стерилизации изделий медицинского назначения (в соответствии с выбором организации здравоохранения) ', 2, 53, NULL, NULL),
(961, 20, '     Соблюдаются условия хранения изделий медицинского назначения', 2, 53, NULL, NULL),
(962, 21, '     В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 53, NULL, NULL),
(963, 22, '     Для врачей-УЗД обеспечена доступность проведения телемедицинского консультирования, результаты которого документируются\r\nи находятся в медицинской карте', 2, 53, NULL, NULL),
(964, 23, '     Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021г. №55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 2, 53, NULL, NULL),
(965, 24, '     Наличие журнала (бумажный и (или) электронный носитель) регистрации УЗ исследований и/или вмешательств под УЗ контролем согласно утверждённой форме. Электронный носитель допускается при наличии в организации здравоохранения автоматизированной системы управления и сервера, базы данных, позволяющих централизовать, формировать и сохранять информацию', 2, 53, NULL, NULL),
(966, 25, '     Обеспечено выполнение функции врачебной должности не менее 95%', 2, 53, NULL, NULL),
(967, 26, '     Протокол УЗ исследования или вмешательства под УЗ контролем оформляется согласно утверждённой формы', 3, 53, NULL, NULL),
(968, 27, '     В структурном подразделении выполняются запланированные объемы медицинской помощи, предоставляемой за счет бюджета, выполняется функция врачебной должности', 2, 53, NULL, NULL),
(1036, 1, '    Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 54, NULL, NULL),
(1037, 2, '   Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей.\r\nРезультаты анализа документируются, предоставляются лицу, ответственному за организацию функциональной диагностики.\r\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению,  решениями медицинского совета', 2, 54, NULL, NULL),
(1038, 3, '    Укомплектованность структурного подразделения врачами-эндоскопистами не менее 75% по физическим лицам. При наличии в  штатном расписании неполных должностей врачей-эндоскопистов укомплектованность не менее 96 % по занятым должностям', 1, 54, NULL, NULL),
(1039, 4, '    Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75% по физическим лицам. При наличии в  штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 54, NULL, NULL),
(1040, 5, '    Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 54, NULL, NULL),
(1041, 6, '    Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев.\r\nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 54, NULL, NULL),
(1042, 7, '    Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков.\r\nМедицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 54, NULL, NULL),
(1043, 8, '    Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 54, NULL, NULL),
(1044, 9, '    Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой согласно перечню выполняемых функциональных исследований по профилям оказываемой в организации здравоохранения помощи', 2, 54, NULL, NULL),
(1045, 10, '    Соблюдаются минимальные требования к оснащению отделения (кабинета) ФД включает в себя медицинское оборудование и изделия медицинской техники, необходимые для проведения методов и методик диагностики в соответствии с уровнем и профилем организации здравоохранения', 1, 54, NULL, NULL),
(1046, 11, '    Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 54, NULL, NULL),
(1047, 12, '    В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники.\r\nПроведение обучения документируется', 3, 54, NULL, NULL),
(1048, 13, '    Порядок проведения функциональных исследований в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь.', 2, 54, NULL, NULL),
(1049, 14, '    Работа структурного подразделения обеспечена в сменном режиме при оказании помощи амбулаторным пациентам', 2, 54, NULL, NULL),
(1050, 15, '    Проведение плановых функциональных исследований осуществляется по предварительной записи с указанием даты и времени проводимого исследования', 2, 54, NULL, NULL),
(1051, 16, '    Определен порядок оказания функциональных исследований пациентам на период отсутствия в организации здравоохранения врача-специалиста (при наличии в штате одного врача ФД), неисправности оборудования кабинета(отделения) ФД', 1, 54, NULL, NULL),
(1052, 17, '    При оказании в больничной организации здравоохранения хирургической помощи, срочные функциональные исследования выполняются круглосуточно', 2, 54, NULL, NULL),
(1053, 18, '    Выполняется минимальный обязательный набора методов и методик функциональных исследований, согласно актам законодательства и профилям оказываемой помощи организацией здравоохранения', 2, 54, NULL, NULL),
(1054, 19, '    Разработан и выполняется алгоритм по стерилизации изделий медицинского назначения (в соответствии с выбором организации здравоохранения)', 2, 54, NULL, NULL),
(1055, 20, '    Соблюдаются условия хранения изделий медицинского назначения', 2, 54, NULL, NULL),
(1056, 21, '    В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 54, NULL, NULL),
(1057, 22, '    Для врачей ФД обеспечена доступность проведения телемедицинского консультирования, результаты которого документируются\r\nи находятся в медицинской карте', 2, 54, NULL, NULL),
(1058, 23, '    Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021г. №55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 2, 54, NULL, NULL),
(1059, 25, '    Наличие журнала (бумажный и (или) электронный носитель) регистрации функциональных исследований согласно утверждённой форме. Электронный носитель допускается при наличии в организации здравоохранения автоматизированной системы управления и сервера, базы данных, позволяющих централизовать, формировать и сохранять информацию', 2, 54, NULL, NULL),
(1060, 26, '    Обеспечено выполнение функции врачебной должности не менее 95%', 2, 54, NULL, NULL),
(1061, 27, '    В структурном подразделении выполняются запланированные объемы медицинской помощи, предоставляемой за счет бюджета, функция врачебной должности', 2, 54, NULL, NULL),
(1135, 1, '    Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 55, NULL, NULL),
(1136, 2, '   Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей.\r\nРезультаты анализа документируются, предоставляются лицу, ответственному за организацию лабораторной диагностики.\r\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 55, NULL, NULL),
(1137, 3, '   Укомплектованность структурного подразделения врачами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей клинической лабораторной диагностики укомплектованность не менее 96 % по занятым должностям   ', 1, 55, NULL, NULL),
(1138, 4, '   Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям ', 1, 55, NULL, NULL),
(1139, 5, '   Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего', 1, 55, NULL, NULL),
(1140, 6, '   Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 55, NULL, NULL),
(1141, 7, '   В организации здравоохранения разработаны правила доставки образцов биологического материала для каждого вида клинических лабораторных исследований с регламентацией условий транспортировки биологических образцов к месту проведения аналитического этапа исследования', 3, 55, NULL, NULL),
(1142, 8, '   В организации здравоохранения для забора венозной крови используются одноразовые стандартные системы: система шприц-пробирка, обеспечивающая как поршневой способ забора крови, так и вакуумный; вакуумные системы, обеспечивающие забор крови вакуумным методом со строгим соблюдением требований производителя компонентов систем', 1, 55, NULL, NULL),
(1143, 9, '   В организации здравоохранения соблюдается последовательность заполнения вакуумных систем: кровь без антикоагулянтов или с прокоагулянтами\r\nкровь с цитратом\r\nкровь с гепарином\r\nкровь с ЭДТА', 2, 55, NULL, NULL),
(1144, 10, '   Транспортировка биологических проб осуществляется в специально предназначенных для этого и промаркированных контейнерах', 2, 55, NULL, NULL),
(1145, 11, '   Порядок транспортировки биологического материала в лабораторию в обязательном порядке предусматривает:\r\nв каждой организации здравоохранения должен быть определен медицинский работник, ответственный за транспортировку образцов биологического материала в лабораторию, в обязанности которого входит:\r\nосуществление контроля за подготовленным к транспортировке биологическим материалом, соответствием количества заявок на лабораторные исследования количеству отобранных проб биологического материала;\r\nоформление Акта приема образцов биологического материала для лабораторных исследований;\r\nконтроль за температурным режимом в контейнерах не реже 1 раза в 5 дней;\r\nведение Журнала контроля температурного режима контейнеров;\r\nдоставка материала в лабораторию осуществляется в максимально короткий промежуток времени, при этом нормативы времени доставки биологического материала в лабораторию отражаются в алгоритме доставки биологического материала, разработанного для данной организации здравоохранения;\r\nконтейнеры должны обеспечивать соответствующие температурные режимы в зависимости от вида лабораторных исследований. В зависимости от требуемой для транспортировки биологического материала температуры они оборудуются хладагентами (для поддержания температуры 2-8 °C) или термоэлементами (для поддержания температуры в диапазоне 37 °C)', 2, 55, NULL, NULL),
(1146, 12, '    В организации здравоохранения при приеме проб организовано:\r\nосуществление контроля за совпадением идентификационных характеристик пробы (маркировка, штрих-кодирование, информация на бланке-направлении, информация в ЛИС);\r\nприменение критериев приемлемости или отказа в приеме проб (качество пробы (гемолиз, хилез, сгусток, иное), неправильное кодирование и заполнение бланка-направления на исследование, неправильный выбор пробирки, иное)', 2, 55, NULL, NULL),
(1147, 13, '    При направлении биологического материала внешнему исполнителю (при централизации исследований) за организацию процесса на преаналитическом этапе отвечает направляющая организация здравоохранения (пп.1.1-1.5)', 2, 55, NULL, NULL),
(1148, 14, '    Прием, сортировка и регистрация материала, поступившего в лабораторию, осуществляется медицинским или иным (биолог, химик) работником лаборатории в соответствии с должностной инструкцией вручную либо с использованием технических средств (сканер) ЛИС', 2, 55, NULL, NULL),
(1149, 15, '    Направление на клинико-лабораторное исследование оформляется в электронном виде (в ЛИС) либо на бумажном носителе с указанием персональных данных в соответствии с нормативными правовыми актами', 2, 55, NULL, NULL),
(1150, 16, '    В организации здравоохранения должны быть стандартные операционные процедуры, инструкции, алгоритмы по выполнению клинико-лабораторных исследований инструментальными и мануальными методами. Методики исследования должны быть документированы. Они должны быть поняты персоналом и доступны на рабочих местах', 2, 55, NULL, NULL),
(1151, 17, '   Клинико-лабораторные исследования выполняются:\r\nмедицинскими и иными (биологи, химики) работниками лаборатории в соответствии с должностными инструкциями и квалификационными характеристиками;\r\nиными медицинскими работниками при выполнении исследований по месту лечения пациента', 2, 55, NULL, NULL),
(1152, 18, '   Лаборатория должна определить биологические референсные интервалы или значения клинического решения, документально оформить основу для референтных интервалов или значения клинического решения и сообщить эту информацию пользователям', 2, 55, NULL, NULL),
(1153, 19, '   При внутрилабораторном контроле используются контрольные материалы промышленного производства, допущенные в установленном порядке к применению на территории Республики Беларусь, в случае если необходимость внутрилабораторного контроля качества установлена производителем наборов реагентов и/или оборудования.\r\nВ случаях отсутствия контрольных материалов промышленного производства для контроля воспроизводимости используются приготовленные в лаборатории материалы', 1, 55, NULL, NULL),
(1154, 20, '   Подготовка контрольного материала к исследованию проводится строго в соответствии с инструкцией производителя и используется так же, как и пробы пациентов', 1, 55, NULL, NULL),
(1155, 21, '   Полученные данные исследования контрольного материала документально оформляются. Результаты внутрилабораторного контроля качества вносятся в журналы регистрации лабораторных исследований и их результатов (ЛИС)\r\nПри отсутствии возможности хранения результатов внутрилабораторного контроля качества в архиве анализатора (или ЛИС), они вносятся в журналы регистрации лабораторных исследований или в журнал регистрации результатов контроля качества (бумажный или электронный вариант)', 2, 55, NULL, NULL),
(1156, 22, '    Проводится статистическая обработка полученных результатов исследования контрольного материала, заполняются контрольные карты (при наличии программного обеспечения в аналитическом оборудовании/ЛИС – допускается ведение контрольных карт в электронном виде), проводится последующая их оценка.\r\nПри отсутствии возможности построения контрольных карт в автоматическом режиме/ЛИС построение контрольных карт выполняется вручную на бумажном носителе или в электронном варианте', 2, 55, NULL, NULL),
(1157, 23, '   Данные контроля качества должны пересматриваться через регулярные интервалы, чтобы обнаружить тенденции в выполнении исследований, которые могут указывать на наличие проблем в исследовательской системе. В случае обнаружения таких тенденций должны быть предприняты и зарегистрированы предупреждающие действия', 2, 55, NULL, NULL),
(1158, 24, '   В организации здравоохранения должны быть определены правила по оценке результатов контроля качества и порядок действий по устранению неприемлемых результатов внутрилабораторного контроля качества', 2, 55, NULL, NULL),
(1159, 25, '   Лаборатория принимает участие в программе(ах) межлабораторных сличений в отношении проводимых исследований. Внешняя оценка качества подтверждается результатами участия в программах межлабораторных сличительных испытаний в соответствии с планом внешней оценки качества республиканского уровня Республиканского центра по лабораторной диагностике и (или) участия в международной системе внешней оценки качества.\r\nЛаборатория должна осуществлять мониторинг результатов программ межлабораторных сличений и выполнять корректирующие действия, если заданные критерии не достигнуты', 1, 55, NULL, NULL),
(1160, 26, '    1.    Положение о лаборатории.\r\n2.    Приказы, распоряжения руководителя организации здравоохранения.\r\n3.    Приказы, распоряжения вышестоящих организаций здравоохранения.\r\n4.    Решения медицинского совета организации здравоохранения (копии), касающиеся деятельности лаборатории.\r\n5.    План работы лаборатории.\r\n6.    Должностные инструкции работников лаборатории.\r\n7.    Годовой (ежеквартальный, ежемесячный) отчет лаборатории.\r\n8.    Протоколы производственных совещаний в лаборатории.\r\n9.    Документы по экспертной оценке качества оказания диагностической помощи.\r\n10.    Документы по регистрации внутреннего обучения персонала лаборатории (первичная стажировка на рабочем месте, техническое обучение и т.д.).\r\n11.    Паспорт лаборатории, включающий информацию о применяемом оборудовании, об оснащенности стандартными образцами, в том числе контрольными материалами, о производственных помещениях, о кадровом составе, об участии во внешнем контроле качества, о применяемых методах исследования, о применяемых вспомогательных материалах.\r\n12.    Стандартные операционные процедуры (инструкции, алгоритмы, методики) по выполнению клинико-лабораторных исследований инструментальными и мануальными методами.\r\n13.    Аналитическая справка о деятельности лаборатории (по требованию).\r\n14.    Журналы в соответствии с приказом Министерства здравоохранения Республики Беларусь от 28 сентября 2007 г. № 787 «Об утверждении форм первичной медицинской документации по лабораторной диагностике»*.\r\n15.    Журнал технического обслуживания и учета неисправностей оборудования.\r\n16.    Журнал регистрации температуры и влажности в помещениях лаборатории.\r\n17.    Журнал регистрации температуры в холодильнике (морозильнике) лаборатории.\r\n18.    Акты приема образцов биологического материала для клинико-лабораторных исследований (для централизованных лабораторий).\r\n19.    Журнал контроля температурного режима термоконтейнеров (для централизованных лабораторий).\r\n20.    Документы по регистрации внутреннего и внешнего контроля качества.\r\n21.    Документы, косвенно относящиеся к деятельности лаборатории, закрепленные в требованиях иных служб (отделы охраны труда, бухгалтерия, центры гигиены и эпидемиологии и др.)\r\n* при наличии лабораторной информационной системы допускается ведение электронного журнала', 3, 55, NULL, NULL),
(1161, 27, '   Лаборатория располагает пространством, отведенным для выполнения работ, которое организовано таким образом, что обеспечивает качество, безопасность, эффективность оказания медицинской помощи, а также здоровье и безопасность персонала', 2, 55, NULL, NULL),
(1162, 28, '   В помещениях для проведения исследований созданы условия для их правильного проведения (источник электроэнергии, освещение, вентиляция, защита от шума, водоснабжение, удаление отходов и условия окружающей среды)', 2, 55, NULL, NULL),
(1163, 29, '   Помещения, предоставленные для хранения, и условия хранения должны постоянно обеспечивать сохранность образцов проб, документов, оборудования, реагентов, расходных материалов и любых иных объектов, которые могут оказать влияние на результаты исследований ', 2, 55, NULL, NULL),
(1164, 30, '   Лаборатория производит мониторинг, контроль и регистрацию условий окружающей среды в производственных и складских помещениях', 2, 55, NULL, NULL),
(1165, 31, '   В помещениях для проведения исследований разделены зоны, в которых осуществляются несовместимые виды деятельности и применены процедуры, предотвращающие перекрестную контаминацию', 2, 55, NULL, NULL),
(1166, 32, '   Лаборатории, осуществляющие работу с условно-патогенными микроорганизмами и патогенными биологическими агентами, должны иметь разрешение, выданное в порядке, установленном законодательством Республики Беларусь', 2, 55, NULL, NULL),
(1167, 33, '   Каждая единица оборудования имеет уникальную маркировку или иное обозначение', 3, 55, NULL, NULL),
(1168, 34, '   Оборудование всегда применяется обученным и уполномоченным персоналом', 2, 55, NULL, NULL),
(1169, 35, '   Актуальные инструкции по эксплуатации легкодоступны для соответствующего персонала', 3, 55, NULL, NULL),
(1170, 36, '   Оборудование своевременно проходит метрологическую поверку/калибровку в соответствии с нормативными актами (если применимо)', 2, 55, NULL, NULL),
(1171, 37, '   Оборудование обеспечено техническим обслуживанием в соответствии с требованиями эксплуатационной документации к нему', 2, 55, NULL, NULL),
(1172, 38, '   Реагенты и расходные материалы хранятся в строгом соответствии с инструкциями производителя', 2, 55, NULL, NULL),
(1173, 39, '   Инструкции по применению реагентов и расходных материалов легкодоступны для персонала (в бумажном и/или электронном виде)', 3, 55, NULL, NULL),
(1174, 40, '   В отношении каждого реагента и расходного материала, которые оказывают влияние на качество исследований, должны вестись записи: дата вскрытия/дата начала использования, сроки годности', 3, 55, NULL, NULL),
(1175, 41, '   Результат клинико-лабораторного исследования оформляется на бланке организации здравоохранения, в которой проводилось клинико-лабораторное исследование, либо в электронном виде (ЛИС) при соблюдении требований законодательства Республики Беларусь по защите конфиденциальной информации и персональных данных пациента', 2, 55, NULL, NULL),
(1176, 42, '   Результат клинико-лабораторных исследований содержит:\r\nфамилию, имя, отчество (при наличии) пациента, пол, дату его рождения;\r\nдату, время взятия материала (при необходимости);\r\nвремя доставки материала (при необходимости);\r\nнаименование материала, в котором проводились клинико-лабораторные исследования (при необходимости);\r\nрезультаты проведенных клинико-лабораторных исследований, выраженные в соответствующих единицах измерения в сопоставлении с референтными интервалами (при наличии) с использованием четырех видов шкал (количественная, номинальная, описательная и порядковая);\r\nрасчетные лабораторные показатели (при необходимости);\r\nзаключение по результатам клинико-лабораторных исследований (при необходимости);\r\nфамилию, имя, отчество (при наличии) врача, фельдшера-лаборанта либо иного (биолога, химика) работника лаборатории, проводившего клинико-лабораторное исследование (валидацию)', 2, 55, NULL, NULL),
(1177, 43, '   В каждой конкретной организации здравоохранения разработан и утвержден перечень экстренных клинико-лабораторных исследований и установлены минимальные и максимальные сроки их проведения с учетом имеющегося оборудования, применяемых методов исследования и организации деятельности лаборатории', 2, 55, NULL, NULL),
(1178, 44, '   В случае получения критических (угрожающих) значений либо эпидемиологически значимой информации медицинский либо иной (биолог, химик) работник лаборатории передает информацию о результате исследования лечащему врачу, определен порядок получения этой информации лечащим врачом', 2, 55, NULL, NULL),
(1179, 45, '   Оснащение структурного подразделения включает в себя медицинское оборудование и изделия медицинской техники, необходимые для проведения методов и методик диагностики в соответствии с уровнем и профилем организации здравоохранения, локальных нормативных актов, регламентирующих централизацию клинико-лабораторных исследований', 1, 55, NULL, NULL),
(1180, 46, '   Оснащение структурного подразделения соответствует утвержденному табелю оснащения', 2, 55, NULL, NULL),
(1181, 47, '   Обеспечено проведение общеклинических исследований\r\n(в подразделении организации здравоохранения и/или централизованно)', 2, 55, NULL, NULL),
(1182, 48, '    Обеспечено проведение гематологических исследований\r\n(в подразделении организации здравоохранения и/или централизованно)', 2, 55, NULL, NULL),
(1183, 49, '   Обеспечено проведение биохимических исследований\r\n(в подразделении организации здравоохранения и/или централизованно)', 2, 55, NULL, NULL),
(1184, 50, '    Обеспечено проведение цитологических исследований\r\n(в подразделении организации здравоохранения и/или централизованно)', 2, 55, NULL, NULL),
(1185, 51, '   Обеспечено проведение коагулологических исследований\r\n(в подразделении организации здравоохранения и/или централизованно)', 2, 55, NULL, NULL);
INSERT INTO `mark` (`id_mark`, `str_num`, `mark_name`, `mark_class`, `id_criteria`, `date_close`, `date_open`) VALUES
(1186, 52, '    Обеспечено проведение иммунологических (серологических) исследований (определение антигенов и антител): диагностика сифилиса, маркеры аллергий, гормоны, онкомаркеры, кардиомаркеры, маркеры инфекционных заболеваний, маркеры аутоиммунных заболеваний\r\n(в подразделении организации здравоохранения и/или централизованно) ', 2, 55, NULL, NULL),
(1187, 53, '    Обеспечено проведение иммуногематологических исследований\r\n(в подразделении и/или централизованно)', 2, 55, NULL, NULL),
(1188, 54, '   Обеспечено проведение микробиологических исследований\r\n(в подразделении организации здравоохранения и/или централизованно)', 2, 55, NULL, NULL),
(1189, 55, '   Обеспечено проведение молекулярно-биологических исследований (в подразделении организации здравоохранения и/или централизованно)', 2, 55, NULL, NULL),
(1190, 56, '   Оснащение структурного подразделения включает в себя медицинское оборудование и изделия медицинской техники, необходимые для проведения методов и методик диагностики в соответствии с уровнем и профилем организации здравоохранения, локальных нормативных актов, регламентирующих централизацию клинико-лабораторных исследований', 1, 55, NULL, NULL),
(1191, 57, '   Оснащение структурного подразделения соответствует утвержденному табелю оснащения', 2, 55, NULL, NULL),
(1192, 58, '   Обеспечено проведение гематологических исследований\r\n(в подразделении организации здравоохранения и/или централизованно)', 2, 55, NULL, NULL),
(1193, 59, '   Обеспечено проведение биохимических исследований\r\n(в подразделении организации здравоохранения и/или централизованно)', 2, 55, NULL, NULL),
(1194, 60, '   Обеспечено проведение цитологических исследований\r\n(в подразделении организации здравоохранения и/или централизованно)', 2, 55, NULL, NULL),
(1195, 61, '   Обеспечено проведение коагулологических исследований\r\n(в подразделении организации здравоохранения и/или централизованно)', 2, 55, NULL, NULL),
(1196, 62, '   Обеспечено проведение иммунологических (серологических) исследований (определение антигенов и антител): диагностика сифилиса, маркеры аллергий, гормоны, онкомаркеры, кардиомаркеры, маркеры инфекционных заболеваний, маркеры аутоиммунных заболеваний и др.\r\n(в подразделении организации здравоохранения и/или централизованно)', 2, 55, NULL, NULL),
(1197, 63, '   Обеспечено проведение микробиологических исследований\r\n(в подразделении организации здравоохранения и/или централизованно)', 2, 55, NULL, NULL),
(1198, 64, '   Обеспечено проведение молекулярно-биологических исследований (в подразделении организации здравоохранения и/или централизованно)', 2, 55, NULL, NULL),
(1199, 65, '    Обеспечено проведение иммуногематологических исследований\r\n(в подразделении организации здравоохранения и/или централизованно)', 1, 55, NULL, NULL),
(1200, 66, '    Обеспечено проведение цитогенетических исследований\r\n(в подразделении организации здравоохранения и/или централизованно)', 2, 55, NULL, NULL),
(1201, 67, '   Обеспечено проведение химико-токсикологических исследований\r\n(в подразделении организации здравоохранения и/или централизованно)', 2, 55, NULL, NULL),
(1202, 1, '    В организации здравоохранения имеется локальный правовой акт, утверждающий порядок организации и проведения медицинской реабилитации, медицинской абилитации, порядок направления на медицинскую реабилитацию, медицинскую абилитацию; определено лицо, ответственное за организацию и проведение медицинской реабилитации, медицинской абилитации в организации здравоохранения', 1, 48, NULL, NULL),
(1203, 2, '   Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 48, NULL, NULL),
(1204, 3, '   Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей.\r\nРезультаты анализа документируются, предоставляются лицу, ответственному за организацию медицинской реабилитации, медицинской абилитации.\r\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению,  решениями медицинского совета', 2, 48, NULL, NULL),
(1205, 4, '    Соответствие штатного расписания организации здравоохранения штатному нормативу численности врачей-реабилитологов, а также врачей-специалистов (врача-физиотерапевта, врача лечебной физкультуры), специалистов со средним медицинским образованием по специальностям реабилитационного профиля', 1, 48, NULL, NULL),
(1206, 5, '     Укомплектованность специалистами реабилитационного профиля (врачом-реабилитологом, врачом физиотерапевтом, врачом лечебной физкультуры) с высшим медицинским образованием по физическим лицам не менее 75%', 1, 48, NULL, NULL),
(1207, 6, '    В организации здравоохранения соблюдается порядок и установленные сроки направления пациентов на медицинскую реабилитацию, медицинскую абилитацию в соответствии\r\nс порядком организации и проведения медицинской реабилитации, медицинской абилитации и перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на медицинскую реабилитацию, медицинскую абилитацию (при обслуживании взрослого населения);\r\nпорядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет и перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на раннюю медицинскую реабилитацию в стационарных условиях,  перечнем общих медицинских противопоказаний для проведения медицинской реабилитации (при обслуживании детского населения)', 2, 48, NULL, NULL),
(1208, 7, '    Оформляется согласие на простое медицинское вмешательство или отказ от проведения медицинской реабилитации и (или) применения методов медицинской реабилитации пациентом или его законным представителем', 3, 48, NULL, NULL),
(1209, 8, '    Медицинская реабилитация осуществляется в соответствии с порядком организации и проведения медицинской реабилитации, медицинской абилитации,  клиническими протоколами по профилям заболеваний, состояниям, синдромам,\r\nметодами оказания медицинской помощи, соответствующими профилю оказываемой медицинской помощи, локальными нормативными актами, регламентирующими проведение медицинской реабилитации, медицинской абилитации в организации здравоохранения', 1, 48, NULL, NULL),
(1210, 9, '    Организовано проведение мероприятий медицинской реабилитации, медицинской абилитации в отделении (палате) интенсивной терапии, реанимации и анестезиологии', 2, 48, NULL, NULL),
(1211, 10, '    Соблюдение сроков проведения медицинской реабилитации, медицинской абилитации в соответствии с перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на медицинскую реабилитацию, медицинскую абилитацию (при обслуживании взрослого населения);\r\nперечнем медицинских показаний и медицинских противопоказаний для направления пациентов на раннюю медицинскую реабилитацию в стационарных условиях, перечнем общих медицинских противопоказаний для проведения медицинской реабилитации (при обслуживании детского населения) в 80% случаях', 2, 48, NULL, NULL),
(1212, 11, '    В случае отсутствия в организации здравоохранения врача-реабилитолога, мероприятия медицинской реабилитации, медицинской абилитации пациентам проводятся врачами-специалистами данной организации здравоохранения', 1, 48, NULL, NULL),
(1213, 12, '    Медицинский осмотр врачом-реабилитологом, врачами-специалистами, осуществляющими мероприятия медицинской реабилитации, медицинской абилитации проводится в соответствии с Инструкцией о порядке проведения медицинских осмотров, утвержденной постановлением Министерства здравоохранения Республики Беларусь от 21 декабря 2015 г. № 127, с оформлением записи в медицинской карте стационарного пациента', 2, 48, NULL, NULL),
(1214, 13, '    Сформулирован клинико-функциональный диагноз основного и сопутствующих заболеваний на основании жалоб, анамнеза, данных объективного осмотра пациента, проведенной диагностики, в соответствии с Международной статистической классификацией болезней и проблем, связанных со здоровьем, десятого пересмотра (далее - МКБ-10) и (или) клиническими классификациями', 2, 48, NULL, NULL),
(1215, 14, '    Мероприятия медицинской реабилитации, медицинской абилитации назначаются с учетом наличия медицинских показаний и отсутствия медицинских противопоказаний к проведению медицинской реабилитации, медицинской абилитации или отдельным методам медицинской реабилитации', 2, 48, NULL, NULL),
(1216, 15, '    Составляется план медицинской реабилитации, медицинской абилитации пациента (далее – ПМР) в соответствии с порядком организации и проведения медицинской реабилитации, медицинской абилитации, порядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет в 100% случаях', 1, 48, NULL, NULL),
(1217, 16, '    Организовано выполнение, своевременная коррекция (при необходимости) ПМР, что отражается в медицинских документах', 2, 48, NULL, NULL),
(1218, 17, '    Удельный вес пациентов, которым назначена лечебная физкультура (далее - ЛФК) не менее 90% от числа пациентов, поступивших в отделение, где проводится медицинская реабилитация', 2, 48, NULL, NULL),
(1219, 18, '    Врачом ЛФК, врачом-специалистом, имеющим подготовку по ЛФК, назначаются процедуры ЛФК (механотерапии), массажа, эрготерапии с учетом установленного диагноза, медицинских показаний и медицинских противопоказаний, с оформлением записи в медицинской карте стационарного пациента', 2, 48, NULL, NULL),
(1220, 19, '    Врачом ЛФК, врачом-специалистом, имеющим подготовку по ЛФК, заполняется форма 042/у «Карта лечащегося в кабинете лечебной физкультуры»', 3, 48, NULL, NULL),
(1221, 20, '    Врачом-физиотерапевтом назначаются физиотерапевтические процедуры с учетом установленного диагноза, медицинских показаний и медицинских противопоказаний к их назначению в соответствии с клиническими протоколами, инструкциями по медицинскому применению физиотерапевтических аппаратов (руководствами по эксплуатации), с оформлением записи в медицинской карте стационарного пациента', 2, 48, NULL, NULL),
(1222, 21, '    Врачом-физиотерапевтом заполняется форма № 044/у «Карта больного, лечащегося в физиотерапевтическом отделении (кабинете)»', 3, 48, NULL, NULL),
(1223, 22, '    В отделении (кабинете) физиотерапии, ЛФК заполняется форма №029/у «Журнал учета процедур»', 3, 48, NULL, NULL),
(1224, 23, '    В организации здравоохранения организовано проведение физиотерапевтических процедур, ЛФК в палате (для пациентов с ограниченной мобильностью), либо организована транспортировка пациента в кабинет физиотерапии, зал (кабинет) ЛФК', 3, 48, NULL, NULL),
(1225, 24, '    Организовано функционирование специализированных тематических школ (школ здоровья); осуществляется обучение членов семьи пациента отдельным элементам методов медицинской реабилитации', 3, 48, NULL, NULL),
(1226, 25, '    Осуществление оценки эффективности медицинской реабилитации с применением стандартизованных шкал, тестов, опросников с внесением результатов в медицинские документы пациента в 80% случаях', 3, 48, NULL, NULL),
(1227, 26, '    Направление пациентов на последующий этап медицинской реабилитации осуществляется в соответствии с порядком организации и проведения медицинской реабилитации, медицинской абилитации и перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на медицинскую реабилитацию, медицинскую абилитацию (при обслуживании взрослого населения);\r\nпорядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет и перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на раннюю медицинскую реабилитацию в стационарных условиях, перечнем общих медицинских противопоказаний для проведения медицинской реабилитации, перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на медицинскую реабилитацию в амбулаторных условиях (при обслуживании детского населения)', 2, 48, NULL, NULL),
(1228, 27, '    Оформление эпикриза с указанием клинико-функционального диагноза, результатов проведенного лечения,  мероприятий медицинской реабилитации, медицинской абилитации и их эффективности,  рекомендаций на последующий этап медицинской реабилитации', 3, 48, NULL, NULL),
(1229, 28, '    В организации здравоохранения имеется возможность проведения врачебных консультаций (консилиумов) в соответствии с Инструкцией о порядке проведения врачебных консультаций (консилиумов), утвержденной постановлением Министерства здравоохранения Республики Беларусь от 20 декабря 2008 г. № 224, с применением телемедицинских технологий', 3, 48, NULL, NULL),
(1230, 29, '    Осуществляется оказание психотерапевтической и психологической помощи в соответствии с законодательством о здравоохранении, об оказании психиатрической помощи, об оказании психологической помощи с внесением сведений в медицинские документы пациента в соответствии с требованиями законодательства', 2, 48, NULL, NULL),
(1231, 30, '    Оснащение зала (кабинета) ЛФК соответствует табелю оснащения, утвержденному локальным правовым актом, с учетом профиля оказания медицинской помощи', 1, 48, NULL, NULL),
(1232, 31, '    Удельный вес пациентов, перенесших острый/повторный инфаркт миокарда и направленных на медицинскую реабилитацию в стационарных условиях, составляет 80% и более от числа заболевших - при оказании медицинской помощи пациентам в возрасте 18 лет и старше', 1, 48, NULL, NULL),
(1233, 32, '    Удельный вес пациентов, перенесших острое нарушение мозгового кровообращения (ОНМК) и направленных на медицинскую реабилитацию в стационарных условиях, составляет 60% и более от числа заболевших - при оказании медицинской помощи пациентам в возрасте 18 лет и старше', 1, 48, NULL, NULL),
(1234, 33, '    Удельный вес пациентов онкологического профиля, направленных на медицинскую реабилитацию в стационарных условиях после проведения радикальной операции, составляет 20% и более от числа прооперированных - при оказании медицинской помощи пациентам в возрасте 18 лет и старше', 1, 48, NULL, NULL),
(1235, 34, '    В организации здравоохранения имеется локальный правовой акт, утверждающий порядок организации и проведения медицинской реабилитации, медицинской абилитации, порядок направления на медицинскую реабилитацию, медицинскую абилитацию; определено лицо, ответственное за организацию и проведение медицинской реабилитации, медицинской абилитации в организации здравоохранения', 1, 48, NULL, NULL),
(1236, 35, '   Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 48, NULL, NULL),
(1237, 36, '   Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей.\r\nРезультаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по _____________________.\r\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению,  решениями медицинского совета', 2, 48, NULL, NULL),
(1238, 37, '    В структуре и штатном расписании организации здравоохранения выделены структурные подразделения реабилитационного профиля согласно видам и условиям оказания медицинской помощи в организации здравоохранения', 1, 48, NULL, NULL),
(1239, 38, '    Соответствие штатного расписания организации здравоохранения штатному нормативу численности врачей-реабилитологов, а также врачей-специалистов (врача-физиотерапевта, врача лечебной физкультуры), специалистов со средним медицинским образованием по специальностям реабилитационного профиля', 1, 48, NULL, NULL),
(1240, 39, '    Укомплектованность специалистами реабилитационного профиля (врачом-реабилитологом, врачом физиотерапевтом, врачом лечебной физкультуры) с высшим медицинским образованием по физическим лицам не менее 75%', 1, 48, NULL, NULL),
(1241, 40, '    В организации здравоохранения соблюдается порядок и установленные сроки направления пациентов на медицинскую реабилитацию, медицинскую абилитацию в соответствии с\r\nпорядком организации и проведения медицинской реабилитации, медицинской абилитации и перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на медицинскую реабилитацию, медицинскую абилитацию (при обслуживании взрослого населения);\r\nпорядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет и перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на раннюю медицинскую реабилитацию в стационарных условиях,  перечнем общих медицинских противопоказаний для проведения медицинской реабилитации (при обслуживании детского населения)', 2, 48, NULL, NULL),
(1242, 41, '    Оформляется согласие на простое медицинское вмешательство или отказ от проведения медицинской реабилитации и (или) применения методов медицинской реабилитации пациентом или его законным представителем', 2, 48, NULL, NULL),
(1243, 42, '    Медицинская реабилитация осуществляется в соответствии с порядком организации и проведения медицинской реабилитации, медицинской абилитации,  клиническими протоколами по профилям заболеваний, состояниям, синдромам, методами оказания медицинской помощи, соответствующими профилю оказываемой медицинской помощи,\r\nлокальными нормативными актами, регламентирующими проведение медицинской реабилитации, медицинской абилитации в организации здравоохранения', 1, 48, NULL, NULL),
(1244, 43, '    Организовано проведение мероприятий медицинской реабилитации, медицинской абилитации в отделении (палате) интенсивной терапии, реанимации и анестезиологии', 1, 48, NULL, NULL),
(1245, 44, '    Соблюдение сроков проведения медицинской реабилитации, медицинской абилитации в соответствии с перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на медицинскую реабилитацию, медицинскую абилитацию (при обслуживании взрослого населения);\r\nперечнем медицинских показаний и медицинских противопоказаний для направления пациентов на раннюю медицинскую реабилитацию в стационарных условиях, перечнем общих медицинских противопоказаний для проведения медицинской реабилитации (при обслуживании детского населения) в 80% случаях', 2, 48, NULL, NULL),
(1246, 45, '    Организована работа мультидисциплинарной реабилитационной бригады (далее - МДБ)', 1, 48, NULL, NULL),
(1247, 46, '    На заседании МДБ проводится экспертно-реабилитационная диагностика, включающая медицинский осмотр пациента в соответствии с Инструкцией о порядке проведения медицинских осмотров, утвержденной постановлением Министерства здравоохранения Республики Беларусь от 21 декабря 2015 г. № 127, установление клинико-функционального диагноза основного и сопутствующего(их) заболевания(ий), определение наличия и степени выраженности нарушений функций органов и систем организма пациента, степени ограничений базовых категорий жизнедеятельности, оценку реабилитационного потенциала;\r\nформирование цели проведения медицинской реабилитации, медицинской абилитации пациента;\r\nформирование ИПМРАП, с оформлением записи в медицинской карте стационарного пациента', 1, 48, NULL, NULL),
(1248, 47, '    Оценка степени выраженности нарушений функций органов и систем организма, обусловленных заболеваниями, до начала медицинской реабилитации и после ее окончания осуществляется в соответствии с классификацией основных видов нарушений функций органов и систем организма пациента, согласно приложению 2 к Инструкции о порядке освидетельствования (переосвидетельствования) пациентов (инвалидов) при проведении медико-социальной экспертизы, утвержденной постановлением Министерства здравоохранения Республики Беларусь от 9 июня 2021 г. № 77', 1, 48, NULL, NULL),
(1249, 48, '    Сформулирован клинико-функциональный диагноз основного и сопутствующих заболеваний на основании жалоб, анамнеза, данных объективного осмотра пациента, проведенной диагностики, в соответствии с Международной статистической классификацией болезней и проблем, связанных со здоровьем, десятого пересмотра (далее - МКБ-10) и (или) клиническими классификациями', 2, 48, NULL, NULL),
(1250, 49, '    Осуществляется оценка степени выраженности ограничений базовых категорий жизнедеятельности до начала медицинской реабилитации и после ее окончания в соответствии с классификацией основных категорий жизнедеятельности и степени выраженности их ограничений согласно приложению 1 к Инструкции о порядке освидетельствования (переосвидетельствования) пациентов (инвалидов) при проведении медико-социальной экспертизы, методом оценки ограничений жизнедеятельности при последствиях заболеваний и травм, состояниях у лиц в возрасте старше 18 лет, методом оценки степени утраты здоровья у детей с неврологической, соматической и ортопедотравматологической патологией', 2, 48, NULL, NULL),
(1251, 50, '    Определяется реабилитационный потенциал в 100% случаях', 2, 48, NULL, NULL),
(1252, 51, '    Мероприятия медицинской реабилитации, медицинской абилитации назначаются с учетом наличия медицинских показаний, реабилитационного потенциала и отсутствия медицинских противопоказаний к проведению медицинской реабилитации, медицинской абилитации или отдельным методам медицинской реабилитации', 2, 48, NULL, NULL),
(1253, 52, '    Индивидуальная программа медицинской реабилитации, абилитации пациента заполняется по форме согласно приложению 8 к постановлению Министерства здравоохранения Республики Беларусь от 9 июня 2021 г. № 77 «О вопросах проведения медико-социальной экспертизы» (далее - ИПМРАП) в соответствии с порядком организации и проведения медицинской реабилитации, медицинской абилитации, порядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет в 100% случаях от подлежащих', 1, 48, NULL, NULL),
(1254, 53, '    Составляется план медицинской реабилитации, медицинской абилитации пациента (далее – ПМР) в соответствии с порядком организации и проведения медицинской реабилитации, медицинской абилитации, порядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет в 100% случаях от подлежащих', 1, 48, NULL, NULL),
(1255, 54, '    Организовано выполнение, своевременная коррекция (при необходимости) ИПМРАП, ПМР, что отражается в медицинских документах', 2, 48, NULL, NULL),
(1256, 55, '    Удельный вес пациентов, которым назначена ЛФК, не менее 100% от числа пациентов, поступивших в стационарное отделение медицинской реабилитации', 1, 48, NULL, NULL),
(1257, 56, '   Врачом ЛФК, врачом-специалистом, имеющим подготовку по ЛФК, назначаются процедуры ЛФК (механотерапии), массажа, эрготерапии с учетом установленного диагноза, медицинских показаний и медицинских противопоказаний, с оформлением записи в медицинской карте стационарного пациента', 2, 48, NULL, NULL),
(1258, 57, '    Врачом ЛФК, врачом-специалистом, имеющим подготовку по ЛФК, заполняется форма 042/у «Карта лечащегося в кабинете лечебной физкультуры»', 3, 48, NULL, NULL),
(1259, 58, '    Врачом-физиотерапевтом назначаются физиотерапевтические процедуры с учетом установленного диагноза, медицинских показаний и медицинских противопоказаний к их назначению в соответствии с клиническими протоколами, инструкциями по медицинскому применению физиотерапевтических аппаратов (руководствами по эксплуатации), с оформлением записи в медицинской карте стационарного пациента', 2, 48, NULL, NULL),
(1260, 59, '    Врачом-физиотерапевтом заполняется форма № 044/у «Карта больного, лечащегося в физиотерапевтическом отделении (кабинете)»', 3, 48, NULL, NULL),
(1261, 60, '    В отделении (кабинете) физиотерапии, ЛФК заполняется форма №029/у «Журнал учета процедур»', 3, 48, NULL, NULL),
(1262, 61, '    В организации здравоохранения организовано проведение физиотерапевтических процедур, ЛФК в палате (для пациентов с ограниченной мобильностью), либо организована транспортировка пациента в кабинет физиотерапии, зал (кабинет) ЛФК', 3, 48, NULL, NULL),
(1263, 62, '    Направление пациентов на последующий этап медицинской реабилитации осуществляется в соответствии с\r\nпорядком организации и проведения медицинской реабилитации, медицинской абилитации и перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на медицинскую реабилитацию, медицинскую абилитацию (при обслуживании взрослого населения);\r\nпорядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет и перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на раннюю медицинскую реабилитацию в стационарных условиях, перечнем общих медицинских противопоказаний для проведения медицинской реабилитации, перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на медицинскую реабилитацию в амбулаторных условиях (при обслуживании детского населения)', 3, 48, NULL, NULL),
(1264, 63, '    Организовано функционирование специализированных тематических школ (школ здоровья);\r\nосуществляется обучение членов семьи пациента отдельным элементам методов медицинской реабилитации', 3, 48, NULL, NULL),
(1265, 64, '    Осуществление оценки эффективности медицинской реабилитации с применением стандартизованных шкал, тестов, опросников с внесением результатов в медицинские документы пациента в 100% случаях', 1, 48, NULL, NULL),
(1266, 65, '    Оформление по окончании медицинской реабилитации эпикриза с указанием клинико-функционального диагноза, результатов проведенного лечения,  мероприятий медицинской реабилитации, медицинской абилитации и их эффективности,  рекомендаций на последующий этап медицинской реабилитации', 2, 48, NULL, NULL),
(1267, 66, '    В организации здравоохранения имеется возможность проведения врачебных консультаций (консилиумов) в соответствии с Инструкцией о порядке проведения врачебных консультаций (консилиумов), утвержденной постановлением Министерства здравоохранения Республики Беларусь от 20 декабря 2008 г. № 224, с применением телемедицинских технологий', 3, 48, NULL, NULL),
(1268, 67, '    Осуществляется оказание психотерапевтической и психологической помощи в соответствии с законодательством о здравоохранении, об оказании психиатрической помощи, об оказании психологической помощи с внесением сведений в медицинские документы пациента в соответствии с требованиями законодательства', 2, 48, NULL, NULL),
(1269, 68, '    Оснащение зала (кабинета) ЛФК соответствует табелю оснащения, утвержденному локальным правовым актом, с учетом профиля оказания медицинской помощи', 2, 48, NULL, NULL),
(1270, 69, '    Оснащение кабинета эрготерапии соответствует табелю оснащения, утвержденному локальным правовым актом, с учетом профиля оказания медицинской помощи либо в зале (кабинете) ЛФК имеются приспособления для проведения эрготерапии', 2, 48, NULL, NULL),
(1271, 70, '     Разработка информационных материалов (памяток, буклетов) по вопросам медицинской реабилитации – для организаций здравоохранения республиканского уровня', 3, 48, NULL, NULL),
(1272, 71, '    Удельный вес пациентов, перенесших острый/повторный инфаркт миокарда и направленных на медицинскую реабилитацию в стационарных условиях, составляет 80% и более от числа заболевших - при оказании медицинской помощи пациентам в возрасте 18 лет и старше - для специализированных отделений (отделений) по профилю заболевания (состояния, оказываемой медицинской помощи)', 1, 48, NULL, NULL),
(1273, 72, '    Удельный вес пациентов, перенесших острое нарушение мозгового кровообращения (ОНМК) и направленных на медицинскую реабилитацию в стационарных условиях, составляет 60% и более от числа заболевших - при оказании медицинской помощи пациентам в возрасте 18 лет и старше - для специализированных отделений (отделений) по профилю заболевания (состояния, оказываемой медицинской помощи)', 1, 48, NULL, NULL),
(1274, 73, '    Удельный вес пациентов онкологического профиля, направленных на медицинскую реабилитацию в стационарных условиях после проведения радикальной операции, составляет 20% и более от числа заболевших - при оказании медицинской помощи пациентам в возрасте 18 лет и старше - для специализированных отделений (отделений) по профилю заболевания (состояния, оказываемой медицинской помощи)', 1, 48, NULL, NULL),
(1367, 1, 'Деятельность фельдшерско-акушерского пункта (далее – ФАП) осуществляется в соответствии с утвержденным положением. Обеспечено выполнение запланированных объемов оказания медицинской помощи', 3, 56, NULL, NULL),
(1368, 2, 'Укомплектованность ФАП медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. Наличие квалификационных категорий у специалистов со средним медицинским образованием 100 % от лиц, подлежащих профессиональной аттестации', 1, 56, NULL, NULL),
(1369, 3, 'Заведующим ФАП осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности', 2, 56, NULL, NULL),
(1370, 4, 'Организована реализация лекарственных препаратов населению сельских населенных пунктов медицинским работником, на которого возложена обязанность по розничной реализации лекарственных препаратов. Организовано постоянное наличие на ФАП минимального перечня лекарственных препаратов, обязательных для осуществления розничной реализации. Организованы условия хранения лекарственных средств и изделий медицинского назначения в соответствии с законодательством', 2, 56, NULL, NULL),
(1371, 5, 'Оснащение ФАП медицинскими изделиями и оборудованием, оснащение сумки-укладки фельдшера соответствует табелю, утвержденному законодательством', 2, 56, NULL, NULL),
(1372, 6, 'Выполняется утвержденный руководителем организации здравоохранения порядок оказания организационно-методической и консультативной медицинской помощи на ФАП, график выездов врача общей практики врачебной амбулатории (поликлиники). Осуществляется информирование населения', 2, 56, NULL, NULL),
(1373, 7, 'Наличие ежегодно обновляемого (до 1 января) списка обслуживаемого населения (взрослого и детского), закрепленного за ФАП. Выполняются требования утвержденного порядка проведения диспансеризации населения, адаптированного к условиям работы организации здравоохранения', 1, 56, NULL, NULL),
(1374, 8, 'Медицинские работники ФАП могут продемонстрировать навыки по оказанию экстренной медицинской помощи. Обеспечено проведение ЭКГ, в том числе в домашних условиях', 1, 56, NULL, NULL),
(1375, 9, 'Отсутствуют неисполненные на дату проведения оценки (согласно установленным срокам) предписания и решения контролирующих органов в части соблюдения санитарно-эпидемиологического законодательства', 1, 56, NULL, NULL),
(1376, 10, 'Техническое обслуживание, текущий и капитальный ремонты зданий и помещений ФАП, инженерных систем (в том числе отопления, горячего и холодного водоснабжения, водоотведения (канализации), вентиляции, санитарно-технического оборудования) проводится в зависимости от их санитарно-технического состояния и в сроки, установленные планом мероприятий, разработанным и утвержденным руководителем организации', 2, 56, NULL, NULL),
(1413, 1, 'Деятельность участковой больницы (далее – УБ) осуществляется в соответствии с утвержденным положением. Обеспечено выполнение плановых показателей деятельности и проведение их анализа с внесением предложений по улучшению качества медицинской помощи.\nВыполнены нормативы обеспеченности врачами в соответствии с государственными минимальными социальными стандартами в области здравоохранения: \nучастковыми врачами-педиатрами: один врач на 0,8 тыс. детского населения;\nврачами общей практики: один врач на 1,3 тыс. взрослого и детского населения;\nналичие специального автомобиля «медицинская помощь»', 2, 58, NULL, NULL),
(1414, 2, 'Укомплектованность УБ врачами общей практики, медицинскими работниками, имеющими среднее специальное медицинское образование не менее 75 % по физическим лицам. Наличие квалификационных категорий у специалистов с медицинским образованием 100 % от лиц, подлежащих профессиональной аттестации', 1, 58, NULL, NULL),
(1415, 3, 'Соблюдается установленный порядок информирования пациентов о порядке оказания медицинской помощи, графике приема, правилах внутреннего распорядка для пациентов, порядке осуществления административных процедур, рассмотрения обращений граждан', 3, 58, NULL, NULL),
(1416, 4, 'Заведующим УБ осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности', 2, 58, NULL, NULL),
(1417, 5, 'Соблюдается утвержденный порядок оказания медицинской помощи населению, находящемуся в зоне обслуживания участковой больницы. График работы УБ обеспечивает доступность медицинской помощи. Обеспечена возможность получения консультации врача общей практики в день обращения', 1, 58, NULL, NULL),
(1418, 6, 'Организован прием пациентов командой врача общей практики, самостоятельный прием пациентов помощником врача по амбулаторно-поликлинической помощи, медицинской сестрой общей практики, медицинской сестрой участковой.\nОрганизовано проведение патронажа пациентов медицинской сестрой общей практики, медицинской сестрой участковой', 1, 58, NULL, NULL),
(1419, 7, 'Оснащение изделиями медицинского назначения и медицинской техникой УБ, оснащение сумки врача общей практики соответствует утвержденному. Обеспечено техническое обслуживание эксплуатируемой медицинской техники', 2, 58, NULL, NULL),
(1420, 8, 'Обеспечены условия для диагностики: выполнение ЭКГ (в том числе в домашних условиях), ВГД. Обеспечена возможность выполнения клинико-диагностических исследований.\nСоблюдение установленного порядка направления в другие организации здравоохранения для проведения диагностики и консультаций врачей-специалистов', 1, 58, NULL, NULL),
(1421, 9, 'В организации здравоохранения для забора венозной крови используются одноразовые стандартные системы: система шприц-пробирка, обеспечивающая как поршневой способ забора крови, так и вакуумный; вакуумные системы, обеспечивающие забор крови вакуумным методом со строгим соблюдением требований производителя компонентов систем', 2, 58, NULL, NULL),
(1422, 10, 'Направление на клинико-лабораторное исследование оформляется в электронном виде либо на бумажном носителе с указанием персональных данных в соответствии с нормативными правовыми актами', 3, 58, NULL, NULL),
(1423, 11, 'Назначенное лечение соответствует установленному диагнозу и требованиям клинических протоколов диагностики и лечения, утвержденных Министерством здравоохранения Республики Беларусь (далее – клинические протоколы)', 1, 58, NULL, NULL),
(1424, 12, 'Медицинские работники УБ проходят обучение и могут продемонстрировать навыки по оказанию экстренной медицинской помощи. Осуществляется контроль за наличием необходимых лекарственных препаратов, медицинских изделий для оказания экстренной медицинской помощи, своевременное их пополнение и соблюдение сроков годности', 1, 58, NULL, NULL),
(1425, 13, 'Работа стационара организована в круглосуточном режиме. Обеспечена возможность осмотра дежурным врачом круглосуточно', 2, 58, NULL, NULL),
(1426, 14, 'Определяется потребность, составляются и выполняются заявки на лекарственные препараты, изделия медицинского назначения в соответствии с Республиканским формуляром лекарственных средств, Республиканским формуляром медицинских изделий. Обеспечено хранение лекарственных, иммунобиологических лекарственных препаратов и изделий медицинского назначения в соответствии с требованиями законодательства. Соблюдается порядок представления информации о выявленных нежелательных реакциях на лекарственные препараты', 2, 58, NULL, NULL),
(1427, 15, 'Организовано обеспечение пациентов стационара лечебным питанием в соответствии с требованиями законодательства', 1, 58, NULL, NULL),
(1428, 16, 'Наличие ежегодно обновляемого (до 1 января) списка обслуживаемого населения (взрослого и детского), закрепленного за УБ. Выполняются требования утвержденного порядка проведения диспансеризации населения, адаптированного к условиям работы УБ. Выполняются мероприятия по раннему выявлению злокачественных новообразований в соответствии с установленными порядками', 1, 58, NULL, NULL),
(1429, 17, 'Соблюдается порядок медицинского наблюдения пациентов в амбулаторных условиях. Ведется учет пациентов, подлежащих медицинскому наблюдению. Соблюдается преемственность с больничными организациями здравоохранения, выполнение рекомендаций по медицинскому наблюдению после выписки ', 2, 58, NULL, NULL),
(1430, 18, 'Организована работа с женским и детским населением: патронаж детей до года 100 %, проводится осмотр детей СОП в установленном порядке. Организовано проведение профилактических прививок в соответствии с Национальным календарем профилактических прививок', 2, 58, NULL, NULL),
(1431, 19, 'Экспертиза временной нетрудоспособности осуществляется в соответствии с требованиями законодательства, в том числе определяющего получение, хранение, учет, списание и уничтожение бланков листков нетрудоспособности. Осуществляется своевременное направление пациентов на медико-социальную экспертизу ', 2, 58, NULL, NULL),
(1432, 20, 'Наличие условий для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 58, NULL, NULL),
(1433, 21, 'В организации здравоохранения медицинская реабилитация, медицинская абилитация осуществляется в соответствии с\nпорядком организации и проведения медицинской реабилитации, медицинской абилитации пациента (при обслуживании взрослого населения),\nпорядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет (при обслуживании детского населения),\nклиническими протоколами по профилям заболеваний, состояниям, синдромам,\nметодами оказания медицинской помощи, соответствующими профилю оказываемой медицинской помощи,\nлокальными нормативными актами, регламентирующими проведение медицинской реабилитации в организации здравоохранения.\nКритерий применяется для организаций здравоохранения, в штатном расписании которых отсутствует должность врача-реабилитолога', 1, 58, NULL, NULL),
(1434, 22, 'Отсутствуют неисполненные на дату проведения оценки (согласно установленным срокам) предписания и решения контролирующих органов в части соблюдения санитарно-эпидемиологического законодательства', 1, 58, NULL, NULL),
(1435, 23, 'Техническое обслуживание, текущий и капитальный ремонты зданий и помещений УБ, инженерных систем (в том числе отопления, горячего и холодного водоснабжения, водоотведения (канализации), вентиляции, санитарно-технического оборудования) проводится в зависимости от их санитарно-технического состояния и в сроки, установленные планом мероприятий, разработанным и утвержденным руководителем организации', 2, 58, NULL, NULL),
(1451, 1, 'Деятельность амбулатории врача общей практики (далее – АВОП) осуществляется в соответствии утвержденным положением. Обеспечено выполнение плановых показателей деятельности и проведение их анализа с внесением предложений по улучшению качества медицинской помощи.\nВыполнены нормативы обеспеченности врачами в соответствии с государственными минимальными социальными стандартами в области здравоохранения: \nучастковыми врачами-педиатрами: один врач на 0,8 тыс. детского населения,\nврачами общей практики: один врач на 1,3 тыс. взрослого и детского населения,\nналичие специального автомобиля «медицинская помощь»', 2, 57, NULL, NULL),
(1452, 2, 'Укомплектованность АВОП врачами общей практики, медицинскими работниками, имеющими среднее специальное медицинское образование не менее 75 % по физическим лицам. Наличие квалификационных категорий у специалистов с медицинским образованием 100 % от лиц, подлежащих профессиональной аттестации', 1, 57, NULL, NULL),
(1453, 3, 'Заведующим АВОП осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности', 2, 57, NULL, NULL),
(1454, 4, 'График работы врачебной амбулатории обеспечивает доступность медицинской помощи. Обеспечена возможность получения консультации врача общей практики (помощника врача общей практики) в день обращения. Определен порядок оказания медицинской помощи пациентам на период отсутствия врача общей практики', 1, 57, NULL, NULL),
(1455, 5, 'Организован прием пациентов командой врача общей практики, самостоятельный прием пациентов помощником врача по амбулаторно-поликлинической помощи, медицинской сестрой общей практики, медицинской сестрой участковой.\nОрганизовано проведение патронажа пациентов медицинской сестрой общей практики, медицинской сестрой участковой', 2, 57, NULL, NULL),
(1456, 6, 'Медицинские работники АВОП проходят обучение и могут продемонстрировать навыки по оказанию экстренной медицинской помощи. Обеспечено проведение ЭКГ, в том числе в домашних условиях', 1, 57, NULL, NULL),
(1457, 7, 'Оснащение изделиями медицинского назначения и медицинской техникой АВОП, оснащение сумки врача общей практики соответствует утвержденному табелю. Обеспечено хранение лекарственных, иммунобиологических лекарственных препаратов и изделий медицинского назначения в соответствии с требованиями законодательства. Соблюдается порядок представления информации о выявленных нежелательных реакциях на лекарственные препараты', 2, 57, NULL, NULL),
(1458, 8, 'Для забора венозной крови во АВОП используются одноразовые стандартные системы: система шприц-пробирка, обеспечивающая как поршневой способ забора крови, так и вакуумный, вакуумные системы, обеспечивающие забор крови вакуумным методом со строгим соблюдением требований производителя компонентов систем', 2, 57, NULL, NULL),
(1459, 9, 'Направление на клинико-лабораторное исследование оформляется в электронном виде либо на бумажном носителе с указанием персональных данных в соответствии с нормативными правовыми актами', 3, 57, NULL, NULL),
(1460, 10, 'Обеспечена возможность проведения диагностики в соответствии с клиническими протоколами.\nОбеспечено назначение лечения пациентам в амбулаторных условиях согласно клиническим протоколам. \nСоблюдение установленного порядка направления в другие организации здравоохранения для проведения диагностики и консультаций врачей-специалистов', 1, 57, NULL, NULL),
(1461, 11, 'Наличие ежегодно обновляемого (до 1 января) списка обслуживаемого населения (взрослого и детского), закрепленного за АВОП. Выполняются требования утвержденного порядка проведения диспансеризации населения, адаптированного к условиям работы АВОП. Выполняются мероприятия по раннему выявлению злокачественных новообразований в соответствии с установленными порядками', 1, 57, NULL, NULL),
(1462, 12, 'Соблюдается порядок медицинского наблюдения пациентов в амбулаторных условиях. Ведется учет пациентов, подлежащих медицинскому наблюдению. Соблюдается преемственность с больничными организациями здравоохранения, выполнение рекомендаций по медицинскому наблюдению после выписки ', 2, 57, NULL, NULL),
(1463, 13, 'Организована работа с женским и детским населением: патронаж детей до года 100%, проводится осмотр детей СОП в установленном порядке. Организовано проведение профилактических прививок в соответствии с Национальным календарем профилактических прививок', 2, 57, NULL, NULL),
(1464, 14, 'Экспертиза временной нетрудоспособности осуществляется в соответствии с требованиями законодательства, в том числе определяющего получение, хранение, учет, списание и уничтожение бланков листков нетрудоспособности. Осуществляется своевременное направление пациентов на медико-социальную экспертизу ', 2, 57, NULL, NULL),
(1465, 15, 'Наличие условий для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 57, NULL, NULL),
(1466, 16, 'В организации здравоохранения медицинская реабилитация, медицинская абилитация осуществляется в соответствии с\nпорядком организации и проведения медицинской реабилитации, медицинской абилитации пациента (при обслуживании взрослого населения),\nпорядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет (при обслуживании детского населения),\nклиническими протоколами по профилям заболеваний, состояниям, синдромам,\nметодами оказания медицинской помощи, соответствующими профилю оказываемой медицинской помощи,\nлокальными нормативными актами, регламентирующими проведение медицинской реабилитации в организации здравоохранения.\nКритерий применяется для организаций здравоохранения, в штатном расписании которых отсутствует должность врача-реабилитолога', 1, 57, NULL, NULL),
(1467, 17, 'Отсутствуют неисполненные на дату проведения оценки (согласно установленным срокам) предписания и решения контролирующих органов в части соблюдения санитарно-эпидемиологического законодательства', 1, 57, NULL, NULL),
(1468, 18, 'Техническое обслуживание, текущий и капитальный ремонты зданий и помещений АВОП, инженерных систем (в том числе отопления, горячего и холодного водоснабжения, водоотведения (канализации), вентиляции, санитарно-технического оборудования) проводится в зависимости от их санитарно-технического состояния и в сроки, установленные планом мероприятий, разработанным и утвержденным руководителем организации', 2, 57, NULL, NULL),
(1482, 1, 'Деятельность организации здравоохранения осуществляется в соответствии с Уставом', 2, 59, NULL, NULL),
(1483, 2, 'Деятельность структурных подразделений осуществляется в соответствии с утвержденным положением о структурном подразделении, имеется ознакомление работников с положениями о структурных подразделениях', 3, 59, NULL, NULL),
(1484, 3, 'Наличие документов в соответствии с номенклатурой дел и выполнение утвержденных руководителем организации документов и локальных правовых актов (далее – ЛПА):\nкомплексный план основных организационных мероприятий,\nо режиме работы организации здравоохранения, структурных подразделений,\nо распределении обязанностей между заместителями руководителя,\nо трудовой и исполнительской дисциплине,\nо правилах внутреннего трудового распорядка', 2, 59, NULL, NULL),
(1485, 4, 'Руководителем организации здравоохранения определены ответственные лица за организацию оказания специализированной медицинской помощи', 3, 59, NULL, NULL),
(1486, 5, 'Наличие и выполнение требований системы управления охраны труда, обеспечивающей идентификацию опасностей, оценку профессиональных рисков, определение мер управления профессиональными рисками и анализ их результативности. Проводятся первичный, повторный, целевые (при необходимости) инструктажи с сотрудниками структурного подразделения. Разрабатываются инструкции по охране труда для профессий рабочих и (или) отдельных видов работ. Осуществляется контроль за соблюдением требований по охране труда', 2, 59, NULL, NULL),
(1487, 6, 'Наличие и выполнение общеобъектовой инструкции по пожарной безопасности. Определены лица, ответственные за пожарную безопасность, проводится обучение по программе пожарно-технического минимума с последующей проверкой знаний. Осуществление контроля за соблюдением требований по пожарной безопасности', 2, 59, NULL, NULL),
(1488, 7, 'Выполнение плановых показателей деятельности и проведение их анализа с принятием организационно-управленческих решений. Выполнение управленческих решений по улучшению качества медицинской помощи за последний отчетный период или год', 1, 59, NULL, NULL),
(1489, 8, 'Наличие положения о клинических конференциях. Проведение в организации здравоохранения клинических конференций, оформление протоколов проведения клинических конференций', 2, 59, NULL, NULL),
(1490, 9, 'Наличие на рабочих местах врачей-специалистов клинических протоколов, соответствующих профилю оказываемой медицинской помощи, либо обеспечен постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 59, NULL, NULL),
(1491, 10, 'Внедрение в практику работы новых методов оказания медицинской помощи за отчетный период или год', 3, 59, NULL, NULL),
(1492, 11, 'Проводится планирование и осуществление мероприятий по обеспечению радиационной безопасности в соответствии с законодательством. Имеется лицензия на данный вид деятельности', 1, 59, NULL, NULL),
(1493, 12, 'Наличие на информационных стендах в организации здравоохранения информации о правилах внутреннего распорядка для пациентов', 3, 59, NULL, NULL),
(1494, 13, 'Организована работа по защите персональных данных. Имеется политика организации в отношении обработки персональных данных, ЛПА о назначении лица или структурного подразделения, ответственного за осуществление внутреннего контроля за обработкой персональных данных, информированное согласие пациента (его законных представителей) на обработку персональных данных', 2, 59, NULL, NULL),
(1495, 14, 'Отсутствие фактов нарушения правил охраны труда, техники безопасности и пожарной безопасности работниками организации здравоохранения за последний отчетный период или год исполнительской и трудовой дисциплины, обоснованных жалоб в организации здравоохранения за последний отчетный период или год', 3, 59, NULL, NULL),
(1496, 15, 'Организована работа комиссии по вопросам медицинской этики и деонтологии организации здравоохранения', 2, 59, NULL, NULL),
(1497, 16, 'В организации здравоохранения соблюдаются права ребенка на получение безопасной и эффективной медицинской помощи, имеются условия для организации среды, дружественной детям (наличие и правильная организация игровых комнат, красочное оформление стен холлов, коридоров и др.)', 3, 59, NULL, NULL),
(1498, 17, 'В организации здравоохранения имеются условия для организации образовательного процесса пациентов школьного возраста в зависимости от сроков госпитализации, согласно действующим нормативным правовым актам', 2, 59, NULL, NULL),
(1499, 18, 'Работа по противодействию коррупции в организации здравоохранения осуществляется в соответствии с законодательством', 2, 59, NULL, NULL),
(1500, 19, 'Работа по осуществлению административных процедур организована в соответствии с законодательством ', 2, 59, NULL, NULL);
INSERT INTO `mark` (`id_mark`, `str_num`, `mark_name`, `mark_class`, `id_criteria`, `date_close`, `date_open`) VALUES
(1501, 20, 'Работа по обращениям граждан и юридических лиц организована в соответствии с законодательством\n', 2, 59, NULL, NULL),
(1502, 21, 'Наличие в организации здравоохранения ЛПА по обеспечению доступности медицинской помощи', 3, 59, NULL, NULL),
(1503, 22, 'График работы врачей-специалистов обеспечивает доступность специализированной медицинской помощи по профилю заболевания', 1, 59, NULL, NULL),
(1504, 23, 'Наличие в приемном отделении порядка (алгоритма) распределения потоков пациентов при обращении в организацию здравоохранения', 3, 59, NULL, NULL),
(1505, 24, 'Обеспечена доступность проведения телемедицинского консультирования, результаты которого документируются \nи находятся в медицинской карте', 2, 59, NULL, NULL),
(1506, 25, 'Наличие информации о деятельности организации здравоохранения, размещенной на информационных стендах и на официальном интернет-сайте организации здравоохранения', 2, 59, NULL, NULL),
(1507, 26, 'Официальный интернет-сайт организации здравоохранения функционирует в порядке, установленном законодательством', 2, 59, NULL, NULL),
(1508, 27, 'Наличие на информационных стендах в организации здравоохранения информации о лицах, имеющих право на внеочередное, первоочередное оказание медицинской помощи', 3, 59, NULL, NULL),
(1509, 28, 'Наличие и функционирование на официальном интернет-сайте организации здравоохранения дистанционных способов взаимодействия с получателями медицинских услуг:\nэлектронных сервисов (в том числе раздел «Часто задаваемые вопросы», раздел «Вопрос-Ответ»),\nобеспечение технической возможности выражения получателями медицинских услуг мнения о качестве и доступности медицинской помощи (наличие анкеты для опроса граждан или гиперссылки на нее)', 3, 59, NULL, NULL),
(1510, 29, 'Территория, прилегающая к организации здравоохранения, и ее помещения оборудованы с учетом доступности для лиц с ограниченными возможностями:\nоборудование входных групп пандусами (подъемными платформами),\nналичие выделенных стоянок для автотранспортных средств лиц с ограниченными возможностями,\nналичие поручней, расширенных проемов,\nналичие кресел-колясок', 3, 59, NULL, NULL),
(1511, 30, 'Наличие в организации здравоохранения условий, позволяющих лицам с ограниченными возможностями получать медицинские услуги наравне с другими пациентами, включая:\nналичие и доступность санитарно-гигиенических помещений,\nдублирование надписей, знаков и иной текстовой и графической информации знаками, выполненными рельефно-точечным шрифтом Брайля,\nналичие алгоритмов сопровождения лиц с ограниченными возможностями работниками организации здравоохранения', 2, 59, NULL, NULL),
(1512, 31, 'Наличие в организации здравоохранения места для хранения детских колясок', 3, 59, NULL, NULL),
(1513, 32, 'Штатная численность должностей служащих (профессий рабочих) утверждена руководителем организации здравоохранения с учетом норм нагрузок труда работников, установленных в организации здравоохранения, и является достаточной для оказания планируемых объемов медицинской помощи. Штатное расписание составляется и пересматривается ежегодно на основании анализа кадрового потенциала организации здравоохранения, фактического объема оказываемой медицинской помощи', 2, 59, NULL, NULL),
(1514, 33, 'В соответствии со штатным расписанием на каждую должность медицинского работника руководителем учреждения здравоохранения утверждена должностная инструкция с указанием квалификационных требований и функций, прав и обязанностей медицинских работников. Медицинские работники ознакомлены с должностной инструкцией', 2, 59, NULL, NULL),
(1515, 34, 'Квалификация медицинских работников соответствует требованиям должностной инструкции к занимаемой должности служащих', 1, 59, NULL, NULL),
(1516, 35, 'В организации здравоохранения проводится работа по обучению/повышению квалификации персонала (определяется потребность персонала в обучении/повышении квалификации, осуществляется планирование и контроль его прохождения).', 2, 59, NULL, NULL),
(1517, 36, 'Укомплектованность структурного подразделения врачами-специалистами не менее 75 % по физическим лицам', 1, 59, NULL, NULL),
(1518, 37, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам', 1, 59, NULL, NULL),
(1519, 38, 'Обеспечение кадровой потребности в специалистах с высшим медицинским, фармацевтическим образованием (укомплектованность) по занятым должностям служащих не менее 96 %', 1, 59, NULL, NULL),
(1520, 39, 'Обеспечение кадровой потребности в специалистах со средним медицинским, фармацевтическим образованием (укомплектованность) по занятым должностям служащих не менее 96 %', 1, 59, NULL, NULL),
(1521, 40, 'Закрепление молодых специалистов на рабочих местах после завершения срока работы по распределению (направлению на работу) не менее 90 %', 2, 59, NULL, NULL),
(1522, 41, 'Наличие квалификационных категорий у специалистов с высшим медицинским, фармацевтическим образованием 100 % от лиц, подлежащих профессиональной аттестации', 2, 59, NULL, NULL),
(1523, 42, 'Наличие квалификационных категорий у специалистов со средним медицинским, фармацевтическим образованием 100 % от лиц, подлежащих профессиональной аттестации', 2, 59, NULL, NULL),
(1524, 43, 'Коэффициент совместительства медицинских работников с высшим медицинским, фармацевтическим образованием не более 1,25', 2, 59, NULL, NULL),
(1525, 44, 'Коэффициент совместительства медицинских работников со средним медицинским, фармацевтическим образованием не более 1,25', 2, 59, NULL, NULL),
(1526, 45, 'Текучесть медицинских кадров с высшим медицинским, фармацевтическим образованием не более 7 %', 3, 59, NULL, NULL),
(1527, 46, 'Текучесть медицинских кадров со средним медицинским, фармацевтическим образованием не более 7 %', 3, 59, NULL, NULL),
(1528, 47, 'Наличие и выполнение в организации здравоохранения ЛПА:\nпо организации работы фармакотерапевтической комиссии по вопросам управления лекарственными препаратами, \nпо порядку приобретения, хранения, реализации, отпуска (распределения) наркотических средств и психотропных веществ и их прекурсоров', 1, 59, NULL, NULL),
(1529, 48, 'Осуществляется рациональное назначение, контроль за обоснованностью назначений и медицинского применения лекарственных препаратов', 2, 59, NULL, NULL),
(1530, 49, 'Соблюдается порядок учета лекарственных препаратов, подлежащих предметно-количественному учету, и изделий медицинского назначения', 2, 59, NULL, NULL),
(1531, 50, 'Определяется потребность, составляются и выполняются заявки на лекарственные препараты, изделия медицинского назначения в соответствии с Республиканским формуляром лекарственных средств, Республиканским формуляром медицинских изделий. Имеется список лекарственных средств для закупки на следующий календарный год на основании Республиканского формуляра лекарственных средств в соответствии с профилем и структурой заболеваемости пациентов', 1, 59, NULL, NULL),
(1532, 51, 'Проведение ABC/VEN анализа расхода бюджетных средств на лекарственные препараты. Проведение DDD анализа потребления антибактериальных препаратов резерва в соответствии с Республиканским формуляром лекарственных средств. Определение порядка представления информации о выявленных нежелательных реакциях на лекарственные средства', 3, 59, NULL, NULL),
(1533, 52, 'Организована выписка рецептов врача в соответствии с Инструкцией о порядке выписывания рецепта врача и создания электронных рецептов врача, утвержденной постановлением Министерства здравоохранения Республики Беларусь от 31 октября 2007 г. № 99', 2, 59, NULL, NULL),
(1534, 53, 'Обеспечено хранение лекарственных, иммунобиологических лекарственных препаратов и изделий медицинского назначения в соответствии с требованиями законодательства. Проводится контроль за условиями хранения и сроками годности', 1, 59, NULL, NULL),
(1535, 54, 'Помещения для хранения лекарственных препаратов оснащены средствами измерений для регистрации температуры и относительной влажности окружающей среды, прошедших государственную поверку (термогигрометры и (или) другие электронные устройства)', 2, 59, NULL, NULL),
(1536, 55, 'Материально-техническая база организации здравоохранения соответствует табелю, утвержденному руководителем на основании примерного табеля оснащения, утвержденного приказом Министерства здравоохранения Республики Беларусь 16.11.2018 №1180 ', 2, 59, NULL, NULL),
(1537, 56, 'В организации здравоохранения ЛПА определены лица, ответственные за техническое обслуживание и ремонт медицинской техники', 3, 59, NULL, NULL),
(1538, 57, 'Обеспечено ведение учета медицинской техники', 3, 59, NULL, NULL),
(1539, 58, 'Оснащение организации здравоохранения медицинскими изделиями и медицинской техникой в объеме, достаточном для оказания медицинской помощи, в том числе специализированной', 2, 59, NULL, NULL),
(1540, 59, 'Наличие своевременной государственной поверки средств измерений ', 2, 59, NULL, NULL),
(1541, 60, 'Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и (или) ремонтом. Техническое обслуживание и (или) ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на выполнение данных услуг', 1, 59, NULL, NULL),
(1542, 61, 'Обеспечена эффективность использования медицинской техники с учетом сменности, отсутствуют случаи необоснованного простоя', 1, 59, NULL, NULL),
(1543, 62, 'Проводится и документируется обучение медицинских работников правилам эксплуатации медицинской техники при вводе в эксплуатацию', 2, 59, NULL, NULL),
(1544, 63, 'Обеспечение организации здравоохранения медицинскими газами, назначены ответственные лица. Имеются договоры на обслуживание оборудования', 1, 59, NULL, NULL),
(1545, 64, 'Обеспечена информатизация организации здравоохранения:\nобеспечение медицинской информационной системой, автоматизированными информационными системами,\nвнедрение системы межведомственного документооборота,\nобеспечение информатизации рабочих мест (наличие персонального компьютера, электронной цифровой подписи),\nосуществляется ведение электронной медицинской карты пациента', 2, 59, NULL, NULL),
(1546, 65, 'Наличие ЛПА, регламентирующего порядок госпитализации в учреждение', 1, 59, NULL, NULL),
(1547, 66, 'Обеспечение разделения потоков плановых, экстренных пациентов', 2, 59, NULL, NULL),
(1548, 67, 'Наличие положения об ответственном дежурном враче больницы', 1, 59, NULL, NULL),
(1549, 68, 'Наличие системы аудио- и видеонаблюдения в приемном отделении', 2, 59, NULL, NULL),
(1550, 69, 'Обеспечение готовности приемного отделения к работе в условиях чрезвычайных ситуаций мирного и военного времени: наличие нормативных документов, тренинги персонала', 1, 59, NULL, NULL),
(1551, 70, 'Организовано взаимодействие по информированию в случаях подозрения на совершение противоправных действий', 2, 59, NULL, NULL),
(1552, 71, 'Наличие в приемном отделении современных автоматизированных систем учета и регистрации пациента', 2, 59, NULL, NULL),
(1553, 72, 'Определение порядка использования санитарного автотранспорта в соответствии с действующими нормативными документами', 2, 59, NULL, NULL),
(1554, 73, 'Наличие алгоритма идентификации личности детей при поступлении (переводе)', 2, 59, NULL, NULL),
(1555, 74, 'Наличие и выполнение в организации здравоохранения ЛПА, определяющих порядки организации и проведения в соответствии с требованиями законодательства:\n1.	медицинских осмотров, врачебных консультаций и врачебных консилиумов,\n2.	медицинского наблюдения пациентов,\n3.	организации проведения диагностических исследований,\n4.	раннего выявления онкологических заболеваний,\n5.	паллиативной медицинской помощи,\n6.	медицинской реабилитации', 2, 59, NULL, NULL),
(1556, 75, 'В организации здравоохранения круглосуточно* обеспечено проведение лабораторных, ультразвуковых, эндоскопических, рентгенологических, функциональных исследований\n*круглосуточность подтверждается графиком работы, дежурств на дому, привлечением закрепленных специалистов других организаций здравоохранения', 1, 59, NULL, NULL),
(1557, 76, 'Утвержден перечень экстренных лабораторных исследований с установленными минимальными и максимальными сроками их проведения', 3, 59, NULL, NULL),
(1558, 77, 'В организации здравоохранения разработаны правила доставки образцов биологического материала для каждого вида клинических лабораторных исследований с регламентацией условий транспортировки биологических образцов к месту проведения аналитического этапа исследования', 3, 59, NULL, NULL),
(1559, 78, 'В организации здравоохранения для забора венозной крови используются одноразовые стандартные системы: система шприц-пробирка, обеспечивающая как поршневой способ забора крови, так и вакуумный, вакуумные системы, обеспечивающие забор крови вакуумным методом со строгим соблюдением требований производителя компонентов систем', 1, 59, NULL, NULL),
(1560, 79, 'В организации здравоохранения соблюдается последовательность заполнения вакуумных систем: кровь без антикоагулянтов или с прокоагулянтами\nкровь с цитратом\nкровь с гепарином\nкровь с ЭДТА', 2, 59, NULL, NULL),
(1561, 80, 'Транспортировка биологических проб осуществляется в специально предназначенных для этого и промаркированных контейнерах', 2, 59, NULL, NULL),
(1562, 81, 'Порядок транспортировки биологического материала в лабораторию в обязательном порядке предусматривает:\nв каждой организации здравоохранения должен быть определен медицинский работник, ответственный за транспортировку образцов биологического материала в лабораторию, в обязанности которого входит:\nосуществление контроля за подготовленным к транспортировке биологическим материалом, соответствием количества заявок на лабораторные исследования количеству отобранных проб биологического материала,\nоформление Акта приема образцов биологического материала для лабораторных исследований,\nконтроль за температурным режимом в контейнерах не реже 1 раза в 5 дней,\nведение Журнала контроля температурного режима контейнеров,\nдоставка материала в лабораторию осуществляется в максимально короткий промежуток времени, при этом нормативы времени доставки биологического материала в лабораторию отражаются в алгоритме доставки биологического материала, разработанного для данной организации здравоохранения,\nконтейнеры должны обеспечивать соответствующие температурные режимы в зависимости от вида лабораторных исследований. В зависимости от требуемой для транспортировки биологического материала температуры они оборудуются хладагентами (для поддержания температуры 2-8 °C) или термоэлементами (для поддержания температуры в диапазоне 37 °C)', 2, 59, NULL, NULL),
(1563, 82, 'Направление на клинико-лабораторное исследование оформляется в электронном виде либо на бумажном носителе с указанием персональных данных в соответствии с нормативными правовыми актами', 2, 59, NULL, NULL),
(1564, 83, 'Госпитализация пациентов осуществляется в соответствии с медицинскими показаниями', 1, 59, NULL, NULL),
(1565, 84, 'Длительность предоперационного пребывания плановых пациентов в стационарных условиях не превышает 2 суток, кроме случаев, где требуется проведение дополнительной диагностики', 1, 59, NULL, NULL),
(1566, 85, 'Назначение диагностических исследований в соответствии с требованиями клинических протоколов', 1, 59, NULL, NULL),
(1567, 86, 'Назначение лекарственных препаратов в соответствии с требованиями клинических протоколов и инструкциями по медицинскому применению лекарственного препарата', 1, 59, NULL, NULL),
(1568, 87, 'Осуществляется патологоанатомическое исследование биопсийного (операционного) материала при проведении оперативного вмешательства в 100 % случаев', 1, 59, NULL, NULL),
(1569, 88, 'Патологоанатомические вскрытия проводятся в 100 % от числа умерших, подлежащих обязательному патологоанатомическому вскрытию', 2, 59, NULL, NULL),
(1570, 89, 'Направление эпикризов в организацию здравоохранения по месту жительства (месту пребывания) на электронном или бумажном носителе', 2, 59, NULL, NULL),
(1571, 90, 'Отсутствие роста послеоперационных летальных исходов при экстренной хирургической патологии, случаев расхождения клинических и патологоанатомических диагнозов по основному заболеванию 2-3 категории', 2, 59, NULL, NULL),
(1572, 91, 'Организовано обеспечение пациентов лечебным питанием в соответствии с требованиями законодательства', 1, 59, NULL, NULL),
(1573, 92, 'Организована работа специализированных тематических школ (школ здоровья)', 3, 59, NULL, NULL),
(1574, 93, 'В организации здравоохранения медицинская реабилитация, медицинская абилитация осуществляется в соответствии с\nпорядком организации и проведения медицинской реабилитации, медицинской абилитации пациента (при обслуживании взрослого населения),\nпорядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет (при обслуживании детского населения),\nклиническими протоколами по профилям заболеваний, состояниям, синдромам,\nметодами оказания медицинской помощи, соответствующими профилю оказываемой медицинской помощи,\nлокальными нормативными актами, регламентирующими проведение медицинской реабилитации в организации здравоохранения.\nКритерий применяется для организаций здравоохранения, в штатном расписании которых отсутствует должность врача-реабилитолога', 1, 59, NULL, NULL),
(1575, 94, 'Оформление медицинских документов осуществляется по установленным формам, в соответствии с требованиями нормативных правовых актов Министерства здравоохранения Республики Беларусь', 1, 59, NULL, NULL),
(1576, 95, 'Медицинские осмотры пациентов проводятся в соответствии с Инструкцией о порядке проведения медицинских осмотров с оформлением записи в медицинских документах', 1, 59, NULL, NULL),
(1577, 96, 'Имеется согласие или отказ пациента или лиц, указанных в части второй статьи 18 Закона Республики Беларусь «О здравоохранении», на проведение простых и (или) сложных медицинских вмешательств, оформленный в соответствии с нормативными правовыми актами Республики Беларусь', 2, 59, NULL, NULL),
(1578, 97, 'Врачебные консультации (консилиумы) и их решения оформляются в соответствии с требованиями Инструкции о порядке проведения врачебных консультаций (консилиумов), утвержденной Министерством здравоохранения Республики Беларусь', 2, 59, NULL, NULL),
(1579, 98, 'Осуществляется документооборот с другими организациями здравоохранения в целях обеспечения преемственности в оказании медицинской помощи населению:\nоформление направлений на стационарное лечение, консультации врачей-специалистов, справок о состоянии здоровья и выписок из медицинских документов в другие организации здравоохранения,\nпредоставление эпикризов стационарного лечения и заключений врачебных консультаций, справок о состоянии здоровья и выписок из медицинских документов из других организаций здравоохранения', 2, 59, NULL, NULL),
(1580, 99, 'Профилактические прививки выполнены в соответствии с Национальным календарем профилактических прививок согласно приложению 1 к постановлению Министерства здравоохранения Республики Беларусь от 17 мая 2018 г. № 42 «О профилактических прививках» и (или) по эпидемиологическим показаниям', 1, 59, NULL, NULL),
(1581, 100, 'Профилактические прививки выполнены с учетом медицинских показаний и противопоказаний к их проведению, в соответствии с инструкцией по медицинскому применению, прилагаемой к иммунобиологическому лекарственному препарату', 1, 59, NULL, NULL),
(1582, 101, 'Наличие устного согласия на проведение профилактической прививки или в установленном порядке оформленного отказа от проведения профилактической прививки', 1, 59, NULL, NULL),
(1583, 102, 'Осуществление медицинского осмотра врачом-педиатром (врачом-специалистом) перед проведением профилактической прививки', 1, 59, NULL, NULL),
(1584, 103, 'Осуществление медицинским работником, проводившим профилактическую прививку, медицинского наблюдения за пациентом в течение 30 минут после введения иммунобиологического лекарственного препарата', 1, 59, NULL, NULL),
(1585, 104, 'Выявление, регистрация и расследование случаев серьезных побочных реакций на профилактические прививки, направление внеочередной информации о серьезной побочной реакции после прививки', 1, 59, NULL, NULL),
(1586, 105, 'Транспортировка, хранение и уничтожение иммунобиологических лекарственных средств, а также хранение и использование хладоэлементов соответствует санитарно-эпидемиологическим требованиям', 1, 59, NULL, NULL),
(1587, 106, 'Наличие и выполнение в организации здравоохранения ЛПА, регулирующего порядок организации оказания экстренной и неотложной медицинской помощи пациентам. Утверждены алгоритмы оказания экстренной медицинской и неотложной помощи, в том числе комплекса мероприятий сердечно-легочной реанимации, соответствующие условиям оказания медицинской помощи в структурных подразделениях учреждения здравоохранения', 1, 59, NULL, NULL),
(1588, 107, 'Наличие и выполнение в организации здравоохранения ЛПА, определяющего перечень лиц, осуществляющих контроль за наличием необходимых лекарственных препаратов, изделий медицинского назначения для оказания экстренной медицинской помощи, своевременное их пополнение и соблюдение сроков годности. В структурном подразделении определены лица, осуществляющие контроль за наличием необходимых лекарственных препаратов, медицинских изделий для оказания экстренной медицинской помощи, своевременное их пополнение и соблюдение сроков годности', 2, 59, NULL, NULL),
(1589, 108, 'Наличие лекарственных препаратов, медицинских изделий, медицинской техники, компонентов и препаратов крови для оказания экстренной и неотложной медицинской помощи в соответствии с требованиями клинических протоколов', 1, 59, NULL, NULL),
(1590, 109, 'Наличие и обеспечение хранения лекарственных препаратов, иммунобиологических лекарственных средств, изделий медицинского назначения, медицинской техники, компонентов и препаратов крови для оказания неотложной медицинской помощи в соответствии с требованиями нормативных правовых актов', 1, 59, NULL, NULL),
(1591, 110, 'В структурном подразделении проводятся занятия с медицинскими работниками по освоению теоретических и практических навыков оказания экстренной медицинской помощи с последующим контролем знаний с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев ', 1, 59, NULL, NULL),
(1592, 111, 'Наличие ЛПА по проведению экспертизы временной нетрудоспособности (далее – экспертизы ВН) в организации здравоохранения, в том числе определяющего получение, хранение, учет, списание и уничтожение бланков листков нетрудоспособности, справок о временной нетрудоспособности в соответствии с требованиями нормативных документов', 2, 59, NULL, NULL),
(1593, 112, 'Бухгалтерский учет и использование бланков строгой отчетности (листков нетрудоспособности) осуществляется в соответствии с Инструкцией о порядке использования и бухгалтерского учета бланков строгой отчетности', 1, 59, NULL, NULL),
(1594, 113, 'Организована работа врачебно-консультационных комиссий в соответствии с требованиями законодательства Республики Беларусь', 2, 59, NULL, NULL),
(1595, 114, 'Проводятся инструктажи по вопросам проведения экспертизы ВН и контроль знаний ', 2, 59, NULL, NULL),
(1596, 115, 'Проводится анализ статистических показателей заболеваемости с временной нетрудоспособностью с выявлением причин их отклонения', 3, 59, NULL, NULL),
(1597, 116, 'Осуществляется выдача и оформление листков нетрудоспособности и справок о временной нетрудоспособности в соответствии с требованиями Инструкции о порядке выдачи и оформления листков нетрудоспособности и справок о временной нетрудоспособности', 1, 59, NULL, NULL),
(1598, 117, 'В организации здравоохранения ЛПА правовым актом утвержден порядок организации и проведения экспертизы качества медицинской помощи (далее – экспертиза качества), оценки качества медицинской помощи и медицинских экспертиз (далее – оценка качества) в соответствии с требованиями законодательства. Определены лица, ответственные за организацию и проведение экспертизы качества, оценки качества', 3, 59, NULL, NULL),
(1599, 118, 'Оценка качества проводится в соответствии с планом, утвержденным руководителем организации здравоохранения.', 1, 59, NULL, NULL),
(1600, 119, 'По результатам экспертизы качества и (или) оценки качества оформляется заключение', 1, 59, NULL, NULL),
(1601, 120, 'Результаты экспертизы качества, оценки качества рассматриваются на врачебно-консультационных комиссиях, клинических конференциях, принимаются меры по устранению причин и условий, повлекших снижение качества медицинской помощи, медицинских экспертиз', 2, 59, NULL, NULL),
(1602, 121, 'Наличие специальных медицинских изделий для профилактики и лечения пролежней по количеству коек анестезиологии, реанимации и интенсивной терапии', 2, 59, NULL, NULL),
(1603, 122, 'Определены функциональные обязанности работников структурных подразделений по осуществлению мероприятий по уходу за лежачими пациентами', 1, 59, NULL, NULL),
(1604, 123, 'Осуществление комплекса профилактических мероприятий по предупреждению развития пролежней, проведение лечения пролежней с оформлением медицинских документов', 1, 59, NULL, NULL),
(1605, 124, 'Обеспечено устранение в срок рекомендаций по устранению нарушений, предписаний об устранении нарушений, выданных территориальными центрами гигиены и эпидемиологии ', 1, 59, NULL, NULL),
(1606, 125, 'Осуществляется выполнение разработанной и утвержденной руководителем организации здравоохранения программы производственного контроля. Сроки и кратность проведения лабораторного производственного контроля соблюдаются согласно установленным в программе производственного контроля на протяжении 3-х последних лет', 2, 59, NULL, NULL),
(1607, 126, 'В организации оборудована и функционирует система приточно-вытяжной вентиляции. Профилактический ремонт, обслуживание и ремонт системы вентиляции проводится не реже одного раза в 3 года', 2, 59, NULL, NULL),
(1608, 127, 'Имеется функционирующая система проточного холодного и горячего водоснабжения, система водоотведения (канализации). Умывальники в помещениях, к которым предъявляется данное требование, оснащены кранами с локтевым (бесконтактным, педальным и прочим не кистевым) управлением. В помещениях, к которым предъявляется данное требование, имеется резервное горячее водоснабжение, в том числе обеспечена его работоспособность', 1, 59, NULL, NULL),
(1609, 128, 'Отопление организации здравоохранения осуществляется централизованно или с помощью локальных (автономных) систем, Печное отопление не применяется. В зимнее время система отопления обеспечивает нормируемые показатели температуры воздуха в помещении', 2, 59, NULL, NULL),
(1610, 129, 'Установлены и находятся в функционирующем состоянии медицинские изделия для очистки воздуха в помещениях, к которым предъявляется данное требование', 2, 59, NULL, NULL),
(1611, 130, 'Внутренняя отделка помещений, в том числе поверхности дверей, окон и нагревательных приборов, выполнена в соответствии с функциональным назначением помещений и устойчива к моющим и дезинфицирующим средствам.', 2, 59, NULL, NULL),
(1612, 131, 'Отсутствует в использовании мебель с дефектами покрытия и (или) неисправная мебель, неисправные санитарно-технические изделия и оборудование, медицинские изделия', 2, 59, NULL, NULL),
(1613, 132, 'Стерилизация осуществляется в централизованном стерилизационном отделении и (или) в стерилизационной. Отсутствуют места организации стерилизации в лечебных кабинетах (манипуляционных, перевязочных, кабинетах приема врачей-специалистов или в других приспособленных местах)', 2, 59, NULL, NULL),
(1614, 133, 'Стерилизации подвергаются медицинские изделия, контактирующие с раневой поверхностью, кровью, внутренними стерильными полостями организма, растворами для инъекций, а также которые в процессе эксплуатации соприкасаются со слизистой оболочкой и могут вызвать ее повреждение', 1, 59, NULL, NULL),
(1615, 134, 'Отсутствуют в использовании простерилизованные медицинские изделия с истекшим сроком стерильности либо хранившиеся с нарушением условий сохранения стерильности', 1, 59, NULL, NULL),
(1616, 135, 'Отработанные медицинские изделия подвергаются дезинфекции химическим или физическим методом', 2, 59, NULL, NULL),
(1617, 136, 'Организован сбор, обеззараживание, транспортировка, хранение и утилизация отходов производства и потребления (путем переработки, сжигания или захоронения) в соответствии с требованиями законодательства Республики Беларусь', 2, 59, NULL, NULL),
(1618, 137, 'Для упорядоченного временного хранения медицинских отходов созданы условия, исключающие прямой контакт с медицинскими отходами пациентов и работников (специально выделенное место, помещение, шкаф или другое)', 2, 59, NULL, NULL),
(1619, 138, 'Стирка белья, санитарной одежды, полотенец, салфеток осуществляется в прачечной, прачечной общего типа и (или) мини-прачечных в отделении организации.\nБелье и постельные принадлежности (матрасы, подушки, одеяла) подвергаются дезинфекции в случаях, предусмотренных законодательством', 2, 59, NULL, NULL),
(1620, 139, 'Обеспечено раздельное хранение личной и санитарной одежды в изолированных секциях шкафов. Не допускается стирка санитарной одежды в домашних условиях', 2, 59, NULL, NULL),
(1621, 140, 'Территория и помещения организации здравоохранения содержатся в чистоте, соблюдается утвержденный порядок уборок', 2, 59, NULL, NULL),
(1622, 141, 'Техническое обслуживание, текущий и капитальный ремонты зданий и помещений организаций, инженерных систем (в том числе отопления, горячего и холодного водоснабжения, водоотведения (канализации), вентиляции, санитарно-технического оборудования) проводится в зависимости от их санитарно-технического состояния и в сроки, установленные планом мероприятий, разработанным и утвержденным руководителем организации', 2, 59, NULL, NULL),
(1623, 142, 'Работники, подлежащие обязательным медицинским осмотрам, проходят их в порядке, предусмотренным законодательством', 2, 59, NULL, NULL),
(1624, 143, 'Минимальный состав и площади отдельных помещений соответствуют приложению 1 к санитарным нормам и правилам «Санитарно-эпидемиологические требования к организациям, оказывающим медицинскую помощь, в том числе к организации и проведению санитарно-противоэпидемических мероприятий по профилактике инфекционных заболеваний в этих организациях», утвержденным постановлением Министерства здравоохранения Республики Беларусь от 5 июля 2017 г. № 73', 2, 59, NULL, NULL),
(1625, 144, 'Дезинфекция высокого уровня и (или) стерилизация эндоскопического оборудования осуществляется механизированным способом. Организация здравоохранения оснащена достаточным количеством моечно-дезинфекционных машин и шкафов для асептического хранения эндоскопического оборудования.\n(Указанный критерий заполняется только в отношении тех организаций, где проводятся эндоскопические вмешательства на нестерильных полостях организма)', 2, 59, NULL, NULL),
(1737, 1, 'Деятельность организации здравоохранения осуществляется в соответствии с Уставом (Положением об обособленном структурном подразделении)', 2, 60, NULL, NULL),
(1738, 2, 'Наличие документов в соответствии с номенклатурой дел и выполнение утвержденных руководителем организации документов и локальных правовых актов (далее – ЛПА):\nкомплексный план основных организационных мероприятий,\nо режиме работы организации здравоохранения, структурных подразделений,\nЛПА о распределении обязанностей между заместителями руководителя,\nо трудовой и исполнительской дисциплине,\nправила внутреннего трудового распорядка.\n', 2, 60, NULL, NULL),
(1739, 3, 'Деятельность структурных подразделений осуществляется в соответствии с утвержденным положением о структурном подразделении, имеется ознакомление работников с положениями о структурных подразделениях', 3, 60, NULL, NULL),
(1740, 4, 'Руководителем организации здравоохранения определены ответственные лица за организацию оказания специализированной медицинской помощи', 3, 60, NULL, NULL),
(1741, 5, 'Выполнение плановых показателей деятельности и проведение их анализа с принятием организационно-управленческих решений. Выполнение управленческих решений по улучшению качества медицинской помощи за последний отчетный период или год', 1, 60, NULL, NULL),
(1742, 6, 'Наличие и выполнение в организации здравоохранения ЛПА, регламентирующего порядок по организации и проведении клинических конференций. Проведение в организации здравоохранения клинических конференций, оформление протоколов проведения клинических конференций.', 2, 60, NULL, NULL),
(1743, 7, 'Проводится обучение и контроль знаний медицинских работников клинических протоколов по профилям заболеваний, состояниям, синдромам, порядков и методов оказания медицинской помощи (далее – клинические протоколы), соответствующих профилю оказываемой медицинской помощи', 2, 60, NULL, NULL),
(1744, 8, 'Наличие на рабочих местах врачей-специалистов клинических протоколов, соответствующих профилю оказываемой медицинской помощи, либо обеспечен постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 60, NULL, NULL),
(1745, 9, 'Внедрение в практику работы новых методов оказания медицинской помощи и (или) малоинвазивных методик диагностики и лечения за последний отчетный период или год', 3, 60, NULL, NULL),
(1746, 10, 'Проводится планирование и осуществление мероприятий по обеспечению радиационной безопасности в соответствии с законодательством. Имеется лицензия на данный вид деятельности', 1, 60, NULL, NULL),
(1747, 11, 'Обеспечено проведение предабортного психологического консультирования женщин, обратившихся за проведением искусственного прерывания беременности', 2, 60, NULL, NULL),
(1748, 12, 'Наличие и выполнение в организации здравоохранения ЛПА, регламентирующего порядок организации работы по защите персональных данных. Имеется политика организации в отношении обработки персональных данных. Проводится контроль за обработкой персональных данных, имеется информированное согласие пациента на обработку персональных данных', 2, 60, NULL, NULL),
(1749, 13, 'Наличие и выполнение требований системы управления охраной труда, обеспечивающей идентификацию опасностей, оценку профессиональных рисков, определение мер управления профессиональными рисками и анализ их результативности. Проводятся первичный, повторный, целевые (при необходимости) инструктажи с сотрудниками структурного подразделения. Разрабатываются инструкции по охране труда для профессий рабочих и (или) отдельных видов работ. Осуществляется контроль за соблюдением требований по охране труда', 2, 60, NULL, NULL),
(1750, 14, 'Наличие и выполнение общеобъектовой инструкции по пожарной безопасности. Определены лица, ответственные за пожарную безопасность, проводится обучение по программе пожарно-технического минимума с последующей проверкой знаний. Осуществляется контроль за соблюдением требований по пожарной безопасности', 2, 60, NULL, NULL),
(1751, 15, 'Отсутствие фактов нарушения правил охраны труда, техники безопасности и пожарной безопасности работниками организации здравоохранения за последний отчетный период или год исполнительской и трудовой дисциплины, обоснованных жалоб в организации здравоохранения за последний отчетный период или год', 3, 60, NULL, NULL),
(1752, 16, 'Организована работа комиссии по вопросам медицинской этики и деонтологии организации здравоохранения.', 2, 60, NULL, NULL),
(1753, 17, 'Работа по противодействию коррупции в организации здравоохранения осуществляется в соответствии с законодательством', 2, 60, NULL, NULL),
(1754, 18, 'Работа по осуществлению административных процедур организована в соответствии с законодательством', 2, 60, NULL, NULL),
(1755, 19, 'Работа по обращениям граждан и юридических лиц организована в соответствии с законодательством', 2, 60, NULL, NULL),
(1756, 20, 'Наличие в организации здравоохранения ЛПА, регламентирующего порядок по обеспечению доступности медицинской помощи', 3, 60, NULL, NULL),
(1757, 21, 'Расчет планового количества посещений в учреждениях здравоохранения соответствует методике, утвержденной Министерством здравоохранения Республики Беларусь. Использованные при расчете плана посещений нормы нагрузки (обслуживания) на приеме врача и вне организации здравоохранения соответствуют утвержденным нормативам', 2, 60, NULL, NULL),
(1758, 22, 'График работы врачей-специалистов обеспечивает доступность медицинской помощи по профилю заболевания', 1, 60, NULL, NULL),
(1759, 23, 'Наличие на информационных стендах в организации здравоохранения информации:\nо режиме работы организации здравоохранения и структурных подразделений,\nо правилах внутреннего распорядка для пациентов,\nо порядке оказания медицинской помощи гражданам Республики Беларусь, в том числе льготным категориям граждан,\nо лицах, имеющих право на внеочередное, первоочередное оказание медицинской помощи,\nо порядке оказания медицинской помощи иностранным гражданам и лицам без гражданства,\nо приеме граждан по личным вопросам руководством организации здравоохранения и вышестоящим руководством\n', 3, 60, NULL, NULL),
(1760, 24, 'Официальный интернет-сайт организации здравоохранения функционирует в порядке, установленном законодательством', 2, 60, NULL, NULL),
(1761, 25, 'Наличие и функционирование на официальном интернет-сайте организации здравоохранения: дистанционных способов взаимодействия с получателями медицинских услуг (электронных сервисов «Часто задаваемые вопросы», раздел «Вопрос-Ответ»)', 2, 60, NULL, NULL),
(1762, 26, 'Наличие на официальном интернет-сайте и визуальном доступе в организации здравоохранения информации о порядке проведения диспансеризации взрослого и детского населения', 2, 60, NULL, NULL),
(1763, 27, 'Имеется и функционирует в организации здравоохранения система «Электронная очередь»', 2, 60, NULL, NULL),
(1764, 28, 'Обеспечена доступность записи на прием к врачу-специалисту через «Информационный киоск», по телефону, на официальном сайте или при обращении пациента в организацию здравоохранения', 3, 60, NULL, NULL),
(1765, 29, 'Обеспечена доступность получения консультации врача общей практики (помощника врача общей практики) в день обращения в организацию здравоохранения ', 1, 60, NULL, NULL),
(1766, 30, 'Обеспечена доступность выполнения лабораторных исследований при наличии у пациента направления на их проведение', 1, 60, NULL, NULL),
(1767, 31, 'Организована предварительная запись пациентов на диспансеризацию', 2, 60, NULL, NULL),
(1768, 32, 'Соблюдается установленный в организации здравоохранения порядок направления на плановые и срочные диагностические исследования', 2, 60, NULL, NULL),
(1769, 33, 'Обеспечен минимальный 2-х сменный режим работы КТ, МРТ, лаборатории, рентгенологических исследований (при наличии)', 1, 60, NULL, NULL),
(1770, 34, 'Территория, прилегающая к организации здравоохранения, и ее помещения оборудованы с учетом доступности для лиц с ограниченными возможностями:\nоборудование входных групп пандусами (подъемными платформами),\nналичие выделенных стоянок для автотранспортных средств лиц с ограниченными возможностями,\nналичие поручней, расширенных проемов, наличие кресел-колясок\n', 3, 60, NULL, NULL),
(1771, 35, 'Наличие в организации здравоохранения условий, позволяющих лицам с ограниченными возможностями получать медицинские услуги наравне с другими пациентами, включая:\nналичие и доступность санитарно-гигиенических помещений,\nдублирование надписей, знаков и иной текстовой и графической информации знаками, выполненными рельефно-точечным шрифтом Брайля,\nналичие алгоритмов сопровождения лиц с ограниченными возможностями работниками организации здравоохранения\n', 2, 60, NULL, NULL),
(1772, 36, 'Штатная численность должностей служащих (профессий рабочих) утверждена руководителем организации здравоохранения с учетом норм нагрузок труда работников, установленных в организации здравоохранения, и является достаточной для оказания планируемых объемов медицинской помощи. Штатное расписание составляется и пересматривается ежегодно, на основании анализа кадрового потенциала организации здравоохранения, фактического объема оказываемой медицинской помощи', 2, 60, NULL, NULL),
(1773, 37, 'В соответствии со штатным расписанием на каждую должность медицинского работника руководителем учреждения здравоохранения утверждена должностная инструкция с указанием квалификационных требований и функций, прав и обязанностей медицинских работников. Медицинские работники ознакомлены с должностной инструкцией', 2, 60, NULL, NULL),
(1774, 38, 'Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего', 1, 60, NULL, NULL),
(1775, 39, 'В организации здравоохранения проводится работа по обучению/повышению квалификации персонала (определяется потребность персонала в обучении/повышении квалификации, осуществляется планирование и контроль его прохождения).', 2, 60, NULL, NULL),
(1776, 40, 'Укомплектованность организации здравоохранения врачами-специалистами не менее 75 % по физическим лицам', 1, 60, NULL, NULL),
(1777, 41, 'Укомплектованность организации здравоохранения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам', 1, 60, NULL, NULL),
(1778, 42, 'Обеспечение кадровой потребности в специалистах с высшим медицинским, фармацевтическим образованием (укомплектованность) по занятым должностям служащих не менее 96 %', 1, 60, NULL, NULL),
(1779, 43, 'Обеспечение кадровой потребности в специалистах со средним медицинским, фармацевтическим образованием (укомплектованность) по занятым должностям служащих не менее 96 %', 1, 60, NULL, NULL),
(1780, 44, 'Закрепление молодых специалистов на рабочих местах после завершения срока работы по распределению (направлению на работу) не менее 90 %', 2, 60, NULL, NULL),
(1781, 45, 'Наличие квалификационных категорий у специалистов с высшим медицинским, фармацевтическим образованием 100 % от лиц, подлежащих профессиональной аттестации', 2, 60, NULL, NULL),
(1782, 46, 'Наличие квалификационных категорий у специалистов со средним медицинским, фармацевтическим образованием 100 % от лиц, подлежащих профессиональной аттестации', 2, 60, NULL, NULL),
(1783, 47, 'Коэффициент совместительства медицинских работников с высшим медицинским, фармацевтическим образованием не более 1,25', 2, 60, NULL, NULL),
(1784, 48, 'Коэффициент совместительства медицинских работников со средним медицинским, фармацевтическим образованием не более 1,25', 2, 60, NULL, NULL),
(1785, 49, 'Текучесть медицинских кадров с высшим медицинским, фармацевтическим образованием не более 7 %', 3, 60, NULL, NULL),
(1786, 50, 'Текучесть медицинских кадров со средним медицинским, фармацевтическим образованием не более 7 %', 3, 60, NULL, NULL),
(1787, 51, 'Наличие и выполнение в организации здравоохранения ЛПА, регламентирующих порядок работы по:\nорганизации работы фармакотерапевтической комиссии по вопросам управления лекарственными препаратами,\nпо приобретению, хранению, реализации, отпуска (распределения) наркотических средств и психотропных веществ и их прекурсоров,\nпредоставлению информации о выявленных нежелательных реакциях на лекарственные препараты\n', 1, 60, NULL, NULL),
(1788, 52, 'Осуществляется рациональное назначение, контроль за обоснованностью назначений и медицинского применения лекарственных препаратов', 2, 60, NULL, NULL),
(1789, 53, 'Соблюдается порядок учета лекарственных препаратов, подлежащих предметно-количественному учету, и изделий медицинского назначения', 2, 60, NULL, NULL),
(1790, 54, 'Определяется потребность, составляются и выполняются заявки на лекарственные средства, изделия медицинского назначения в соответствии с Республиканским формуляром лекарственных средств, Республиканским формуляром медицинских изделий. ', 1, 60, NULL, NULL),
(1791, 55, 'Организована выписка рецептов врача в соответствии с Инструкцией о порядке выписывания рецепта врача и создания электронных рецептов врача, утвержденной постановлением Министерства здравоохранения Республики Беларусь от 31 октября 2007 г. № 99:\n наличие бланков рецептов врача для выписки лекарственных препаратов, реализуемых в аптеке за полную стоимость, на льготных условиях, в том числе бесплатно, использование иных (компьютерных) способов выписывания рецептов,\nналичие и учет бланков рецептов врача для выписки наркотических средств,\nналичие и учет бланков рецептов врача для выписки психотропных веществ и лекарственных препаратов, обладающих анаболической активностью\n', 2, 60, NULL, NULL),
(1792, 56, 'Обеспечено хранение лекарственных, иммунобиологических лекарственных препаратов и изделий медицинского назначения в соответствии с требованиями законодательства. Проводится контроль за условиями хранения и сроками годности', 1, 60, NULL, NULL),
(1793, 57, 'Помещения для хранения лекарственных препаратов оснащены средствами измерений для регистрации температуры и относительной влажности окружающей среды, прошедших государственную поверку (термогигрометры и (или) другие электронные устройства).', 2, 60, NULL, NULL),
(1794, 58, 'Материально-техническая база организации здравоохранения соответствует табелю, утвержденному руководителем на основании примерного табеля оснащения, утвержденного приказом Министерства здравоохранения Республики Беларусь 16.11.2018 №1180', 2, 60, NULL, NULL),
(1795, 59, 'Наличие и выполнение в организации здравоохранения ЛПА, определяющего ответственных лиц за техническое обслуживание и ремонт медицинской техники', 3, 60, NULL, NULL),
(1796, 60, 'Обеспечено ведение учета медицинской техники', 3, 60, NULL, NULL),
(1797, 61, 'Оснащение организации здравоохранения медицинскими изделиями и медицинской техникой в объеме, достаточном для оказания медицинской помощи, в том числе специализированной', 2, 60, NULL, NULL),
(1798, 62, 'Наличие своевременной государственной поверки средств измерений', 2, 60, NULL, NULL),
(1799, 63, 'Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и (или) ремонтом. Техническое обслуживание и (или) ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на выполнение данных услуг', 1, 60, NULL, NULL),
(1800, 64, 'Обеспечена эффективность использования медицинской техники с учетом сменности, отсутствуют случае необоснованного простоя', 1, 60, NULL, NULL),
(1801, 65, 'Проводится и документируется обучение медицинских работников правилам эксплуатации медицинской техники при вводе в эксплуатацию', 2, 60, NULL, NULL),
(1802, 66, 'Соблюдается порядок информирования о технике медицинской стоимостью выше 2000 базовых величин, числящейся на балансе организации здравоохранения, но не установленной или не эксплуатируемой', 1, 60, NULL, NULL),
(1803, 67, 'Обеспечение организации здравоохранения медицинскими газами, назначены ответственные лица. Имеются договоры на обслуживание оборудования', 1, 60, NULL, NULL),
(1804, 68, 'Обеспечена информатизация организации здравоохранения:\n обеспечение медицинской информационной системой, автоматизированными информационными системами,\n внедрение системы межведомственного документооборота,\n обеспечение информатизации рабочих мест (наличие персонального компьютера, электронной цифровой подписи), осуществляется ведение электронной медицинской карты пациента\n', 2, 60, NULL, NULL),
(1805, 69, 'Регистратура оснащена персональными компьютерами, рабочие места медицинских регистраторов автоматизированы', 2, 60, NULL, NULL),
(1806, 70, 'Наличие элементов «заботливой поликлиники» (организация call-центра, визуальное оформление регистратуры по типу «открытая регистратура», аппаратно-программные комплексы: электронная регистратура, электронная очередь, демонстрационная панель, зоны комфортного ожидания в холлах и др.)', 3, 60, NULL, NULL),
(1807, 71, 'Наличие алгоритмов действий медицинских регистраторов регистратуры в различных ситуациях', 1, 60, NULL, NULL),
(1808, 72, 'Эффективное распределение потоков пациентов посредством визуальной маршрутизации по отделениям, кабинетам и службам', 2, 60, NULL, NULL),
(1809, 73, 'Наличие предварительной записи на прием к врачам-специалистам через интернет посредством медицинских информационных систем', 2, 60, NULL, NULL),
(1810, 74, 'Наличие возможности записи на повторный прием в кабинете врача-специалиста', 3, 60, NULL, NULL),
(1811, 75, 'Наличие алгоритма идентификации личности пациентов', 2, 60, NULL, NULL),
(1812, 76, 'Наличие и выполнение в организации здравоохранения ЛПА, регламентирующего порядок проведения диспансеризации населения, адаптированный к условиям работы организации здравоохранения', 1, 60, NULL, NULL),
(1813, 77, 'Выполнение планирования диспансеризации в разрезе общеврачебных участков (с учетом группы диспансерного наблюдения и возраста пациента), составлены персонифицированные списки лиц, подлежащих диспансеризации на текущий год', 1, 60, NULL, NULL),
(1814, 78, 'Организована работа кабинетов для проведения диспансеризации, кабинеты оснащены всем необходимым медицинским оборудованием и изделиями медицинского назначения, персональным компьютером, обеспечен доступ к единому порталу Национального центра электронных услуг', 2, 60, NULL, NULL),
(1815, 79, 'Осуществляется активное приглашение пациентов и проведение диспансеризации медицинскими работниками «команды» врача общей практики (врач общей практики/помощник врача по амбулаторно-поликлинической помощи/медицинская сестра общей практики) в соответствии с порядком, утвержденным Министерством здравоохранения Республики Беларусь', 2, 60, NULL, NULL),
(1816, 80, 'Проводится профилактическое консультирование пациентов по факторам риска хронических неинфекционных заболеваний', 3, 60, NULL, NULL),
(1817, 81, 'Функционирует система обмена информацией о проведении диспансеризации между доврачебным кабинетом (кабинетом диспансеризации), другими структурными подразделениями и отделениями общей врачебной практики', 2, 60, NULL, NULL),
(1818, 82, 'Осуществляется учет результатов диспансеризации населения и контроль полноты проведения мероприятий по диспансеризации, предусмотренных утвержденной схемой', 2, 60, NULL, NULL);
INSERT INTO `mark` (`id_mark`, `str_num`, `mark_name`, `mark_class`, `id_criteria`, `date_close`, `date_open`) VALUES
(1819, 83, 'Организовано проведение работы по выявлению туберкулеза при проведении медицинских осмотров отдельных групп населения: при обязательных медицинских осмотров лиц, занятых на работах с вредными и (или) опасными условиями труда и (или) на работах, где в соответствии с законодательством есть необходимость в профессиональном отборе, а как же выявление туберкулеза среди «угрожаемых» и прочих контингентов', 1, 60, NULL, NULL),
(1820, 84, 'Организовано проведение обследования лиц, контактных с больным туберкулезом', 1, 60, NULL, NULL),
(1821, 85, 'Обеспечено оказание квалифицированной первичной и специализированной медицинской помощи пациентам по профилям заболеваний, состояниям, синдромам на основании клинических протоколов, а также иных нормативных правовых актов, утвержденных Министерством здравоохранения Республики Беларусь или методов оказания медицинской помощи', 2, 60, NULL, NULL),
(1822, 86, 'Проводится динамическое наблюдение за лицами с хроническими заболеваниями:\nопределены категории пациентов с хроническими заболеваниями, требующими постоянного динамического медицинского наблюдения,\nсоставлены персонифицированные списки пациентов, с хроническими заболеваниями, подлежащих медицинскому осмотру в текущем году,\nосуществляется динамические наблюдение пациентов с хроническими заболеваниями медицинскими работниками «команды» врача общей практики (врач общей практики/помощник врача по амбулаторно-поликлинической помощи/медицинская сестра общей практики) в соответствии с клиническими протоколами, а также иными нормативными правовыми актами, утвержденными Министерством здравоохранения Республики Беларусь,\nосуществляется учет результатов медицинского наблюдения пациентов и контроль качества оказания медицинской помощи указанной категории пациентов\n', 2, 60, NULL, NULL),
(1823, 87, 'Наличие и выполнение в организации здравоохранения ЛПА, регламентирующего порядок по проведению обязательных и внеочередных медицинских осмотров работающих, регламентирующего порядок проведения обязательных и (или) внеочередных медицинских осмотров работающих, адаптированный к условиям работы организации здравоохранения', 3, 60, NULL, NULL),
(1824, 88, 'Создана и функционирует медицинская комиссия для проведения обязательных и (или) внеочередных медицинских осмотров работающих, персональный состав комиссии, порядок и график ее работы утвержден руководителем организации здравоохранения', 3, 60, NULL, NULL),
(1825, 89, 'Обеспечено выполнение лабораторных, инструментальных и иные исследований, а также медицинских осмотров врачами-специалистами в соответствии с Инструкцией о порядке проведения обязательных и (или) внеочередных медицинских осмотров работающих, утвержденной Министерством здравоохранения Республики Беларусь', 2, 60, NULL, NULL),
(1826, 90, 'В организации здравоохранения разработаны правила доставки образцов биологического материала для каждого вида клинических лабораторных исследований с регламентацией условий транспортировки биологических образцов к месту проведения аналитического этапа исследования', 3, 60, NULL, NULL),
(1827, 91, 'В организации здравоохранения для забора венозной крови используются одноразовые стандартные системы: система шприц-пробирка, обеспечивающая как поршневой способ забора крови, так и вакуумный, вакуумные системы, обеспечивающие забор крови вакуумным методом со строгим соблюдением требований производителя компонентов систем', 1, 60, NULL, NULL),
(1828, 92, 'В организации здравоохранения соблюдается последовательность заполнения вакуумных систем: кровь без антикоагулянтов или с прокоагулянтами\nкровь с цитратом\nкровь с гепарином\nкровь с ЭДТА\n', 2, 60, NULL, NULL),
(1829, 93, 'Транспортировка биологических проб осуществляется в специально предназначенных для этого и промаркированных контейнерах', 2, 60, NULL, NULL),
(1830, 94, 'Порядок транспортировки биологического материала в лабораторию в обязательном порядке предусматривает:', 2, 60, NULL, NULL),
(1831, 95, 'Порядок транспортировки биологического материала в лабораторию в обязательном порядке предусматривает:\nв каждой организации здравоохранения должен быть определен медицинский работник, ответственный за транспортировку образцов биологического материала в лабораторию, в обязанности которого входит:\nосуществление контроля за подготовленным к транспортировке биологическим материалом, соответствием количества заявок на лабораторные исследования количеству отобранных проб биологического материала,\nоформление Акта приема образцов биологического материала для лабораторных исследований,\nконтроль за температурным режимом в контейнерах не реже 1 раза в 5 дней,\nведение Журнала контроля температурного режима контейнеров,\nдоставка материала в лабораторию осуществляется в максимально короткий промежуток времени, при этом нормативы времени доставки биологического материала в лабораторию отражаются в алгоритме доставки биологического материала, разработанного для данной организации здравоохранения,\nконтейнеры должны обеспечивать соответствующие температурные режимы в зависимости от вида лабораторных исследований. В зависимости от требуемой для транспортировки биологического материала температуры они оборудуются хладагентами (для поддержания температуры 2-8 °C) или термоэлементами (для поддержания температуры в диапазоне 37 °C)\n', 2, 60, NULL, NULL),
(1832, 96, 'Проводятся профилактические онкологические осмотры по выявлению предопухолевых и опухолевых заболеваний в соответствии с Инструкцией, утвержденной Министерством здравоохранения Республики Беларусь', 1, 60, NULL, NULL),
(1833, 97, 'Выполняются мероприятия раннего выявления злокачественных новообразований в соответствии с порядками, утвержденными Министерством здравоохранения Республики Беларусь', 1, 60, NULL, NULL),
(1834, 98, 'Осуществляется учет лиц с подозрением на онкологическое заболевание и проведение им углубленного медицинского обследования в установленные сроки', 2, 60, NULL, NULL),
(1835, 99, 'Ведется учет (реестр) пациентов с предопухолевыми заболеваниями и осуществляется динамическое медицинское наблюдение врачами-специалистами (по профилям заболеваний)', 2, 60, NULL, NULL),
(1836, 100, 'Осуществляется динамическое медицинское наблюдение за пациентами со злокачественными новообразованиями III клинической группы, использование в работе данных белорусского канцер-регистра', 2, 60, NULL, NULL),
(1837, 101, 'Обеспечена преемственность с другими организациями здравоохранения в оказании медицинской помощи пациентам с предопухолевой патологией и злокачественными новообразованиями с учетом этапности оказания онкологической помощи', 2, 60, NULL, NULL),
(1838, 102, 'Создана и функционирует экспертная комиссия по раннему выявлению онкологических заболеваний, персональный состав комиссии, порядок ее работы утвержден руководителем организации здравоохранения. Результаты ее работы рассматриваются на врачебных конференциях в организации здравоохранения с принятием организационно-управленческих решений по совершенствованию данного раздела работы', 3, 60, NULL, NULL),
(1839, 103, 'Наличие и выполнение в организации здравоохранения ЛПА, регламентирующего порядок оказания медицинской помощи пациентам в условиях отделения дневного пребывания организации здравоохранения (далее – ОДП), в том числе порядок направления и госпитализации пациентов в ОДП, выписки или перевода пациентов в другие организации здравоохранения для дальнейшего лечения', 3, 60, NULL, NULL),
(1840, 104, 'Оснащение ОДП соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой', 2, 60, NULL, NULL),
(1841, 105, 'Работа ОДП обеспечена в сменном режиме ', 2, 60, NULL, NULL),
(1842, 106, 'В ОДП имеются лекарственные препараты и медицинские изделия для оказания экстренной медицинской помощи в соответствии с требованиями клинических протоколов', 2, 60, NULL, NULL),
(1843, 107, 'Обеспечен в рабочее время доступ врача ОДП к дефибриллятору. Дефибриллятор находится в технически исправном состоянии соблюдается график его зарядки', 2, 60, NULL, NULL),
(1844, 108, 'Обеспечен контроль за соблюдением санитарно-гигиенических требований в ОДП', 2, 60, NULL, NULL),
(1845, 109, 'Пациенты, находящиеся на лечении в отделении дневного пребывания, обеспечиваются лекарственными средствами и изделиями медицинского назначения за счет средств бюджета в соответствии с действующим законодательством Республики Беларусь', 2, 60, NULL, NULL),
(1846, 110, 'Медицинская помощь в условиях ОДП осуществляется по профилям заболеваний, состояниям, синдромам на основании клинических протоколов, а также иных нормативных правовых актов, утвержденных Министерством здравоохранения Республики Беларусь или методов оказания медицинской помощи', 2, 60, NULL, NULL),
(1847, 111, 'В организации здравоохранения медицинская реабилитация, медицинская абилитация осуществляется в соответствии с\nпорядком организации и проведения медицинской реабилитации, медицинской абилитации пациента (при обслуживании взрослого населения),\nпорядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет (при обслуживании детского населения),\nклиническими протоколами по профилям заболеваний, состояниям, синдромам,\nметодами оказания медицинской помощи, соответствующими профилю оказываемой медицинской помощи,\nлокальными нормативными актами, регламентирующими проведение медицинской реабилитации в организации здравоохранения.\nКритерий применяется для организаций здравоохранения, в штатном расписании которых отсутствует должность врача-реабилитолога\n', 1, 60, NULL, NULL),
(1848, 112, 'Оформление медицинских документов осуществляется по установленным формам, в соответствии с требованиями нормативных правовых актов Министерства здравоохранения Республики Беларусь', 1, 60, NULL, NULL),
(1849, 113, 'Медицинские осмотры пациентов проводятся в соответствии с Инструкцией о порядке проведения медицинских осмотров с оформлением записи в медицинских документах', 1, 60, NULL, NULL),
(1850, 114, 'Имеется согласие или отказ пациента или лиц, указанных в части второй статьи 18 Закона Республики Беларусь «О здравоохранении», на проведение простых и (или) сложных медицинских вмешательств, оформленный в соответствии с нормативными правовыми актами Республики Беларусь', 2, 60, NULL, NULL),
(1851, 115, 'Врачебные консультации (консилиумы) и их решения оформляются в соответствии с требованиями Инструкции о порядке проведения врачебных консультаций (консилиумов), утвержденной Министерством здравоохранения Республики Беларусь', 2, 60, NULL, NULL),
(1852, 116, 'Оформляется выписной эпикриз с отражением информации о проведенном лечении, его результатах и рекомендаций по дальнейшему наблюдению пациента при завершении курса лечения в ОДП', 2, 60, NULL, NULL),
(1853, 117, 'Осуществляется документооборот с другими организациями здравоохранения в целях обеспечения преемственности в оказании медицинской помощи населению:\nоформление направлений на стационарное лечение, консультации врачей-специалистов, справок о состоянии здоровья и выписок из медицинских документов в другие организации здравоохранения,\nпредоставление эпикризов стационарного лечения и заключений врачебных консультаций, справок о состоянии здоровья и выписок из медицинских документов из других организаций здравоохранения\n', 2, 60, NULL, NULL),
(1854, 118, 'Профилактические прививки выполнены в соответствии с Национальным календарем профилактических прививок согласно приложению 1 к постановлению Министерства здравоохранения Республики Беларусь от 17 мая 2018 г. № 42 «О профилактических прививках» и (или) по эпидемиологическим показаниям', 1, 60, NULL, NULL),
(1855, 119, 'Профилактические прививки выполнены с учетом медицинских показаний и противопоказаний к их проведению, в соответствии с инструкцией по медицинскому применению, прилагаемой к иммунобиологическому лекарственному препарату', 2, 60, NULL, NULL),
(1856, 120, 'Наличие устного согласия на проведение профилактической прививки или в установленном порядке оформленного отказа от проведения профилактической прививки', 2, 60, NULL, NULL),
(1857, 121, 'Осуществление медицинского осмотра врачом общей практики (врачом-специалистом, врачом-терапевтом, врачом-педиатром) перед проведением профилактической прививки', 2, 60, NULL, NULL),
(1858, 122, 'Осуществление медицинским работником, проводившим профилактическую прививку, медицинского наблюдения за пациентом в течение 30 минут после введения иммунобиологического лекарственного препарата', 2, 60, NULL, NULL),
(1859, 123, 'Выявление, регистрация и расследование случаев серьезных побочных реакций на профилактические прививки, направление внеочередной информации о серьезной побочной реакции после прививки', 1, 60, NULL, NULL),
(1860, 124, 'Устройство, оборудование и оснащение прививочных кабинетов соответствует санитарно-эпидемиологическим требованиям', 3, 60, NULL, NULL),
(1861, 125, 'Транспортировка, хранение и уничтожение иммунобиологических лекарственных средств, а также хранение и использование хладоэлементов соответствует санитарно-эпидемиологическим требованиям', 2, 60, NULL, NULL),
(1862, 126, 'Наличие и выполнение в организации здравоохранения ЛПА, регламентирующего порядок организации оказания экстренной и неотложной медицинской помощи пациентам. Утверждены алгоритмы оказания экстренной медицинской и неотложной помощи, в том числе комплекса мероприятий сердечно-легочной реанимации, соответствующие условиям оказания медицинской помощи в структурных подразделениях учреждения здравоохранения', 1, 60, NULL, NULL),
(1863, 127, 'Наличие и выполнение в организации здравоохранения ЛПА, определяющего перечень лиц, осуществляющих контроль за наличием необходимых лекарственных препаратов, изделий медицинского назначения для оказания экстренной медицинской помощи, своевременное их пополнение и соблюдение сроков годности. В структурном подразделении определены лица, осуществляющие контроль за наличием необходимых лекарственных препаратов, медицинских изделий для оказания экстренной медицинской помощи, своевременное их пополнение и соблюдение сроков годности', 2, 60, NULL, NULL),
(1864, 128, 'Наличие лекарственных препаратов, медицинских изделий, медицинской техники, компонентов и препаратов крови для оказания экстренной и неотложной медицинской помощи в соответствии с требованиями клинических протоколов', 1, 60, NULL, NULL),
(1865, 129, 'Наличие и обеспечение хранения лекарственных препаратов, иммунобиологических лекарственных средств, изделий медицинского назначения, медицинской техники, компонентов и препаратов крови для оказания неотложной медицинской помощи в соответствии с требованиями нормативных правовых актов', 2, 60, NULL, NULL),
(1866, 130, 'Организовано проведение занятий с медицинскими работниками по освоению теоретических и практических навыков оказания экстренной медицинской помощи с последующим контролем знаний с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев', 1, 60, NULL, NULL),
(1867, 131, 'Наличие и выполнение в организации здравоохранения ЛПА, регламентирующего порядок по проведению экспертизы временной нетрудоспособности (далее – экспертизы ВН) в организации здравоохранения, в том числе определяющего получение, хранение, учет, списание и уничтожение бланков листков нетрудоспособности, справок о временной нетрудоспособности в соответствии с требованиями нормативных документов', 2, 60, NULL, NULL),
(1868, 132, 'Бухгалтерский учет и использование бланков строгой отчетности (листков нетрудоспособности) осуществляется в соответствии с Инструкцией о порядке использования и бухгалтерского учета бланков строгой отчетности', 1, 60, NULL, NULL),
(1869, 133, 'Организована работа врачебно-консультационных комиссий в соответствии с требованиями законодательства Республики Беларусь', 2, 60, NULL, NULL),
(1870, 134, 'Проводятся инструктажи по вопросам проведения экспертизы ВН и контроль знаний', 2, 60, NULL, NULL),
(1871, 135, 'Проводится анализ статистических показателей заболеваемости с временной нетрудоспособностью с выявлением причин их отклонения', 1, 60, NULL, NULL),
(1872, 136, 'Осуществляется выдача и оформление листков нетрудоспособности и справок о временной нетрудоспособности в соответствии с требованиями Инструкции о порядке выдачи и оформления листков нетрудоспособности и справок о временной нетрудоспособности', 1, 60, NULL, NULL),
(1873, 137, 'Осуществляется направление пациентов на медико-социальную экспертизу (далее – МСЭ) в соответствии с требованиями постановления Министерства здравоохранения Республики Беларусь от 9 июня 2021 г. № 77', 1, 60, NULL, NULL),
(1874, 138, 'Проводится обследование пациентов при направлении на МСЭ в соответствии с приказом Министерства здравоохранения Республики Беларусь от 11 января 2022 г. № 11', 1, 60, NULL, NULL),
(1875, 139, 'Наличие и выполнение в организации здравоохранения ЛПА, регламентирующего порядок организации и деятельности медицинской водительской комиссии в соответствии с требованиями законодательства ', 3, 60, NULL, NULL),
(1876, 140, 'Наличие и выполнение в организации здравоохранения ЛПА, регламентирующего порядок организации и проведения экспертизы качества медицинской помощи (далее – экспертиза качества), оценки качества медицинской помощи и медицинских экспертиз (далее – оценка качества) в соответствии с требованиями законодательства. Определены лица, ответственные за организацию и проведение экспертизы качества, оценки качества', 3, 60, NULL, NULL),
(1877, 141, 'Оценка качества проводится в соответствии с планом, утвержденным руководителем организации здравоохранения.', 1, 60, NULL, NULL),
(1878, 142, 'По результатам экспертизы качества и (или) оценки качества оформляется заключение', 1, 60, NULL, NULL),
(1879, 143, 'Результаты экспертизы качества, оценки качества рассматриваются на врачебно-консультационных комиссиях, клинических конференциях, принимаются меры по устранению причин и условий, повлекших снижение качества медицинской помощи, медицинских экспертиз', 2, 60, NULL, NULL),
(1880, 144, 'Обеспечено устранение в срок рекомендаций по устранению нарушений, предписаний об устранении нарушений, выданных территориальными центрами гигиены и эпидемиологии', 1, 60, NULL, NULL),
(1881, 145, 'Обеспечены условия для разделения потоков пациентов, имеющих и не имеющих признаки острых инфекционных заболеваний согласно законодательству в области санитарно-эпидемиологических требований', 2, 60, NULL, NULL),
(1882, 146, 'Осуществляется выполнение разработанной и утвержденной руководителем организации здравоохранения программы производственного контроля. Сроки и кратность проведения лабораторного производственного контроля соблюдаются согласно установленным в программе производственного контроля на протяжении 3-х последних лет', 2, 60, NULL, NULL),
(1883, 147, 'В организации здравоохранения оборудована и функционирует система приточно-вытяжной вентиляции. Профилактический ремонт, обслуживание и ремонт системы вентиляции проводится не реже одного раза в 3 года', 2, 60, NULL, NULL),
(1884, 148, 'Имеется функционирующая система проточного холодного и горячего водоснабжения, система водоотведения (канализации). Умывальники в помещениях, к которым предъявляется данное требование, оснащены кранами с локтевым (бесконтактным, педальным и прочим не кистевым) управлением. В помещениях, к которым предъявляется данное требование, имеется резервное горячее водоснабжение, в том числе обеспечена его работоспособность', 2, 60, NULL, NULL),
(1885, 149, 'Отопление организации здравоохранения осуществляется централизованно или с помощью локальных (автономных) систем. В зимнее время система отопления обеспечивает нормируемые показатели температуры воздуха в помещении', 2, 60, NULL, NULL),
(1886, 150, 'Установлены и находятся в функционирующем состоянии медицинские изделия для очистки воздуха в помещениях, к которым предъявляется данное требование', 2, 60, NULL, NULL),
(1887, 151, 'Внутренняя отделка помещений, в том числе поверхности дверей, окон и нагревательных приборов, выполнена в соответствии с функциональным назначением помещений и устойчива к моющим и дезинфицирующим средствам', 2, 60, NULL, NULL),
(1888, 152, 'Отсутствует в использовании мебель с дефектами покрытия и (или) неисправная мебель, неисправные санитарно-технические изделия и оборудование, медицинские изделия', 2, 60, NULL, NULL),
(1889, 153, 'Дезинфекция, стерилизация проводятся в соответствии с законодательством актами Республики Беларусь. Стерилизация осуществляется в централизованном стерилизационном отделении и (или) в стерилизационной. Отсутствуют места организации стерилизации в лечебных кабинетах (манипуляционных, перевязочных, кабинетах приема врачей-специалистов или в других приспособленных местах). Отсутствуют в использовании простерилизованные медицинские изделия с истекшим сроком стерильности либо хранившиеся с нарушением условий сохранения стерильности', 2, 60, NULL, NULL),
(1890, 154, 'В наличии имеется достаточное количество средств индивидуальной защиты, антисептиков и дезинфектантов', 1, 60, NULL, NULL),
(1891, 155, 'Утвержден и внедрен порядок действий работников при аварийном контакте с биологическим материалом пациента, загрязнении биологическим материалом объектов внешней среды', 2, 60, NULL, NULL),
(1892, 156, 'Информация о выявленных инфекционных заболеваниях своевременно предоставляется в территориальные центры гигиены и эпидемиологии', 3, 60, NULL, NULL),
(1893, 157, 'Осуществляется регистрация всех выявленных инфекций, связанных с оказанием медицинской помощи, с проведением анализа и принятием управленческих решений', 2, 60, NULL, NULL),
(1894, 158, 'Отработанные медицинские изделия подвергаются дезинфекции химическим или физическим методом', 1, 60, NULL, NULL),
(1895, 159, 'Организован сбор, обеззараживание, транспортировка, хранение и утилизация отходов производства и потребления (путем переработки, сжигания или захоронения) в соответствии с требованиями законодательства Республики Беларусь', 2, 60, NULL, NULL),
(1896, 160, 'Для упорядоченного временного хранения медицинских отходов созданы условия, исключающие прямой контакт с медицинскими отходами пациентов и работников (специально выделенное место, помещение, шкаф или другое)', 2, 60, NULL, NULL),
(1897, 161, 'Стирка белья, санитарной одежды, полотенец, салфеток осуществляется в прачечной, прачечной общего типа и (или) мини-прачечных в отделении организации. Белье и постельные принадлежности (матрасы, подушки, одеяла) подвергаются дезинфекции в случаях, предусмотренных законодательством', 2, 60, NULL, NULL),
(1898, 162, 'Обеспечено раздельное хранение личной и санитарной одежды в изолированных секциях шкафов. Не допускается стирка санитарной одежды в домашних условиях', 2, 60, NULL, NULL),
(1899, 163, 'Территория и помещения организации здравоохранения содержатся в чистоте, соблюдается утвержденный порядок уборок', 2, 60, NULL, NULL),
(1900, 164, 'Техническое обслуживание, текущий и капитальный ремонты зданий и помещений организаций, инженерных систем (в том числе отопления, горячего и холодного водоснабжения, водоотведения (канализации), вентиляции, санитарно-технического оборудования) проводится в зависимости от их санитарно-технического состояния и в сроки, установленные планом мероприятий, разработанным и утвержденным руководителем организации', 2, 60, NULL, NULL),
(1901, 165, 'Работники, подлежащие обязательным медицинским осмотрам, проходят их в порядке, предусмотренным законодательством', 2, 60, NULL, NULL),
(1902, 166, 'Минимальный состав и площади отдельных помещений соответствуют приложению 1 к санитарным нормам и правилам «Санитарно-эпидемиологические требования к организациям, оказывающим медицинскую помощь, в том числе к организации и проведению санитарно-противоэпидемических мероприятий по профилактике инфекционных заболеваний в этих организациях», утвержденных постановлением Министерства здравоохранения Республики Беларусь от 5 июля 2017 г. № 73', 2, 60, NULL, NULL),
(1903, 167, 'Дезинфекция высокого уровня и (или) стерилизация эндоскопического оборудования осуществляется механизированным способом. Организация здравоохранения оснащена достаточным количеством моечно-дезинфекционных машин и шкафов для асептического хранения эндоскопического оборудования\n*Указанный критерий применяется только в отношении тех организаций, где проводятся эндоскопические вмешательства на нестерильных полостях организма.\n', 2, 60, NULL, NULL),
(1992, 1, 'Деятельность организации здравоохранения осуществляется в соответствии с Уставом (Положением об обособленном структурном подразделении)', 3, 61, NULL, NULL),
(1993, 2, 'Деятельность структурных подразделений осуществляется в соответствии с утвержденным положением о структурном подразделении, имеется ознакомление работников с положениями о структурных подразделениях', 2, 61, NULL, NULL),
(1994, 3, 'Наличие документов в соответствии с номенклатурой дел и выполнение утвержденных руководителем организации документов и локальных правовых актов (далее – ЛПА):\nкомплексный план основных организационных мероприятий,\nо режиме работы организации здравоохранения, структурных подразделений,\nЛПА о распределении обязанностей между заместителями руководителя,\nо трудовой и исполнительской дисциплине,\nправила внутреннего трудового распорядка', 2, 61, NULL, NULL),
(1995, 4, 'Наличие и выполнение требований системы управления охраной труда, обеспечивающей идентификацию опасностей, оценку профессиональных рисков, определение мер управления профессиональными рисками и анализ их результативности. Проводятся первичный, повторный, целевые (при необходимости) инструктажи с сотрудниками структурных подразделений. Разрабатываются инструкции по охране труда для профессий рабочих и (или) отдельных видов работ. Осуществляется контроль за соблюдением требований по охране труда', 2, 61, NULL, NULL),
(1996, 5, 'Наличие и выполнение общеобъектовой инструкции по пожарной безопасности. Определены лица, ответственные за пожарную безопасность, проводится обучение по пожарной безопасности', 2, 61, NULL, NULL),
(1997, 6, 'Выполнение плановых показателей деятельности и проведение их анализа с принятием организационно-управленческих решений. Выполнение управленческих решений по улучшению качества медицинской помощи за последний отчетный период или год', 1, 61, NULL, NULL),
(1998, 7, 'Наличие и выполнение в организации здравоохранения ЛПА, регламентирующего порядок по организации и проведении клинических конференций. Проведение в организации здравоохранения клинических конференций, оформление протоколов проведения клинических конференций', 2, 61, NULL, NULL),
(1999, 8, 'Наличие на рабочих местах врачей-специалистов клинических протоколов, соответствующих профилю оказываемой медицинской помощи, либо обеспечен постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативных правовых актов по организации медицинской помощи', 3, 61, NULL, NULL),
(2000, 9, 'Проводится планирование и осуществление мероприятий по обеспечению радиационной безопасности в соответствии с законодательством. Имеется лицензия на данный вид деятельности', 1, 61, NULL, NULL),
(2001, 10, 'Организована выписка рецептов врача в соответствии с Инструкцией о порядке выписывания рецепта врача и создания электронных рецептов врача, утвержденной постановлением Министерства здравоохранения Республики Беларусь от 31 октября 2007 г. № 99:\nналичие бланков рецептов врача для выписки лекарственных препаратов, реализуемых в аптеке за полную стоимость, на льготных условиях, в том числе бесплатно, использование иных (компьютерных) способов выписывания рецептов,\nналичие и учет бланков рецептов врача для выписки наркотических средств,\nналичие и учет бланков рецептов врача для выписки психотропных веществ и лекарственных препаратов, обладающих анаболической активностью', 1, 61, NULL, NULL),
(2002, 11, 'Наличие на информационных стендах в организации здравоохранения информации:\nо режиме работы организации здравоохранения и структурных подразделений,\nо правилах внутреннего распорядка для пациентов,\nо порядке оказания медицинской помощи гражданам Республики Беларусь, в том числе льготным категориям граждан,\nо лицах, имеющих право на внеочередное, первоочередное оказание медицинской помощи,\nо порядке оказания медицинской помощи иностранным гражданам и лицам без гражданства,\nо приеме граждан по личным вопросам руководством организации здравоохранения и вышестоящим руководством', 1, 61, NULL, NULL),
(2003, 12, 'Официальный интернет-сайт организации здравоохранения функционирует в порядке, установленном законодательством', 2, 61, NULL, NULL),
(2004, 13, 'Организована работа по защите персональных данных. Имеется политика организации в отношении обработки персональных данных, ЛПА о назначении лица или структурного подразделения, ответственного за осуществление внутреннего контроля за обработкой персональных данных, информированное согласие пациента на обработку персональных данных', 2, 61, NULL, NULL),
(2005, 14, 'Организована работа комиссии по вопросам медицинской этики и деонтологии организации здравоохранения', 2, 61, NULL, NULL),
(2006, 15, 'В организации здравоохранения соблюдаются права ребенка на получение безопасной и эффективной медицинской помощи, имеются условия для организации среды, дружественной детям (наличие и правильная организация мест для кормления, пеленальных столов, красочное оформление стен холлов, коридоров и др.)', 3, 61, NULL, NULL),
(2007, 16, 'Работа по противодействию коррупции в организации здравоохранения осуществляется в соответствии с законодательством', 2, 61, NULL, NULL),
(2008, 17, 'Работа по осуществлению административных процедур организована в соответствии с законодательством ', 2, 61, NULL, NULL),
(2009, 18, 'Работа по обращениям граждан и юридических лиц организована в соответствии с законодательством', 2, 61, NULL, NULL),
(2010, 19, 'Наличие в организации здравоохранения ЛПА по обеспечению доступности медицинской помощи', 3, 61, NULL, NULL),
(2011, 20, 'Расчет планового количества посещений в учреждениях здравоохранения соответствует методике, утвержденной Министерством здравоохранения Республики Беларусь', 2, 61, NULL, NULL),
(2012, 21, 'Наличие информации о деятельности организации здравоохранения, размещенной на информационных стендах и на официальном интернет-сайте организации здравоохранения', 2, 61, NULL, NULL),
(2013, 22, 'Использованные при расчете плана посещений нормы нагрузки (обслуживания) на приеме врача и вне организации здравоохранения соответствуют утвержденным нормативам', 2, 61, NULL, NULL),
(2014, 23, 'График работы врачей-специалистов обеспечивает доступность медицинской помощи по профилю заболевания', 1, 61, NULL, NULL),
(2015, 24, 'Наличие и функционирование на официальном интернет-сайте организации здравоохранения: дистанционных способов взаимодействия с получателями медицинских услуг (электронных сервисов «Часто задаваемые вопросы», раздел «Вопрос-Ответ»)', 2, 61, NULL, NULL),
(2016, 25, 'Наличие на официальном интернет-сайте и визуальном доступе в организации здравоохранения информации о порядке проведения диспансеризации детского населения', 1, 61, NULL, NULL),
(2017, 26, 'Имеется и функционирует в организации здравоохранения система «Электронная очередь»', 2, 61, NULL, NULL),
(2018, 27, 'Обеспечена доступность записи на прием к врачу-специалисту через «Информационный киоск», по телефону, на официальном сайте или при обращении пациента в организацию здравоохранения', 3, 61, NULL, NULL),
(2019, 28, 'Обеспечена доступность получения консультации врача-педиатра участкового в день обращения в организацию здравоохранения', 1, 61, NULL, NULL),
(2020, 27, 'Обеспечена доступность выполнения лабораторных исследований при наличии у пациента направления на их проведение', 1, 61, NULL, NULL),
(2021, 30, 'Соблюдается установленный в организации здравоохранения порядок направления на плановые и срочные диагностические исследования', 2, 61, NULL, NULL),
(2022, 31, 'Обеспечен сменный режим работы врачей-специалистов, диагностических подразделений', 1, 61, NULL, NULL),
(2023, 32, 'Наличие в организации здравоохранения условий, позволяющих лицам с ограниченными возможностями получать медицинские услуги наравне с другими пациентами, включая: \nналичие и доступность санитарно-гигиенических помещений,\nдублирование надписей, знаков и иной текстовой и графической информации знаками, выполненными рельефно-точечным шрифтом Брайля,\nналичие алгоритмов сопровождения лиц с ограниченными возможностями работниками организации здравоохранения', 2, 61, NULL, NULL),
(2024, 33, 'Территория, прилегающая к организации здравоохранения, и ее помещения оборудованы с учетом доступности для лиц с ограниченными возможностями:\nоборудование входных групп пандусами (подъемными платформами),\nналичие выделенных стоянок для автотранспортных средств лиц с ограниченными возможностями, наличие поручней, расширенных проемов,\nналичие кресел-колясок', 3, 61, NULL, NULL),
(2025, 34, 'Наличие в организации здравоохранения места для хранения детских колясок', 3, 61, NULL, NULL),
(2026, 35, 'Штатная численность должностей служащих (профессий рабочих) утверждена руководителем организации здравоохранения с учетом норм нагрузок труда работников, установленных в организации здравоохранения, и является достаточной для оказания планируемых объемов медицинской помощи', 2, 61, NULL, NULL),
(2027, 36, 'Штатное расписание составляется и пересматривается ежегодно, на основании анализа кадрового потенциала организации здравоохранения, фактического объема оказываемой медицинской помощи', 3, 61, NULL, NULL),
(2028, 37, 'В организации здравоохранения исполняются требования к занятию должностей служащих медицинских, фармацевтических работников, установленные Министерством здравоохранения Республики Беларусь', 2, 61, NULL, NULL),
(2029, 38, 'На каждую должность медицинского работника руководителем организации здравоохранения утверждена должностная инструкция с указанием квалификационных требований, функций по должности, прав и обязанностей медицинских работников', 1, 61, NULL, NULL),
(2030, 39, 'В организации здравоохранения проводится работа по обучению/повышению квалификации персонала (определяется потребность персонала в обучении/повышении квалификации, осуществляется планирование и контроль его прохождения)', 2, 61, NULL, NULL),
(2031, 40, 'Укомплектованность организации здравоохранения врачами-специалистами не менее 75 % по физическим лицам', 1, 61, NULL, NULL),
(2032, 41, 'Укомплектованность организации здравоохранения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам', 1, 61, NULL, NULL),
(2033, 42, 'Обеспечение кадровой потребности в специалистах с высшим медицинским, фармацевтическим образованием (укомплектованность) по занятым должностям служащих не менее 96 %', 1, 61, NULL, NULL),
(2034, 43, 'Обеспечение кадровой потребности в специалистах со средним медицинским, фармацевтическим образованием (укомплектованность) по занятым должностям служащих не менее 96 %', 1, 61, NULL, NULL),
(2035, 44, 'Закрепление молодых специалистов на рабочих местах после завершения срока работы по распределению (направлению на работу) не менее 90 %', 2, 61, NULL, NULL),
(2036, 45, 'Наличие квалификационных категорий у специалистов с высшим медицинским, фармацевтическим образованием 100 % от лиц, подлежащих профессиональной аттестации', 2, 61, NULL, NULL),
(2037, 46, 'Наличие квалификационных категорий у специалистов со средним медицинским, фармацевтическим образованием 100 % от лиц, подлежащих профессиональной аттестации', 2, 61, NULL, NULL),
(2038, 47, 'Коэффициент совместительства медицинских работников с высшим медицинским, фармацевтическим образованием не более 1,25 ', 2, 61, NULL, NULL),
(2039, 48, 'Коэффициент совместительства медицинских работников со средним медицинским, фармацевтическим образованием не более 1,25', 2, 61, NULL, NULL),
(2040, 49, 'Текучесть медицинских кадров с высшим медицинским, фармацевтическим образованием не более 7 %', 3, 61, NULL, NULL),
(2041, 50, 'Текучесть медицинских кадров со средним медицинским, фармацевтическим образованием не более 7 %', 3, 61, NULL, NULL),
(2042, 51, 'В организации здравоохранения проводится работа по формированию, хранению личных дел персонала', 1, 61, NULL, NULL),
(2043, 52, 'В организации здравоохранения проводится инструктаж/ознакомление каждого поступающего работника со следующими документами:\nколлективный договор,\nправила внутреннего трудового распорядка,\nдолжностная инструкция,\nохрана труда (вводный инструктаж),\nпожарная безопасность (вводный инструктаж),\nДиректива Президента Республики Беларусь от 11 марта 2004 г. № 1 «О мерах по укреплению общественной безопасности и дисциплины»,\nДекрет Президента Республики Беларусь от 15 декабря 2014 г. № 5 «Об усилении требований к руководящим кадрам и работникам организаций»,\nЗакон Республики Беларусь от 15 июля 2015 г. № 305 -З «О борьбе с коррупцией»', 1, 61, NULL, NULL),
(2044, 53, 'Организована работа по проведению анкетирования работников организации здравоохранения (с частотой, определяемой руководителем организации здравоохранения) с целью изучения социальных вопросов, в том числе психологического климата в организации здравоохранения, справедливости материального стимулирования', 2, 61, NULL, NULL),
(2045, 54, 'В организации здравоохранения определены лица, ответственные за техническое обслуживание и ремонт медицинской техники', 1, 61, NULL, NULL),
(2046, 55, 'В организации здравоохранения обеспечено ведение учета медицинской техники', 1, 61, NULL, NULL),
(2047, 56, 'Материально-техническая база организации здравоохранения соответствует табелю, утвержденному руководителем на основании примерного табеля оснащения, утвержденного приказом Министерства здравоохранения Республики Беларусь 16.11.2018 №1180', 2, 61, NULL, NULL),
(2048, 57, 'Наличие своевременной государственной поверки средств измерений', 2, 61, NULL, NULL),
(2049, 58, 'Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и (или) ремонтом. Техническое обслуживание и (или) ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на выполнение данных услуг', 1, 61, NULL, NULL),
(2050, 59, 'Проводится и документируется обучение медицинских работников правилам эксплуатации медицинской техники при вводе в эксплуатацию', 2, 61, NULL, NULL),
(2051, 60, 'Обеспечена эффективность использования медицинской техники, отсутствуют случаи необоснованного простоя', 1, 61, NULL, NULL),
(2052, 61, 'Обеспечена информатизация организации здравоохранения:\nобеспечение информатизации рабочих мест (наличие персонального компьютера, электронной цифровой подписи),\nобеспечение медицинской информационной системой,\nвнедрение системы межведомственного документооборота,\nведение электронной медицинской карты пациента ', 2, 61, NULL, NULL),
(2053, 62, 'Регистратура оснащена персональными компьютерами, рабочие места медицинских регистраторов автоматизированы', 2, 61, NULL, NULL),
(2054, 63, 'Наличие элементов «заботливой поликлиники» (организация call-центра, визуальное оформление регистратуры по типу «открытая регистратура», аппаратно-программные комплексы: электронная регистратура, электронная очередь, демонстрационная панель, зоны комфортного ожидания в холлах и др.)', 3, 61, NULL, NULL),
(2055, 64, 'Наличие алгоритмов действий медицинских регистраторов регистратуры в различных ситуациях', 1, 61, NULL, NULL),
(2056, 65, 'Эффективное распределение потоков пациентов посредством визуальной маршрутизации по отделениям, кабинетам и службам', 2, 61, NULL, NULL),
(2057, 66, 'Наличие предварительной записи на прием к врачам-специалистам через интернет посредством медицинских информационных систем', 2, 61, NULL, NULL),
(2058, 67, 'Наличие возможности записи на повторный прием в кабинете врача-специалиста', 3, 61, NULL, NULL),
(2059, 68, 'Наличие алгоритма идентификации личности детей', 3, 61, NULL, NULL),
(2060, 69, 'Наличие в организации здравоохранения ЛПА по проведению диспансеризации детского населения, регламентирующего порядок проведения диспансеризации, адаптированный к условиям работы организации здравоохранения', 3, 61, NULL, NULL),
(2061, 70, 'Выполнено планирование диспансеризации в разрезе педиатрических участков (с учетом группы диспансерного наблюдения и возраста пациента), составлены персонифицированные списки лиц, подлежащих диспансеризации на текущий год', 1, 61, NULL, NULL),
(2062, 71, 'Осуществляется учет результатов диспансеризации детского населения и контроль полноты проведения мероприятий по диспансеризации, предусмотренных утвержденной схемой', 1, 61, NULL, NULL),
(2063, 72, 'Обеспечено оказание квалифицированной первичной и специализированной медицинской помощи пациентам по профилям заболеваний, состояниям, синдромам на основании клинических протоколов, а также иных нормативных правовых актов, утвержденных Министерством здравоохранения Республики Беларусь или методов оказания медицинской помощи', 1, 61, NULL, NULL),
(2064, 73, 'Выполнен норматив обеспеченности участковыми врачами-педиатрами в соответствии с государственными минимальными социальными стандартами в области здравоохранения', 1, 61, NULL, NULL),
(2065, 74, 'В организации здравоохранения разработаны правила доставки образцов биологического материала для каждого вида клинических лабораторных исследований с регламентацией условий транспортировки биологических образцов к месту проведения аналитического этапа исследования', 3, 61, NULL, NULL),
(2066, 75, 'В организации здравоохранения для забора венозной крови используются одноразовые стандартные системы: система шприц-пробирка, обеспечивающая как поршневой способ забора крови, так и вакуумный, вакуумные системы, обеспечивающие забор крови вакуумным методом со строгим соблюдением требований производителя компонентов систем', 1, 61, NULL, NULL),
(2067, 76, 'В организации здравоохранения соблюдается последовательность заполнения вакуумных систем: кровь без антикоагулянтов или с прокоагулянтами\nкровь с цитратом\nкровь с гепарином\nкровь с ЭДТА', 2, 61, NULL, NULL),
(2068, 77, 'Транспортировка биологических проб осуществляется в специально предназначенных для этого и промаркированных контейнерах', 2, 61, NULL, NULL),
(2069, 78, 'Порядок транспортировки биологического материала в лабораторию в обязательном порядке предусматривает:\nв каждой организации здравоохранения должен быть определен медицинский работник, ответственный за транспортировку образцов биологического материала в лабораторию, в обязанности которого входит:\nосуществление контроля за подготовленным к транспортировке биологическим материалом, соответствием количества заявок на лабораторные исследования количеству отобранных проб биологического материала,\nоформление Акта приема образцов биологического материала для лабораторных исследований,\nконтроль за температурным режимом в контейнерах не реже 1 раза в 5 дней,\nведение Журнала контроля температурного режима контейнеров,\nдоставка материала в лабораторию осуществляется в максимально короткий промежуток времени, при этом нормативы времени доставки биологического материала в лабораторию отражаются в алгоритме доставки биологического материала, разработанного для данной организации здравоохранения,\nконтейнеры должны обеспечивать соответствующие температурные режимы в зависимости от вида лабораторных исследований. В зависимости от требуемой для транспортировки биологического материала температуры они оборудуются хладагентами (для поддержания температуры 2-8 °C) или термоэлементами (для поддержания температуры в диапазоне 37 °C)', 2, 61, NULL, NULL),
(2070, 79, 'Направление на клинико-лабораторное исследование оформляется в электронном виде либо на бумажном носителе с указанием персональных данных в соответствии с нормативными правовыми актами', 2, 61, NULL, NULL),
(2071, 80, 'Заведующий отделением участковой службы координирует обслуживание вызовов и посещение пациентов на дому медицинским работником в соответствии с показаниями для обслуживания вызовов на дому', 1, 61, NULL, NULL),
(2072, 81, 'Организовано проведение патронажа пациентов вне организации здравоохранения медицинской сестрой', 1, 61, NULL, NULL),
(2073, 82, 'Организовано проведение медицинских осмотров пациентов вне организации здравоохранения врачами-специалистами', 1, 61, NULL, NULL),
(2074, 83, 'Проводится динамическое наблюдение за лиц, нуждающиеся в медицинском наблюдении:\nопределены категории пациентов с хроническими заболеваниями, требующими постоянного динамического медицинского наблюдения,\nсоставлены персонифицированные списки пациентов, с хроническими заболеваниями, подлежащих медицинскому осмотру в текущем году,\nосуществляется динамические наблюдение пациентов с хроническими заболеваниями медицинскими работниками в соответствии с клиническими протоколами, а также иными нормативными правовыми актами, утвержденными Министерством здравоохранения Республики Беларусь,\nосуществляется учет результатов медицинского наблюдения пациентов и контроль качества оказания медицинской помощи указанной категории пациентов', 1, 61, NULL, NULL),
(2075, 84, 'Организована работа специализированных тематических школ (школ здоровья)', 2, 61, NULL, NULL),
(2076, 85, 'Организован самостоятельный прием пациентов медицинской сестрой и (или) медицинской сестрой участковой', 3, 61, NULL, NULL),
(2077, 86, 'Утвержден перечень экстренных лабораторных исследований с установленными минимальными и максимальными сроками их проведения', 3, 61, NULL, NULL),
(2078, 87, 'В организации здравоохранения медицинская реабилитация, медицинская абилитация осуществляется в соответствии с\nпорядком организации и проведения медицинской реабилитации, медицинской абилитации пациента (при обслуживании взрослого населения),\nпорядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет (при обслуживании детского населения),\nклиническими протоколами по профилям заболеваний, состояниям, синдромам,\nметодами оказания медицинской помощи, соответствующими профилю оказываемой медицинской помощи,\nлокальными нормативными актами, регламентирующими проведение медицинской реабилитации в организации здравоохранения.\nКритерий применяется для организаций здравоохранения, в штатном расписании которых отсутствует должность врача-реабилитолога', 1, 61, NULL, NULL),
(2079, 88, 'Оформление медицинских документов осуществляется по установленным формам, в соответствии с требованиями нормативных правовых актов Министерства здравоохранения Республики Беларусь', 1, 61, NULL, NULL),
(2080, 89, 'Медицинские осмотры пациентов проводятся в соответствии с Инструкцией о порядке проведения медицинских осмотров с оформлением записи в медицинских документах', 1, 61, NULL, NULL),
(2081, 90, 'Имеется согласие или отказ пациента или лиц, указанных в части второй статьи 18 Закона Республики Беларусь «О здравоохранении», на проведение простых и (или) сложных медицинских вмешательств, оформленный в соответствии с нормативными правовыми актами Республики Беларусь', 2, 61, NULL, NULL),
(2082, 91, 'Врачебные консультации (консилиумы) и их решения оформляются в соответствии с требованиями Инструкции о порядке проведения врачебных консультаций (консилиумов), утвержденной Министерством здравоохранения Республики Беларусь', 2, 61, NULL, NULL),
(2083, 92, 'Осуществляется документооборот с другими организациями здравоохранения в целях обеспечения преемственности в оказании медицинской помощи населению:\nоформление направлений на стационарное лечение, консультации врачей-специалистов, справок о состоянии здоровья и выписок из медицинских документов в другие организации здравоохранения,\nпредоставление эпикризов стационарного лечения и заключений врачебных консультаций, справок о состоянии здоровья и выписок из медицинских документов из других организаций здравоохранения', 2, 61, NULL, NULL),
(2084, 93, 'Профилактические прививки выполняются в соответствии с Национальным календарем профилактических прививок согласно приложению 1 к постановлению Министерства здравоохранения Республики Беларусь от 17 мая 2018 г. № 42 «О профилактических прививках» и (или) по эпидемиологическим показаниям\nПрофилактические прививки выполняются с учетом медицинских показаний и противопоказаний к их проведению, в соответствии с инструкцией по медицинскому применению, прилагаемой к иммунобиологическому лекарственному препарату', 1, 61, NULL, NULL),
(2085, 94, 'Наличие устного согласия на проведение профилактической прививки или в установленном порядке оформленного отказа от проведения профилактической прививки', 2, 61, NULL, NULL),
(2086, 95, 'Осуществление медицинского осмотра врачом-педиатром (врачом-специалистом, врачом общей практики) перед проведением профилактической прививки', 1, 61, NULL, NULL),
(2087, 96, 'Осуществление медицинским работником, проводившим профилактическую прививку, медицинского наблюдения за пациентом в течение 30 минут после введения иммунобиологического лекарственного препарата', 1, 61, NULL, NULL),
(2088, 97, 'Выявление, регистрация и расследование случаев серьезных побочных реакций на профилактические прививки, направление внеочередной информации о серьезной побочной реакции после прививки', 2, 61, NULL, NULL),
(2089, 98, 'Транспортировка, хранение и уничтожение иммунобиологических лекарственных средств, а также хранение и использование хладоэлементов соответствует санитарно-эпидемиологическим требованиям', 2, 61, NULL, NULL),
(2090, 99, 'Наличие в организации здравоохранения ЛПА, регулирующий порядок организации оказания экстренной медицинской помощи. Утверждены алгоритмы оказания экстренной медицинской помощи', 3, 61, NULL, NULL),
(2091, 100, 'Определены лица, осуществляющие контроль за наличием необходимых лекарственных препаратов, медицинских изделий для оказания экстренной медицинской помощи, своевременное их пополнение и соблюдение сроков годности', 3, 61, NULL, NULL),
(2092, 101, 'Имеются лекарственные препараты и медицинские изделия для оказания экстренной медицинской помощи в соответствии с требованиями клинических протоколов', 2, 61, NULL, NULL);
INSERT INTO `mark` (`id_mark`, `str_num`, `mark_name`, `mark_class`, `id_criteria`, `date_close`, `date_open`) VALUES
(2093, 102, 'Проводятся занятия с медицинскими работниками по освоению теоретических и практических навыков оказания экстренной медицинской помощи с последующим контролем знаний с частотой, определяемой руководителем организации, но не реже одного раза в год', 2, 61, NULL, NULL),
(2094, 103, 'Наличие ЛПА по проведению экспертизы временной нетрудоспособности (далее – экспертизы ВН) в организации здравоохранения, в том числе определяющего получение, хранение, учет, списание и уничтожение бланков листков нетрудоспособности, справок о временной нетрудоспособности в соответствии с требованиями нормативных документов', 2, 61, NULL, NULL),
(2095, 104, 'Бухгалтерский учет и использование бланков строгой отчетности (листков нетрудоспособности) осуществляется в соответствии с Инструкцией о порядке использования и бухгалтерского учета бланков строгой отчетности', 1, 61, NULL, NULL),
(2096, 105, 'Организована работа врачебно-консультационных комиссий в соответствии с требованиями законодательства Республики Беларусь', 2, 61, NULL, NULL),
(2097, 106, 'Проводятся инструктажи по вопросам проведения экспертизы ВН и контроль знаний', 2, 61, NULL, NULL),
(2098, 107, 'Проводится анализ статистических показателей заболеваемости с временной нетрудоспособностью с выявлением причин их отклонения', 1, 61, NULL, NULL),
(2099, 108, 'Осуществляется выдача и оформление листков нетрудоспособности и справок о временной нетрудоспособности в соответствии с требованиями Инструкции о порядке выдачи и оформления листков нетрудоспособности и справок о временной нетрудоспособности', 1, 61, NULL, NULL),
(2100, 109, 'Осуществляется направление пациентов на медико-социальную экспертизу (далее – МСЭ) в соответствии с требованиями постановления Министерства здравоохранения Республики Беларусь от 9 июня 2021 г. № 77', 1, 61, NULL, NULL),
(2101, 110, 'Проводится обследование пациентов при направлении на МСЭ в соответствии с приказом Министерства здравоохранения Республики Беларусь от 11 января 2022 г. № 11', 1, 61, NULL, NULL),
(2102, 111, 'В организации здравоохранения соблюдается порядок организации и проведения экспертизы качества медицинской помощи (далее – экспертиза качества), оценки качества медицинской помощи и медицинских экспертиз (далее – оценка качества)', 3, 61, NULL, NULL),
(2103, 112, 'В организации здравоохранения определены лица, ответственные за организацию и проведение экспертизы качества, оценки качества', 2, 61, NULL, NULL),
(2104, 113, 'Оценка качества в структурных подразделениях проводится в соответствии с планом, утвержденным руководителем организации здравоохранения', 2, 61, NULL, NULL),
(2105, 114, 'По результатам экспертизы качества и (или) оценки качества оформляется заключение', 1, 61, NULL, NULL),
(2106, 115, 'Результаты экспертизы качества, оценки качества рассматриваются на врачебно-контрольных комиссиях, медицинских советах, принимаются меры по устранению причин и условий, повлекших снижение качества медицинской помощи, медицинских экспертиз', 2, 61, NULL, NULL),
(2107, 116, 'Обеспечено устранение в срок рекомендаций по устранению нарушений, предписаний об устранении нарушений, выданных территориальными центрами гигиены и эпидемиологии', 1, 61, NULL, NULL),
(2108, 117, 'Обеспечены условия для разделения потоков пациентов, имеющих и не имеющих признаки острых инфекционных заболеваний согласно законодательству в области санитарно-эпидемиологических требований', 2, 61, NULL, NULL),
(2109, 118, 'Осуществляется выполнение разработанной и утвержденной руководителем организации здравоохранения программы производственного контроля. Сроки и кратность проведения лабораторного производственного контроля соблюдаются согласно установленным в программе производственного контроля на протяжении 3-х последних лет ', 2, 61, NULL, NULL),
(2110, 119, 'В организации оборудована и функционирует система приточно-вытяжной вентиляции. Профилактический ремонт, обслуживание и ремонт системы вентиляции проводится не реже одного раза в 3 года', 2, 61, NULL, NULL),
(2111, 120, 'Имеется функционирующая система проточного холодного и горячего водоснабжения, система водоотведения (канализации). Умывальники в помещениях, к которым предъявляется данное требование, оснащены кранами с локтевым (бесконтактным, педальным и прочим не кистевым) управлением. В помещениях, к которым предъявляется данное требование, имеется резервное горячее водоснабжение, в том числе обеспечена его работоспособность', 2, 61, NULL, NULL),
(2112, 121, 'Отопление организации здравоохранения осуществляется централизованно или с помощью локальных (автономных) систем, Печное отопление не применяется. В зимнее время система отопления обеспечивает нормируемые показатели температуры воздуха в помещении', 2, 61, NULL, NULL),
(2113, 122, 'Установлены и находятся в функционирующем состоянии медицинские изделия для очистки воздуха в помещениях, к которым предъявляется данное требование', 2, 61, NULL, NULL),
(2114, 123, 'Внутренняя отделка помещений, в том числе поверхности дверей, окон и нагревательных приборов, выполнена в соответствии с функциональным назначением помещений и устойчива к моющим и дезинфицирующим средствам.', 2, 61, NULL, NULL),
(2115, 124, 'Отсутствует в использовании мебель с дефектами покрытия и (или) неисправная мебель, неисправные санитарно-технические изделия и оборудование, медицинские изделия', 2, 61, NULL, NULL),
(2116, 125, 'Дезинфекция, стерилизация проводятся в соответствии с законодательством актами Республики Беларусь. Стерилизация осуществляется в централизованном стерилизационном отделении и (или) в стерилизационной. Отсутствуют места организации стерилизации в лечебных кабинетах (манипуляционных, перевязочных, кабинетах приема врачей-специалистов или в других приспособленных местах). Отсутствуют в использовании простерилизованные медицинские изделия с истекшим сроком стерильности либо хранившиеся с нарушением условий сохранения стерильности', 2, 61, NULL, NULL),
(2117, 126, 'В наличии имеется достаточное количество средств индивидуальной защиты, антисептиков и дезинфектантов', 1, 61, NULL, NULL),
(2118, 127, 'Утвержден и внедрен порядок действий работников при аварийном контакте с биологическим материалом пациента, загрязнении биологическим материалом объектов внешней среды', 2, 61, NULL, NULL),
(2119, 128, 'Информация о выявленных инфекционных заболеваниях своевременно предоставляется в территориальные центры гигиены и эпидемиологии', 3, 61, NULL, NULL),
(2120, 129, 'Осуществляется регистрация всех выявленных инфекций, связанных с оказанием медицинской помощи, с проведением анализа и принятием управленческих решений', 2, 61, NULL, NULL),
(2121, 130, 'Отработанные медицинские изделия подвергаются дезинфекции химическим или физическим методом', 1, 61, NULL, NULL),
(2122, 131, 'Организован сбор, обеззараживание, транспортировка, хранение и утилизация отходов производства и потребления (путем переработки, сжигания или захоронения) в соответствии с требованиями законодательства Республики Беларусь', 2, 61, NULL, NULL),
(2123, 132, 'Для упорядоченного временного хранения медицинских отходов созданы условия, исключающие прямой контакт с медицинскими отходами пациентов и работников (специально выделенное место, помещение, шкаф или другое)', 2, 61, NULL, NULL),
(2124, 133, 'Стирка белья, санитарной одежды, полотенец, салфеток осуществляется в прачечной, прачечной общего типа и (или) мини-прачечных в отделении организации. Белье и постельные принадлежности (матрасы, подушки, одеяла) подвергаются дезинфекции в случаях, предусмотренных законодательством', 2, 61, NULL, NULL),
(2125, 134, 'Обеспечено раздельное хранение личной и санитарной одежды в изолированных секциях шкафов. Не допускается стирка санитарной одежды в домашних условиях', 2, 61, NULL, NULL),
(2126, 135, 'Территория и помещения организации здравоохранения содержатся в чистоте, соблюдается утвержденный порядок уборок', 2, 61, NULL, NULL),
(2127, 136, 'Техническое обслуживание, текущий и капитальный ремонты зданий и помещений организаций, инженерных систем (в том числе отопления, горячего и холодного водоснабжения, водоотведения (канализации), вентиляции, санитарно-технического оборудования) проводится в зависимости от их санитарно-технического состояния и в сроки, установленные планом мероприятий, разработанным и утвержденным руководителем организации', 2, 61, NULL, NULL),
(2128, 137, 'Работники, подлежащие обязательным медицинским осмотрам, проходят их в порядке, предусмотренным законодательством', 2, 61, NULL, NULL),
(2129, 138, 'Минимальный состав и площади отдельных помещений соответствуют приложению 1 к санитарным нормам и правилам «Санитарно-эпидемиологические требования к организациям, оказывающим медицинскую помощь, в том числе к организации и проведению санитарно-противоэпидемических мероприятий по профилактике инфекционных заболеваний в этих организациях», утвержденных постановлением Министерства здравоохранения Республики Беларусь от 5 июля 2017 г. № 73', 2, 61, NULL, NULL),
(2130, 139, 'Дезинфекция высокого уровня и (или) стерилизация эндоскопического оборудования осуществляется механизированным способом. Организация здравоохранения оснащена достаточным количеством моечно-дезинфекционных машин и шкафов для асептического хранения эндоскопического оборудования. (Указанный критерий применяется только в отношении тех организаций, где проводятся эндоскопические вмешательства на нестерильных полостях организма)', 2, 61, NULL, NULL),
(2247, 1, 'Деятельность больницы сестринского ухода (далее – БСУ) осуществляется в соответствии утвержденным положением. Обеспечено выполнение плановых показателей деятельности и проведение их анализа с принятием организационно-управленческих решений', 2, 64, NULL, NULL),
(2248, 2, 'Руководителем организации здравоохранения определены ответственные лица за организацию оказания медико-социальной помощи в БСУ', 1, 64, NULL, NULL),
(2249, 3, 'Соблюдается установленный порядок информирования о порядке оказания медицинской помощи, правилах внутреннего распорядка для пациентов, порядке осуществления административных процедур, рассмотрения обращений граждан', 3, 64, NULL, NULL),
(2250, 4, 'Заведующим БСУ осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности', 2, 64, NULL, NULL),
(2251, 5, 'Материально-техническая база организации здравоохранения соответствует табелю, утвержденному руководителем на основании примерного табеля оснащения, утвержденного приказом Министерства здравоохранения Республики Беларусь 16.11.2018 г. № 1180', 2, 64, NULL, NULL),
(2252, 6, 'Соблюдается утвержденный порядок госпитализации и оказания медико-социальной и долгосрочной паллиативной медицинской помощи пациентам', 3, 64, NULL, NULL),
(2253, 7, 'Медицинские работники БСУ проходят обучение и могут продемонстрировать навыки по оказанию экстренной медицинской помощи. Осуществляется контроль за наличием необходимых лекарственных препаратов, медицинских изделий для оказания экстренной медицинской помощи, своевременное их пополнение и соблюдение сроков годности', 1, 64, NULL, NULL),
(2254, 8, 'Определяется потребность, составляются и выполняются заявки на лекарственные препараты, изделия медицинского назначения в соответствии с Республиканским формуляром лекарственных препаратов. Обеспечено хранение лекарственных препаратов, изделий медицинского назначения в соответствии с требованиями законодательства', 2, 64, NULL, NULL),
(2255, 9, 'Организовано обеспечение пациентов стационара лечебным питанием в соответствии с требованиями законодательства', 1, 64, NULL, NULL),
(2256, 10, 'При оказании медико-социальной и долгосрочной паллиативной медицинской помощи пациентам осуществляется динамическое наблюдение за состоянием пациентов специалистами со средним медицинским образованием', 2, 64, NULL, NULL),
(2257, 11, 'Проводятся медицинские осмотры пациентов врачом-специалистом с периодичностью, соответствующей имеющимся заболеваниям и предъявляемым жалобам, но не реже одного раза в неделю', 2, 64, NULL, NULL),
(2258, 12, 'Для оказания медицинской помощи при возникновении состояний, требующих медицинского вмешательства других врачей-специалистов, пациенты своевременно направляются в другие организации здравоохранения', 2, 64, NULL, NULL),
(2259, 13, 'Наличие специальных медицинских изделий для профилактики и лечения пролежней', 2, 64, NULL, NULL),
(2260, 14, 'Определены функциональные обязанности работников структурных подразделений по осуществлению мероприятий по уходу за лежачими пациентами', 3, 64, NULL, NULL),
(2261, 15, 'Осуществление комплекса профилактических мероприятий по предупреждению развития пролежней, проведение лечения пролежней с оформлением медицинских документов', 2, 64, NULL, NULL),
(2262, 16, 'Проводится обучение и контроль знаний медицинских работников, младших медицинских сестер по уходу, санитарок по порядку и методам проведения мероприятий по уходу за пациентами', 1, 64, NULL, NULL),
(2263, 17, 'Отсутствуют неисполненные на дату проведения оценки (согласно установленным срокам) предписания и решения контролирующих органов в части соблюдения санитарно-эпидемиологического законодательства', 1, 64, NULL, NULL),
(2264, 18, 'Техническое обслуживание, текущий и капитальный ремонты зданий и помещений БСУ, инженерных систем (в том числе отопления, горячего и холодного водоснабжения, водоотведения (канализации), вентиляции, санитарно-технического оборудования) проводится в зависимости от их санитарно-технического состояния и в сроки, установленные планом мероприятий, разработанным и утвержденным руководителем организации', 2, 64, NULL, NULL),
(2278, 1, 'Деятельность РНПЦ осуществляется в соответствии с Уставом', 2, 62, NULL, NULL),
(2279, 2, 'Наличие документов в соответствии с номенклатурой дел и выполнение утвержденных руководителем организации документов и локальных правовых актов (далее – ЛПА):\nкомплексный план основных организационных мероприятий,\nЛПА о распределении обязанностей между заместителями руководителя,\nЛПА, регламентирующего порядок оказания медицинской помощи в РНПЦ\nо правилах внутреннего распорядка для пациентов\nо трудовой и исполнительской дисциплине,\nправила внутреннего трудового распорядка', 2, 62, NULL, NULL),
(2280, 3, 'Деятельность структурных подразделений осуществляется в соответствии с утвержденным положением о структурном подразделении, имеется ознакомление работников с положениями о структурных подразделениях', 3, 62, NULL, NULL),
(2281, 4, 'Выполнение плановых показателей деятельности и проведение их анализа с принятием организационно-управленческих решений. Выполнение управленческих решений по улучшению качества медицинской помощи за последний отчетный период или год', 1, 62, NULL, NULL),
(2282, 5, 'Рассмотрение вопросов деятельности РНПЦ на заседаниях медико-санитарного совета, ученого совета, совета медицинских сестер, производственных совещаниях', 2, 62, NULL, NULL),
(2283, 6, 'Проводится планирование и осуществление мероприятий по обеспечению радиационной безопасности в соответствии с законодательством. Имеется лицензия на данный вид деятельности', 1, 62, NULL, NULL),
(2284, 7, 'Наличие и выполнение требований системы управления охраной труда, обеспечивающей идентификацию опасностей, оценку профессиональных рисков, определение мер управления профессиональными рисками и анализ их результативности.\nВ соответствии с законодательством об охране труда проводятся: обучение, стажировка, инструктажи и проверка знаний работающих по вопросам охраны труда, аттестация рабочих мест по условиям труда, разрабатываются инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, осуществляется контроль за соблюдением требований по охране труда', 2, 62, NULL, NULL),
(2285, 8, 'Наличие и выполнение общеобъектовой инструкции по пожарной безопасности. Определены лица, ответственные за пожарную безопасность, проводится обучение по программе пожарно-технического минимума с последующей проверкой знаний, проводятся инструктажи по пожарной безопасности с работниками. Осуществляется контроль за соблюдением требований по пожарной безопасности', 1, 62, NULL, NULL),
(2286, 9, 'Обеспечена информатизация организации здравоохранения при наличии условий (функционирование медицинской информационной системы, системы межведомственного документооборота, обеспечена информатизация рабочих мест персонала, имеется возможность ведения электронной медицинской карты пациента, выписки электронных рецептов)', 2, 62, NULL, NULL),
(2287, 10, 'Соблюдение требований законодательства о предоставлении информации, составляющей врачебную тайну, внесении в медицинскую информационную систему и обработке персональных данных пациента и информации, составляющей врачебную тайну', 3, 62, NULL, NULL),
(2288, 11, 'Организована работа по обращениям граждан и юридических лиц в соответствии с требованиями действующего законодательства (наличие локального правового акта, регламентирующего порядок организации работы по обращениям граждан и юридических лиц, определение ответственных лиц за работу по обращениям граждан и юридических лиц, рассмотрение обращений осуществляется в полном объеме и по существу поставленных вопросов с соблюдением порядка регистрации и сроков рассмотрения обращений, информация о порядке работы с обращениями граждан и юридических лиц, включая графики личного приема, проведения «горячих» и «прямых» телефонных линий, размещена на информационных стендах, официальном интернет-сайте)', 3, 62, NULL, NULL),
(2289, 12, 'Осуществляется анализ работы с обращениями граждан и юридических лиц (вопросы рассматриваются на производственных (административных, рабочих) совещаниях, клинических конференциях с принятием управленческих решений)', 3, 62, NULL, NULL),
(2290, 13, 'Наличие в организации здравоохранения ЛПА, регламентирующего порядок организации работы по проведению анкетирования работников организации здравоохранения (с частотой, определяемой руководителем организации здравоохранения) с целью изучения социальных вопросов, в том числе психологического климата в организации здравоохранения, справедливости материального стимулирования. Проводится анализ проведенного анкетирования, принимаемые меры по результатам проведенного анкетирования, рассматриваются результаты анкетирования на производственных (административных, рабочих) совещаниях с принятием управленческих решений', 2, 62, NULL, NULL),
(2291, 14, 'Осуществляется работа по противодействию коррупции в соответствие с требованиями действующего законодательства (наличие локального правового акта, создана комиссия по противодействию коррупции, утвержден план работы комиссии, утверждено положение об урегулировании конфликтов интересов, вопросы соблюдения законодательства по противодействию коррупции отражены в должностных инструкциях и других ЛПА)', 2, 62, NULL, NULL),
(2292, 15, 'Осуществляется анализ работы по противодействию коррупции в организации здравоохранения (вопросы рассматриваются на производственных (административных, рабочих) совещаниях с принятием управленческих решений)', 2, 62, NULL, NULL),
(2293, 16, 'Организована работа по осуществлению административных процедур в соответствие с требованиями действующего законодательства (наличие локального правового акта, регламентирующего порядок и виды осуществляемых административных процедур, определены ответственные лица, информация о порядке и видах осуществляемых административных процедур размещена на информационных стендах, официальном интернет-сайте)', 3, 62, NULL, NULL),
(2294, 17, 'Наличие в медицинских документах согласия пациента или лиц, указанных в части второй статьи 18 Закона Республики Беларусь «О здравоохранении», на проведение простых и (или) сложных медицинских вмешательств или отказа от оказания медицинской помощи', 2, 62, NULL, NULL),
(2295, 18, 'Проведение врачебных консультаций (консилиумов) осуществляется в соответствии с Инструкцией о порядке проведения врачебных консультаций (консилиумов), утвержденной Министерством здравоохранения Республики Беларусь, в том числе организация, участие и проведение республиканских консилиумов', 1, 62, NULL, NULL),
(2296, 19, 'Организована выписка рецептов врача в соответствии с Инструкцией о порядке выписывания рецепта врача и создания электронных рецептов врача, утвержденной постановлением Министерства здравоохранения Республики Беларусь \nот 31 октября 2007 г. № 99', 1, 62, NULL, NULL),
(2297, 20, 'Возможность записи на консультативный прием к врачам-специалистам по телефону, через официальный интернет-сайт или при обращении пациента в РНПЦ', 2, 62, NULL, NULL),
(2298, 21, 'Наличие порядка (алгоритма) распределения потоков пациентов при обращении в РНПЦ (регистратура, приемное отделение)', 2, 62, NULL, NULL),
(2299, 22, 'Наличие на информационных стендах, официальном интернет-сайте информации:\n- об основных направлениях деятельности РНПЦ,\n- о режиме работы организации здравоохранения\n- о правилах внутреннего распорядка для пациентов,\n- о лицах, имеющих право на внеочередное, первоочередное оказание медицинской помощи,\n- о порядке лекарственного обеспечения, в том числе на льготных условиях', 3, 62, NULL, NULL),
(2300, 23, 'Территория, прилегающая к организации здравоохранения, и ее помещения оборудованы с учетом доступности для лиц с ограниченными возможностями:\nоборудование входных групп пандусами и/или подъемными платформами, наличие выделенных стоянок для автотранспортных средств лиц с ограниченными возможностями, наличие поручней, расширенных проемов, наличие кресел-колясок,\nналичие в организации здраоохранения условий, позволяющих лицам с ограниченными возможностями получать медицинские услуги наравне с другими пациентами, включая:\nналичие и доступность санитарно-гигиенических помещений,\nдублирование надписей, знаков и иной текстовой и графической информации знаками, выполненными рельефно-точечным шрифтом Брайля,\nналичие алгоритмов сопровождения лиц с ограниченными возможностями работниками организации здравоохранения', 2, 62, NULL, NULL),
(2301, 24, 'Штатная численность должностей служащих (профессий рабочих) утверждена руководителем организации здравоохранения, соответствует организационной структуре, согласована с Министерством здравоохранения Республики Беларусь', 1, 62, NULL, NULL),
(2302, 25, 'Работа организована в пределах утвержденной штатной численности. Внесение изменений в штатное расписание осуществляется на основании анализа штатной численности, объемов выполняемых работ и нагрузки труда работников, потребностей учреждения', 2, 62, NULL, NULL),
(2303, 26, 'Квалификация медицинских работников соответствует требованиям должностной инструкции к занимаемой должности служащих', 1, 62, NULL, NULL),
(2304, 27, 'Руководитель РНПЦ имеет ученую степень', 1, 62, NULL, NULL),
(2305, 28, 'В организации здравоохранения проводится работа по обучению/повышению квалификации персонала (определяется потребность персонала в обучении/повышении квалификации, осуществляется планирование и контроль его прохождения).', 2, 62, NULL, NULL),
(2306, 29, 'Укомплектованность врачами-специалистами не менее 75 % по физическим лицам', 2, 62, NULL, NULL),
(2307, 30, 'Укомплектованность медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам', 2, 62, NULL, NULL),
(2308, 31, 'Обеспечение кадровой потребности в специалистах с высшим медицинским, фармацевтическим образованием (укомплектованность) по занятым должностям служащих не менее 96 %', 2, 62, NULL, NULL),
(2309, 32, 'Обеспечение кадровой потребности в специалистах со средним медицинским, фармацевтическим образованием (укомплектованность) по занятым должностям служащих не менее 96 %', 2, 62, NULL, NULL),
(2310, 33, 'Закрепление молодых специалистов на рабочих местах после завершения срока работы по распределению (направлению на работу) не менее 90 %', 2, 62, NULL, NULL),
(2311, 34, 'Наличие квалификационных категорий у специалистов с высшим медицинским, фармацевтическим образованием 100 % от лиц, подлежащих к профессиональной аттестации', 2, 62, NULL, NULL),
(2312, 35, 'Наличие квалификационных категорий у специалистов со средним медицинским, фармацевтическим образованием 100 % от лиц, подлежащих к профессиональной аттестации', 2, 62, NULL, NULL),
(2313, 36, 'Коэффициент совместительства медицинских работников с высшим медицинским, фармацевтическим образованием не более 1,25', 2, 62, NULL, NULL),
(2314, 37, 'Коэффициент совместительства медицинских работников со средним медицинским, фармацевтическим образованием не более 1,25', 2, 62, NULL, NULL),
(2315, 38, 'Текучесть медицинских кадров с высшим медицинским, фармацевтическим образованием не более 7 %', 3, 62, NULL, NULL),
(2316, 39, 'Текучесть медицинских кадров со средним медицинским, фармацевтическим образованием не более 7 %', 3, 62, NULL, NULL),
(2317, 40, 'Организация здравоохранения оснащена изделиями медицинского назначения и медицинской техникой в объеме, достаточном для оказания медицинской помощи', 1, 62, NULL, NULL),
(2318, 41, 'Определены лица, ответственные за техническое обслуживание и ремонт медицинской техники', 3, 62, NULL, NULL),
(2319, 42, 'Ведется учет, техническое обслуживание и ремонт медицинской техники', 2, 62, NULL, NULL),
(2320, 43, 'Медицинская техника и средства измерения, подлежащие метрологическому контролю, проходит периодическую поверку и калибровку согласно графику, утвержденному руководителем организации здравоохранения', 2, 62, NULL, NULL),
(2321, 44, 'Обеспечена эффективность использования медицинской техники с учетом сменности работы и отсутствия простоя', 2, 62, NULL, NULL),
(2322, 45, 'Имеется локальный правовой акт, утверждающий табель оснащения структурных подразделений РНПЦ необходимой медицинской техникой, изделиями медицинского назначения, инструментарием', 3, 62, NULL, NULL),
(2323, 46, 'Оснащение структурных подразделений РНПЦ соответствует утвержденному табелю оснащения', 2, 62, NULL, NULL),
(2324, 47, 'Наличие в организации здравоохранения локального правового акта, регламентирующего учет, хранение и назначение лекарственных средств и изделий медицинского назначения', 2, 62, NULL, NULL),
(2325, 48, 'Наличие в организации здравоохранения локального правового акта по организации порядка приобретения, хранения, реализации, отпуска (распределения) наркотических средств и психотропных веществ в соответствии с законодательством ', 2, 62, NULL, NULL),
(2326, 49, 'Обеспечение лекарственными средствами, медицинскими изделиями в соответствии с профилем учреждения и Республиканским формуляром лекарственных средств, Республиканским формуляром медицинских изделий', 1, 62, NULL, NULL),
(2327, 50, 'Организованы условия хранения лекарственных средств и изделий медицинского назначения в соответствии с законодательством', 1, 62, NULL, NULL),
(2328, 51, 'В организации здравоохранения создана фармакотерапевтическая комиссия, рассматривающая вопросы управления лекарственными средствами', 2, 62, NULL, NULL),
(2329, 52, 'Организовано и осуществляется выявление, регистрация и представление информации о выявленных нежелательных реакциях на лекарственные средства в республиканское унитарное предприятие «Центр экспертиз и испытаний в здравоохранении»', 2, 62, NULL, NULL),
(2330, 53, 'В организации здравоохранения ежегодно формируется список лекарственных средств для закупки на следующий календарный год на основании Республиканского формуляра лекарственных средств в соответствии с профилем учреждения.\nВ организации здравоохранения, организован и ежегодно проводится ABC/VEN анализ расхода бюджетных средств на лекарственные средства. \nВ организации здравоохранения организован и ежегодно проводится DDD анализ потребления антибактериальных препаратов резерва в соответствии с Республиканским формуляром лекарственных средств', 2, 62, NULL, NULL),
(2331, 54, 'Назначение лекарственных средств осуществляется в соответствии с клиническими протоколами', 1, 62, NULL, NULL),
(2332, 55, 'Оформление назначения лекарственных средств осуществляется с указанием доз, способа введения, режима дозирования', 1, 62, NULL, NULL),
(2333, 56, 'Обеспечено устранение в срок рекомендаций по устранению нарушений, предписаний об устранении нарушений, выданных территориальными центрами гигиены и эпидемиологии', 1, 62, NULL, NULL),
(2334, 57, 'Обеспечены условия для разделения потоков пациентов имеющих и не имеющих признаки острых инфекционных заболеваний согласно законодательству в области санитарно-эпидемиологических требований', 2, 62, NULL, NULL),
(2335, 58, 'Осуществляется выполнение разработанной и утвержденной руководителем организации здравоохранения программы производственного контроля. Сроки и кратность проведения лабораторного производственного контроля соблюдаются согласно установленным в программе производственного контроля на протяжении 3-х последних лет', 2, 62, NULL, NULL),
(2336, 59, 'В организации здравоохранения оборудована и функционирует система приточно-вытяжной вентиляции. Профилактический ремонт, обслуживание и ремонт системы вентиляции проводится не реже одного раза в 3 года', 2, 62, NULL, NULL),
(2337, 60, 'Имеется функционирующая система проточного холодного и горячего водоснабжения, система водоотведения (канализации). Умывальники в помещениях, к которым предъявляется данное требование, оснащены кранами с локтевым (бесконтактным, педальным и прочим некистевым) управлением. В помещениях, к которым предъявляется данное требование, имеется резервное горячее водоснабжение, в том числе обеспечена его работоспособность', 2, 62, NULL, NULL),
(2338, 61, 'Отопление организации здравоохранения осуществляется централизованно или с помощью локальных (автономных) систем, В зимнее время система отопления обеспечивает нормируемые показатели температуры воздуха в помещении', 2, 62, NULL, NULL),
(2339, 62, 'Установлены и находятся в функционирующем состоянии медицинские изделия для очистки воздуха в помещениях, к которым предъявляется данное требование', 2, 62, NULL, NULL),
(2340, 63, 'Внутренняя отделка помещений, в том числе поверхности дверей, окон и нагревательных приборов, выполнена в соответствии с функциональным назначением помещений и устойчива к моющим и дезинфицирующим средствам', 2, 62, NULL, NULL),
(2341, 64, 'Отсутствует в использовании мебель с дефектами покрытия и (или) неисправная мебель, неисправные санитарно-технические изделия и оборудование, медицинские изделия', 2, 62, NULL, NULL),
(2342, 65, 'Дезинфекция, стерилизация проводятся в соответствии с законодательством актами Республики Беларусь. Стерилизация осуществляется в централизованном стерилизационном отделении и (или) в стерилизационной. Отсутствуют места организации стерилизации в лечебных кабинетах (манипуляционных, перевязочных, кабинетах приема врачей-специалистов или в других приспособленных местах). Отсутствуют в использовании простерилизованные медицинские изделия с истекшим сроком стерильности либо хранившиеся с нарушением условий сохранения стерильности', 2, 62, NULL, NULL),
(2343, 66, 'В наличии имеется достаточное количество средств индивидуальной защиты, антисептиков и дезинфектантов', 1, 62, NULL, NULL),
(2344, 67, 'Утвержден и внедрен порядок действий работников при аварийном контакте с биологическим материалом пациента, загрязнении биологическим материалом объектов внешней среды', 2, 62, NULL, NULL),
(2345, 68, 'Информация о выявленных инфекционных заболеваниях своевременно предоставляется в территориальные центры гигиены и эпидемиологии', 3, 62, NULL, NULL),
(2346, 69, 'Осуществляется регистрация всех выявленных инфекций, связанных с оказанием медицинской помощи, с проведением анализа и принятием управленческих решений', 2, 62, NULL, NULL),
(2347, 70, 'Отработанные медицинские изделия подвергаются дезинфекции химическим или физическим методом', 1, 62, NULL, NULL),
(2348, 71, 'Сбор медицинских отходов осуществляется в промаркированной одноразовой и (или) непрокалываемой многоразовой таре. Сбор острых, колющих и режущих отработанных медицинских изделий осуществляется в непрокалываемой одноразовой таре, снабженной плотно прилегающей крышкой', 2, 62, NULL, NULL),
(2349, 72, 'Для упорядоченного временного хранения медицинских отходов созданы условия, исключающие прямой контакт с медицинскими отходами пациентов и работников (специально выделенное место, помещение, шкаф или другое)', 2, 62, NULL, NULL),
(2350, 73, 'Стирка белья, санитарной одежды, полотенец, салфеток осуществляется в прачечной, прачечной общего типа и (или) мини-прачечных в отделении организации. Белье и постельные принадлежности (матрасы, подушки, одеяла) подвергаются дезинфекции в случаях, предусмотренных законодательством', 2, 62, NULL, NULL),
(2351, 74, 'Обеспечено раздельное хранение личной и санитарной одежды в изолированных секциях шкафов. Не допускается стирка санитарной одежды в домашних условиях', 2, 62, NULL, NULL),
(2352, 75, 'Территория и помещения организации здравоохранения содержатся в чистоте, соблюдается утвержденный порядок уборок', 2, 62, NULL, NULL),
(2353, 76, 'Техническое обслуживание, текущий и капитальный ремонты зданий и помещений организаций, инженерных систем (в том числе отопления, горячего и холодного водоснабжения, водоотведения (канализации), вентиляции, санитарно-технического оборудования) проводится в зависимости от их санитарно-технического состояния и в сроки, установленные планом мероприятий, разработанным и утвержденным руководителем организации', 2, 62, NULL, NULL),
(2354, 77, 'Подлежащие работники проходят обязательные медицинские осмотры и гигиеническое обучение', 2, 62, NULL, NULL),
(2355, 78, 'Минимальный состав и площади отдельных помещений соответствуют приложению 1 к санитарным нормам и правилам «Санитарно-эпидемиологические требования к организациям, оказывающим медицинскую помощь, в том числе к организации и проведению санитарно-противоэпидемических мероприятий по профилактике инфекционных заболеваний в этих организациях», утвержденных постановлением Министерства здравоохранения от 5 июля 2017 г. № 73', 2, 62, NULL, NULL),
(2356, 79, 'Дезинфекция высокого уровня и (или) стерилизация эндоскопического оборудования осуществляется механизированным способом. Организация здравоохранения оснащена достаточным количеством моечно-дезинфекционных машин и шкафов для асептического хранения эндоскопического оборудования', 2, 62, NULL, NULL),
(2357, 80, 'Выполняются запланированные объемы оказания медицинской помощи, предоставляемой за счет бюджетного финансирования, в том числе в разрезе регионов, в соответствии с договорами с главными управлениями по здравоохранению облисполкомов и Комитетом по здравоохранению Мингорисполкома', 1, 62, NULL, NULL),
(2358, 81, 'Модель конечных результатов деятельности РНПЦ выполняется с коэффициентом достижения результатов (КДР) не ниже 0,95', 2, 62, NULL, NULL),
(2359, 82, 'Выполнение высокотехнологичных, сложных медицинских вмешательств соответствуют утвержденным показателям', 2, 62, NULL, NULL),
(2360, 83, 'Патологоанатомические вскрытия проводятся в 100% от числа умерших, подлежащих обязательному патологоанатомическому вскрытию', 2, 62, NULL, NULL),
(2361, 84, 'Осуществляется патологоанатомическое исследование биопсийного (операционного) материала при проведении оперативного вмешательства в 100 % случаев', 1, 62, NULL, NULL),
(2362, 85, 'Наличие ЛПА об ответственном враче учреждения здравоохранения', 1, 62, NULL, NULL),
(2363, 86, 'Наличие системы аудио и видеонаблюдения в приемном отделении', 2, 62, NULL, NULL),
(2364, 87, 'Обеспечение готовности приемного отделения к работе в условиях чрезвычайных ситуаций мирного и военного времени: наличие нормативных документов, тренинги персонала', 1, 62, NULL, NULL),
(2365, 88, 'Наличие в приёмном отделении современных автоматизированных систем учёта и регистрации пациента', 2, 62, NULL, NULL),
(2366, 89, 'Наличие алгоритма идентификации личности пациентов при поступлении (переводе)', 2, 62, NULL, NULL),
(2367, 90, 'Наличие и выполнение в организации здравоохранения ЛПА, регламентирующих порядки организации и проведения в соответствии с требованиями законодательства:\n1. медицинских осмотров, врачебных консультаций и врачебных консилиумов,\n2. медицинского наблюдения пациентов,\n3. организации проведения диагностических исследований,\n4. раннего выявления онкологических заболеваний,\n5. паллиативной медицинской помощи,\n6. медицинской реабилитации', 2, 62, NULL, NULL),
(2368, 91, 'В организации здравоохранения обеспечена возможность проведения лабораторных, ультразвуковых, эндоскопических, рентгенологических, функциональных исследований круглосуточно', 1, 62, NULL, NULL),
(2369, 92, 'В организации здравоохранения разработаны правила доставки образцов биологического материала для каждого вида клинических лабораторных исследований с регламентацией условий транспортировки биологических образцов к месту проведения аналитического этапа исследования', 3, 62, NULL, NULL),
(2370, 93, 'В организации здравоохранения для забора венозной крови используются одноразовые стандартные системы: система шприц-пробирка, обеспечивающая как поршневой способ забора крови, так и вакуумный, вакуумные системы, обеспечивающие забор крови вакуумным методом со строгим соблюдением требований производителя компонентов систем', 1, 62, NULL, NULL),
(2371, 94, 'В организации здравоохранения соблюдается последовательность заполнения вакуумных систем: кровь без антикоагулянтов или с прокоагулянтами\nкровь с цитратом\nкровь с гепарином\nкровь с ЭДТА', 2, 62, NULL, NULL),
(2372, 95, 'Транспортировка биологических проб осуществляется в специально предназначенных для этого и промаркированных контейнерах', 2, 62, NULL, NULL),
(2373, 96, 'Порядок транспортировки биологического материала в лабораторию в обязательном порядке предусматривает:\nв каждой организации здравоохранения должен быть определен медицинский работник, ответственный за транспортировку образцов биологического материала в лабораторию, в обязанности которого входит:\nосуществление контроля за подготовленным к транспортировке биологическим материалом, соответствием количества заявок на лабораторные исследования количеству отобранных проб биологического материала,\nоформление Акта приема образцов биологического материала для лабораторных исследований,\nконтроль за температурным режимом в контейнерах не реже 1 раза в 5 дней,\nведение Журнала контроля температурного режима контейнеров,\nдоставка материала в лабораторию осуществляется в максимально короткий промежуток времени, при этом нормативы времени доставки биологического материала в лабораторию отражаются в алгоритме доставки биологического материала, разработанного для данной организации здравоохранения,\nконтейнеры должны обеспечивать соответствующие температурные режимы в зависимости от вида лабораторных исследований. В зависимости от требуемой для транспортировки биологического материала температуры они оборудуются хладагентами (для поддержания температуры 2-8 °C) или термоэлементами (для поддержания температуры в диапазоне 37 °C)', 2, 62, NULL, NULL),
(2374, 97, 'Направление на клинико-лабораторное исследование оформляется в электронном виде либо на бумажном носителе с указанием персональных данных в соответствии с нормативными правовыми актами', 2, 62, NULL, NULL),
(2375, 98, 'Диагностика и лечение осуществляется в соответствии с требованиями клинических протоколов диагностики и лечения', 1, 62, NULL, NULL),
(2376, 99, 'Участие врачей-специалистов в патологоанатомическом вскрытии пациентов, умерших в организациях здравоохранения, оказывающих медицинскую помощь в стационарных условиях', 2, 62, NULL, NULL),
(2377, 100, 'Обеспечено направление эпикризов в организацию здравоохранения по месту жительства (месту пребывания) на электронном и/или бумажном носителе', 2, 62, NULL, NULL),
(2378, 101, 'Отсутствие роста случаев расхождения клинических и патологоанатомических диагнозов по основному заболеванию 2-3 категории', 2, 62, NULL, NULL),
(2379, 102, 'Оформление медицинских документов осуществляется по установленным формам в соответствии с требованиями нормативных правовых актов Министерства здравоохранения Республики Беларусь', 2, 62, NULL, NULL),
(2380, 103, 'Организовано обеспечение пациентов лечебным питанием в соответствии с требованиями законодательства', 1, 62, NULL, NULL),
(2381, 104, 'Наличие и выполнение в организации здравоохранения ЛПА, регламентирующего порядок организации оказания экстренной и неотложной медицинской помощи пациентам. Утверждены алгоритмы оказания экстренной медицинской и неотложной помощи, в том числе комплекса мероприятий сердечно-легочной реанимации, соответствующие условиям оказания медицинской помощи в структурных подразделениях учреждения здравоохранения', 1, 62, NULL, NULL),
(2382, 105, 'Наличие и выполнение в организации здравоохранения ЛПА, определяющего перечень лиц, осуществляющих контроль за наличием необходимых лекарственных препаратов, изделий медицинского назначения, медицинской техники, крови и ее компонентов для оказания экстренной медицинской помощи, своевременное их пополнение с соблюдением сроков годности. В структурном подразделении определены лица, осуществляющие контроль за наличием необходимых лекарственных препаратов, медицинских изделий для оказания экстренной медицинской помощи, своевременное их пополнение и соблюдение сроков годности', 2, 62, NULL, NULL),
(2383, 106, 'Наличие и обеспечение хранения лекарственных препаратов, иммунобиологических лекарственных средств, медицинских изделий, медицинской техники, крови и ее компонентов для оказания экстренной и неотложной медицинской помощи в соответствии с требованиями клинических протоколов, нормативных правовых актов', 1, 62, NULL, NULL),
(2384, 107, 'Организовано проведение занятий с медицинскими работниками по освоению теоретических и практических навыков оказания экстренной медицинской помощи с последующим контролем знаний с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев', 1, 62, NULL, NULL),
(2385, 108, 'Наличие и выполнение в организации здравоохранения ЛПА, регламентирующего порядок проведения экспертизы временной нетрудоспособности (далее – экспертизы ВН) в организации здравоохранения, порядок получения, хранения, учета, списания и уничтожения бланков листков нетрудоспособности, справок о временной нетрудоспособности в соответствии с требованиями нормативных документов', 3, 62, NULL, NULL),
(2386, 109, 'Бухгалтерский учет и использование бланков строгой отчетности (листков нетрудоспособности) осуществляется в соответствии с Инструкцией о порядке использования и бухгалтерского учета бланков строгой отчетности', 1, 62, NULL, NULL),
(2387, 110, 'Организована работа врачебно-консультационных комиссий в соответствии с требованиями законодательства Республики Беларусь', 2, 62, NULL, NULL),
(2388, 111, 'Проводятся инструктажи по вопросам проведения экспертизы ВН и контроль знаний', 2, 62, NULL, NULL),
(2389, 112, 'Проводится анализ статистических показателей заболеваемости с временной нетрудоспособностью с выявлением причин их отклонения', 3, 62, NULL, NULL),
(2390, 113, 'Осуществляется выдача и оформление листков нетрудоспособности и справок о временной нетрудоспособности в соответствии с требованиями Инструкции о порядке выдачи и оформления листков нетрудоспособности и справок о временной нетрудоспособности', 1, 62, NULL, NULL),
(2391, 114, 'Обеспечивается реализация образовательных программ высшего, научно-ориентированного, дополнительного образования по направлению образования «Здравоохранение», профессиональная подготовка врачей-специалистов (клиническая ординатура)', 2, 62, NULL, NULL),
(2392, 115, 'Наличие в организации здравоохранения (РНПЦ) работников высшей научной квалификации, имеющих ученую степень (не менее пяти)', 1, 62, NULL, NULL),
(2393, 116, 'Выполнение диссертаций на соискание ученой степени не менее 1 (одной) в год', 1, 62, NULL, NULL),
(2394, 117, 'Участие в выполнении государственных программ, государственных программ научных исследований, государственных научно-технических программ, региональных научно-технических программ, отраслевых научно-технических программ, межгосударственных программ, проектов в рамках конкурсов Белорусского республиканского фонда фундаментальных исследований, инновационных проектов, выполняемых в рамках Государственной программы инновационного развития Республики Беларусь', 1, 62, NULL, NULL),
(2395, 118, 'Публикация результатов научно-исследовательских работ (статьи в отечественных и международных журналах, сборниках, материалах конференций и т.д.):\nне менее 5 публикаций в год в рецензируемых изданиях, рекомендованных ВАК Республики Беларусь для публикации результатов диссертационных исследований, не менее 3 статей в год в рецензируемых научных изданиях, индексируемых в базах данных научной информации («Web of Science», «Scopus», «РИНЦ»)', 1, 62, NULL, NULL),
(2396, 119, 'Разработка и внедрение новых методов и алгоритмов оказания медицинской помощи (диагностики, лечения, профилактики, реабилитации) и инструкции по их применению, стандартов диагностики и лечения (клинические протоколы и др.):\nинструкции по применению (не менее 1 в год), акты внедрения (не менее 6 в год)', 2, 62, NULL, NULL),
(2397, 120, 'Проведение изобретательской, рационализаторской и патентно-лицензионной работы (подача заявок и/или получение патентов на изобретение, полезную модель, промышленные образцы, товарные знаки, компьютерные программы (не менее 3 в год), получение свидетельств на рационализаторские предложения (не менее 5 в год))', 2, 62, NULL, NULL),
(2398, 121, 'Проведение съездов, конференций, симпозиумов, семинаров, круглых столов и др., выставочная деятельность (не менее 2 в год)', 1, 62, NULL, NULL),
(2399, 122, 'Проведение клинических испытаний лекарственных средств, изделий медицинского назначения согласно требованиям Правил надлежащей клинической практики и действующего законодательства', 2, 62, NULL, NULL),
(2400, 123, 'Проводится аналитическая работа по оценке состояния здоровья населения республики (по профилю РНПЦ), оценке состояния профильной службы в республике с внесением предложений по совершенствованию организации оказания специализированной медицинской помощи', 1, 62, NULL, NULL),
(2401, 124, 'Участие в проведении оценки качества медицинской помощи и медицинских экспертиз, экспертизы качества медицинской помощи, оказываемой в организациях здравоохранения различного уровня, с разработкой плана мероприятий по совершенствованию оказания специализированной медицинской помощи ', 2, 62, NULL, NULL),
(2402, 125, 'Участие в работе экспертных, проблемных, межведомственных комиссий, рабочих групп (по проблемам здравоохранения, подготовке клинических протоколов и др. нормативных правовых актов), заседаниях лечебно-контрольного совета главного управления по здравоохранению облисполкома (Комитета по здравоохранению Мингорисполкома)/Министерства здравоохранения, в мониторинге, работе комиссий по проверке организации здравоохранения', 2, 62, NULL, NULL),
(2403, 126, 'Оказание организационно-методической и плановой консультативной помощи организациям здравоохранения, в т.ч. с выездами врачей-специалистов', 1, 62, NULL, NULL),
(2404, 127, 'Экстренные выезды в организации здравоохранения через государственное учреждение «Республиканский центр организации медицинского реагирования»', 1, 62, NULL, NULL),
(2405, 128, 'Проведение выездных образовательных семинаров (лекции, выступления), обучающих мастер-классов', 2, 62, NULL, NULL),
(2406, 129, 'Участие/разработка, рецензирование нормативных документов ', 2, 62, NULL, NULL),
(2407, 130, 'Организована работа системы телемедицинского консультирования. Обеспечено оказание консультативно-методической помощи при проведении телемедицинского консультирования', 1, 62, NULL, NULL),
(2408, 131, 'Проведение мероприятий по расширению международного сотрудничества и внешнеэкономических связей', 2, 62, NULL, NULL),
(2409, 132, 'Наличие локальных правовых актов, регламентирующих работу по оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи', 2, 62, NULL, NULL),
(2410, 133, 'Наличие сводного плана работы организации здравоохранения по проведению оценки качества медицинской помощи и медицинских экспертиз', 3, 62, NULL, NULL),
(2411, 134, 'Соблюдается порядок организации и проведения оценки качества медицинской помощи и медицинских экспертиз, экспертизы качества медицинской помощи', 1, 62, NULL, NULL),
(2412, 135, 'Наличие заключений о проведении оценки качества медицинской помощи и медицинских экспертиз, экспертизы качества медицинской помощи', 1, 62, NULL, NULL),
(2413, 136, 'Наличие аналитических справок по результатам проведения оценки качества медицинской помощи и медицинских экспертиз, экспертизы качества медицинской помощи с резолюцией руководителя организации здравоохранения, с планом мероприятий по устранению выявленных недостатков и нарушений ', 1, 62, NULL, NULL),
(2414, 137, 'Наличие плана с протоколами проведения клинических конференций по рассмотрению вопросов качества медицинской помощи', 3, 62, NULL, NULL),
(2415, 138, 'Организована работа по проведению анкетирования пациентов с целью изучения удовлетворенности населения доступностью и качеством медицинской помощи. \nОсуществляется анализ анкетирования с рассмотрением результатов анкетирования на производственных (административных, рабочих) совещаниях с принятием управленческих решений', 3, 62, NULL, NULL),
(2416, 139, 'Результаты проведения оценки качества медицинской помощи и медицинских экспертиз, экспертизы качества медицинской помощи рассматриваются на производственных совещаниях, медицинских советах, принимаются меры по устранению причин и условий, повлекших снижение качества оказания медицинской помощи и проведения медицинских экспертиз', 2, 62, NULL, NULL),
(2417, 140, 'Проводится обучение, контроль практических навыков и знаний медицинских работников клинических протоколов по профилям заболеваний, состояниям, синдромам, порядков и методов оказания медицинской помощи, соответствующих профилю оказываемой медицинской помощи ', 2, 62, NULL, NULL);
INSERT INTO `mark` (`id_mark`, `str_num`, `mark_name`, `mark_class`, `id_criteria`, `date_close`, `date_open`) VALUES
(2722, 1, 'Наличие утвержденных руководителем организации документов и локальных правовых актов (далее – ЛПА):\nноменклатура дел организации здравоохранения;\nкомплексный план основных организационных мероприятий;\nо режиме работы организации здравоохранения, структурных подразделений;\nЛПА о распределении обязанностей между заместителями руководителя;\nо трудовой и исполнительской дисциплине;\nправила внутреннего трудового распорядка', 2, 66, NULL, NULL),
(2723, 2, 'Деятельность структурных подразделений осуществляется в соответствии с утвержденным положением о структурном подразделении, имеется ознакомление работников с положениями о структурных подразделениях', 3, 66, NULL, NULL),
(2724, 3, 'Наличие и выполнение требований системы управления охраной труда, обеспечивающей идентификацию опасностей, оценку профессиональных рисков, определение мер управления профессиональными рисками и анализ их результативности. Проводятся первичный, повторный, целевые (при необходимости) инструктажи с сотрудниками структурного подразделения. Разрабатываются инструкции по охране труда для профессий рабочих и (или) отдельных видов работ. Осуществляется контроль за соблюдением требований по охране труда', 2, 66, NULL, NULL),
(2725, 4, 'Наличие и выполнение общеобъектовой инструкции по пожарной безопасности. Определены лица, ответственные за пожарную безопасность, проводится обучение по пожарной безопасности', 2, 66, NULL, NULL),
(2726, 5, 'Выполнение плановых показателей деятельности и проведение их анализа с принятием организационно-управленческих решений', 1, 66, NULL, NULL),
(2727, 6, 'Наличие на информационных стендах в организации здравоохранения информации:\nо режиме работы организации здравоохранения и структурных подразделений;\nправила внутреннего распорядка для пациентов;\nинформации о лицах, имеющих право на внеочередное, первоочередное обслуживание;\nинформация о приеме граждан по личным вопросам руководством организации здравоохранения и вышестоящим руководством.', 1, 66, NULL, NULL),
(2728, 7, 'Официальный интернет-сайт организации здравоохранения функционирует в порядке, установленном законодательством', 2, 66, NULL, NULL),
(2729, 8, 'Организована работа по защите персональных данных. Имеется политика организации в отношении обработки персональных данных; ЛПА о назначении лица или структурного подразделения, ответственного за осуществление внутреннего контроля за обработкой персональных данных; информированное согласие пациента на обработку персональных данных', 2, 66, NULL, NULL),
(2730, 9, 'Наличие и функционирование на официальном интернет-сайте организации здравоохранения: дистанционных способов взаимодействия с получателями медицинских услуг (электронных сервисов «Часто задаваемые вопросы», раздел «Вопрос-Ответ»). ', 2, 66, NULL, NULL),
(2731, 10, 'Наличие в организации здравоохранения условий, позволяющих лицам с ограниченными возможностями получать медицинские услуги наравне с другими пациентами, включая: \nналичие и доступность санитарно-гигиенических помещений;\nдублирование надписей, знаков и иной текстовой и графической информации знаками, выполненными рельефно-точечным шрифтом Брайля;\nналичие алгоритмов сопровождения лиц с ограниченными возможностями работниками организации здравоохранения', 2, 66, NULL, NULL),
(2732, 11, 'Территория, прилегающая к организации здравоохранения, и ее помещения оборудованы с учетом доступности для лиц с ограниченными возможностями:\nоборудование входных групп пандусами (подъемными платформами);\nналичие выделенных стоянок для автотранспортных средств лиц с ограниченными возможностями;\nналичие поручней, расширенных проемов;\nналичие кресел-колясок', 3, 66, NULL, NULL),
(2733, 12, 'Работа по противодействию коррупции в организации здравоохранения осуществляется в соответствии с законодательством', 2, 66, NULL, NULL),
(2734, 13, 'Работа по осуществлению административных процедур организована в соответствии с законодательством \n', 2, 66, NULL, NULL),
(2735, 14, 'Работа по обращениям граждан и юридических лиц организована в соответствии с законодательством', 2, 66, NULL, NULL),
(2736, 15, 'В организации здравоохранения определены лица, ответственные за техническое обслуживание и ремонт медицинской техники', 1, 66, NULL, NULL),
(2737, 16, 'В организации здравоохранения обеспечено ведение учета медицинской техники', 1, 66, NULL, NULL),
(2738, 17, 'Материально-техническая база организации здравоохранения соответствует табелю, утвержденному руководителем на основании примерного табеля оснащения, утвержденного приказом Министерства здравоохранения Республики Беларусь 16.11.2018 № 1180', 2, 66, NULL, NULL),
(2739, 18, 'Наличие своевременной государственной поверки средств измерений', 2, 66, NULL, NULL),
(2740, 19, 'Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и (или) ремонтом. Техническое обслуживание и (или) ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на выполнение данных услуг', 1, 66, NULL, NULL),
(2741, 20, 'Проводится и документируется обучение медицинских работников правилам эксплуатации медицинской техники при вводе в эксплуатацию', 2, 66, NULL, NULL),
(2742, 21, 'Обеспечена эффективность использования медицинской техники; отсутствуют случае необоснованного простоя', 1, 66, NULL, NULL),
(2743, 22, 'Обеспечена информатизация организации здравоохранения: обеспечение информатизации рабочих мест;\nобеспечение медицинской информационной системой;\nвнедрение системы межведомственного документооборота;\nосуществляется ведение электронной медицинской документации ', 2, 66, NULL, NULL),
(2744, 23, 'Наличие в организации здравоохранения ЛПА, регулирующий порядок организации оказания экстренной медицинской помощи. Утверждены алгоритмы оказания экстренной медицинской помощи', 3, 66, NULL, NULL),
(2745, 24, 'Определены лица, осуществляющие контроль за наличием необходимых лекарственных препаратов, медицинских изделий для оказания экстренной медицинской помощи, своевременное их пополнение и соблюдение сроков годности', 3, 66, NULL, NULL),
(2746, 25, 'Имеются лекарственные препараты и медицинские изделия для оказания экстренной медицинской помощи в соответствии с требованиями клинических протоколов', 2, 66, NULL, NULL),
(2747, 26, 'Проводятся занятия с медицинскими работниками по освоению теоретических и практических навыков оказания экстренной медицинской помощи с последующим контролем знаний с частотой, определяемой руководителем организации, но не реже одного раза в год', 2, 66, NULL, NULL),
(2748, 27, 'Обеспечено устранение в срок рекомендаций по устранению нарушений, предписаний об устранении нарушений, выданных территориальными центрами гигиены и эпидемиологии ', 1, 66, NULL, NULL),
(2749, 28, 'Осуществляется выполнение разработанной и утвержденной руководителем организации здравоохранения программы производственного контроля. Сроки и кратность проведения лабораторного производственного контроля соблюдаются согласно установленным в программе производственного контроля на протяжении 3-х последних лет ', 1, 66, NULL, NULL),
(2750, 29, 'В организации оборудована и функционирует система приточно-вытяжной вентиляции. Профилактический ремонт, обслуживание и ремонт системы вентиляции проводится не реже одного раза в 3 года', 2, 66, NULL, NULL),
(2751, 30, 'Имеется функционирующая система проточного холодного и горячего водоснабжения, система водоотведения (канализации). Умывальники в помещениях, к которым предъявляется данное требование, оснащены кранами с локтевым (бесконтактным, педальным и прочим не кистевым) управлением. В помещениях, к которым предъявляется данное требование, имеется резервное горячее водоснабжение, в том числе обеспечена его работоспособность', 2, 66, NULL, NULL),
(2752, 31, 'Отопление организации здравоохранения осуществляется централизованно или с помощью локальных (автономных) систем. Печное отопление не применяется. В зимнее время система отопления обеспечивает нормируемые показатели температуры воздуха в помещении', 2, 66, NULL, NULL),
(2753, 32, 'Установлены и находятся в функционирующем состоянии медицинские изделия для очистки воздуха в помещениях, к которым предъявляется данное требование', 2, 66, NULL, NULL),
(2754, 33, 'Внутренняя отделка помещений, в том числе поверхности дверей, окон и нагревательных приборов, выполнена в соответствии с функциональным назначением помещений и устойчива к моющим и дезинфицирующим средствам', 2, 66, NULL, NULL),
(2755, 34, 'Отсутствует в использовании мебель с дефектами покрытия и (или) неисправная мебель, неисправные санитарно-технические изделия и оборудование, медицинские изделия ', 2, 66, NULL, NULL),
(2756, 35, 'Дезинфекция, стерилизация проводятся в соответствии с законодательством актами Республики Беларусь. Стерилизация осуществляется в централизованном стерилизационном отделении и (или) в стерилизационной. Отсутствуют места организации стерилизации в лечебных кабинетах (манипуляционных, перевязочных, кабинетах приема врачей-специалистов или в других приспособленных местах). Отсутствуют в использовании простерилизованные медицинские изделия с истекшим сроком стерильности либо хранившиеся с нарушением условий сохранения стерильности', 2, 66, NULL, NULL),
(2757, 36, 'В наличии имеется достаточное количество средств индивидуальной защиты, антисептиков и дезинфектантов', 1, 66, NULL, NULL),
(2758, 37, 'Утвержден и внедрен порядок действий работников при аварийном контакте с биологическим материалом пациента, загрязнении биологическим материалом объектов внешней среды', 2, 66, NULL, NULL),
(2759, 38, 'Отработанные медицинские изделия подвергаются дезинфекции химическим или физическим методом', 1, 66, NULL, NULL),
(2760, 39, 'Организован сбор, обеззараживание, транспортировка, хранение и утилизация отходов производства и потребления (путем переработки, сжигания или захоронения) в соответствии с требованиями законодательства Республики Беларусь', 2, 66, NULL, NULL),
(2761, 40, 'Для упорядоченного временного хранения медицинских отходов созданы условия, исключающие прямой контакт с медицинскими отходами пациентов и работников (специально выделенное место, помещение, шкаф или другое)', 2, 66, NULL, NULL),
(2762, 41, 'Стирка белья, санитарной одежды, полотенец, салфеток осуществляется в прачечной, прачечной общего типа и (или) мини-прачечных в отделении организации. Белье и постельные принадлежности (матрасы, подушки, одеяла) подвергаются дезинфекции в случаях, предусмотренных законодательством', 2, 66, NULL, NULL),
(2763, 42, 'Обеспечено раздельное хранение личной и санитарной одежды в изолированных секциях шкафов. Не допускается стирка санитарной одежды в домашних условиях', 2, 66, NULL, NULL),
(2764, 43, 'Территория и помещения организации здравоохранения содержатся в чистоте, соблюдается утвержденный порядок уборок', 2, 66, NULL, NULL),
(2765, 44, 'Техническое обслуживание, текущий и капитальный ремонты зданий и помещений организаций, инженерных систем (в том числе отопления, горячего и холодного водоснабжения, водоотведения (канализации), вентиляции, санитарно-технического оборудования) проводится в зависимости от их санитарно-технического состояния и в сроки, установленные планом мероприятий, разработанным и утвержденным руководителем организации', 2, 66, NULL, NULL),
(2766, 45, 'Работники, подлежащие обязательным медицинским осмотрам, проходят их в порядке, предусмотренным законодательством', 2, 66, NULL, NULL),
(2767, 46, 'Минимальный состав и площади отдельных помещений соответствуют приложению 1 к санитарным нормам и правилам «Санитарно-эпидемиологические требования к организациям, оказывающим медицинскую помощь, в том числе к организации и проведению санитарно-противоэпидемических мероприятий по профилактике инфекционных заболеваний в этих организациях», утвержденных постановлением Министерства здравоохранения Республики Беларусь от 5 июля 2017 г. № 73', 2, 66, NULL, NULL),
(2768, 47, 'Обеспечено наличие автоматизированной информационной системы, учитывающей донации крови, ее компонентов, результаты лабораторного исследования крови, ее компонентов, а также не допуска доноров к донации', 1, 66, NULL, NULL),
(2769, 48, 'Обеспечено наличие подключения к единой базе донорства крови, ее компонентов', 2, 66, NULL, NULL),
(2770, 49, 'Обеспечено осуществляется учет данных медицинского осмотра донора, донаций в медицинской карте донора', 1, 66, NULL, NULL),
(2771, 50, 'Обеспечено проведение медицинского осмотра донора с использованием карты- анкеты донора', 1, 66, NULL, NULL),
(2772, 51, 'Осуществляется обеспечение донора питанием до донации (либо денежной компенсацией)', 1, 66, NULL, NULL),
(2773, 52, 'Обеспечено наличие стандартных операционных процедур, регламентирующих медицинский осмотр доноров, а также допуск к донации', 2, 66, NULL, NULL),
(2774, 53, 'Обеспечено наличие и оформление информированного согласия на донацию крови, ее компонентов', 2, 66, NULL, NULL),
(2775, 54, 'Обеспечено наличие и оперативное внесение в электронную базу (либо на бумажном носителе) списков лиц, имеющих противопоказания к донорству', 1, 66, NULL, NULL),
(2776, 55, 'Обеспечено проведение клинико-лабораторного исследования доноров до донации в соответствии с действующими нормативными правовыми актами', 1, 66, NULL, NULL),
(2777, 56, 'Обеспечено проведение медицинского консультирования доноров, не допущенных к донации', 3, 66, NULL, NULL),
(2778, 57, 'Обеспечено 100% выполнение заявок на заготовку тромбоцитов в течении 48 часов', 2, 66, NULL, NULL),
(2779, 58, 'Созданы резервы компонентов крови в соответствии с действующими нормативными правовыми актами', 1, 66, NULL, NULL),
(2780, 59, 'Время проведения медицинского осмотра донора крови не более 2 часов', 2, 66, NULL, NULL),
(2781, 60, 'Время проведения медицинского осмотра донора компонентов крови не более 3 часов', 2, 66, NULL, NULL),
(2782, 61, 'Не менее 90% лейкодеплецированных компонентов крови для клинического использования', 2, 66, NULL, NULL),
(2783, 62, 'Обеспечено использование технологии стерильного соединения магистралей контейнеров', 2, 66, NULL, NULL),
(2784, 63, 'Обеспечено использование автоматических весов-помешивателей при заготовки цельной крови в выездных и (или) стационарных условиях', 2, 66, NULL, NULL),
(2785, 64, 'Обеспечено проведение центрифугирования цельной крови с валидированными параметрами', 2, 66, NULL, NULL),
(2786, 65, 'Обеспечена герметизация магистралей контейнеров с использованием специальных устройств', 2, 66, NULL, NULL),
(2787, 66, 'Обеспечено проведение визуального контроля компонентов крови в соответствии с действующими нормативными правовыми актами', 1, 66, NULL, NULL),
(2788, 67, 'Обеспечено ведение журналов заготовки крови, компонентов крови на бумажном и (или) электронном носителе', 1, 66, NULL, NULL),
(2789, 68, 'Обеспечено наличие стандартных операционных процедур, регламентирующих заготовку крови, ее компонентов и производство компонентов крови', 2, 66, NULL, NULL),
(2790, 69, 'Обеспечено наличие системы контроля качества компонентов крови', 1, 66, NULL, NULL),
(2791, 70, 'Обеспечено наличие процедуры отмывания компонентов крови мануальным или автоматическим методом', 2, 66, NULL, NULL),
(2792, 71, 'Обеспечено хранение компонентов в холодильном (морозильном) оборудовании с соблюдением соответствующих условий с непрерывным мониторингом', 1, 66, NULL, NULL),
(2793, 72, 'Обеспечено хранение тромбоцитных компонентов крови в термостатах при постоянном перемешивании (при наличии производства)', 2, 66, NULL, NULL),
(2794, 73, 'Обеспечена транспортировка компонентов крови при соответствующих условиях в термоизоляционных контейнерах с использованием логгеров', 2, 66, NULL, NULL),
(2795, 74, 'Обеспечена выбраковка и этикетировка компонентов крови с автоматическим вынесением необходимой информации на этикетку (термопринтер)', 2, 66, NULL, NULL),
(2796, 75, 'Обеспечено наличие стандартных операционных процедур, регламентирующих выбраковку, этикетирование, хранение и транспортировку компонентов крови', 2, 66, NULL, NULL),
(2797, 76, 'Обеспечена организация исследования каждой дозы на маркеры трансфузионно-трансмиссивных инфекций двумя методами (ИФА/ИХЛ+ПЦР) ', 1, 66, NULL, NULL),
(2798, 77, 'Обеспечена организация архивного хранения образца крови после донации в течении не менее трех лет', 1, 66, NULL, NULL),
(2799, 78, 'Обеспечена организация отдельного хранения крови, ее компонентов, не подлежащих выдаче', 1, 66, NULL, NULL),
(2800, 79, 'Обеспечена организация карантинного хранения плазмы для переливания не менее 180 суток', 1, 66, NULL, NULL),
(2801, 80, 'Оформление заявок на кровь, ее компоненты, в соответствии с действующими нормативно-правовыми актами', 2, 66, NULL, NULL),
(2802, 81, 'Обеспечено оказание консультативной помощи по вопросам клинической трансфузиологии', 3, 66, NULL, NULL),
(2803, 82, 'Обеспечено проведение оценки оказания трансфузиологической помощи в организациях здравоохранения', 2, 66, NULL, NULL),
(2804, 83, 'Обеспечено проведение регулярного обучения специалистов организаций здравоохранения по вопросам оказания трансфузиологической помощи', 2, 66, NULL, NULL),
(2805, 84, 'Обеспечено проведение регулярного обучения медицинского персонала по вопросам производственной трансфузиологии', 2, 66, NULL, NULL),
(2806, 85, 'Осуществляется учет данных медицинского осмотра донора, донаций в медицинской карте донора', 1, 66, NULL, NULL),
(2807, 86, 'Обеспечено определение групп крови по системам АВ0 и Rh у доноров', 1, 66, NULL, NULL),
(2808, 87, 'Обеспечено определение антигенов эритроцитов С с Е е системы Rh', 2, 66, NULL, NULL),
(2809, 88, 'Обеспечено определение антигена К системы Келл', 1, 66, NULL, NULL),
(2810, 89, 'Обеспечено определение наличия аллоимунных антиэритроцитарных антител', 1, 66, NULL, NULL),
(2811, 90, 'Обеспечено проведение подбора совместимых эритроцитных компонентов крови для переливания', 2, 66, NULL, NULL),
(2812, 91, 'Обеспечено проведение иммуногематологического консультирования ', 3, 66, NULL, NULL),
(2849, 1, 'Деятельность Центра и станции скорой медицинской помощи (далее – Центр (Станция) СМП) осуществляется в соответствии с Уставом (Положением)', 3, 67, NULL, NULL),
(2850, 2, 'Структура Центра (Станции) СМП организована, утверждена руководителем организации здравоохранения, информация о структуре организации здравоохранения размещена на официальном сайте организации здравоохранения', 3, 67, NULL, NULL),
(2851, 3, 'Приказом Центра (Станции) СМП определены ответственные лица по направлениям деятельности (организация оказания медицинской помощи, контроль деятельности медицинского персонала, контроль эффективного управления финансовыми ресурсами, охраны труда, работа с кадрами, работы инженерных и информационно-технических подразделений и др.) и порядок взаимодействия структурных подразделений организации', 3, 67, NULL, NULL),
(2852, 4, 'Деятельность структурных подразделений Центра (Станции) СМП осуществляется в соответствии с Положением о структурном подразделении', 3, 67, NULL, NULL),
(2853, 5, 'Результаты работы Центра (Станции) СМП анализируются и рассматриваются на производственных совещаниях не менее 2 раз в год, меры по выявлению и устранению недостатков принимаются', 2, 67, NULL, NULL),
(2854, 6, 'В Центре (Станции) СМП имеется отдел (сектор) по охране труда. Осуществляется работа в соответствии с законодательством об охране труда', 3, 67, NULL, NULL),
(2855, 7, 'В структурном подразделении Центра (Станции) СМП осуществляется работа по соблюдению требований по охране труда: имеются инструкции по охране труда для профессий рабочих, проводятся инструктажи по охране труда (первичные, повторные, целевые), ведутся журналы регистрации инструктажей по охране труда', 2, 67, NULL, NULL),
(2856, 8, 'Инструкции по пожарной безопасности разработаны, утверждены руководителем организации, обучение сотрудников осуществляется в соответствии с требованиями законодательства', 2, 67, NULL, NULL),
(2857, 9, 'В Центре (Станции) СМП имеются: необходимая оргтехника, программное обеспечение, локальная сеть, договор на использование (сопровождение) медицинской информационной системы', 2, 67, NULL, NULL),
(2858, 10, 'Имеется возможность оформления и хранения карты вызова бригады скорой медицинской помощи в электронной форме', 3, 67, NULL, NULL),
(2859, 11, 'Штатная численность должностей служащих (профессий рабочих) соответствует требованиям законодательства, утверждена руководителем Центра (Станции) СМП, достаточна для оказания запланированных объемов медицинской помощи', 3, 67, NULL, NULL),
(2860, 12, 'Актуализация штатного расписания Центра (Станции) СМП проводится на основании проведения анализа соответствия штатного расписания производственным нуждам, с учетом численности населения закрепленных районов и фактического объема работы, проводится своевременно', 3, 67, NULL, NULL),
(2861, 13, 'Имеются утвержденные руководителем Центра (Станции) СМП должностные инструкции на каждую должность работников Центра (станции) СМП с указанием квалификационных требований и функций, прав и обязанностей. Работники с должностными инструкциями ознакомлены', 2, 67, NULL, NULL),
(2862, 14, 'Должностные инструкции и (или) контракты (трудовые договоры) медицинских работников содержат требования о соблюдении законодательства о борьбе с коррупцией. Лица, определенные приказом руководителя, в целях недопущения действий, которые могут привести к использованию ими своего служебного положения и связанных с ним возможностей, подписывают обязательство по соблюдению ограничений, установленных актами законодательства', 3, 67, NULL, NULL),
(2863, 15, 'Укомплектованность Центра (Станции) СМП врачами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей СМП укомплектованность не менее 96 % по занятым должностям', 1, 67, NULL, NULL),
(2864, 16, 'Укомплектованность Центра (Станции) СМП медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 67, NULL, NULL),
(2865, 17, 'Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 3, 67, NULL, NULL),
(2866, 18, 'Санитарный автотранспорт оснащен оборудованием и средствами транспортировки пациента, необходимыми для предоставления скорой медицинской помощи, в соответствии с табелем оснащения автомобиля СМП (применим при условии наличия своего автотранспорта)', 2, 67, NULL, NULL),
(2867, 19, 'Используемый санитарный автотранспорт представлен автомобилями скорой медицинской помощи классов В или С (реанимобиль) (применим при условии наличия своего автотранспорта)', 2, 67, NULL, NULL),
(2868, 20, 'Контроль технического состояния автомобилей скорой медицинской помощи организован, приказом руководителя назначены лица, ответственные за его осуществление. (Применим при условии наличия своего автотранспорта)', 2, 67, NULL, NULL),
(2869, 21, 'На автомобилях СМП установлена спутниковая навигационная система, отслеживающая местоположение автомобиля в реальном времени (применим при условии наличия своего автотранспорта)', 3, 67, NULL, NULL),
(2870, 22, 'На территории Центра (Станции) СМП имеется гараж для санитарного транспорта или парковочная площадка', 3, 67, NULL, NULL),
(2871, 23, 'Обеспечено регулярное техническое обслуживание зданий, помещений, инженерных систем Центра (Станции)', 3, 67, NULL, NULL),
(2872, 24, 'Табель оснащения бригад СМП необходимой медицинской техникой, изделиями медицинского назначения соответствует табелю, утвержденному руководителем на основании примерного табеля оснащения, утвержденного приказом Министерства здравоохранения Республики Беларусь 16.11.2018 № 1180', 1, 67, NULL, NULL),
(2873, 25, 'Лица, ответственные за организацию, техническое обслуживание и ремонт медицинской техники определены приказом руководителя Центра (Станции) СМП', 3, 67, NULL, NULL),
(2874, 26, 'В структурном подразделении Центра (Станции) СМП ведется учет медицинской техники', 3, 67, NULL, NULL),
(2875, 27, 'Медицинская техника, находящаяся в эксплуатации в структурном подразделении Центра (Станции) СМП, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 1, 67, NULL, NULL),
(2876, 28, 'Медицинская техника, подлежащая метрологическому контролю, проходит периодическую поверку и калибровку', 1, 67, NULL, NULL),
(2877, 29, 'В Центре (Станции) СМП определен порядок проведения обучения медицинских работников правилам эксплуатации медицинской техники. В структурном подразделении документируется проведение обучения', 3, 67, NULL, NULL),
(2878, 30, 'В Центре (Станции) СМП создана формулярная комиссия, рассматривающая вопросы управления лекарственными средствами', 3, 67, NULL, NULL),
(2879, 31, 'В Центре (Станции) СМП ежегодно формируется список лекарственных средств для закупки на следующий календарный год в соответствии с табелем оснащения и учетом среднего расхода ЛС по наименованиям', 2, 67, NULL, NULL),
(2880, 32, 'В Центре (Станции) СМП определен порядок представления информации о выявленных нежелательных реакциях на лекарственные средства, медицинские изделия', 3, 67, NULL, NULL),
(2881, 33, 'Хранение лекарственных средств осуществляется в предназначенных для этих целей помещениях (помещении, части помещения) или специально выделенных шкафах, сейфах, металлических шкафах, холодильниках с учетом указанных производителем условий хранения на упаковке (температура, влажность и прочие условия). Обеспечено хранение изделий медицинского назначения в соответствии с требованиями законодательства', 2, 67, NULL, NULL),
(2882, 34, 'Учёт и хранение лекарственных средств, в том числе наркотических средств и психотропных веществ, подлежащих предметно-количественному учету, осуществляется в соответствии с требованиями законодательства Республики Беларусь', 2, 67, NULL, NULL),
(2883, 35, 'В Центре (Станции) СМП утверждена программа производственного контроля за соблюдением санитарных правил и выполнением санитарно-противоэпидемических и профилактических мероприятий в соответствии с требованиями законодательства в области санитарно-эпидемического благополучия', 3, 67, NULL, NULL),
(2884, 36, 'При поступлении на работу и в дальнейшем не реже одного раза в год работники структурного подразделения Центра (Станции) СМП проходят обучение по соблюдению санитарных норм и правил, гигиенических нормативов со сдачей зачета', 2, 67, NULL, NULL),
(2885, 37, 'В Центре (Станции) СМП создана и функционирует комиссия по профилактике инфекций, связанных с оказанием медицинской помощи, результаты которой оформляются в виде протокола, содержащего выводы и предложения', 3, 67, NULL, NULL),
(2886, 38, 'Руководством Центра (Станции) СМП определен порядок организации и функционирования оперативного отдела', 3, 67, NULL, NULL),
(2887, 39, 'Проводится фиксирование (запись) номера телефона для обратной связи с вызывающим лицом, адреса вызова или адресного объекта, повода для вызова ', 1, 67, NULL, NULL),
(2888, 40, 'В бесперебойном обмене информацией между бригадой СМП и оперативным отделом используется цифровое картографирование', 3, 67, NULL, NULL),
(2889, 41, 'Имеется взаимодействие оперативного отдела в части связи с другими экстренными службами (МВД, МЧС)', 3, 67, NULL, NULL),
(2890, 42, 'Специализированные врачебные и фельдшерские бригады СМП направляются на вызовы в соответствии с поводом к вызову и его приоритетом', 1, 67, NULL, NULL),
(2891, 43, 'При оказании медицинской помощи пациенту оформляется карта вызова бригады скорой медицинской помощи согласно законодательству ', 2, 67, NULL, NULL),
(2892, 44, 'В структурном подразделении Центра (Станции) СМП определены лица, осуществляющие контроль за наличием необходимых лекарственных препаратов, медицинских изделий для оказания экстренной и неотложной медицинской помощи, своевременное их пополнение и соблюдение сроков годности', 3, 67, NULL, NULL),
(2893, 45, 'Оказание скорой медицинской помощи осуществляется на основании клинических протоколов, утвержденных Министерством здравоохранения Республики Беларусь', 1, 67, NULL, NULL),
(2894, 46, 'Объем диагностических мероприятий соответствует устанавливаемому предварительному диагнозу и требованиям клинических протоколов', 1, 67, NULL, NULL),
(2895, 47, 'Назначение лекарственных препаратов соответствует устанавливаемому предварительному диагнозу, требованиям клинических протоколов, инструкции по медицинскому применению лекарственного препарата', 1, 67, NULL, NULL),
(2896, 48, 'Обеспечено проведение тромболитической терапии при наличии показаний на догоспитальном этапе', 1, 67, NULL, NULL),
(2897, 49, 'Согласие пациента или его законного представителя на проведение простых медицинских вмешательств оформляется в медицинских документах в соответствии с требованиями законодательства', 3, 67, NULL, NULL),
(2898, 50, 'Отказ от оказания медицинской помощи, в том числе медицинского вмешательства, оформляется в приложении к карте вызова бригады СМП, утвержденном постановлением Министерства здравоохранения Республики Беларусь от 4 января 2020 г. № 2 «О вопросах организации деятельности службы скорой медицинской помощи»', 2, 67, NULL, NULL),
(2899, 51, 'В структурном подразделении Центра (Станции) СМП проводятся занятия с медицинскими работниками по освоению теоретических и практических навыков оказания экстренной и неотложной медицинской помощи, в том числе оказанию сердечно-легочной реанимации', 2, 67, NULL, NULL),
(2900, 52, 'Медицинская транспортировка пациентов осуществляется в больничные организации здравоохранения по профилю заболевания в соответствии с требованиями законодательства', 2, 67, NULL, NULL),
(2901, 53, 'Наличие в Центре (Станции) СМП приказов (алгоритмов, инструкций) по действиям медицинского персонала в результате возникновения ЧС техногенного или природного характера', 3, 67, NULL, NULL),
(2902, 54, 'В Центре (Станции) СМП ежегодно проходят занятия с персоналом по принимаемым действиям при чрезвычайных ситуациях (оказание экстренной медицинской помощи, проверка готовности системы оповещения)', 3, 67, NULL, NULL),
(2903, 55, 'В Центре (Станции) СМП определен порядок организации и проведения экспертизы качества медицинской помощи (далее – экспертиза качества), оценки качества медицинской помощи (далее – оценка качества)', 3, 67, NULL, NULL),
(2904, 56, 'В Центре (Станции) СМП определено лицо, ответственное за организацию проведения экспертизы качества, оценки качества', 3, 67, NULL, NULL),
(2905, 57, 'Оценка качества в структурных подразделениях Центра (Станции) СМП проводится в соответствии с планом проведения оценки качества медицинской помощи и медицинских экспертиз, утвержденным руководителем организации здравоохранения', 2, 67, NULL, NULL),
(2906, 58, 'По результатам экспертизы качества и (или) оценки качества оформляется заключение о проведении экспертизы качества медицинской помощи по форме 1 эк-21 и (или) заключение о проведении оценки качества медицинской помощи по форме 1 ок 21', 1, 67, NULL, NULL),
(2907, 59, 'Результаты экспертизы качества, оценки качества рассматриваются на производственных совещаниях Центра (Станции) СМП, принимаются меры по устранению причин и условий, повлекших снижение качества медицинской помощи', 2, 67, NULL, NULL),
(2908, 60, 'Норматив обеспеченности бригадами скорой медицинской помощи: для областей - две бригады скорой медицинской помощи в районах с населением до 15 тыс. жителей, три бригады скорой медицинской помощи в районах с населением от 15 до 35 тыс. жителей, в районах с населением свыше 35 тыс. жителей - три бригады скорой медицинской помощи на 35 тыс. жителей и дополнительно одна бригада скорой медицинской помощи на каждые 12 тыс. жителей сверх 35 тыс. жителей, для г. Минска - одна бригада скорой медицинской помощи на 12 тыс. жителей', 1, 67, NULL, NULL),
(2909, 61, 'Норматив обеспеченности специальными легковыми автомобилями Центра (Станции) СМП – не менее одного специального автомобиля «скорая медицинская помощь», на одну бригаду СМП (применим при условии наличия своего автотранспорта)', 1, 67, NULL, NULL),
(2910, 62, 'Норматив ожидания прибытия бригады скорой медицинской помощи, за исключением вызовов с поводом «констатация смерти» и «транспортировка», выполняется не менее чем в 95% случаев и составляет для экстренных вызовов в городе 20 минут (в иных населенных пунктах 35 минут), для неотложных вызовов в городе 75 минут (в иных населенных пунктах 90 минут)', 2, 67, NULL, NULL),
(2911, 63, 'В Центре (Станции) СМП действует комиссия по вопросам медицинской этики и деонтологии, разработан алгоритм действий для сотрудников при возникновении конфликтных ситуаций', 3, 67, NULL, NULL),
(2912, 64, 'В Центре (Станции) СМП обеспечена защита персональных данных и сохранность врачебной тайны', 1, 67, NULL, NULL),
(2913, 65, 'Информация на бумажном и электронном носителях защищается от повреждения, утери и неавторизированного доступа, предупреждается несанкционированное проникновение в автоматизированную информационную систему', 2, 67, NULL, NULL),
(2914, 66, 'Информация о вызовах скорой медицинской помощи передается для организации оказания медицинской помощи пациенту из Центра (Станции) СМП в амбулаторно-поликлиническую организацию, обслуживающую пациентов на данной административной территории', 3, 67, NULL, NULL),
(3039, 1, 'Деятельность структурных подразделений организации здравоохранения осуществляется в соответствии с положением о структурных подразделениях', 1, 68, NULL, NULL),
(3040, 2, 'Наличие и выполнение разработанной системы управления охраной труда, обеспечивающей идентификацию опасностей, оценку профессиональных рисков, определение мер управления профессиональными рисками и анализ их результативности', 1, 68, NULL, NULL),
(3041, 3, 'Наличие и выполнение общеобъектовой инструкции по пожарной безопасности. Определены лица, ответственные за пожарную безопасность, обеспечено обучение по пожарной безопасности', 1, 68, NULL, NULL),
(3042, 4, 'Наличие утвержденных руководителем организации здравоохранения локальных нормативных актов:\nноменклатура дел организации здравоохранения;\nкомплексный план основных организационных мероприятий;\nо режиме работы организации здравоохранения, структурных подразделений;\nо распределении обязанностей между заместителями руководителя;\nо трудовой и исполнительской дисциплине;\nправила внутреннего трудового распорядка', 1, 68, NULL, NULL),
(3043, 5, 'Анализ выполнения показателей деятельности организации здравоохранения (бизнес-плана предприятия)', 1, 68, NULL, NULL),
(3044, 6, 'Кабинет обеспечивает необходимые объемы оказания медицинской помощи по профилактике и лечению стоматологических заболеваний', 3, 68, NULL, NULL),
(3045, 7, 'Проведение в организации здравоохранения клинических конференций; наличие положения клинических конференциях, оформленных протоколов клинических конференций.', 2, 68, NULL, NULL),
(3046, 8, 'Наличие на рабочих местах врачей-специалистов клинических протоколов, соответствующих профилю оказываемой медицинской помощи', 1, 68, NULL, NULL),
(3047, 9, 'Планирование и осуществление мероприятий по обеспечению радиационной безопасности в соответствии с законодательством Республики Беларусь', 1, 68, NULL, NULL),
(3048, 10, 'Организована выписка рецептов врача в соответствии с Инструкцией о порядке выписывания рецепта врача и создания электронных рецептов врача, утвержденной постановлением Министерства здравоохранения Республики Беларусь от 31 октября 2007 г. № 99', 1, 68, NULL, NULL),
(3049, 11, 'Наличие на информационных стендах в организации здравоохранения информации:\n\nо режиме работы организации здравоохранения и структурных подразделений;\nправила внутреннего распорядка для пациентов;\nинформация о приеме граждан по личным вопросам руководством организации здравоохранения и вышестоящим руководством', 1, 68, NULL, NULL),
(3050, 12, 'Официальный интернет-сайт организации здравоохранения функционирует в порядке, установленном законодательством', 2, 68, NULL, NULL),
(3051, 13, 'Организация работы по защите персональных данных:\nполитика организации в отношении обработки персональных данных;\nприказ о назначении лица или структурного подразделения, ответственного за осуществление внутреннего контроля за обработкой персональных данных;\nналичие информированного согласия пациента на обработку персональных данных.', 2, 68, NULL, NULL),
(3052, 14, 'Организация работы комиссии по вопросам медицинской этики и деонтологии организации здравоохранения.', 2, 68, NULL, NULL),
(3053, 15, 'Работа по противодействию коррупции в организации здравоохранения осуществляется в соответствии с законодательством', 2, 68, NULL, NULL),
(3054, 16, 'Работа по осуществлению административных процедур организована в соответствии с законодательством ', 2, 68, NULL, NULL),
(3055, 17, 'Работа по обращениям граждан и юридических лиц организована в соответствии с законодательством', 2, 68, NULL, NULL),
(3056, 18, 'Территория, прилегающая к организации здравоохранения, и ее помещения оборудованы с учетом доступности для лиц с ограниченными возможностями:оборудование входных групп пандусами (подъемными платформами); наличие выделенных стоянок для автотранспортных средств лиц с ограниченными возможностями; наличие поручней, расширенных проемов (при наличии такой возможности при проведении текущего и (или) капитального ремонта или применение иных решений, обеспечивающих доступность для лиц с ограниченными возможностями)', 2, 68, NULL, NULL),
(3057, 19, 'Наличие в организации здравоохранения условий, позволяющих лицам с ограниченными возможностями получать медицинские услуги наравне с другими пациентами, включая: \nналичие и доступность санитарно-гигиенических помещений;\nдублирование надписей, знаков и иной текстовой и графической информации знаками, выполненными рельефно-точечным шрифтом Брайля;\nили наличие алгоритмов сопровождения лиц с ограниченными возможностями работниками организации здравоохранения', 2, 68, NULL, NULL),
(3058, 20, 'Наличие и функционирование в организации здравоохранения дистанционных способов взаимодействия с получателями медицинских услуг (электронных сервисов, мессенджеров, социальных сетей и пр.).', 2, 68, NULL, NULL),
(3059, 21, 'График работы врачей-специалистов обеспечивает доступность платной медицинской помощи по профилю заболевания.', 1, 68, NULL, NULL),
(3060, 22, 'В организации здравоохранения согласно графику работы учреждения обеспечено проведение рентгенологических исследований', 2, 68, NULL, NULL),
(3061, 23, 'Штатная численность должностей служащих (профессий рабочих) утверждена руководителем организации и является достаточной для оказания планируемых объемов медицинской помощи', 1, 68, NULL, NULL),
(3062, 24, 'Штатное расписание составляется и пересматривается ежегодно и (или) по мере необходимости, на основании анализа кадрового потенциала организации здравоохранения, фактического объема оказываемой медицинской помощи', 2, 68, NULL, NULL),
(3063, 25, 'В организации здравоохранения исполняются требования к занятию должностей служащих медицинских, фармацевтических работников, установленные Министерством здравоохранения Республики Беларусь', 2, 68, NULL, NULL),
(3064, 26, 'На каждую должность медицинского работника руководителем организации здравоохранения утверждена должностная инструкция с указанием квалификационных требований, функций по должности, прав и обязанностей медицинских работников', 1, 68, NULL, NULL),
(3065, 27, 'В организации здравоохранения проводится работа по обучению/повышению квалификации персонала (определяется потребность персонала в обучении/повышении квалификации, осуществляется планирование и контроль его прохождения)', 2, 68, NULL, NULL),
(3066, 28, 'В организации здравоохранения проводится работа по формированию, хранению личных дел персонала', 1, 68, NULL, NULL),
(3067, 29, 'Организована работа по проведению анкетирования работников организации здравоохранения (с частотой, определяемой руководителем организации здравоохранения) с целью изучения социальных вопросов, в том числе психологического климата в организации здравоохранения, справедливости материального стимулирования', 2, 68, NULL, NULL),
(3068, 30, 'В организации здравоохранения определены лица, ответственные за техническое обслуживание и ремонт медицинской техники.', 1, 68, NULL, NULL),
(3069, 31, 'В организации здравоохранения обеспечено ведение учета медицинской техники', 1, 68, NULL, NULL),
(3070, 32, 'Материально-техническая база организации здравоохранения соответствует табелю, утвержденному руководителем на основании примерного табеля оснащения, утвержденного приказом Министерства здравоохранения Республики Беларусь 16.11.2018 № 1180', 2, 68, NULL, NULL),
(3071, 33, 'Кабинет укомплектован изделиями медицинской техники и медицинского назначения в соответствии с табелем оснащения и планируемыми видами и объемами оказания медицинской помощи', 3, 68, NULL, NULL),
(3072, 34, 'Наличие своевременной государственной поверки средств измерений', 2, 68, NULL, NULL),
(3073, 35, 'Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и (или) ремонтом. Техническое обслуживание и (или) ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на выполнение данных услуг', 1, 68, NULL, NULL),
(3074, 36, 'Проводится и документируется обучение медицинских работников правилам эксплуатации медицинской техники при вводе в эксплуатацию', 2, 68, NULL, NULL),
(3075, 37, 'Обеспечена эффективность использования медицинской техники; отсутствуют случае необоснованного простоя', 1, 68, NULL, NULL),
(3076, 38, 'Обеспечена информатизация организации здравоохранения: обеспечение информатизации рабочих мест (наличие персонального компьютера, электронной цифровой подписи);\nобеспечение медицинской информационной системой;\nвнедрение системы межведомственного документооборота;\nосуществляется ведение электронной медицинской карты пациента ', 2, 68, NULL, NULL),
(3077, 39, 'Регистратура оснащена персональными компьютерами, рабочие места медицинских регистраторов автоматизированы', 2, 68, NULL, NULL),
(3078, 40, 'Наличие алгоритмов действий медицинских регистраторов регистратуры в различных ситуациях', 1, 68, NULL, NULL),
(3079, 41, 'Эффективное распределение потоков пациентов посредством визуальной маршрутизации по отделениям, кабинетам и службам.', 1, 68, NULL, NULL),
(3080, 42, 'Наличие предварительной записи на прием к врачам-специалистам через интернет посредством медицинских информационных систем', 2, 68, NULL, NULL),
(3081, 43, 'Наличие возможности записи на повторный прием в кабинете врача-специалиста.', 3, 68, NULL, NULL),
(3082, 44, 'Оказание квалифицированной первичной и специализированной медицинской помощи пациентам по профилям заболеваний, состояниям, синдромам на основании клинических протоколов, а также иных нормативных правовых актов, утвержденных Министерством здравоохранения Республики Беларусь или методов оказания медицинской помощи.', 1, 68, NULL, NULL),
(3083, 45, 'Организация работы по раннему выявлению злокачественных новообразований:\nпроводятся профилактические онкологические осмотры по выявлению предопухолевых и опухолевых заболеваний в соответствии с Инструкцией, утвержденной Министерством здравоохранения Республики Беларусь;\nобеспечена преемственность с другими организациями здравоохранения в оказании медицинской помощи пациентам с предопухолевой патологией и злокачественными новообразованиями с учетом этапности оказания онкологической помощи', 1, 68, NULL, NULL),
(3084, 46, 'Осуществление необходимого документооборота с другими организациями здравоохранения в целях обеспечения преемственности в оказании медицинской помощи населению:\nоформление направлений на стационарное лечение, консультации врачей-специалистов, справок о состоянии здоровья и выписок из медицинских документов в другие организации здравоохранения;\nпредоставление эпикризов стационарного лечения и заключений врачебных консультаций, справок о состоянии здоровья и выписок из медицинских документов из других организаций здравоохранения.', 2, 68, NULL, NULL),
(3085, 47, 'Оформление медицинских документов осуществляется по установленным формам, в соответствии с требованиями нормативных правовых актов Министерства здравоохранения Республики Беларусь.', 1, 68, NULL, NULL),
(3086, 48, 'Медицинские осмотры пациентов проводятся в соответствии с Инструкцией о порядке проведения медицинских осмотров с оформлением записи в медицинских документах. ', 1, 68, NULL, NULL),
(3087, 49, 'Имеется согласие или отказ пациента или лиц, указанных в части второй статьи 18 Закона Республики Беларусь «О здравоохранении», на проведение простых и (или) сложных медицинских вмешательств, оформленный в соответствии с нормативными правовыми актами Республики Беларусь', 2, 68, NULL, NULL),
(3088, 50, 'В организации здравоохранения имеется локальный правовой акт, регулирующий порядок организации оказания экстренной и (или) неотложной медицинской помощи. Утверждены алгоритмы оказания экстренной медицинской помощи.', 1, 68, NULL, NULL),
(3089, 51, 'Определены лица, осуществляющие контроль за наличием необходимых лекарственных препаратов, медицинских изделий для оказания экстренной и (или) неотложной медицинской помощи, своевременное их пополнение и соблюдение сроков годности', 1, 68, NULL, NULL),
(3090, 52, 'Имеются лекарственные препараты и медицинские изделия для оказания экстренной и (или) неотложной медицинской помощи в соответствии с требованиями клинических протоколов', 1, 68, NULL, NULL),
(3091, 53, 'Проводятся занятия с медицинскими работниками по освоению теоретических и практических навыков оказания экстренной и (или) неотложной медицинской помощи с последующим контролем знаний с частотой, определяемой руководителем организации, но не реже одного раза в год', 1, 68, NULL, NULL),
(3092, 54, 'В организации здравоохранения соблюдается порядок организации и проведения экспертизы качества медицинской помощи (далее – экспертиза качества), оценки качества медицинской помощи и медицинских экспертиз (далее – оценка качества)', 1, 68, NULL, NULL),
(3093, 55, 'В организации здравоохранения определены лица, ответственные за организацию и проведение экспертизы качества, оценки качества', 1, 68, NULL, NULL),
(3094, 56, 'Оценка качества в структурных подразделениях проводится в соответствии с планом, утвержденным руководителем организации здравоохранения', 1, 68, NULL, NULL),
(3095, 57, 'По результатам экспертизы качества и (или) оценки качества оформляется заключение', 1, 68, NULL, NULL),
(3096, 58, 'Результаты экспертизы качества, оценки качества рассматриваются на клинических конференциях, принимаются меры по устранению причин и условий, повлекших снижение качества медицинской помощи, медицинских экспертиз', 1, 68, NULL, NULL),
(3097, 59, 'Разработана и внедрена программа производственного и (или) инфекционного контроля в соответствии с законодательством', 2, 68, NULL, NULL),
(3098, 60, 'Своевременное выполнение предписаний по устранению нарушений санитарно-эпидемиологического режима в организации здравоохранения ', 2, 68, NULL, NULL),
(3099, 61, 'В организации здравоохранения проводится техническое обслуживание, текущий, капитальный ремонт зданий и помещений организаций, инженерных систем, в том числе систем отопления, горячего и холодного водоснабжения, водоотведения (канализации), вентиляции, санитарно-технического оборудования в зависимости от их санитарно-технического состояния в соответствии с планом мероприятий, разработанным и утвержденным руководителем организации, и с учетом дефектного акта и (или) проектной документации в случаях, когда их разработка (составление) предусмотрена законодательством в области архитектурной, градостроительной и строительной деятельности.', 2, 68, NULL, NULL),
(3100, 62, 'Дезинфекция, стерилизация проводятся в соответствии с законодательными актами Республики Беларусь.', 1, 68, NULL, NULL),
(3101, 63, 'В наличии имеется достаточное количество средств индивидуальной защиты, антисептиков и дезинфектантов', 1, 68, NULL, NULL),
(3102, 64, 'Утвержден и внедрен порядок действий работников при аварийном контакте с биологическим материалом пациента, загрязнении биологическим материалом объектов внешней среды', 1, 68, NULL, NULL),
(3103, 65, 'Информация о выявленных инфекционных заболеваниях своевременно предоставляется в территориальные центры гигиены и эпидемиологии', 1, 68, NULL, NULL),
(3104, 66, 'Осуществляется регистрация всех выявленных инфекций, связанных с оказанием медицинской помощи, с проведением анализа и принятием управленческих решений', 1, 68, NULL, NULL),
(3105, 67, 'Обеспечено безопасное обращение с медицинскими отходами, классификация всех отходов, образуемых в медицинской организации, а также их своевременная утилизация.', 1, 68, NULL, NULL),
(3106, 68, 'Разработана и внедрена программа производственного и (или) инфекционного контроля в соответствии с законодательством', 2, 68, NULL, NULL),
(3107, 69, 'Своевременное выполнение предписаний по устранению нарушений санитарно-эпидемиологического режима в организации здравоохранения ', 2, 68, NULL, NULL),
(3108, 70, 'В организации здравоохранения проводится техническое обслуживание, текущий, капитальный ремонт зданий и помещений организаций, инженерных систем, в том числе систем отопления, горячего и холодного водоснабжения, водоотведения (канализации), вентиляции, санитарно-технического оборудования в зависимости от их санитарно-технического состояния в соответствии с планом мероприятий, разработанным и утвержденным руководителем организации, и с учетом дефектного акта и (или) проектной документации в случаях, когда их разработка (составление) предусмотрена законодательством в области архитектурной, градостроительной и строительной деятельности.', 2, 68, NULL, NULL),
(3109, 71, 'Дезинфекция, стерилизация проводятся в соответствии с законодательными актами Республики Беларусь.', 1, 68, NULL, NULL),
(3110, 72, 'В наличии имеется достаточное количество средств индивидуальной защиты, антисептиков и дезинфектантов', 1, 68, NULL, NULL);
INSERT INTO `mark` (`id_mark`, `str_num`, `mark_name`, `mark_class`, `id_criteria`, `date_close`, `date_open`) VALUES
(3111, 73, 'Утвержден и внедрен порядок действий работников при аварийном контакте с биологическим материалом пациента, загрязнении биологическим материалом объектов внешней среды', 1, 68, NULL, NULL),
(3166, 1, 'Деятельность организации здравоохранения осуществляется в соответствии с Уставом', 3, 63, NULL, NULL),
(3167, 2, 'Деятельность структурных подразделений организации здравоохранения осуществляется в соответствии с положением о структурных подразделениях', 3, 63, NULL, NULL),
(3168, 3, 'Осуществляется контроль за соблюдением требований по охране труда. Разрабатываются инструкции по охране труда для профессий рабочих и (или) отдельных видов работ. Проводятся первичный, повторный, целевые (при необходимости) инструктажи с сотрудниками структурного подразделения, ведутся соответствующие журналы регистрации инструктажей по охране труда', 2, 63, NULL, NULL),
(3169, 4, 'Утверждена инструкция по пожарной безопасности. В структурных подразделениях определены лица, ответственные за пожарную безопасность, которые проходят обучение по программе пожарно-технического минимума с последующей проверкой знаний', 2, 63, NULL, NULL),
(3170, 5, 'Наличие документов в соответствии с номенклатурой дел', 3, 63, NULL, NULL),
(3171, 6, 'Проведение анализа показателей статистических данных и выполняемой работы', 2, 63, NULL, NULL),
(3172, 7, 'Наличие на рабочих местах врачей-специалистов клинических протоколов, соответствующих профилю оказываемой медицинской помощи', 1, 63, NULL, NULL),
(3173, 8, 'Внедрение в практику работы новых форм и методов оказания медицинской помощи за год', 3, 63, NULL, NULL),
(3174, 9, 'Выполнение плановых показателей деятельности структурного подразделения', 2, 63, NULL, NULL),
(3175, 10, 'Отсутствие случаев нарушения правил охраны труда, техники безопасности, пожарной безопасности работниками организации здравоохранения за последний отчетный период или год', 1, 63, NULL, NULL),
(3176, 11, 'Отсутствие фактов нарушения исполнительской и трудовой дисциплины в организации здравоохранения за последний отчетный период или год', 3, 63, NULL, NULL),
(3177, 12, 'Отсутствие обоснованных жалоб в течение последнего отчетного периода или года', 1, 63, NULL, NULL),
(3178, 13, 'Организован порядок приобретения, хранения, реализации, отпуска (распределения) наркотических средств и психотропных веществ в соответствии с Инструкцией о порядке приобретения, хранения, реализации, отпуска (распределения) наркотических средств и психотропных веществ в медицинских целях, утвержденной постановлением Министерства здравоохранения Республики Беларусь от 28 декабря 2004 г. № 51:\nимеется лицензия на деятельность, связанную с оборотом наркотических средств, психотропных веществ и их прекурсоров,\nпомещения хранения наркотических средств соответствуют требованиям, указанным в лицензии,\nпомещения хранения психотропных веществ соответствуют требованиям, указанным в лицензии,\nсоответствие количества доз (ампул, таблеток),\nналичие постоянно действующей комиссии, созданной приказом руководителя, по проверке целесообразности назначения наркотических средств и психотропных веществ,\nежемесячная проверка комиссией целесообразности назначения врачами-специалистами наркотических средств и психотропных веществ, состояния их хранения, соответствия записей в медицинских документах записям в журнале учета главной медицинской сестры организации здравоохранения \n', 1, 63, NULL, NULL),
(3179, 14, 'Организована выписка рецептов врача в соответствии с Инструкцией о порядке выписывания рецепта врача и создания электронных рецептов врача, утвержденной постановлением Министерства здравоохранения Республики Беларусь от 31 октября 2007 г. № 99:\nналичие бланков рецептов врача для выписки лекарственных препаратов, реализуемых в аптеке за полную стоимость,\nналичие и учет бланков рецептов врача для выписки психотропных веществ и лекарственных препаратов, обладающих анаболической активностью\n', 2, 63, NULL, NULL),
(3180, 15, 'Организовано обеспечение лекарственными препаратами в соответствии с Республиканским формуляром лекарственных средств. Обеспечено хранение лекарственных препаратов, изделий медицинского назначения в соответствии с требованиями законодательства', 1, 63, NULL, NULL),
(3181, 16, 'Наличие на информационных стендах в организации здравоохранения информации о правилах внутреннего распорядка для пациентов и их родственников', 3, 63, NULL, NULL),
(3182, 17, 'Официальный интернет-сайт организации здравоохранения функционирует в порядке, установленном законодательством', 3, 63, NULL, NULL),
(3183, 18, 'Проводится обучение и контроль знаний медицинских работников клинических протоколов по профилям заболеваний, состояниям, синдромам, порядков и методов оказания медицинской помощи (далее – клинические протоколы), соответствующих профилю оказываемой медицинской помощи', 2, 63, NULL, NULL),
(3184, 19, 'В организации здравоохранения имеются условия для формирования и ведения электронных медицинских документов', 2, 63, NULL, NULL),
(3185, 20, 'В организации здравоохранения создана комиссия по медицинской этике и деонтологии и(или) этический комитет', 3, 63, NULL, NULL),
(3186, 21, 'Работа по противодействию коррупции в организации здравоохранения осуществляется в соответствии с законодательством', 2, 63, NULL, NULL),
(3187, 22, 'Работа по осуществлению административных процедур организована в соответствии с законодательством ', 2, 63, NULL, NULL),
(3188, 23, 'Работа по обращениям граждан и юридических лиц организована в соответствии с законодательством', 2, 63, NULL, NULL),
(3189, 24, 'Наличие информации о деятельности организации здравоохранения, размещенной на информационных стендах и на официальном интернет-сайте организации здравоохранения ', 3, 63, NULL, NULL),
(3190, 25, 'Территория, прилегающая к организации здравоохранения, и ее помещения оборудованы с учетом доступности для лиц с ограниченными возможностями: оборудование входных групп пандусами (подъемными платформами), наличие выделенных стоянок для автотранспортных средств лиц с ограниченными возможностями, наличие поручней, расширенных проемов, наличие кресел-колясок', 2, 63, NULL, NULL),
(3191, 26, 'Наличие в организации здравоохранения условий, позволяющих лицам с ограниченными возможностями получать медицинские услуги наравне с другими пациентами, включая: \nналичие и доступность санитарно-гигиенических помещений, дублирование надписей, знаков и иной текстовой и графической информации знаками, выполненными рельефно-точечным шрифтом Брайля,\nналичие алгоритмов сопровождения лиц с ограниченными возможностями работниками организации здравоохранения\n', 2, 63, NULL, NULL),
(3192, 27, 'Наличие на информационных стендах в организации здравоохранения информации о лицах, имеющих право на внеочередное, первоочередное оказание медицинской помощи', 3, 63, NULL, NULL),
(3193, 28, 'Наличие и функционирование на официальном интернет-сайте организации здравоохранения дистанционных способов взаимодействия с получателями медицинских услуг: электронных сервисов (в том числе раздел «Часто задаваемые вопросы», раздел «Вопрос-Ответ»), обеспечение технической возможности выражения получателями медицинских услуг мнения о качестве и доступности медицинской помощи (наличие анкеты для опроса граждан или гиперссылки на нее)', 3, 63, NULL, NULL),
(3194, 29, 'График работы врачей-специалистов обеспечивает доступность паллиативной медицинской помощи ', 1, 63, NULL, NULL),
(3195, 30, 'Штатная численность должностей служащих (профессий рабочих) утверждена руководителем организации здравоохранения с учетом норм нагрузок труда работников, установленных в организации здравоохранения, и является достаточной для оказания планируемых объемов медицинской помощи', 3, 63, NULL, NULL),
(3196, 31, 'На каждую должность медицинского работника руководителем организации здравоохранения утверждена должностная инструкция с указанием квалификационных требований и функций, прав и обязанностей медицинских работников', 3, 63, NULL, NULL),
(3197, 32, 'Квалификация медицинских работников структурного подразделения соответствует требованиям должностной инструкции к занимаемой должности служащего. Медицинские работники ознакомлены с должностной инструкцией', 2, 63, NULL, NULL),
(3198, 33, 'Укомплектованность структурного подразделения врачами-специалистами не менее 75 % по физическим лицам ', 1, 63, NULL, NULL),
(3199, 34, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам ', 1, 63, NULL, NULL),
(3200, 35, 'Обеспечение кадровой потребности в специалистах с высшим медицинским, педагогическим образованием (укомплектованность) по занятым должностям служащих не менее 90 %', 1, 63, NULL, NULL),
(3201, 36, 'Обеспечение кадровой потребности в специалистах со средним медицинским образованием (укомплектованность) по занятым должностям служащих не менее 90 %', 1, 63, NULL, NULL),
(3202, 37, 'Закрепление молодых специалистов на рабочих местах после завершения срока работы по распределению (направлению на работу) не менее 90 %', 2, 63, NULL, NULL),
(3203, 38, 'Наличие квалификационных категорий у специалистов с высшим медицинским образованием 100 % от лиц, подлежащих   профессиональной аттестации', 2, 63, NULL, NULL),
(3204, 39, 'Наличие квалификационных категорий у специалистов со средним медицинским образованием 100 % от лиц, подлежащих   профессиональной аттестации', 2, 63, NULL, NULL),
(3205, 40, 'Коэффициент совместительства медицинских работников с высшим медицинским образованием не более 1,25 ', 2, 63, NULL, NULL),
(3206, 41, 'Коэффициент совместительства медицинских работников со средним медицинским образованием не более 1,25', 2, 63, NULL, NULL),
(3207, 42, 'Текучесть медицинских кадров с высшим медицинским образованием не более 7 %', 3, 63, NULL, NULL),
(3208, 43, 'Текучесть медицинских кадров со средним медицинским образованием не более 7 %', 3, 63, NULL, NULL),
(3209, 44, 'В организации здравоохранения определены лица, ответственные за техническое обслуживание и ремонт медицинской техники', 3, 63, NULL, NULL),
(3210, 45, 'Обеспечено ведение учета медицинской техники', 3, 63, NULL, NULL),
(3211, 46, 'Материально-техническая база организации здравоохранения соответствует табелю, утвержденному руководителем на основании примерного табеля оснащения, утвержденного приказом Министерства здравоохранения Республики Беларусь 16.11.2018 № 1180', 1, 63, NULL, NULL),
(3212, 47, 'Наличие своевременной государственной поверки средств измерений ', 1, 63, NULL, NULL),
(3213, 48, 'Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и (или) ремонтом. Техническое обслуживание и (или) ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на выполнение данных услуг', 1, 63, NULL, NULL),
(3214, 49, 'Проводится и документируется обучение медицинских работников правилам эксплуатации медицинской техники', 2, 63, NULL, NULL),
(3215, 50, 'Обеспечен своевременный ремонт медицинской техники', 1, 63, NULL, NULL),
(3216, 51, 'Обеспечена эффективность использования медицинской техники с учетом сменности работы и отсутствия простоя', 2, 63, NULL, NULL),
(3217, 52, 'Обеспечена информатизация организации здравоохранения:\n обеспечение медицинской информационной системой, автоматизированными информационными системами,\n внедрение системы межведомственного документооборота,\nобеспечение информатизации рабочих мест (наличие персонального компьютера, электронной цифровой подписи),\nосуществляется ведение электронной медицинской карты пациента \n', 2, 63, NULL, NULL),
(3218, 53, 'Обеспечено устранение в срок рекомендаций по устранению нарушений, предписаний об устранении нарушений, выданных территориальными центрами гигиены и эпидемиологии', 3, 63, NULL, NULL),
(3219, 54, 'Осуществляется выполнение разработанной и утвержденной руководителем организации здравоохранения программы производственного контроля', 2, 63, NULL, NULL),
(3220, 55, 'Оборудована и функционирует система приточно-вытяжной вентиляции. Профилактический ремонт, обслуживание и ремонт системы вентиляции проводится не реже одного раза в 3 года', 2, 63, NULL, NULL),
(3221, 56, 'Имеется функционирующая система проточного холодного и горячего водоснабжения, система водоотведения (канализации). Умывальники в помещениях, к которым предъявляется данное требование, оснащены кранами с локтевым (бесконтактным, педальным и прочим не кистевым) управлением ', 3, 63, NULL, NULL),
(3222, 57, 'В помещениях, к которым предъявляется данное требование, имеется резервное горячее водоснабжение, в том числе обеспечена его работоспособность ', 2, 63, NULL, NULL),
(3223, 58, 'Отопление организации здравоохранения осуществляется централизованно или с помощью локальных (автономных) систем. Печное отопление не применяется. В зимнее время система отопления обеспечивает нормируемые показатели температуры воздуха в помещении', 2, 63, NULL, NULL),
(3224, 59, 'Внутренняя отделка помещений, в том числе поверхности дверей, окон и нагревательных приборов, выполнена в соответствии с функциональным назначением помещений и устойчива к моющим и дезинфицирующим средствам', 2, 63, NULL, NULL),
(3225, 60, 'Отсутствует в использовании мебель с дефектами покрытия и (или) неисправная мебель, неисправные санитарно-технические изделия и оборудование, медицинские изделия ', 3, 63, NULL, NULL),
(3226, 61, 'Используются стерильные медицинские изделия, контактирующие с раневой поверхностью, кровью, внутренними стерильными полостями организма, растворами для инъекций, а также которые в процессе эксплуатации соприкасаются со слизистой оболочкой и могут вызвать ее повреждение. Отсутствуют в использовании простерилизованные медицинские изделия с истекшим сроком   стерильности либо хранившиеся с нарушением условий сохранения стерильности', 1, 63, NULL, NULL),
(3227, 62, 'Организован сбор, обеззараживание, транспортировка, хранение и утилизация отходов производства и потребления (путем переработки, сжигания или захоронения) в соответствии с требованиями законодательства Республики Беларусь', 2, 63, NULL, NULL),
(3228, 63, 'Обеспечено наличие и раздельное хранение личной и санитарной одежды в изолированных секциях шкафов. Не допускается стирка санитарной одежды в домашних условиях', 3, 63, NULL, NULL),
(3229, 64, 'Техническое обслуживание, текущий и капитальный ремонты зданий и помещений организации здравоохранения, инженерных систем (в том числе отопления, горячего и холодного водоснабжения, водоотведения (канализации), вентиляции, санитарно-технического оборудования) проводится в зависимости от их санитарно-технического состояния и в сроки, установленные планом мероприятий, разработанным и утвержденным руководителем организации', 2, 63, NULL, NULL),
(3230, 65, 'Работники, подлежащие обязательным медицинским осмотрам, проходят их в порядке, предусмотренным законодательством', 3, 63, NULL, NULL),
(3231, 66, 'Минимальный состав и площади отдельных помещений соответствуют приложению 1 к санитарным нормам и правилам «Санитарно-эпидемиологические требования к организациям, оказывающим медицинскую помощь, в том числе к организации и проведению санитарно-противоэпидемических мероприятий по профилактике инфекционных заболеваний в этих организациях», утвержденным постановлением Министерства здравоохранения Республики Беларусь от 5 июля 2017 г. № 73', 3, 63, NULL, NULL),
(3232, 67, 'В организации здравоохранения соблюдается порядок организации и проведения экспертизы качества медицинской помощи (далее – экспертиза качества), оценки качества медицинской помощи и медицинских экспертиз (далее – оценка качества)', 3, 63, NULL, NULL),
(3233, 68, 'В организации здравоохранения определены лица, ответственные за организацию и проведение экспертизы качества, оценки качества', 3, 63, NULL, NULL),
(3234, 69, 'Оценка качества в структурных подразделениях проводится в соответствии с планом, утвержденным руководителем организации здравоохранения', 2, 63, NULL, NULL),
(3235, 70, 'По результатам экспертизы качества и (или) оценки качества оформляется заключение', 2, 63, NULL, NULL),
(3236, 71, 'Результаты экспертизы качества, оценки качества рассматриваются на врачебно-консультационных комиссиях, клинических конференциях, принимаются меры по устранению причин и условий, повлекших снижение качества медицинской помощи, медицинских экспертиз', 2, 63, NULL, NULL),
(3237, 72, 'Госпитализация пациентов осуществляется в соответствии с медицинскими показаниями', 3, 63, NULL, NULL),
(3238, 73, 'Проведение врачебных консультаций (консилиумов) в соответствии с Инструкцией о порядке проведения врачебных консультаций (консилиумов)', 3, 63, NULL, NULL),
(3239, 74, 'Организовано проведение клинических конференций', 3, 63, NULL, NULL),
(3240, 75, 'Наличие локальных нормативных актов по организации оказания неотложной медицинской помощи ', 3, 63, NULL, NULL),
(3241, 76, 'Наличие и обеспечение хранения лекарственных препаратов, изделий медицинского назначения, медицинской техники для оказания неотложной медицинской помощи в соответствии с требованиями нормативных правовых актов', 2, 63, NULL, NULL),
(3242, 77, 'Направление эпикризов в организацию здравоохранения по месту жительства (месту пребывания) на электронном или бумажном носителе ', 2, 63, NULL, NULL),
(3243, 78, 'Организовано обеспечение пациентов лечебным питанием в соответствии с требованиями законодательства', 1, 63, NULL, NULL),
(3244, 79, 'Обеспечено функционирование специализированных тематических школ (школ ухода за тяжелобольными)', 3, 63, NULL, NULL),
(3245, 80, 'Организована работа выездной патронажной службы', 3, 63, NULL, NULL),
(3246, 81, 'Организована работа дневного стационара', 2, 63, NULL, NULL),
(3247, 82, 'Организовано оказание психологической помощи пациентам и их родственникам', 2, 63, NULL, NULL),
(3248, 83, 'При наличии болевого синдрома проведена оценка выраженности боли с помощью нумерологической оценочной шкалы (НОШ) или других шкал. Назначенное лечение обеспечивает адекватный контроль боли', 1, 63, NULL, NULL),
(3249, 84, 'Оформление медицинских документов осуществляется по установленным формам', 3, 63, NULL, NULL),
(3250, 85, 'В медицинских документах оформлено согласие на предоставление (отказ от предоставления) информации, составляющей врачебную тайну, при возможности получения такого согласия (отказа)', 3, 63, NULL, NULL),
(3251, 86, 'Определен риск совершения суицида с использованием опросника риска суицидального поведения, модифицированной шкалы оценки риска суицида (при наличии возможности заполнения)', 2, 63, NULL, NULL),
(3252, 87, 'Наличие в медицинских документах клинико-функционального диагноза основного и сопутствующих заболеваний ', 2, 63, NULL, NULL),
(3253, 88, 'Имеется согласие или отказ пациента или лиц, указанных в части второй статьи 18 Закона Республики Беларусь «О здравоохранении», на проведение простых и (или) сложных медицинских вмешательств', 2, 63, NULL, NULL),
(3254, 89, 'В медицинских документах имеются дневники врачебных наблюдений и назначений:пост в удовлетворительном состоянии и состоянии средней степени тяжести в рабочие дни – не реже 3 раз в неделю,в тяжелом состоянии – 1 раз в сутки', 2, 63, NULL, NULL),
(3255, 90, 'Оформляются листы назначений с указанием режима, диеты, лекарственных препаратов с указанием доз, способа введения, режима дозирования', 3, 63, NULL, NULL),
(3256, 91, 'В медицинских документах оценка патологических симптомов осуществляется в баллах в соответствии с оценочными шкалами', 3, 63, NULL, NULL),
(3257, 92, 'Отказ от оказания медицинской помощи, в том числе медицинского вмешательства, оформляется записью в медицинских документах и подписывается пациентом либо его законным представителем и лечащим врачом', 2, 63, NULL, NULL),
(3258, 93, 'Врачебные консультации (консилиумы) и их решения оформляются в соответствии с требованиями Инструкции о порядке проведения врачебных консультаций (консилиумов), утвержденной постановлением Министерства здравоохранения Республики Беларусь от 20 декабря 2008 г. № 224', 2, 63, NULL, NULL),
(3259, 94, 'Выписка пациентов из организации здравоохранения осуществляется после осмотра врача (заведующего) структурным подразделением с оформлением эпикриза ', 2, 63, NULL, NULL),
(3260, 95, 'В организации здравоохранения имеется локальный правовой акт, регулирующий порядок организации оказания экстренной медицинской помощи пациентам. Утверждены алгоритмы оказания экстренной медицинской помощи', 3, 63, NULL, NULL),
(3261, 96, 'В структурном подразделении определены лица, осуществляющие контроль за наличием необходимых лекарственных препаратов, медицинских изделий для оказания экстренной медицинской помощи, своевременное их пополнение и соблюдение сроков годности', 3, 63, NULL, NULL),
(3262, 97, 'В структурном подразделении имеются лекарственные препараты и медицинские изделия для оказания экстренной медицинской помощи в соответствии с требованиями клинических протоколов', 2, 63, NULL, NULL),
(3263, 98, 'В структурном подразделении проводятся занятия с медицинскими работниками по освоению теоретических и практических навыков оказания экстренной медицинской помощи с последующим контролем знаний с частотой, определяемой руководителем организации, но не реже одного раза в год', 1, 63, NULL, NULL),
(3264, 99, 'Наличие специальных медицинских изделий для профилактики и лечения пролежней по количеству коек анестезиологии, реанимации и интенсивной терапии', 2, 63, NULL, NULL),
(3265, 100, 'Определены функциональные обязанности работников структурных подразделений по осуществлению мероприятий по уходу за лежачими пациентами', 1, 63, NULL, NULL),
(3266, 101, 'Осуществление комплекса профилактических мероприятий по предупреждению развития пролежней, проведение лечения пролежней с оформлением медицинских документов', 1, 63, NULL, NULL),
(3267, 102, 'Проводится обучение и контроль знаний медицинских работников, младших медицинских сестер по уходу, санитарок порядка и методов проведения мероприятий по уходу за пациентами ', 2, 63, NULL, NULL),
(3268, 103, 'Наличие нормативного документа, регламентирующего порядок госпитализации в учреждение', 1, 63, NULL, NULL),
(3269, 104, 'Наличие информационных и справочных материалов о порядке организации оказания паллиативной медицинской помощи', 2, 63, NULL, NULL),
(3270, 105, 'Наличие технических средств связи и коммуникации', 1, 63, NULL, NULL),
(3271, 106, 'Наличие системы аудио и видеонаблюдения ', 1, 63, NULL, NULL),
(3272, 107, 'Наличие современной автоматизированной системы учёта и регистрации пациентов', 2, 63, NULL, NULL),
(3356, 1, 'Деятельность организации здравоохранения осуществляется в соответствии с Уставом', 2, 65, NULL, NULL),
(3357, 2, 'Наличие утвержденных руководителем организации документов и локальных правовых актов (далее – ЛПА):\nноменклатура дел организации здравоохранения,\nкомплексный план основных организационных мероприятий,\nо режиме работы организации здравоохранения, структурных подразделений,\nЛПА о распределении обязанностей между заместителями руководителя,\nо трудовой и исполнительской дисциплине,\nо правилах внутреннего трудового распорядка', 3, 65, NULL, NULL),
(3358, 3, 'Наличие и выполнение требований системы управления охраной труда, обеспечивающей идентификацию опасностей, оценку профессиональных рисков, определение мер управления профессиональными рисками и анализ их результативности. Проводятся первичный, повторный, целевые (при необходимости) инструктажи с сотрудниками структурных подразделений. Разрабатываются инструкции по охране труда для профессий рабочих и (или) отдельных видов работ. Осуществляется контроль за соблюдением требований по охране труда', 2, 65, NULL, NULL),
(3359, 4, 'Наличие и выполнение общеобъектовой инструкции по пожарной безопасности. Определены лица, ответственные за пожарную безопасность, проводится обучение по пожарной безопасности', 2, 65, NULL, NULL),
(3360, 5, 'Выполнение плановых показателей деятельности и проведение их анализа с принятием организационно-управленческих решений', 1, 65, NULL, NULL),
(3361, 6, 'Наличие на рабочих местах врачей-специалистов клинических протоколов, соответствующих профилю оказываемой медицинской помощи, либо обеспечен постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативных правовых актов по организации медицинской помощи', 3, 65, NULL, NULL),
(3362, 7, 'Наличие в организации здравоохранения локального правового акта по организации порядка приобретения, хранения, реализации, отпуска (распределения) наркотических средств и психотропных веществ в соответствии с законодательством', 1, 65, NULL, NULL),
(3363, 8, 'Наличие на информационных стендах в организации здравоохранения информации:\nо режиме работы организации здравоохранения,\nо правилах внутреннего распорядка для пациентов,\nо порядке оказания медицинской помощи в организации здравоохранения,\nо приеме граждан по личным вопросам руководством организации здравоохранения и вышестоящим руководством', 1, 65, NULL, NULL),
(3364, 9, 'Официальный интернет-сайт организации здравоохранения функционирует в порядке, установленном законодательством', 2, 65, NULL, NULL),
(3365, 10, 'Организована работа по защите персональных данных. Имеется политика организации в отношении обработки персональных данных, ЛПА о назначении лица или структурного подразделения, ответственного за осуществление внутреннего контроля за обработкой персональных данных, информированное согласие законных представителей воспитанников на обработку персональных данных', 2, 65, NULL, NULL),
(3366, 11, 'Организована работа комиссии по вопросам медицинской этики и деонтологии организации здравоохранения', 2, 65, NULL, NULL),
(3367, 12, 'В организации здравоохранения соблюдаются права ребенка на получение безопасной и эффективной медицинской помощи, имеются условия для организации среды, дружественной детям (наличие и правильная организация игровых комнат, красочное оформление стен холлов, коридоров и др.)', 3, 65, NULL, NULL),
(3368, 13, 'В организации здравоохранения имеются условия для освоения образовательных программ и оказания коррекционно-педагогической помощи детям, согласно действующим нормативным правовым актам', 1, 65, NULL, NULL),
(3369, 14, 'Работа по противодействию коррупции в организации здравоохранения осуществляется в соответствии с законодательством', 2, 65, NULL, NULL),
(3370, 15, 'Работа по осуществлению административных процедур организована в соответствии с законодательством', 2, 65, NULL, NULL),
(3371, 16, 'Работа по обращениям граждан и юридических лиц организована в соответствии с законодательством', 2, 65, NULL, NULL),
(3372, 17, 'Наличие в организации здравоохранения ЛПА по обеспечению доступности медицинской помощи', 3, 65, NULL, NULL),
(3373, 18, 'Наличие информации о деятельности организации здравоохранения, размещенной на информационных стендах и на официальном интернет-сайте организации здравоохранения', 2, 65, NULL, NULL),
(3374, 19, 'Обеспечен круглосуточный график работы врачей-специалистов для оказания медицинской помощи детям', 1, 65, NULL, NULL),
(3375, 20, 'Наличие в организации здравоохранения условий, позволяющих лицам с ограниченными возможностями получать медицинские услуги, включая: \nналичие и доступность санитарно-гигиенических помещений,\nдублирование надписей, знаков и иной текстовой и графической информации знаками, выполненными рельефно-точечным шрифтом Брайля', 2, 65, NULL, NULL),
(3376, 21, 'Территория, прилегающая к организации здравоохранения, и ее помещения оборудованы с учетом доступности для лиц с ограниченными возможностями:\nоборудование входных групп пандусами (подъемными платформами),\nналичие выделенных стоянок для автотранспортных средств лиц с ограниченными возможностями, наличие поручней, расширенных проемов,\nналичие кресел-колясок', 3, 65, NULL, NULL),
(3377, 22, 'Обеспечено оказание паллиативной медицинской помощи вне организации здравоохранения выездной паллиативной службой', 1, 65, NULL, NULL),
(3378, 23, 'Штатная численность должностей служащих (профессий рабочих) утверждена руководителем организации здравоохранения с учетом норм нагрузок труда работников, установленных в организации здравоохранения, и является достаточной для оказания планируемых объемов медицинской помощи', 2, 65, NULL, NULL),
(3379, 24, 'Штатное расписание составляется и пересматривается ежегодно, на основании анализа кадрового потенциала организации здравоохранения, фактического объема оказываемой медицинской помощи', 3, 65, NULL, NULL),
(3380, 25, 'В организации здравоохранения исполняются требования к занятию должностей служащих медицинских, фармацевтических работников, установленные Министерством здравоохранения Республики Беларусь', 2, 65, NULL, NULL),
(3381, 26, 'На каждую должность медицинского работника руководителем организации здравоохранения утверждена должностная инструкция с указанием квалификационных требований, функций по должности, прав и обязанностей медицинских работников', 1, 65, NULL, NULL),
(3382, 27, 'В организации здравоохранения проводится работа по обучению/повышению квалификации персонала (определяется потребность персонала в обучении/повышении квалификации, осуществляется планирование и контроль его прохождения)', 2, 65, NULL, NULL),
(3383, 28, 'Укомплектованность организации здравоохранения врачами-специалистами не менее 75 % по физическим лицам', 1, 65, NULL, NULL),
(3384, 29, 'Укомплектованность организации здравоохранения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам', 1, 65, NULL, NULL),
(3385, 30, 'Обеспечение кадровой потребности в специалистах с высшим медицинским, фармацевтическим образованием (укомплектованность) по занятым должностям служащих не менее 96 %', 1, 65, NULL, NULL),
(3386, 31, 'Обеспечение кадровой потребности в специалистах со средним медицинским, фармацевтическим образованием (укомплектованность) по занятым должностям служащих не менее 96 %', 1, 65, NULL, NULL),
(3387, 32, 'Закрепление молодых специалистов на рабочих местах после завершения срока работы по распределению (направлению на работу) не менее 90 %', 2, 65, NULL, NULL),
(3388, 33, 'Наличие квалификационных категорий у специалистов с высшим медицинским, фармацевтическим образованием 100 % от лиц, подлежащих профессиональной аттестации', 2, 65, NULL, NULL),
(3389, 34, 'Наличие квалификационных категорий у специалистов со средним медицинским, фармацевтическим образованием 100 % от лиц, подлежащих профессиональной аттестации', 2, 65, NULL, NULL),
(3390, 35, 'Коэффициент совместительства медицинских работников с высшим медицинским, фармацевтическим образованием не более 1,25 ', 2, 65, NULL, NULL),
(3391, 36, 'Коэффициент совместительства медицинских работников со средним медицинским, фармацевтическим образованием не более 1,25', 2, 65, NULL, NULL),
(3392, 37, 'Текучесть медицинских кадров с высшим медицинским, фармацевтическим образованием не более 7 %', 3, 65, NULL, NULL),
(3393, 38, 'Текучесть медицинских кадров со средним медицинским, фармацевтическим образованием не более 7 %', 3, 65, NULL, NULL),
(3394, 39, 'В организации здравоохранения проводится работа по формированию, хранению личных дел персонала', 1, 65, NULL, NULL),
(3395, 40, 'В организации здравоохранения проводится инструктаж/ознакомление каждого поступающего работника со следующими документами:\nколлективный договор,\nправила внутреннего трудового распорядка,\nдолжностная инструкция,\nохрана труда (вводный инструктаж),\nпожарная безопасность (вводный инструктаж),\nДиректива Президента Республики Беларусь от 11 марта 2004 г. № 1 «О мерах по укреплению общественной безопасности и дисциплины»,\nДекрет Президента Республики Беларусь от 15 декабря 2014 г. № 5 «Об усилении требований к руководящим кадрам и работникам организаций»,\nЗакон Республики Беларусь от 15 июля 2015 г. № 305 -З «О борьбе с коррупцией»', 1, 65, NULL, NULL),
(3396, 41, 'Организована работа по проведению анкетирования работников организации здравоохранения (с частотой, определяемой руководителем организации здравоохранения) с целью изучения социальных вопросов, в том числе психологического климата в организации здравоохранения, справедливости материального стимулирования', 2, 65, NULL, NULL),
(3397, 42, 'В организации здравоохранения определены лица, ответственные за техническое обслуживание и ремонт медицинской техники', 1, 65, NULL, NULL),
(3398, 43, 'В организации здравоохранения обеспечено ведение учета медицинской техники', 1, 65, NULL, NULL),
(3399, 44, 'Материально-техническая база организации здравоохранения соответствует табелю, утвержденному руководителем на основании примерного табеля оснащения, утвержденного приказом Министерства здравоохранения Республики Беларусь 16.11.2018 № 1180', 2, 65, NULL, NULL),
(3400, 45, 'Наличие своевременной государственной поверки средств измерений', 2, 65, NULL, NULL),
(3401, 46, 'Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и (или) ремонтом. Техническое обслуживание и (или) ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на выполнение данных услуг', 1, 65, NULL, NULL),
(3402, 47, 'Проводится и документируется обучение медицинских работников правилам эксплуатации медицинской техники при вводе в эксплуатацию', 2, 65, NULL, NULL),
(3403, 48, 'Обеспечена эффективность использования медицинской техники, отсутствуют случаи необоснованного простоя', 1, 65, NULL, NULL),
(3404, 49, 'Обеспечена информатизация организации здравоохранения:\nобеспечение информатизации рабочих мест (наличие персонального компьютера, электронной цифровой подписи),\nобеспечение медицинской информационной системой,\nвнедрение системы межведомственного документооборота,\nведение электронной медицинской карты пациента ', 2, 65, NULL, NULL),
(3405, 50, 'Помещение детей в дом ребенка осуществляется в соответствии с нормативными правовыми актами', 3, 65, NULL, NULL),
(3406, 51, 'Наличие в организации здравоохранения ЛПА по проведению диспансеризации воспитанников, регламентирующего порядок проведения диспансеризации, адаптированный к условиям работы организации здравоохранения', 3, 65, NULL, NULL),
(3407, 52, 'Осуществляется учет результатов диспансеризации воспитанников и контроль полноты проведения мероприятий по диспансеризации, предусмотренных утвержденной схемой', 1, 65, NULL, NULL),
(3408, 53, 'Обеспечено оказание квалифицированной первичной и специализированной медицинской помощи пациентам по профилям заболеваний, состояниям, синдромам на основании клинических протоколов, а также иных нормативных правовых актов, утвержденных Министерством здравоохранения Республики Беларусь или методов оказания медицинской помощи (в организации здравоохранения или определен порядок направления в другие организации здравоохранения)', 1, 65, NULL, NULL),
(3409, 54, 'Обеспечена преемственность с больничными организациями здравоохранения. Определен порядок направления детей на плановую и экстренную госпитализацию. Обеспечено выполнение рекомендаций по дальнейшему медицинскому наблюдению после выписки', 1, 65, NULL, NULL),
(3410, 55, 'Перевод детей в группу паллиативной медицинской помощи, изменение группы паллиативной медицинской помощи или вывод из группы паллиативной медицинской помощи осуществляется врачебным консилиумом с участием специалиста детской паллиативной медицинской помощи', 2, 65, NULL, NULL),
(3411, 56, 'Организовано обеспечение детей из группы паллиативной медицинской помощи трахеостомическими и гастростомическими трубками, определен порядок их замены', 1, 65, NULL, NULL),
(3412, 57, 'Определен порядок оказания паллиативной медицинской помощи детям, нуждающимся в проведении длительной искусственной вентиляции легких (далее – ИВЛ) в стационарных условиях и на дому', 1, 65, NULL, NULL),
(3413, 58, 'Организовано рациональное питание детей, в том числе диетическое, в соответствии с заболеваниями, состояниями и возрастом детей согласно требованиям законодательства', 3, 65, NULL, NULL),
(3414, 59, 'Организована работа по медицинской реабилитации, абилитации детей. Для каждого ребенка разработана индивидуальная программа медицинской реабилитации, абилитации по форме согласно приложению 8 постановления Министерства здравоохранения Республики Беларусь от 9 июня 2021 г. № 77 «О вопросах проведения медико-социальной экспертизы»', 1, 65, NULL, NULL),
(3415, 60, 'Оформление медицинских документов осуществляется по установленным формам, в соответствии с требованиями нормативных правовых актов Министерства здравоохранения Республики Беларусь', 1, 65, NULL, NULL),
(3416, 61, 'Медицинские осмотры воспитанников проводятся в соответствии с Инструкцией о порядке проведения медицинских осмотров с оформлением записи в медицинских документах', 1, 65, NULL, NULL),
(3417, 62, 'Имеется согласие или отказ пациента или лиц, указанных в части второй статьи 18 Закона Республики Беларусь «О здравоохранении», на проведение простых и (или) сложных медицинских вмешательств, оформленный в соответствии с нормативными правовыми актами Республики Беларусь', 2, 65, NULL, NULL),
(3418, 63, 'В медицинских документах детей группы паллиативной медицинской помощи имеется индивидуальный план паллиативного наблюдения ребенка с учетом диагноза, тяжести состояния, витального прогноза и потребностей семьи', 1, 65, NULL, NULL),
(3419, 64, 'Врачебные консультации (консилиумы) и их решения оформляются в соответствии с требованиями Инструкции о порядке проведения врачебных консультаций (консилиумов), утвержденной Министерством здравоохранения Республики Беларусь', 2, 65, NULL, NULL),
(3420, 65, 'Осуществляется документооборот с другими организациями здравоохранения в целях обеспечения преемственности в оказании медицинской помощи детям:\nоформление направлений на стационарное лечение, консультации врачей-специалистов, справок о состоянии здоровья и выписок из медицинских документов в другие организации здравоохранения,\nпредоставление эпикризов стационарного лечения и заключений врачебных консультаций, справок о состоянии здоровья и выписок из медицинских документов из других организаций здравоохранения', 2, 65, NULL, NULL),
(3421, 66, 'Профилактические прививки выполняются в соответствии с Национальным календарем профилактических прививок согласно приложению 1 к постановлению Министерства здравоохранения Республики Беларусь от 17 мая 2018 г. № 42 «О профилактических прививках» и (или) по эпидемиологическим показаниям\nПрофилактические прививки выполняются с учетом медицинских показаний и противопоказаний к их проведению, в соответствии с инструкцией по медицинскому применению, прилагаемой к иммунобиологическому лекарственному препарату', 1, 65, NULL, NULL),
(3422, 67, 'Наличие устного согласия на проведение профилактической прививки или в установленном порядке оформленного отказа от проведения профилактической прививки', 2, 65, NULL, NULL),
(3423, 68, 'Осуществление медицинского осмотра врачом-педиатром (врачом-специалистом, врачом общей практики) перед проведением профилактической прививки', 1, 65, NULL, NULL),
(3424, 69, 'Осуществление медицинским работником, проводившим профилактическую прививку, медицинского наблюдения за ребенком в течение 30 минут после введения иммунобиологического лекарственного препарата', 1, 65, NULL, NULL),
(3425, 70, 'Выявление, регистрация и расследование случаев серьезных побочных реакций на профилактические прививки, направление внеочередной информации о серьезной побочной реакции после прививки', 2, 65, NULL, NULL),
(3426, 71, 'Транспортировка, хранение и уничтожение иммунобиологических лекарственных средств, а также хранение и использование хладоэлементов соответствует санитарно-эпидемиологическим требованиям', 2, 65, NULL, NULL),
(3427, 72, 'Наличие в организации здравоохранения ЛПА, регулирующий порядок организации оказания экстренной медицинской помощи. Утверждены алгоритмы оказания экстренной медицинской помощи', 3, 65, NULL, NULL),
(3428, 73, 'Определены лица, осуществляющие контроль за наличием необходимых лекарственных препаратов, медицинских изделий для оказания экстренной медицинской помощи, своевременное их пополнение и соблюдение сроков годности', 3, 65, NULL, NULL),
(3429, 74, 'Имеются лекарственные препараты и медицинские изделия для оказания экстренной медицинской помощи в соответствии с требованиями клинических протоколов', 2, 65, NULL, NULL),
(3430, 75, 'Проводятся занятия с медицинскими работниками по освоению теоретических и практических навыков оказания экстренной медицинской помощи с последующим контролем знаний с частотой, определяемой руководителем организации, но не реже одного раза в год', 2, 65, NULL, NULL),
(3431, 76, 'В организации здравоохранения соблюдается порядок организации и проведения экспертизы качества медицинской помощи (далее – экспертиза качества), оценки качества медицинской помощи и медицинских экспертиз (далее – оценка качества)', 3, 65, NULL, NULL),
(3432, 77, 'В организации здравоохранения определены лица, ответственные за организацию и проведение экспертизы качества, оценки качества', 2, 65, NULL, NULL),
(3433, 78, 'Оценка качества в структурных подразделениях проводится в соответствии с планом, утвержденным руководителем организации здравоохранения', 2, 65, NULL, NULL),
(3434, 79, 'По результатам экспертизы качества и (или) оценки качества оформляется заключение', 1, 65, NULL, NULL),
(3435, 80, 'Результаты экспертизы качества, оценки качества рассматриваются на врачебно-консультационных комиссиях, врачебно-сестринских конференциях, принимаются меры по устранению причин и условий, повлекших снижение качества медицинской помощи, медицинских экспертиз', 2, 65, NULL, NULL),
(3436, 81, 'Обеспечено устранение в срок рекомендаций по устранению нарушений, предписаний об устранении нарушений, выданных территориальными центрами гигиены и эпидемиологии', 1, 65, NULL, NULL),
(3437, 82, 'Обеспечены условия для разделения пациентов имеющих и не имеющих признаки острых инфекционных заболеваний согласно законодательству в области санитарно-эпидемиологических требований', 2, 65, NULL, NULL),
(3438, 83, 'Осуществляется выполнение разработанной и утвержденной руководителем организации здравоохранения программы производственного контроля. Сроки и кратность проведения лабораторного производственного контроля соблюдаются согласно установленным в программе производственного контроля на протяжении 3-х последних лет ', 2, 65, NULL, NULL),
(3439, 84, 'В организации оборудована и функционирует система приточно-вытяжной вентиляции. Профилактический ремонт, обслуживание и ремонт системы вентиляции проводится не реже одного раза в 3 года', 2, 65, NULL, NULL),
(3440, 85, 'Имеется функционирующая система проточного холодного и горячего водоснабжения, система водоотведения (канализации). Умывальники в помещениях, к которым предъявляется данное требование, оснащены кранами с локтевым (бесконтактным, педальным и прочим не кистевым) управлением. В помещениях, к которым предъявляется данное требование, имеется резервное горячее водоснабжение, в том числе обеспечена его работоспособность', 2, 65, NULL, NULL),
(3441, 86, 'Отопление организации здравоохранения осуществляется централизованно или с помощью локальных (автономных) систем, Печное отопление не применяется. В зимнее время система отопления обеспечивает нормируемые показатели температуры воздуха в помещении', 2, 65, NULL, NULL),
(3442, 87, 'Установлены и находятся в функционирующем состоянии медицинские изделия для очистки воздуха в помещениях, к которым предъявляется данное требование', 2, 65, NULL, NULL),
(3443, 88, 'Внутренняя отделка помещений, в том числе поверхности дверей, окон и нагревательных приборов, выполнена в соответствии с функциональным назначением помещений и устойчива к моющим и дезинфицирующим средствам.', 2, 65, NULL, NULL),
(3444, 89, 'Отсутствует в использовании мебель с дефектами покрытия и (или) неисправная мебель, неисправные санитарно-технические изделия и оборудование, медицинские изделия', 2, 65, NULL, NULL),
(3445, 90, 'Дезинфекция, стерилизация проводятся в соответствии с законодательством актами Республики Беларусь. Стерилизация осуществляется в централизованном стерилизационном отделении и (или) в стерилизационной. Отсутствуют места организации стерилизации в лечебных кабинетах (манипуляционных, перевязочных, кабинетах приема врачей-специалистов или в других приспособленных местах). Отсутствуют в использовании простерилизованные медицинские изделия с истекшим сроком стерильности либо хранившиеся с нарушением условий сохранения стерильности', 2, 65, NULL, NULL),
(3446, 91, 'В наличии имеется достаточное количество средств индивидуальной защиты, антисептиков и дезинфектантов', 1, 65, NULL, NULL),
(3447, 92, 'Утвержден и внедрен порядок действий работников при аварийном контакте с биологическим материалом пациента, загрязнении биологическим материалом объектов внешней среды', 2, 65, NULL, NULL),
(3448, 93, 'Информация о выявленных инфекционных заболеваниях своевременно предоставляется в территориальные центры гигиены и эпидемиологии', 3, 65, NULL, NULL),
(3449, 94, 'Осуществляется регистрация всех выявленных инфекций, связанных с оказанием медицинской помощи, с проведением анализа и принятием управленческих решений', 2, 65, NULL, NULL),
(3450, 95, 'Отработанные медицинские изделия подвергаются дезинфекции химическим или физическим методом', 1, 65, NULL, NULL),
(3451, 96, 'Организован сбор, обеззараживание, транспортировка, хранение и утилизация отходов производства и потребления (путем переработки, сжигания или захоронения) в соответствии с требованиями законодательства Республики Беларусь', 2, 65, NULL, NULL),
(3452, 97, 'Для упорядоченного временного хранения медицинских отходов созданы условия, исключающие прямой контакт с медицинскими отходами пациентов и работников (специально выделенное место, помещение, шкаф или другое)', 2, 65, NULL, NULL),
(3453, 98, 'Стирка белья, санитарной одежды, полотенец, салфеток осуществляется в прачечной, прачечной общего типа и (или) мини-прачечных в отделении организации. Белье и постельные принадлежности (матрасы, подушки, одеяла) подвергаются дезинфекции в случаях, предусмотренных законодательством', 2, 65, NULL, NULL),
(3454, 99, 'Обеспечено раздельное хранение личной и санитарной одежды в изолированных секциях шкафов. Не допускается стирка санитарной одежды в домашних условиях', 2, 65, NULL, NULL),
(3455, 100, 'Территория и помещения организации здравоохранения содержатся в чистоте, соблюдается утвержденный порядок уборок', 2, 65, NULL, NULL),
(3456, 101, 'Техническое обслуживание, текущий и капитальный ремонты зданий и помещений организаций, инженерных систем (в том числе отопления, горячего и холодного водоснабжения, водоотведения (канализации), вентиляции, санитарно-технического оборудования) проводится в зависимости от их санитарно-технического состояния и в сроки, установленные планом мероприятий, разработанным и утвержденным руководителем организации', 2, 65, NULL, NULL),
(3457, 102, 'Работники, подлежащие обязательным медицинским осмотрам, проходят их в порядке, предусмотренным законодательством', 2, 65, NULL, NULL),
(3458, 103, 'Минимальный состав и площади отдельных помещений соответствуют приложению 1 к санитарным нормам и правилам «Санитарно-эпидемиологические требования к организациям, оказывающим медицинскую помощь, в том числе к организации и проведению санитарно-противоэпидемических мероприятий по профилактике инфекционных заболеваний в этих организациях», утвержденных постановлением Министерства здравоохранения от 05 июля 2017 г. № 73', 2, 65, NULL, NULL),
(3483, 1, 'Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 69, NULL, NULL),
(3484, 2, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей. Результаты анализа документируются, предоставляются лицу, ответственному за организацию кардиологической помощи.\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 69, NULL, NULL),
(3485, 3, 'Укомплектованность структурного подразделения врачами-кардиологами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей-кардиологов укомплектованность не менее 96 % по занятым должностям ', 1, 69, NULL, NULL),
(3486, 4, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям ', 1, 69, NULL, NULL),
(3487, 5, 'Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего ', 1, 69, NULL, NULL),
(3488, 6, 'Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 69, NULL, NULL),
(3489, 7, 'Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев. \nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 69, NULL, NULL),
(3490, 8, 'Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков. \nМедицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи ', 3, 69, NULL, NULL);
INSERT INTO `mark` (`id_mark`, `str_num`, `mark_name`, `mark_class`, `id_criteria`, `date_close`, `date_open`) VALUES
(3491, 9, 'Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 69, NULL, NULL),
(3492, 10, 'Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой ', 2, 69, NULL, NULL),
(3493, 11, 'Порядок оказания медицинской помощи в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь.\nСоблюдается порядок (алгоритмы) оказания скорой и плановой медицинской помощи при кардиологической патологии', 2, 69, NULL, NULL),
(3494, 12, 'Работа структурного подразделения обеспечена в сменном режиме ', 2, 69, NULL, NULL),
(3495, 13, 'Определен порядок оказания медицинской помощи пациентам с заболеваниями кардиологического профиля на период отсутствия в организации здравоохранения врача-кардиолога', 1, 69, NULL, NULL),
(3496, 14, 'Соблюдается порядок медицинского наблюдения пациентов кардиологического профиля в амбулаторных условиях.\nВедется учет пациентов, подлежащих медицинскому наблюдению врачом-кардиологом. \nРуководителем структурного подразделения (ответственным лицом) осуществляется анализ результатов медицинского наблюдения пациентов', 1, 69, NULL, NULL),
(3497, 15, 'Соблюдается установленный нормативно-правовым актом органа управления здравоохранением административной территории порядок («дорожная карта») оказания специализированной кардиологической помощи при острых коронарных синдромах. \nСотрудники структурного подразделения, осуществляющего  оказание специализированной кардиологической помощи, ознакомлены с данным нормативно-правовым актом', 1, 69, NULL, NULL),
(3498, 16, 'Организовано направление пациентов для проведения рентгенэндоваскулярных методов диагностики и лечения в комиссию по отбору пациентов (далее – комиссия) на плановую коронарографию (далее – КАГ).\nОрганизовано ведение «листов ожидания» для проведения КАГ и своевременный обмен информацией с комиссией', 1, 69, NULL, NULL),
(3499, 17, 'Обеспечена преемственность с больничными организациями здравоохранения. Определен порядок направления на плановую и экстренную госпитализацию пациентов кардиологического профиля. Обеспечено выполнение на амбулаторном этапе рекомендаций по дальнейшему медицинскому наблюдению после выписки ', 2, 69, NULL, NULL),
(3500, 18, 'Обеспечено назначение лечения пациентам в амбулаторных условиях согласно клиническим протоколам ', 1, 69, NULL, NULL),
(3501, 19, 'Оформление медицинской карты амбулаторного больного соответствует установленной форме', 3, 69, NULL, NULL),
(3502, 20, 'В организации здравоохранения разработан алгоритм при отказе пациента (или его законного представителя) от оказания медицинской помощи или ее отдельных видов', 2, 69, NULL, NULL),
(3503, 21, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 69, NULL, NULL),
(3504, 22, 'Осуществляется выписка электронных рецептов на лекарственные средства', 2, 69, NULL, NULL),
(3505, 23, 'Для врачей-специалистов структурного подразделения обеспечена доступность проведения телемедицинского консультирования, результаты которого документируются и находятся в медицинской карте ', 2, 69, NULL, NULL),
(3506, 24, 'Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 3, 69, NULL, NULL),
(3507, 25, 'Обеспечена доступность и условия для выполнения электрокардиограммы и оказания неотложной помощи в течение всего периода работы амбулаторно-поликлинической организации здравоохранения', 1, 69, NULL, NULL),
(3508, 26, 'В рамках получения пациентом кардиологической помощи, в случаях, предусмотренных клиническими протоколами диагностики и лечения, обеспечена возможность проведения консультаций врача-офтальмолога, врача-эндокринолога, врача-невролога, врача-хирурга, врача-кардиохирурга, врача-ангиохирурга, в том числе с использованием телемедицинских технологий, с использованием собственных ресурсов организации здравоохранения или по договорам с другими организациями (центрами коллективного пользования, специализированными центрами)', 1, 69, NULL, NULL),
(3509, 27, 'Обеспечена возможность проведения полного спектра лабораторных исследований, предусмотренных клиническими протоколами диагностики и лечения болезней системы кровообращения на амбулаторном этапе, с использованием собственных возможностей организации или по договорам с другими организациями здравоохранения (центрами коллективного пользования, специализированными центрами)', 1, 69, NULL, NULL),
(3510, 28, 'Обеспечена возможность проведения диагностических исследований, предусмотренных клиническими протоколами диагностики и лечения болезней системы кровообращения на амбулаторном этапе: эхокардиографии, холтеровского мониторирования, велоэргометрии или тредмил-теста, суточного мониторирования ЭКГ и артериального давления, ультразвукового исследования почек, сосудов, – с использованием собственных возможностей организации или по договорам с другими организациями здравоохранения (центрами коллективного пользования, специализированными центрами).\nСредние сроки ожидания перечисленных выше функциональных и диагностических исследований, выполняемых в плановом порядке при амбулаторном лечении, не превышают 4 недель от даты установления показаний к их проведению, если иное не предусмотрено по плану медицинского наблюдения пациента ', 1, 69, NULL, NULL),
(3511, 29, 'Обеспечено выполнение функции врачебной должности не менее 90% ', 2, 69, NULL, NULL),
(3512, 30, 'Количество выполненных плановых КАГ на 10 тысяч закрепленного населения не ниже среднеобластного показателя за предыдущий отчетный период ', 2, 69, NULL, NULL),
(3513, 31, 'Организация здравоохранения, осуществляющая организационно-методическое руководство деятельностью кардиологической службы региона, обеспечивает доступность проведения телемедицинского консультирования и (или) консилиума по заявкам территориальных организаций здравоохранения.\nФакт проведения консилиума и (или) телемедицинского консультирования документируется', 1, 69, NULL, NULL),
(3514, 32, 'Организация здравоохранения, осуществляющая организационно-методическое руководство деятельностью кардиологической службы региона, осуществляет планирование и проведение мероприятий по повышению уровня профессиональных знаний специалистов организаций здравоохранения курируемого региона. Проведение данных мероприятий документируется ', 1, 69, NULL, NULL),
(3515, 33, 'Планирование и анализ объемов оказанной специализированной помощи населению проводится в разрезе закрепленных территорий.\nПланирование и анализ объемов осуществляется с учетом обеспечения равной доступности населению всех закрепленных территорий', 1, 69, NULL, NULL),
(3516, 34, 'Организация здравоохранения, осуществляющая организационно-методическое руководство деятельностью кардиологической службы региона, организует работу по оказанию методической помощи закрепленным организациям здравоохранения, в т.ч. с выездом на места. Проведенные мероприятия документируются', 1, 69, NULL, NULL),
(3517, 35, 'Осуществляется взаимодействие и совместная работа с профильными кафедрами (университетами) согласно Положению о клинической организации здравоохранения, Положению об университетской клинике.\nСовместные мероприятия в рамках лечебно-диагностической, инновационной, научной деятельности, подбору кадров документируются', 1, 69, NULL, NULL),
(3546, 1, 'Деятельность структурных подразделений организации здравоохранения осуществляется в соответствии с положением о структурных подразделениях', 1, 68, NULL, NULL),
(3547, 2, 'Наличие и выполнение разработанной системы управления охраной труда, обеспечивающей идентификацию опасностей, оценку профессиональных рисков, определение мер управления профессиональными рисками и анализ их результативности', 1, 68, NULL, NULL),
(3548, 3, 'Наличие и выполнение общеобъектовой инструкции по пожарной безопасности. Определены лица, ответственные за пожарную безопасность, обеспечено обучение по пожарной безопасности', 1, 68, NULL, NULL),
(3549, 4, 'Наличие утвержденных руководителем организации здравоохранения локальных нормативных актов:\nноменклатура дел организации здравоохранения;\nкомплексный план основных организационных мероприятий;\nо режиме работы организации здравоохранения, структурных подразделений;\nо распределении обязанностей между заместителями руководителя;\nо трудовой и исполнительской дисциплине;\nправила внутреннего трудового распорядка', 1, 68, NULL, NULL),
(3550, 5, 'Анализ выполнения показателей деятельности организации здравоохранения (бизнес-плана предприятия)', 1, 68, NULL, NULL),
(3551, 6, 'Кабинет обеспечивает необходимые объемы оказания медицинской помощи по профилактике и лечению стоматологических заболеваний', 3, 68, NULL, NULL),
(3552, 7, 'Проведение в организации здравоохранения клинических конференций; наличие положения клинических конференциях, оформленных протоколов клинических конференций.', 2, 68, NULL, NULL),
(3553, 8, 'Наличие на рабочих местах врачей-специалистов клинических протоколов, соответствующих профилю оказываемой медицинской помощи', 1, 68, NULL, NULL),
(3554, 9, 'Планирование и осуществление мероприятий по обеспечению радиационной безопасности в соответствии с законодательством Республики Беларусь', 1, 68, NULL, NULL),
(3555, 10, 'Организована выписка рецептов врача в соответствии с Инструкцией о порядке выписывания рецепта врача и создания электронных рецептов врача, утвержденной постановлением Министерства здравоохранения Республики Беларусь от 31 октября 2007 г. № 99', 1, 68, NULL, NULL),
(3556, 11, 'Наличие на информационных стендах в организации здравоохранения информации:\n\nо режиме работы организации здравоохранения и структурных подразделений;\nправила внутреннего распорядка для пациентов;\nинформация о приеме граждан по личным вопросам руководством организации здравоохранения и вышестоящим руководством', 1, 68, NULL, NULL),
(3557, 12, 'Официальный интернет-сайт организации здравоохранения функционирует в порядке, установленном законодательством', 2, 68, NULL, NULL),
(3558, 13, 'Организация работы по защите персональных данных:\nполитика организации в отношении обработки персональных данных;\nприказ о назначении лица или структурного подразделения, ответственного за осуществление внутреннего контроля за обработкой персональных данных;\nналичие информированного согласия пациента на обработку персональных данных.', 2, 68, NULL, NULL),
(3559, 14, 'Организация работы комиссии по вопросам медицинской этики и деонтологии организации здравоохранения.', 2, 68, NULL, NULL),
(3560, 15, 'Работа по противодействию коррупции в организации здравоохранения осуществляется в соответствии с законодательством', 2, 68, NULL, NULL),
(3561, 16, 'Работа по осуществлению административных процедур организована в соответствии с законодательством ', 2, 68, NULL, NULL),
(3562, 17, 'Работа по обращениям граждан и юридических лиц организована в соответствии с законодательством', 2, 68, NULL, NULL),
(3563, 18, 'Территория, прилегающая к организации здравоохранения, и ее помещения оборудованы с учетом доступности для лиц с ограниченными возможностями:оборудование входных групп пандусами (подъемными платформами); наличие выделенных стоянок для автотранспортных средств лиц с ограниченными возможностями; наличие поручней, расширенных проемов (при наличии такой возможности при проведении текущего и (или) капитального ремонта или применение иных решений, обеспечивающих доступность для лиц с ограниченными возможностями)', 2, 68, NULL, NULL),
(3564, 19, 'Наличие в организации здравоохранения условий, позволяющих лицам с ограниченными возможностями получать медицинские услуги наравне с другими пациентами, включая: \nналичие и доступность санитарно-гигиенических помещений;\nдублирование надписей, знаков и иной текстовой и графической информации знаками, выполненными рельефно-точечным шрифтом Брайля;\nили наличие алгоритмов сопровождения лиц с ограниченными возможностями работниками организации здравоохранения', 2, 68, NULL, NULL),
(3565, 20, 'Наличие и функционирование в организации здравоохранения дистанционных способов взаимодействия с получателями медицинских услуг (электронных сервисов, мессенджеров, социальных сетей и пр.).', 2, 68, NULL, NULL),
(3566, 21, 'График работы врачей-специалистов обеспечивает доступность платной медицинской помощи по профилю заболевания.', 1, 68, NULL, NULL),
(3567, 22, 'В организации здравоохранения согласно графику работы учреждения обеспечено проведение рентгенологических исследований', 2, 68, NULL, NULL),
(3568, 23, 'Штатная численность должностей служащих (профессий рабочих) утверждена руководителем организации и является достаточной для оказания планируемых объемов медицинской помощи', 1, 68, NULL, NULL),
(3569, 24, 'Штатное расписание составляется и пересматривается ежегодно и (или) по мере необходимости, на основании анализа кадрового потенциала организации здравоохранения, фактического объема оказываемой медицинской помощи', 2, 68, NULL, NULL),
(3570, 25, 'В организации здравоохранения исполняются требования к занятию должностей служащих медицинских, фармацевтических работников, установленные Министерством здравоохранения Республики Беларусь', 2, 68, NULL, NULL),
(3571, 26, 'На каждую должность медицинского работника руководителем организации здравоохранения утверждена должностная инструкция с указанием квалификационных требований, функций по должности, прав и обязанностей медицинских работников', 1, 68, NULL, NULL),
(3572, 27, 'В организации здравоохранения проводится работа по обучению/повышению квалификации персонала (определяется потребность персонала в обучении/повышении квалификации, осуществляется планирование и контроль его прохождения)', 2, 68, NULL, NULL),
(3573, 28, 'В организации здравоохранения проводится работа по формированию, хранению личных дел персонала', 1, 68, NULL, NULL),
(3574, 29, 'Организована работа по проведению анкетирования работников организации здравоохранения (с частотой, определяемой руководителем организации здравоохранения) с целью изучения социальных вопросов, в том числе психологического климата в организации здравоохранения, справедливости материального стимулирования', 2, 68, NULL, NULL),
(3575, 30, 'В организации здравоохранения определены лица, ответственные за техническое обслуживание и ремонт медицинской техники.', 1, 68, NULL, NULL),
(3576, 31, 'В организации здравоохранения обеспечено ведение учета медицинской техники', 1, 68, NULL, NULL),
(3577, 32, 'Материально-техническая база организации здравоохранения соответствует табелю, утвержденному руководителем на основании примерного табеля оснащения, утвержденного приказом Министерства здравоохранения Республики Беларусь 16.11.2018 № 1180', 2, 68, NULL, NULL),
(3578, 33, 'Кабинет укомплектован изделиями медицинской техники и медицинского назначения в соответствии с табелем оснащения и планируемыми видами и объемами оказания медицинской помощи', 3, 68, NULL, NULL),
(3579, 34, 'Наличие своевременной государственной поверки средств измерений', 2, 68, NULL, NULL),
(3580, 35, 'Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и (или) ремонтом. Техническое обслуживание и (или) ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на выполнение данных услуг', 1, 68, NULL, NULL),
(3581, 36, 'Проводится и документируется обучение медицинских работников правилам эксплуатации медицинской техники при вводе в эксплуатацию', 2, 68, NULL, NULL),
(3582, 37, 'Обеспечена эффективность использования медицинской техники; отсутствуют случае необоснованного простоя', 1, 68, NULL, NULL),
(3583, 38, 'Обеспечена информатизация организации здравоохранения: обеспечение информатизации рабочих мест (наличие персонального компьютера, электронной цифровой подписи);\nобеспечение медицинской информационной системой;\nвнедрение системы межведомственного документооборота;\nосуществляется ведение электронной медицинской карты пациента ', 2, 68, NULL, NULL),
(3584, 39, 'Регистратура оснащена персональными компьютерами, рабочие места медицинских регистраторов автоматизированы', 2, 68, NULL, NULL),
(3585, 40, 'Наличие алгоритмов действий медицинских регистраторов регистратуры в различных ситуациях', 1, 68, NULL, NULL),
(3586, 41, 'Эффективное распределение потоков пациентов посредством визуальной маршрутизации по отделениям, кабинетам и службам.', 1, 68, NULL, NULL),
(3587, 42, 'Наличие предварительной записи на прием к врачам-специалистам через интернет посредством медицинских информационных систем', 2, 68, NULL, NULL),
(3588, 43, 'Наличие возможности записи на повторный прием в кабинете врача-специалиста.', 3, 68, NULL, NULL),
(3589, 44, 'Оказание квалифицированной первичной и специализированной медицинской помощи пациентам по профилям заболеваний, состояниям, синдромам на основании клинических протоколов, а также иных нормативных правовых актов, утвержденных Министерством здравоохранения Республики Беларусь или методов оказания медицинской помощи.', 1, 68, NULL, NULL),
(3590, 45, 'Организация работы по раннему выявлению злокачественных новообразований:\nпроводятся профилактические онкологические осмотры по выявлению предопухолевых и опухолевых заболеваний в соответствии с Инструкцией, утвержденной Министерством здравоохранения Республики Беларусь;\nобеспечена преемственность с другими организациями здравоохранения в оказании медицинской помощи пациентам с предопухолевой патологией и злокачественными новообразованиями с учетом этапности оказания онкологической помощи', 1, 68, NULL, NULL),
(3591, 46, 'Осуществление необходимого документооборота с другими организациями здравоохранения в целях обеспечения преемственности в оказании медицинской помощи населению:\nоформление направлений на стационарное лечение, консультации врачей-специалистов, справок о состоянии здоровья и выписок из медицинских документов в другие организации здравоохранения;\nпредоставление эпикризов стационарного лечения и заключений врачебных консультаций, справок о состоянии здоровья и выписок из медицинских документов из других организаций здравоохранения.', 2, 68, NULL, NULL),
(3592, 47, 'Оформление медицинских документов осуществляется по установленным формам, в соответствии с требованиями нормативных правовых актов Министерства здравоохранения Республики Беларусь.', 1, 68, NULL, NULL),
(3593, 48, 'Медицинские осмотры пациентов проводятся в соответствии с Инструкцией о порядке проведения медицинских осмотров с оформлением записи в медицинских документах. ', 1, 68, NULL, NULL),
(3594, 49, 'Имеется согласие или отказ пациента или лиц, указанных в части второй статьи 18 Закона Республики Беларусь «О здравоохранении», на проведение простых и (или) сложных медицинских вмешательств, оформленный в соответствии с нормативными правовыми актами Республики Беларусь', 2, 68, NULL, NULL),
(3595, 50, 'В организации здравоохранения имеется локальный правовой акт, регулирующий порядок организации оказания экстренной и (или) неотложной медицинской помощи. Утверждены алгоритмы оказания экстренной медицинской помощи.', 1, 68, NULL, NULL),
(3596, 51, 'Определены лица, осуществляющие контроль за наличием необходимых лекарственных препаратов, медицинских изделий для оказания экстренной и (или) неотложной медицинской помощи, своевременное их пополнение и соблюдение сроков годности', 1, 68, NULL, NULL),
(3597, 52, 'Имеются лекарственные препараты и медицинские изделия для оказания экстренной и (или) неотложной медицинской помощи в соответствии с требованиями клинических протоколов', 1, 68, NULL, NULL),
(3598, 53, 'Проводятся занятия с медицинскими работниками по освоению теоретических и практических навыков оказания экстренной и (или) неотложной медицинской помощи с последующим контролем знаний с частотой, определяемой руководителем организации, но не реже одного раза в год', 1, 68, NULL, NULL),
(3599, 54, 'В организации здравоохранения соблюдается порядок организации и проведения экспертизы качества медицинской помощи (далее – экспертиза качества), оценки качества медицинской помощи и медицинских экспертиз (далее – оценка качества)', 1, 68, NULL, NULL),
(3600, 55, 'В организации здравоохранения определены лица, ответственные за организацию и проведение экспертизы качества, оценки качества', 1, 68, NULL, NULL),
(3601, 56, 'Оценка качества в структурных подразделениях проводится в соответствии с планом, утвержденным руководителем организации здравоохранения', 1, 68, NULL, NULL),
(3602, 57, 'По результатам экспертизы качества и (или) оценки качества оформляется заключение', 1, 68, NULL, NULL),
(3603, 58, 'Результаты экспертизы качества, оценки качества рассматриваются на клинических конференциях, принимаются меры по устранению причин и условий, повлекших снижение качества медицинской помощи, медицинских экспертиз', 1, 68, NULL, NULL),
(3604, 59, 'Разработана и внедрена программа производственного и (или) инфекционного контроля в соответствии с законодательством', 2, 68, NULL, NULL),
(3605, 60, 'Своевременное выполнение предписаний по устранению нарушений санитарно-эпидемиологического режима в организации здравоохранения ', 2, 68, NULL, NULL),
(3606, 61, 'В организации здравоохранения проводится техническое обслуживание, текущий, капитальный ремонт зданий и помещений организаций, инженерных систем, в том числе систем отопления, горячего и холодного водоснабжения, водоотведения (канализации), вентиляции, санитарно-технического оборудования в зависимости от их санитарно-технического состояния в соответствии с планом мероприятий, разработанным и утвержденным руководителем организации, и с учетом дефектного акта и (или) проектной документации в случаях, когда их разработка (составление) предусмотрена законодательством в области архитектурной, градостроительной и строительной деятельности.', 2, 68, NULL, NULL),
(3607, 62, 'Дезинфекция, стерилизация проводятся в соответствии с законодательными актами Республики Беларусь.', 1, 68, NULL, NULL),
(3608, 63, 'В наличии имеется достаточное количество средств индивидуальной защиты, антисептиков и дезинфектантов', 1, 68, NULL, NULL),
(3609, 64, 'Утвержден и внедрен порядок действий работников при аварийном контакте с биологическим материалом пациента, загрязнении биологическим материалом объектов внешней среды', 1, 68, NULL, NULL),
(3610, 65, 'Информация о выявленных инфекционных заболеваниях своевременно предоставляется в территориальные центры гигиены и эпидемиологии', 1, 68, NULL, NULL),
(3611, 66, 'Осуществляется регистрация всех выявленных инфекций, связанных с оказанием медицинской помощи, с проведением анализа и принятием управленческих решений', 1, 68, NULL, NULL),
(3612, 67, 'Обеспечено безопасное обращение с медицинскими отходами, классификация всех отходов, образуемых в медицинской организации, а также их своевременная утилизация.', 1, 68, NULL, NULL),
(3613, 68, 'Разработана и внедрена программа производственного и (или) инфекционного контроля в соответствии с законодательством', 2, 68, NULL, NULL),
(3614, 69, 'Своевременное выполнение предписаний по устранению нарушений санитарно-эпидемиологического режима в организации здравоохранения ', 2, 68, NULL, NULL),
(3615, 70, 'В организации здравоохранения проводится техническое обслуживание, текущий, капитальный ремонт зданий и помещений организаций, инженерных систем, в том числе систем отопления, горячего и холодного водоснабжения, водоотведения (канализации), вентиляции, санитарно-технического оборудования в зависимости от их санитарно-технического состояния в соответствии с планом мероприятий, разработанным и утвержденным руководителем организации, и с учетом дефектного акта и (или) проектной документации в случаях, когда их разработка (составление) предусмотрена законодательством в области архитектурной, градостроительной и строительной деятельности.', 2, 68, NULL, NULL),
(3616, 71, 'Дезинфекция, стерилизация проводятся в соответствии с законодательными актами Республики Беларусь.', 1, 68, NULL, NULL),
(3617, 72, 'В наличии имеется достаточное количество средств индивидуальной защиты, антисептиков и дезинфектантов', 1, 68, NULL, NULL),
(3618, 73, 'Утвержден и внедрен порядок действий работников при аварийном контакте с биологическим материалом пациента, загрязнении биологическим материалом объектов внешней среды', 1, 68, NULL, NULL),
(3673, 1, 'Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 70, NULL, NULL),
(3674, 2, 'Руководителем организации здравоохранения определены ответственные лица за организацию оказания неврологической помощи в учреждении здравоохранения', 3, 70, NULL, NULL),
(3675, 3, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения', 3, 70, NULL, NULL),
(3676, 4, 'Укомплектованность структурного подразделения врачами-неврологами, врачами-неврологами детскими не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей-неврологов укомплектованность не менее 96 % по занятым должностям', 1, 70, NULL, NULL),
(3677, 5, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 70, NULL, NULL),
(3678, 6, 'Наличие квалификационных категорий у врачей-неврологов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 70, NULL, NULL),
(3679, 7, 'Имеется должностная инструкция врачу-неврологу, утвержденная руководителем организации здравоохранения, с указанием квалификационных требований (образование, обучение, знания, навыки и опыт) и функций, специфичных для данной должности', 2, 70, NULL, NULL),
(3680, 8, 'Медицинские работники неврологического кабинета (отделения) проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев. Медицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 70, NULL, NULL),
(3681, 9, 'Медицинские работники неврологического кабинета (отделения) на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков. Медицинские работники неврологического отделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 70, NULL, NULL),
(3682, 10, 'Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 70, NULL, NULL),
(3683, 11, 'Кабинет врача-невролога (неврологическое отделение) оснащен изделиями медицинского назначения и медицинской техникой в соответствии с Примерным табелем оснащения, установленным Министерством здравоохранения или табелем оснащения, установленным ЛПА, в объеме, достаточном для оказания специализированной медицинской помощи пациентам неврологического профиля', 3, 70, NULL, NULL),
(3684, 12, 'В организации здравоохранения на пациента оформляется медицинская карта амбулаторного больного по форме, установленной Министерством здравоохранения Республики Беларусь и (или) иные медицинские документы, установленные ЛПА ', 2, 70, NULL, NULL),
(3685, 13, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 70, NULL, NULL),
(3686, 14, 'Осуществляется выписка электронных рецептов на лекарственные средства', 2, 70, NULL, NULL),
(3687, 15, 'Для врачей-специалистов структурного подразделения обеспечена доступность проведения телемедицинского консультирования, результаты которого документируется и находится в медицинской карте', 2, 70, NULL, NULL),
(3688, 16, 'Работа структурного подразделения обеспечена в сменном режиме', 2, 70, NULL, NULL),
(3689, 17, 'Обеспечена доступность выполнения лабораторных методов диагностики для пациентов неврологического профиля согласно клиническому протоколу ', 2, 70, NULL, NULL),
(3690, 18, 'Обеспечена доступность проведения плановых инструментальных исследований, в том числе УЗИ БЦА, КТ, МРТ головного и спинного мозга, электроэнцефалографии, электронейромиографии согласно клиническому протоколу, определен порядок направления на эти диагностические исследования', 2, 70, NULL, NULL),
(3691, 19, 'Обеспечено направление пациентов с пароксизмальными состояниями (эпилепсией), миастенией, дистонией, рассеянным склерозом на консультацию в областной (городской) и (или) Республиканский специализированный центр ', 2, 70, NULL, NULL),
(3692, 20, 'Для пациентов неврологического профиля обеспечена доступность лечения в условиях отделения дневного пребывания согласно клиническому протоколу, определен порядок направления в ОДП', 3, 70, NULL, NULL),
(3693, 21, 'В организации здравоохранения определен порядок направления на плановую и экстренную госпитализацию пациентов неврологического профиля ', 3, 70, NULL, NULL),
(3694, 22, 'Обеспечено назначение лечения пациентов неврологического профиля согласно клиническому протоколу', 2, 70, NULL, NULL),
(3695, 23, 'Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 70, NULL, NULL),
(3696, 24, 'Руководителем организации здравоохранения определены ответственные лица за организацию оказания неврологической помощи в учреждении здравоохранения', 3, 70, NULL, NULL),
(3697, 25, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения', 3, 70, NULL, NULL),
(3698, 26, 'Норматив численности врачей-неврологов соответствует Штатным нормативам численности должностей врачей-специалистов для оказания медицинской помощи в амбулаторных условиях, установленным Министерством здравоохранения ', 1, 70, NULL, NULL),
(3699, 27, 'Укомплектованность структурного подразделения врачами-неврологами, врачами-неврологами детскими не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей врачей-неврологов укомплектованность не менее 96 % по занятым должностям', 1, 70, NULL, NULL),
(3700, 28, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям ', 1, 70, NULL, NULL),
(3701, 29, 'Наличие квалификационных категорий у врачей-неврологов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 70, NULL, NULL),
(3702, 30, 'Имеется должностная инструкция врачу-неврологу, утвержденная руководителем организации здравоохранения, с указанием квалификационных требований (образование, обучение, знания, навыки и опыт) и функций, специфичных для данной должности', 2, 70, NULL, NULL),
(3703, 31, 'Кабинет врача-невролога (неврологическое отделение) оснащен изделиями медицинского назначения и медицинской техникой в соответствии с Примерным табелем оснащения, установленным Министерством здравоохранения или табелем оснащения, установленным ЛПА, в объеме, достаточном для оказания специализированной медицинской помощи пациентам неврологического профиля', 3, 70, NULL, NULL),
(3704, 32, 'В организации здравоохранения на пациента оформляется медицинская карта амбулаторного больного по форме, установленной Министерством здравоохранения Республики Беларусь и (или) иные медицинские документы, установленные ЛПА ', 2, 70, NULL, NULL),
(3705, 33, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 70, NULL, NULL),
(3706, 34, 'Осуществляется выписка электронных рецептов на лекарственные средства', 2, 70, NULL, NULL),
(3707, 35, 'В организации здравоохранения функционируют консультативные центры по отдельным направлениям (для пациентов с пароксизмальными состояниями (эпилепсией), миастенией, дистонией, рассеянным склерозом)', 3, 70, NULL, NULL),
(3708, 36, 'В организации здравоохранения обеспечено проведение плановых лабораторных, инструментальных исследований (ЭЭГ, электронейромиография, КТ или МРТ) и консультаций других специалистов в соответствии с показаниями и клиническим протоколом или определен порядок направления на эти исследования (консультации) при невозможности их выполнения в данной организации здравоохранения', 2, 70, NULL, NULL),
(3709, 37, 'Обеспечено назначение лечения пациентов неврологического профиля согласно клиническому протоколу', 2, 70, NULL, NULL),
(3710, 38, 'В организации здравоохранения определен порядок направления на плановую и экстренную госпитализацию пациентов неврологического профиля ', 3, 70, NULL, NULL),
(3711, 39, 'Наличие в организации здравоохранения консультативно-поликлинического отделения ', 1, 70, NULL, NULL),
(3712, 40, 'Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 70, NULL, NULL),
(3713, 41, 'Руководителем организации здравоохранения определены ответственные лица за организацию оказания неврологической помощи в учреждении здравоохранения', 3, 70, NULL, NULL),
(3714, 42, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения', 3, 70, NULL, NULL),
(3715, 43, 'Укомплектованность структурного подразделения врачами-неврологами, врачами-неврологами детскими не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей врачей-неврологов укомплектованность не менее 96 % по занятым должностям', 1, 70, NULL, NULL),
(3716, 44, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям ', 1, 70, NULL, NULL),
(3717, 45, 'Наличие квалификационных категорий у врачей-неврологов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 70, NULL, NULL),
(3718, 46, 'Имеется должностная инструкция врачу-неврологу, утвержденная руководителем организации здравоохранения, с указанием квалификационных требований (образование, обучение, знания, навыки и опыт) и функций, специфичных для данной должности', 2, 70, NULL, NULL),
(3719, 47, 'Кабинет врача-невролога оснащен изделиями медицинского назначения и медицинской техникой в соответствии с Примерным табелем оснащения, установленным Министерством здравоохранения или табелем оснащения, установленным ЛПА, в объеме, достаточном для оказания специализированной медицинской помощи пациентам неврологического профиля', 3, 70, NULL, NULL),
(3720, 48, 'В организации здравоохранения на пациента оформляется медицинская карта амбулаторного больного по форме, установленной Министерством здравоохранения Республики Беларусь и (или) иные медицинские документы, установленные ЛПА ', 2, 70, NULL, NULL),
(3721, 49, 'В организации здравоохранения функционируют консультативные центры по отдельным направлениям (для пациентов с пароксизмальными состояниями (эпилепсией), миастенией, дистонией, рассеянным склерозом)', 3, 70, NULL, NULL),
(3722, 50, 'В организации здравоохранения обеспечено проведение плановых лабораторных, инструментальных исследований (ЭЭГ, электронейромиография, КТ или МРТ и консультаций других специалистов в соответствии с показаниями и клиническим протоколом', 2, 70, NULL, NULL),
(3723, 51, 'В организации здравоохранения обеспечено оказание методической помощи иным организациям здравоохранения по вопросам оказания медицинской помощи пациентам неврологического профиля ', 3, 70, NULL, NULL),
(3724, 52, 'Обеспечено назначение лечения пациентов неврологического профиля согласно клиническому протоколу', 2, 70, NULL, NULL),
(3736, 1, 'Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 72, NULL, NULL),
(3737, 2, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей. \nРезультаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по травматологии.\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 72, NULL, NULL),
(3738, 3, 'Обеспечение безбарьерной среды в помещениях учреждения для пациентов, использующих средства индивидуальной мобильности', 2, 72, NULL, NULL),
(3739, 4, 'Укомплектованность структурного подразделения врачами-специалистами не менее 75 % по физическим лицам (для городских поликлиник).\nНаличие врача-специалиста (для районных поликлиник). При наличии в штатном расписании неполных должностей врачей-травматологов укомплектованность не менее 96 % по занятым должностям', 1, 72, NULL, NULL),
(3740, 5, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям ', 1, 72, NULL, NULL),
(3741, 6, 'Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего ', 1, 72, NULL, NULL),
(3742, 7, 'Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 72, NULL, NULL),
(3743, 8, 'Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, с частотой, определяемой руководителем организации. \nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 72, NULL, NULL),
(3744, 9, 'Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков. \nМедицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи ', 3, 72, NULL, NULL),
(3745, 10, 'Минимальный состав и площади отдельных помещений структурного подразделения соответствуют приложению 1 к санитарным нормам и правилам «Санитарно-эпидемиологические требования к организациям, оказывающим медицинскую помощь, в том числе к организациям и проведению санитарно-противоэпидемических мероприятий по профилактике инфекционных заболеваний в этих организациях», утвержденным постановлением Министерства здравоохранения от 5 июля 2017 г. № 73', 1, 72, NULL, NULL),
(3746, 11, 'Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 72, NULL, NULL),
(3747, 12, 'Структурное подразделение оснащено изделиями медицинского назначения и медицинской техникой в объеме, достаточном для оказания специализированной медицинской помощи по профилю травматология и ортопедия для амбулаторно-поликлинических организаций здравоохранения ', 2, 72, NULL, NULL),
(3748, 13, 'В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники.\nПроведение обучения документируется', 3, 72, NULL, NULL),
(3749, 14, 'Порядок оказания медицинской помощи в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь.\nСоблюдается порядок (алгоритмы) оказания скорой и плановой медицинской помощи по травматологии', 2, 72, NULL, NULL),
(3750, 15, 'Работа структурного подразделения обеспечена в сменном режиме ', 2, 72, NULL, NULL),
(3751, 16, 'В структурном подразделении в обязательном порядке осуществляется направление операционного (биопсийного) материала и биологических жидкостей на патогистологическое (бактериологическое) исследование', 1, 72, NULL, NULL),
(3752, 17, 'Организация здравоохранения обеспечивает:\nсвоевременный прием / осмотр пациентов с травмой легкой степени или с обострением хронического заболевания опорно-двигательного аппарата в кабинете травматолога-ортопеда. Пациентов с острой травмой, нуждающихся в госпитализации при самостоятельном обращении, направляют в другие профильные организации здравоохранения после осмотра пациентов и оказания первой медицинской помощи', 2, 72, NULL, NULL),
(3753, 18, 'При первичном приеме / осмотре пациента с травмой или с заболеванием опорно-двигательного аппарата проводится сбор жалоб, анамнеза, аллергологический, объективный и локальный статус с определением предварительного диагноза', 2, 72, NULL, NULL),
(3754, 19, 'Соблюдается порядок медицинского наблюдения пациентов с травмами и ортопедическими заболеваниями в амбулаторных условиях. Руководителем структурного подразделения осуществляется анализ результатов медицинского наблюдения пациентов', 1, 72, NULL, NULL),
(3755, 20, 'Обеспечена преемственность с больничными организациями здравоохранения. Определен порядок направления на плановую и экстренную госпитализацию пациентов травматологического и ортопедического профиля. Обеспечено выполнение на амбулаторном этапе рекомендаций по дальнейшему медицинскому наблюдению после выписки ', 2, 72, NULL, NULL),
(3756, 21, 'Обеспечена возможность консультаций врачей-специалистов в соответствии с клиническими протоколами диагностики и лечения (в организации здравоохранения или определен порядок направления в другие организации здравоохранения)', 1, 72, NULL, NULL),
(3757, 22, 'Обеспечена возможность проведения лабораторных исследований: в соответствии с клиническими протоколами диагностики и лечения', 3, 72, NULL, NULL),
(3758, 23, 'В организации здравоохранения обеспечено проведение рентгенологических исследований', 2, 72, NULL, NULL),
(3759, 24, 'В организации здравоохранения имеется установленный порядок направления пациентов на КТ, МРТ исследования в другие УЗ', 2, 72, NULL, NULL),
(3760, 25, 'Обеспечено назначение лечения пациентам в амбулаторных условиях согласно клиническим протоколам', 1, 72, NULL, NULL),
(3761, 26, 'В структурном подразделении обеспечена возможность работы врача для выполнения хирургических вмешательств в специализированных помещениях (операционной) (по графику работы)', 2, 72, NULL, NULL),
(3762, 27, 'В медицинской карте пациента, получающего медицинскую помощь в амбулаторных условиях, указываются обоснование оперативного вмешательства с учетом установленного диагноза', 3, 72, NULL, NULL),
(3763, 28, 'Протоколы хирургических вмешательств оформляются в журнале записи оперативных вмешательств', 3, 72, NULL, NULL),
(3764, 29, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 72, NULL, NULL),
(3765, 30, 'Осуществляется выписка электронных рецептов на лекарственные средства', 2, 72, NULL, NULL),
(3766, 31, 'Для врачей-специалистов структурного подразделения обеспечена доступность проведения телемедицинского консультирования, результаты которого документируется и находится в медицинской карте ', 2, 72, NULL, NULL),
(3767, 32, 'Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 3, 72, NULL, NULL),
(3768, 33, 'В организации здравоохранения проводится анализ (разбор) выхода пациентов с травмой или заболеваниями опорно-двигательного аппарата на инвалидность', 2, 72, NULL, NULL),
(3769, 34, 'В структуре организации здравоохранения имеется физиотерапевтическое (реабилитационное) отделение, имеется установленный порядок для проведения реабилитации в травматологическом отделении других УЗ', 2, 72, NULL, NULL),
(3770, 35, 'Организация здравоохранения имеет необходимые условия и перечень медицинского оборудования для проведения этапа реабилитации пациентам травматологического и ортопедического профиля.', 2, 72, NULL, NULL),
(3771, 36, 'Организация здравоохранения проводит обучение медицинского персонала по современным технологиям оказания реабилитационной помощи травматологическим и ортопедическим пациентам', 2, 72, NULL, NULL),
(3772, 37, 'Организация здравоохранения обеспечивает индивидуальный комплексный план реабилитации для пациентов с травмой и заболеванием опорно-двигательного аппарата', 2, 72, NULL, NULL),
(3773, 38, 'Организация здравоохранения обеспечивает контроль реализации плана реабилитации и внесение необходимых корректировок для повышения и улучшения качества жизни пациентов', 2, 72, NULL, NULL),
(3774, 39, 'Хирургическая активность не менее 30 %.', 2, 72, NULL, NULL),
(3775, 40, 'Обеспечено выполнение функции врачебной должности не менее 90% ', 2, 72, NULL, NULL),
(3799, 1, 'Деятельность организации здравоохранения (структурного подразделения) осуществляется в соответствии с Положением об организации (структурном подразделении). Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении и имеют постоянный доступ к его содержанию', 3, 74, NULL, NULL),
(3800, 2, 'Руководителем организации здравоохранения определены ответственные лица за организацию оказания онкологической    помощи', 3, 74, NULL, NULL),
(3801, 3, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, результаты работы рассматриваются на медицинских советах, производственных совещаниях, принимаются меры по устранению недостатков', 2, 74, NULL, NULL),
(3802, 4, 'Квалификация медицинских работников структурного подразделения соответствует требованиям должностной инструкции к занимаемой должности сотрудника. Соблюдены требования к занятию должностей медицинских, фармацевтических и иных работников', 2, 74, NULL, NULL),
(3803, 5, 'Укомплектованность структурного подразделения врачами не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей врачей укомплектованность не менее 96 % по занятым должностям', 1, 74, NULL, NULL),
(3804, 6, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное образование, не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 74, NULL, NULL),
(3805, 7, 'Наличие квалификационных категорий у врачей, специалистов со средним медицинским образованием в организации здравоохранения (структурного подразделения) – 100 % от лиц, подлежащих профессиональной аттестации', 2, 74, NULL, NULL),
(3806, 8, 'Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи, купированию болевых синдромов с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев.\nМедицинские работники владеют соответствующими навыками при проведении реанимационных мероприятий', 1, 74, NULL, NULL),
(3807, 9, 'Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков, имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 74, NULL, NULL);
INSERT INTO `mark` (`id_mark`, `str_num`, `mark_name`, `mark_class`, `id_criteria`, `date_close`, `date_open`) VALUES
(3808, 10, 'Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 74, NULL, NULL),
(3809, 11, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 74, NULL, NULL),
(3810, 12, 'В организации здравоохранения созданы условия для лиц с ограниченными возможностями: имеются кресла-коляски, коридоры оборудованы поручнями, перилами, информационными и указательными знаками, имеются палаты, туалеты, оборудованные для лиц с ограниченными возможностями. Работниками организации здравоохранения оказывается ситуационная помощь, согласно разработанным локальным правовым актам', 2, 74, NULL, NULL),
(3811, 13, 'Структурное подразделение оснащено изделиями медицинского назначения и медицинской техникой в соответствии с Примерным табелем оснащения, установленным Министерством здравоохранения или табелем оснащения, установленным локальным правовым актом, в объеме, достаточном для оказания специализированной медицинской помощи пациентам с ЗНО различных локализаций', 2, 74, NULL, NULL),
(3812, 14, 'Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 74, NULL, NULL),
(3813, 15, 'В структурном подразделении определены лица, ответственные за техническое обслуживание и ремонт медицинской техники', 3, 74, NULL, NULL),
(3814, 16, 'В структурном подразделении ведется учет медицинской техники', 3, 74, NULL, NULL),
(3815, 17, 'Проводится и документируется обучение медицинских работников правилам эксплуатации медицинской техники при вводе в эксплуатацию', 2, 74, NULL, NULL),
(3816, 18, 'В организации здравоохранения медицинская помощь оказывается с учетом уровня оказываемой медицинской помощи в рамках протоколов диагностики и лечения злокачественных новообразований (ЗНО), а также паллиативной медицинской помощи', 1, 74, NULL, NULL),
(3817, 19, 'Организация здравоохранения обеспечена необходимыми лекарственными средствами и медицинскими изделиями в соответствии с установленными требованиями оказания медицинской помощи по онкологии и лучевой терапии (при наличии оборудования)', 1, 74, NULL, NULL),
(3818, 20, 'В организации здравоохранения на пациента оформляется медицинская карта амбулаторного пациента по форме, установленной Министерством здравоохранения Республики Беларусь и (или) иные медицинские документы, установленные ЛПА', 2, 74, NULL, NULL),
(3819, 21, 'Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 2, 74, NULL, NULL),
(3820, 22, 'Осуществляется организационно-методическая работа по принципу прямой и обратной связи с АПО и районными онкологами. Процесс документируется (отчеты, формы 30-у\\Ф, 90-у\\Ф). Осуществляется анализ организации и проведения медицинского наблюдения онкологических пациентов в соответствии с требованиями законодательства', 2, 74, NULL, NULL),
(3821, 23, 'На регулярной основе производится анализ запущенности онкопатологии с разбором каждого случая. Процесс документируется с выделением причин и мероприятий по улучшению качества своевременной диагностики ЗНО. На регулярной основе производится мониторинг соблюдения сроков обследования пациентов с подозрением на ЗНО и сроков начала лечения с момента верификации диагноза', 2, 74, NULL, NULL),
(3822, 24, 'Отработана система направления пациентов с ЗНО для обследования и лечения в организации здравоохранения республиканского уровня или медицинские организации онкологического профиля других областей (по желанию или потребностям пациента).', 2, 74, NULL, NULL),
(3823, 25, 'Осуществляется взаимосвязь с высокотехнологичными центрами республиканского уровня (Республиканская молекулярно-генетическая лаборатория канцерогенеза,  Республиканский центр позитронно-эмиссионной томографии).', 2, 74, NULL, NULL),
(3824, 26, 'Обеспечена доступность проведения телемедицинского консультирования, результаты которого документируются\n и находятся в медицинской карте', 2, 74, NULL, NULL),
(3825, 27, 'Имеется возможность проведения морфологического (гистологического и цитологического), в т.ч. срочного и иммуногистохимического исследований в соответствии с порядком и перечнем, утвержденным протоколами диагностики и лечения ЗНО', 1, 74, NULL, NULL),
(3826, 28, 'Решения мультидисциплинарных групп (при наличии), врачебных консультаций (консилиумов) оформляются в соответствии с требованиями Инструкции о порядке проведения врачебных консультаций (консилиумов).', 1, 74, NULL, NULL),
(3827, 29, 'Наличие в организации здравоохранения организационно-методического отделения (кабинета) с группой канцер-регистра', 1, 74, NULL, NULL),
(3828, 30, 'Наличие АИС в организации здравоохранения и доступа к сети Интернет', 1, 74, NULL, NULL),
(3829, 31, 'Созданы условия для обращения с противоопухолевыми лекарственными средствами (ПЛС): 1. Наличие централизованного отделения либо спец. помещения, оснащенного вытяжными шкафами и расходными материалами для работы с ПЛС', 1, 74, NULL, NULL),
(3830, 32, 'Наличие выделенного и обученного персонала для работы с ПЛС, в должностные обязанности которого входит разведение и использование данных ПЛС.', 1, 74, NULL, NULL),
(3831, 33, 'Наличие системы обращения с отходами категории В (учет, временное хранение утилизация)', 1, 74, NULL, NULL),
(3832, 34, 'Наличие расходных материалов для работы с различными видами ПЛС', 1, 74, NULL, NULL),
(3833, 35, 'Наличие персонала, имеющего соответствующую подготовку для оказания химиотерапевтической помощи ХТ, пациентам ХТ профиля, подтвержденную документально', 1, 74, NULL, NULL),
(3834, 36, 'Наличие диагностических и лечебных возможностей, для своевременного выявления и оказания помощи при развитии осложнений от проведения ПЛС - терапии ', 2, 74, NULL, NULL),
(3835, 37, 'Имеется необходимый набор помещений для оказания ХТ- помощи в амбулаторных условиях ((*)- при наличии)', 2, 74, NULL, NULL),
(3836, 38, 'Наличие коечного фонда, обеспеченного круглосуточным наблюдением врачебного, сестринского и иного медицинского персонала', 2, 74, NULL, NULL),
(3837, 39, 'Наличие возможности круглосуточного выполнения лабораторно-инструментальных диагностических методов исследования, включая возможность привлечение мед.персонала (дежурство на дому (*)', 2, 74, NULL, NULL),
(3838, 40, 'Имеется отчетная форма медицинских документов, фиксирующая все аспекты проведения ПЛС - терапии (идентификация пациента, дозы, времени, способа введения ПЛС, посттерапевтическая реакция на ПЛС)', 1, 74, NULL, NULL),
(3839, 41, 'Обязательное наличие обоснований /проведение консилиумов и др./ при использовании нестандартных схем ПЛС – терапии.', 1, 74, NULL, NULL),
(3840, 42, 'Лучевая терапия проводится пациентам по показаниям в соответствии с клиническими протоколами с учетом индивидуальных противопоказаний', 1, 74, NULL, NULL),
(3841, 43, 'В медицинской документации имеется информация о лучевой терапии в соответствии с утвержденными клиническими протоколами и методами (указаны область облучения, разовая и суммарная дозы, режим фракционирования, дозовые нагрузки на органы риска и прочее), на бумажном носителе либо в электронном виде', 1, 74, NULL, NULL),
(3842, 44, 'Созданы условия для проведения лучевой терапии в амбулаторных и (или) стационарных условиях, условиях отделения дневного пребывания (при наличии)', 2, 74, NULL, NULL),
(3843, 45, 'Квалификация медицинских и прочих работников, занятых в организации оказания данного вида помощи, соответствует занимаемой должности.', 1, 74, NULL, NULL),
(3844, 46, 'Для поддержания работоспособности и обеспечения контроля качества работы оборудования для лучевой терапии имеются соответствующие специалисты (инженеры, медицинские физики, техники и т.д.), оборудование и программное обеспечение', 2, 74, NULL, NULL),
(3845, 47, 'Персонал, обеспечивающий проведение предлучевой подготовки, планирование облучения, дозиметрический контроль, поддержание работоспособности и обеспечение контроля качества работы оборудования (врачи-рентгенологи, рентгенолаборанты, техники, медицинские физики, инженеры и т.д.), входит в состав радиологического отделения, или является самостоятельным структурным подразделением', 2, 74, NULL, NULL),
(3846, 48, 'Техническое оснащение, размещение и оборудование помещений отделения лучевой терапии радиотерапевтическими установками, топометрическим и дозиметрическим оборудованием соответствует требованиям законодательства', 1, 74, NULL, NULL),
(3847, 49, 'Медицинская техника и медицинское оборудование, применяемое в лучевой терапии, обеспечены техническим обслуживанием и (или) ремонтом в соответствии с действующим законодательством.', 1, 74, NULL, NULL),
(3848, 50, 'Разработана и утверждена программа контроля качества работы источников ионизирующего излучения, применяемых в лучевой терапии', 1, 74, NULL, NULL),
(3849, 51, 'Процедуры технического обслуживания и контроля качества работы оборудования оформляются и хранятся в установленном порядке (на бумажном либо электронном носителе)', 2, 74, NULL, NULL),
(3850, 52, 'Руководителем организации здравоохранения определены ответственные лица в области обеспечения радиационной безопасности, имеются ЛПА по радиационной безопасности', 1, 74, NULL, NULL),
(3851, 53, 'Сотрудники, осуществляющие работы с источниками ионизирующего излучения, а также сотрудники, находящиеся по условиям труда в зоне воздействия источников ионизирующего излучения отнесены к категории облучаемых лиц «персонал».', 1, 74, NULL, NULL),
(3852, 54, 'Проводится периодическая проверка (оценка) знаний персонала по вопросам обеспечения радиационной безопасности', 1, 74, NULL, NULL),
(3853, 55, 'Сотрудники, отнесенные к категории облучаемых лиц «персонал», обеспечены индивидуальными дозиметрами.', 1, 74, NULL, NULL),
(3854, 56, 'Ведется учет доз облучения персонала согласно действующему законодательству.', 1, 74, NULL, NULL),
(3855, 57, 'Наличие кабинета врача-онколога, оснащенного необходимым оборудованием для приема пациентов и хранения медицинской документации, а также персональным компьютером, подключенным к сети Интернет и доступом к базе Белорусского канцер-регистра.', 1, 74, NULL, NULL),
(3856, 58, 'Врач-онколог кабинета – врач специалист с высшим медицинским образованием по специальности «лечебное дело», прошедший последипломную (интернатура) или дополнительную подготовку (специализация) по онкологии (онкохирургии).', 1, 74, NULL, NULL),
(3857, 59, 'Укомплектованность штатов медицинского персонала онкологического кабинета в соответствии с действующими штатными нормативами не менее 95 %.', 1, 74, NULL, NULL),
(3862, 1, 'Деятельность структурного подразделения осуществляется в соответствии с положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении и имеют постоянный доступ к его содержанию', 3, 73, NULL, NULL),
(3863, 2, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей. Результаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по травматологии.Результаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 73, NULL, NULL),
(3864, 3, 'Укомплектованность структурного подразделения врачами-травматологами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей-травматологов укомплектованность не менее 96 % по занятым должностям', 1, 73, NULL, NULL),
(3865, 4, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям ', 1, 73, NULL, NULL),
(3866, 5, 'Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего ', 1, 73, NULL, NULL),
(3867, 6, 'Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 73, NULL, NULL),
(3868, 7, 'Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев. Медицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 73, NULL, NULL),
(3869, 8, 'Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков. Медицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощ', 3, 73, NULL, NULL),
(3870, 9, 'Обеспечено соблюдение требований к профилактике инфекционных заболеваний при проведении хирургических и оперативных вмешательств, перевязок (пп. 154-163 Постановление Совета Министров Республики Беларусь от 3 марта 2020 г. № 130 «Специфические санитарно-эпидемические требования к содержанию и эксплуатации организаций здравоохранения, иных организаций и индивидуальных предпринимателей, которых осуществляют медицинскую, фармацевтическую деятельность»)', 1, 73, NULL, NULL),
(3871, 10, 'Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 73, NULL, NULL),
(3872, 11, 'Структурное подразделение оснащено изделиями медицинского назначения и медицинской техникой в объеме, достаточном для оказания специализированной медицинской помощи по профилю травматология и ортопедия ', 2, 73, NULL, NULL),
(3873, 12, 'В организации здравоохранения функционирует операционный блок, обеспечивающий проведение полноценного и безопасного оперативного вмешательства при травмах или заболеваниях опорно-двигательного аппарата', 1, 73, NULL, NULL),
(3874, 13, 'Организация здравоохранения обеспечивает операционный блок необходимым и исправным оборудованием, инструментарием, изделиями медицинского назначения и расходными материалами для проведения оперативных вмешательств у пациентов с травмой и заболеваниями опорно-двигательного аппарата', 1, 73, NULL, NULL),
(3875, 14, 'Организация здравоохранения проводит обучение персонала операционного блока по вопросам организации и проведения оперативных вмешательств у пациентов с травмой и заболеваниями опорно-двигательного аппарата', 1, 73, NULL, NULL),
(3876, 15, 'В организации здравоохранения внедрена система идентификации пациента и верификации операционного участка у пациентов с травмой или заболеванием опорно-двигательного аппарата перед непосредственным проведением оперативного вмешательства', 1, 73, NULL, NULL),
(3877, 16, 'Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 73, NULL, NULL),
(3878, 17, 'В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники.Проведение обучения документируется', 3, 73, NULL, NULL),
(3879, 18, 'Организация здравоохранения обеспечивает: своевременный прием/осмотр пациентов с травмой легкой степени или с обострением хронического заболевания опорно-двигательного аппарата в кабинете травматолога-ортопеда, своевременный прием и осмотр в приемном отделении пациентов с острой травмой при самостоятельном обращении пациентов, при поступлении по линии скорой медицинской помощи, при направлении других организаций здравоохранения своевременный прием и осмотр пациентов с острой травмой в травматологическом пункте', 2, 73, NULL, NULL),
(3880, 19, 'При первичном приеме/осмотре пациента с травмой или с заболеванием опорно-двигательного аппарата проводится сбор жалоб и анамнеза жизни, травмы или заболевания, наследственный, аллергологический, объективный и локальный статус с определением предварительного диагноза', 3, 73, NULL, NULL),
(3881, 20, 'Обеспечена круглосуточная работа врачей-травматологов при условии оказания экстренной специализированной помощи в структурном подразделении. В круглосуточном режиме, в том числе в выходные праздничные дни доступен осмотр дежурного врача', 2, 73, NULL, NULL),
(3882, 21, 'В структурном подразделении обеспечена возможность одновременного участия 2 врачей-хирургов при выполнении хирургических вмешательств (по графику работы круглосуточно, дежурства на дому)', 3, 73, NULL, NULL),
(3883, 22, 'Круглосуточно обеспечена возможность оказания анестезиолого-реанимационной помощи. Критерий применяется для структурных подразделений межрайонного, городского, областного, республиканского уровня', 1, 73, NULL, NULL),
(3884, 23, 'В случае поступления в приемное отделение организации здравоохранения критических пациентов с острой травмой, в том числе множественной и сочетанной травмой, обеспечивается своевременный осмотр врача-реаниматолога', 1, 73, NULL, NULL),
(3885, 24, 'В структурном подразделении в обязательном порядке осуществляется направление операционного (биопсийного) материала и биологических жидкостей на патогистологическое (бактериологическое) исследование', 2, 73, NULL, NULL),
(3886, 25, 'Обеспечена преемственность с амбулаторно-поликлиническими организациями здравоохранения. Обеспечена передача эпикриза, содержащего рекомендации по дальнейшему медицинскому наблюдению в территориальную амбулаторно-поликлиническую организацию', 2, 73, NULL, NULL),
(3887, 26, 'В рамках получения пациентом стационарной помощи, в случаях, предусмотренных протоколами диагностики и лечения, обеспечена возможность проведения консультаций врачей-специалистов, в том числе с использованием телемедицинских технологий, с использованием собственных ресурсов организации здравоохранения или другими организациями (центрами коллективного пользования, специализированными центрами) в соответствии с установленным порядком', 1, 73, NULL, NULL),
(3888, 27, 'Обеспечена возможность проведения лабораторных исследований в соответствии с клиническими протоколами диагностики и лечения', 1, 73, NULL, NULL),
(3889, 28, 'В организации здравоохранения круглосуточно обеспечено проведение рентгенологических исследований (по графику работы круглосуточно или дежурства на дому)', 1, 73, NULL, NULL),
(3890, 29, 'В организации здравоохранения обеспечено проведение ультразвуковых исследований либо имеется установленный порядок направления пациентов на данные исследования ', 2, 73, NULL, NULL),
(3891, 30, 'В организации здравоохранения обеспечено проведение КТ-исследований либо имеется установленный порядок направления пациентов на данные исследования в другие УЗ', 2, 73, NULL, NULL),
(3892, 31, 'В организации здравоохранения обеспечено проведение МРТ-исследований либо имеется установленный порядок направления пациентов на данные исследования в другие УЗ', 2, 73, NULL, NULL),
(3893, 32, 'Организация здравоохранения имеет необходимые условия и перечень медицинского оборудования для проведения ранней и (или) поздней реабилитационной помощи травматологическим или ортопедическим пациентам', 2, 73, NULL, NULL),
(3894, 33, 'Организация здравоохранения проводит обучение медицинского персонала по современным технологиям оказания реабилитационной помощи травматологическим и ортопедическим пациентам', 2, 73, NULL, NULL),
(3895, 34, 'Организация здравоохранения обеспечивает индивидуальный комплексный план реабилитации для пациентов с травмой и заболеванием опорно-двигательного аппарата', 2, 73, NULL, NULL),
(3896, 35, 'Организация здравоохранения обеспечивает контроль реализации плана реабилитации и внесение необходимых корректировок для повышения и улучшения качества жизни пациентов', 2, 73, NULL, NULL),
(3897, 36, 'Назначение лекарственных препаратов соответствует установленному диагнозу, требованиям клинических протоколов, инструкции по медицинскому применению лекарственного препарата ', 1, 73, NULL, NULL),
(3898, 37, 'Оформление медицинской карты стационарного пациента соответствует установленной форме', 3, 73, NULL, NULL),
(3899, 38, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 73, NULL, NULL),
(3900, 39, 'В медицинской карте стационарного пациента оформлен предоперационный эпикриз, указываются обоснование хирургического вмешательства с учетом установленного диагноза, способа обезболивания, вида оперативного доступа, возможных рисков', 2, 73, NULL, NULL),
(3901, 40, 'В структурном подразделении имеются условия для выписки электронных рецептов на лекарственные средства', 2, 73, NULL, NULL),
(3902, 41, 'Для врачей-специалистов структурного подразделения обеспечена доступность проведения телемедицинского консультирования, результаты которого документируется и находится в медицинской карте ', 2, 73, NULL, NULL),
(3903, 42, 'Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 3, 73, NULL, NULL),
(3904, 43, 'Хирургическая активность не менее 30 % (для учреждений районного уровня), не менее 40 % (для учреждений межрайонного уровня), не менее 50 % (для учреждений областного, г. Минска и республиканского уровня),', 2, 73, NULL, NULL),
(3905, 44, 'Показатель среднегодовой занятости койки структурного подразделения на основании годовой отчетности за последние 3 года не менее 300.', 3, 73, NULL, NULL),
(3906, 45, 'Профильность работы структурного подразделения для районного и городского уровня оказания помощи не менее 60 %, для областного и республиканского не менее 80 %', 2, 73, NULL, NULL),
(3907, 46, 'В структурном подразделении выполняются запланированные объемы специализированной медицинской помощи, предоставляемой за счет бюджета (число проведенных койко-дней, средняя длительность лечения)', 3, 73, NULL, NULL),
(3908, 47, 'Планирование объемов медицинской помощи для структурных подразделений, являющихся межрайонными, осуществляется с учетом обеспечения равной доступности населению всех закрепленных территорий. Удельный вес пациентов закрепленных территорий для районного уровня не менее 30%, для городского и областного уровня не менее 60 %', 2, 73, NULL, NULL),
(3925, 1, 'Положение о структурном подразделении соответствует деятельности подразделения, его структуре. Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении и имеют постоянный доступ к его содержанию', 3, 75, NULL, NULL),
(3926, 2, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, результаты работы рассматриваются на медицинских советах, производственных совещаниях, принимаются меры по устранению недостатков', 2, 75, NULL, NULL),
(3927, 3, 'Укомплектованность структурного подразделения врачами-офтальмологами не менее 75% по физическим лицам', 1, 75, NULL, NULL),
(3928, 4, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75% по физическим лицам', 1, 75, NULL, NULL),
(3929, 5, 'Наличие квалификационных категорий у врачей-офтальмологов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 75, NULL, NULL),
(3930, 6, 'Квалификация медицинских работников структурного подразделения соответствует требованиям должностной инструкции к занимаемой должности служащего', 2, 75, NULL, NULL),
(3931, 7, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 75, NULL, NULL),
(3932, 8, 'Структурное подразделение оснащено изделиями медицинского назначения и медицинской техникой в объеме, достаточном для оказания специализированной медицинской помощи согласно утвержденному табелю оснащения', 2, 75, NULL, NULL),
(3933, 9, 'Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 75, NULL, NULL),
(3934, 10, 'В структурном подразделении определены лица, ответственные за техническое обслуживание и ремонт медицинской техники', 1, 75, NULL, NULL),
(3935, 11, 'В структурном подразделении ведется учет медицинской техники', 1, 75, NULL, NULL),
(3936, 12, 'В организации здравоохранения определен порядок проведения обучения медицинских работников правилам эксплуатации медицинской техники. В структурном подразделении документируется проведение обучения.', 3, 75, NULL, NULL),
(3937, 13, 'Назначаемая диагностика соответствует установленному диагнозу и требованиям клинических протоколов', 2, 75, NULL, NULL),
(3938, 14, 'Назначение лекарственных препаратов соответствует установленному диагнозу, требованиям клинических протоколов, инструкции по медицинскому применению лекарственного препарата', 2, 75, NULL, NULL),
(3939, 15, 'Согласие пациента или его законного представителя на проведение медицинских вмешательств оформляется в медицинских документах в соответствии с требованиями законодательства', 2, 75, NULL, NULL),
(3940, 16, 'Отказ от оказания медицинской помощи, в том числе медицинского вмешательства, оформляется записью в медицинских документах и подписывается пациентом либо его законным представителем и лечащим врачом', 1, 75, NULL, NULL),
(3941, 17, 'Отказ от применения изделий медицинского назначения, предоставляемых за счет бюджетных средств, оформляется записью в медицинских документах и подписывается пациентом либо его законным представителем и лечащим врачом', 2, 75, NULL, NULL),
(3942, 18, 'В организации здравоохранения созданы условия для лиц с ограниченными возможностями: имеются кресла-коляски, коридоры оборудованы поручнями, перилами, информационными и указательными знаками, имеются палаты, туалеты, оборудованные для лиц с ограниченными возможностями. Работниками организации здравоохранения оказывается ситуационная помощь, согласно разработанным локальным правовым актам', 2, 75, NULL, NULL),
(3943, 19, 'Журнал записи амбулаторных оперативных вмешательств оформляется с описанием протокола операции', 2, 75, NULL, NULL),
(3944, 20, 'В структурном подразделении определены лица, осуществляющие контроль за наличием необходимых лекарственных препаратов, медицинских изделий для оказания экстренной и неотложной медицинской помощи, своевременное их пополнение и соблюдение сроков годности', 2, 75, NULL, NULL),
(3945, 21, 'В структурном подразделении имеются лекарственные препараты и медицинские изделия для оказания экстренной медицинской помощи в соответствии с требованиями клинических протоколов', 2, 75, NULL, NULL),
(3946, 22, 'В структурном подразделении проводятся занятия с медицинскими работниками по освоению теоретических и практических навыков оказания экстренной и неотложной медицинской помощи, в том числе оказанию сердечно-легочной реанимации с последующим контролем знаний с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев', 3, 75, NULL, NULL),
(3947, 23, 'В организации здравоохранения обеспечена возможность проведения диагностических исследований или имеется установленный порядок направления на обследование: общий (клинический) анализ крови, биохимический анализ крови, общий анализ мочи, определение показателей свертывания крови: активированного частичного тромбопластинового времени, международного нормализованного отношения, фибриногена, D-димеров, исследование уровня гликированного гемоглобина в крови, серологическое исследование на маркеры сифилиса методом иммуноферментного анализа или реакция быстрых плазменных реагинов', 2, 75, NULL, NULL),
(3948, 24, 'В организации здравоохранения обеспечена возможность проведения консультаций врачей-специалистов по профилю сопутствующей патологии, оказывающей влияние на состояние глаза, согласно перечню дополнительных диагностических исследований, в том числе с использованием телемедицинских технологий и/или с наличием установленного порядка направления на консультации в другие организации здравоохранения', 2, 75, NULL, NULL),
(3949, 25, 'Для организаций здравоохранения, выполняющих амбулаторные хирургические офтальмологические вмешательства: перевязки и медицинские осмотры после хирургических вмешательств выполняются обязательно на следующий день после операции и далее – по медицинским показаниям', 2, 75, NULL, NULL),
(3950, 26, 'Для организаций здравоохранения, выполняющих амбулаторные хирургические офтальмологические вмешательства: в обязательном порядке осуществляется направление операционного (биопсийного) материала на патологоанатомическое исследование', 2, 75, NULL, NULL),
(3951, 27, 'Для организаций здравоохранения, выполняющих амбулаторные хирургические офтальмологические вмешательства: в медицинской карте пациента, получающего медицинскую помощь в амбулаторных условиях, указываются обоснование оперативного вмешательства с учетом установленного диагноза, вид оперативного вмешательства и вид предоставляемого анестезиологического пособия.', 2, 75, NULL, NULL),
(3952, 28, 'Для организаций здравоохранения, выполняющих амбулаторные хирургические офтальмологические вмешательства: в организации здравоохранения проводится учет, анализ осложнений, вызванных медицинским вмешательством. Принимаются меры по устранению причин и условий, повлекших осложнения, вызванные медицинским вмешательством.', 3, 75, NULL, NULL),
(3953, 29, 'Выполнение плановых объемов оказания медицинской помощи', 2, 75, NULL, NULL),
(3954, 30, 'Удельный вес пациентов с впервые выявленной глаукомой 4 стадии от общего количества пациентов с впервые выявленной глаукомой в течение года', 2, 75, NULL, NULL),
(3955, 31, 'Наличие оборудования, обеспечивающего проведение базовых диагностических исследований (визометрии, наружного осмотра, исследования сред глаза в проходящем свете, исследования переднего отрезка глаза методом бокового освещения, офтальмоскопии, биомикроскопии глаза), тонометрии глаза и исследования рефракции', 2, 75, NULL, NULL),
(3956, 32, 'Наличие оборудования для проведения периметрии либо наличие установленного порядка направления на периметрию в другие организации здравоохранения', 2, 75, NULL, NULL),
(3957, 33, 'Наличие установленного порядка направления на обязательные и дополнительные исследования для уточнения диагноза, проведения дифференциальной диагностики и оценки динамики заболевания в другие организации здравоохранения', 2, 75, NULL, NULL),
(3958, 34, 'Медицинские осмотры осуществляются врачом-офтальмологом при острых заболеваниях – не реже 1 раза в 5 дней, при хронических заболеваниях и в послеоперационном периоде медицинское наблюдение пациентов с болезнями глаза и его придаточного аппарата осуществляется по алгоритмам, указанным в клинических протоколах ', 2, 75, NULL, NULL),
(3959, 35, 'Соблюдение алгоритма медицинского наблюдения пациентов с глаукомой, согласно действующим клиническим протоколам', 2, 75, NULL, NULL),
(3960, 36, 'Наличие оборудования, обеспечивающего проведение базовых диагностических исследований (визометрии, наружного осмотра, исследования сред глаза в проходящем свете, исследования переднего отрезка глаза методом бокового освещения, офтальмоскопии, биомикроскопии глаза), тонометрии глаза и исследования рефракции, периметрии', 2, 75, NULL, NULL),
(3961, 37, 'Наличие установленного порядка направления на обязательные и дополнительные исследования для уточнения диагноза, проведения дифференциальной диагностики и оценки динамики заболевания в другие организации здравоохранения ', 2, 75, NULL, NULL),
(3962, 38, 'Медицинские осмотры осуществляются врачом-офтальмологом при острых заболеваниях – не реже 1 раза в 5 дней, при хронических заболеваниях и в послеоперационном периоде медицинское наблюдение пациентов с болезнями глаза и его придаточного аппарата осуществляется по алгоритмам, указанным в клинических протоколах ', 2, 75, NULL, NULL),
(3963, 39, 'Соблюдение алгоритма медицинского наблюдения пациентов с глаукомой, согласно действующим клиническим протоколам', 2, 75, NULL, NULL),
(3964, 40, 'Наличие оборудования, обеспечивающего проведение базовых диагностических исследований (визометрии, наружного осмотра, исследования сред глаза в проходящем свете, исследования переднего отрезка глаза методом бокового освещения, офтальмоскопии, биомикроскопии глаза), тонометрии глаза и исследования рефракции, периметрии', 2, 75, NULL, NULL),
(3965, 41, 'Наличие оборудования, обеспечивающего проведение обязательных и дополнительных исследований для уточнения диагноза, проведения дифференциальной диагностики, оценки динамики заболевания, либо наличие установленного порядка направления на эти исследования в другие организации здравоохранения', 2, 75, NULL, NULL),
(3988, 1, 'Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 76, NULL, NULL),
(3989, 2, 'Руководителем организации здравоохранения определены ответственные лица за организацию оказания офтальмологической помощи', 3, 76, NULL, NULL),
(3990, 3, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, результаты работы рассматриваются на медицинских советах, производственных совещаниях, принимаются меры по устранению недостатков', 2, 76, NULL, NULL),
(3991, 4, 'Квалификация медицинских работников структурного подразделения соответствует требованиям должностной инструкции к занимаемой должности служащего. Соблюдены требования к занятию должностей медицинских, фармацевтических работников', 2, 76, NULL, NULL),
(3992, 5, 'Укомплектованность структурного подразделения врачами-офтальмологами не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей врачей укомплектованность не менее 96 % по занятым должностям', 1, 76, NULL, NULL),
(3993, 6, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 76, NULL, NULL),
(3994, 7, 'Наличие квалификационных категорий у врачей-офтальмологов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 76, NULL, NULL),
(3995, 8, 'Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев. Медицинские работники владеют соответствующими навыками при проведении реанимационных мероприятий', 1, 76, NULL, NULL),
(3996, 9, 'Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков, имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 76, NULL, NULL),
(3997, 10, 'Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 76, NULL, NULL),
(3998, 11, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 76, NULL, NULL),
(3999, 12, 'В организации здравоохранения обеспечена возможность проведения консультаций врачей-специалистов по профилю сопутствующей патологии, оказывающей влияние на состояние глаза, согласно перечню дополнительных диагностических исследований, указанных в действующем клиническом протоколе, в том числе с использованием телемедицинских технологий и/или при содействии Республиканского центра экстренной медицинской помощи', 2, 76, NULL, NULL),
(4000, 13, 'В организации здравоохранения созданы условия для лиц с ограниченными возможностями: имеются кресла-коляски, коридоры оборудованы поручнями, перилами, информационными и указательными знаками, имеются палаты, туалеты, оборудованные для лиц с ограниченными возможностями. Работниками организации здравоохранения оказывается ситуационная помощь, согласно разработанным локальным правовым актам', 2, 76, NULL, NULL),
(4001, 14, 'Структурное подразделение оснащено изделиями медицинского назначения и медицинской техникой в соответствии с Примерным табелем оснащения, установленным Министерством здравоохранения или табелем оснащения, установленным локальным правовым актом, в объеме, достаточном для оказания специализированной медицинской помощи пациентам неврологического профиля', 3, 76, NULL, NULL),
(4002, 15, 'Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 76, NULL, NULL),
(4003, 16, 'В структурном подразделении определены лица, ответственные за техническое обслуживание и ремонт медицинской техники', 1, 76, NULL, NULL),
(4004, 17, 'В структурном подразделении ведется учет медицинской техники', 1, 76, NULL, NULL),
(4005, 18, 'В организации здравоохранения определен порядок проведения обучения медицинских работников правилам эксплуатации медицинской техники. В структурном подразделении документируется проведение обучения.', 3, 76, NULL, NULL),
(4006, 19, 'Назначаемая диагностика соответствует установленному диагнозу и требованиям клинических протоколов', 2, 76, NULL, NULL),
(4007, 20, 'Назначение лекарственных препаратов соответствует установленному диагнозу, требованиям клинических протоколов, инструкции по медицинскому применению лекарственного препарата', 2, 76, NULL, NULL),
(4008, 21, 'В организации здравоохранения на пациента оформляется медицинская карта амбулаторного больного по форме, установленной Министерством здравоохранения Республики Беларусь и (или) иные медицинские документы, установленные ЛПА', 3, 76, NULL, NULL),
(4009, 22, 'Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 2, 76, NULL, NULL),
(4010, 23, 'Согласие пациента или его законного представителя на проведение медицинских вмешательств оформляется в медицинских документах в соответствии с требованиями законодательства', 2, 76, NULL, NULL),
(4011, 24, 'Отказ от оказания медицинской помощи, в том числе медицинского вмешательства, оформляется записью в медицинских документах и подписывается пациентом либо его законным представителем и лечащим врачом', 1, 76, NULL, NULL),
(4012, 25, 'Отказ от применения изделий медицинского назначения, предоставляемых за счет бюджетных средств, оформляется записью в медицинских документах и подписывается пациентом либо его законным представителем и лечащим врачом', 2, 76, NULL, NULL),
(4013, 26, 'Выписка пациентов из организации здравоохранения осуществляется после осмотра заведующим структурным подразделением с оформлением эпикриза', 2, 76, NULL, NULL),
(4014, 27, 'Журнал записи оперативных вмешательств в стационаре оформляется с описанием протокола операции', 2, 76, NULL, NULL),
(4015, 28, 'В структурном подразделении определены лица, осуществляющие контроль за наличием необходимых лекарственных препаратов, медицинских изделий для оказания экстренной и неотложной медицинской помощи, своевременное их пополнение и соблюдение сроков годности', 2, 76, NULL, NULL),
(4016, 29, 'В структурном подразделении имеются лекарственные препараты и медицинские изделия для оказания экстренной медицинской помощи в соответствии с требованиями клинических протоколов', 2, 76, NULL, NULL),
(4017, 30, 'В организации здравоохранения обеспечена возможность проведения диагностических исследований либо имеется установленный порядок направления пациентов на данные исследования в другие организации здравоохранения: общий (клинический) анализ крови, биохимический анализ крови, общий анализ мочи, определение показателей свертывания крови: активированного частичного тромбопластинового времени, международного нормализованного отношения, фибриногена, D-димеров, исследование уровня гликированного гемоглобина в крови, серологическое исследование на маркеры сифилиса методом иммуноферментного анализа или реакция быстрых плазменных реагинов', 2, 76, NULL, NULL),
(4018, 31, 'В организации здравоохранения обеспечена возможность проведения диагностических исследований: КТ головы, КТ глазницы, МРТ головного мозга, МРТ глазницы либо имеется установленный порядок направления пациентов на данные исследования в другие организации здравоохранения', 2, 76, NULL, NULL),
(4019, 32, 'Госпитализация пациентов в структурное подразделение осуществляется на основании локального правового акта в соответствии с утвержденными порядками оказания медицинской помощи и действующими клиническими протоколами, законодательством Республики Беларусь', 2, 76, NULL, NULL),
(4020, 33, 'В организации здравоохранения круглосуточно обеспечена возможность оказания анестезиолого-реанимационной помощи', 2, 76, NULL, NULL),
(4021, 34, 'Медицинские осмотры врачом-офтальмологом, включающие диагностические исследования (базовые, по показаниям – обязательные и/или дополнительные) проводятся не реже 1 раза в 2 дня', 2, 76, NULL, NULL),
(4022, 35, 'Перевязки и медицинские осмотры после хирургических вмешательств выполняются обязательно на следующий день после операции и далее – по медицинским показаниям', 2, 76, NULL, NULL),
(4023, 36, 'В структурном подразделении в обязательном порядке осуществляется направление операционного (биопсийного) материала на патологоанатомическое исследование', 2, 76, NULL, NULL),
(4024, 37, 'В медицинской карте пациента указываются обоснование оперативного вмешательства с учетом установленного диагноза, вид оперативного вмешательства и вид предоставляемого анестезиологического пособия', 2, 76, NULL, NULL),
(4025, 38, 'В организации здравоохранения проводится учет, анализ осложнений, вызванных медицинским вмешательством. Принимаются меры по устранению причин и условий, повлекших осложнения, вызванные медицинским вмешательством', 3, 76, NULL, NULL),
(4026, 39, 'Анестезиологическое пособие и его вид определяются объемом хирургической операции, ее длительностью, риском прогнозируемых осложнений, возрастом пациента и наличием коморбидной патологии.', 2, 76, NULL, NULL),
(4027, 40, 'Показатели среднегодовой занятости койки и оборота койки структурного подразделения составляют не менее среднеобластных их значений по офтальмологическому профилю на основании годовой отчетности за последние 3 года. При их недостижении проводится анализ и предоставляются данные с указанием причин невыполнения', 3, 76, NULL, NULL),
(4028, 41, 'Наличие оборудования, обеспечивающего проведение базовых диагностических исследований (визометрии, наружного осмотра, исследования сред глаза в проходящем свете, исследования переднего отрезка глаза методом бокового освещения, офтальмоскопии, биомикроскопии глаза), тонометрии глаза и исследования рефракции', 2, 76, NULL, NULL),
(4029, 42, 'Показатель хирургической активности составляет не менее 40 %', 2, 76, NULL, NULL),
(4030, 43, 'В организации здравоохранения круглосуточно обеспечено проведение лабораторных исследований', 2, 76, NULL, NULL),
(4031, 44, 'В организации здравоохранения, оказывающей круглосуточную неотложную специализированную офтальмологическую помощь, круглосуточно обеспечено проведение рентгенологических исследований', 1, 76, NULL, NULL),
(4032, 45, 'Необходимо наличие оборудования, обеспечивающего проведение базовых, обязательных и дополнительных исследований для уточнения диагноза, проведения дифференциальной диагностики, оценки динамики заболевания, либо имеется установленный порядок направления пациентов на обязательные и дополнительные исследования в другие организации здравоохранения', 2, 76, NULL, NULL),
(4033, 46, 'В структурном подразделении при выполнении хирургических вмешательств обеспечена возможность одновременного участия 2 врачей-офтальмологов', 2, 76, NULL, NULL),
(4034, 47, 'Показатель хирургической активности составляет не менее 60%', 2, 76, NULL, NULL),
(4035, 48, 'Внедрение научных разработок и новых методов в практическое здравоохранение', 3, 76, NULL, NULL),
(4036, 49, 'В организации здравоохранения круглосуточно обеспечено проведение лабораторных исследований', 2, 76, NULL, NULL),
(4037, 50, 'В организации здравоохранения, оказывающей круглосуточную неотложную специализированную офтальмологическую помощь, круглосуточно обеспечено проведение рентгенологических исследований', 1, 76, NULL, NULL),
(4038, 51, 'Обеспечено наличие оборудования, обеспечивающего проведения базовых, обязательных и дополнительных исследований для уточнения диагноза, проведения дифференциальной диагностики, оценки динамики заболевания', 2, 76, NULL, NULL),
(4039, 52, 'В структурном подразделении при выполнении хирургических вмешательств обеспечена возможность одновременного участия 2 врачей-офтальмологов, в том числе при оказании неотложной помощи', 2, 76, NULL, NULL),
(4040, 53, 'Показатель хирургической активности составляет не менее 70%', 2, 76, NULL, NULL),
(4041, 54, 'Обеспечена возможность проведения высокотехнологичных и сложных хирургических операций (наличие оборудования и кадров)', 1, 76, NULL, NULL),
(4042, 55, 'Внедрение научных разработок и новых методов в практическое здравоохранение', 2, 76, NULL, NULL),
(4051, 1, 'Деятельность структурного подразделения осуществляется в соответствии с положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении и имеют постоянный доступ к его содержанию', 3, 77, NULL, NULL),
(4052, 2, 'Руководителем организации здравоохранения определены ответственные лица за организацию оказания специализированной медицинской помощи', 3, 77, NULL, NULL),
(4053, 3, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей. Результаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по экстренной и неотложной патологии. Результаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 77, NULL, NULL),
(4054, 4, 'Укомплектованность структурного подразделения врачами анестезиологами-реаниматологами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей анестезиологов-реаниматологов укомплектованность не менее 96 % по занятым должностям', 1, 77, NULL, NULL),
(4055, 5, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 77, NULL, NULL),
(4056, 6, 'Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего', 1, 77, NULL, NULL),
(4057, 7, 'Наличие квалификационных категорий у врачей анестезиологов-реаниматологов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 77, NULL, NULL);
INSERT INTO `mark` (`id_mark`, `str_num`, `mark_name`, `mark_class`, `id_criteria`, `date_close`, `date_open`) VALUES
(4058, 8, 'Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев.  Медицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 77, NULL, NULL),
(4059, 9, 'Руководителем отделения анестезиологии и реаниматологии осуществляется систематическое обучение сотрудников смежных отделений методам оказания медицинской помощи при развитии неотложных, терминальных состояний, производится обучение проведению комплекса сердечно-легочной реанимации, ведется учет результатов обучения', 2, 77, NULL, NULL),
(4060, 10, 'Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков. Медицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 77, NULL, NULL),
(4061, 11, 'Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 77, NULL, NULL),
(4062, 12, 'Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой ', 2, 77, NULL, NULL),
(4063, 13, 'Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 77, NULL, NULL),
(4064, 14, 'Медицинская техника, подлежащая метрологическому контролю, проходит периодическую поверку и калибровку согласно графику, утвержденному руководителем организации здравоохранения ', 3, 77, NULL, NULL),
(4065, 15, 'В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники. Проведение обучения документируется', 3, 77, NULL, NULL),
(4066, 16, 'Порядок оказания медицинской помощи в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь. Соблюдается порядок (алгоритмы, «дорожные карты») оказания скорой медицинской помощи', 2, 77, NULL, NULL),
(4067, 17, 'Обеспечена возможность осмотра пациентов при возникновении состояний, требующих оказания неотложной медицинской помощи или необходимости оказания анестезиологического пособия врачом анестезиологом-реаниматологом в рабочее время ', 1, 77, NULL, NULL),
(4068, 18, 'Назначение лекарственных препаратов соответствует установленному диагнозу, требованиям клинических протоколов, инструкции по медицинскому применению лекарственного препарата', 1, 77, NULL, NULL),
(4069, 19, 'Ведение первичной медицинской документации в отделении анестезиологии и реаниматологии в соответствии с требованиями законодательства', 2, 77, NULL, NULL),
(4070, 20, 'Согласие пациента или его законного представителя на проведение медицинских вмешательств оформляется в медицинских документах в соответствии с требованиями законодательства', 2, 77, NULL, NULL),
(4071, 21, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 77, NULL, NULL),
(4072, 22, 'Организовано наблюдение пациентов в послеоперационном периоде', 1, 77, NULL, NULL),
(4073, 23, 'Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи', 2, 77, NULL, NULL),
(4074, 24, 'Ведется журнал оценки готовности рабочего места врача анестезиолога-реаниматолога. Осуществляется информирование ответственных лиц о неисправности медицинской техники, медицинских изделий, отсутствии медицинских изделий, лекарственных препаратов ', 2, 77, NULL, NULL),
(4075, 25, 'Созданы условия для обеспечения медицинскими газами', 1, 77, NULL, NULL),
(4082, 1, 'Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 78, NULL, NULL),
(4083, 2, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей. Результаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по хирургии. езультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 78, NULL, NULL),
(4084, 3, 'Укомплектованность структурного подразделения врачами-специалистами не менее 75 % по физическим лицам (для городских поликлиник). Наличие врача-специалиста (для районных поликлиник)', 1, 78, NULL, NULL),
(4085, 4, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам', 1, 78, NULL, NULL),
(4086, 5, 'Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего', 1, 78, NULL, NULL),
(4087, 6, 'Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 78, NULL, NULL),
(4088, 7, 'Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев. Медицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 78, NULL, NULL),
(4089, 8, 'Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков. Медицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 78, NULL, NULL),
(4090, 9, 'Врачи-оториноларингологи прошли повышение квалификации или стажировку на рабочем месте по профилю оказываемой медицинской помощи в структурном подразделении', 1, 78, NULL, NULL),
(4091, 10, 'Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 78, NULL, NULL),
(4092, 11, 'Структурное подразделение оснащено изделиями медицинского назначения и медицинской техникой в соответствии с Примерным табелем оснащения, установленным Министерством здравоохранения или табелем оснащения в объеме, достаточном для оказания специализированной медицинской помощи пациентам оториноларингологического профиля', 2, 78, NULL, NULL),
(4093, 12, 'Порядок оказания медицинской помощи в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь. Соблюдается порядок (алгоритмы) оказания скорой и плановой медицинской помощи при оториноларингологической патологии', 2, 78, NULL, NULL),
(4094, 13, 'Работа структурного подразделения обеспечена в сменном режиме', 2, 78, NULL, NULL),
(4095, 14, 'В структурном подразделении в обязательном порядке осуществляется направление операционного (биопсийного) материала и биологических жидкостей на патогистологическое (бактериологическое) исследование', 1, 78, NULL, NULL),
(4096, 15, 'Соблюдается порядок медицинского наблюдения пациентов с оториноларингологическими заболеваниями в амбулаторных условиях. Руководителем структурного подразделения осуществляется анализ результатов медицинского наблюдения пациентов', 1, 78, NULL, NULL),
(4097, 16, 'Обеспечена преемственность с больничными организациями здравоохранения. Определен порядок направления на плановую и экстренную госпитализацию пациентов оториноларингологического профиля. Обеспечено выполнение на амбулаторном этапе рекомендаций по дальнейшему медицинскому наблюдению после выписки', 2, 78, NULL, NULL),
(4098, 17, 'Обеспечена возможность консультаций врачей-специалистов в соответствии с клиническими протоколами диагностики и лечения (в организации здравоохранения или определён порядок направления в другие организации здравоохранения)', 1, 78, NULL, NULL),
(4099, 18, 'Обеспечена возможность проведения лабораторных исследований: в соответствии с клиническими протоколами диагностики и лечения (в организации здравоохранения или определён порядок направления в другие организации здравоохранения)', 1, 78, NULL, NULL),
(4100, 19, 'Обеспечена возможность проведения диагностических исследований ЛОР патологии методами КТ, МРТ или определен порядок направления пациентов на данные исследования', 1, 78, NULL, NULL),
(4101, 20, 'Обеспечено проведение рентгенологических исследований ЛОР патологии (носоглотки, околоносовых пазух) – для районного и межрайонного уровня, (носоглотки, околоносовых пазух, гортани, височных костей) – для областного и республиканского уровней', 1, 78, NULL, NULL),
(4102, 21, 'В медицинской карте амбулаторного пациента указываются обоснование оперативного вмешательства с учетом установленного диагноза, вид оперативного вмешательства и вид предоставляемого анестезиологического пособия, информация о получении согласия пациента (законного представителя)', 3, 78, NULL, NULL),
(4103, 22, 'Протоколы хирургических вмешательств оформляются в журнале записи оперативных вмешательств с описанием хода операции', 3, 78, NULL, NULL),
(4104, 23, 'В структурном подразделении проводится анализ осложнений, вызванных медицинским вмешательством. Принимаются меры по устранению причин и условий, повлекших осложнения, вызванные медицинским вмешательством', 3, 78, NULL, NULL),
(4105, 24, 'Обеспечена доступность проведения консультаций врачами-оториноларингологами, смежными врачами-специалистами, в том числе телемедицинское консультирование, результаты которого документируются и находится в медицинской карте', 2, 78, NULL, NULL),
(4106, 25, 'Обеспечено выполнение функции врачебной должности не менее 90 %', 2, 78, NULL, NULL),
(4107, 26, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе.', 2, 78, NULL, NULL),
(4108, 27, 'Осуществляется выписка электронных рецептов на лекарственные средства', 2, 78, NULL, NULL),
(4109, 28, 'Выполнение хирургических вмешательств в амбулаторных условиях составляет не менее 5 вмешательств в год на одну ставку', 2, 78, NULL, NULL),
(4110, 29, 'Показатель своевременности взятия под диспансерное наблюдение пациентов с хроническими гнойными средними отитами (ХГСО) не менее 100%. При недостижении уровня показателя проводится анализ и предоставляются данные с указанием причин невыполнения.', 2, 78, NULL, NULL),
(4111, 30, 'Соблюдается порядок проведения раннего выявления предопухолевых заболеваний и злокачественных новообразований головы и шеи, ранней диагностики опухолей головы и шеи', 2, 78, NULL, NULL),
(4112, 31, 'Наличие сурдологического (сурдологопедического) отделения (кабинета) на областном уровне и выполнение объема работы в соответствии с положением о структурном подразделении', 2, 78, NULL, NULL),
(4113, 32, 'Обеспечено выполнение объективных методов исследования слуха для областного уровня и РНПЦ (импендансометрия, тимпанометрия, отоакустическая эмиссия, запись коротколатентных слуховых вызванных потенциалов)', 2, 78, NULL, NULL),
(4114, 33, 'Обеспечено выполнение субъективных методов исследования слуха для районного, межрайонного, областного, уровней и РНПЦ (акуметрия, камертональные пробы, тональная пороговая аудиометрия)', 1, 78, NULL, NULL),
(4115, 34, 'Раннее выявление нарушений слуха у детей раннего возраста (до 1 года) не менее 100% от подлежащих', 3, 78, NULL, NULL),
(4116, 35, 'Выполнение планов оказания медицинской помощи по договорам с ГУЗО и комитетом по здравоохранению Минского городского исполнительного комитета, для РНПЦ', 2, 78, NULL, NULL),
(4145, 1, 'Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 79, NULL, NULL),
(4146, 2, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей. Результаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по хирургии. Результаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 79, NULL, NULL),
(4147, 3, 'Укомплектованность структурного подразделения врачами-специалистами не менее 75 % по физическим лицам (для городских поликлиник). Наличие врача-специалиста (для районных поликлиник)', 1, 79, NULL, NULL),
(4148, 4, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам', 1, 79, NULL, NULL),
(4149, 5, 'Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего', 1, 79, NULL, NULL),
(4150, 6, 'Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 79, NULL, NULL),
(4151, 7, 'Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев. Медицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 79, NULL, NULL),
(4152, 8, 'Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков. Медицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 79, NULL, NULL),
(4153, 9, 'Врачи-оториноларингологи прошли повышение квалификации или стажировку на рабочем месте по профилю оказываемой медицинской помощи в структурном подразделении', 1, 79, NULL, NULL),
(4154, 10, 'Обеспечено соблюдение требований к профилактике инфекционных заболеваний при проведении хирургических и оперативных вмешательств, перевязок (пп. 154-163 Постановление Совета Министров Республики Беларусь от 3 марта 2020 г. № 130 «Специфические санитарно-эпидемические требования к содержанию и эксплуатации организаций здравоохранения, иных организаций и индивидуальных предпринимателей, которых осуществляют медицинскую, фармацевтическую деятельность»)', 1, 79, NULL, NULL),
(4155, 11, 'Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 79, NULL, NULL),
(4156, 12, 'Оснащение хирургического отделения и операционного блока медицинской техникой соответствует утвержденному табелю оснащения и соответствует объемам и видам оказываемой хирургической помощи', 2, 79, NULL, NULL),
(4157, 13, 'Структурное подразделение оснащено изделиями медицинского назначения и медицинской техникой в соответствии с Примерным табелем оснащения, установленным Министерством здравоохранения или табелем оснащения в объеме, достаточном для оказания специализированной медицинской помощи пациентам оториноларингологического профиля', 2, 79, NULL, NULL),
(4158, 14, 'Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание.', 3, 79, NULL, NULL),
(4159, 15, 'Порядок оказания медицинской помощи пациентам в структурном подразделении в стационарных условиях осуществляется на основании локального правового акта в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь', 2, 79, NULL, NULL),
(4160, 16, 'Обеспечена круглосуточная работа врачей-оториноларингологов при условии оказания экстренной специализированной помощи в структурном подразделении. В круглосуточном режиме, в том числе в выходные праздничные дни доступен осмотр дежурного врача', 2, 79, NULL, NULL),
(4161, 17, 'В организации здравоохранения обеспечено круглосуточное выполнение экстренных хирургических вмешательств, либо транспортировка пациента в другой стационар', 1, 79, NULL, NULL),
(4162, 18, 'Круглосуточно обеспечена возможность оказания анестезиолого-реанимационной помощи. Критерий применяется для структурных подразделений межрайонного, городского, областного, республиканского уровня', 1, 79, NULL, NULL),
(4163, 19, 'В организации здравоохранения обеспечивается необходимый объем и структура резервного запаса продуктов крови, ее компонентов, место и условия хранения, назначены ответственные медицинские работники', 1, 79, NULL, NULL),
(4164, 20, 'В структурном подразделении в обязательном порядке осуществляется направление операционного (биопсийного) материала и биологических жидкостей на патогистологическое (бактериологическое) исследование', 1, 79, NULL, NULL),
(4165, 21, 'Обеспечена преемственность с амбулаторно-поликлиническими организациями здравоохранения. Обеспечена передача эпикриза, содержащего рекомендации по дальнейшему медицинскому наблюдению в территориальную амбулаторно-поликлиническую организацию', 2, 79, NULL, NULL),
(4166, 22, 'В рамках получения пациентом стационарной помощи, в случаях, предусмотренных протоколами диагностики и лечения, обеспечена возможность проведения консультаций смежными врачами-специалистами, врачами-оториноларингологами, в том числе с использованием телемедицинских технологий, с использованием собственных ресурсов организации здравоохранения или другими организациями (центрами коллективного пользования, специализированными центрами) в соответствии с установленным порядком', 2, 79, NULL, NULL),
(4167, 23, 'Обеспечена возможность проведения лабораторных исследований в соответствии с клиническими протоколами диагностики и лечения', 1, 79, NULL, NULL),
(4168, 24, 'Обеспечена возможность проведения диагностики в соответствии с клиническими протоколами (в организации здравоохранения или определён порядок направления в другие организации здравоохранения)', 1, 79, NULL, NULL),
(4169, 25, 'Назначение лекарственных препаратов соответствует установленному диагнозу, требованиям клинических протоколов, инструкции по медицинскому применению лекарственного препарата', 1, 79, NULL, NULL),
(4170, 26, 'Оформление медицинской карты стационарного пациента соответствует установленной форме', 3, 79, NULL, NULL),
(4171, 27, 'В медицинской карте стационарного пациента оформлен предоперационный эпикриз, указываются обоснование хирургического вмешательства с учетом установленного диагноза, способа обезболивания, вида оперативного доступа, возможных рисков', 2, 79, NULL, NULL),
(4172, 28, 'Протоколы хирургических вмешательств оформляются в журнале записи оперативных вмешательств, либо в электронном виде с внесением в медицинскую карту стационарного пациента с описанием хода операции', 2, 79, NULL, NULL),
(4173, 29, 'В организации здравоохранения проводится анализ осложнений, вызванных медицинским вмешательством. Принимаются меры по устранению причин и условий, повлекших осложнения, вызванные медицинским вмешательством согласно Постановлению Минздрава РБ от 21.05.2021 № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 2, 79, NULL, NULL),
(4174, 30, 'Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 3, 79, NULL, NULL),
(4175, 31, 'Показатель среднегодовой занятости койки структурного подразделения на основании годовой отчетности за последние 3 года не менее 300', 3, 79, NULL, NULL),
(4176, 32, 'Показатель хирургической активности составляет не менее 50% для районного и межрайонного уровней, не менее 65% - для областного, не менее 80% - для РНПЦ. При недовыполнении уровня показателя проводится анализ и предоставляются данные с указанием причин невыполнения', 2, 79, NULL, NULL),
(4177, 33, 'Показатель выполнения оперативных вмешательств детям под общим обезболиванием составляет для районного уровня не менее 25%, областного – не менее 70%, республиканского не менее 90%', 2, 79, NULL, NULL),
(4178, 34, 'Обеспечена возможность проведения диагностических исследований ЛОР патологии методами КТ, МРТ или определен порядок направления пациентов на данные исследования', 1, 79, NULL, NULL),
(4179, 35, 'Обеспечено проведение рентгенологических исследований ЛОР органов (носоглотки, околоносовых пазух) – для районного и межрайонного уровня, (носоглотки, околоносовых пазух, гортани, височных костей) – для областного и республиканского уровней', 1, 79, NULL, NULL),
(4180, 36, 'Показатель выполнения высокотехнологичных хирургических вмешательств составляет не менее 30 % для областного уровня (45% для РНПЦ). При недостижении указанного уровня проводится анализ и предоставляются данные с указанием причин невыполнения', 3, 79, NULL, NULL),
(4181, 37, 'Показатель выполнения слухоулучшающих хирургических вмешательств на ухе составляет не менее 30% от операций на ухе для областного уровня (не менее 70% для РНПЦ). При недостижении указанного уровня проводится анализ и предоставляются данные с указанием причин невыполнения', 3, 79, NULL, NULL),
(4182, 38, 'Выполнение планов оказания медицинской помощи по договорам с ГУЗО и комитетом по здравоохранению Минского городского исполнительного комитета, для РНПЦ', 3, 79, NULL, NULL),
(4183, 39, 'Осуществляется внедрение научных разработок и новых методов в практическое здравоохранение не менее 2 методов в год (для областного уровня)', 3, 79, NULL, NULL),
(4335, 1, 'В организации здравоохранения имеется локальный правовой акт, утверждающий порядок организации и проведения медицинской реабилитации, медицинской абилитации (далее - медицинская реабилитация), порядок направления на медицинскую реабилитацию, определено лицо, ответственное за организацию и проведение медицинской реабилитации в организации здравоохранения', 1, 80, NULL, NULL),
(4336, 2, 'Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. ', 3, 80, NULL, NULL),
(4337, 3, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей. Результаты анализа документируются, предоставляются лицу, ответственному за организацию медицинской реабилитации. Результаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению', 2, 80, NULL, NULL),
(4338, 4, 'Соответствие штатного расписания организации здравоохранения штатному нормативу обеспеченности врачами-реабилитологами, а также врачами-специалистами (врачом-физиотерапевтом, врачом лечебной физкультуры), специалистами со средним медицинским образованием по специальностям реабилитационного профиля, специалистами со средним медицинским образованием и высшим педагогическим образованием (инструктором-методистом физической реабилитации), специалистами с высшим педагогическим образованием (логопедом, психологом)', 1, 80, NULL, NULL),
(4339, 5, 'Укомплектованность специалистами реабилитационного профиля (врачом-реабилитологом, врачом физиотерапевтом, врачом лечебной физкультуры) с высшим медицинским образованием по физическим лицам не менее 75%', 1, 80, NULL, NULL),
(4340, 6, 'В организации здравоохранения соблюдается порядок и установленные сроки направления пациентов на медицинскую реабилитацию в соответствии с порядком организации и проведения медицинской реабилитации, медицинской абилитации и перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на медицинскую реабилитацию, медицинскую абилитацию (при обслуживании взрослого населения), порядком организации и проведения медицинской реабилитации, пациентов в возрасте до 18 лет и перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на раннюю медицинскую реабилитацию в стационарных условиях, перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на повторную медицинскую реабилитацию в стационарных условиях, перечнем общих медицинских противопоказаний для проведения медицинской реабилитации, перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на медицинскую реабилитацию в амбулаторных условиях (при обслуживании детского населения)', 2, 80, NULL, NULL),
(4341, 7, 'Оформляется согласие на простое медицинское вмешательство или отказ от проведения медицинской реабилитации и (или) применения методов медицинской реабилитации пациентом или его законным представителем', 3, 80, NULL, NULL),
(4342, 8, 'Медицинская реабилитация осуществляется в соответствии с порядком организации и проведения медицинской реабилитации, медицинской абилитации пациента (при обслуживании взрослого населения), порядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет (при обслуживании детского населения), клиническими протоколами по профилям заболеваний, состояниям, синдромам, методами оказания медицинской помощи, соответствующими профилю оказываемой медицинской помощи, локальными нормативными актами, регламентирующими проведение медицинской реабилитации в организации здравоохранения', 1, 80, NULL, NULL),
(4343, 9, 'Определен порядок медицинской реабилитации на период отсутствия в организации здравоохранения врача-реабилитолога (районный, городской уровень)', 1, 80, NULL, NULL),
(4344, 10, 'Соблюдение сроков проведения медицинской реабилитации в соответствии с перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на медицинскую реабилитацию, медицинскую абилитацию (при обслуживании взрослого населения), перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на медицинскую реабилитацию в амбулаторных условиях, (при обслуживании детского населения) в 70 % случаях', 3, 80, NULL, NULL),
(4345, 11, 'Медицинский осмотр врачом-реабилитологом, врачами-специалистами проводится в соответствии с Инструкцией о порядке проведения медицинских осмотров, утвержденной постановлением Министерства здравоохранения Республики Беларусь от 21 декабря 2015 г. № 127, с оформлением записи в медицинских документах', 2, 80, NULL, NULL),
(4346, 12, 'Оценка степени выраженности нарушений функций органов и систем организма, обусловленных заболеваниями, до начала медицинской реабилитации и после ее окончания осуществляется в соответствии с классификацией основных видов нарушений функций органов и систем организма пациента, согласно приложению 2 к Инструкции о порядке освидетельствования (переосвидетельствования) пациентов (инвалидов) при проведении медико-социальной экспертизы, утвержденной постановлением Министерства здравоохранения Республики Беларусь от 9 июня 2021 г. № 77', 1, 80, NULL, NULL),
(4347, 13, 'Сформулирован клинико-функциональный диагноз основного и сопутствующих заболеваний на основании жалоб, анамнеза, данных объективного осмотра пациента, проведенной диагностики, в соответствии с Международной статистической классификацией болезней и проблем, связанных со здоровьем, десятого пересмотра (далее - МКБ-10) и (или) клиническими классификациями', 2, 80, NULL, NULL),
(4348, 14, 'Осуществляется оценка степени выраженности ограничений базовых категорий жизнедеятельности до начала медицинской реабилитации и после ее окончания в соответствии с классификацией основных категорий жизнедеятельности и степени выраженности их ограничений согласно приложению 1 к Инструкции о порядке освидетельствования (переосвидетельствования) пациентов (инвалидов) при проведении медико-социальной экспертизы, методом оценки ограничений жизнедеятельности при последствиях заболеваний и травм, состояниях у лиц в возрасте старше 18 лет (при обслуживании взрослого населения), методом оценки степени утраты здоровья у детей с неврологической, соматической и ортопедотравматологической патологией (при обслуживании детского населения)', 2, 80, NULL, NULL),
(4349, 15, 'Определяется реабилитационный потенциал в 100% случаях', 2, 80, NULL, NULL),
(4350, 16, 'Мероприятия медицинской реабилитации назначаются с учетом наличия медицинских показаний, реабилитационного потенциала и отсутствия медицинских противопоказаний к проведению медицинской реабилитации, медицинской абилитации или отдельным методам медицинской реабилитации', 2, 80, NULL, NULL),
(4351, 17, 'Индивидуальная программа медицинской реабилитации, абилитации пациента заполняется по форме согласно приложению 8 к постановлению Министерства здравоохранения Республики Беларусь от 9 июня 2021 г. № 77 «О вопросах проведения медико-социальной экспертизы» (далее - ИПМРАП) в соответствии с порядком организации и проведения медицинской реабилитации, медицинской абилитации (при обслуживании взрослого населения), порядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет (при обслуживании детского населения) в 100% случаях от подлежащих, ИПМРАП содержится в медицинской карте амбулаторного больного (истории развития ребенка)', 2, 80, NULL, NULL),
(4352, 18, 'Инвалиду ИПМРАП заполняется в соответствии с индивидуальной программой реабилитации, абилитации инвалида, ребенку-инвалиду ИПМРАП заполняется в соответствии с индивидуальной программой реабилитации, абилитации ребенка-инвалида', 2, 80, NULL, NULL),
(4353, 19, 'Составляется план медицинской реабилитации, медицинской абилитации пациента (далее – ПМР) в медицинской карте амбулаторного больного (истории развития ребенка) в соответствии с порядком организации и проведения медицинской реабилитации, медицинской абилитации (при обслуживании взрослого населения), порядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет (при обслуживании детского населения) в 100% случаях от подлежащих', 2, 80, NULL, NULL),
(4354, 20, 'Организовано выполнение, своевременная коррекция (при необходимости) ИПМРАП, ПМР, что отражается в медицинских документах', 2, 80, NULL, NULL),
(4355, 21, 'ИПМРАП регистрируется врачом-реабилитологом в журнале учета пациентов, на которых заполняется индивидуальная программа медицинской реабилитации, абилитации пациента (при обслуживании взрослого населения)', 3, 80, NULL, NULL),
(4356, 22, 'ПМР регистрируется врачом-реабилитологом (врачом-специалистом) в журнале учета пациентов, на которых заполняется план медицинской реабилитации, медицинской абилитации пациента (при обслуживании взрослого населения)', 3, 80, NULL, NULL),
(4357, 23, 'Удельный вес пациентов, которым назначена лечебная физкультура (далее - ЛФК), составляет не менее чем 70% от числа пациентов, поступивших в отделение медицинской реабилитации', 1, 80, NULL, NULL),
(4358, 24, 'Врачом ЛФК, врачом-специалистом назначаются процедуры ЛФК (механотерапии), эрготерапии с учетом установленного диагноза, медицинских показаний и медицинских противопоказаний, с оформлением назначений в медицинской карте амбулаторного больного (истории развития ребенка)', 2, 80, NULL, NULL),
(4359, 25, 'Заполняется форма 042/у «Карта лечащегося в кабинете лечебной физкультуры»', 3, 80, NULL, NULL),
(4360, 26, 'Оснащение зала (кабинета) ЛФК соответствует табелю оснащения, утвержденному локальным правовым актом, с учетом профиля оказания медицинской помощи', 1, 80, NULL, NULL),
(4361, 27, 'Врачом-физиотерапевтом назначаются физиотерапевтические процедуры, массаж с учетом установленного диагноза, медицинских показаний и медицинских противопоказаний к их назначению в соответствии с клиническими протоколами, инструкциями по медицинскому применению физиотерапевтических аппаратов (руководствами по эксплуатации), не менее чем 80 % пациентам, поступившим на медицинскую реабилитацию, с оформлением записи в медицинской карте амбулаторного больного (истории развития ребенка)', 2, 80, NULL, NULL),
(4362, 28, 'Заполняется форма № 044/у «Карта больного, лечащегося в физиотерапевтическом отделении (кабинете)»', 3, 80, NULL, NULL),
(4363, 29, 'В отделении (кабинете) физиотерапии, ЛФК заполняется форма №029/у «Журнал учета процедур»', 3, 80, NULL, NULL),
(4364, 30, 'Осуществляется оказание психотерапевтической и психологической помощи в соответствии с законодательством о здравоохранении, об оказании психиатрической помощи, об оказании психологической помощи с внесением сведений в медицинские документы пациента в соответствии с требованиями законодательства', 2, 80, NULL, NULL),
(4365, 31, 'Направление пациентов на последующий этап медицинской реабилитации осуществляется в соответствии с порядком организации и проведения медицинской реабилитации, медицинской абилитации и перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на медицинскую реабилитацию, медицинскую абилитацию (при обслуживании взрослого населения), порядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет и перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на раннюю медицинскую реабилитацию в стационарных условиях, перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на повторную медицинскую реабилитацию в стационарных условиях, перечнем общих медицинских противопоказаний для проведения медицинской реабилитации, (при обслуживании детского населения)', 3, 80, NULL, NULL),
(4366, 32, 'Организовано функционирование специализированных тематических школ (школ здоровья), осуществляется обучение членов семьи пациента отдельным элементам методов медицинской реабилитации', 3, 80, NULL, NULL),
(4367, 33, 'Осуществление оценки эффективности медицинской реабилитации с применением стандартизованных шкал, тестов, опросников с внесением результатов в медицинские документы пациента не менее чем в 80% случаях', 2, 80, NULL, NULL),
(4368, 34, 'В организации здравоохранения имеется возможность проведения врачебных консультаций (консилиумов) в соответствии с Инструкцией о порядке проведения врачебных консультаций (консилиумов), утвержденной постановлением Министерства здравоохранения Республики Беларусь от 20 декабря 2008 г. № 224, с применением телемедицинских технологий', 3, 80, NULL, NULL),
(4369, 35, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 80, NULL, NULL),
(4370, 36, 'Организован домашний этап медицинской реабилитации', 3, 80, NULL, NULL),
(4371, 37, 'Обеспечено выполнение функции врачебной должности не менее 90%', 2, 80, NULL, NULL),
(4372, 37, 'В организации здравоохранения имеется локальный правовой акт, утверждающий порядок организации и проведения медицинской реабилитации, медицинской абилитации (далее - медицинская реабилитация) пациентов возрасте до 18 лет, порядок направления на медицинскую реабилитацию, определены ответственные за организацию и проведение медицинской реабилитации в организации здравоохранения', 1, 80, NULL, NULL),
(4373, 38, 'Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. ', 3, 80, NULL, NULL),
(4374, 39, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей. Результаты анализа документируются, предоставляются лицу, ответственному за организацию медицинской реабилитации. Результаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению', 2, 80, NULL, NULL),
(4375, 40, 'Соответствие штатного расписания организации здравоохранения штатному нормативу обеспеченности врачами-реабилитологами, а также врачами-специалистами (врачом-физиотерапевтом, врачом лечебной физкультуры), специалистами со средним медицинским образованием по специальностям реабилитационного профиля, специалистами со средним медицинским образованием и высшим педагогическим образованием (инструктором-методистом физической реабилитации), специалистами с высшим педагогическим образованием (логопедом, психологом)', 1, 80, NULL, NULL),
(4376, 41, 'Укомплектованность специалистами реабилитационного профиля (врачом-реабилитологом, врачом- физиотерапевтом, врачом лечебной физкультуры) с высшим медицинским образованием по физическим лицам не менее 75%', 1, 80, NULL, NULL),
(4377, 42, 'В организации здравоохранения соблюдается порядок приема (отбор) пациентов на медицинскую реабилитацию в соответствии с порядком организации и проведения медицинской реабилитации пациентов возрасте до 18 лет и перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на медицинскую реабилитацию в амбулаторных условиях, перечнем общих медицинских противопоказаний для проведения медицинской реабилитации, локальным правовым актом', 1, 80, NULL, NULL),
(4378, 43, 'Оформляется согласие на простое медицинское вмешательство или отказ от проведения медицинской реабилитации и (или) применения методов медицинской реабилитации пациентом или его законным представителем', 3, 80, NULL, NULL),
(4379, 44, 'Медицинская реабилитация осуществляется в соответствии с порядком организации и проведения медицинской реабилитации пациентов возрасте до 18 лет, клиническими протоколами по профилям заболеваний, состояниям, синдромам, методами оказания медицинской помощи, соответствующими профилю оказываемой медицинской помощи, локальными нормативными актами, регламентирующими проведение медицинской реабилитации в организации здравоохранения', 1, 80, NULL, NULL),
(4380, 45, 'Соблюдение сроков проведения медицинской реабилитации в соответствии перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на медицинскую реабилитацию в амбулаторных условиях в 70 % случаях', 3, 80, NULL, NULL),
(4381, 46, 'Организована работа мультидисциплинарной реабилитационной бригады (далее - МДБ)', 1, 80, NULL, NULL),
(4382, 47, 'Медицинский осмотр врачом-реабилитологом, врачами-специалистами МДБ проводится в соответствии с Инструкцией о порядке проведения медицинских осмотров, утвержденной постановлением Министерства здравоохранения Республики Беларусь от 21 декабря 2015 г. № 127, с оформлением записи в медицинских документах', 1, 80, NULL, NULL),
(4383, 48, 'Оценка степени выраженности нарушений функций органов и систем организма, обусловленных заболеваниями, до начала медицинской реабилитации и после ее окончания осуществляется в соответствии с классификацией основных видов нарушений функций органов и систем организма пациента, согласно приложению 2 к Инструкции о порядке освидетельствования (переосвидетельствования) пациентов (инвалидов) при проведении медико-социальной экспертизы, утвержденной постановлением Министерства здравоохранения Республики Беларусь от 9 июня 2021 г. № 77', 1, 80, NULL, NULL),
(4384, 49, 'Сформулирован клинико-функциональный диагноз основного и сопутствующих заболеваний на основании жалоб, анамнеза, данных объективного осмотра пациента, проведенной диагностики, сведений, содержащихся в медицинских документах пациента, в соответствии с МКБ-10 и (или) клиническими классификациями', 2, 80, NULL, NULL),
(4385, 50, 'Осуществляется оценка степени выраженности ограничений базовых категорий жизнедеятельности до начала медицинской реабилитации и после ее окончания в соответствии с классификацией основных категорий жизнедеятельности и степени выраженности их ограничений согласно приложению 1 к Инструкции о порядке освидетельствования (переосвидетельствования) пациентов (инвалидов) при проведении медико-социальной экспертизы, методом оценки степени утраты здоровья у детей с неврологической, соматической и ортопедотравматологической патологией', 2, 80, NULL, NULL),
(4386, 51, 'Определяется реабилитационный потенциал в 100% случаях', 2, 80, NULL, NULL),
(4387, 52, 'Мероприятия медицинской реабилитации и назначаются с учетом наличия медицинских показаний, реабилитационного потенциала и отсутствия медицинских противопоказаний к проведению медицинской реабилитации или отдельным методам медицинской реабилитации', 2, 80, NULL, NULL),
(4388, 53, 'Индивидуальная программа медицинской реабилитации, абилитации пациента заполняется по форме согласно приложению 8 к постановлению Министерства здравоохранения Республики Беларусь от 9 июня 2021 г. № 77 «О вопросах проведения медико-социальной экспертизы» (далее - ИПМРАП) в соответствии с порядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет в 100% случаях', 2, 80, NULL, NULL),
(4389, 54, 'План медицинской реабилитации, медицинской абилитации пациента (далее – ПМР) составляется по форме согласно локальному правовому акту организации здравоохранения в медицинских документах пациента в соответствии с порядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет в 100% случаях', 2, 80, NULL, NULL),
(4390, 55, 'Организовано выполнение, своевременная коррекция (при необходимости) ИПМРАП, ПМР, что отражается в медицинских документах', 2, 80, NULL, NULL),
(4391, 56, 'Удельный вес пациентов, которым назначена лечебная физкультура (далее - ЛФК), составляет не менее чем 70% от числа пациентов, поступивших в отделение медицинской реабилитации', 2, 80, NULL, NULL),
(4392, 57, 'Врач-реабилитолог (врач-специалист) осуществляет медицинский осмотр пациента в течение курса медицинской реабилитации с оформлением дневника врачебных наблюдений не реже 1 раза в два дня', 2, 80, NULL, NULL),
(4393, 58, 'Врачом ЛФК, врачом-специалистом назначаются процедуры ЛФК (механотерапии), массажа, эрготерапии с учетом установленного диагноза, медицинских показаний и медицинских противопоказаний, с оформлением записи в медицинских документах', 2, 80, NULL, NULL),
(4394, 59, 'Заполняется форма 042/у «Карта лечащегося в кабинете лечебной физкультуры»', 3, 80, NULL, NULL),
(4395, 60, 'Оснащение зала (кабинета) ЛФК соответствует табелю оснащения, утвержденному локальным правовым актом, с учетом профиля оказания медицинской помощи', 1, 80, NULL, NULL),
(4396, 61, 'Врачом-физиотерапевтом назначаются физиотерапевтические процедуры, массаж с учетом установленного диагноза, медицинских показаний и медицинских противопоказаний к их назначению в соответствии с клиническими протоколами, инструкциями по медицинскому применению физиотерапевтических аппаратов (руководствами по эксплуатации), не менее чем 80 % пациентам, поступившим на медицинскую реабилитацию, с оформлением записи в медицинских документах', 2, 80, NULL, NULL),
(4397, 62, 'Заполняется форма № 044/у «Карта больного, лечащегося в физиотерапевтическом отделении (кабинете)»', 3, 80, NULL, NULL),
(4398, 63, 'В отделении (кабинете) физиотерапии, ЛФК заполняется форма №029/у «Журнал учета процедур»', 3, 80, NULL, NULL),
(4399, 64, 'Осуществляется оказание психотерапевтической и психологической помощи в соответствии с законодательством о здравоохранении, об оказании психиатрической помощи, об оказании психологической помощи с внесением сведений в медицинские документы пациента в соответствии с требованиями законодательства', 2, 80, NULL, NULL),
(4400, 65, 'Осуществление оценки эффективности медицинской реабилитации с применением стандартизованных шкал, тестов, опросников с внесением результатов в медицинские документы пациента не менее чем в 90% случаях', 2, 80, NULL, NULL),
(4401, 66, 'Оформление врачом-реабилитологом по окончании курса медицинской реабилитации выписки из медицинских документов с указанием клинико-функционального диагноза, результатов и эффективности медицинской реабилитации, рекомендаций на последующий этап медицинской реабилитации', 2, 80, NULL, NULL),
(4402, 67, 'Организовано функционирование специализированных тематических школ (школ здоровья), осуществляется обучение членов семьи пациента отдельным элементам методов медицинской реабилитации', 3, 80, NULL, NULL),
(4403, 68, 'В организации здравоохранения имеется возможность проведения врачебных консультаций (консилиумов) в соответствии с Инструкцией о порядке проведения врачебных консультаций (консилиумов), утвержденной постановлением Министерства здравоохранения Республики Беларусь от 20 декабря 2008 г. № 224, с применением телемедицинских технологий', 3, 80, NULL, NULL),
(4404, 69, 'Работа структурного подразделения обеспечена в сменном режиме', 2, 80, NULL, NULL),
(4405, 70, 'Соблюдается порядок проведения медицинской реабилитации в амбулаторных условиях. Руководителем структурного подразделения осуществляется анализ результатов медицинского наблюдения пациентов', 1, 80, NULL, NULL),
(4406, 72, 'Обеспечена возможность консультаций врачей-специалистов в соответствии с клиническими протоколами (в организации здравоохранения или определен порядок направления в другие организации здравоохранения)', 1, 80, NULL, NULL),
(4407, 73, 'Обеспечена возможность проведения диагностики в соответствии с клиническими протоколами (в организации здравоохранения или определен порядок направления в другие организации здравоохранения)', 1, 80, NULL, NULL),
(4408, 74, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 80, NULL, NULL),
(4409, 75, 'Обеспечено выполнение функции врачебной должности не менее 90%', 2, 80, NULL, NULL),
(4410, 76, 'В организации здравоохранения имеется локальный правовой акт, утверждающий порядок организации и проведения медицинской реабилитации, медицинской абилитации (далее - медицинская реабилитация), порядок направления на медицинскую реабилитацию, определены ответственные за организацию и проведение медицинской реабилитации  в организации здравоохранения', 1, 80, NULL, NULL),
(4411, 77, 'Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 80, NULL, NULL),
(4412, 78, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей. Результаты анализа документируются, предоставляются лицу, ответственному за организацию медицинской реабилитации. Результаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению', 2, 80, NULL, NULL),
(4413, 79, 'Укомплектованность специалистами реабилитационного профиля (врачом-реабилитологом, врачом- физиотерапевтом, врачом лечебной физкультуры) с высшим медицинским образованием по физическим лицам не менее 75%', 1, 80, NULL, NULL),
(4414, 80, 'В организации здравоохранения соблюдается порядок приема (отбора) пациентов на медицинскую реабилитацию в соответствии с порядком организации и проведения медицинской реабилитации, медицинской абилитации и перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на медицинскую реабилитацию (при обслуживании взрослого населения), порядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет и перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на медицинскую реабилитацию в амбулаторных условиях, перечнем общих медицинских противопоказаний для проведения медицинской реабилитации (при обслуживании детского населения неврологического, ортопедотравматологического профилей) локальным правовым актом', 2, 80, NULL, NULL);
INSERT INTO `mark` (`id_mark`, `str_num`, `mark_name`, `mark_class`, `id_criteria`, `date_close`, `date_open`) VALUES
(4415, 81, 'Оформляется согласие на простое медицинское вмешательство или отказ от проведения медицинской реабилитации и (или) применения методов медицинской реабилитации пациента или его законного представителя', 3, 80, NULL, NULL),
(4416, 82, 'Медицинская реабилитация осуществляется в соответствии с порядком организации и проведения медицинской реабилитации, медицинской абилитации (при обслуживании взрослого населения), порядком организации и проведения медицинской реабилитации пациентов в возрасте до 18 лет (при обслуживании детского населения неврологического, ортопедотравматологического профилей), клиническими протоколами по профилям заболеваний, состояниям, синдромам, методами оказания медицинской помощи, соответствующими профилю оказываемой медицинской помощи, локальными нормативными актами, регламентирующими проведение медицинской реабилитации в организации здравоохранения', 1, 80, NULL, NULL),
(4417, 83, 'Соблюдение сроков проведения медицинской реабилитации в соответствии с перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на медицинскую реабилитацию, медицинскую абилитацию (при обслуживании взрослого населения), перечнем медицинских показаний и медицинских противопоказаний для направления пациентов на медицинскую реабилитацию в амбулаторных условиях, (при обслуживании детского населения) в 70 % случаях', 3, 80, NULL, NULL),
(4418, 84, 'Организована работа мультидисциплинарной реабилитационной бригады (далее - МДБ)', 3, 80, NULL, NULL),
(4419, 85, 'Медицинский осмотр врачом-реабилитологом, врачами-специалистами МДБ проводится в соответствии с Инструкцией о порядке проведения медицинских осмотров, утвержденной постановлением Министерства здравоохранения Республики Беларусь от 21 декабря 2015 г. № 127, с оформлением записи в медицинских документах', 2, 80, NULL, NULL),
(4420, 86, 'Оценка степени выраженности нарушений функций органов и систем организма, обусловленных заболеваниями, до начала медицинской реабилитации и после ее окончания осуществляется в соответствии с классификацией основных видов нарушений функций органов и систем организма пациента, согласно приложению 2 к Инструкции о порядке освидетельствования (переосвидетельствования) пациентов (инвалидов) при проведении медико-социальной экспертизы, утвержденной постановлением Министерства здравоохранения Республики Беларусь от 9 июня 2021 г. № 77', 2, 80, NULL, NULL),
(4421, 87, 'Сформулирован клинико-функциональный диагноз основного и сопутствующих заболеваний на основании жалоб, анамнеза, данных объективного осмотра пациента, сведений, содержащихся в медицинских документах пациента, в соответствии с МКБ-10 и (или) клиническими классификациями', 2, 80, NULL, NULL),
(4422, 88, 'Осуществляется оценка степени выраженности ограничений базовых категорий жизнедеятельности до начала медицинской реабилитации и после ее окончания в соответствии с классификацией основных категорий жизнедеятельности и степени выраженности их ограничений согласно приложению 1 к Инструкции о порядке освидетельствования (переосвидетельствования) пациентов (инвалидов) при проведении медико-социальной экспертизы, Методом оценки ограничений жизнедеятельности при последствиях заболеваний и травм, состояниях у лиц в возрасте старше 18 лет, Методом оценки степени утраты здоровья у детей с неврологической, соматической и ортопедотравматологической патологией', 2, 80, NULL, NULL),
(4423, 89, 'Определяется реабилитационный потенциал в 100% случаях', 2, 80, NULL, NULL),
(4424, 90, 'Мероприятия медицинской реабилитации назначаются с учетом наличия медицинских показаний, реабилитационного потенциала и отсутствия медицинских противопоказаний к проведению медицинской реабилитации или отдельным методам медицинской реабилитации', 2, 80, NULL, NULL),
(4425, 91, 'Составляется план медицинской реабилитации, абилитации пациента (далее – ПМР) в медицинских документах пациента и заполняется форма ПМР, утвержденная локальным правовым актом организации здравоохранения, в 100% случаях', 2, 80, NULL, NULL),
(4426, 92, 'Организовано выполнение, своевременная коррекция (при необходимости) ПМР, что отражается в медицинских документах', 2, 80, NULL, NULL),
(4427, 93, 'ПМР регистрируется врачом-реабилитологом (врачом-специалистом) в журнале учета пациентов, на которых заполняется план медицинской реабилитации, медицинской абилитации пациента (при обслуживании взрослого населения)', 2, 80, NULL, NULL),
(4428, 94, 'Удельный вес пациентов, которым назначена лечебная физкультура (далее - ЛФК), составляет не менее чем 70% от числа пациентов, поступивших в отделение медицинской реабилитации', 2, 80, NULL, NULL),
(4429, 95, 'Врачом-специалистом назначаются процедуры ЛФК (механотерапии)  эрготерапии с учетом установленного диагноза, медицинских показаний и медицинских противопоказаний, с оформлением назначений в медицинских документах пациента', 1, 80, NULL, NULL),
(4430, 96, 'В структурных подразделениях о заполняется форма №029/у «Журнал учета процедур»', 3, 80, NULL, NULL),
(4431, 97, 'Заполняется форма 042/у «Карта лечащегося в кабинете лечебной физкультуры»', 3, 80, NULL, NULL),
(4432, 98, 'Оснащение зала (кабинета) ЛФК соответствует табелю оснащения, утвержденному локальным правовым актом', 1, 80, NULL, NULL),
(4433, 99, 'Врачом-физиотерапевтом (врачами-специалистами) назначаются физиотерапевтические процедуры, массаж с учетом установленного диагноза, медицинских показаний и медицинских противопоказаний к их назначению в соответствии с клиническими протоколами, инструкциями по медицинскому применению физиотерапевтических аппаратов (руководствами по эксплуатации), не менее чем 80 % пациентам, поступившим на медицинскую реабилитацию, с оформлением записи в медицинских документах', 2, 80, NULL, NULL),
(4434, 100, 'Заполняется форма № 044/у «Карта больного, лечащегося в физиотерапевтическом отделении (кабинете)»', 3, 80, NULL, NULL),
(4435, 101, 'Осуществляется оказание психотерапевтической и психологической помощи в соответствии с законодательством о здравоохранении, об оказании психиатрической помощи, об оказании психологической помощи с внесением сведений в медицинские документы пациента в соответствии с требованиями законодательства', 2, 80, NULL, NULL),
(4436, 102, 'Осуществление оценки эффективности медицинской реабилитации с применением стандартизованных шкал, тестов, опросников с внесением результатов в медицинские документы пациента не менее чем в 90% случаях', 2, 80, NULL, NULL),
(4437, 103, 'Оформление врачом-реабилитологом по окончании курса медицинской реабилитации выписки из медицинских документов с указанием клинико-функционального диагноза, результатов и эффективности медицинской реабилитации, рекомендаций на последующий этап медицинской реабилитации', 2, 80, NULL, NULL),
(4438, 104, 'Работа структурного подразделения обеспечена в сменном режиме', 2, 80, NULL, NULL),
(4439, 105, 'Соблюдается порядок организации медицинской реабилитации в амбулаторных условиях. Руководителем структурного подразделения осуществляется анализ результатов медицинского наблюдения пациентов', 1, 80, NULL, NULL),
(4440, 106, 'Обеспечена возможность консультаций врачей-специалистов в соответствии с клиническими протоколами (в организации здравоохранения или определен порядок направления в другие организации здравоохранения)', 1, 80, NULL, NULL),
(4441, 107, 'Обеспечена возможность проведения диагностики в соответствии с клиническими протоколами (в организации здравоохранения или определен порядок направления в другие организации здравоохранения)', 1, 80, NULL, NULL),
(4442, 108, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 80, NULL, NULL),
(4443, 109, 'Организовано функционирование специализированных тематических школ (школ здоровья), осуществляется обучение членов семьи пациента отдельным элементам методов медицинской реабилитации', 3, 80, NULL, NULL),
(4444, 110, 'Обеспечено выполнение функции врачебной должности не менее 90%', 2, 80, NULL, NULL),
(4465, 1, 'Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 81, NULL, NULL),
(4466, 2, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей. \nРезультаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по эндокринологии.\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 81, NULL, NULL),
(4467, 3, 'Укомплектованность структурного подразделения врачами-эндокринологами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей-эндокринологов укомплектованность не менее 96 % по занятым должностям ', 1, 81, NULL, NULL),
(4468, 4, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям ', 1, 81, NULL, NULL),
(4469, 5, 'Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего ', 1, 81, NULL, NULL),
(4470, 6, 'Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 81, NULL, NULL),
(4471, 7, 'Наличие первой, высшей категории у врачей-эндокринологов:\nне менее 50 % на областном уровне\nне менее 80 % на республиканском уровне', 3, 81, NULL, NULL),
(4472, 8, 'Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев. \nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 81, NULL, NULL),
(4473, 9, 'Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков. \nМедицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи ', 3, 81, NULL, NULL),
(4474, 10, 'Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 81, NULL, NULL),
(4475, 11, 'Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой ', 2, 81, NULL, NULL),
(4476, 12, 'Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 81, NULL, NULL),
(4477, 13, 'В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники.\nПроведение обучения документируется', 3, 81, NULL, NULL),
(4478, 14, 'Порядок оказания медицинской помощи в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь.\nСоблюдается порядок (алгоритмы) оказания скорой и плановой медицинской помощи при эндокринной патологии', 2, 81, NULL, NULL),
(4479, 15, 'Работа структурного подразделения обеспечена в сменном режиме', 2, 81, NULL, NULL),
(4480, 16, 'Определен порядок оказания медицинской помощи пациентам с эндокринными заболеваниями на период отсутствия в организации здравоохранения врача-специалиста (районный, городской уровень)', 1, 81, NULL, NULL),
(4481, 17, 'Соблюдается порядок медицинского наблюдения пациентов с эндокринными заболеваниями в амбулаторных условиях. Руководителем структурного подразделения осуществляется анализ результатов медицинского наблюдения пациентов', 1, 81, NULL, NULL),
(4482, 18, 'Обеспечена преемственность с больничными организациями здравоохранения. Определен порядок направления на плановую и экстренную госпитализацию пациентов эндокринологического профиля. Обеспечено выполнение на амбулаторном этапе рекомендаций по дальнейшему медицинскому наблюдению после выписки', 2, 81, NULL, NULL),
(4483, 19, 'После консультации пациентов врачом-эндокринологом пациенту предоставляется медицинский документ (выписка из медицинских документов, медицинская справка о состоянии здоровья)', 2, 81, NULL, NULL),
(4484, 20, 'Обеспечена возможность консультаций врачей-специалистов в соответствии с клиническими протоколами диагностики и лечения (в организации здравоохранения или определён порядок направления в другие организации здравоохранения)', 1, 81, NULL, NULL),
(4485, 21, 'Оформление медицинской карты амбулаторного больного соответствует установленной форме', 3, 81, NULL, NULL),
(4486, 22, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 81, NULL, NULL),
(4487, 23, 'Осуществляется выписка электронных рецептов на лекарственные средства', 2, 81, NULL, NULL),
(4488, 24, 'Для врачей-специалистов структурного подразделения обеспечена доступность проведения телемедицинского консультирования, результаты которого документируется', 2, 81, NULL, NULL),
(4489, 25, 'Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 3, 81, NULL, NULL),
(4490, 26, 'Обеспечено выполнение функции врачебной должности не менее 90 %', 2, 81, NULL, NULL),
(4491, 27, 'Ежегодное обновление сведений в республиканском регистре «Сахарный диабет» о пациентах с сахарным диабетом, состоящих под медицинским наблюдением в организации здравоохранения с ежеквартальной передачей на областной уровень (районный/ городской уровень)', 3, 81, NULL, NULL),
(4492, 28, 'Свод и анализ информации республиканского регистра «Сахарный диабет» с ежеквартальной передачей данных на республиканский уровень (областной уровень)', 3, 81, NULL, NULL),
(4493, 29, 'Свод и анализ качества ведения республиканского регистра «Сахарный диабет» (республиканский уровень)', 3, 81, NULL, NULL),
(4494, 30, 'Сформирована, укомплектована и доступна укладка «Комы при сахарном диабете» (районный/городской, межрайонный, областной, республиканский уровень)', 1, 81, NULL, NULL),
(4495, 31, 'Организован и функционирует кабинет «Диабетическая стопа» (областной уровень)', 1, 81, NULL, NULL),
(4496, 32, 'Укомплектованность медицинскими работниками, оснащенность кабинета «Диабетическая стопа» соответствует нормативным документам (межрайонный, областной уровень)', 1, 81, NULL, NULL),
(4497, 33, 'Уровень высоких ампутаций составляет не выше 0,05 (областной уровень)', 3, 81, NULL, NULL),
(4498, 34, 'Удельный вес посещений пациентов – жителей районного/городского уровня среди консультативных посещений врачей-эндокринологов областного уровня – не менее 50 %', 2, 81, NULL, NULL),
(4499, 35, 'Удельный вес посещений пациентов – жителей регионов (кроме г. Минска) среди консультативных посещений врачей-эндокринологов республиканского уровня – не менее 65 %', 2, 81, NULL, NULL),
(4500, 36, 'Организовано проведение консультаций профессорско-преподавательского состава кафедр эндокринологии, акушерства и гинекологии, хирургии, неврологии и нейрохирургии УО «БГМУ», ГУО «БелМАПО», УО «ГомГМУ» (республиканский уровень)', 2, 81, NULL, NULL),
(4501, 37, 'Организовано проведение Республиканских консилиумов по назначению препаратов соматропина, гонадотропин-рилизинг гормона, аналогов соматостатина, аналогов инсулина у взрослых (республиканский уровень)', 1, 81, NULL, NULL),
(4502, 38, 'Организовано взаимодействие с организациями здравоохранения, осуществляющими хирургическое лечение пациентов с заболеваниями эндокринной системы (ГУ «РНПЦ неврологии и нейрохирургии», Республиканский центр опухолей щитовидной железы, ГУ «РНПЦ онкологии и медицинской радиологии им.Н.Н.Александрова», ГУ «РНПЦ радиационной медицины и экологии человека») (республиканский уровень)', 2, 81, NULL, NULL),
(4503, 39, 'Организован отбор пациентов для проведения радиойодтерапии (республиканский уровень)', 2, 81, NULL, NULL),
(4504, 40, 'Удельный вес посещений пациентов с «редкой» эндокринной патологией среди посещений врачей-эндокринологов – не менее 50 % (республиканский уровень)', 2, 81, NULL, NULL),
(4505, 41, 'Участие работников организации в обучении слушателей циклов повышения квалификации по эндокринологии, ультразвуковой диагностике в эндокринологии, организованных УО «БГМУ», ГУО «БелМАПО» (республиканский уровень)', 3, 81, NULL, NULL),
(4506, 42, 'Организация и проведение научно-практических конференций по актуальным вопросам диагностики и лечения заболеваний эндокринной системы (республиканский уровень)', 2, 81, NULL, NULL),
(4507, 43, 'Организация и проведение круглых столов, мастер-классов по актуальным вопросам диагностики и лечения заболеваний эндокринной системы (республиканский уровень)', 2, 81, NULL, NULL),
(4508, 44, 'Разработка нормативных документов по улучшению организации эндокринологической службы республики (республиканский уровень)', 2, 81, NULL, NULL),
(4509, 45, 'Организована возможность проведения исследования гликированного гемоглобина для пациентов с сахарным диабетом в соответствии с клиническими протоколами диагностики и лечения (районный/городской, областной, республиканский уровень)', 1, 81, NULL, NULL),
(4510, 46, 'Организована возможность проведения лабораторного исследования тироидных гормонов в соответствии с клиническими протоколами диагностики и лечения (районный/городской, областной, республиканский уровень)', 1, 81, NULL, NULL),
(4511, 47, 'Организована возможность проведения лабораторного исследования половых гормонов в соответствии с клиническими протоколами диагностики и лечения (областной, республиканский уровень) ', 1, 81, NULL, NULL),
(4512, 48, 'Организована возможность проведения лабораторного исследования редких гормонов в соответствии с клиническими протоколами диагностики и лечения (республиканский уровень)', 1, 81, NULL, NULL),
(4513, 49, 'Организована возможность проведения инструментальных исследований в соответствии с клиническими протоколами диагностики и лечения (в организации здравоохранения или определен порядок направления в другие организации здравоохранения) (районный/городской, областной, республиканский уровень)', 1, 81, NULL, NULL),
(4514, 50, 'Организовано проведение тонкоигольной пункционной аспирационной биопсии щитовидной железы (областной, республиканский уровень)', 1, 81, NULL, NULL),
(4515, 51, 'Организовано проведение постоянного мониторирования гликемии (республиканский уровень)', 3, 81, NULL, NULL),
(4516, 52, 'Выписка лекарственных препаратов на льготной/бесплатной основе в соответствии с перечнем основных лекарственных средств, Республиканским формуляром лекарственных средств (районный/городской, областной уровень)', 3, 81, NULL, NULL),
(4517, 53, 'Врач-эндокринолог проводит лечение пациентов с эндокринными заболеваниями в соответствии с клиническими протоколами диагностики и лечения (районный/городской, областной, республиканский уровень)', 1, 81, NULL, NULL),
(4518, 54, 'Организован кабинет помповой инсулинотерапии (республиканский уровень)', 3, 81, NULL, NULL),
(4519, 55, 'Организовано внедрение современных технологий в ведении пациентов с заболеваниями эндокринной системы (областной, республиканский уровень)', 2, 81, NULL, NULL),
(4520, 56, 'Организована работа «Школы сахарного диабета» (районный/городской, областной, республиканский уровень)', 2, 81, NULL, NULL),
(4521, 57, 'Осуществляется формирование заявки на годовую закупку лекарственных средств инсулина (областной, республиканский уровень)', 2, 81, NULL, NULL),
(4522, 58, 'Осуществляется контроль обоснованности назначения аналогов инсулина и расходования препаратов инсулина при лекарственном обеспечении пациентов с сахарным диабетом (районный/городской межрайонный, областной, республиканский уровень)', 2, 81, NULL, NULL),
(4523, 59, 'Осуществляется обеспечение медицинскими изделиями (тест-полоски, глюкометр, иглы для шприц-ручек) пациентов с сахарным диабетом, состоящих под медицинским наблюдением в организации здравоохранения (районный/городской, областной, республиканский уровень)', 2, 81, NULL, NULL),
(4528, 1, 'Деятельность структурного подразделения осуществляется в соответствии с утвержденным Положением о структурном подразделении, работники ознакомлены с положением о структурном подразделении', 3, 84, NULL, NULL),
(4529, 2, 'Руководителем организации здравоохранения определены ответственные лица за организацию оказания фтизиатрической помощи пациентам в амбулаторных условиях', 3, 84, NULL, NULL),
(4530, 3, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей.\nРезультаты анализа документируются, предоставляются ответственному лицу, используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 84, NULL, NULL),
(4531, 4, 'Квалификация медицинских работников структурного подразделения соответствует требованиям должностной инструкции к занимаемой должности служащего', 2, 84, NULL, NULL),
(4532, 5, 'Укомплектованность структурного подразделения врачами-фтизиатрами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей-фтизиатров укомплектованность не менее 96 % по занятым должностям', 1, 84, NULL, NULL),
(4533, 6, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 84, NULL, NULL),
(4534, 7, 'Наличие квалификационных категорий у врачей-фтизиатров, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 84, NULL, NULL),
(4535, 8, 'В соответствии с утвержденным штатным расписание на каждую должность медицинского работника руководителем организации здравоохранения утверждена должностная инструкция с указанием квалификационных требований и функций, прав и обязанностей медицинских работников. Медицинские работники ознакомлены с должностной инструкцией', 2, 84, NULL, NULL),
(4536, 9, 'Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев.\nМедицинские работники владеют соответствующими навыками при проведении реанимационных мероприятий', 1, 84, NULL, NULL),
(4537, 10, 'Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков, имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 84, NULL, NULL),
(4538, 11, 'Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 84, NULL, NULL),
(4539, 12, 'Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой в объеме, достаточном для оказания медицинской помощи в соответствии с профилем отделения, уровнем оказания медицинской помощи', 2, 84, NULL, NULL),
(4540, 13, 'В организации здравоохранения на пациента оформляется медицинская карта амбулаторного больного по форме, установленной Министерством здравоохранения Республики Беларусь и (или) иные медицинские документы, установленные ЛПА', 2, 84, NULL, NULL),
(4541, 14, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 84, NULL, NULL),
(4542, 15, 'Осуществляется выписка электронных рецептов на лекарственные средства', 2, 84, NULL, NULL),
(4543, 16, 'Обеспечена непрерывность лечения туберкулеза у пациентов, переходящих со стационарного на амбулаторный этап (ведется карта лечения пациента, обеспечен письменный обмен информацией о планирующейся выписке пациента между организациями здравоохранения, оказывающими помощь в стационарных и амбулаторных условиях)', 3, 84, NULL, NULL),
(4544, 17, 'Организован контролируемый прием противотуберкулезных лекарственных препаратов в присутствии медицинского работника.', 3, 84, NULL, NULL),
(4545, 18, 'Организовано проведение дистанционного контроля приема противотуберкулезных лекарственных препаратов пациентами, находящимися на видео-контролируемом лечении', 3, 84, NULL, NULL),
(4546, 19, 'Обеспечено проведение работы по сбору мокроты: наличие мест для сбора мокроты, обучение пациента правилам сбора мокроты, соблюдение правил хранения и транспортировки собранной мокроты', 2, 84, NULL, NULL),
(4547, 20, 'Обеспечено наличие и использование компрессорного небулайзера для получения индуцированной мокроты (при отсутствии мокроты/скудности ее выделения/при сухом кашле)', 1, 84, NULL, NULL),
(4548, 21, 'Обеспечено проведение иммунологической диагностики туберкулеза путем постановки и оценки кожных аллергических тестов: туберкулиновой кожной пробы или кожной пробы с аллергеном туберкулиновым рекомбинантным.', 2, 84, NULL, NULL),
(4549, 22, 'Проводится работа по медицинскому наблюдению и обследованию лиц, контактных с больным туберкулезом', 2, 84, NULL, NULL),
(4550, 23, 'Проводится заполнение и динамическое ведение «Карта наблюдения за очагом туберкулезной инфекции» с отражением характеристики очага и проводимых в нем мероприятий', 1, 84, NULL, NULL),
(4551, 24, 'Организована выдача наборов продуктов дополнительного высококалорийного питания пациентам с туберкулезом органов дыхания, находящимся на контролируемом амбулаторном лечении туберкулеза', 2, 84, NULL, NULL),
(4552, 25, 'Организовано проведение динамического наблюдения подлежащих пациентов с соблюдением контрольных сроков и объемов обследования, организацией лечения в соответствии с клиническим протоколом ', 3, 84, NULL, NULL),
(4553, 26, 'Обеспечена непрерывность медицинского наблюдения и лечения больных туберкулезом, освобождающихся из мест лишения свободы', 2, 84, NULL, NULL),
(4554, 27, 'Деятельность структурного подразделения осуществляется в соответствии с утвержденным положением о структурном подразделении, работники ознакомлены с положением о структурном подразделении', 3, 84, NULL, NULL),
(4555, 28, 'Руководителем организации здравоохранения определены ответственные лица за организацию оказания фтизиатрической помощи пациентам в амбулаторных условиях', 3, 84, NULL, NULL),
(4556, 29, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей.\nРезультаты анализа документируются, предоставляются ответственному лицу, используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 84, NULL, NULL),
(4557, 30, 'Укомплектованность структурного подразделения врачами-фтизиатрами не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей врачей-фтизиатров укомплектованность не менее 96 % по занятым должностям', 1, 84, NULL, NULL),
(4558, 31, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 84, NULL, NULL),
(4559, 32, 'Наличие квалификационных категорий у врачей-фтизиатров, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 84, NULL, NULL),
(4560, 33, 'В соответствии с утвержденным штатным расписание на каждую должность медицинского работника руководителем организации здравоохранения утверждена должностная инструкция с указанием квалификационных требований и функций, прав и обязанностей медицинских работников. Медицинские работники ознакомлены с должностной инструкцией', 2, 84, NULL, NULL),
(4561, 34, 'Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев.\nМедицинские работники владеют соответствующими навыками при проведении реанимационных мероприятий', 1, 84, NULL, NULL),
(4562, 35, 'Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков, имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 84, NULL, NULL),
(4563, 36, 'Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 84, NULL, NULL),
(4564, 37, 'Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой в объеме, достаточном для оказания медицинской помощи в соответствии с профилем отделения, уровнем оказания медицинской помощи', 2, 84, NULL, NULL),
(4565, 38, 'В организации здравоохранения на пациента оформляется медицинская карта амбулаторного больного по форме, установленной Министерством здравоохранения Республики Беларусь и (или) иные медицинские документы, установленные ЛПА', 2, 84, NULL, NULL),
(4566, 39, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 84, NULL, NULL),
(4567, 40, 'Осуществляется выписка электронных рецептов на лекарственные средства', 2, 84, NULL, NULL),
(4568, 41, 'Работа структурного подразделения обеспечена в сменном режиме (2 смены, включая выходные дни)', 2, 84, NULL, NULL),
(4569, 42, 'Установление диагноза «туберкулез» или наличия латентной туберкулезной инфекции осуществляется в соответствии с требованиями клинического протокола', 2, 84, NULL, NULL),
(4570, 43, 'Организовано проведение лечения больных туберкулезом в соответствии с клиническим протоколом', 3, 84, NULL, NULL),
(4571, 44, 'Обеспечена непрерывность лечения туберкулеза у пациентов, переходящих со стационарного на амбулаторный этап', 3, 84, NULL, NULL),
(4572, 45, 'Обеспечен ежедневный прием всей дозы ПТЛП под непосредственным наблюдением медицинского работника в условиях, удобных для пациента', 3, 84, NULL, NULL),
(4573, 46, 'Организован дистанционный контроль приема противотуберкулезных лекарственных препаратов пациентами, находящимися на видео-контролируемом лечении', 3, 84, NULL, NULL),
(4574, 47, 'Обеспечено проведение работы по сбору мокроты: наличие мест для сбора мокроты, обучение пациента правилам сбора мокроты, соблюдение правил хранения и транспортировки собранной мокроты', 2, 84, NULL, NULL),
(4575, 48, 'Обеспечено наличие и использование компрессорного небулайзера для получения индуцированной мокроты (при отсутствии мокроты/скудности ее выделения/при сухом кашле)', 1, 84, NULL, NULL),
(4576, 49, 'Организовано проведение иммунологической диагностики туберкулеза путем постановки и оценки кожных аллергических тестов: туберкулиновой кожной пробы или кожной пробы с аллергеном туберкулиновым рекомбинантным', 2, 84, NULL, NULL),
(4577, 50, 'Организовано проведение работы по медицинскому наблюдению и обследованию лиц, контактных с больным туберкулезом', 2, 84, NULL, NULL),
(4578, 51, 'Проводится заполнение и динамическое ведение карты очага туберкулезной инфекции с отражением характеристики очага и проводимых в нем мероприятий', 1, 84, NULL, NULL),
(4579, 52, 'Обеспечена выдача наборов продуктов дополнительного высококалорийного питания пациентам, находящимся на контролируемом лечении туберкулеза', 2, 84, NULL, NULL),
(4580, 53, 'Организовано проведение диспансеризации подлежащих пациентов с соблюдением контрольных сроков обследования и наблюдения, организацией лечения в соответствии с клиническим протоколом', 3, 84, NULL, NULL),
(4581, 54, 'Обеспечена непрерывность медицинского наблюдения и лечения больных туберкулезом, освобождающихся из мест лишения свободы', 3, 84, NULL, NULL),
(4582, 55, 'Обеспечено проведение телемедицинского консультирования пациентов фтизиатрического профиля, результаты которого документируется и находится в медицинской карте', 2, 84, NULL, NULL),
(4583, 56, 'Организовано внесение учетных данных пациентов с туберкулезом в государственный регистр «Туберкулез»', 1, 84, NULL, NULL),
(4584, 57, 'Деятельность структурного подразделения осуществляется в соответствии с утвержденным положением о структурном подразделении, имеется ознакомление работников с положением о структурном подразделении', 3, 84, NULL, NULL),
(4585, 58, 'Руководителем организации здравоохранения определены ответственные лица за организацию оказания фтизиатрической помощи', 3, 84, NULL, NULL),
(4586, 59, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей.\nРезультаты анализа документируются, предоставляются ответственному лицу, используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 84, NULL, NULL),
(4587, 60, 'Укомплектованность структурного подразделения врачами-фтизиатрами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей-фтизиатров укомплектованность не менее 96 % по занятым должностям', 1, 84, NULL, NULL),
(4588, 61, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 84, NULL, NULL),
(4589, 62, 'Наличие квалификационных категорий у врачей-фтизиатров, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 84, NULL, NULL),
(4590, 63, 'В соответствии с утвержденным штатным расписание на каждую должность медицинского работника руководителем организации здравоохранения утверждена должностная инструкция с указанием квалификационных требований и функций, прав и обязанностей медицинских работников. Медицинские работники ознакомлены с должностной инструкцией', 2, 84, NULL, NULL),
(4591, 64, 'Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев.\nМедицинские работники владеют соответствующими навыками при проведении реанимационных мероприятий', 1, 84, NULL, NULL),
(4592, 65, 'Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков, имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 84, NULL, NULL),
(4593, 66, 'Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 84, NULL, NULL),
(4594, 67, 'Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой в объеме, достаточном для оказания медицинской помощи в соответствии с профилем отделения, уровнем оказания медицинской помощи', 2, 84, NULL, NULL),
(4595, 68, 'В организации здравоохранения на пациента оформляется медицинская карта амбулаторного больного по форме, установленной Министерством здравоохранения Республики Беларусь и (или) иные медицинские документы, установленные ЛПА', 2, 84, NULL, NULL),
(4596, 69, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 84, NULL, NULL),
(4597, 70, 'Осуществляется выписка электронных рецептов на лекарственные средства', 2, 84, NULL, NULL),
(4598, 71, 'Работа структурного подразделения обеспечена в сменном режиме (2 смены, включая выходные дни)', 2, 84, NULL, NULL),
(4599, 72, 'Обеспечено установление диагноза туберкулез или наличия латентной туберкулезной инфекции на основании эпидемиологических, клинических, лабораторных и иных данных в соответствии с требованиями клинического протокола', 2, 84, NULL, NULL),
(4600, 73, 'Организовано проведения фармакотерапии больных туберкулезом в соответствии с требованиями клинического протокола', 3, 84, NULL, NULL),
(4601, 74, 'Обеспечена непрерывность лечения туберкулеза у пациентов, переходящих со стационарного на амбулаторный этап', 3, 84, NULL, NULL),
(4602, 75, 'Организован контролируемый прием противотуберкулезных лекарственных препаратов в присутствии медицинского работника', 3, 84, NULL, NULL),
(4603, 76, 'Организован дистанционный контроль приема противотуберкулезных лекарственных препаратов пациентами, находящимися на видео-контролируемом лечении', 3, 84, NULL, NULL),
(4604, 77, 'Обеспечено проведение работы по сбору мокроты: наличие мест для сбора мокроты, обучение пациента правилам сбора мокроты, соблюдение правил хранения и транспортировки собранной мокроты', 3, 84, NULL, NULL),
(4605, 78, 'Обеспечено наличие и использование компрессорного небулайзера для получения индуцированной мокроты (при отсутствии мокроты/скудности ее выделения/при сухом кашле)', 1, 84, NULL, NULL),
(4606, 79, 'Организовано проведение иммунологической диагностики туберкулеза путем постановки и оценки кожных аллергических тестов: туберкулиновой кожной пробы или кожной пробы с аллергеном туберкулиновым рекомбинантным', 2, 84, NULL, NULL),
(4607, 80, 'Имеется возможность проведения иммунологических тестов для диагностики туберкулеза: IGRA-тесты (иммунологические методы, основанные на стимуляции Т-лимфоцитов пептидными антигенами и выработке интерферона–?, секретируемого клетками крови инфицированного МБТ человека), или тестов, основанных на количественной оценке сенсибилизированных Т-лимфоцитов в ответ на стимуляцию пептидными антигенами, которые присутствуют в нуклеотидной последовательности M.tuberculosis, но при этом отсутствуют у всех штаммов BCG  и большинства нетуберкулезных микобактерий), или тестов, основанных на оценке продукции интерферона-гамма (IFN-?) после стимуляции сенсибилизированных Т-клеток', 2, 84, NULL, NULL),
(4608, 81, 'Организовано проведение работы по медицинскому наблюдению и обследованию лиц, контактных с больным туберкулезом', 2, 84, NULL, NULL),
(4609, 82, 'Осуществляется заполнение и динамическое ведение карты очага туберкулезной инфекции с отражением характеристики очага и проводимых в нем мероприятий', 1, 84, NULL, NULL),
(4610, 83, 'Организована выдача наборов продуктов дополнительного высококалорийного питания пациентам, находящимся на контролируемом лечении туберкулеза', 2, 84, NULL, NULL),
(4611, 84, 'Организовано проведение диспансеризации подлежащих пациентов с соблюдением контрольных сроков обследования и наблюдения, организацией лечения в соответствии с клиническим протоколом', 3, 84, NULL, NULL),
(4612, 85, 'Обеспечена непрерывность медицинского наблюдения и лечения больных туберкулезом, освобождающихся из мест лишения свободы', 3, 84, NULL, NULL),
(4613, 86, 'Обеспечено проведение телемедицинского консультирования пациентов фтизиатрического профиля, результаты которого документируется и находится в медицинской карте', 2, 84, NULL, NULL),
(4614, 87, 'Обеспечено внесение учетных данных пациентов с туберкулезом в государственный регистр «Туберкулез»', 1, 84, NULL, NULL),
(4615, 88, 'Организована работа Республиканского консилиума по МЛУ-ТБ', 1, 84, NULL, NULL),
(4655, 1, 'Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 71, NULL, NULL),
(4656, 2, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей. \nРезультаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по хирургии.\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 71, NULL, NULL),
(4657, 3, 'Укомплектованность структурного подразделения врачами-специалистами не менее 75 % по физическим лицам (для городских поликлиник).\nНаличие врача-специалиста (для районных поликлиник)', 1, 71, NULL, NULL),
(4658, 4, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам', 1, 71, NULL, NULL),
(4659, 5, 'Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего ', 1, 71, NULL, NULL),
(4660, 6, 'Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 71, NULL, NULL),
(4661, 7, 'Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев. \nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 71, NULL, NULL),
(4662, 8, 'Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков. \nМедицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи ', 3, 71, NULL, NULL),
(4663, 9, 'Врачи-хирурги, работающие в центральных районных больницах, прошли повышение квалификации или стажировку на рабочем месте по профилю оказываемой медицинской помощи в структурном подразделении (травматология, урология, детская хирургия, сосудистая хирургия и др.)', 1, 71, NULL, NULL),
(4664, 10, 'Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 71, NULL, NULL),
(4665, 11, 'Структурное подразделение оснащено изделиями медицинского назначения, расходными материалами в достаточном количестве для оказания специализированной медицинской помощи на период не менее 6 месяцев для всех уровней', 1, 71, NULL, NULL),
(4666, 12, 'В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники.\nПроведение обучения документируется', 3, 71, NULL, NULL),
(4667, 13, 'Порядок оказания медицинской помощи в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь.\nСоблюдается порядок (алгоритмы) оказания скорой и плановой медицинской помощи при хирургической патологии', 2, 71, NULL, NULL),
(4668, 14, 'Работа структурного подразделения обеспечена в сменном режиме ', 2, 71, NULL, NULL),
(4669, 15, 'В структурном подразделении в обязательном порядке осуществляется направление операционного (биопсийного) материала и биологических жидкостей на патогистологическое (бактериологическое) исследование', 1, 71, NULL, NULL),
(4670, 16, 'Соблюдается порядок медицинского наблюдения пациентов с хирургическими заболеваниями в амбулаторных условиях. Руководителем структурного подразделения осуществляется анализ результатов медицинского наблюдения пациентов', 1, 71, NULL, NULL),
(4671, 17, 'Обеспечена преемственность с больничными организациями здравоохранения. Определен порядок направления на плановую и экстренную госпитализацию пациентов хирургического профиля. Обеспечено выполнение на амбулаторном этапе рекомендаций по дальнейшему медицинскому наблюдению после выписки ', 2, 71, NULL, NULL),
(4672, 18, 'Обеспечена возможность консультаций врачей-специалистов в соответствии с клиническими протоколами диагностики и лечения (в организации здравоохранения или определён порядок направления в другие организации здравоохранения)', 1, 71, NULL, NULL),
(4673, 19, 'Обеспечена возможность проведения лабораторных исследований: в соответствии с клиническими протоколами диагностики и лечения', 1, 71, NULL, NULL),
(4674, 20, 'В организации здравоохранения обеспечено проведение лабораторных и инструментальных исследований (функциональная диагностика, УЗИ, эндоскопия, рентгенография, есть возможность направления на КТ и МРТ).\nСрок ожидания плановых обследований не более 1 месяца, КТ, МРТ – не более 3 месяцев', 1, 71, NULL, NULL),
(4675, 21, 'Обеспечено назначение лечения пациентам в амбулаторных условиях согласно клиническим протоколам', 1, 71, NULL, NULL),
(4676, 22, 'В медицинской карте пациента, получающего медицинскую помощь в амбулаторных условиях, указываются обоснование оперативного вмешательства с учетом установленного диагноза', 3, 71, NULL, NULL),
(4677, 23, 'Протоколы хирургических вмешательств оформляются в журнале записи оперативных вмешательств', 3, 71, NULL, NULL),
(4678, 24, 'Выделены дни (время) для выполнения плановых оперативных вмешательств', 3, 71, NULL, NULL),
(4679, 25, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 71, NULL, NULL),
(4680, 26, 'Осуществляется выписка электронных рецептов на лекарственные средства', 2, 71, NULL, NULL),
(4681, 27, 'Для врачей-специалистов структурного подразделения обеспечена доступность проведения телемедицинского консультирования, результаты которого документируется и находится в медицинской карте ', 2, 71, NULL, NULL),
(4682, 28, 'Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 3, 71, NULL, NULL),
(4683, 29, 'Обеспечено выполнение функции врачебной должности не менее 90 % ', 2, 71, NULL, NULL),
(4686, 1, 'Деятельность структурного подразделения осуществляется в соответствии с положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении и имеют постоянный доступ к его содержанию', 3, 83, NULL, NULL);
INSERT INTO `mark` (`id_mark`, `str_num`, `mark_name`, `mark_class`, `id_criteria`, `date_close`, `date_open`) VALUES
(4687, 2, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей.  Результаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по гастроэнтерологии. Результаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 83, NULL, NULL),
(4688, 3, 'Укомплектованность структурного подразделения врачами-гастроэнтерологами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей-гастроэнтерологов укомплектованность не менее 96 % по занятым должностям ', 1, 83, NULL, NULL),
(4689, 4, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям ', 1, 83, NULL, NULL),
(4690, 5, 'Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего ', 1, 83, NULL, NULL),
(4691, 6, 'Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 83, NULL, NULL),
(4692, 7, 'Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев. Медицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 83, NULL, NULL),
(4693, 8, 'Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков. Медицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи ', 3, 83, NULL, NULL),
(4694, 9, 'Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 83, NULL, NULL),
(4695, 10, 'Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой ', 2, 83, NULL, NULL),
(4696, 11, 'Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 83, NULL, NULL),
(4697, 12, 'В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники.   Проведение обучения документируется', 3, 83, NULL, NULL),
(4698, 13, 'Порядок оказания медицинской помощи в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь. Соблюдается порядок (алгоритмы, «дорожные карты») оказания срочной и плановой медицинской помощи при гастроэнтерологической патологии', 2, 83, NULL, NULL),
(4699, 14, 'Обеспечена круглосуточная работа врачей-гастроэнтерологов при условии оказания экстренной специализированной помощи в структурном подразделении. В круглосуточном режиме, в том числе в выходные праздничные дни доступен осмотр дежурного врача', 2, 83, NULL, NULL),
(4700, 15, 'Круглосуточно обеспечена возможность оказания анестезиолого-реанимационной помощи. Критерий применяется для структурных подразделений межрайонного, городского, областного, республиканского уровня', 1, 83, NULL, NULL),
(4701, 16, 'Обеспечена преемственность с амбулаторно-поликлиническими организациями здравоохранения. Обеспечена передача эпикриза, содержащего рекомендации по дальнейшему медицинскому наблюдению в территориальную амбулаторно-поликлиническую организацию', 2, 83, NULL, NULL),
(4702, 17, 'В рамках получения пациентом стационарной помощи, в случаях, предусмотренных протоколами диагностики и лечения, обеспечена возможность проведения консультаций врачей-специалистов, в том числе с использованием телемедицинских технологий, с использованием собственных ресурсов организации здравоохранения или другими организациями (центрами коллективного пользования, специализированными центрами) в соответствии с установленным порядком', 1, 83, NULL, NULL),
(4703, 18, 'Обеспечена возможность проведения лабораторных исследований в соответствии с клиническими протоколами диагностики и лечения', 1, 83, NULL, NULL),
(4704, 19, 'Обеспечена возможность проведения диагностики в соответствии с клиническими протоколами (в организации здравоохранения или определён порядок направления в другие организации здравоохранения)', 1, 83, NULL, NULL),
(4705, 20, 'Назначение лекарственных препаратов соответствует установленному диагнозу, требованиям клинических протоколов, инструкции по медицинскому применению лекарственного препарата ', 1, 83, NULL, NULL),
(4706, 21, 'Оформление медицинской карты стационарного пациента соответствует установленной форме', 3, 83, NULL, NULL),
(4707, 22, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 83, NULL, NULL),
(4708, 23, 'В структурном подразделении имеются условия для выписки электронных рецептов на лекарственные средства', 2, 83, NULL, NULL),
(4709, 24, 'Для врачей-специалистов структурного подразделения обеспечена доступность проведения телемедицинского консультирования, результаты которого документируется и находится в медицинской карте ', 2, 83, NULL, NULL),
(4710, 25, 'Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 3, 83, NULL, NULL),
(4711, 26, 'Показатель среднегодовой занятости койки структурного подразделения на основании годовой отчетности за последние 3 года не менее 300', 3, 83, NULL, NULL),
(4712, 27, 'Профильность работы структурного подразделения для районного и городского уровня оказания помощи не менее 60 %, для областного и республиканского не менее 80 %', 2, 83, NULL, NULL),
(4713, 28, 'В структурном подразделении выполняются запланированные объемы специализированной медицинской помощи, предоставляемой за счет бюджета (число проведенных койко-дней, средняя длительность лечения)', 3, 83, NULL, NULL),
(4714, 29, 'Планирование объемов медицинской помощи для структурных подразделений, являющихся межрайонными, осуществляется с учетом обеспечения равной доступности населению всех закрепленных территорий. Удельный вес пациентов закрепленных территорий для районного уровня не менее 30 %, для городского и областного уровня не менее 60 %', 2, 83, NULL, NULL),
(4715, 30, 'В структурном подразделении созданы условия для лиц с хроническими воспалительными заболеваниями кишечника: имеются санузлы из расчета 1 санузел на 3-4 пациента, санузлы оборудованы биде, имеются душевые кабины из расчета не менее 1 на 25 пациентов', 3, 83, NULL, NULL),
(4716, 31, 'В организации здравоохранения круглосуточно обеспечена возможность оказания хирургической помощи', 1, 83, NULL, NULL),
(4717, 32, 'Структурное подразделение обеспечено препаратами железа для внутривенной инфузии, энтеральным и парентеральным питанием, препаратами альбумина для пациентов с синдромом мальнутриции, препаратами биологической терапии для пациентов с воспалительными заболеваниями кишечника, мультиэнзимами с покрытием, устойчивым к соляной кислоте, содержащим не менее 10 тыс. ЕД липазы в одной капсуле/таблетке для пациентов с внешнесекреторной недостаточностью поджелудочной железы', 1, 83, NULL, NULL),
(4718, 33, 'Руководителем организации здравоохранения утверждается необходимый объем и структура резервного запаса (или его отсутствие) продуктов крови, ее компонентов, место и условия хранения, ответственные медицинские работники', 1, 83, NULL, NULL),
(4719, 34, 'Врачи-специалисты структурного подразделения обеспечены шкалами для оценки активности и степени тяжести гастроэнтерологических заболеваний', 2, 83, NULL, NULL),
(4720, 35, 'В организации здравоохранения обеспечено проведение КТ-энтерографии, эластографии/эластометрии печени для пациентов гастроэнтерологического профиля (или имеется установленный порядок направления пациентов в другие организации здравоохранения, согласованный с организацией здравоохранения, где исследования будут выполняться)', 1, 83, NULL, NULL),
(4721, 36, 'В организации здравоохранения обеспечено проведение эндосонографии*, импедансной рН-метрии*, манометрии*, энтероскопии* для пациентов гастроэнтерологического профиля* (или имеется установленный порядок направления пациентов в другие организации здравоохранения, согласованный с организацией здравоохранения, где исследования будут выполняться)', 1, 83, NULL, NULL),
(4722, 37, 'В организации здравоохранения обеспечено проведение лабораторных исследований для диагностики аутоиммунных и наследственных заболеваний органов пищеварения (или имеется установленный порядок направления пациентов в другие организации здравоохранения, согласованный с организацией здравоохранения, где исследования будут выполняться)', 1, 83, NULL, NULL),
(4723, 38, 'В организации здравоохранения обеспечено проведение лабораторных исследований для диагностики Clostridium difficile-ассоциированного колита, ЦМВ-колита и других кишечных инфекций (или имеется установленный порядок направления пациентов в другие организации здравоохранения, согласованный с организацией здравоохранения, где исследования будут выполняться)', 1, 83, NULL, NULL),
(4724, 39, 'В организации здравоохранения обеспечено выполнение биопсии печени* (или имеется установленный порядок направления пациентов в другие организации здравоохранения, согласованный с организацией здравоохранения, где исследования будут выполняться)', 1, 83, NULL, NULL),
(4725, 40, 'В организации здравоохранения в обязательном порядке осуществляется направление операционного (биопсийного) материала на патологоанатомическое исследование', 1, 83, NULL, NULL),
(4726, 41, 'В организации здравоохранения обеспечена возможность установки зонда для кормления нуждающимся пациентам', 2, 83, NULL, NULL),
(4727, 42, 'В организации здравоохранения обеспечено выполнение диагностического и лечебного парацентеза', 1, 83, NULL, NULL),
(4749, 1, 'Организована работа по забору биологического материала и его направлению на лабораторное исследование в целях выявления туберкулеза', 2, 85, NULL, NULL),
(4750, 2, 'Осуществляется выявление туберкулеза органов дыхания и других органов при оказании медицинской помощи госпитализированным пациентам', 2, 85, NULL, NULL),
(4751, 3, 'Деятельность структурного подразделения осуществляется в соответствии с утвержденным положением о структурном подразделении, имеется ознакомление работников с положением о структурном подразделении', 3, 85, NULL, NULL),
(4752, 4, 'Руководителем организации здравоохранения определены ответственные лица за организацию оказания фтизиатрической помощи', 3, 85, NULL, NULL),
(4753, 5, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, результаты работы рассматриваются на медицинских советах, производственных совещаниях, принимаются меры по устранению недостатков', 2, 85, NULL, NULL),
(4754, 6, 'Укомплектованность структурного подразделения врачами-фтизиатрами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей-фтизиатров укомплектованность не менее 96 % по занятым должностям', 1, 85, NULL, NULL),
(4755, 7, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям', 1, 85, NULL, NULL),
(4756, 8, 'Наличие квалификационных категорий у врачей-фтизиатров, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 85, NULL, NULL),
(4757, 9, 'Квалификация медицинских работников структурного подразделения соответствует требованиям должностной инструкции к занимаемой должности служащего', 2, 85, NULL, NULL),
(4758, 10, 'Медицинские работники проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев. Медицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 85, NULL, NULL),
(4759, 11, 'Медицинские работники на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков.\nМедицинские работники имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи', 3, 85, NULL, NULL),
(4760, 12, 'Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 85, NULL, NULL),
(4761, 13, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 85, NULL, NULL),
(4762, 14, 'Структурное подразделение оснащено изделиями медицинского назначения и медицинской техникой в соответствии с Примерным табелем оснащения, установленным Министерством здравоохранения или табелем оснащения, установленным локальным правовым актом, в объеме, достаточном для оказания специализированной медицинской помощи пациентам неврологического профиля', 3, 85, NULL, NULL),
(4763, 15, 'Наличие своевременной государственной поверки средств измерений', 2, 85, NULL, NULL),
(4764, 16, 'Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и (или) ремонтом. Техническое обслуживание и (или) ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на выполнение данных услуг', 1, 85, NULL, NULL),
(4765, 17, 'Порядок оказания медицинской помощи пациентам в структурном подразделении в стационарных условиях осуществляется на основании локального правового акта в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь', 2, 85, NULL, NULL),
(4766, 18, 'Круглосуточно обеспечена возможность оказания анестезиолого-реанимационной помощи. Критерий применяется для структурных подразделений межрайонного, городского, областного, республиканского уровня', 1, 85, NULL, NULL),
(4767, 19, 'Обеспечена преемственность с амбулаторно-поликлиническими организациями здравоохранения. Обеспечена передача эпикриза, содержащего рекомендации по дальнейшему медицинскому наблюдению в территориальную амбулаторно-поликлиническую организацию', 2, 85, NULL, NULL),
(4768, 20, 'Оформление медицинской карты стационарного пациента соответствует установленной форме', 3, 85, NULL, NULL),
(4769, 21, 'Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 2, 85, NULL, NULL),
(4770, 22, 'Обеспечена доступность проведения телемедицинского консультирования, результаты которого документируются\n и находятся в медицинской карте', 2, 85, NULL, NULL),
(4771, 23, 'Диагностика и лечение пациентов в стационарных условиях осуществляется согласно клиническим протоколам диагностики и лечения взрослого и детского населения и другим актам законодательства', 1, 85, NULL, NULL),
(4772, 24, 'При оказании медицинской помощи пациентам лечение и диагностические исследования проводятся в соответствии с клиническими протоколами', 1, 85, NULL, NULL),
(4773, 25, 'Круглосуточно обеспечена возможность оказания анестезиолого-реанимационной помощи. Критерий применяется для структурных подразделений межрайонного, городского, областного, республиканского уровня', 1, 85, NULL, NULL),
(4774, 26, 'Обеспечена преемственность с амбулаторно-поликлиническими организациями здравоохранения. Обеспечена передача эпикриза, содержащего рекомендации по дальнейшему медицинскому наблюдению в территориальную амбулаторно-поликлиническую организацию', 2, 85, NULL, NULL),
(4775, 27, 'В организации здравоохранения на пациента оформляется медицинская карта амбулаторного больного по форме, установленной Министерством здравоохранения Республики Беларусь и (или) иные медицинские документы, установленные ЛПА', 2, 85, NULL, NULL),
(4776, 28, 'Организовано проведение госпитализации больных легочными и внелегочными формами туберкулеза по эпидемиологическим, медицинским и социальным показаниям', 1, 85, NULL, NULL),
(4777, 29, 'Организовано лечение сопутствующих инфекционных и неинфекционных заболеваний и состояний у пациентов с туберкулезом', 2, 85, NULL, NULL),
(4778, 30, 'Обеспечено проведение обязательных и дополнительных диагностических мероприятий до начала и в процессе лечения туберкулеза всех локализаций с соблюдением требований клинического протокола', 2, 85, NULL, NULL),
(4779, 31, 'Имеется в наличии техническое и иное обеспечение, позволяющее проводить дифференциальную диагностику туберкулеза с другими заболеваниями легких и иных органов и систем', 3, 85, NULL, NULL),
(4780, 32, 'Осуществляется выполнение хирургических вмешательств в целях дифференциальной диагностики туберкулеза*', 2, 85, NULL, NULL),
(4781, 34, 'Организовано проведение работы по сбору биологического материала и проведению его специфических исследований', 3, 85, NULL, NULL),
(4782, 35, 'Обеспечено проведение мониторинга бактериовыделения и индивидуальной лекарственной чувствительности у пациентов с туберкулезом', 2, 85, NULL, NULL),
(4783, 36, 'Обеспечены своевременность, комплексность, длительность и непрерывность противотуберкулезного лечения в соответствии с требованиями клинического протокола', 3, 85, NULL, NULL),
(4784, 37, 'Организован контролируемый прием противотуберкулезных лекарственных препаратов в присутствии медицинского работника.', 3, 85, NULL, NULL),
(4785, 38, 'Проводится клинический мониторинг больных туберкулезом с оценкой данных бактериологических и лабораторных исследований', 2, 85, NULL, NULL),
(4786, 39, 'Осуществляется мониторинг нежелательных явлений в состоянии здоровья пациентов, получающих противотуберкулезные лекарственные препараты (далее – ПТЛП), и проведение соответствующей коррекции лечения', 2, 85, NULL, NULL),
(4787, 40, 'Организовано оказание паллиативной медицинской помощи больным туберкулезом*', 2, 85, NULL, NULL),
(4788, 41, 'Обеспечено проведение обоснованной, опирающейся на установленные клиническим протоколом критерии, выписки пациентов с туберкулезом', 1, 85, NULL, NULL),
(4789, 42, 'Имеются соответствующие условия и проводится контроль соблюдения условий для принудительного лечения и изоляции больных туберкулезом*', 1, 85, NULL, NULL),
(4790, 43, 'Организована работа сотрудников с использованием средств индивидуальной защиты органов дыхания соответствующего уровня', 2, 85, NULL, NULL),
(4791, 44, 'Обеспечен перевод пациентов в отделения (палаты), соответствующие степени контагиозности и эпидемической опасности после установления факта и обильности бацилловыделения, получения результатов теста на лекарственную чувствительность микобактерий туберкулеза.', 3, 85, NULL, NULL),
(4792, 45, 'Обеспечено наличие вентиляции, соответствующей зонированию помещений по степени эпидемической опасности, оснащение отделений, оказывающих медицинскую помощь пациентам с туберкулезом органов дыхания, приточно-вытяжной вентиляцией', 2, 85, NULL, NULL),
(4793, 46, 'Обеспечено проведение дезинфекции изделий медицинского назначения и объектов внешней среды дезинфицирующими средствами по туберкулоцидному режиму', 2, 85, NULL, NULL),
(4794, 47, 'Обеспечено удовлетворительное санитарно-гигиеническое состояние структурного подразделения', 2, 85, NULL, NULL),
(4795, 48, 'Организовано внесение учетных данных пациентов с туберкулезом в государственный регистр «Туберкулез»', 1, 85, NULL, NULL),
(4812, 1, 'Деятельность структурного подразделения осуществляется в cоответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 86, NULL, NULL),
(4813, 2, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей. Результаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по пульмонологии.Результаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 86, NULL, NULL),
(4814, 3, 'Укомплектованность структурного подразделения врачами-пульмонологами не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей врачей-пульмонологов укомплектованность не менее 96 % по занятым должностям ', 1, 86, NULL, NULL),
(4815, 4, 'Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75 % по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям ', 1, 86, NULL, NULL),
(4816, 5, 'Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего ', 1, 86, NULL, NULL),
(4817, 6, 'Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации', 2, 86, NULL, NULL),
(4818, 7, 'Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев. Медицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 86, NULL, NULL),
(4819, 8, 'Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков. Медицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи ', 3, 86, NULL, NULL),
(4820, 9, 'Руководителем структурного подразделения осуществляется контроль за соблюдением требований по охране труда, пожарной безопасности. Проводятся инструктажи с сотрудниками структурного подразделения, которые документируются. Разработаны инструкции по охране труда для профессий рабочих и (или) отдельных видов работ, инструкция по пожарной безопасности', 2, 86, NULL, NULL),
(4821, 10, 'Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой ', 2, 86, NULL, NULL),
(4822, 11, 'Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 86, NULL, NULL),
(4823, 12, 'В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники.  Проведение обучения документируется', 3, 86, NULL, NULL),
(4824, 13, 'Порядок оказания медицинской помощи в структурном утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь. Соблюдается порядок (алгоритмы) оказания скорой и плановой медицинской помощи при заболеваниях органов дыхания. В организации здравоохранения утвержден график приема врача-пульмонолога', 2, 86, NULL, NULL),
(4825, 14, 'Работа структурного подразделения обеспечена в сменном режиме ', 2, 86, NULL, NULL),
(4826, 15, 'Определен порядок оказания медицинской помощи пациентам с заболеваниями органов дыхания на период отсутствия в организации здравоохранения врача-пульмонолога', 1, 86, NULL, NULL),
(4827, 16, 'Соблюдается порядок медицинского наблюдения пациентов с заболеваниями органов дыхания в амбулаторных условиях. Руководителем структурного подразделения осуществляется анализ результатов медицинского наблюдения пациентов', 1, 86, NULL, NULL),
(4828, 17, 'Обеспечена преемственность с больничными организациями здравоохранения. Определен порядок направления на плановую и экстренную госпитализацию пациентов пульмонологического профиля. Обеспечено выполнение на амбулаторном этапе рекомендаций по дальнейшему медицинскому наблюдению после выписки ', 2, 86, NULL, NULL),
(4829, 18, 'Имеется возможность консультаций врачей-специалистов в соответствии с клиническими протоколами диагностики и лечения, сотрудников кафедр и организаций здравоохранения более высокого уровня или определен порядок направления пациентов к таким специалистам (в организации здравоохранения или определен порядок направления в другие организации здравоохранения)', 1, 86, NULL, NULL),
(4830, 19, 'Обеспечена возможность проведения лабораторных исследований в соответствии с клиническими протоколами диагностики и лечения', 1, 86, NULL, NULL),
(4831, 20, 'Обеспечена возможность проведения диагностики в соответствии с клиническими протоколами (в организации здравоохранения или определен порядок направления в другие организации здравоохранения)', 1, 86, NULL, NULL),
(4832, 21, 'Обеспечено назначение лечения пациентам в амбулаторных условиях согласно клиническим протоколам ', 1, 86, NULL, NULL),
(4833, 22, 'Оформление медицинской карты амбулаторного больного соответствует установленной форме', 3, 86, NULL, NULL),
(4834, 23, 'В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 86, NULL, NULL),
(4835, 24, 'Осуществляется выписка электронных рецептов на лекарственные средства', 2, 86, NULL, NULL),
(4836, 25, 'Для врачей-специалистов структурного подразделения обеспечена доступность проведения телемедицинского консультирования, результаты которого документируется и находится в медицинской карте ', 2, 86, NULL, NULL),
(4837, 26, 'Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»', 3, 86, NULL, NULL),
(4838, 27, 'Обеспечено выполнение функции врачебной должности не менее 90 % ', 2, 86, NULL, NULL),
(4839, 28, 'Обеспечена доступность спирометрического исследования, в том числе с проведением бронходилатационных тестов', 1, 86, NULL, NULL),
(4840, 29, 'Обеспечена доступность рентгенологического обследования, в том числе КТ для пациентов пульмонологического профиля, или определен порядок направления на эти диагностические исследования', 1, 86, NULL, NULL),
(4841, 30, 'Обеспечена доступность проведения плановых диагностических исследований (ФБС, ФГДС, УЗИ, МРТ, бодиплетизмографии) или определен порядок направления на эти диагностические исследования', 1, 86, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `mark_rating`
--

CREATE TABLE `mark_rating` (
  `id_mark_rating` int NOT NULL,
  `id_mark` int NOT NULL,
  `field4` int DEFAULT NULL COMMENT '1 - да 2 - нет 3 - не требуется',
  `field5` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `field6` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `field7` int DEFAULT NULL COMMENT '1 - да 2 - нет 3 - не требуется',
  `field8` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `id_subvision` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `mark_rating`
--

INSERT INTO `mark_rating` (`id_mark_rating`, `id_mark`, `field4`, `field5`, `field6`, `field7`, `field8`, `id_subvision`) VALUES
(121, 143, 2, '', '1212', NULL, NULL, 63),
(122, 144, 2, '', 'вввввввввв', NULL, NULL, 63),
(123, 145, 2, '', ' импраер', NULL, NULL, 63),
(124, 146, 1, '', '', NULL, NULL, 63),
(125, 147, 0, '', '', NULL, NULL, 63),
(126, 148, 0, '', '', NULL, NULL, 63),
(127, 149, 0, '', '', NULL, NULL, 63),
(128, 150, 0, '', '', NULL, NULL, 63),
(129, 151, 0, '', '', NULL, NULL, 63),
(130, 152, 0, '', '', NULL, NULL, 63),
(131, 153, 0, '', '', NULL, NULL, 63),
(132, 154, 0, '', '', NULL, NULL, 63),
(133, 155, 0, '', '', NULL, NULL, 63),
(134, 156, 0, '', '', NULL, NULL, 63),
(135, 157, 0, '', '', NULL, NULL, 63),
(136, 158, 1, '', '', NULL, NULL, 63),
(137, 159, 0, '', '', NULL, NULL, 63),
(138, 160, 0, '', '', NULL, NULL, 63),
(139, 161, 0, '', '', NULL, NULL, 63),
(140, 162, 0, '', '', NULL, NULL, 63),
(141, 163, 0, '', '', NULL, NULL, 63),
(142, 164, 0, '', '', NULL, NULL, 63),
(143, 165, 0, '', '', NULL, NULL, 63),
(144, 166, 0, '', '', NULL, NULL, 63),
(145, 167, 0, '', '', NULL, NULL, 63),
(146, 168, 0, '', '', NULL, NULL, 63),
(147, 169, 0, '', '', NULL, NULL, 63),
(148, 170, 0, '', '', NULL, NULL, 63),
(149, 171, 0, '', '', NULL, NULL, 63),
(150, 172, 0, '', '', NULL, NULL, 63),
(151, 173, 0, '', '', NULL, NULL, 63),
(152, 174, 0, '', '', NULL, NULL, 63),
(153, 175, 0, '', '', NULL, NULL, 63),
(154, 176, 0, '', '', NULL, NULL, 63),
(155, 177, 0, '', '', NULL, NULL, 63),
(156, 178, 0, '', '', NULL, NULL, 63),
(157, 179, 0, '', '', NULL, NULL, 63),
(158, 180, 0, '', '', NULL, NULL, 63),
(159, 181, 0, '', '', NULL, NULL, 63),
(160, 182, 0, '', '', NULL, NULL, 63),
(161, 183, 0, '', '', NULL, NULL, 63),
(162, 184, 0, '', '', NULL, NULL, 63),
(163, 185, 0, '', '', NULL, NULL, 63),
(164, 186, 0, '', '', NULL, NULL, 63),
(165, 187, 0, '', '', NULL, NULL, 63),
(166, 188, 0, '', '', NULL, NULL, 63),
(167, 189, 0, '', '', NULL, NULL, 63),
(168, 190, 0, '', '', NULL, NULL, 63),
(169, 191, 0, '', '', NULL, NULL, 63),
(170, 192, 0, '', '', NULL, NULL, 63),
(171, 193, 0, '', '', NULL, NULL, 63),
(172, 194, 0, '', '', NULL, NULL, 63),
(173, 195, 0, '', '', NULL, NULL, 63),
(174, 196, 0, '', '', NULL, NULL, 63),
(175, 197, 0, '', '', NULL, NULL, 63),
(176, 198, 0, '', '', NULL, NULL, 63),
(177, 199, 0, '', '', NULL, NULL, 63),
(178, 200, 0, '', '', NULL, NULL, 63),
(179, 201, 0, '', '', NULL, NULL, 63),
(180, 202, 0, '', '', NULL, NULL, 63),
(181, 203, 0, '', '', NULL, NULL, 63),
(182, 335, 1, '', '', 2, '', 63),
(183, 336, 1, '', '', 0, '', 63),
(184, 337, 1, '', '', 0, '', 63),
(185, 338, 2, '', '3434', 0, '', 63),
(186, 339, 1, '', '', 0, '', 63),
(187, 340, 1, '', '', 0, '', 63),
(188, 341, 1, '', '', 0, '', 63),
(189, 342, 1, '', '', 0, '', 63),
(190, 343, 1, '', '', 0, '', 63),
(191, 344, 1, '', '', 0, '', 63),
(192, 345, 1, '', '', 0, '', 63),
(193, 346, 1, '', '', 0, '', 63),
(194, 347, 1, '', '', 0, '', 63),
(195, 348, 1, '', '', 0, '', 63),
(196, 349, 1, '', '', 0, '', 63),
(197, 350, 1, '', '', 0, '', 63),
(198, 351, 1, '', '', 0, '', 63),
(199, 352, 1, '', '', 0, '', 63),
(200, 353, 1, '', '', 0, '', 63),
(201, 354, 1, '', '', 0, '', 63),
(202, 355, 1, '', '', 0, '', 63),
(203, 356, 1, '', '', 0, '', 63),
(204, 357, 1, '', '', 0, '', 63),
(205, 358, 1, '', '', 0, '', 63),
(206, 359, 1, '', '', 0, '', 63),
(207, 360, 1, '', '', 0, '', 63),
(208, 361, 1, '', '', 0, '', 63),
(209, 362, 1, '', '', 0, '', 63),
(210, 363, 1, '', '', 0, '', 63),
(211, 364, 1, '', '', 0, '', 63),
(212, 365, 1, '', '', 0, '', 63),
(213, 366, 1, '', '', 0, '', 63),
(214, 367, 1, '', '', 0, '', 63),
(215, 368, 1, '', '', 0, '', 63),
(216, 369, 1, '', '', 0, '', 63),
(217, 370, 1, '', '', 0, '', 63),
(218, 371, 1, '', '', 0, '', 63),
(219, 372, 1, '', '', 0, '', 63),
(220, 373, 1, '', '', 0, '', 63),
(221, 374, 1, '', '', 0, '', 63),
(222, 375, 1, '', '', 0, '', 63),
(223, 376, 1, '', '', 0, '', 63),
(224, 377, 1, '', '', 0, '', 63),
(225, 378, 1, '', '', 0, '', 63),
(226, 379, 1, '', '', 0, '', 63),
(227, 380, 1, '', '', 0, '', 63),
(228, 381, 1, '', '', 0, '', 63),
(229, 536, 0, '', '', NULL, NULL, 81),
(230, 537, 0, '', '', NULL, NULL, 81),
(231, 538, 0, '', '', NULL, NULL, 81),
(232, 539, 0, '', '', NULL, NULL, 81),
(233, 540, 2, '', '56', NULL, NULL, 81),
(234, 541, 2, '', '78', NULL, NULL, 81),
(235, 542, 0, '', '', NULL, NULL, 81),
(236, 543, 0, '', '', NULL, NULL, 81),
(237, 544, 0, '', '', NULL, NULL, 81),
(238, 545, 0, '', '', NULL, NULL, 81),
(239, 546, 0, '', '', NULL, NULL, 81),
(240, 547, 0, '', '', NULL, NULL, 81),
(241, 548, 0, '', '', NULL, NULL, 81),
(242, 549, 0, '', '', NULL, NULL, 81),
(243, 550, 0, '', '', NULL, NULL, 81),
(244, 551, 0, '', '', NULL, NULL, 81),
(245, 552, 0, '', '', NULL, NULL, 81),
(246, 553, 0, '', '', NULL, NULL, 81),
(247, 554, 0, '', '', NULL, NULL, 81),
(248, 555, 0, '', '', NULL, NULL, 81),
(249, 556, 0, '', '', NULL, NULL, 81),
(250, 557, 0, '', '', NULL, NULL, 81),
(251, 558, 0, '', '', NULL, NULL, 81),
(252, 559, 0, '', '', NULL, NULL, 81),
(253, 560, 0, '', '', NULL, NULL, 81),
(254, 561, 0, '', '', NULL, NULL, 81),
(255, 562, 0, '', '', NULL, NULL, 81),
(256, 563, 0, '', '', NULL, NULL, 81),
(257, 564, 0, '', '', NULL, NULL, 81),
(258, 565, 0, '', '', NULL, NULL, 81),
(259, 566, 0, '', '', NULL, NULL, 81),
(260, 567, 0, '', '', NULL, NULL, 81),
(261, 568, 0, '', '', NULL, NULL, 81),
(262, 569, 0, '', '', NULL, NULL, 81),
(263, 570, 0, '', '', NULL, NULL, 81),
(264, 571, 0, '', '', NULL, NULL, 81),
(265, 572, 0, '', '', NULL, NULL, 81),
(266, 573, 0, '', '', NULL, NULL, 81),
(267, 574, 0, '', '', NULL, NULL, 81),
(268, 575, 0, '', '', NULL, NULL, 81),
(269, 576, 0, '', '', NULL, NULL, 81),
(270, 577, 0, '', '', NULL, NULL, 81),
(271, 578, 0, '', '', NULL, NULL, 81),
(272, 579, 0, '', '', NULL, NULL, 81),
(273, 580, 0, '', '', NULL, NULL, 81),
(274, 581, 0, '', '', NULL, NULL, 81),
(275, 582, 0, '', '', NULL, NULL, 81),
(276, 583, 0, '', '', NULL, NULL, 81),
(277, 584, 0, '', '', NULL, NULL, 81),
(278, 585, 0, '', '', NULL, NULL, 81),
(279, 586, 0, '', '', NULL, NULL, 81),
(280, 587, 0, '', '', NULL, NULL, 81),
(281, 588, 0, '', '', NULL, NULL, 81),
(282, 589, 0, '', '', NULL, NULL, 81),
(283, 590, 0, '', '', NULL, NULL, 81),
(284, 591, 0, '', '', NULL, NULL, 81),
(285, 592, 0, '', '', NULL, NULL, 81),
(286, 593, 0, '', '', NULL, NULL, 81),
(287, 594, 0, '', '', NULL, NULL, 81),
(288, 595, 0, '', '', NULL, NULL, 81),
(289, 596, 0, '', '', NULL, NULL, 81),
(290, 597, 0, '', '', NULL, NULL, 81),
(291, 598, 0, '', '', NULL, NULL, 81),
(292, 599, 0, '', '', NULL, NULL, 81),
(293, 600, 0, '', '', NULL, NULL, 81),
(294, 601, 0, '', '', NULL, NULL, 81),
(295, 602, 0, '', '', NULL, NULL, 81),
(296, 603, 0, '', '', NULL, NULL, 81),
(297, 604, 0, '', '', NULL, NULL, 81),
(298, 605, 0, '', '', NULL, NULL, 81),
(299, 606, 0, '', '', NULL, NULL, 81),
(300, 607, 0, '', '', NULL, NULL, 81),
(301, 608, 0, '', '', NULL, NULL, 81),
(302, 609, 0, '', '', NULL, NULL, 81),
(303, 610, 0, '', '', NULL, NULL, 81),
(304, 611, 0, '', '', NULL, NULL, 81),
(305, 612, 0, '', '', NULL, NULL, 81),
(306, 613, 0, '', '', NULL, NULL, 81),
(307, 614, 0, '', '', NULL, NULL, 81),
(308, 615, 0, '', '', NULL, NULL, 81),
(309, 616, 0, '', '', NULL, NULL, 81),
(310, 617, 0, '', '', NULL, NULL, 81),
(311, 618, 0, '', '', NULL, NULL, 81),
(312, 619, 0, '', '', NULL, NULL, 81),
(313, 620, 0, '', '', NULL, NULL, 81),
(314, 621, 0, '', '', NULL, NULL, 81),
(315, 622, 0, '', '', NULL, NULL, 81),
(316, 623, 0, '', '', NULL, NULL, 81),
(317, 624, 0, '', '', NULL, NULL, 81),
(318, 625, 0, '', '', NULL, NULL, 81),
(319, 626, 0, '', '', NULL, NULL, 81),
(320, 627, 0, '', '', NULL, NULL, 81),
(321, 628, 0, '', '', NULL, NULL, 81),
(322, 629, 0, '', '', NULL, NULL, 81),
(323, 630, 0, '', '', NULL, NULL, 81),
(324, 631, 0, '', '', NULL, NULL, 81),
(325, 632, 0, '', '', NULL, NULL, 81),
(326, 633, 0, '', '', NULL, NULL, 81),
(327, 634, 0, '', '', NULL, NULL, 81),
(328, 635, 0, '', '', NULL, NULL, 81),
(329, 286, 1, '', '', NULL, NULL, 63),
(330, 287, 1, '', '', NULL, NULL, 63),
(331, 288, 1, '', '', NULL, NULL, 63),
(332, 289, 0, '', '', NULL, NULL, 63),
(333, 290, 0, '', '', NULL, NULL, 63),
(334, 291, 0, '', '', NULL, NULL, 63),
(335, 292, 0, '', '', NULL, NULL, 63),
(336, 293, 0, '', '', NULL, NULL, 63),
(337, 294, 0, '', '', NULL, NULL, 63),
(338, 295, 0, '', '', NULL, NULL, 63),
(339, 296, 0, '', '', NULL, NULL, 63),
(340, 297, 0, '', '', NULL, NULL, 63),
(341, 298, 0, '', '', NULL, NULL, 63),
(342, 299, 0, '', '', NULL, NULL, 63),
(343, 300, 0, '', '', NULL, NULL, 63),
(344, 301, 0, '', '', NULL, NULL, 63),
(345, 302, 0, '', '', NULL, NULL, 63),
(346, 303, 0, '', '', NULL, NULL, 63),
(347, 304, 0, '', '', NULL, NULL, 63),
(348, 305, 0, '', '', NULL, NULL, 63),
(349, 306, 0, '', '', NULL, NULL, 63),
(350, 307, 0, '', '', NULL, NULL, 63),
(351, 308, 0, '', '', NULL, NULL, 63),
(352, 309, 0, '', '', NULL, NULL, 63),
(353, 310, 0, '', '', NULL, NULL, 63),
(354, 311, 0, '', '', NULL, NULL, 63),
(355, 312, 0, '', '', NULL, NULL, 63),
(356, 313, 0, '', '', NULL, NULL, 63),
(357, 314, 0, '', '', NULL, NULL, 63),
(358, 315, 0, '', '', NULL, NULL, 63),
(359, 316, 0, '', '', NULL, NULL, 63),
(360, 317, 0, '', '', NULL, NULL, 63),
(361, 318, 0, '', '', NULL, NULL, 63),
(362, 319, 0, '', '', NULL, NULL, 63),
(363, 320, 0, '', '', NULL, NULL, 63),
(364, 321, 0, '', '', NULL, NULL, 63),
(365, 322, 0, '', '', NULL, NULL, 63),
(366, 323, 0, '', '', NULL, NULL, 63),
(367, 324, 0, '', '', NULL, NULL, 63),
(368, 325, 0, '', '', NULL, NULL, 63),
(369, 326, 0, '', '', NULL, NULL, 63),
(370, 327, 0, '', '', NULL, NULL, 63),
(371, 328, 0, '', '', NULL, NULL, 63),
(372, 329, 0, '', '', NULL, NULL, 63),
(373, 330, 0, '', '', NULL, NULL, 63),
(374, 331, 0, '', '', NULL, NULL, 63),
(375, 332, 0, '', '', NULL, NULL, 63),
(376, 333, 0, '', '', NULL, NULL, 63),
(377, 334, 0, '', '', NULL, NULL, 63),
(378, 251, 0, '', '', NULL, NULL, 63),
(379, 252, 2, '', 'ошл', NULL, NULL, 63),
(380, 253, 1, '', '', NULL, NULL, 63),
(381, 254, 2, '', '123', NULL, NULL, 63),
(382, 255, 0, '', '', NULL, NULL, 63),
(383, 256, 0, '', '', NULL, NULL, 63),
(384, 257, 0, '', '', NULL, NULL, 63),
(385, 258, 0, '', '', NULL, NULL, 63),
(386, 259, 0, '', '', NULL, NULL, 63),
(387, 260, 0, '', '', NULL, NULL, 63),
(388, 261, 0, '', '', NULL, NULL, 63),
(389, 262, 0, '', '', NULL, NULL, 63),
(390, 263, 0, '', '', NULL, NULL, 63),
(391, 264, 0, '', '', NULL, NULL, 63),
(392, 265, 0, '', '', NULL, NULL, 63),
(393, 266, 0, '', '', NULL, NULL, 63),
(394, 267, 0, '', '', NULL, NULL, 63),
(395, 268, 0, '', '', NULL, NULL, 63),
(396, 269, 0, '', '', NULL, NULL, 63),
(397, 270, 0, '', '', NULL, NULL, 63),
(398, 271, 0, '', '', NULL, NULL, 63),
(399, 272, 0, '', '', NULL, NULL, 63),
(400, 273, 0, '', '', NULL, NULL, 63),
(401, 274, 0, '', '', NULL, NULL, 63),
(402, 275, 0, '', '', NULL, NULL, 63),
(403, 276, 0, '', '', NULL, NULL, 63),
(404, 277, 0, '', '', NULL, NULL, 63),
(405, 278, 0, '', '', NULL, NULL, 63),
(406, 279, 0, '', '', NULL, NULL, 63),
(407, 280, 0, '', '', NULL, NULL, 63),
(408, 281, 0, '', '', NULL, NULL, 63),
(409, 282, 0, '', '', NULL, NULL, 63),
(410, 283, 0, '', '', NULL, NULL, 63),
(411, 284, 0, '', '', NULL, NULL, 63),
(412, 285, 0, '', '', NULL, NULL, 63),
(413, 454, 2, '', 'e', NULL, NULL, 81),
(414, 455, 1, '', '', NULL, NULL, 81),
(415, 456, 0, '', '', NULL, NULL, 81),
(416, 457, 0, '', '', NULL, NULL, 81),
(417, 458, 2, '', '11113333', NULL, NULL, 81),
(418, 459, 0, '', '', NULL, NULL, 81),
(419, 460, 0, '', '', NULL, NULL, 81),
(420, 461, 0, '', '', NULL, NULL, 81),
(421, 462, 0, '', '', NULL, NULL, 81),
(422, 463, 0, '', '', NULL, NULL, 81),
(423, 464, 0, '', '', NULL, NULL, 81),
(424, 465, 0, '', '', NULL, NULL, 81),
(425, 466, 0, '', '', NULL, NULL, 81),
(426, 467, 0, '', '', NULL, NULL, 81),
(427, 468, 0, '', '', NULL, NULL, 81),
(428, 469, 0, '', '', NULL, NULL, 81),
(429, 470, 0, '', '', NULL, NULL, 81),
(430, 471, 0, '', '', NULL, NULL, 81),
(431, 472, 0, '', '', NULL, NULL, 81),
(432, 473, 0, '', '', NULL, NULL, 81),
(433, 474, 0, '', '', NULL, NULL, 81),
(434, 475, 0, '', '', NULL, NULL, 81),
(435, 476, 0, '', '', NULL, NULL, 81),
(436, 477, 0, '', '', NULL, NULL, 81),
(437, 478, 0, '', '', NULL, NULL, 81),
(438, 479, 0, '', '', NULL, NULL, 81),
(439, 480, 0, '', '', NULL, NULL, 81),
(440, 481, 0, '', '', NULL, NULL, 81),
(441, 482, 0, '', '', NULL, NULL, 81),
(442, 483, 0, '', '', NULL, NULL, 81),
(443, 484, 0, '', '', NULL, NULL, 81),
(444, 485, 0, '', '', NULL, NULL, 81),
(445, 486, 0, '', '', NULL, NULL, 81),
(446, 487, 0, '', '', NULL, NULL, 81),
(447, 488, 0, '', '', NULL, NULL, 81),
(448, 489, 0, '', '', NULL, NULL, 81),
(449, 490, 0, '', '', NULL, NULL, 81),
(450, 491, 0, '', '', NULL, NULL, 81),
(451, 492, 0, '', '', NULL, NULL, 81),
(452, 493, 0, '', '', NULL, NULL, 81),
(453, 494, 0, '', '', NULL, NULL, 81),
(454, 495, 0, '', '', NULL, NULL, 81),
(455, 496, 0, '', '', NULL, NULL, 81),
(456, 251, 0, '', '', NULL, NULL, 81),
(457, 252, 3, '', '11111', NULL, NULL, 81),
(458, 253, 2, '', 'qqq', NULL, NULL, 81),
(459, 254, 2, '', 'aaa', NULL, NULL, 81),
(460, 255, 0, '', '', NULL, NULL, 81),
(461, 256, 0, '', '', NULL, NULL, 81),
(462, 257, 0, '', '', NULL, NULL, 81),
(463, 258, 0, '', '', NULL, NULL, 81),
(464, 259, 2, '', '12', NULL, NULL, 81),
(465, 260, 2, '', '3232', NULL, NULL, 81),
(466, 261, 0, '', '', NULL, NULL, 81),
(467, 262, 0, '', '', NULL, NULL, 81),
(468, 263, 0, '', '', NULL, NULL, 81),
(469, 264, 0, '', '', NULL, NULL, 81),
(470, 265, 0, '', '', NULL, NULL, 81),
(471, 266, 0, '', '', NULL, NULL, 81),
(472, 267, 0, '', '', NULL, NULL, 81),
(473, 268, 0, '', '', NULL, NULL, 81),
(474, 269, 0, '', '', NULL, NULL, 81),
(475, 270, 0, '', '', NULL, NULL, 81),
(476, 271, 0, '', '', NULL, NULL, 81),
(477, 272, 0, '', '', NULL, NULL, 81),
(478, 273, 0, '', '', NULL, NULL, 81),
(479, 274, 0, '', '', NULL, NULL, 81),
(480, 275, 0, '', '', NULL, NULL, 81),
(481, 276, 0, '', '', NULL, NULL, 81),
(482, 277, 0, '', '', NULL, NULL, 81),
(483, 278, 0, '', '', NULL, NULL, 81),
(484, 279, 0, '', '', NULL, NULL, 81),
(485, 280, 0, '', '', NULL, NULL, 81),
(486, 281, 0, '', '', NULL, NULL, 81),
(487, 282, 0, '', '', NULL, NULL, 81),
(488, 283, 0, '', '', NULL, NULL, 81),
(489, 284, 0, '', '', NULL, NULL, 81),
(490, 285, 0, '', '', NULL, NULL, 81),
(491, 251, 1, '', '', NULL, NULL, 83),
(492, 252, 1, '', '', NULL, NULL, 83),
(493, 253, 2, '', '123123123', NULL, NULL, 83),
(494, 254, 0, '', '', NULL, NULL, 83),
(495, 255, 0, '', '', NULL, NULL, 83),
(496, 256, 0, '', '', NULL, NULL, 83),
(497, 257, 0, '', '', NULL, NULL, 83),
(498, 258, 0, '', '', NULL, NULL, 83),
(499, 259, 0, '', '', NULL, NULL, 83),
(500, 260, 0, '', '', NULL, NULL, 83),
(501, 261, 0, '', '', NULL, NULL, 83),
(502, 262, 0, '', '', NULL, NULL, 83),
(503, 263, 0, '', '', NULL, NULL, 83),
(504, 264, 0, '', '', NULL, NULL, 83),
(505, 265, 0, '', '', NULL, NULL, 83),
(506, 266, 0, '', '', NULL, NULL, 83),
(507, 267, 0, '', '', NULL, NULL, 83),
(508, 268, 0, '', '', NULL, NULL, 83),
(509, 269, 0, '', '', NULL, NULL, 83),
(510, 270, 0, '', '', NULL, NULL, 83),
(511, 271, 0, '', '', NULL, NULL, 83),
(512, 272, 0, '', '', NULL, NULL, 83),
(513, 273, 0, '', '', NULL, NULL, 83),
(514, 274, 0, '', '', NULL, NULL, 83),
(515, 275, 0, '', '', NULL, NULL, 83),
(516, 276, 0, '', '', NULL, NULL, 83),
(517, 277, 0, '', '', NULL, NULL, 83),
(518, 278, 0, '', '', NULL, NULL, 83),
(519, 279, 0, '', '', NULL, NULL, 83),
(520, 280, 0, '', '', NULL, NULL, 83),
(521, 281, 0, '', '', NULL, NULL, 83),
(522, 282, 0, '', '', NULL, NULL, 83),
(523, 283, 0, '', '', NULL, NULL, 83),
(524, 284, 0, '', '', NULL, NULL, 83),
(525, 285, 0, '', '', NULL, NULL, 83);

-- --------------------------------------------------------

--
-- Структура таблицы `news`
--

CREATE TABLE `news` (
  `id_news` int NOT NULL,
  `path_img` text COLLATE utf8mb4_bin,
  `name_news` text COLLATE utf8mb4_bin,
  `text_news` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `date_news` text COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Дамп данных таблицы `news`
--

INSERT INTO `news` (`id_news`, `path_img`, `name_news`, `text_news`, `date_news`) VALUES
(1, NULL, 'Новость 0', NULL, '01.02.2023'),
(2, NULL, 'Загружены критерии по общим условиям оказания медицинской помощи', NULL, '17.07.2023'),
(3, NULL, 'Загружены критерии по видам и профилям оказания медицинской помощи', NULL, '17.07.2023'),
(4, NULL, 'Обращаем внимание: проводятся регламентные работы на сервере', NULL, '18.07.2023'),
(5, NULL, 'Обновлены критерии', NULL, '19.07.2023'),
(6, NULL, 'Начато опытное тестирование системы ИС «Медицинская аккредитация»', NULL, '24.07.2023');

-- --------------------------------------------------------

--
-- Структура таблицы `questions`
--

CREATE TABLE `questions` (
  `id_question` int NOT NULL,
  `question` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `id_user` int NOT NULL,
  `type_question` text COLLATE utf8mb4_bin,
  `file` text COLLATE utf8mb4_bin,
  `important` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Дамп данных таблицы `questions`
--

INSERT INTO `questions` (`id_question`, `question`, `answer`, `id_user`, `type_question`, `file`, `important`) VALUES
(1, 'Как зайти в систему?', 'Нужно нажать на кнопку войти в открывающейся вкладке в верхнем правом углу системы.', 3, NULL, NULL, 1),
(2, 'Где найти заявки?', 'Заявки можно найти в пункте меню Заявки', 3, NULL, NULL, 1),
(3, 'Сколько времени можно заполнять заявку?', 'На заполнение заявки дается один месяц', 3, NULL, NULL, 1),
(4, 'Что делает кнопка «Добавить обособленное структурное подразделение»?', 'С помощью этой кнопки можно добавить нижестоящие организации', 3, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `qwe`
--

CREATE TABLE `qwe` (
  `q` text CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL,
  `w` text CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL,
  `e` text CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `rating_criteria`
--

CREATE TABLE `rating_criteria` (
  `id_rating_criteria` int NOT NULL,
  `id_subvision` int NOT NULL,
  `id_criteria` int NOT NULL,
  `value` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `rating_criteria`
--

INSERT INTO `rating_criteria` (`id_rating_criteria`, `id_subvision`, `id_criteria`, `value`) VALUES
(188, 63, 39, 1),
(189, 63, 40, 1),
(190, 63, 41, 1),
(191, 63, 42, 1),
(192, 63, 43, 1),
(193, 63, 44, 1),
(194, 63, 45, 1),
(195, 63, 46, 1),
(196, 63, 47, 1),
(197, 63, 48, 1),
(198, 63, 49, 1),
(199, 63, 50, 1),
(200, 63, 51, 1),
(201, 63, 52, 1),
(202, 63, 53, 1),
(203, 63, 54, 1),
(204, 63, 55, 1),
(209, 81, 40, 1),
(210, 81, 44, 1),
(211, 83, 40, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `report_application_mark`
--

CREATE TABLE `report_application_mark` (
  `id_application` int NOT NULL,
  `otmetka_all` int NOT NULL,
  `otmetka_all_count_yes` int DEFAULT NULL,
  `otmetka_all_count_all` int DEFAULT NULL,
  `otmetka_all_count_not_need` int DEFAULT NULL,
  `otmetka_class_1` int NOT NULL,
  `otmetka_class_1_count_yes` int DEFAULT NULL,
  `otmetka_class_1_count_all` int DEFAULT NULL,
  `otmetka_class_1_count_not_need` int DEFAULT NULL,
  `otmetka_class_2` int NOT NULL,
  `otmetka_class_2_count_yes` int DEFAULT NULL,
  `otmetka_class_2_count_all` int DEFAULT NULL,
  `otmetka_class_2_count_not_need` int DEFAULT NULL,
  `otmetka_class_3` int NOT NULL,
  `otmetka_class_3_count_yes` int DEFAULT NULL,
  `otmetka_class_3_count_all` int DEFAULT NULL,
  `otmetka_class_3_count_not_need` int DEFAULT NULL,
  `otmetka_accred_all` int DEFAULT NULL,
  `otmetka_accred_all_count_yes` int DEFAULT NULL,
  `otmetka_accred_all_count_all` int DEFAULT NULL,
  `otmetka_accred_all_count_not_need` int DEFAULT NULL,
  `otmetka_accred_class_1` int DEFAULT NULL,
  `otmetka_accred_class_1_count_yes` int DEFAULT NULL,
  `otmetka_accred_class_1_count_all` int DEFAULT NULL,
  `otmetka_accred_class_1_count_not_need` int DEFAULT NULL,
  `otmetka_accred_class_2` int DEFAULT NULL,
  `otmetka_accred_class_2_count_yes` int DEFAULT NULL,
  `otmetka_accred_class_2_count_all` int DEFAULT NULL,
  `otmetka_accred_class_2_count_not_need` int DEFAULT NULL,
  `otmetka_accred_class_3` int DEFAULT NULL,
  `otmetka_accred_class_3_count_yes` int DEFAULT NULL,
  `otmetka_accred_class_3_count_all` int DEFAULT NULL,
  `otmetka_accred_class_3_count_not_need` int DEFAULT NULL,
  `otmetka_verif` int DEFAULT NULL,
  `otmetka_verif_count_yes` int DEFAULT NULL,
  `otmetka_verif_count_all` int DEFAULT NULL,
  `otmetka_verif_count_not_need` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `report_application_mark`
--

INSERT INTO `report_application_mark` (`id_application`, `otmetka_all`, `otmetka_all_count_yes`, `otmetka_all_count_all`, `otmetka_all_count_not_need`, `otmetka_class_1`, `otmetka_class_1_count_yes`, `otmetka_class_1_count_all`, `otmetka_class_1_count_not_need`, `otmetka_class_2`, `otmetka_class_2_count_yes`, `otmetka_class_2_count_all`, `otmetka_class_2_count_not_need`, `otmetka_class_3`, `otmetka_class_3_count_yes`, `otmetka_class_3_count_all`, `otmetka_class_3_count_not_need`, `otmetka_accred_all`, `otmetka_accred_all_count_yes`, `otmetka_accred_all_count_all`, `otmetka_accred_all_count_not_need`, `otmetka_accred_class_1`, `otmetka_accred_class_1_count_yes`, `otmetka_accred_class_1_count_all`, `otmetka_accred_class_1_count_not_need`, `otmetka_accred_class_2`, `otmetka_accred_class_2_count_yes`, `otmetka_accred_class_2_count_all`, `otmetka_accred_class_2_count_not_need`, `otmetka_accred_class_3`, `otmetka_accred_class_3_count_yes`, `otmetka_accred_class_3_count_all`, `otmetka_accred_class_3_count_not_need`, `otmetka_verif`, `otmetka_verif_count_yes`, `otmetka_verif_count_all`, `otmetka_verif_count_not_need`) VALUES
(35, 26, 5, 20, 1, 14, 1, 8, 1, 50, 4, 8, 0, 0, 0, 4, 0, 15, 3, 20, 0, 38, 3, 8, 0, 0, 0, 8, 0, 0, 0, 4, 0, 45, 9, 20, 0),
(40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 6, 55, 959, 1, 7, 21, 317, 0, 5, 22, 467, 1, 7, 12, 175, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `report_criteria_mark`
--

CREATE TABLE `report_criteria_mark` (
  `id_application` int NOT NULL,
  `id_subvision` int NOT NULL,
  `id_criteria` int NOT NULL,
  `otmetka_all` int NOT NULL,
  `otmetka_all_count_yes` int DEFAULT NULL,
  `otmetka_all_count_all` int DEFAULT NULL,
  `otmetka_all_count_not_need` int DEFAULT NULL,
  `otmetka_class_1` int NOT NULL,
  `otmetka_class_1_count_yes` int DEFAULT NULL,
  `otmetka_class_1_count_all` int DEFAULT NULL,
  `otmetka_class_1_count_not_need` int DEFAULT NULL,
  `otmetka_class_2` int NOT NULL,
  `otmetka_class_2_count_yes` int DEFAULT NULL,
  `otmetka_class_2_count_all` int DEFAULT NULL,
  `otmetka_class_2_count_not_need` int DEFAULT NULL,
  `otmetka_class_3` int NOT NULL,
  `otmetka_class_3_count_yes` int DEFAULT NULL,
  `otmetka_class_3_count_all` int DEFAULT NULL,
  `otmetka_class_3_count_not_need` int DEFAULT NULL,
  `otmetka_accred_all` int DEFAULT NULL,
  `otmetka_accred_all_count_yes` int DEFAULT NULL,
  `otmetka_accred_all_count_all` int DEFAULT NULL,
  `otmetka_accred_all_count_not_need` int DEFAULT NULL,
  `otmetka_accred_class_1` int DEFAULT NULL,
  `otmetka_accred_class_1_count_yes` int DEFAULT NULL,
  `otmetka_accred_class_1_count_all` int DEFAULT NULL,
  `otmetka_accred_class_1_count_not_need` int DEFAULT NULL,
  `otmetka_accred_class_2` int DEFAULT NULL,
  `otmetka_accred_class_2_count_yes` int DEFAULT NULL,
  `otmetka_accred_class_2_count_all` int DEFAULT NULL,
  `otmetka_accred_class_2_count_not_need` int DEFAULT NULL,
  `otmetka_accred_class_3` int DEFAULT NULL,
  `otmetka_accred_class_3_count_yes` int DEFAULT NULL,
  `otmetka_accred_class_3_count_all` int DEFAULT NULL,
  `otmetka_accred_class_3_count_not_need` int DEFAULT NULL,
  `otmetka_verif` int DEFAULT NULL,
  `otmetka_verif_count_yes` int DEFAULT NULL,
  `otmetka_verif_count_all` int DEFAULT NULL,
  `otmetka_verif_count_not_need` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `report_criteria_mark`
--

INSERT INTO `report_criteria_mark` (`id_application`, `id_subvision`, `id_criteria`, `otmetka_all`, `otmetka_all_count_yes`, `otmetka_all_count_all`, `otmetka_all_count_not_need`, `otmetka_class_1`, `otmetka_class_1_count_yes`, `otmetka_class_1_count_all`, `otmetka_class_1_count_not_need`, `otmetka_class_2`, `otmetka_class_2_count_yes`, `otmetka_class_2_count_all`, `otmetka_class_2_count_not_need`, `otmetka_class_3`, `otmetka_class_3_count_yes`, `otmetka_class_3_count_all`, `otmetka_class_3_count_not_need`, `otmetka_accred_all`, `otmetka_accred_all_count_yes`, `otmetka_accred_all_count_all`, `otmetka_accred_all_count_not_need`, `otmetka_accred_class_1`, `otmetka_accred_class_1_count_yes`, `otmetka_accred_class_1_count_all`, `otmetka_accred_class_1_count_not_need`, `otmetka_accred_class_2`, `otmetka_accred_class_2_count_yes`, `otmetka_accred_class_2_count_all`, `otmetka_accred_class_2_count_not_need`, `otmetka_accred_class_3`, `otmetka_accred_class_3_count_yes`, `otmetka_accred_class_3_count_all`, `otmetka_accred_class_3_count_not_need`, `otmetka_verif`, `otmetka_verif_count_yes`, `otmetka_verif_count_all`, `otmetka_verif_count_not_need`) VALUES
(35, 6, 3, 75, 3, 4, 0, 50, 1, 2, 0, 100, 2, 2, 0, 0, 0, 0, 0, 25, 1, 4, 0, 50, 1, 2, 0, 0, 0, 2, 0, 0, 0, 0, 0, 100, 4, 4, 0),
(35, 6, 4, 0, 0, 5, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 5, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 5, 0),
(35, 6, 5, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 1, 1, 0, 100, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 1, 1, 0),
(35, 6, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(35, 49, 3, 67, 2, 4, 1, 0, 0, 2, 1, 100, 2, 2, 0, 0, 0, 0, 0, 25, 1, 4, 0, 50, 1, 2, 0, 0, 0, 2, 0, 0, 0, 0, 0, 100, 4, 4, 0),
(35, 49, 4, 0, 0, 5, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 5, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 5, 0),
(35, 49, 5, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(35, 49, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(35, 49, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40, 58, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 85, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 85, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 85, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 85, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 85, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 85, 34, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 85, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 85, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 85, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 63, 39, 0, 0, 172, 0, 0, 0, 50, 0, 0, 0, 95, 0, 0, 0, 27, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 63, 40, 3, 1, 35, 0, 6, 1, 18, 0, 0, 0, 13, 0, 0, 0, 4, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 63, 41, 3, 2, 61, 0, 0, 0, 25, 0, 9, 2, 23, 0, 0, 0, 13, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 63, 42, 98, 46, 47, 0, 95, 19, 20, 0, 100, 17, 17, 0, 100, 10, 10, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 63, 43, 6, 3, 49, 0, 7, 1, 15, 0, 5, 1, 21, 0, 8, 1, 13, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 63, 44, 0, 0, 43, 0, 0, 0, 18, 0, 0, 0, 18, 0, 0, 0, 7, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 63, 45, 0, 0, 47, 0, 0, 0, 15, 0, 0, 0, 21, 0, 0, 0, 11, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 63, 46, 0, 0, 25, 0, 0, 0, 8, 0, 0, 0, 12, 0, 0, 0, 5, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 63, 47, 0, 0, 39, 0, 0, 0, 14, 0, 0, 0, 16, 0, 0, 0, 9, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 63, 48, 0, 0, 73, 0, 0, 0, 26, 0, 0, 0, 28, 0, 0, 0, 19, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 63, 49, 0, 0, 34, 0, 0, 0, 10, 0, 0, 0, 14, 0, 0, 0, 10, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 63, 50, 0, 0, 30, 0, 0, 0, 9, 0, 0, 0, 14, 0, 0, 0, 7, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 63, 51, 0, 0, 40, 0, 0, 0, 7, 0, 0, 0, 27, 0, 0, 0, 6, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 63, 52, 0, 0, 31, 0, 0, 0, 8, 0, 0, 0, 18, 0, 0, 0, 5, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 63, 53, 0, 0, 27, 0, 0, 0, 5, 0, 0, 0, 18, 0, 0, 0, 4, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 63, 54, 0, 0, 26, 0, 0, 0, 5, 0, 0, 0, 18, 0, 0, 0, 3, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 63, 55, 0, 0, 67, 0, 0, 0, 10, 0, 0, 0, 50, 0, 0, 0, 7, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 81, 40, 0, 0, 35, 1, 0, 0, 18, 0, 0, 0, 13, 1, 0, 0, 4, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 81, 44, 2, 1, 43, 0, 0, 0, 18, 0, 6, 1, 18, 0, 0, 0, 7, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 83, 40, 6, 2, 35, 0, 0, 0, 18, 0, 8, 1, 13, 0, 25, 1, 4, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `report_subvision_mark`
--

CREATE TABLE `report_subvision_mark` (
  `id_application` int NOT NULL,
  `id_subvision` int NOT NULL,
  `otmetka_all` int NOT NULL,
  `otmetka_all_count_yes` int DEFAULT NULL,
  `otmetka_all_count_all` int DEFAULT NULL,
  `otmetka_all_count_not_need` int DEFAULT NULL,
  `otmetka_class_1` int NOT NULL,
  `otmetka_class_1_count_yes` int DEFAULT NULL,
  `otmetka_class_1_count_all` int DEFAULT NULL,
  `otmetka_class_1_count_not_need` int DEFAULT NULL,
  `otmetka_class_2` int NOT NULL,
  `otmetka_class_2_count_yes` int DEFAULT NULL,
  `otmetka_class_2_count_all` int DEFAULT NULL,
  `otmetka_class_2_count_not_need` int DEFAULT NULL,
  `otmetka_class_3` int NOT NULL,
  `otmetka_class_3_count_yes` int DEFAULT NULL,
  `otmetka_class_3_count_all` int DEFAULT NULL,
  `otmetka_class_3_count_not_need` int DEFAULT NULL,
  `otmetka_accred_all` int DEFAULT NULL,
  `otmetka_accred_all_count_yes` int DEFAULT NULL,
  `otmetka_accred_all_count_all` int DEFAULT NULL,
  `otmetka_accred_all_count_not_need` int DEFAULT NULL,
  `otmetka_accred_class_1` int DEFAULT NULL,
  `otmetka_accred_class_1_count_yes` int DEFAULT NULL,
  `otmetka_accred_class_1_count_all` int DEFAULT NULL,
  `otmetka_accred_class_1_count_not_need` int DEFAULT NULL,
  `otmetka_accred_class_2` int DEFAULT NULL,
  `otmetka_accred_class_2_count_yes` int DEFAULT NULL,
  `otmetka_accred_class_2_count_all` int DEFAULT NULL,
  `otmetka_accred_class_2_count_not_need` int DEFAULT NULL,
  `otmetka_accred_class_3` int DEFAULT NULL,
  `otmetka_accred_class_3_count_yes` int DEFAULT NULL,
  `otmetka_accred_class_3_count_all` int DEFAULT NULL,
  `otmetka_accred_class_3_count_not_need` int DEFAULT NULL,
  `otmetka_verif` int DEFAULT NULL,
  `otmetka_verif_count_yes` int DEFAULT NULL,
  `otmetka_verif_count_all` int DEFAULT NULL,
  `otmetka_verif_count_not_need` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `report_subvision_mark`
--

INSERT INTO `report_subvision_mark` (`id_application`, `id_subvision`, `otmetka_all`, `otmetka_all_count_yes`, `otmetka_all_count_all`, `otmetka_all_count_not_need`, `otmetka_class_1`, `otmetka_class_1_count_yes`, `otmetka_class_1_count_all`, `otmetka_class_1_count_not_need`, `otmetka_class_2`, `otmetka_class_2_count_yes`, `otmetka_class_2_count_all`, `otmetka_class_2_count_not_need`, `otmetka_class_3`, `otmetka_class_3_count_yes`, `otmetka_class_3_count_all`, `otmetka_class_3_count_not_need`, `otmetka_accred_all`, `otmetka_accred_all_count_yes`, `otmetka_accred_all_count_all`, `otmetka_accred_all_count_not_need`, `otmetka_accred_class_1`, `otmetka_accred_class_1_count_yes`, `otmetka_accred_class_1_count_all`, `otmetka_accred_class_1_count_not_need`, `otmetka_accred_class_2`, `otmetka_accred_class_2_count_yes`, `otmetka_accred_class_2_count_all`, `otmetka_accred_class_2_count_not_need`, `otmetka_accred_class_3`, `otmetka_accred_class_3_count_yes`, `otmetka_accred_class_3_count_all`, `otmetka_accred_class_3_count_not_need`, `otmetka_verif`, `otmetka_verif_count_yes`, `otmetka_verif_count_all`, `otmetka_verif_count_not_need`) VALUES
(35, 6, 30, 3, 10, 0, 25, 1, 4, 0, 50, 2, 4, 0, 0, 0, 2, 0, 20, 2, 10, 0, 50, 2, 4, 0, 0, 0, 4, 0, 0, 0, 2, 0, 50, 5, 10, 0),
(35, 49, 22, 2, 10, 1, 0, 0, 4, 1, 50, 2, 4, 0, 0, 0, 2, 0, 10, 1, 10, 0, 25, 1, 4, 0, 0, 0, 4, 0, 0, 0, 2, 0, 40, 4, 10, 0),
(40, 58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(41, 61, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(41, 62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 85, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 86, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 63, 6, 52, 846, 0, 8, 21, 263, 0, 5, 20, 423, 0, 7, 11, 160, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 81, 1, 1, 78, 1, 0, 0, 36, 0, 3, 1, 31, 1, 0, 0, 11, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 82, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 83, 6, 2, 35, 0, 0, 0, 18, 0, 8, 1, 13, 0, 25, 1, 4, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `roles`
--

CREATE TABLE `roles` (
  `id_role` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `roles`
--

INSERT INTO `roles` (`id_role`, `name`) VALUES
(1, 'Администратор'),
(2, 'Аккредитатор'),
(3, 'Пользователь'),
(4, 'Минздрав'),
(5, 'Аккредитация Минск'),
(6, 'Аккредитация Минская область'),
(7, 'Аккредитация Гомель'),
(8, 'Аккредитация Могилев'),
(9, 'Аккредитация Витебск'),
(10, 'Аккредитация Гродно'),
(11, 'Аккредитация Брест');

-- --------------------------------------------------------

--
-- Структура таблицы `status`
--

CREATE TABLE `status` (
  `id_status` int NOT NULL,
  `name_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `status`
--

INSERT INTO `status` (`id_status`, `name_status`) VALUES
(1, 'создано'),
(2, 'новое'),
(3, 'проверяется'),
(4, 'проверено'),
(5, 'отклонено');

-- --------------------------------------------------------

--
-- Структура таблицы `subvision`
--

CREATE TABLE `subvision` (
  `id_subvision` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_application` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `subvision`
--

INSERT INTO `subvision` (`id_subvision`, `name`, `id_application`) VALUES
(63, '36gp', 42),
(81, '123', 42),
(83, 'поликлиника 35', 42);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id_user` int NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `login` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_role` int NOT NULL,
  `online` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_act` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_time_online` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_page` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `oblast` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id_user`, `username`, `login`, `password`, `id_role`, `online`, `last_act`, `last_time_online`, `last_page`, `oblast`) VALUES
(1, 'Аккредитация', 'accred@mail.ru', '6534cb7340066e972846eaf508de6224', 2, '0', 'dl7hosqo9gbs0082eaptv9j08f3an66f', '2023-07-24 12:00:22', '/index.php?logout', 0),
(2, '36gp', '36gp@mail.ru', 'ba258829bb23dce283867bb2f8b78d7f', 3, 'kahkkth0rtqnuah8dtq7i4o69dagh9i1', 'kahkkth0rtqnuah8dtq7i4o69dagh9i1', '2023-08-08 11:10:11', '/index.php?help', 0),
(3, 'admin', 'hancharou@rnpcmt.by', '2c904ec0191ebc337d56194f6f9a08fa', 1, '0', 'n4t60og9hv31soimi7sguve6cddsunhf', '2023-07-31 15:09:59', '/index.php?logout', 0),
(184, 'Государственное учреждение «Университетская стоматологическая клиника»', 'univDendClinic', '11023f1e51b80bc349f9c19f056bcedf', 3, NULL, NULL, NULL, NULL, 4),
(185, 'Государственное учреждение «Республиканский центр медицинской реабилитации и бальнеолечения»', 'republicCentermedrb', '8a7199d2b7e7c86b0bc46f16f666f1e8', 3, '0', '16cu55poolm06mqq70bfc3jfv7nk8egk', '2023-07-20 16:52:47', '/index.php?logout', 4),
(186, 'Государственное учреждение «Медицинская служба гражданской авиации»', 'medServiceCivilAvia', 'df4de89b52b74bce9bcc4803ed1f8f8d', 3, NULL, NULL, NULL, NULL, 4),
(187, 'Государственное учреждение «Республиканский научно-практический центр «Кардиология»', 'rnpcCardio', '2b2089b7e9f6ebb83a8c5cb887877801', 3, NULL, NULL, NULL, NULL, 4),
(188, 'Государственное учреждение «Республиканский научно-практический центр оториноларингологии»', 'rnpcOtorhino', '242c0bc9230a7a275473960d193bea45', 3, NULL, NULL, NULL, NULL, 4),
(189, 'Государственное учреждение «Республиканский научно-практический центр травматологии и ортопедии»', 'rnpcTravmOrtoped', '014222e4f9a9a8208db0195816eca3ca', 3, NULL, NULL, NULL, NULL, 4),
(190, 'Государственное учреждение «Республиканский научно-практический центр неврологии и нейрохирургии»', 'rnpcNevro', '014222e4f9a9a8208db0195816eca3ca', 3, NULL, NULL, NULL, NULL, 4),
(191, 'Государственное учреждение «Республиканский научно-практический центр детской хирургии»', 'rnpcChildKhirurg', '0167b7fc33fa193394cc39e3865451fe', 3, NULL, NULL, NULL, NULL, 4),
(192, 'Государственное учреждение «Республиканский научно-практический центр «Мать и дитя»', 'rnpcMD', 'f3340c96cd6e0cc32fc8c0acd881529c', 3, NULL, NULL, NULL, NULL, 4),
(193, 'Государственное учреждение «Республиканский научно-практический центр психического здоровья»', 'rnpcPsHealth', 'b4a9b2fa4584d9ed01f2e3375710f404', 3, NULL, NULL, NULL, NULL, 4),
(194, 'Государственное учреждение «Республиканский научно-практический центр пульмонологии и фтизиатрии»', 'rnpcPulmoPhthis', '8a507e0caf004ee87455c98084ba5b6b', 3, NULL, NULL, NULL, NULL, 4),
(195, 'Государственное учреждение «Республиканский научно-практический центр детской онкологии, гематологии и иммунологии»', 'rnpcChildOnkoGemIm', '91cead1039c6985cfa3ccfd34ad3e427', 3, NULL, NULL, NULL, NULL, 4),
(196, 'Государственное учреждение «Республиканский научно-практический центр онкологии и медицинской радиологии им.Н.Н.Александрова»', 'rnpcOnkoMedRadio', 'd961bb083092fbadc4380efad53bfa34', 3, NULL, NULL, NULL, NULL, 4),
(197, 'Государственное учреждение «Республиканский клинический центр паллиативной медицинской помощи детям»', 'rnpcPalMedHelpChild', 'd46303e3393203c26f63d0b93d055732', 3, NULL, NULL, NULL, NULL, 4),
(198, 'Государственное учреждение «Республиканская клиническая больница медицинской реабилитации» (н.п.Аксаковщина)', 'rcb-med-reabil', 'efe5d77d890ff01cd2dd3ce9d4db5de5', 3, NULL, NULL, NULL, NULL, 4),
(199, 'Государственное учреждение «Республиканский научно-практический центр медицинской экспертизы и реабилитации»', 'rnpc-med-exp-reabil', '54bec392b30e72821a0fc85c8b3381e3', 3, NULL, NULL, NULL, NULL, 4),
(200, 'Государственное учреждение «Республиканская детская больница медицинской реабилитации» (н.п.Острошицкий Городок)', 'rdbmrOstrosh', '7eacb5f7a4dadc47d79195802623e699', 3, NULL, NULL, NULL, NULL, 4),
(201, 'Государственное учреждение «Республиканская больница спелеолечения» ', 'rbSpeleo', '4eb8f871175c73348f4ae047fecb972a', 3, NULL, NULL, NULL, NULL, 4),
(202, 'Государственное учреждение «Республиканский детский центр медицинской реабилитации»', 'rdcMedReabil', 'bff2c2e8c1ba79462d2fa374a9414293', 3, NULL, NULL, NULL, NULL, 4),
(203, 'Учреждение здравоохранения «Брестская городская больница №1»', 'brestGb1', '904de1487c642e1df625e3b76b2e5c87', 3, NULL, NULL, NULL, NULL, 11),
(204, 'Учреждение здравоохранения «Брестская городская больница скорой медицинской помощи»', 'brest-gbsmp', '0eb09ac4667bd2dda0c0a83aaf6d29c8', 3, NULL, NULL, NULL, NULL, 11),
(205, 'Учреждение здравоохранения «Брестская городская больница паллиативной помощи Хоспис»', 'brest-gbphelp', '2c6e12ab028414228c4e97ad7273a1ce', 3, NULL, NULL, NULL, NULL, 11),
(206, 'Учреждение здравоохранения «Брестская центральная городская больница»', 'brest-cgb', '335dd80d03aed9704b0adcb842d34295', 3, NULL, NULL, NULL, NULL, 11),
(207, 'Учреждение здравоохранения «Брестская областная детская больница»', 'brest-obldb', 'f26d6f368e758aae100af6819b600207', 3, NULL, NULL, NULL, NULL, 11),
(208, 'Учреждение здравоохранения «Брестская городская больница №2»', 'brest-gb2', '0e4b9229268be41dcc8a25aa9974a187', 3, NULL, NULL, NULL, NULL, 11),
(209, 'Учреждение здравоохранения «Брестская областная клиническая больница»', 'brest-oblkb', 'bf22f74dd2aebfe1ff7e3df2a106e0dc', 3, NULL, NULL, NULL, NULL, 11),
(210, 'Учреждение здравоохранения «Брестский областной родильный дом»', 'brest-oblrd', '95bef7f8b75d456d386cefd14f511198', 3, NULL, NULL, NULL, NULL, 11),
(211, 'Учреждение здравоохранения «Брестский областной детский центр медицинской реабилитации «Томашовка»', 'brest-obldcmr-tomashovka', 'd602c3ead6f523741eea793a04d6f5ac', 3, NULL, NULL, NULL, NULL, 11),
(212, 'Учреждение здравоохранения «Брестский областной детский центр медицинской реабилитации «Сосновый Бор»', 'brest-obldcmr-sosnovbor', 'c8e5feb22c298a5c2f461fb96176df8e', 3, NULL, NULL, NULL, NULL, 11),
(213, 'Учреждение здравоохранения «Брестский областной детский центр медицинской реабилитации «Лахва»', 'brest-obldcmr-lyahva', '75e886a3df7f820c251469e5a9984f20', 3, NULL, NULL, NULL, NULL, 11),
(214, 'Учреждение здравоохранения «Брестская областная психиатрическая больница «Кривошин»', 'brest-oblpb-krivoshin', '189918f42a19292d80f0226073da8a8f', 3, NULL, NULL, NULL, NULL, 11),
(215, 'Учреждение здравоохранения «Брестская областная психоневрологическая больница «Могилевцы»', 'brest-oblpb-mogilevcy', '01cfb38d5288581152ce04b2b3bf2da1', 3, NULL, NULL, NULL, NULL, 11),
(216, 'Учреждение здравоохранения «Брестская областная психиатрическая больница «Городище»', 'brest-oblpb-gorodishe', 'bcf4a82f5bdf730b2a6513f4ff39021d', 3, NULL, NULL, NULL, NULL, 11),
(217, 'Учреждение здравоохранения «Брестский областной наркологический диспансер»', 'brest-oblnd', '8da3166e321e5b14ba193d8bf3a414f8', 3, NULL, NULL, NULL, NULL, 11),
(218, 'Учреждение здравоохранения «Брестский областной психоневрологический диспансер»', 'brest-oblpd', '1e2959b2ffb4ef5a5a4571cfe5b21eef', 3, NULL, NULL, NULL, NULL, 11),
(219, 'Учреждение здравоохранения «Брестский областной кожно-венерологический диспансер»', 'brest-oblkvd', '39e1c0148be727513b0814116b9bb74c', 3, NULL, NULL, NULL, NULL, 11),
(220, 'Учреждение здравоохранения «Брестский областной онкологический диспансер»', 'brest-oblod', '0cb4f9fa6f88209c7837735a9bc1d634', 3, NULL, NULL, NULL, NULL, 11),
(221, 'Учреждение здравоохранения «Брестский областной противотуберкулезный диспансер»', 'brest-oblptd', '09aeb5e1ebc071d8d4f6372b13e82729', 3, NULL, NULL, NULL, NULL, 11),
(222, 'Учреждение здравоохранения «Барановичская городская больница»', 'baranovichi-gb', '49e97ba53e605751dc1bcb384189e6da', 3, NULL, NULL, NULL, NULL, 11),
(223, 'Учреждение здравоохранения «Барановичская городская больница №2»', 'baranovichi-gb2', 'bfc9027bbdb738e3e037f58105bcf602', 3, NULL, NULL, NULL, NULL, 11),
(224, 'Учреждение здравоохранения «Барановичская детская городская больница»', 'baranovichi-dgb', 'f63d113812460f495e1d11197de205f4', 3, NULL, NULL, NULL, NULL, 11),
(225, 'Учреждение здравоохранения «Барановичский родильный дом»', 'baranovichi-rd', '5c4179e3d7862694b867a36cb19cd3e3', 3, NULL, NULL, NULL, NULL, 11),
(226, 'Учреждение здравоохранения «Березовская центральная районная больница им.Э.Э.Вержбицкого»', 'berezino-crb-Verzhbickogo', '472ddb4db877c0c2289fd24ec25f40a3', 3, NULL, NULL, NULL, NULL, 11),
(227, 'Учреждение здравоохранения «Ганцевичская центральная районная больница»', 'gancevichi-crb', 'e00cb56d4fea7ab64225ef9e4ef65423', 3, NULL, NULL, NULL, NULL, 11),
(228, 'Учреждение здравоохранения «Дрогичинская центральная районная больница»', 'drogichin-crb', '6f2e1594099c793b4c06fac0203297a0', 3, NULL, NULL, NULL, NULL, 11),
(229, 'Учреждение здравоохранения «Жабинковская центральная районная больница»', 'zhabinka-crb', 'ecb7cff12ca148ad1ed370aefab4563e', 3, NULL, NULL, NULL, NULL, 11),
(230, 'Учреждение здравоохранения «Ивановская центральная районная больница»', 'ivanovsk-crb', 'ac72b451d9727fd047a08637b204e726', 3, NULL, NULL, NULL, NULL, 11),
(231, 'Учреждение здравоохранения «Ивацевичская центральная районная больница»', 'ivacevich-crb', 'b5d65467957af78cc8fad8c39b6cd705', 3, NULL, NULL, NULL, NULL, 11),
(232, 'Учреждение здравоохранения «Каменецкая центральная районная больница»', 'kameneck-crb', 'c9673af8126e90bfaebe86347853944b', 3, NULL, NULL, NULL, NULL, 11),
(233, 'Учреждение здравоохранения «Кобринская центральная районная больница»', 'kobrin-crb', 'f7ed2f7327a721ead7e76c3f745ef544', 3, NULL, NULL, NULL, NULL, 11),
(234, 'Учреждение здравоохранения «Лунинецкая центральная районная больница»', 'lunineck-crb', 'dd632c6e3b92beeb5f37769ecdaf92b2', 3, NULL, NULL, NULL, NULL, 11),
(235, 'Учреждение здравоохранения «Ляховичская центральная районная больница»', 'lyahovichi-crb', 'a5b4f95a73d2ff07561c6b64e24ee5fe', 3, NULL, NULL, NULL, NULL, 11),
(236, 'Учреждение здравоохранения «Малоритская центральная районная больница»', 'malorit-crb', '02d22b821dc626fd87d9ba0f0c0031a9', 3, NULL, NULL, NULL, NULL, 11),
(237, 'Учреждение здравоохранения «Пинский межрайонный родильный дом»', 'pinsk-mrd', '7d513a1fbfbdbb1151ed9969fd1685b9', 3, NULL, NULL, NULL, NULL, 11),
(238, 'Учреждение здравоохранения «Пинская детская больница»', 'pinsk-db', '24beb3146aab7c4184f1d66fb8e2cc05', 3, NULL, NULL, NULL, NULL, 11),
(239, 'Учреждение здравоохранения «Пинская центральная больница»', 'pinsk-cb', '63243d1b9f02fc7fa6dded8d9733a742', 3, NULL, NULL, NULL, NULL, 11),
(240, 'Учреждение здравоохранения «Пружанская центральная районная больница»', 'pruzhan-crb', '606e53d792aeb8be381360af4c4eab10', 3, NULL, NULL, NULL, NULL, 11),
(241, 'Учреждение здравоохранения «Столинская центральная районная больница»', 'stolin-crb', '6a01281f345aa7481178c51bb1754fba', 3, NULL, NULL, NULL, NULL, 11),
(242, 'Учреждение здравоохранения «Брестская городская поликлиника №1»', 'brest-gp1', 'af060c7a49588b3c9ac6ef6fe39f61c1', 3, NULL, NULL, NULL, NULL, 11),
(243, 'Учреждение здравоохранения «Брестская городская поликлиника №2»', 'brest-gp2', 'd7a78fae4785ac536cdb29562bad863a', 3, NULL, NULL, NULL, NULL, 11),
(244, 'Государственное учреждение здравоохранения «Брестская городская поликлиника №3»', 'brest-gp3', 'a1c3edded1a3f61778ab8544e11a4c0e', 3, NULL, NULL, NULL, NULL, 11),
(245, 'Государственное учреждение здравоохранения «Брестская городская поликлиника №5» ', 'brest-gp5', '4fcd8d03d36ae5aeeda899d1350166ee', 3, NULL, NULL, NULL, NULL, 11),
(246, 'Учреждение здравоохранения «Брестская городская поликлиника №6»', 'brest-gp6', 'd5dbac51cde48ac46133f4b47ddef90b', 3, NULL, NULL, NULL, NULL, 11),
(247, 'Учреждение здравоохранения «Брестская городская детская поликлиника №1»', 'brest-gdp1', '788931d7647ada0cfca603796a08b653', 3, NULL, NULL, NULL, NULL, 11),
(248, 'Государственное учреждение здравоохранения «Брестская городская детская поликлиника №3»', 'brest-gdp3', 'ae2be0dd8c6b9726e7e6a9bbdf2dff4f', 3, NULL, NULL, NULL, NULL, 11),
(249, 'Государственное учреждение здравоохранения «Детская стоматологическая поликлиника г.Бреста»', 'brest-dsp', '785e6d362befecaa609e21520ab53a36', 3, NULL, NULL, NULL, NULL, 11),
(250, 'Учреждение здравоохранения «Брестская стоматологическая поликлиника»', 'brest-sp', '2b72899438a7d317e81896ac5fd5d90f', 3, NULL, NULL, NULL, NULL, 11),
(251, 'Учреждение здравоохранения «Брестская центральная поликлиника»', 'brest-cp', '63507ed18ac786d968da6c79a933caba', 3, NULL, NULL, NULL, NULL, 11),
(252, 'Коммунальное унитарное предприятие «Лечебно-консультативная поликлиника г.Бреста» ', 'lkp-brest', '2d64534d9423e0ae5c1fc815308155f9', 3, NULL, NULL, NULL, NULL, 11),
(253, 'Учреждение здравоохранения «Брестская областная стоматологическая поликлиника»', 'brest-obl-sp', '84631bd0eee05fabee7f00aba799e2a1', 3, NULL, NULL, NULL, NULL, 11),
(254, 'Учреждение здравоохранения «Брестский областной эндокринологический диспансер»', 'brest-obl-ed', '4475397ac870601e901f7e2e8e7d0d48', 3, NULL, NULL, NULL, NULL, 11),
(255, 'Государственное учреждение Брестский областной центр медицинской реабилитации для детей с психоневрологическими заболеваниями «Тонус»', 'brest-obl-cmrdpz-tonus', 'bec5484d1e5bd17c5fcc120b5c64ac50', 3, NULL, NULL, NULL, NULL, 11),
(256, 'Учреждение здравоохранения «Барановичская центральная поликлиника»', 'baranovichi-cp', '39dc9602bc92b92c69aa687d79944ea4', 3, NULL, NULL, NULL, NULL, 11),
(257, 'Коммунальное унитарное предприятие «Барановичская лечебно-консультативная поликлиника»', 'baranovichi-lkp', 'dc3e219e844fd35d4b05470e66692523', 3, NULL, NULL, NULL, NULL, 11),
(258, 'Коммунальное унитарное предприятие «Пинский лечебно-диагностический центр»', 'pinsk-ldc', '48d4127bbdaa59021f4f967e08afb319', 3, NULL, NULL, NULL, NULL, 11),
(259, 'Учреждение здравоохранения «Пинская стоматологическая поликлиника»', 'pinsk-sp', '2c464247020d66cb3acdece3b41f69c8', 3, NULL, NULL, NULL, NULL, 11),
(260, 'Государственное учреждение здравоохранения «Пинская городская поликлиника №1»', 'pinsk-gp1', '1d029617f6207df9edc1c486bed8dbf4', 3, NULL, NULL, NULL, NULL, 11),
(261, 'Учреждение здравоохранения «Пинская женская консультация»', 'pinsk-zhk', 'f2b5b3f01d1bdb46d51d8bf69d029ec2', 3, NULL, NULL, NULL, NULL, 11),
(262, 'Учреждение здравоохранения «Пинская центральная поликлиника»', 'pinsk-cp', 'c64244380327cde97669f89982f22f5b', 3, NULL, NULL, NULL, NULL, 11),
(263, 'Государственное учреждение «Брестская областная станция переливания крови»', 'brest-obl-spk', '7801dcdb25b61c6495fb8d508df6fd01', 3, NULL, NULL, NULL, NULL, 11),
(264, 'Государственное учреждение здравоохранения «Станция скорой медицинской помощи г.Бреста»', 'ssmp-brest', '52ab77f7398dbb72f923d01dba9c2193', 3, NULL, NULL, NULL, NULL, 11),
(265, 'Учреждение здравоохранения «Витебская областная клиническая больница»', 'vitebsk-oblkb', 'd1d3556f180eb3ae1f241d10a6ab7040', 3, NULL, NULL, NULL, NULL, 9),
(266, 'Учреждение здравоохранения «Витебский областной клинический специализированный центр»', 'vitebsk-oblksc', '94b10efd917bad3dd15f4c37f591f5af', 3, NULL, NULL, NULL, NULL, 9),
(267, 'Учреждение здравоохранения «Витебский областной клинический родильный дом»', 'vitebsk-oblkrd', 'e407e77572bd575841e318834a1f774b', 3, NULL, NULL, NULL, NULL, 9),
(268, 'Государственное учреждение здравоохранения «Полоцкая центральная городская больница»', 'polock-cgb', '720befa6dd82c42a86ab20b12ed9ff55', 3, NULL, NULL, NULL, NULL, 9),
(269, 'Учреждение здравоохранения «Витебский областной клинический центр психиатрии и наркологии»', 'vitebsk-obl-kcpn', '890c1b5d8da3d4a002e186cb3e57b36a', 3, NULL, NULL, NULL, NULL, 9),
(270, 'Учреждение здравоохранения «Областной детский реабилитационный оздоровительный центр «Ветразь»', 'odroc-vetraz', 'aabc0e99ceba5bac826cc5192122cf42', 3, NULL, NULL, NULL, NULL, 9),
(271, 'Учреждение здравоохранения «Витебский областной госпиталь инвалидов Великой Отечественной войны «Юрцево»', 'vitebsk-obl-givov-yurcevo', 'f80395775988d533cff097d93ab04a3a', 3, NULL, NULL, NULL, NULL, 9),
(272, 'Учреждение здравоохранения «Витебская областная клиническая инфекционная больница»', 'vitebsk-obl-kib', '58ea027fe267d3137062e98c680a236c', 3, NULL, NULL, NULL, NULL, 9),
(273, 'Учреждение здравоохранения «Витебский областной специализированный дом ребёнка»', 'vitebsk-obl-sdr', '4a503f89198dbd2837bab206c46120f9', 3, NULL, NULL, NULL, NULL, 9),
(274, 'Учреждение здравоохранения «Лепельская областная психиатрическая больница»', 'lepel-obl-pb', '2e79ff1799744ac803b967376b515d2b', 3, NULL, NULL, NULL, NULL, 9),
(275, 'Учреждение здравоохранения «Полоцкая областная психиатрическая больница»', 'polock-obl-pb', 'c2811329c951041ee41f229f119063a3', 3, NULL, NULL, NULL, NULL, 9),
(276, 'Коммунальное унитарное предприятие «Детский реабилитационно-оздоровительный центр «Жемчужина»', 'droc-zhemchuzhina', 'adc1efa09466a7faab516d2159050e01', 3, NULL, NULL, NULL, NULL, 9),
(277, 'Учреждение здравоохранения «Витебский областной клинический кардиологический центр»', 'vitebsk-obl-kkc', '596c212be4de77010be4cc9587c17729', 3, NULL, NULL, NULL, NULL, 9),
(278, 'Учреждение здравоохранения «Витебский областной детский клинический центр»', 'vitebsk-obl-dkc', '698ed3639b6450df9eb0379c411a01da', 3, NULL, NULL, NULL, NULL, 9),
(279, 'Учреждение здравоохранения «Витебский областной клинический онкологический диспансер»', 'vitebsk-obl-od', 'a224b003765809cb36a41b91c0c5ab1e', 3, NULL, NULL, NULL, NULL, 9),
(280, 'Учреждение здравоохранения «Витебский областной клинический центр пульмонологии и фтизиатрии»', 'vitebsk-obl-kcpf', '8dd0a4c9a5ddbc00ef6f200c5e92d455', 3, NULL, NULL, NULL, NULL, 9),
(281, 'Учреждение здравоохранения «Витебская городская клиническая больница №1»', 'vitebsk-gkb1', 'cdecf4147dfc7a8948d3c8b00623d979', 3, NULL, NULL, NULL, NULL, 9),
(282, 'Учреждение здравоохранения «Витебский городской клинический роддом №2»', 'vitebsk-gkrd2', '93600e022f2cdd8118c2aea887d61240', 3, NULL, NULL, NULL, NULL, 9),
(283, 'Учреждение здравоохранения «Витебская городская клиническая больница скорой медицинской помощи»', 'vitebsk-gkbsmp', '712d11a2e07f2a4c050cf7efcaee1474', 3, NULL, NULL, NULL, NULL, 9),
(284, 'Учреждение здравоохранения «Витебский областной клинический центр дерматовенерологии и косметологии»', 'vitebsk-obl-kcdk', '1c0be888c610ed4b43ec60900292b360', 3, NULL, NULL, NULL, NULL, 9),
(285, 'Государственное учреждение здравоохранения «Витебский областной клинический центр медицинской реабилитации для инвалидов и ветеранов боевых действий на территории других государств»', 'vitebsk-oblkcmrivbdt', '06c245de802c7131f689c9abf4064fdd', 3, NULL, NULL, NULL, NULL, 9),
(286, 'Учреждение здравоохранения «Бешенковичская центральная районная больница»', 'beshenkovichi-crb', 'f72c72f375b3d8d32b4ebd19d2fec680', 3, NULL, NULL, NULL, NULL, 9),
(287, 'Учреждение здравоохранения «Браславская центральная районная больница»', 'braslavsk-crb', 'b48047f3d99b124ba4d5ade8e0fab0b8', 3, NULL, NULL, NULL, NULL, 9),
(288, 'Учреждение здравоохранения «Верхнедвинская центральная районная больница»', 'verhnedvinsk-crb', '5018ba77275f3dcfa8d63771514e820c', 3, NULL, NULL, NULL, NULL, 9),
(289, 'Учреждение здравоохранения «Глубокская центральная районная больница»', 'gluboksk-crb', '5895b7092c3b98fcdaf0b0c7a5e7bd9f', 3, NULL, NULL, NULL, NULL, 9),
(290, 'Учреждение здравоохранения «Городокская центральная районная больница»', 'gorodoksk-crb', '54f39dd9deb07dfc8079457ae07d849e', 3, NULL, NULL, NULL, NULL, 9),
(291, 'Учреждение здравоохранения «Докшицкая центральная районная больница»', 'dokshick-crb', '16e074a4b115feedf621afba54c6c223', 3, NULL, NULL, NULL, NULL, 9),
(292, 'Учреждение здравоохранения «Дубровенская центральная районная больница»', 'dubrovensk-crb', '5805141b44ac26b4e8461f74f9d6d430', 3, NULL, NULL, NULL, NULL, 9),
(293, 'Учреждение здравоохранения «Лепельская центральная районная больница»', 'lepel-crb', '9f0aae1c936d4ee33fb7cb5bf0646388', 3, NULL, NULL, NULL, NULL, 9),
(294, 'Учреждение здравоохранения «Лиозненская центральная районная больница»', 'liozensk-crb', '63c7b7dc40b57784354aa56f0a7e05d8', 3, NULL, NULL, NULL, NULL, 9),
(295, 'Учреждение здравоохранения «Миорская центральная районная больница»', 'miorsk-crb', 'b644e8fefb71c30890022d2e9a14e3ee', 3, NULL, NULL, NULL, NULL, 9),
(296, 'Учреждение здравоохранения «Поставская центральная районная больница»', 'postavsk-crb', 'ecd34aa3760e29ff796998a0f038e090', 3, NULL, NULL, NULL, NULL, 9),
(297, 'Учреждение здравоохранения «Россонская центральная районная больница»', 'rossonsk-crb', 'e38d1cc3c66bf0f6e02c8f879332039b', 3, NULL, NULL, NULL, NULL, 9),
(298, 'Учреждение здравоохранения «Сенненская центральная районная больница»', 'sennic-crb', '9992304fc78654f4dbbd6c8cd8e4b331', 3, NULL, NULL, NULL, NULL, 9),
(299, 'Учреждение здравоохранения «Толочинская центральная районная больница»', 'tolochinsk-crb', 'e94835bb4a4f8ee08ccb507b761b65d6', 3, NULL, NULL, NULL, NULL, 9),
(300, 'Учреждение здравоохранения «Ушачская центральная районная больница»', 'ushachi-crb', '6ac494f702d841da7e4f43553f853879', 3, NULL, NULL, NULL, NULL, 9),
(301, 'Учреждение здравоохранения «Новолукомльская центральная районная больница»', 'novolukoml-crb', 'db897c5ce085f207afde61287602ba94', 3, NULL, NULL, NULL, NULL, 9),
(302, 'Учреждение здравоохранения «Шарковщинская центральная районная больница»', 'sharkovshinsk-crb', '6d4a7dbb2b8076f15a8a816dfb54f0f3', 3, NULL, NULL, NULL, NULL, 9),
(303, 'Учреждение здравоохранения «Шумилинская центральная районная больница»', 'shumilinsk-crb', 'a08c707a04964b681fd84a70ce94d975', 3, NULL, NULL, NULL, NULL, 9),
(304, 'Учреждение здравоохранения «Новополоцкая центральная городская больница»', 'novopolock-cgb', 'a3efb7118f876cf90009aa87a0566e9b', 3, NULL, NULL, NULL, NULL, 9),
(305, 'Учреждение здравоохранения «Оршанская центральная поликлиника»', 'orsha-cp', '5ebb184232de7d3be25495dac8d4fddf', 3, NULL, NULL, NULL, NULL, 9),
(306, 'Учреждение здравоохранения «Холомерская сельская участковая больница»', 'holomersk-sub', 'c9932be04551d4d9236625084d604dd6', 3, NULL, NULL, NULL, NULL, 9),
(307, 'Государственное учреждение здравоохранения «Витебский областной центр паллиативной медицинской помощи»', 'vitebsk-obl-cpmp', 'eceba01e8e7fe2ff338e66c61d718f72', 3, NULL, NULL, NULL, NULL, 9),
(308, 'Учреждение здравоохранения «Витебский областной эндокринологический диспансер»', 'vitebsk-obl-ed', 'b22fd242d82e291edd6e5d7645b2393b', 3, NULL, NULL, NULL, NULL, 9),
(309, 'Учреждение здравоохранения «Витебский областной клинический диагностический центр»', 'vitebsk-obl-kdc', '77b118fad14f8276f205878d2e4c2872', 3, NULL, NULL, NULL, NULL, 9),
(310, 'Государственное учреждение здравоохранения «Витебский областной центр скорой медицинской помощи»', 'vitebsk-obl-csmp', 'afc4c74dc6aa33647ed51ad77399b675', 3, NULL, NULL, NULL, NULL, 9),
(311, 'Государственное учреждение здравоохранения «Витебская городская центральная поликлиника»', 'vitebsk-gcp', 'd6d7fbbcbae578602e4cab5943fd8b03', 3, NULL, NULL, NULL, NULL, 9),
(312, 'Государственное учреждение здравоохранения «Витебский областной центр трансфузиологии»', '\r\n	vitebsk-obl-ct', '4123ff91e7fd87f8140a169aeefb8910', 3, NULL, NULL, NULL, NULL, 9),
(313, 'Учреждение здравоохранения «Витебский областной клинический стоматологический центр»', 'vitebsk-obl-ksc', 'a17480b97c9e0a2cf50d37ce63d54a7a', 3, NULL, NULL, NULL, NULL, 9),
(314, 'Медицинское коммунальное унитарное предприятие «Алекс-хэлп»', 'mkup-alex-help', '0e9d6b04ec945b96de19ba6d852f7c23', 3, NULL, NULL, NULL, NULL, 9),
(315, 'Учреждение здравоохранения «Оршанская городская поликлиника №5»', 'orsha-gp5', '21fa0245b61152a902c092f9a2e71000', 3, NULL, NULL, NULL, NULL, 9),
(316, 'Учреждение здравоохранения «Оршанская стоматологическая поликлиника»', 'orsha-sp', '11aebca69815cb75f77a646f654e6d40', 3, NULL, NULL, NULL, NULL, 9),
(317, 'Учреждение здравоохранения «Брагинская центральная районная больница»', 'bragin-crb', 'decb20aec75dde4269d100cc2b468c60', 3, NULL, NULL, NULL, NULL, 7),
(318, 'Учреждение здравоохранения «Буда-Кошелевская центральная районная больница»', 'buda-koshelevo-crb', '2d31cf64a91f96f9ad1a16f926a585ae', 3, NULL, NULL, NULL, NULL, 7),
(319, 'Учреждение здравоохранения «Ветковская центральная районная больница»', 'vetka-crb', '407abe0923aa578bbfbcfdbea313c30e', 3, NULL, NULL, NULL, NULL, 7),
(320, 'Учреждение здравоохранения «Добрушская центральная районная больница»', 'dobrush-crb', '407abe0923aa578bbfbcfdbea313c30e', 3, NULL, NULL, NULL, NULL, 7),
(321, 'Учреждение здравоохранения «Ельская центральная районная больница»', 'elsk-crb', '6a62ad76a1fb9336c3b7278e5e1c2e94', 3, NULL, NULL, NULL, NULL, 7),
(322, 'Учреждение здравоохранения «Житковичская центральная районная больница»', 'zhitkovichi-crb', '3b161c8342afc49ef21f56d28332ccf1', 3, NULL, NULL, NULL, NULL, 7),
(323, 'Учреждение здравоохранения «Жлобинская центральная районная больница»', 'zhlobin-crb', '570408b6240d2e873d82196933e991c2', 3, NULL, NULL, NULL, NULL, 7),
(324, 'Учреждение здравоохранения «Калинковичская центральная районная больница»', 'kalinkovichi-crb', 'f34951b28bba47081323baabb0c24487', 3, NULL, NULL, NULL, NULL, 7),
(325, 'Учреждение здравоохранения «Кормянская центральная районная больница»', 'korma-crb', '6ec715de690e4939a7dbbf4a9fa0fae0', 3, NULL, NULL, NULL, NULL, 7),
(326, 'Учреждение здравоохранения «Лельчицкая центральная районная больница»', 'lelchici-crb', 'e3610f1e4dce4dfc9e37b8a89a9b2d2b', 3, NULL, NULL, NULL, NULL, 7),
(327, 'Учреждение здравоохранения «Лоевская центральная районная больница»', 'loev-crb', 'b1af3426bbc19c163ff60994f64089d9', 3, NULL, NULL, NULL, NULL, 7),
(328, 'Учреждение «Мозырский городской родильный дом»', 'mozyr-grd', '4bf76322a8da80e7a21bb28435a3f493', 3, NULL, NULL, NULL, NULL, 7),
(329, 'Учреждение «Мозырская городская детская больница»', 'mozyr-gdb', 'abc7d5cf5e9ae4aedaf81621b14e69fd', 3, NULL, NULL, NULL, NULL, 7),
(330, 'Учреждение «Мозырская городская больница»', 'mozyr-gb', '0fd1a674e80b252044ce59893cbc52c4', 3, NULL, NULL, NULL, NULL, 7),
(331, 'Учреждение здравоохранения «Наровлянская центральная районная больница»', 'narovlya-crb', 'd31b3ceb5e213f6d5c22ab1a32f67ed6', 3, NULL, NULL, NULL, NULL, 7),
(332, 'Учреждение здравоохранения «Октябрьская центральная районная больница»', 'oktyabr-crb', '635646f48bd92c2666531f622aa8c3a7', 3, NULL, NULL, NULL, NULL, 7),
(333, 'Учреждение здравоохранения «Петриковская центральная районная больница»', 'petrikovsk-crb', 'ce966946cabc90986847ab5a1aad4461', 3, NULL, NULL, NULL, NULL, 7),
(334, 'Учреждение здравоохранения «Речицкая центральная районная больница»', 'rechick-crb', 'df89525acf9db9070e46541c6121779a', 3, NULL, NULL, NULL, NULL, 7),
(335, 'Учреждение здравоохранения «Рогачевская центральная районная больница»', 'rogachev-crb', '1b90d66ea67702f75a5a8cc188b1808c', 3, NULL, NULL, NULL, NULL, 7),
(336, 'Учреждение здравоохранения «Светлогорская центральная районная больница»', 'svetlcrb', '1f87f1be476952144447022b6dbbbe15', 3, NULL, NULL, NULL, NULL, 7),
(337, 'Учреждение здравоохранения «Хойникская центральная районная больница»', 'hoincrb', '09c2cc5da02a44637d7825478f2adb55', 3, NULL, NULL, NULL, NULL, 7),
(338, 'Учреждение здравоохранения «Чечерская центральная районная больница»', 'chechcrb', '8f81b963a86966143cdf603e85750aa3', 3, NULL, NULL, NULL, NULL, 7),
(339, 'Учреждение «Гомельская областная клиническая больница»', 'gomokb', '9bca2fb2e720364cf00fd6b97e67f1bb', 3, NULL, NULL, NULL, NULL, 7),
(340, 'Учреждение «Гомельская областная детская клиническая больница»', 'gomodkb', 'cb37fb10aeaecf641d37f5243dae0459', 3, NULL, NULL, NULL, NULL, 7),
(341, 'Учреждение «Университетская клиника - областной клинический Госпиталь ИОВ»', 'yniverivov', '1431ec292b6887e9e70be43f97c8e24d', 3, NULL, NULL, NULL, NULL, 7),
(342, 'Учреждение «Гомельская областная туберкулезная клиническая больница»', 'gomotkb', 'd21351b38260afae81a56b21d5d1863d', 3, NULL, NULL, NULL, NULL, 7),
(343, 'Учреждение «Гомельская областная клиническая психиатрическая больница»', 'gomokpb', '9c934dd1e4889f1d33a43b77c247c5f4', 3, NULL, NULL, NULL, NULL, 7),
(344, 'Учреждение «Гомельский областной наркологический диспансер»', 'gomond', '55265569afd8cd7119a47e5e663cc90b', 3, NULL, NULL, NULL, NULL, 7),
(345, 'Учреждение «Гомельский областной клинический онкологический диспансер»', 'gomokod', '74408dc68d43668c57ff5596e71f49be', 3, NULL, NULL, NULL, NULL, 7),
(346, 'Учреждение «Гомельский областной клинический кожно-венерологический диспансер»', 'gomokkd', '4636ce532d1846e2ae1c51de639b2581', 3, NULL, NULL, NULL, NULL, 7),
(347, 'Учреждение «Гомельский областной клинический кардиологический центр»', 'gomokkc', 'd393f8204b6ea83ff12993fa4880bdc0', 3, NULL, NULL, NULL, NULL, 7),
(348, 'Учреждение «Гомельская областная специализированная клиническая больница»', 'gomoskb', 'fe2e3a35ee0af1456d70602693ce35f2', 3, NULL, NULL, NULL, NULL, 7),
(349, 'Учреждение «Гомельская областная инфекционная клиническая больница»', 'gomoikb', 'f4a61cf97f832512468e8bb9aed1d76c', 3, NULL, NULL, NULL, NULL, 7),
(350, 'Учреждение «Гомельский областной детский центр медицинской реабилитации «Верасок»', 'verasok', '87760566f42def97512210c7e1d28fab', 3, NULL, NULL, NULL, NULL, 7),
(351, 'Учреждение «Гомельская областная детская больница медицинской реабилитации «Живица»', 'zhivica', 'cdc78af36d6bf32b79020621cc5324fd', 3, NULL, NULL, NULL, NULL, 7),
(352, 'Государственное учреждение здравоохранения «Гомельская городская клиническая больница №1»', 'gomgkb1', '4bc2e330fcf9787271928315dadb7b21', 3, NULL, NULL, NULL, NULL, 7),
(353, 'Государственное учреждение здравоохранения «Гомельская городская клиническая больница №2»', 'gomgkb2', 'ee384231a69ff68af381274b33dedf55', 3, NULL, NULL, NULL, NULL, 7),
(354, 'Государственное учреждение здравоохранения «Гомельская городская клиническая больница №3»', 'gomgkb3', '79a11a04b5bf0fe4a8dbb9d60d0e8bd0', 3, NULL, NULL, NULL, NULL, 7),
(355, 'Государственное учреждение здравоохранения «Гомельская городская больница №4»', 'gomgb4', 'e3d93817e96c1ff7bbfc08f50aeaa680', 3, NULL, NULL, NULL, NULL, 7),
(356, 'Государственное учреждение здравоохранения «Больница скорой медицинской помощи»', 'gombsmp', '8429b369a038d05c8dd82e827a6a837b', 3, NULL, NULL, NULL, NULL, 7),
(357, 'Учреждение «Гомельская областная стоматологическая поликлиника»', 'gomosp', '9e1e7e196402825d207886d79652bb80', 3, NULL, NULL, NULL, NULL, 7),
(358, 'Учреждение «Гомельский областной эндокринологический диспансер»', 'gomoed', '9a702851b79944ec7afa4c75a1525a9b', 3, NULL, NULL, NULL, NULL, 7),
(359, 'Учреждение «Гомельский областной медико-генетический центр с консультацией «Брак и семья»', 'gomomgcbs', '9573997729f3766e619302cf8a243a18', 3, NULL, NULL, NULL, NULL, 7),
(360, 'Учреждение «Гомельская областная клиническая поликлиника»', 'gomokp', 'e6f7213852a97b2017e9d3f4ff459c04', 3, NULL, NULL, NULL, NULL, 7),
(361, 'Государственное учреждение здравоохранения «Гомельская центральная городская клиническая поликлиника»', 'gomcgkp', 'cad0d906637cf721aafe996c3f3e198b', 3, NULL, NULL, NULL, NULL, 7),
(362, 'Государственное учреждение здравоохранения «Гомельская городская клиническая поликлиника №2»', 'gomgkp2', '66e11971d50b556ea6904d9037b714b3', 3, NULL, NULL, NULL, NULL, 7),
(363, 'Государственное учреждение здравоохранения «Гомельская городская клиническая поликлиника №3»', 'gomgkp3', '93173a2db910163baa359d5b59931c13', 3, NULL, NULL, NULL, NULL, 7),
(364, 'Государственное учреждение здравоохранения «Гомельская городская клиническая поликлиника №4»', 'gomgkp4', '5c9702b01520fa1fcff7b4e7672217dd', 3, NULL, NULL, NULL, NULL, 7),
(365, 'Государственное учреждение здравоохранения «Гомельская городская клиническая поликлиника №5 им. С.В. Голуховой»', 'gomgkp5', '7dbd0e6df48b97877dd910a53e8d9795', 3, NULL, NULL, NULL, NULL, 7),
(366, 'Государственное учреждение здравоохранения «Гомельская городская клиническая поликлиника №6»', 'gomgkp6', '04b576124d154d923a673622a72f0c79', 3, NULL, NULL, NULL, NULL, 7),
(367, 'Государственное учреждение здравоохранения «Гомельская городская клиническая поликлиника №8»', 'gomgkp8', 'b8b529c22cf4894f74eb7a5331036a55', 3, NULL, NULL, NULL, NULL, 7),
(368, 'Государственное учреждение здравоохранения «Гомельская городская клиническая поликлиника №9»', 'gomgkp9', '68ea93a82812120e616d3d617a880eec', 3, NULL, NULL, NULL, NULL, 7),
(369, 'Государственное учреждение здравоохранения «Гомельская городская клиническая поликлиника №10»', 'gomgkp10', '5891bba82f2093d15059a9b7c79bbe23', 3, NULL, NULL, NULL, NULL, 7),
(370, 'Государственное учреждение здравоохранения «Гомельская городская клиническая поликлиника №11»', 'gomgkp11', '4ca2f5923d2776f6e7d0a90080795c79', 3, NULL, NULL, NULL, NULL, 7),
(371, 'Государственное учреждение здравоохранения «Гомельская городская поликлиника №13»', 'gomgp13', '1586cc4aa0ed7b01061f615bd6130af9', 3, NULL, NULL, NULL, NULL, 7),
(372, 'Государственное учреждение здравоохранения «Гомельская городская клиническая поликлиника №14»', 'gomgkp14', '1a77573bfdc50344b038bc561e05e3db', 3, NULL, NULL, NULL, NULL, 7),
(373, 'Государственное учреждение здравоохранения «Гомельская городская поликлиника №1»', 'gomgp1', '7cc3a9a2a69d19f9f7bf3e7d89622426', 3, NULL, NULL, NULL, NULL, 7),
(374, 'Коммунальное унитарное предприятие «Поликлиника №7»', 'pol7', '8c7071a11dc8f2798c63177fac990b91', 3, NULL, NULL, NULL, NULL, 7),
(375, 'Государственное учреждение здравоохранения «Гомельская центральная городская детская клиническая поликлиника»', 'gomcgdkp', 'bff47c475d4536344dc5002a757bd162', 3, NULL, NULL, NULL, NULL, 7),
(376, 'Государственное учреждение здравоохранения «Гомельская центральная городская стоматологическая поликлиника»', 'gomcgsp', 'f152fb639e1838c7aa7be49071bf6fc6', 3, NULL, NULL, NULL, NULL, 7),
(377, 'Учреждение здравоохранения «Мозырская центральная городская поликлиника»', 'mozcgp', 'a037472bd4e4e182c1b5ce031dd2d7e4', 3, NULL, NULL, NULL, NULL, 7),
(378, 'Учреждение «Центр медицинской реабилитации для детей-инвалидов и молодых инвалидов с психоневрологическими заболеваниями «Радуга»', 'raduga', '725961dbbb766c7d767203390d121414', 3, NULL, NULL, NULL, NULL, 7),
(379, 'Учреждение «Мозырская городская стоматологическая поликлиника»', 'mozgsp', 'dd3447894c34f50f56bdb55f34c9e7b4', 3, NULL, NULL, NULL, NULL, 7),
(380, 'Коммунальное унитарное предприятие «Мозырская городская поликлиника №4»', 'mozgp4', '1742be268dbbb562d37c524f4666e141', 3, NULL, NULL, NULL, NULL, 7),
(381, 'Государственное учреждение здравоохранения «Гомельская городская станция скорой медицинской помощи»', 'gomgssmp', '0e23fc2f4d9a6f634d3a784a0e922ee7', 3, NULL, NULL, NULL, NULL, 7),
(382, 'Государственное учреждение «Гомельский областной центр трансфузиологии»', 'gomoct', '087e0b48d015c2d80114fa1dfbbdbbf0', 3, NULL, NULL, NULL, NULL, 7),
(383, 'Учреждение здравоохранения «Мозырская станция переливания крови»', 'mozspk', '24da2695285ac9a3720f3a9d8961c7fa', 3, NULL, NULL, NULL, NULL, 7),
(384, 'Учреждение «Рогачевская станция переливания крови»', 'rogspk', '4b1a1b269f20bfa282f30ce9dd34a981', 3, NULL, NULL, NULL, NULL, 7),
(385, 'Учреждение здравоохранения «Берестовицкая центральная районная больница»', 'berstcrb', '524cce9d22d4c41e0446f9c542b67f6e', 3, NULL, NULL, NULL, NULL, 10),
(386, 'Учреждение здравоохранения «Волковысская центральная районная больница»', 'volkcrb', 'd92ab87ac7afb8f65bb5a8e4af57892c', 3, NULL, NULL, NULL, NULL, 10),
(387, 'Учреждение здравоохранения «Вороновская центральная районная больница»', 'voroncrb', 'ad339da0e2b69e4e1e69a3745afd8124', 3, NULL, NULL, NULL, NULL, 10),
(388, 'Учреждение здравоохранения «Дятловская центральная районная больница»', 'dyatlcrb', 'b0e2313eb5d31ef6799b23cfe7ab37ec', 3, NULL, NULL, NULL, NULL, 10),
(389, 'Учреждение здравоохранения «Зельвенская центральная районная больница»', 'zelvcrb', 'e68fdaf50742b5eeabdb544acc25d23e', 3, NULL, NULL, NULL, NULL, 10),
(390, 'Учреждение здравоохранения «Ивьевская центральная районная больница»', 'iviecrb', '746759b162f56baf15da8425f52a8e55', 3, NULL, NULL, NULL, NULL, 10),
(391, 'Учреждение здравоохранения «Кореличская центральная районная больница»', 'korelcrb', 'bf46e52bd0df971ec17253e6788d04ff', 3, NULL, NULL, NULL, NULL, 10),
(392, 'Учреждение здравоохранения «Лидская центральная районная больница»', 'lidcrb', 'c3f997acd003fc29dbb138db429e3a9a', 3, NULL, NULL, NULL, NULL, 10),
(393, 'Учреждение здравоохранения «Мостовская центральная районная больница»', 'mostcrb', '7108ada99a89cccc0521ad28196f05e6', 3, NULL, NULL, NULL, NULL, 10),
(394, 'Учреждение здравоохранения «Новогрудская центральная районная больница»', 'novogrcrb', 'b881d4aafa38b4dd4225c7dd585801ae', 3, NULL, NULL, NULL, NULL, 10),
(395, 'Учреждение здравоохранения «Островецкая центральная районная клиническая больница»', 'ostrovcrb', '28d412c926d5aef308079e6f51e51a1c', 3, NULL, NULL, NULL, NULL, 10),
(396, 'Учреждение здравоохранения «Ошмянская центральная районная больница»', 'oshmyancrb', 'fd73b4e2bbde3a930a5b68b97419c2f1', 3, NULL, NULL, NULL, NULL, 10),
(397, 'Учреждение здравоохранения «Свислочская центральная районная больница»', 'svislochcrb', 'dc5aa1849c41b7fa075e072efc20fd5b', 3, NULL, NULL, NULL, NULL, 10),
(398, 'Учреждение здравоохранения «Слонимская центральная районная больница»', 'slonimcrb', '7e2ddb627e6e834e659677b2cf1e548d', 3, NULL, NULL, NULL, NULL, 10),
(399, 'Учреждение здравоохранения «Сморгонская центральная районная больница»', 'smorgcrb', '7460f0bf90ad05a3476a2a8446afc587', 3, NULL, NULL, NULL, NULL, 10),
(400, 'Учреждение здравоохранения «Щучинская центральная районная больница»', 'shuchincrb', '3455d19ad8467cecd135137f20eebd61', 3, NULL, NULL, NULL, NULL, 10),
(401, 'Учреждение здравоохранения «Городская клиническая больница №2 г.Гродно»', 'grogkb2', 'c6180191ec04fe17da056dbc96581fb7', 3, NULL, NULL, NULL, NULL, 10),
(402, 'Учреждение здравоохранения «Городская клиническая больница №4 г.Гродно»', 'grogkb4', '29ab02899987c6f7fc11dbb0c515ef41', 3, NULL, NULL, NULL, NULL, 10),
(403, 'Учреждение здравоохранения «Городская клиническая больница скорой медицинской помощи г.Гродно»', 'grogkbsmp', '375ef3cef27ef9ee99289f38e90e6da2', 3, NULL, NULL, NULL, NULL, 10),
(404, 'Учреждение здравоохранения «Гродненская областная клиническая больница медицинской реабилитации»', 'grookbmr', '13b6c27f5e517395aa56ba576162a1c9', 3, NULL, NULL, NULL, NULL, 10),
(405, 'Учреждение здравоохранения «Городская клиническая больница №3 г.Гродно»', 'grogkb3', '5d50215517167cb8886bfddcd8159776', 3, NULL, NULL, NULL, NULL, 10),
(406, 'Государственное учреждение здравоохранения «Гродненский областной центр медицинской реабилитации детей-инвалидов и больных детей психоневрологического профиля»', 'groocmrdi', '4caf8d406c40a21b5836e60623a5991c', 3, NULL, NULL, NULL, NULL, 10),
(407, 'Учреждение здравоохранения «Гродненская университетская клиника»', 'groyk', 'a00f82da0c12346f5d6ede51ddd681a9', 3, NULL, NULL, NULL, NULL, 10),
(408, 'Учреждение здравоохранения «Гродненская областная детская клиническая больница»', 'groodkb', 'acf0e407c36faa8cfc2713eab32a0384', 3, NULL, NULL, NULL, NULL, 10),
(409, 'Учреждение здравоохранения «Гродненская областная инфекционная клиническая больница»', 'grooikb', '79ed95f5e2236648654a0581ab5f17c6', 3, NULL, NULL, NULL, NULL, 10),
(410, 'Учреждение здравоохранения «Гродненский областной клинический перинатальный центр»', 'grookpc', '17d4f75befca91e80b721992f1849b8b', 3, NULL, NULL, NULL, NULL, 10),
(411, 'Учреждение здравоохранения «Гродненский областной клинический кардиологический центр»', 'grookkc', '488f402fcdd1076747de901a67cf216a', 3, NULL, NULL, NULL, NULL, 10),
(412, 'Учреждение здравоохранения «Гродненский областной клинический центр «Психиатрия-наркология»', 'grookcpn', '75866f1d586785f88031b29da0c46b28', 3, NULL, NULL, NULL, NULL, 10),
(413, 'Учреждение здравоохранения «Гродненский областной кожно-венерологический диспансер»', 'grookvd', '30b63c07f8fdf63c2357887319043cb2', 3, NULL, NULL, NULL, NULL, 10),
(414, 'Учреждение здравоохранения «Гродненский областной клинический центр «Фтизиатрия»', 'grookcf', '3b3a4207d0cc4c1526fa583d6637922e', 3, NULL, NULL, NULL, NULL, 10),
(415, 'Учреждение здравоохранения «Областная психоневрологическая больница «Островля»', 'ostrovlya', '813de2c26b7ed2b661161c3638ae8a35', 3, NULL, NULL, NULL, NULL, 10),
(416, 'Учреждение здравоохранения «Областной детский реабилитационный центр «Волковыск»', 'odrcvolk', '12515b4ea1e37ff329d64ecaa6b5e1de', 3, NULL, NULL, NULL, NULL, 10),
(417, 'Государственное учреждение «Республиканская психиатрическая больница «Гайтюнишки»', 'gaitushniki', '536be8025ed6ca2621ef1a89a9ecd370', 3, NULL, NULL, NULL, NULL, 10),
(418, 'Государственное учреждение «Республиканская туберкулезная больница «Новоельня»', 'novoelnya', '9a85352f35f69af7281d9d1d82e4ca2d', 3, NULL, NULL, NULL, NULL, 10),
(419, 'Государственное учреждение здравоохранения «Городская поликлиника №1 г.Гродно»', 'grogp1', '11f1c124b9dff9178e1090e984b9f587', 3, NULL, NULL, NULL, NULL, 10),
(420, 'Государственное учреждение здравоохранения «Гродненская центральная городская поликлиника»', 'grocgp', 'b781d76a2a50beedf2fca871da8f1cbf', 3, NULL, NULL, NULL, NULL, 10),
(421, 'Государственное учреждение здравоохранения «Городская поликлиника №3 г.Гродно»', 'grogp3', '52162b466875b7d8b595e858e11b89dd', 3, NULL, NULL, NULL, NULL, 10),
(422, 'Государственное учреждение здравоохранения «Городская поликлиника №4 г.Гродно»', 'grogp4', '4c510d112cb26270bcb8be47d55e9713', 3, NULL, NULL, NULL, NULL, 10),
(423, 'Государственное учреждение здравоохранения «Городская поликлиника №5 г.Гродно»', 'grogp5', 'c2c73f7301154dacf7954a4840d50d62', 3, NULL, NULL, NULL, NULL, 10),
(424, 'Государственное учреждение здравоохранения «Городская поликлиника №6 г.Гродно»', 'grogp6', 'abb55b0023d45dd4928327b0ae1c6712', 3, NULL, NULL, NULL, NULL, 10),
(425, 'Государственное учреждение здравоохранения «Городская поликлиника №7 г.Гродно»', 'grogp7', '82006997ef22e8270e22de489f97fb83', 3, NULL, NULL, NULL, NULL, 10),
(426, 'Государственное учреждение здравоохранения «Детская центральная городская клиническая поликлиника г.Гродно»', 'grodcgkp', 'b5a52e3a9c39c7b08f28370b8402963f', 3, NULL, NULL, NULL, NULL, 10),
(427, 'Учреждение здравоохранения «Гродненский областной эндокринологический диспансер»', 'grooed', '585384d35e5ed9a9e34ef71a3c0f5dee', 3, NULL, NULL, NULL, NULL, 10),
(428, 'Учреждение здравоохранения «Центральная городская стоматологическая поликлиника г.Гродно»', 'grocgsp', 'da2dc428bbc809b1f3c22a1413271cd2', 3, NULL, NULL, NULL, NULL, 10),
(429, 'Государственное учреждение здравоохранения «Гродненская областная станция скорой медицинской помощи»', 'groossmp', '173c5888677725a5dbc4dc53a715748b', 3, NULL, NULL, NULL, NULL, 10),
(430, 'Учреждение здравоохранения «Гродненский областной центр трансфузиологии»', 'grooct', '08e610e138205b8e98e9739cc7105184', 3, NULL, NULL, NULL, NULL, 10),
(431, 'Учреждение здравоохранения «1-я городская клиническая больница»', 'minskgkb1', '8077741081cdd2ec127a7fd15ead5433', 3, NULL, NULL, NULL, NULL, 5),
(432, 'Учреждение здравоохранения «2-я городская клиническая больница»', 'minskgkb2', '74f9d066764847be5969aee9986db9f3', 3, NULL, NULL, NULL, NULL, 5),
(433, 'Учреждение здравоохранения «3-я городская клиническая больница им.Е.В.Клумова»', 'minskgkb3', 'cf7883847e2a72c38897a90684818fe4', 3, NULL, NULL, NULL, NULL, 5),
(434, 'Учреждение здравоохранения «4-я городская клиническая больница им.Н.Е.Савченко»', 'minskgkb4', 'f887cf3e7922517773e14a838c38ab5d', 3, NULL, NULL, NULL, NULL, 5),
(435, 'Учреждение здравоохранения «5-я городская клиническая больница»', 'minskgkb5', '29a9dfeac69979be2f24c5271ea38500', 3, NULL, NULL, NULL, NULL, 5),
(436, 'Учреждение здравоохранения «6-я городская клиническая больница»', 'minskgkb6', '5d4baca68b5e6624eaf85e728dec9d38', 3, NULL, NULL, NULL, NULL, 5),
(437, 'Учреждение здравоохранения «Городская гинекологическая больница»', 'minckggb', '44ff592e0bec51d94f8d151c9ee5b370', 3, NULL, NULL, NULL, NULL, 5),
(438, 'Государственное учреждение «Минский научно-практический центр хирургии, трансплантологии и гематологии»', 'minsknpchtg', 'c294c4bf33def602a2c65a8d4b02be33', 3, NULL, NULL, NULL, NULL, 5),
(439, 'Учреждение здравоохранения «10-я городская клиническая больница»', 'minskgkb10', '055a6662591cc34d5fb8166748998016', 3, NULL, NULL, NULL, NULL, 5),
(440, 'Учреждение здравоохранения «11-я городская клиническая больница»', 'minskgkb11', 'ed5756a4afbc39771f62404801f45017', 3, NULL, NULL, NULL, NULL, 5),
(441, 'Учреждение здравоохранения «Городская клиническая больница скорой медицинской помощи»', 'minskgkbsmp', 'ca3ec9e56d33286f4b183ae2becb5b1e', 3, NULL, NULL, NULL, NULL, 5),
(442, 'Учреждение здравоохранения «Городская клиническая инфекционная больница»', 'miskgkib', '6e96560e790ebba797f053f168744f58', 3, NULL, NULL, NULL, NULL, 5),
(443, 'Учреждение здравоохранения «Минский городской центр медицинской реабилитации детей с психоневрологическими заболеваниями»', 'minskgcmrdpz', 'f3a7fb238cfdaa8ab94bfd21dff64305', 3, NULL, NULL, NULL, NULL, 5),
(444, 'Учреждение здравоохранения «2-я городская детская клиническая больница»', 'minskgdkb2', '419775c78e459dac01a4dde1dadc9083', 3, NULL, NULL, NULL, NULL, 5),
(445, 'Учреждение здравоохранения «3-я городская детская клиническая больница»', 'minskgdkb3', '2b1bc1b3d737ab9eb71d26eb6bb88ba6', 3, NULL, NULL, NULL, NULL, 5),
(446, 'Учреждение здравоохранения «4-я городская детская клиническая больница»', 'minskgdkb4', '18fea7fd43e45f26a009130937a9f74d', 3, NULL, NULL, NULL, NULL, 5),
(447, 'Учреждение здравоохранения «Городской клинический родильный дом №2»', 'minskgkrd2', '7b4ed65ed893594180e44f98901318b0', 3, NULL, NULL, NULL, NULL, 5),
(448, 'Учреждение здравоохранения «Городская детская инфекционная клиническая больница»', 'minskgdikb', 'f65d86de1fea533543058dc6a578c771', 3, NULL, NULL, NULL, NULL, 5),
(449, 'Государственное учреждение «Больница паллиативного ухода «Хоспис»', 'bpyhospis', '12dbb2a81232493714300d6fc407aa8c', 3, NULL, NULL, NULL, NULL, 5),
(450, 'Учреждение здравоохранения «Минский городской клинический центр дерматовенерологии»', 'minskgkcd', 'c197a3e0ab518a7d5863c3b4196e80a0', 3, NULL, NULL, NULL, NULL, 5),
(451, 'Учреждение здравоохранения «Минский клинический центр фтизиопульмонологии»', 'minskkcf', '4c0196a303e3cb20b6676b050a59a60a', 3, NULL, NULL, NULL, NULL, 5),
(452, 'Учреждение здравоохранения «Минский городской клинический наркологический центр»', 'minskgknc', 'febd034e8599e641b9b7edb99cd40d4e', 3, NULL, NULL, NULL, NULL, 5),
(453, 'Учреждение здравоохранения «Минский городской клинический центр детской психиатрии и психотерапии»', 'minskgkcdp', 'c49cbb504f1d1ca07b4fce8c3b02d34d', 3, NULL, NULL, NULL, NULL, 5),
(454, 'Учреждение здравоохранения «Минский городской клинический эндокринологический центр»', 'minskgked', 'bf3e91424c9b4aaea297630a96d4a7be', 3, NULL, NULL, NULL, NULL, 5),
(455, 'Учреждение здравоохранения «Минский городской клинический онкологический центр»', 'minskgkoc', 'e1a0bbe403fbb1310be00ad6adc56f65', 3, NULL, NULL, NULL, NULL, 5),
(456, 'Учреждение здравоохранения «Минский городской клинический центр психиатрии и психотерапии»', 'minskgkcp', '19c192671744b5b6cc65f07d4745869b', 3, NULL, NULL, NULL, NULL, 5),
(457, 'Коммунальное унитарное предприятие «Клинический центр пластической хирургии и медицинской косметологии г.Минска»', 'kcphmk', 'f3ca2b9889c48650f3f35e767acd423b', 3, NULL, NULL, NULL, NULL, 5),
(458, 'Учреждение здравоохранения «Дом ребенка №1 для детей с органическим поражением центральной нервной системы и психики»', 'dr1', '3e57552d09e7949707b1e2f6ee3ff446', 3, NULL, NULL, NULL, NULL, 5),
(459, 'Учреждение здравоохранения «Городской детский центр медицинской реабилитации «Пралеска»', 'praleska', '7f3d52da727e7a1a82a9f90c17f45bc5', 3, NULL, NULL, NULL, NULL, 5),
(460, 'Учреждение здравоохранения «1-я центральная районная клиническая поликлиника Центрального района г.Минска»', 'minskcrkp1', 'a49ae7293e1f76462895ec9d17dc3085', 3, NULL, NULL, NULL, NULL, 5),
(461, 'Учреждение здравоохранения «2-я центральная районная поликлиника Фрунзенского района г.Минска»', 'minskcrp2', '0f4e8d0f609b408fd81043d7f90e6725', 3, NULL, NULL, NULL, NULL, 5),
(462, 'Учреждение здравоохранения «3-я центральная районная клиническая поликлиника Октябрьского района г.Минска»', 'minskcrkp3', 'd9275466f9c9f8eef80f66628575f71d', 3, NULL, NULL, NULL, NULL, 5),
(463, 'Учреждение здравоохранения «4-я городская поликлиника»', 'minskgp4', '777f8162f1fdc6f45fb000e97e77cc93', 3, NULL, NULL, NULL, NULL, 5),
(464, 'Учреждение здравоохранения «5-я городская клиническая поликлиника»', 'minskgkp5', 'cd1f2d254e0a5085bdf11780280f0eb8', 3, NULL, NULL, NULL, NULL, 5),
(465, 'Учреждение здравоохранения «6-я центральная районная клиническая поликлиника Ленинского района г.Минска»', 'minskcrkp6', '92a17555d73b48bcd3f55768415e4823', 3, NULL, NULL, NULL, NULL, 5),
(466, 'Учреждение здравоохранения «7-я городская поликлиника»', 'minskgp7', 'bb8937cc414e9bfe02498fe5b2e9ceeb', 3, NULL, NULL, NULL, NULL, 5),
(467, 'Учреждение здравоохранения «8-я городская поликлиника»', 'minskgp8', '61f7d9cd19547c5250070bfddad10abc', 3, NULL, NULL, NULL, NULL, 5),
(468, 'Учреждение здравоохранения «9-я городская поликлиника»', 'minskgp9', 'd98613d50c609e834a43cff912a3edf0', 3, NULL, NULL, NULL, NULL, 5),
(469, 'Учреждение здравоохранения «10-я городская поликлиника»', 'minskgp10', '45ce9a93c18babf454a947cf0044f57a', 3, NULL, NULL, NULL, NULL, 5),
(470, 'Учреждение здравоохранения «11-я городская поликлиника»', 'minskgp11', 'f2ff676eee8f308af96022e5bf3312d7', 3, NULL, NULL, NULL, NULL, 5),
(471, 'Учреждение здравоохранения «12-я городская поликлиника»', 'minskgp12', '0b665bb7db2c6d102c67aea598e850c2', 3, NULL, NULL, NULL, NULL, 5),
(472, 'Учреждение здравоохранения «13-я городская поликлиника»', 'minskgp13', 'a83f8e0544293d30291f09dc38e89ed2', 3, NULL, NULL, NULL, NULL, 5),
(473, 'Учреждение здравоохранения «14-я центральная районная поликлиника Партизанского района г.Минска»', 'minskcrp14', '6c4dc5308b0b62870da477602ec51b8a', 3, NULL, NULL, NULL, NULL, 5),
(474, 'Учреждение здравоохранения «15-я городская поликлиника»', 'minskgp15', '7c4e8bda9b1029111f85215c95cf5a0a', 3, NULL, NULL, NULL, NULL, 5),
(475, 'Учреждение здравоохранения «16-я городская клиническая поликлиника»', 'minskgkp16', '58a77d904df903c1371e4a7816ffbffa', 3, NULL, NULL, NULL, NULL, 5),
(476, 'Учреждение здравоохранения «17-я городская клиническая  поликлиника»', 'minskgkp17', 'bf16be9fc041c176f61626447c474333', 3, NULL, NULL, NULL, NULL, 5),
(477, 'Учреждение здравоохранения «18-я городская поликлиника»', 'minskgp18', '9ea905ec4602203c96bf8423257ba282', 3, NULL, NULL, NULL, NULL, 5);
INSERT INTO `users` (`id_user`, `username`, `login`, `password`, `id_role`, `online`, `last_act`, `last_time_online`, `last_page`, `oblast`) VALUES
(478, 'Учреждение здравоохранения «19-я центральная районная поликлиника Первомайского района г.Минска»', 'minskcrp19', 'fb67d60744410e3c6e1e796c02502314', 3, NULL, NULL, NULL, NULL, 5),
(479, 'Учреждение здравоохранения «20-я городская поликлиника»', 'minskgp20', '36594f40a233335937f07c8c95ae1d62', 3, NULL, NULL, NULL, NULL, 5),
(480, 'Учреждение здравоохранения «21-я центральная районная поликлиника Заводского района г.Минска»', 'minskcrp21', '9eed04fd17bb70fc6f7e911dc4c5c68c', 3, NULL, NULL, NULL, NULL, 5),
(481, 'Учреждение здравоохранения «22-я городская поликлиника»', 'minskgp22', 'c110cc2d0e847acac314e18ae349b8c7', 3, NULL, NULL, NULL, NULL, 5),
(482, 'Учреждение здравоохранения «23-я городская поликлиника»', 'minskgp23', 'd0c03848b24bc92042ca4415508620b9', 3, NULL, NULL, NULL, NULL, 5),
(483, 'Коммунальное унитарное предприятие «24-я городская поликлиника спецмедосмотров»', 'minskgps24', 'd97965b7bbb79066b56286a840c9ef90', 3, NULL, NULL, NULL, NULL, 5),
(484, 'Учреждение здравоохранения «25-я центральная районная поликлиника Московского района г.Минска»', 'minskcrp25', 'a9533383f805a39b5116af28d3d0b7cd', 3, NULL, NULL, NULL, NULL, 5),
(485, 'Учреждение здравоохранения «26-я городская поликлиника»', 'minskgp26', 'b7736c1bdce23fea45b67ed08b00d06f', 3, NULL, NULL, NULL, NULL, 5),
(486, 'Учреждение здравоохранения «27-я городская поликлиника»', 'minskgp27', 'febd17994718e5f9852f5de442323dda', 3, NULL, NULL, NULL, NULL, 5),
(487, 'Учреждение здравоохранения «28-я городская поликлиника»', 'minskgp28', 'f1b4e9923aa44dc9130e8c79b1d9fd2a', 3, NULL, NULL, NULL, NULL, 5),
(488, 'Учреждение здравоохранения «29-я городская поликлиника»', 'minskgp29', 'ef5a31d6c585ddb21bea1ab2e39f6109', 3, NULL, NULL, NULL, NULL, 5),
(489, 'Учреждение здравоохранения «30-я городская клиническая поликлиника»', 'minskgkp30', 'e602a931fd5da41eba5aa71a572228d2', 3, NULL, NULL, NULL, NULL, 5),
(490, 'Учреждение здравоохранения «31-я городская поликлиника»', 'minskgp31', '9538669461898aadd88fef81945b1f9e', 3, NULL, NULL, NULL, NULL, 5),
(491, 'Учреждение здравоохранения «32-я городская клиническая поликлиника»', 'minskgkp32', 'eefe13b7e7117f46b0092a504128103b', 3, NULL, NULL, NULL, NULL, 5),
(492, 'Учреждение здравоохранения «33-я городская студенческая поликлиника»', 'minskgsp33', '5f6eb302499619f3c8206b393d9f467f', 3, NULL, NULL, NULL, NULL, 5),
(493, 'Учреждение здравоохранения «34-я центральная районная клиническая поликлиника Советского района г.Минска»', 'minskcrkp34', '0c510dfbdcd8c40b3f3bca040568511f', 3, NULL, NULL, NULL, NULL, 5),
(494, 'Учреждение здравоохранения «35-я городская клиническая поликлиника»', 'minskgkp35', 'b47152490d298dd0b84cd8d36fd9de26', 3, NULL, NULL, NULL, NULL, 5),
(495, 'Учреждение здравоохранения «36-я городская поликлиника»', 'minskgp36', 'ad2e9cfefea8ac21b96a46dfa34dc8eb', 3, NULL, NULL, NULL, NULL, 5),
(496, 'Учреждение здравоохранения «37-я городская поликлиника»', 'minskgp37', '727eec68355af1786722592a96a9e60b', 3, NULL, NULL, NULL, NULL, 5),
(497, 'Учреждение здравоохранения «38-я городская клиническая поликлиника»', 'minskgkp38', '9ec9240d0cfb206d69a8bb3032cceca7', 3, NULL, NULL, NULL, NULL, 5),
(498, 'Учреждение здравоохранения «39-я городская клиническая поликлиника»', 'minskgkp39', '15fcea6fa14f59903388a0712895b6b7', 3, NULL, NULL, NULL, NULL, 5),
(499, 'Учреждение здравоохранения «40-я городская клиническая поликлиника»', 'minskgkp40', 'e1af19d038f00e1bc3b9fb8c5d80cc7b', 3, NULL, NULL, NULL, NULL, 5),
(500, 'Учреждение здравоохранения «1-я городская детская поликлиника»', 'minskgdp1', '2d167ffa145c7b61e567381dbaf0de51', 3, NULL, NULL, NULL, NULL, 5),
(501, 'Учреждение здравоохранения «2-я городская детская поликлиника»', 'minskgdp2', 'dffc2732d3ce0a0bfbfce0f798349f4b', 3, NULL, NULL, NULL, NULL, 5),
(502, 'Учреждение здравоохранения «3-я городская детская клиническая поликлиника»', 'minskgkdp3', '47aadf5ae36bae2379804a0c924abf48', 3, NULL, NULL, NULL, NULL, 5),
(503, 'Учреждение здравоохранения «4-я городская детская клиническая поликлиника»', 'minskgkdp4', '31056cd99d5b2c9af1c42136eaa04ebe', 3, NULL, NULL, NULL, NULL, 5),
(504, 'Учреждение здравоохранения «5-я городская детская поликлиника»', 'minskgdp5', 'aaf4f9ec53174daed79817674df96354', 3, NULL, NULL, NULL, NULL, 5),
(505, 'Учреждение здравоохранения «6-я городская детская клиническая поликлиника»', 'minskgkdp6', '61afe4138acd8b8c5c867d0b9ec9ac63', 3, NULL, NULL, NULL, NULL, 5),
(506, 'Учреждение здравоохранения «7-я городская детская поликлиника»', 'minskgdp7', '68832852d35e1aa32b40055dbbf47eac', 3, NULL, NULL, NULL, NULL, 5),
(507, 'Учреждение здравоохранения «8-я городская детская клиническая поликлиника»', 'minskgkdp8', 'e28d31190ddbddbe50ecdfb396c35e20', 3, NULL, NULL, NULL, NULL, 5),
(508, 'Учреждение здравоохранения «9-я городская детская поликлиника»', 'minskgdp9', 'c5c103a4216200dc7e69a3e0ad262186', 3, NULL, NULL, NULL, NULL, 5),
(509, 'Учреждение здравоохранения «10-я городская детская клиническая поликлиника»', 'minskgkdp10', '2b02283356c4c48f51c5be7c6ae1deed', 3, NULL, NULL, NULL, NULL, 5),
(510, 'Учреждение здравоохранения «11-я городская детская поликлиника»', 'minskgdp11', '9c31b4450f919621fa09ca69f625aa04', 3, NULL, NULL, NULL, NULL, 5),
(511, 'Учреждение здравоохранения «12-я городская детская поликлиника»', 'minskgdp12', 'dd312e5fd30fa0ad7f247ce826e51551', 3, NULL, NULL, NULL, NULL, 5),
(512, 'Учреждение здравоохранения «13-я городская детская клиническая поликлиника»', 'minskgkdp13', 'e4ece2beeb5d7f5590d1c21be1e9315c', 3, NULL, NULL, NULL, NULL, 5),
(513, 'Учреждение здравоохранения «14-я городская детская клиническая поликлиника»', 'minskgkdp14', '0b563a6951a2c5227360608c8d5aefa3', 3, NULL, NULL, NULL, NULL, 5),
(514, 'Учреждение здравоохранения «15-я городская детская поликлиника»', 'minskgdp15', 'f84f858442d0c0ae5101712e23215f6d', 3, NULL, NULL, NULL, NULL, 5),
(515, 'Учреждение здравоохранения «16-я городская детская поликлиника»', 'minskgdp16', '4dd7d81f74e85161a7fe3841858cf8b6', 3, NULL, NULL, NULL, NULL, 5),
(516, 'Учреждение здравоохранения «17-я городская детская клиническая поликлиника»', 'minskgkdp17', '7f7fd22f74d5122c5e10e66409f28904', 3, NULL, NULL, NULL, NULL, 5),
(517, 'Учреждение здравоохранения «19-я городская детская поликлиника»', 'minskgdp19', '278d2297a0c5ed27dacda9fb05a2dc3e', 3, NULL, NULL, NULL, NULL, 5),
(518, 'Учреждение здравоохранения «20-я городская детская поликлиника»', 'minskgdp20', 'a1676109081e1e2f341542f105e51f02', 3, NULL, NULL, NULL, NULL, 5),
(519, 'Учреждение здравоохранения «22-я городская детская поликлиника»', 'minskgdp22', 'cdb8d6c1e8b3a641dd48c5948e4d363a', 3, NULL, NULL, NULL, NULL, 5),
(520, 'Учреждение здравоохранения «23-я городская детская поликлиника»', 'minskgdp23', 'b66e906f44991ef875294571ca5ac232', 3, NULL, NULL, NULL, NULL, 5),
(521, 'Учреждение здравоохранения «25-я городская детская поликлиника»', 'minskgdp25', '07a25eb75891ff350bf97bfcacc05470', 3, NULL, NULL, NULL, NULL, 5),
(522, 'Учреждение здравоохранения «Минский городской детский клинический центр по стоматологии»', 'minskgdkcs', 'e212a168d31523c8215cbb1cfb2b1ed1', 3, NULL, NULL, NULL, NULL, 5),
(523, 'Коммунальное унитарное предприятие «Клиника эстетической стоматологии»', 'minskkes', 'a1be11d9fa6b58d1cb98bfcae70bf54b', 3, NULL, NULL, NULL, NULL, 5),
(524, 'Учреждение здравоохранения «3-я городская стоматологическая поликлиника»', 'minskgsp3', 'a909d5bc04a6dc81ea4c82d0abfec98e', 3, NULL, NULL, NULL, NULL, 5),
(525, 'Учреждение здравоохранения «4-я городская клиническая стоматологическая поликлиника»', 'minskgksp4', 'cd8f4965161ed19caa7a8258611e4324', 3, NULL, NULL, NULL, NULL, 5),
(526, 'Учреждение здравоохранения «5-я городская стоматологическая поликлиника»', 'minskgsp5', 'f1ea2cffb06a707474ec44c712684308', 3, NULL, NULL, NULL, NULL, 5),
(527, 'Открытое акционерное общество «Медицинская инициатива»', 'minskmediniciat', 'd90396c3b199537a590b1e8602017ed6', 3, NULL, NULL, NULL, NULL, 5),
(528, 'Учреждение здравоохранения «7-я городская стоматологическая поликлиника»', 'minskgsp7', 'da201cdce4c52989352eea367dd553f5', 3, NULL, NULL, NULL, NULL, 5),
(529, 'Учреждение здравоохранения «8-я городская клиническая стоматологическая поликлиника»', 'minskgksp8', '8ba7a065f87886f6945bb6a84dc0bc8d', 3, NULL, NULL, NULL, NULL, 5),
(530, 'Открытое акционерное общество «БелСтомКристал»', 'minskbelstomkrist', '4ec87c0f82854ad99ed5571a4422e81c', 3, NULL, NULL, NULL, NULL, 5),
(531, 'Учреждение здравоохранения «10-я городская стоматологическая поликлиника»', 'minskgsp10', '297cee5943be403abaa808d7a88c1030', 3, NULL, NULL, NULL, NULL, 5),
(532, 'Учреждение здравоохранения «11-я городская клиническая стоматологическая поликлиника»', 'minskgksp11', '94f0bdb46049b9fe194c7a4cfb497e7c', 3, NULL, NULL, NULL, NULL, 5),
(533, 'Учреждение здравоохранения «12-я городская клиническая стоматологическая поликлиника»', 'minskgksp12', '4b43bdefbfdecfe080a8431c3b7614d7', 3, NULL, NULL, NULL, NULL, 5),
(534, 'Учреждение здравоохранения «13-я городская стоматологическая поликлиника»', 'minskgsp13', '0a6f27e81af711ff8b0a56ff5d9608bc', 3, NULL, NULL, NULL, NULL, 5),
(535, 'Учреждение здравоохранения «14-я городская стоматологическая поликлиника»', 'minskgsp14', 'ead3d15e421802f54bc9923c72db5024', 3, NULL, NULL, NULL, NULL, 5),
(536, 'Учреждение здравоохранения «Минский клинический консультативно-диагностический центр»', 'minskkk-dc', '56770ca8d61e7f0d4565ff37a9dd2f09', 3, NULL, NULL, NULL, NULL, 5),
(537, 'Учреждение здравоохранения «Городская станция скорой медицинской помощи»', 'minskgssmp', 'c79a35fa52f51e297844cecc514407e4', 3, NULL, NULL, NULL, NULL, 5),
(538, 'Учреждение здравоохранения «Березинская центральная районная больница»', 'berezcrb', 'c1f99e6e13b13658ccd2f75667eafaf9', 3, NULL, NULL, NULL, NULL, 6),
(539, 'Учреждение здравоохранения «Борисовская центральная районная больница»', 'borisovcrb', '063ff19868ce091bd9c0901963814832', 3, NULL, NULL, NULL, NULL, 6),
(540, 'Учреждение здравоохранения «Борисовская больница №2»', 'borisovb2', '81f4ccfeb6499fe316ec5dfbe2cc7364', 3, NULL, NULL, NULL, NULL, 6),
(541, 'Учреждение здравоохранения «Борисовский родильный дом»', 'borisovrd', 'e94ed88654eb0825e0821b2ce165efe2', 3, NULL, NULL, NULL, NULL, 6),
(542, 'Учреждение здравоохранения «Вилейская центральная районная больница»', 'vileiskcrb', '6d5a1612ecb527419887cf244c536e82', 3, NULL, NULL, NULL, NULL, 6),
(543, 'Учреждение здравоохранения «Воложинская центральная районная больница»', 'volozhcrb', '38d59aefa7cee56d250f3382f039969f', 3, NULL, NULL, NULL, NULL, 6),
(544, 'Учреждение здравоохранения «Дзержинская центральная районная больница»', 'dzerjinskcrb', '2c70e911f7aeae2aa29b83859f994f9b', 3, NULL, NULL, NULL, NULL, 6),
(545, 'Учреждение здравоохранения «Клецкая центральная районная больница»', 'kleckcrb', '4e683bd8ea37954bc16d91fe937a16fc', 3, NULL, NULL, NULL, NULL, 6),
(546, 'Учреждение здравоохранения «Копыльская центральная районная больница»', 'kopylcrb', 'e595104dc2aeecc231a9a88ed2487344', 3, NULL, NULL, NULL, NULL, 6),
(547, 'Учреждение здравоохранения «Крупская центральная районная больница»', 'krypskcrb', 'c753f7bedac699cf2479605881c41d40', 3, NULL, NULL, NULL, NULL, 6),
(548, 'Учреждение здравоохранения «Логойская центральная районная больница»', 'logoiskcrb', '06f21f453aa7b29d59c59a9937a6a118', 3, NULL, NULL, NULL, NULL, 6),
(549, 'Учреждение здравоохранения «Любанская центральная районная больница»', 'ljybanskcrb', 'd7bb500e7a639ab861e5f24f7c67ea71', 3, NULL, NULL, NULL, NULL, 6),
(550, 'Учреждение здравоохранения «Минская центральная районная клиническая больница»', 'minskcrkp', 'f8c8a2033e35b8fc7a2f7f0fe20fe104', 3, NULL, NULL, NULL, NULL, 6),
(551, 'Учреждение здравоохранения «Молодечненская центральная районная больница»', 'molocrb', '889f4be50ee80b49a27f78e4731bca37', 3, NULL, NULL, NULL, NULL, 6),
(552, 'Учреждение здравоохранения «Мядельская центральная районная больница»', 'myadelcrb', 'a1ec84bacb8dcd86398e5c440b5513b0', 3, NULL, NULL, NULL, NULL, 6),
(553, 'Учреждение здравоохранения «Несвижская центральная районная больница»', 'nesvijcrb', 'd5d41aa55812ac03b633b6b41b4a5c7d', 3, NULL, NULL, NULL, NULL, 6),
(554, 'Учреждение здравоохранения «Марьиногорская центральная районная больница»', 'marjincrb', '427aaa528b901ee0fca94796cd28bf88', 3, NULL, NULL, NULL, NULL, 6),
(555, 'Учреждение здравоохранения «Слуцкая центральная районная больница»', 'slyckcrb', '4f7186403db01805068b6200666a1c17', 3, NULL, NULL, NULL, NULL, 6),
(556, 'Учреждение здравоохранения «Смолевичская центральная районная больница»', 'smolcrb', '32705eeae7a46be9f479bd77322330f0', 3, NULL, NULL, NULL, NULL, 6),
(557, 'Учреждение здравоохранения «Солигорская центральная районная больница»', 'soligorskcrb', '26b04073d86c78b205a3e9368334e159', 3, NULL, NULL, NULL, NULL, 6),
(558, 'Учреждение здравоохранения «Стародорожская центральная районная больница»', 'starodorcrb', '20f7cff1c18d1ada41b666bdb564f161', 3, NULL, NULL, NULL, NULL, 6),
(559, 'Учреждение здравоохранения «Столбцовская центральная районная больница»', 'stolbcrb', '564ae91ac1b6198708ca618deb7fbb7d', 3, NULL, NULL, NULL, NULL, 6),
(560, 'Учреждение здравоохранения «Узденская центральная районная больница»', 'yzdencrb', '6efd980429d156cd81507a5ea24304d4', 3, NULL, NULL, NULL, NULL, 6),
(561, 'Учреждение здравоохранения «Червенская центральная районная больница»', 'chervcrb', 'af90bdfcdd0d4534a2a93c588c5d185e', 3, NULL, NULL, NULL, NULL, 6),
(562, 'Учреждение здравоохранения «Жодинская центральная городская больница»', 'zhodincrb', '9e266236c63a7c5e485f1c37383f9e47', 3, NULL, NULL, NULL, NULL, 6),
(563, 'Учреждение здравоохранения «Минская ордена трудового Красного Знамени областная клиническая больница»', 'minskotkzokb', '22edaaeb3be37f555ccb0fb7cd898b0c', 3, NULL, NULL, NULL, NULL, 6),
(564, 'Учреждение здравоохранения «Минская областная детская клиническая больница»', 'minskodkb', '8578c6bc6f6c697a1a26c7b291f3eb54', 3, NULL, NULL, NULL, NULL, 6),
(565, 'Учреждение здравоохранения «Минский областной противотуберкулезный диспансер» ', 'minskopd', '01231c7aa90587798f7305bc18629372', 3, NULL, NULL, NULL, NULL, 6),
(566, 'Учреждение здравоохранения «Минский областной клинический центр «Психиатрия-Наркология»', 'minskokcpsih', '12994f80694ab46c31c6b12624cad1e0', 3, NULL, NULL, NULL, NULL, 6),
(567, 'УУчреждение здравоохранения «Клинический родильный дом Минской области»', 'minskclinrd', '02d76e7e6e58217bfeadab8dd27ae966', 3, NULL, NULL, NULL, NULL, 6),
(568, 'Учреждение здравоохранение «Областной детский центр медицинской реабилитации «Пуховичи»', 'puhovodcm', 'cfc40cfe028a2add9c25ca27d545dde8', 3, NULL, NULL, NULL, NULL, 6),
(569, 'Учреждение здравоохранения «Областной центр медицинской реабилитации «Загорье»', 'zagorocmr', '577fa90dbd5be5fa47483359154d2de0', 3, NULL, NULL, NULL, NULL, 6),
(570, 'Государственное учреждение «Минский областной клинический госпиталь инвалидов Великой Отечественной войны имени П.М. Машерова»', 'masherovagos', '9272b0718d0c05a0c13304e2ea03f4f3', 3, NULL, NULL, NULL, NULL, 6),
(571, 'Государственное учреждение здравоохранения «Минский областной центр скорой медицинской помощи»', 'minskocsmp', '82f2db7a583f75592d2ac32be21f5460', 3, NULL, NULL, NULL, NULL, 6),
(572, 'Учреждение здравоохранения «Минская областная станция переливания крови»', 'minskoblkrov', '03d9d611ac714956da90806fb8a80382', 3, NULL, NULL, NULL, NULL, 6),
(573, 'Учреждение здравоохранения «Белыничская центральная районная больница»', 'belchinskcrb', '49715f9d92932c8f05b02842b4f5cbc4', 3, NULL, NULL, NULL, NULL, 8),
(574, 'Учреждение здравоохранения «Быховская центральная районная больница»', 'byhovcrb', '6159d01ec032df6d9d35ee7988c0d68a', 3, NULL, NULL, NULL, NULL, 8),
(575, 'Учреждение здравоохранения «Глусская центральная районная больница»', 'glusskcrb', '73d7bab27cc6fd2abf964aef5bbd35dd', 3, NULL, NULL, NULL, NULL, 8),
(576, 'Учреждение здравоохранения «Горецкая центральная районная больница»', 'goreckcrb', '201923fa629f2f0a4e1500e1e5a9be7b', 3, NULL, NULL, NULL, NULL, 8),
(577, 'Учреждение здравоохранения «Дрибинская центральная районная больница»', 'dribinskcrb', 'c532aea1a786f13578ecddd53f5c38ec', 3, NULL, NULL, NULL, NULL, 8),
(578, 'Учреждение здравоохранения «Кировская центральная районная больница»', 'kirovskcrb', 'be2037683bd48c9b82a999b50c673ffc', 3, NULL, NULL, NULL, NULL, 8),
(579, 'Учреждение здравоохранения «Климовичская центральная районная больница»', 'klimovichcrb', 'e8c10d6d6b6503ec65e9ebfd6ac79dc4', 3, NULL, NULL, NULL, NULL, 8),
(580, 'Учреждение здравоохранения «Кличевская центральная районная больница»', 'klichevskcrb', '66c6a982935b2294381bea8ff7d7485a', 3, NULL, NULL, NULL, NULL, 8),
(581, 'Учреждение здравоохранения «Костюковичская центральная районная больница»', 'kostukovichcrb', 'd450fc5b0180e1eec1903a4f38fcd33e', 3, NULL, NULL, NULL, NULL, 8),
(582, 'Учреждение здравоохранения «Краснопольская центральная районная больница»', 'krasnopolcrb', '03d9d611ac714956da90806fb8a80382', 3, NULL, NULL, NULL, NULL, 8),
(583, 'Учреждение здравоохранения «Кричевская центральная районная больница»', 'krichevcrb', '952ac25b4d5a7879c1d3930ce2f210da', 3, NULL, NULL, NULL, NULL, 8),
(584, 'Учреждение здравоохранения «Круглянская центральная районная больница»', 'kruglyanskcrb', '7d1fb57ae9eef504a2636e6f45da6725', 3, NULL, NULL, NULL, NULL, 8),
(585, 'Учреждение здравоохранения «Мстиславская центральная районная больница»', 'mstislavcrb', '2222e6df367e07d376f95f3167358442', 3, NULL, NULL, NULL, NULL, 8),
(586, 'Учреждение здравоохранения «Осиповичская центральная районная больница»', 'osipovcrb', '863164118b2e6a287d4921d0724cfc3e', 3, NULL, NULL, NULL, NULL, 8),
(587, 'Учреждение здравоохранения «Славгородская центральная районная больница»', 'slavgorodcrb', '3a1dba7a47ee83ae94887c18cc6b06ce', 3, NULL, NULL, NULL, NULL, 8),
(588, 'Учреждение здравоохранения «Хотимская центральная районная больница»', 'hotimskcrb', '21b7f6ce0cb7485844aa2078e01dc55c', 3, NULL, NULL, NULL, NULL, 8),
(589, 'Учреждение здравоохранения «Чаусская центральная районная больница»', 'chausskcrb', '144303e3ffadf937b69b7b5c71d69e24', 3, NULL, NULL, NULL, NULL, 8),
(590, 'Учреждение здравоохранения «Чериковская центральная районная больница»', 'cherikcrb', '8a7652f6ff6794cf421962c48539740c', 3, NULL, NULL, NULL, NULL, 8),
(591, 'Учреждение здравоохранения «Шкловская центральная районная больница»', 'shklovcrb', 'fe22f78a007f88894fca1beac7cf6d16', 3, NULL, NULL, NULL, NULL, 8),
(592, 'Учреждение здравоохранения «Могилевская областная клиническая больница»', 'mogokb', 'a051da69ad8d10e1861d594ff2d4c150', 3, NULL, NULL, NULL, NULL, 8),
(593, 'Учреждение здравоохранения «Могилевская областная детская больница»', 'mogodb', '4f38da349f1b5dc4f917845c1383afaf', 3, NULL, NULL, NULL, NULL, 8),
(594, 'Учреждение здравоохранения «Могилевская областная больница медицинской реабилитации»', 'mogobmr', '383ab435d323f3cb5d8a95cd4ccad4a7', 3, NULL, NULL, NULL, NULL, 8),
(595, 'Учреждение здравоохранения «Могилевская областная психиатрическая больница»', 'mogpsix', '44f701e297128c30294df35ffecd165a', 3, NULL, NULL, NULL, NULL, 8),
(596, 'Учреждение здравоохранения «Областной детский центр медицинской реабилитации «Космос»', 'kosmosodcmr', '4d9625d1d5df5100a3b8eae96dcfefea', 3, NULL, NULL, NULL, NULL, 8),
(597, 'Учреждение здравоохранения «Могилевский областной противотуберкулезный диспансер»', 'mogopd', '1bfa3df58cbf32f82013e236efab75c8', 3, NULL, NULL, NULL, NULL, 8),
(598, 'Учреждение здравоохранения «Могилевский областной онкологический диспансер»', 'mogood', '99a512655322184d12abf78532335e31', 3, NULL, NULL, NULL, NULL, 8),
(599, 'Учреждение здравоохранения «Могилевский областной наркологический диспансер»', 'mognarkodis', '18ddd4577d0cf21244e2018a54ed3dc0', 3, NULL, NULL, NULL, NULL, 8),
(600, 'Учреждение здравоохранения «Могилевский областной кожно-венерологический диспансер»', 'mogokvd', 'eb50777a74a5c82572ca1f96f0da2e8c', 3, NULL, NULL, NULL, NULL, 8),
(601, 'Учреждение здравоохранения «Могилевская больница №1»', 'mogboln1', '179fa3b86f2bfcd5ee3050230b5ec4c1', 3, NULL, NULL, NULL, NULL, 8),
(602, 'Учреждение здравоохранения «Могилевская городская больница скорой медицинской помощи»', 'moggbsmp', 'd168204c9e80c12a49c85054ee5fb9c0', 3, NULL, NULL, NULL, NULL, 8),
(603, 'Учреждение здравоохранения «Бобруйская городская больница скорой медицинской помощи»', 'bobrgbsmp', '042d89984c7c22c5fb29243969dacfbf', 3, NULL, NULL, NULL, NULL, 8),
(604, 'Учреждение здравоохранения «Бобруйский межрайонный онкологический диспансер»', 'bobrmod', '3574ea5130633c245f2bb46ed9bc8f99', 3, NULL, NULL, NULL, NULL, 8),
(605, 'Учреждение здравоохранения «Бобруйская центральная больница»', 'bobrcb', '2c8b4316a4a7bc217d6851439409ff99', 3, NULL, NULL, NULL, NULL, 8),
(606, 'Учреждение здравоохранения «Бобруйский родильный дом»', 'bobrroddom', '27c568423b3c609755cd8b520c10f538', 3, NULL, NULL, NULL, NULL, 8),
(607, 'Учреждение здравоохранения «Могилевская центральная поликлиника»', 'mogcp', 'd3b314da80406cd6710818ce0c743013', 3, NULL, NULL, NULL, NULL, 8),
(608, 'Учреждение здравоохранения «Могилевская поликлиника №2»', 'mogp2', '9d3fc5512fe1aafcc7264a8dac7482f8', 3, NULL, NULL, NULL, NULL, 8),
(609, 'Учреждение здравоохранения «Могилевская поликлиника №3»', 'mogp3', '7a59e425f42a940d259ceeb2ba45d196', 3, NULL, NULL, NULL, NULL, 8),
(610, 'Учреждение здравоохранения «Могилевская поликлиника №4»', 'mogp4', '149f68c46fe5f843cbc507c61a3c9347', 3, NULL, NULL, NULL, NULL, 8),
(611, 'Учреждение здравоохранения «Могилевская поликлиника №5»', 'mogp5', '3fe843611bc8900f4536c98b0a3a4af3', 3, NULL, NULL, NULL, NULL, 8),
(612, 'Учреждение здравоохранения «Могилевская поликлиника №6»', 'mogp6', '9a206161439c50425c430c7bf504d773', 3, NULL, NULL, NULL, NULL, 8),
(613, 'Учреждение здравоохранения «Могилевская поликлиника №7»', 'mogp7', 'fab27634b401b89c7d8b9c71d9236ca3', 3, NULL, NULL, NULL, NULL, 8),
(614, 'Учреждение здравоохранения «Могилевская поликлиника №8»', 'mogp8', '9d87e2f94c00ef73496ead7c3d77d5fb', 3, NULL, NULL, NULL, NULL, 8),
(615, 'Учреждение здравоохранения «Могилевская поликлиника №9»', 'mogp9', 'd08d117aae9c965e466b9efc462af918', 3, NULL, NULL, NULL, NULL, 8),
(616, 'Учреждение здравоохранения «Могилевская поликлиника №10»', 'mogp10', '95f24b39ca284749e969123b03826129', 3, NULL, NULL, NULL, NULL, 8),
(617, 'Учреждение здравоохранения «Могилевская поликлиника №11»', 'mogp11', 'ec735cf357164d58ffc13749ecbee253', 3, NULL, NULL, NULL, NULL, 8),
(618, 'Учреждение здравоохранения «Могилевская поликлиника №12»', 'mogp12', '3846182d1027a163d3f861c440d2490c', 3, NULL, NULL, NULL, NULL, 8),
(619, 'Учреждение здравоохранения «Могилевская детская поликлиника»', 'mogdp', 'ee6546f8c875f223ff9b93fa9a69e103', 3, NULL, NULL, NULL, NULL, 8),
(620, 'Учреждение здравоохранения «Могилевская детская поликлиника №1»', 'mogdp1', '690ed76c47772ff931e794471b9ddbbb', 3, NULL, NULL, NULL, NULL, 8),
(621, 'Учреждение здравоохранения «Могилевская детская поликлиника №2»', 'mogdp2', 'ddc4a16f9f6035eead88a21c0ee201c9', 3, NULL, NULL, NULL, NULL, 8),
(622, 'Учреждение здравоохранения «Могилевская детская поликлиника №4»', 'mogdp4', 'eb94cc5ef740b71b7790279db0ab33aa', 3, NULL, NULL, NULL, NULL, 8),
(623, 'Учреждение здравоохранения «Могилевский областной лечебно-диагностический центр»', 'mogoblldc', 'bd30c87c3b25a4c0728ec75482114408', 3, NULL, NULL, NULL, NULL, 8),
(624, 'Учреждение здравоохранения «Могилевская стоматологическая поликлиника»', 'mogsp', '1835f860ba01893817d883bee26287c3', 3, NULL, NULL, NULL, NULL, 8),
(625, 'Учреждение здравоохранения «Могилевская стоматологическая поликлиника №2»', 'mogsp2', 'f95eb5b05e6c43258d1fab5e015f0e47', 3, NULL, NULL, NULL, NULL, 8),
(626, 'Учреждение здравоохранения «Могилевская детская стоматологическая поликлиника»', 'mogdsp', 'ae38252515140d64dff9f7b6d7da3d3a', 3, NULL, NULL, NULL, NULL, 8),
(627, 'Учреждение здравоохранения «Могилевская областная стоматологическая поликлиника»', 'mogoblsp', '20058d55ae9918e64fb4da3d65e29a73', 3, NULL, NULL, NULL, NULL, 8),
(628, 'Учреждение здравоохранения «Могилевская областная детская стоматологическая поликлиника»', 'mogoblsdsp', '00c7db39bd8bafb63d370bf78e09bfba', 3, NULL, NULL, NULL, NULL, 8),
(629, 'Учреждение здравоохранения «Бобруйская городская поликлиника №1»', 'bobrgp1', '4d93e70839f865bc4c18ac783a621eeb', 3, NULL, NULL, NULL, NULL, 8),
(630, 'Учреждение здравоохранения «Бобруйская городская поликлиника №2', 'bobrgp2', '22f73031f59f510fce6993229d817d86', 3, NULL, NULL, NULL, NULL, 8),
(631, 'Учреждение здравоохранения «Бобруйская городская поликлиника №3', 'bobrgp3', '7f8cf8aeeda683814c243b25e27f4486', 3, NULL, NULL, NULL, NULL, 8),
(632, 'Учреждение здравоохранения «Бобруйская городская поликлиника №6', 'bobrgp6', '450c65550fc2c6b1e5b804910a147063', 3, NULL, NULL, NULL, NULL, 8),
(633, 'Учреждение здравоохранения «Бобруйская городская поликлиника №7', 'bobrgp7', 'a30986566aacff0ae57cc656d71ed3c2', 3, NULL, NULL, NULL, NULL, 8),
(634, 'Учреждение здравоохранения «Бобруйская городская детская больница»', 'bobrgdp', '984633ffefc6ecf14b9cd0b98fb500f0', 3, NULL, NULL, NULL, NULL, 8),
(635, 'Учреждение здравоохранения «Бобруйская городская стоматологическая поликлиника №1»', 'bobrgsp1', 'b93f7f83a5eddd2fbbf5e83e98f30130', 3, NULL, NULL, NULL, NULL, 8),
(636, 'Коммунальное унитарное предприятие «Бобруйская лечебно-консультативная поликлиника»', 'bobrlkp', '39b4cac6ba9570cf17b1fed63e434685', 3, NULL, NULL, NULL, NULL, 8),
(637, 'Учреждение здравоохранения «Могилевская областная станция переливания крови»', 'mogoblkrov', 'dc94d21cc6cfa6e5ed7afb288061afe6', 3, NULL, NULL, NULL, NULL, 8),
(638, 'Учреждение здравоохранения «Бобруйская зональная станция переливания крови»', 'bobrzspkrov', '1baae61f5b1dadcbf450b91967f1aaf5', 3, NULL, NULL, NULL, NULL, 8),
(639, 'Кузнец Ольга Михайловна', 'kuznec@rnpcmt.by', 'd961437ba667ed3f97c267110a8cac09', 2, 'rtql1ea3vknlt714p4pmnk42v49c91qr', 'rtql1ea3vknlt714p4pmnk42v49c91qr', '2023-07-21 15:25:51', '/index.php?users', NULL),
(640, 'Федорако Александра Томашевна', 'fedorako@rnpcmt.by', 'd0620ee81008084b956e5fecf8a76e64', 2, NULL, NULL, NULL, NULL, NULL),
(641, 'Войтеховская Анна Александровна', 'voytehovskaya@rnpcmt.by', 'e45666bdf1964b4266a0a2885982f02d', 2, NULL, NULL, NULL, NULL, NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`id_application`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_status` (`id_status`);

--
-- Индексы таблицы `cells`
--
ALTER TABLE `cells`
  ADD PRIMARY KEY (`id_cell`),
  ADD KEY `id_application` (`id_application`),
  ADD KEY `id_column` (`id_column`),
  ADD KEY `id_criteria` (`id_criteria`);

--
-- Индексы таблицы `columns`
--
ALTER TABLE `columns`
  ADD PRIMARY KEY (`id_column`);

--
-- Индексы таблицы `conditions`
--
ALTER TABLE `conditions`
  ADD PRIMARY KEY (`conditions_id`);

--
-- Индексы таблицы `criteria`
--
ALTER TABLE `criteria`
  ADD PRIMARY KEY (`id_criteria`),
  ADD KEY `conditions_id` (`conditions_id`);

--
-- Индексы таблицы `mark`
--
ALTER TABLE `mark`
  ADD PRIMARY KEY (`id_mark`),
  ADD KEY `id_criteria` (`id_criteria`);

--
-- Индексы таблицы `mark_rating`
--
ALTER TABLE `mark_rating`
  ADD PRIMARY KEY (`id_mark_rating`),
  ADD KEY `id_mark` (`id_mark`),
  ADD KEY `id_subvision` (`id_subvision`);

--
-- Индексы таблицы `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id_news`);

--
-- Индексы таблицы `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id_question`),
  ADD KEY `id_user` (`id_user`);

--
-- Индексы таблицы `rating_criteria`
--
ALTER TABLE `rating_criteria`
  ADD PRIMARY KEY (`id_rating_criteria`),
  ADD KEY `id_criteria` (`id_criteria`),
  ADD KEY `id_subvision` (`id_subvision`);

--
-- Индексы таблицы `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_role`);

--
-- Индексы таблицы `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id_status`);

--
-- Индексы таблицы `subvision`
--
ALTER TABLE `subvision`
  ADD PRIMARY KEY (`id_subvision`),
  ADD KEY `id_application` (`id_application`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `id_role` (`id_role`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `applications`
--
ALTER TABLE `applications`
  MODIFY `id_application` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT для таблицы `cells`
--
ALTER TABLE `cells`
  MODIFY `id_cell` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `columns`
--
ALTER TABLE `columns`
  MODIFY `id_column` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `conditions`
--
ALTER TABLE `conditions`
  MODIFY `conditions_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `criteria`
--
ALTER TABLE `criteria`
  MODIFY `id_criteria` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT для таблицы `mark`
--
ALTER TABLE `mark`
  MODIFY `id_mark` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4843;

--
-- AUTO_INCREMENT для таблицы `mark_rating`
--
ALTER TABLE `mark_rating`
  MODIFY `id_mark_rating` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=526;

--
-- AUTO_INCREMENT для таблицы `news`
--
ALTER TABLE `news`
  MODIFY `id_news` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `questions`
--
ALTER TABLE `questions`
  MODIFY `id_question` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `rating_criteria`
--
ALTER TABLE `rating_criteria`
  MODIFY `id_rating_criteria` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=212;

--
-- AUTO_INCREMENT для таблицы `roles`
--
ALTER TABLE `roles`
  MODIFY `id_role` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT для таблицы `status`
--
ALTER TABLE `status`
  MODIFY `id_status` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `subvision`
--
ALTER TABLE `subvision`
  MODIFY `id_subvision` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=642;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `applications`
--
ALTER TABLE `applications`
  ADD CONSTRAINT `applications_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `applications_ibfk_2` FOREIGN KEY (`id_status`) REFERENCES `status` (`id_status`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `cells`
--
ALTER TABLE `cells`
  ADD CONSTRAINT `cells_ibfk_1` FOREIGN KEY (`id_application`) REFERENCES `applications` (`id_application`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cells_ibfk_2` FOREIGN KEY (`id_column`) REFERENCES `columns` (`id_column`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cells_ibfk_3` FOREIGN KEY (`id_criteria`) REFERENCES `criteria` (`id_criteria`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `criteria`
--
ALTER TABLE `criteria`
  ADD CONSTRAINT `criteria_ibfk_1` FOREIGN KEY (`conditions_id`) REFERENCES `conditions` (`conditions_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `mark`
--
ALTER TABLE `mark`
  ADD CONSTRAINT `mark_ibfk_1` FOREIGN KEY (`id_criteria`) REFERENCES `criteria` (`id_criteria`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `mark_rating`
--
ALTER TABLE `mark_rating`
  ADD CONSTRAINT `mark_rating_ibfk_1` FOREIGN KEY (`id_mark`) REFERENCES `mark` (`id_mark`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `mark_rating_ibfk_2` FOREIGN KEY (`id_subvision`) REFERENCES `subvision` (`id_subvision`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `rating_criteria`
--
ALTER TABLE `rating_criteria`
  ADD CONSTRAINT `rating_criteria_ibfk_1` FOREIGN KEY (`id_criteria`) REFERENCES `criteria` (`id_criteria`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `rating_criteria_ibfk_2` FOREIGN KEY (`id_subvision`) REFERENCES `subvision` (`id_subvision`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `subvision`
--
ALTER TABLE `subvision`
  ADD CONSTRAINT `subvision_ibfk_1` FOREIGN KEY (`id_application`) REFERENCES `applications` (`id_application`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id_role`) REFERENCES `roles` (`id_role`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
