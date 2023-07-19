-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Июл 19 2023 г., 16:52
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
  `fileReport` varchar(555) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fileReportSamoocenka` varchar(555) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `applications`
--

INSERT INTO `applications` (`id_application`, `naim`, `sokr_naim`, `unp`, `ur_adress`, `tel`, `email`, `rukovoditel`, `predstavitel`, `soprovod_pismo`, `copy_rasp`, `org_structure`, `id_user`, `id_status`, `date_send`, `date_accept`, `date_complete`, `fileReport`, `fileReportSamoocenka`) VALUES
(42, '36gp', 'Жлобинская ЦРБ', '400080424', 'Республика Беларусь, 247210, Гомельская область, Жлобинский район, г. Жлобин, ул. Воровского, д. 1', '+375 2334 4-25-40', 'zhlcrb@zhlcrb.by', 'Топчий Евгений Николаевич', 'Малиновский Евгений Леонидович', 'Брестский район_26-06-2023_12-16-13.csv', 'download.pdf', 'Справка по работе в РТМС консультирующихся организаций здравоохранения за 2023 год.xlsx', 2, 2, NULL, '2023-07-19', '2023-07-18', 'Приложение к приказу_Перечень ОЗ_10.07.23.doc', 'Дополнение к ТЗ 18.07.2023_ Кузнец.docx');

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
(3, 'Фельдшерско-акушерский пункт', 1, 1),
(4, 'Врачебная амбулатория общей практики', 1, 1),
(5, 'Городская поликлиника (Районная поликлиника)', 1, 1),
(6, 'Больница сестринского ухода', 1, 2),
(7, 'Участковая больница', 1, 2),
(8, 'Центральная районная больница', 1, 2),
(9, 'Хирургия', 2, 1),
(10, 'Хирургия', 2, 2),
(11, 'Анестезиология и реаниматология', 2, 1),
(12, 'Анестезиология и реаниматология', 2, 2),
(13, 'Акушерство и гинекология', 2, 1),
(14, 'Акушерство и гинекология', 2, 2),
(17, 'Кардиология', 2, 1),
(18, 'Кардиология', 2, 2),
(19, 'Лабораторная диагностика', 3, 1),
(20, 'Лабораторная диагностика', 3, 2),
(21, 'Рентгенодиагностика', 3, 1),
(22, 'Рентгенодиагностика', 3, 2),
(23, 'Компьютерная диагностика', 3, 1),
(24, 'Компьютерная диагностика', 3, 2),
(25, 'Эндокринология', 2, 1),
(26, 'Эндокринология', 2, 2),
(27, 'Гастроэнтерология', 2, 1),
(28, 'Гастроэнтерология', 2, 2),
(29, 'Детская хирургия', 2, 1),
(30, 'Детская хирургия', 2, 2),
(31, 'Неврология', 2, 1),
(32, 'Неврология', 2, 2),
(33, 'Отделение скорой медицинской помощи в структуре ЦРБ', 2, NULL),
(34, 'Пульмонология', 2, 1),
(35, 'Пульмонология', 2, 2),
(36, 'Травматология', 2, 1),
(37, 'Травматология', 2, 2),
(38, 'Центр скорой медицинской помощи', 1, NULL);

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
(83, 1, 'Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 25, NULL, NULL),
(84, 2, 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей. \r\nРезультаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по эндокринологии.\r\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 25, NULL, NULL),
(85, 3, '		Укомплектованность структурного подразделения врачами-эндокринологами не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей врачей-эндокринологов укомплектованность не менее 96 % по занятым должностям', 1, 25, NULL, NULL),
(86, 4, '	Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям ', 1, 25, NULL, NULL),
(87, 5, '		Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего ', 1, 25, NULL, NULL),
(88, 6, '	Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации	', 2, 25, NULL, NULL),
(89, 7, '	Наличие первой, высшей категории у врачей-эндокринологов:\r\nне менее 50% на областном уровне\r\nне менее 80% на республиканском уровне	', 3, 25, NULL, NULL),
(90, 8, '	Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев. \r\nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 25, NULL, NULL),
(91, 9, '	Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков. \r\nМедицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи ', 3, 25, NULL, NULL),
(92, 10, '	Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой ', 2, 25, NULL, NULL),
(93, 11, '	Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 25, NULL, NULL),
(94, 12, '	В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники.  \r\nПроведение обучения документируется', 3, 25, NULL, NULL),
(95, 13, '	Порядок оказания медицинской помощи в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь.\r\nСоблюдается порядок (алгоритмы) оказания срочной и плановой медицинской помощи при эндокринной патологии', 2, 25, NULL, NULL),
(96, 14, '	Работа структурного подразделения обеспечена в сменном режиме', 2, 25, NULL, NULL),
(97, 15, '	Определен порядок оказания медицинской помощи пациентам с эндокринными заболеваниями на период отсутствия в организации здравоохранения врача-специалиста (районный, городской уровень)', 1, 25, NULL, NULL),
(98, 16, '	Соблюдается порядок медицинского наблюдения пациентов с эндокринными заболеваниями в амбулаторных условиях. Руководителем структурного подразделения осуществляется анализ результатов медицинского наблюдения пациентов', 1, 25, NULL, NULL),
(99, 17, '	Обеспечена преемственность с больничными организациями здравоохранения. Определен порядок направления на плановую и экстренную госпитализацию пациентов эндокринологического профиля.  Обеспечено выполнение на амбулаторном этапе рекомендаций по дальнейшему медицинскому наблюдению после выписки', 2, 25, NULL, NULL),
(100, 18, '	Обязательная выдача консультативных заключений консультации пациентов на областном, республиканском уровнях\r\nПередача заключений республиканских, областных врачебных консилиумов в территориальные организации здравоохранения', 2, 25, NULL, NULL),
(101, 19, '	Обеспечена возможность консультаций врачей-специалистов в соответствии с клиническими протоколами диагностики и лечения (в организации здравоохранения или определён порядок направления в другие организации здравоохранения)', 1, 25, NULL, NULL),
(102, 20, '	Оформление медицинской карты амбулаторного больного соответствует установленной форме', 3, 25, NULL, NULL),
(103, 21, '	В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 25, NULL, NULL),
(104, 22, '	Осуществляется выписка электронных рецептов на лекарственные средства', 2, 25, NULL, NULL),
(105, 23, '	Для врачей-специалистов структурного подразделения обеспечена доступность проведения телемедицинского консультирования, результаты которого документируется \r\nи находится в медицинской карте ', 2, 25, NULL, NULL),
(106, 24, '	Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»	', 3, 25, NULL, NULL),
(107, 25, '	Обеспечено выполнение функции врачебной должности не менее 90%', 2, 25, NULL, NULL),
(108, 26, '	Ежегодное обновление сведений в республиканском регистре «Сахарный диабет» о пациентах с сахарным диабетом, состоящих под медицинским наблюдением в организации здравоохранения с ежеквартальной передачей на областной уровень (районный/ городской уровень)', 3, 25, NULL, NULL),
(109, 27, '	Свод и анализ информации республиканского регистра «Сахарный диабет» с ежеквартальной передачей данных на республиканский уровень (областной уровень)', 3, 25, NULL, NULL),
(110, 28, '	Свод и анализ качества ведения республиканского регистра «Сахарный диабет» (республиканский уровень)', 3, 25, NULL, NULL),
(111, 29, '	Сформирована, укомплектована и доступна укладка «Комы при сахарном диабете» (районный/городской, межрайонный, областной, республиканский уровень)', 1, 25, NULL, NULL),
(112, 30, '	Организован и функционирует кабинет «Диабетическая стопа» (межрайонный, областной уровень)', 1, 25, NULL, NULL),
(113, 31, '	Укомплектованность медицинскими работниками, оснащенность кабинета «Диабетическая стопа» соответствует нормативным документам (межрайонный, областной уровень)	', 3, 25, NULL, NULL),
(114, 32, '	Уровень высоких ампутаций составляет не выше 0,05 (межрайонный, областной уровень)', 3, 25, NULL, NULL),
(115, 33, '	Удельный вес посещений пациентов – жителей районного/городского уровня среди консультативных посещений врачей-эндокринологов областного уровня – не менее 50%', 2, 25, NULL, NULL),
(116, 34, '	Удельный вес посещений пациентов – жителей регионов (кроме г. Минска) среди консультативных посещений врачей-эндокринологов республиканского уровня – не менее 65%', 2, 25, NULL, NULL),
(117, 35, '	Организовано проведение консультаций профессорско-преподавательского состава кафедр эндокринологии, акушерства и гинекологии, хирургии, неврологии и нейрохирургии УО «БГМУ», ГУО «БелМАПО» (республиканский уровень)', 2, 25, NULL, NULL),
(118, 36, '	Организовано проведение Республиканских консилиумов по назначению препаратов соматропина, гонадотропин-рилизинг гормона, аналогов соматостатина, аналогов инсулина у взрослых (республиканский уровень)', 1, 25, NULL, NULL),
(119, 37, '	Организовано взаимодействие с организациями здравоохранения, осуществляющими хирургическое лечение пациентов с заболеваниями эндокринной системы (ГУ «РНПЦ неврологии и нейрохирургии»; Республиканский центр опухолей щитовидной железы, ГУ «РНПЦ онкологии и медицинской радиологии им.Н.Н.Александрова»; ГУ «РНПЦ радиационной медицины и экологии человека») (республиканский уровень)', 2, 25, NULL, NULL),
(120, 38, '	Организован отбор пациентов для проведения радиойодтерапии (республиканский уровень)', 2, 25, NULL, NULL),
(121, 39, '	Удельный вес посещений пациентов с «редкой» эндокринной патологией среди посещений врачей-эндокринологов – не менее 50% (республиканский уровень)', 2, 25, NULL, NULL),
(122, 40, '	Участие работников организации в обучении слушателей циклов повышения квалификации по эндокринологии, ультразвуковой диагностике в эндокринологии, организованных УО «БГМУ», ГУО «БелМАПО» (республиканский уровень)', 3, 25, NULL, NULL),
(123, 41, '	Организация и проведение научно-практических конференций по актуальным вопросам диагностики и лечения заболеваний эндокринной системы (республиканский уровень)', 2, 25, NULL, NULL),
(124, 42, '	Организация и проведение круглых столов, мастер-классов по актуальным вопросам диагностики и лечения заболеваний эндокринной системы (республиканский уровень)', 2, 25, NULL, NULL),
(125, 43, '	Разработка нормативных документов по улучшению организации эндокринологической службы республики (республиканский уровень)', 2, 25, NULL, NULL),
(126, 44, '	Организована возможность проведения исследования гликированного гемоглобина для пациентов с сахарным диабетом в соответствии с клиническими протоколами диагностики и лечения (районный/городской, областной, республиканский уровень)', 1, 25, NULL, NULL),
(127, 45, '	Организована возможность проведения лабораторного исследования тироидных гормонов в соответствии с клиническими протоколами диагностики и лечения (районный/городской, областной, республиканский уровень)', 1, 25, NULL, NULL),
(128, 46, '	Организована возможность проведения лабораторного исследования половых гормонов в соответствии с клиническими протоколами диагностики и лечения (областной, республиканский уровень) ', 1, 25, NULL, NULL),
(129, 47, '	Организована возможность проведения лабораторного исследования редких гормонов в соответствии с клиническими протоколами диагностики и лечения (республиканский уровень)', 1, 25, NULL, NULL),
(130, 48, '	Организована возможность проведения инструментальных исследований в соответствии с клиническими протоколами диагностики и лечения (в организации здравоохранения или определён порядок направления в другие организации здравоохранения) (районный/городской, областной, республиканский уровень)', 1, 25, NULL, NULL),
(131, 49, '	Организовано проведение тонкоигольной пункционной аспирационной биопсии щитовидной железы (областной, республиканский уровень)', 1, 25, NULL, NULL),
(132, 50, '	Организовано проведение постоянного мониторирования гликемии (республиканский уровень)', 3, 25, NULL, NULL),
(133, 51, '	Выписка лекарственных препаратов на льготной/бесплатной основе в соответствии с перечнем основных лекарственных средств, Республиканским формуляром лекарственных средств (районный/городской, областной уровень)', 3, 25, NULL, NULL),
(134, 52, '	Врач-эндокринолог проводит лечение пациентов с эндокринными заболеваниями в соответствии с клиническими протоколами диагностики и лечения (районный/городской, областной, республиканский уровень)	', 1, 25, NULL, NULL),
(135, 53, '	Организован кабинет помповой инсулинотерапии (республиканский уровень)', 3, 25, NULL, NULL),
(136, 54, '	Организовано внедрение современных технологий в ведении пациентов с заболеваниями эндокринной системы (областной, республиканский уровень)', 2, 25, NULL, NULL),
(137, 55, '	Организована работа «Школы сахарного диабета» (районный/городской, областной, республиканский уровень)	', 2, 25, NULL, NULL),
(138, 56, '	Осуществляется формирование заявки на годовую закупку лекарственных средств инсулина (областной, республиканский уровень)', 2, 25, NULL, NULL),
(139, 57, '	Осуществляется контроль обоснованности назначения аналогов инсулина и расходования препаратов инсулина при лекарственном обеспечении пациентов с сахарным диабетом (районный/городской межрайонный, областной, республиканский уровень)', 2, 25, NULL, NULL),
(140, 58, '	Осуществляется обеспечение медицинскими изделиями (тест-полоски, глюкометр, иглы для шприц-ручек) пациентов с сахарным диабетом, состоящих под медицинским наблюдением в организации здравоохранения (районный/городской, областной, республиканский уровень)', 2, 25, NULL, NULL);

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
(1, 83, 1, '', 'екг', 2, '12', 63),
(2, 84, 2, '', 'qwwwww', 2, '', 63),
(3, 85, 1, '', '', 0, '', 63),
(4, 86, 1, '', '', 1, '', 63),
(5, 87, 0, '', '', 0, '', 63),
(6, 88, 0, '', '', 0, '', 63),
(7, 89, 0, '', '', 0, '', 63),
(8, 90, 0, '', '', 0, '', 63),
(9, 91, 0, '', '', 0, '', 63),
(10, 92, 0, '', '', 0, '', 63),
(11, 93, 0, '', '', 0, '', 63),
(12, 94, 0, '', '', 0, '', 63),
(13, 95, 0, '', '', 0, '', 63),
(14, 96, 0, '', '', 0, '', 63),
(15, 97, 0, '', '', 0, '', 63),
(16, 98, 0, '', '', 0, '', 63),
(17, 99, 0, '', '', 0, '', 63),
(18, 100, 0, '', '', 0, '', 63),
(19, 101, 0, '', '', 0, '', 63),
(20, 102, 0, '', '', 0, '', 63),
(21, 103, 0, '', '', 0, '', 63),
(22, 104, 0, '', '', 0, '', 63),
(23, 105, 0, '', '', 0, '', 63),
(24, 106, 0, '', '', 0, '', 63),
(25, 107, 0, '', '', 0, '', 63),
(26, 108, 0, '', '', 0, '', 63),
(27, 109, 0, '', '', 0, '', 63),
(28, 110, 0, '', '', 0, '', 63),
(29, 111, 0, '', '', 0, '', 63),
(30, 112, 0, '', '', 0, '', 63),
(31, 113, 0, '', '', 0, '', 63),
(32, 114, 0, '', '', 0, '', 63),
(33, 115, 0, '', '', 0, '', 63),
(34, 116, 0, '', '', 0, '', 63),
(35, 117, 0, '', '', 0, '', 63),
(36, 118, 0, '', '', 0, '', 63),
(37, 119, 0, '', '', 0, '', 63),
(38, 120, 0, '', '', 0, '', 63),
(39, 121, 0, '', '', 0, '', 63),
(40, 122, 0, '', '', 0, '', 63),
(41, 123, 0, '', '', 0, '', 63),
(42, 124, 0, '', '', 0, '', 63),
(43, 125, 0, '', '', 0, '', 63),
(44, 126, 0, '', '', 0, '', 63),
(45, 127, 0, '', '', 0, '', 63),
(46, 128, 0, '', '', 0, '', 63),
(47, 129, 0, '', '', 0, '', 63),
(48, 130, 0, '', '', 0, '', 63),
(49, 131, 0, '', '', 0, '', 63),
(50, 132, 0, '', '', 0, '', 63),
(51, 133, 0, '', '', 0, '', 63),
(52, 134, 0, '', '', 0, '', 63),
(53, 135, 0, '', '', 0, '', 63),
(54, 136, 0, '', '', 0, '', 63),
(55, 137, 0, '', '', 0, '', 63),
(56, 138, 0, '', '', 0, '', 63),
(57, 139, 0, '', '', 0, '', 63),
(58, 140, 0, '', '', 0, '', 63),
(59, 83, 2, '', 'sdasd', 0, '', 81),
(60, 84, 1, '', 'azxx', 0, '', 81),
(61, 85, 1, '', '', 0, '', 81),
(62, 86, 0, '', '', 2, '', 81),
(63, 87, 0, '', '', 2, '', 81),
(64, 88, 0, '', '', 0, '', 81),
(65, 89, 0, '', '', 0, '', 81),
(66, 90, 0, '', '', 0, '', 81),
(67, 91, 0, '', '', 0, '', 81),
(68, 92, 0, '', '', 0, '', 81),
(69, 93, 0, '', '', 0, '', 81),
(70, 94, 0, '', '', 0, '', 81),
(71, 95, 0, '', '', 0, '', 81),
(72, 96, 0, '', '', 0, '', 81),
(73, 97, 0, '', '', 0, '', 81),
(74, 98, 0, '', '', 0, '', 81),
(75, 99, 0, '', '', 0, '', 81),
(76, 100, 0, '', '', 0, '', 81),
(77, 101, 0, '', '', 0, '', 81),
(78, 102, 0, '', '', 0, '', 81),
(79, 103, 0, '', '', 0, '', 81),
(80, 104, 0, '', '', 0, '', 81),
(81, 105, 0, '', '', 0, '', 81),
(82, 106, 0, '', '', 0, '', 81),
(83, 107, 0, '', '', 0, '', 81),
(84, 108, 0, '', '', 0, '', 81),
(85, 109, 0, '', '', 0, '', 81),
(86, 110, 0, '', '', 0, '', 81),
(87, 111, 0, '', '', 0, '', 81),
(88, 112, 0, '', '', 0, '', 81),
(89, 113, 0, '', '', 0, '', 81),
(90, 114, 0, '', '', 0, '', 81),
(91, 115, 0, '', '', 0, '', 81),
(92, 116, 0, '', '', 0, '', 81),
(93, 117, 0, '', '', 0, '', 81),
(94, 118, 0, '', '', 0, '', 81),
(95, 119, 0, '', '', 0, '', 81),
(96, 120, 0, '', '', 0, '', 81),
(97, 121, 0, '', '', 0, '', 81),
(98, 122, 0, '', '', 0, '', 81),
(99, 123, 0, '', '', 0, '', 81),
(100, 124, 0, '', '', 0, '', 81),
(101, 125, 0, '', '', 0, '', 81),
(102, 126, 0, '', '', 0, '', 81),
(103, 127, 0, '', '', 0, '', 81),
(104, 128, 0, '', '', 0, '', 81),
(105, 129, 0, '', '', 0, '', 81),
(106, 130, 0, '', '', 0, '', 81),
(107, 131, 0, '', '', 0, '', 81),
(108, 132, 0, '', '', 0, '', 81),
(109, 133, 0, '', '', 0, '', 81),
(110, 134, 0, '', '', 0, '', 81),
(111, 135, 0, '', '', 0, '', 81),
(112, 136, 0, '', '', 0, '', 81),
(113, 137, 0, '', '', 0, '', 81),
(114, 138, 0, '', '', 0, '', 81),
(115, 139, 0, '', '', 0, '', 81),
(116, 140, 0, '', '', 0, '', 81);

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
(162, 81, 3, 1),
(163, 81, 25, 1),
(164, 63, 25, 1),
(165, 63, 26, 1);

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
(42, 4, 5, 116, 0, 9, 3, 34, 0, 4, 2, 52, 0, 0, 0, 30, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
(42, 63, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 81, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 81, 25, 3, 2, 58, 0, 6, 1, 17, 0, 4, 1, 26, 0, 0, 0, 15, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 63, 25, 5, 3, 58, 0, 12, 2, 17, 0, 0, 0, 26, 0, 7, 1, 15, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
(42, 63, 5, 3, 58, 0, 12, 2, 17, 0, 4, 1, 26, 0, 0, 0, 15, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 81, 3, 2, 58, 0, 6, 1, 17, 0, 4, 1, 26, 0, 0, 0, 15, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
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
(1, 'Аккредитация', 'accred@mail.ru', '6534cb7340066e972846eaf508de6224', 2, '0', 'q6rd6e9bjh25s8qp5fm5pj2g84dno2ed', '2023-07-19 15:54:13', '/index.php?logout', 0),
(2, '36gp', '36gp@mail.ru', 'ba258829bb23dce283867bb2f8b78d7f', 3, 'q6rd6e9bjh25s8qp5fm5pj2g84dno2ed', 'q6rd6e9bjh25s8qp5fm5pj2g84dno2ed', '2023-07-19 15:54:19', '/index.php?application', 0),
(3, 'admin', 'hancharou@rnpcmt.by', '2c904ec0191ebc337d56194f6f9a08fa', 1, '0', 'b1su7tp9hk5ivlaokbqekarecglgf3uh', '2023-07-13 14:41:03', '/index.php?logout', 0),
(184, 'Государственное учреждение «Университетская стоматологическая клиника»', 'univDendClinic', '11023f1e51b80bc349f9c19f056bcedf', 3, NULL, NULL, NULL, NULL, 4),
(185, 'Государственное учреждение «Республиканский центр медицинской реабилитации и бальнеолечения»', 'republicCentermedrb', '8a7199d2b7e7c86b0bc46f16f666f1e8', 3, NULL, NULL, NULL, NULL, 4),
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
(487, 'Учреждение здравоохранения «28-я городская поликлиника»', 'minskgp28', 'f1b4e9923aa44dc9130e8c79b1d9fd2a', 3, NULL, NULL, NULL, NULL, 5);

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
  MODIFY `id_application` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

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
  MODIFY `id_criteria` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT для таблицы `mark`
--
ALTER TABLE `mark`
  MODIFY `id_mark` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

--
-- AUTO_INCREMENT для таблицы `mark_rating`
--
ALTER TABLE `mark_rating`
  MODIFY `id_mark_rating` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT для таблицы `rating_criteria`
--
ALTER TABLE `rating_criteria`
  MODIFY `id_rating_criteria` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=175;

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
  MODIFY `id_subvision` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=488;

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
