-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Июл 24 2023 г., 09:05
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
(42, '36gp', 'Жлобинская ЦРБ', '400080424', 'Республика Беларусь, 247210, Гомельская область, Жлобинский район, г. Жлобин, ул. Воровского, д. 1', '+375 2334 4-25-40', 'zhlcrb@zhlcrb.by', 'Топчий Евгений Николаевич', 'Малиновский Евгений Леонидович', 'Брестский район_26-06-2023_12-16-13.csv', 'download.pdf', 'Справка по работе в РТМС консультирующихся организаций здравоохранения за 2023 год.xlsx', 2, 2, '2023-07-20', '2023-07-19', '2023-07-18', NULL, 'Структура таблиц критериев из приказа.docx', 0);

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
(55, 'Лабораторная диагностика', 3, 2);

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
(1274, 73, '    Удельный вес пациентов онкологического профиля, направленных на медицинскую реабилитацию в стационарных условиях после проведения радикальной операции, составляет 20% и более от числа заболевших - при оказании медицинской помощи пациентам в возрасте 18 лет и старше - для специализированных отделений (отделений) по профилю заболевания (состояния, оказываемой медицинской помощи)', 1, 48, NULL, NULL);

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
(490, 285, 0, '', '', NULL, NULL, 81);

-- --------------------------------------------------------

--
-- Структура таблицы `qwer`
--

CREATE TABLE `qwer` (
  `id` int NOT NULL,
  `name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `qwer` int NOT NULL,
  `asdf` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL
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
(210, 81, 44, 1);

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
(42, 6, 53, 924, 1, 7, 21, 299, 0, 5, 21, 454, 1, 6, 11, 171, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
(42, 81, 44, 2, 1, 43, 0, 0, 0, 18, 0, 6, 1, 18, 0, 0, 0, 7, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
(42, 83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
(82, '456', 42),
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
(1, 'Аккредитация', 'accred@mail.ru', '6534cb7340066e972846eaf508de6224', 2, 'rojctva5r4dfj78c6i3c0988v9mkmk9i', 'rojctva5r4dfj78c6i3c0988v9mkmk9i', '2023-07-21 15:34:07', '/index.php?users', 0),
(2, '36gp', '36gp@mail.ru', 'ba258829bb23dce283867bb2f8b78d7f', 3, '0', 'rojctva5r4dfj78c6i3c0988v9mkmk9i', '2023-07-21 15:33:57', '/index.php?logout', 0),
(3, 'admin', 'hancharou@rnpcmt.by', '2c904ec0191ebc337d56194f6f9a08fa', 1, '0', 'b1su7tp9hk5ivlaokbqekarecglgf3uh', '2023-07-13 14:41:03', '/index.php?logout', 0),
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
-- Индексы таблицы `qwer`
--
ALTER TABLE `qwer`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id_criteria` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT для таблицы `mark`
--
ALTER TABLE `mark`
  MODIFY `id_mark` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1275;

--
-- AUTO_INCREMENT для таблицы `mark_rating`
--
ALTER TABLE `mark_rating`
  MODIFY `id_mark_rating` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=491;

--
-- AUTO_INCREMENT для таблицы `rating_criteria`
--
ALTER TABLE `rating_criteria`
  MODIFY `id_rating_criteria` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=211;

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
