-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Июл 14 2023 г., 16:44
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
  `date_send` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `applications`
--

INSERT INTO `applications` (`id_application`, `naim`, `sokr_naim`, `unp`, `ur_adress`, `tel`, `email`, `rukovoditel`, `predstavitel`, `soprovod_pismo`, `copy_rasp`, `org_structure`, `id_user`, `id_status`, `date_send`) VALUES
(39, 'Могилёвская центральная поликлиника', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 153, 1, NULL),
(42, '36gp', 'Жлобинская ЦРБ', '400080424', 'Республика Беларусь, 247210, Гомельская область, Жлобинский район, г. Жлобин, ул. Воровского, д. 1', '+375 2334 4-25-40', 'zhlcrb@zhlcrb.by', 'Топчий Евгений Николаевич', 'Малиновский Евгений Леонидович', 'download.pdf', 'Как авторизоваться на FORMED.docx', 'qwe.xls', 2, 1, '2023-07-14');

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
  `str_num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
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
(83, '1', 'Деятельность структурного подразделения осуществляется в соответствии с Положением о структурном подразделении. Сотрудники структурного подразделения ознакомлены с Положением о структурном подразделении', 3, 25, NULL, NULL),
(84, '2', 'Руководителем структурного подразделения ежеквартально анализируются основные показатели деятельности структурного подразделения, выполнение утвержденных плановых показателей. \r\nРезультаты анализа документируются, предоставляются лицу, ответственному за организацию помощи по эндокринологии.\r\nРезультаты анализа работы структурного подразделения используются для проведения мероприятий по улучшению его деятельности, что подтверждается приказами и распоряжениями по учреждению, решениями медицинского совета', 2, 25, NULL, NULL),
(85, '3', '		Укомплектованность структурного подразделения врачами-эндокринологами не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей врачей-эндокринологов укомплектованность не менее 96 % по занятым должностям', 1, 25, NULL, NULL),
(86, '4	', '	Укомплектованность структурного подразделения медицинскими работниками, имеющими среднее специальное медицинское образование, не менее 75% по физическим лицам. При наличии в штатном расписании неполных должностей среднего медицинского персонала укомплектованность не менее 96 % по занятым должностям ', 1, 25, NULL, NULL),
(87, '5	', '		Квалификация медицинских работников структурного подразделения соответствует требованиям законодательных актов и должностной инструкции к занимаемой должности служащего ', 1, 25, NULL, NULL),
(88, '6	', '	Наличие квалификационных категорий у врачей-специалистов, специалистов со средним медицинским образованием структурного подразделения 100 % от лиц, подлежащих профессиональной аттестации	', 2, 25, NULL, NULL),
(89, '7	', '	Наличие первой, высшей категории у врачей-эндокринологов:\r\nне менее 50% на областном уровне\r\nне менее 80% на республиканском уровне	', 3, 25, NULL, NULL),
(90, '8	', '	Медицинские работники структурного подразделения проходят обучение и контроль знаний и навыков по оказанию экстренной и неотложной медицинской помощи с частотой, определяемой руководителем организации, но не реже одного раза в 6 месяцев. \r\nМедицинские работники могут продемонстрировать соответствующие навыки при проведении реанимационных мероприятий', 1, 25, NULL, NULL),
(91, '9	', '	Медицинские работники структурного подразделения на регулярной основе (в соответствии с планом) проходят обучение, направленное на поддержание и актуализацию профессиональных знаний и практических навыков. \r\nМедицинские работники структурного подразделения имеют постоянный доступ к базам (справочникам) клинических протоколов диагностики и лечения, других нормативно-правовых актов по организации медицинской помощи ', 3, 25, NULL, NULL),
(92, '10	', '	Оснащение структурного подразделения соответствует утвержденному табелю оснащения изделиями медицинского назначения и медицинской техникой ', 2, 25, NULL, NULL),
(93, '11	', '	Медицинская техника, находящаяся в эксплуатации в структурном подразделении, обеспечена техническим обслуживанием и ремонтом. Техническое обслуживание и ремонт медицинской техники документируются в структурном подразделении. Заключены договоры на техническое обслуживание', 2, 25, NULL, NULL),
(94, '12	', '	В структурном подразделении организовано обучение медицинских работников правилам эксплуатации медицинской техники.  \r\nПроведение обучения документируется', 3, 25, NULL, NULL),
(95, '13	', '	Порядок оказания медицинской помощи в структурном подразделении утвержден локальным правовым актом в соответствии с утвержденными порядками оказания медицинской помощи и клиническими протоколами, законодательством Республики Беларусь.\r\nСоблюдается порядок (алгоритмы) оказания срочной и плановой медицинской помощи при эндокринной патологии', 2, 25, NULL, NULL),
(96, '14	', '	Работа структурного подразделения обеспечена в сменном режиме', 2, 25, NULL, NULL),
(97, '15	', '	Определен порядок оказания медицинской помощи пациентам с эндокринными заболеваниями на период отсутствия в организации здравоохранения врача-специалиста (районный, городской уровень)', 1, 25, NULL, NULL),
(98, '16	', '	Соблюдается порядок медицинского наблюдения пациентов с эндокринными заболеваниями в амбулаторных условиях. Руководителем структурного подразделения осуществляется анализ результатов медицинского наблюдения пациентов', 1, 25, NULL, NULL),
(99, '17	', '	Обеспечена преемственность с больничными организациями здравоохранения. Определен порядок направления на плановую и экстренную госпитализацию пациентов эндокринологического профиля.  Обеспечено выполнение на амбулаторном этапе рекомендаций по дальнейшему медицинскому наблюдению после выписки', 2, 25, NULL, NULL),
(100, '18	', '	Обязательная выдача консультативных заключений консультации пациентов на областном, республиканском уровнях\r\nПередача заключений республиканских, областных врачебных консилиумов в территориальные организации здравоохранения', 2, 25, NULL, NULL),
(101, '19	', '	Обеспечена возможность консультаций врачей-специалистов в соответствии с клиническими протоколами диагностики и лечения (в организации здравоохранения или определён порядок направления в другие организации здравоохранения)', 1, 25, NULL, NULL),
(102, '20	', '	Оформление медицинской карты амбулаторного больного соответствует установленной форме', 3, 25, NULL, NULL),
(103, '21	', '	В структурном подразделении имеются условия для формирования и ведения электронных медицинских документов. Медицинские работники владеют навыками работы в медицинской информационной системе', 2, 25, NULL, NULL),
(104, '22	', '	Осуществляется выписка электронных рецептов на лекарственные средства', 2, 25, NULL, NULL),
(105, '23	', '	Для врачей-специалистов структурного подразделения обеспечена доступность проведения телемедицинского консультирования, результаты которого документируется \r\nи находится в медицинской карте ', 2, 25, NULL, NULL),
(106, '24	', '	Руководителем структурного подразделения проводится оценка качества медицинской помощи в случаях, определенных постановлением Министерства здравоохранения Республики Беларусь от 21 мая 2021 г. № 55 «Об оценке качества медицинской помощи и медицинских экспертиз, экспертизе качества медицинской помощи»	', 3, 25, NULL, NULL),
(107, '25	', '	Обеспечено выполнение функции врачебной должности не менее 90%', 2, 25, NULL, NULL),
(108, '26	', '	Ежегодное обновление сведений в республиканском регистре «Сахарный диабет» о пациентах с сахарным диабетом, состоящих под медицинским наблюдением в организации здравоохранения с ежеквартальной передачей на областной уровень (районный/ городской уровень)', 3, 25, NULL, NULL),
(109, '27	', '	Свод и анализ информации республиканского регистра «Сахарный диабет» с ежеквартальной передачей данных на республиканский уровень (областной уровень)', 3, 25, NULL, NULL),
(110, '28	', '	Свод и анализ качества ведения республиканского регистра «Сахарный диабет» (республиканский уровень)', 3, 25, NULL, NULL),
(111, '29	', '	Сформирована, укомплектована и доступна укладка «Комы при сахарном диабете» (районный/городской, межрайонный, областной, республиканский уровень)', 1, 25, NULL, NULL),
(112, '30	', '	Организован и функционирует кабинет «Диабетическая стопа» (межрайонный, областной уровень)', 1, 25, NULL, NULL),
(113, '31	', '	Укомплектованность медицинскими работниками, оснащенность кабинета «Диабетическая стопа» соответствует нормативным документам (межрайонный, областной уровень)	', 3, 25, NULL, NULL),
(114, '32	', '	Уровень высоких ампутаций составляет не выше 0,05 (межрайонный, областной уровень)', 3, 25, NULL, NULL),
(115, '33	', '	Удельный вес посещений пациентов – жителей районного/городского уровня среди консультативных посещений врачей-эндокринологов областного уровня – не менее 50%', 2, 25, NULL, NULL),
(116, '34	', '	Удельный вес посещений пациентов – жителей регионов (кроме г. Минска) среди консультативных посещений врачей-эндокринологов республиканского уровня – не менее 65%', 2, 25, NULL, NULL),
(117, '35	', '	Организовано проведение консультаций профессорско-преподавательского состава кафедр эндокринологии, акушерства и гинекологии, хирургии, неврологии и нейрохирургии УО «БГМУ», ГУО «БелМАПО» (республиканский уровень)', 2, 25, NULL, NULL),
(118, '36	', '	Организовано проведение Республиканских консилиумов по назначению препаратов соматропина, гонадотропин-рилизинг гормона, аналогов соматостатина, аналогов инсулина у взрослых (республиканский уровень)', 1, 25, NULL, NULL),
(119, '37	', '	Организовано взаимодействие с организациями здравоохранения, осуществляющими хирургическое лечение пациентов с заболеваниями эндокринной системы (ГУ «РНПЦ неврологии и нейрохирургии»; Республиканский центр опухолей щитовидной железы, ГУ «РНПЦ онкологии и медицинской радиологии им.Н.Н.Александрова»; ГУ «РНПЦ радиационной медицины и экологии человека») (республиканский уровень)', 2, 25, NULL, NULL),
(120, '38	', '	Организован отбор пациентов для проведения радиойодтерапии (республиканский уровень)', 2, 25, NULL, NULL),
(121, '39	', '	Удельный вес посещений пациентов с «редкой» эндокринной патологией среди посещений врачей-эндокринологов – не менее 50% (республиканский уровень)', 2, 25, NULL, NULL),
(122, '40	', '	Участие работников организации в обучении слушателей циклов повышения квалификации по эндокринологии, ультразвуковой диагностике в эндокринологии, организованных УО «БГМУ», ГУО «БелМАПО» (республиканский уровень)', 3, 25, NULL, NULL),
(123, '41	', '	Организация и проведение научно-практических конференций по актуальным вопросам диагностики и лечения заболеваний эндокринной системы (республиканский уровень)', 2, 25, NULL, NULL),
(124, '42	', '	Организация и проведение круглых столов, мастер-классов по актуальным вопросам диагностики и лечения заболеваний эндокринной системы (республиканский уровень)', 2, 25, NULL, NULL),
(125, '43	', '	Разработка нормативных документов по улучшению организации эндокринологической службы республики (республиканский уровень)', 2, 25, NULL, NULL),
(126, '44	', '	Организована возможность проведения исследования гликированного гемоглобина для пациентов с сахарным диабетом в соответствии с клиническими протоколами диагностики и лечения (районный/городской, областной, республиканский уровень)', 1, 25, NULL, NULL),
(127, '45	', '	Организована возможность проведения лабораторного исследования тироидных гормонов в соответствии с клиническими протоколами диагностики и лечения (районный/городской, областной, республиканский уровень)', 1, 25, NULL, NULL),
(128, '46	', '	Организована возможность проведения лабораторного исследования половых гормонов в соответствии с клиническими протоколами диагностики и лечения (областной, республиканский уровень) ', 1, 25, NULL, NULL),
(129, '47	', '	Организована возможность проведения лабораторного исследования редких гормонов в соответствии с клиническими протоколами диагностики и лечения (республиканский уровень)', 1, 25, NULL, NULL),
(130, '48	', '	Организована возможность проведения инструментальных исследований в соответствии с клиническими протоколами диагностики и лечения (в организации здравоохранения или определён порядок направления в другие организации здравоохранения) (районный/городской, областной, республиканский уровень)', 1, 25, NULL, NULL),
(131, '49	', '	Организовано проведение тонкоигольной пункционной аспирационной биопсии щитовидной железы (областной, республиканский уровень)', 1, 25, NULL, NULL),
(132, '50	', '	Организовано проведение постоянного мониторирования гликемии (республиканский уровень)', 3, 25, NULL, NULL),
(133, '51	', '	Выписка лекарственных препаратов на льготной/бесплатной основе в соответствии с перечнем основных лекарственных средств, Республиканским формуляром лекарственных средств (районный/городской, областной уровень)', 3, 25, NULL, NULL),
(134, '52	', '	Врач-эндокринолог проводит лечение пациентов с эндокринными заболеваниями в соответствии с клиническими протоколами диагностики и лечения (районный/городской, областной, республиканский уровень)	', 1, 25, NULL, NULL),
(135, '53	', '	Организован кабинет помповой инсулинотерапии (республиканский уровень)', 3, 25, NULL, NULL),
(136, '54	', '	Организовано внедрение современных технологий в ведении пациентов с заболеваниями эндокринной системы (областной, республиканский уровень)', 2, 25, NULL, NULL),
(137, '55	', '	Организована работа «Школы сахарного диабета» (районный/городской, областной, республиканский уровень)	', 2, 25, NULL, NULL),
(138, '56	', '	Осуществляется формирование заявки на годовую закупку лекарственных средств инсулина (областной, республиканский уровень)', 2, 25, NULL, NULL),
(139, '57	', '	Осуществляется контроль обоснованности назначения аналогов инсулина и расходования препаратов инсулина при лекарственном обеспечении пациентов с сахарным диабетом (районный/городской межрайонный, областной, республиканский уровень)', 2, 25, NULL, NULL),
(140, '58	', '	Осуществляется обеспечение медицинскими изделиями (тест-полоски, глюкометр, иглы для шприц-ручек) пациентов с сахарным диабетом, состоящих под медицинским наблюдением в организации здравоохранения (районный/городской, областной, республиканский уровень)', 2, 25, NULL, NULL);

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
(1, 83, 0, '', '', NULL, NULL, 63),
(2, 84, 0, '', '', NULL, NULL, 63),
(3, 85, 0, '', '', NULL, NULL, 63),
(4, 86, 0, '', '', NULL, NULL, 63),
(5, 87, 0, '', '', NULL, NULL, 63),
(6, 88, 0, '', '', NULL, NULL, 63),
(7, 89, 0, '', '', NULL, NULL, 63),
(8, 90, 0, '', '', NULL, NULL, 63),
(9, 91, 0, '', '', NULL, NULL, 63),
(10, 92, 0, '', '', NULL, NULL, 63),
(11, 93, 0, '', '', NULL, NULL, 63),
(12, 94, 0, '', '', NULL, NULL, 63),
(13, 95, 0, '', '', NULL, NULL, 63),
(14, 96, 0, '', '', NULL, NULL, 63),
(15, 97, 0, '', '', NULL, NULL, 63),
(16, 98, 0, '', '', NULL, NULL, 63),
(17, 99, 0, '', '', NULL, NULL, 63),
(18, 100, 0, '', '', NULL, NULL, 63),
(19, 101, 0, '', '', NULL, NULL, 63),
(20, 102, 0, '', '', NULL, NULL, 63),
(21, 103, 0, '', '', NULL, NULL, 63),
(22, 104, 0, '', '', NULL, NULL, 63),
(23, 105, 0, '', '', NULL, NULL, 63),
(24, 106, 0, '', '', NULL, NULL, 63),
(25, 107, 0, '', '', NULL, NULL, 63),
(26, 108, 0, '', '', NULL, NULL, 63),
(27, 109, 0, '', '', NULL, NULL, 63),
(28, 110, 0, '', '', NULL, NULL, 63),
(29, 111, 0, '', '', NULL, NULL, 63),
(30, 112, 0, '', '', NULL, NULL, 63),
(31, 113, 0, '', '', NULL, NULL, 63),
(32, 114, 0, '', '', NULL, NULL, 63),
(33, 115, 0, '', '', NULL, NULL, 63),
(34, 116, 0, '', '', NULL, NULL, 63),
(35, 117, 0, '', '', NULL, NULL, 63),
(36, 118, 0, '', '', NULL, NULL, 63),
(37, 119, 0, '', '', NULL, NULL, 63),
(38, 120, 0, '', '', NULL, NULL, 63),
(39, 121, 0, '', '', NULL, NULL, 63),
(40, 122, 0, '', '', NULL, NULL, 63),
(41, 123, 0, '', '', NULL, NULL, 63),
(42, 124, 0, '', '', NULL, NULL, 63),
(43, 125, 0, '', '', NULL, NULL, 63),
(44, 126, 0, '', '', NULL, NULL, 63),
(45, 127, 0, '', '', NULL, NULL, 63),
(46, 128, 0, '', '', NULL, NULL, 63),
(47, 129, 0, '', '', NULL, NULL, 63),
(48, 130, 0, '', '', NULL, NULL, 63),
(49, 131, 0, '', '', NULL, NULL, 63),
(50, 132, 0, '', '', NULL, NULL, 63),
(51, 133, 0, '', '', NULL, NULL, 63),
(52, 134, 0, '', '', NULL, NULL, 63),
(53, 135, 0, '', '', NULL, NULL, 63),
(54, 136, 0, '', '', NULL, NULL, 63),
(55, 137, 0, '', '', NULL, NULL, 63),
(56, 138, 0, '', '', NULL, NULL, 63),
(57, 139, 0, '', '', NULL, NULL, 63),
(58, 140, 1, '', '', NULL, NULL, 63);

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
(132, 57, 4, 1),
(133, 57, 25, 1),
(154, 63, 25, 1),
(155, 63, 26, 1),
(156, 63, 27, 1);

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
(42, 3, 2, 58, 0, 6, 1, 17, 0, 0, 0, 26, 0, 7, 1, 15, 0, 2, 1, 58, 0, 0, 0, 17, 0, 0, 0, 26, 0, 7, 1, 15, 0, 2, 1, 58, 0);

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
(42, 63, 25, 3, 2, 58, 0, 6, 1, 17, 0, 0, 0, 26, 0, 7, 1, 15, 0, 2, 1, 58, 0, 0, 0, 17, 0, 0, 0, 26, 0, 7, 1, 15, 0, 2, 1, 58, 0),
(42, 63, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(42, 63, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

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
(42, 63, 3, 2, 58, 0, 6, 1, 17, 0, 0, 0, 26, 0, 7, 1, 15, 0, 2, 1, 58, 0, 0, 0, 17, 0, 0, 0, 26, 0, 7, 1, 15, 0, 2, 1, 58, 0),
(42, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(42, 67, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(42, 68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(42, 69, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(42, 71, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(42, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(42, 73, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(42, 74, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

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
(3, 'Пользователь');

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
(57, 'Могилёвская центральная поликлиника', 39),
(63, '36gp', 42);

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
  `last_page` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id_user`, `username`, `login`, `password`, `id_role`, `online`, `last_act`, `last_time_online`, `last_page`) VALUES
(1, 'Аккредитация', 'accred@mail.ru', '6534cb7340066e972846eaf508de6224', 2, 'q4a6g38fgbpi8de8qjv9gfe5jua2jnj9', 'q4a6g38fgbpi8de8qjv9gfe5jua2jnj9', '2023-07-14 16:09:01', '/index.php?users'),
(2, '36gp', '36gp@mail.ru', 'ba258829bb23dce283867bb2f8b78d7f', 3, '57niaj6bvvdla3svvlc7sjnllge7rj67', '57niaj6bvvdla3svvlc7sjnllge7rj67', '2023-07-14 16:44:06', '/index.php?application'),
(3, 'Брестская городская поликлиника №1', 'brestgp1', 'ddd415ac66e91cf20c63792ffe88eb70', 3, NULL, NULL, NULL, NULL),
(4, 'Брестская городская поликлиника №2', 'brestgp2', '8bc25d7d934f31bca3a27442355caade', 3, NULL, NULL, NULL, NULL),
(5, 'Брестская городская поликлиника №3', 'brestgp3', 'dab4e30dcda1b14af1e11730e7597579', 3, NULL, NULL, NULL, NULL),
(6, 'Брестская городская поликлиника №5', 'brestgp5', '336e3f80e6a5d322384fffda3acf3493', 3, '0', NULL, '2023-06-21 16:14:17', '/index.php?logout'),
(7, 'Брестская городская поликлиника №6', 'brestgp6', 'c724f414397c5a9c719bfb0b63201032', 3, NULL, NULL, NULL, NULL),
(8, 'Брестская городская детская поликлиника №1', 'brestgdp1', '0fb809774404c914cdafda26f72cbd9c', 3, NULL, NULL, NULL, NULL),
(9, 'Бешенковичская центральная районная больница', 'beshcrb', 'e1bc2f88ab5562e1439bf60d25211f93', 3, NULL, NULL, NULL, NULL),
(10, 'Браславская центральная районная больница', 'braslcrb', 'bf186232d83e58890be306d60717d843', 3, NULL, NULL, NULL, NULL),
(11, 'Верхнедвинская центральная районная больница', 'verhcrb', '403ccfa28911929bde4e52485cb98b53', 3, NULL, NULL, NULL, NULL),
(12, 'Глубокская центральная районная больница', 'glybcrb', 'f3ff1be20a2b86abb56f73d32631eaab', 3, NULL, NULL, NULL, NULL),
(13, 'Городокская центральная районная больница', 'gorodcrb', '7cd53feb18eee6e8a138ec60982c3ce4', 3, NULL, NULL, NULL, NULL),
(14, 'Докшицкая центральная районная больница', 'dokcrb', '1a62538b0857b31bc75a778c7ac3358d', 3, NULL, NULL, NULL, NULL),
(15, 'Дубровенская центральная районная больница', 'dybcrb', 'c186cb708c45e863c714797a496d0cd6', 3, NULL, NULL, NULL, NULL),
(16, 'Лепельская центральная районная больница', 'lepcrb', '0245734f6adf781a9de274be8da2b969', 3, NULL, NULL, NULL, NULL),
(17, 'Лиозненская центральная районная больница', 'liozcrb', '43e35343bf1651d80079b2b39fc4406c', 3, NULL, NULL, NULL, NULL),
(18, 'Миорская центральная районная больница', 'miorcrb', 'ff294cc19bd38b979b07969cddb0312f', 3, NULL, NULL, NULL, NULL),
(19, 'Поставская центральная районная больница', 'postcrb', 'a5ec6b65fb4510d214b8a7132e691431', 3, NULL, NULL, NULL, NULL),
(20, 'Россонская центральная районная больница', 'roscrb', '064cb197795cd6b4bea5712f8971676a', 3, NULL, NULL, NULL, NULL),
(21, 'Сенненская центральная районная больница', 'senncrb', 'dd49b45fcf533467ae8e9a1f6d66aa56', 3, NULL, NULL, NULL, NULL),
(22, 'Толочинская центральная районная больница', 'tolochcrb', 'f8e610671d2fa15a7d1d2ba82c8811a1', 3, NULL, NULL, NULL, NULL),
(23, 'Ушачская центральная районная больница', 'yshachcrb', 'be2b9d92d96a58d02b3c25635956c4bd', 3, NULL, NULL, NULL, NULL),
(24, 'Новолукомльская центральная районная больница', 'novlykcrb', '70097c4f984055d2216dc5181258115c', 3, NULL, NULL, NULL, NULL),
(25, 'Шарковщинская центральная районная больница', 'sharkcrb', '46a85981b9dcfa630c5c3761f514e793', 3, NULL, NULL, NULL, NULL),
(26, 'Шумилинская центральная районная больница', 'shymcrb', '4bdd355b77e2c79518f948ad836bab3d', 3, NULL, NULL, NULL, NULL),
(27, 'Новополоцкая центральная городская больница', 'novopolcrb', 'fcb28017e0818defa1561021f78ed8d2', 3, NULL, NULL, NULL, NULL),
(28, 'Полоцкая центральная городская больница', 'polcrb', 'b94783aae60e04217a215186681c20a8', 3, NULL, NULL, NULL, NULL),
(29, 'Витебская областная клиническая больница', 'vitoblkb', '146cd0e39d24a5e66047eb3737aed046', 3, NULL, NULL, NULL, NULL),
(30, 'Витебский областной клинический специализированный центр', 'vitoblklin', '687a924c3e0c52609d30c895cf9115d3', 3, NULL, NULL, NULL, NULL),
(31, 'Витебский областной детский специализированный центр', 'vitobldetklin', '1b120db4189edd4b35c85fb7c73f84a5', 3, NULL, NULL, NULL, NULL),
(32, 'Витебский областной клинический центр дерматовенерологии и косметологии', 'vitoblcdk', '5cec8181dd3cd0d6c713784696a0972b', 3, NULL, NULL, NULL, NULL),
(33, 'Витебский областной клинический онкологический диспансер', 'vitoblkod', '7a60a486d1d251b590a61ad9b64cfd7e', 3, NULL, NULL, NULL, NULL),
(34, 'Витебский областной клинический центр пульмонологии и фтизиатрии', 'vitoblcpf', '62133d304bb6d38dac29e8832d49f097', 3, NULL, NULL, NULL, NULL),
(35, 'Витебская областная клиническая инфекционная больница', 'vitoblkib', 'b5a435188ada2a8851dc160ff82449f7', 3, NULL, NULL, NULL, NULL),
(36, 'Витебский областной клинический кардиологический центр', 'vitoblkkc', '0ed3a3e3955341333ad9f7ec8bd867e4', 3, NULL, NULL, NULL, NULL),
(37, 'Витебский областной клинический центр психиатрии и наркологии', 'vitoblkcpn', '08b8bd551ae3358ec635e479ae6f83fd', 3, NULL, NULL, NULL, NULL),
(38, 'Витебский областной клинический родильный дом', 'vitoblkrd', 'd2f53c6d5623a2077c52e6024d742e59', 3, NULL, NULL, NULL, NULL),
(39, 'Витебский городской клинический родильный дом №2', 'vitoblkrd2', 'b9b88531884ace07d9c27d6dabd1054d', 3, NULL, NULL, NULL, NULL),
(40, 'Витебский областной центр медицинской реабилитации для инвалидов и ветеранов боевых действий на территории других государств', 'vitoblcmridbd', '13d7c339af883ada411f286d644f6727', 3, NULL, NULL, NULL, NULL),
(41, 'Витебская городская клиническая больница №1', 'vitgkb1', '83ef936afc811a17ba8ae6fbd438226d', 3, NULL, NULL, NULL, NULL),
(42, 'Витебская городская клиническая больница скорой медицинской помощи', 'vitgkbsmp', '73fd8b2895f36dff590a23d6d2fdf872', 3, NULL, NULL, NULL, NULL),
(43, 'Витебский областной центр паллиативной медицинской помощи', 'vitoblcpmp', '4bde58af7703f1fe24860bbeed712843', 3, NULL, NULL, NULL, NULL),
(44, 'Областной детский реабилитационный оздоровительный центр «Ветразь»', 'vetrazod', 'd81cd1d728c6c27f0fa8f4f5dfc99921', 3, NULL, NULL, NULL, NULL),
(45, 'Полоцкая областная психиатрическая больница', 'polopb', '0ee7794db47b4cc3cc234f86f2d03eb3', 3, NULL, NULL, NULL, NULL),
(46, 'Лепельская областная психиатрическая больница', 'lepopb', 'ffccc296a790b92bf3712e6503ed3e36', 3, NULL, NULL, NULL, NULL),
(47, 'Областной госпиталь ИВОВ «Юрцево»', 'yurcevoog', 'c2e8d915ebe34bebf3a537197e9fc604', 3, NULL, NULL, NULL, NULL),
(48, 'Витебская центральная городская поликлиника', 'vitcgp', 'c87fe86209f0789dd0ef81aa5b57758a', 3, NULL, NULL, NULL, NULL),
(49, 'Оршанская центральная поликлиника', 'orshcp', '7ee0e3337806e5bd93ffb91526158165', 3, NULL, NULL, NULL, NULL),
(50, 'Оршанская городская стоматологическая поликлиника', 'orshgsp', '9b913d3e45cbdaff897b6c9f370c8dfa', 3, NULL, NULL, NULL, NULL),
(51, 'Витебский областной клинический стоматологический центр', 'vitobksc', '81349d9cf6bf362d961ede71a0a42caf', 3, NULL, NULL, NULL, NULL),
(52, 'Витебский областной клинический диагностический центр', 'vitokdc', '7c71982c64e1ae1087115c49208fb0ee', 3, NULL, NULL, NULL, NULL),
(53, 'Витебский областной эндокринологический диспансер', 'vitoed', '0f63c7a8ef31d0d9b232670bb45759be', 3, NULL, NULL, NULL, NULL),
(54, 'Брагинская центральная районная больница', 'bragcrb', '9de226275a9907927dd4edf772b5d988', 3, NULL, NULL, NULL, NULL),
(55, 'Буда-Кошелевская центральная районная больница', 'budkoshcrb', '241f315a37acf051f0433af0e007cc8f', 3, NULL, NULL, NULL, NULL),
(56, 'Ветковская центральная районная больница', 'vetcrb', '88336152ee912acc9e02b8c474a4d385', 3, NULL, NULL, NULL, NULL),
(57, 'Добрушская центральная районная больница', 'dobrcrd', 'c7e54637ff7d573933f1129f53deabca', 3, NULL, NULL, NULL, NULL),
(58, 'Ельская центральная районная больница', 'elcrb', 'c7e54637ff7d573933f1129f53deabca', 3, NULL, NULL, NULL, NULL),
(59, 'Житковичская центральная районная больница', 'zhitcrb', 'f7378eb29111b141ee77e70a29ac767a', 3, NULL, NULL, NULL, NULL),
(60, 'Жлобинская центральная районная больница', 'zhlocrb', '8ce967b00c03784aff5787ff3663e508', 3, NULL, NULL, NULL, NULL),
(61, 'Калинковичская центральная районная больница', 'kalinkcrb', '0d672a5b748a9682a2847c16cde60ae6', 3, NULL, NULL, NULL, NULL),
(62, 'Кормянская центральная районная больница', 'kormcrb', 'f3a45ad8de92cee0b25233f8edbae35f', 3, NULL, NULL, NULL, NULL),
(63, 'Лельчицкая центральная районная больница', 'lelchcrb', '271f377ff8dd8b6ab821d532a90fc8ad', 3, NULL, NULL, NULL, NULL),
(64, 'Лоевская центральная районная больница', 'loevcrb', '52e0172a09671db5b36ed1b247632a51', 3, NULL, NULL, NULL, NULL),
(65, 'Мозырский городской родильный дом', 'mozgrd', '4e56ed8004fec8cf31f3e5aa48a6eddf', 3, NULL, NULL, NULL, NULL),
(66, 'Мозырская городская детская больница', 'mozgdb', '84c26ee6f9f7cd8b33f7b2341c9f211d', 3, NULL, NULL, NULL, NULL),
(67, 'Мозырская городская больница', 'mozgb', '0ca21a650ac81626647a2b796755f64e', 3, NULL, NULL, NULL, NULL),
(68, 'Наровлянская центральная районная больница', 'narovlcrb', '5289c04cd9526c0058a102a70d77f45f', 3, NULL, NULL, NULL, NULL),
(69, 'Октябрьская центральная районная больница', 'oktcrb', 'e54c0270ff9edc0bbcc94de22ecf348c', 3, NULL, NULL, NULL, NULL),
(70, 'Петриковская центральная районная больница', 'petrcrb', '9beee53aa2492b20f99df2c762a504b1', 3, NULL, NULL, NULL, NULL),
(71, 'Речицкая центральная районная больница', 'rechcrb', 'd07a5bb5fca5018438713760409dddde', 3, NULL, NULL, NULL, NULL),
(72, 'Рогачевская центральная районная больница', 'rogcrb', '89b7e268451534a8ab900eb670e1307b', 3, NULL, NULL, NULL, NULL),
(73, 'Светлогорская центральная районная больница', 'svetlcrb', '21363eb5e758051e8de2c9fae7f154d3', 3, NULL, NULL, NULL, NULL),
(74, 'Хойникская центральная районная больница', 'hoincrb', 'b26ecf515d89360d9b761ca354fd9d35', 3, NULL, NULL, NULL, NULL),
(75, 'Чечерская центральная районная больница', 'chechercrb', '8ffee210aa0f1b723ce3082df6898048', 3, NULL, NULL, NULL, NULL),
(76, 'Гомельская областная клиническая больница', 'gomokb', '29d867b5638c83e84a1d8a0f79544ee1', 3, NULL, NULL, NULL, NULL),
(77, 'Гомельская областная  детская клиническая больница', 'gomodkb', '3c06c1a037c4bedc0088050f299317c3', 3, NULL, NULL, NULL, NULL),
(78, 'Университетская клиника - областной клинический Госпиталь ИОВ', 'yniverkokg', '52c1a14001b2fa3e936defdb0625a51f', 3, NULL, NULL, NULL, NULL),
(79, 'Гомельская областная туберкулезная клиническая больница', 'gomotkb', '0664e398747ba28fbb9083c3f332c58d', 3, NULL, NULL, NULL, NULL),
(80, 'Гомельская областная клиническая психиатрическая больница', 'gomokpb', 'b6b4cab295435ce24729f91714e3b23f', 3, NULL, NULL, NULL, NULL),
(81, 'Гомельский областной наркологический диспансер', 'gomond', '930af4de3996b17175dcb78eddfee5b1', 3, NULL, NULL, NULL, NULL),
(82, 'Гомельский областной клинический онкологический диспансер', 'gomokod', '2cef0da657f424bfebb3849efd0e89a5', 3, NULL, NULL, NULL, NULL),
(83, 'Гомельский областной клинический кожно-венерологический диспансер', 'gomokkvd', 'fc328b6afc8d9137c6a42fb82894c948', 3, NULL, NULL, NULL, NULL),
(84, 'Гомельский областной клинический кардиологический центр', 'gomokkc', 'fb60fbfaad20ee373615d7d61ec8c965', 3, NULL, NULL, NULL, NULL),
(85, 'Гомельская областная специализированная клиническая больница', 'gomoskb', 'ac68352db67443cee67579183b7a09ac', 3, NULL, NULL, NULL, NULL),
(86, 'Гомельская областная инфекционная клиническая больница', 'gomoikb', '2469186e66104fe0ddb09ceed39796a6', 3, NULL, NULL, NULL, NULL),
(87, 'Гомельский областной детский центр медицинской реабилитации «Верасок»', 'verasokodcmr', '26ee1267ac2d81305bfe8fc992e4d468', 3, NULL, NULL, NULL, NULL),
(88, 'Гомельская областная детская больница медицинской реабилитации «Живица»', 'zhivicaodbmr', '5ae2a95bdde58927cd6e59924a742441', 3, NULL, NULL, NULL, NULL),
(89, 'Гомельская городская клиническая больница №1', 'ggkb1', 'b8dfd62cf58e73260c5b1e234e13cf88', 3, NULL, NULL, NULL, NULL),
(90, 'Гомельская городская клиническая больница №2', 'ggkb2', '37ec5983e06d52a9ead3da6ee4e162d6', 3, NULL, NULL, NULL, NULL),
(91, 'Гомельская городская клиническая больница №3', 'ggkb3', '48b69ceab52f444028bcfccc93c35790', 3, NULL, NULL, NULL, NULL),
(92, 'Гомельская городская больница №4', 'ggb4', '78d243d40d574fd9cdeba204f2dcae92', 3, NULL, NULL, NULL, NULL),
(93, 'Больница скорой медицинской помощи', 'gombsmp', '6f8f2fe6397ef9f9215a04ac04184078', 3, NULL, NULL, NULL, NULL),
(94, 'Гомельская областная стоматологическая поликлиника', 'gomosp', '0919bdc127a8eb3da86cd94bc982367a', 3, NULL, NULL, NULL, NULL),
(95, 'Гомельский областной эндокринологический диспансер', 'gomoed', '85662eab542f47496f03419754870207', 3, NULL, NULL, NULL, NULL),
(96, 'Гомельский областной медико-генетический центр с консультацией «Брак и семья»', 'gomomgckbs', '203cfb04d7cd1c54c4b85cc0557581a0', 3, NULL, NULL, NULL, NULL),
(97, 'Гомельская областная клиническая поликлиника', 'gomokp', 'fa46ce4a5fec5c66a3599d36a779ddd4', 3, NULL, NULL, NULL, NULL),
(98, 'Гомельская центральная городская клиническая поликлиника', 'gomcgkp', '8a8f35aed306251a4a0e5f3425d326d4', 3, NULL, NULL, NULL, NULL),
(99, 'Гомельская городская клиническая поликлиника № 2', 'gomgkp2', '0691677773ba4d1ec8aefdb896017c07', 3, NULL, NULL, NULL, NULL),
(100, 'Гомельская городская клиническая поликлиника № 3', 'gomgkp3', '490bfea2d429766a5145953e99d125e8', 3, NULL, NULL, NULL, NULL),
(101, 'Гомельская городская клиническая поликлиника № 4', 'gomgkp4', '1693c3f3734d9d016039512f495326b3', 3, NULL, NULL, NULL, NULL),
(102, 'Гомельская городская клиническая поликлиника № 5 им. С.В. Голуховой', 'gomgkp5', 'be17e8734d31da1ccf36b598e01c7478', 3, NULL, NULL, NULL, NULL),
(103, 'Гомельская городская клиническая поликлиника № 6', 'gomgkp6', 'eaa6e8fec6220de57eae164f8b7c07b3', 3, NULL, NULL, NULL, NULL),
(104, 'Гомельская городская клиническая поликлиника № 8', 'gomgkp8', '7996b5ae76ded183a3db5a985e209d35', 3, NULL, NULL, NULL, NULL),
(105, 'Гомельская городская клиническая поликлиника № 9', 'gomgkp9', '2e1f0ebd3a963afd77efce78ec699a07', 3, NULL, NULL, NULL, NULL),
(106, 'Гомельская городская клиническая поликлиника № 10', 'gomgkp10', 'f3e2e3fa1dce833133867f225d15ea6c', 3, NULL, NULL, NULL, NULL),
(107, 'Гомельская городская клиническая поликлиника № 11', 'gomgkp11', '81f0dcd793db9f2b0b2fffb2584bc304', 3, NULL, NULL, NULL, NULL),
(108, 'Гомельская городская поликлиника №13', 'gomgp13', 'bae495cf230b4ca7c017de7977a82e64', 3, NULL, NULL, NULL, NULL),
(109, 'Гомельская городская клиническая поликлиника № 14', 'gomgkp14', '0122d770cc542cacb20b7293b245dc92', 3, NULL, NULL, '2023-06-23 16:42:49', '/index.php?application'),
(110, 'Гомельская городская поликлиника № 1', 'gomgp1', 'f4e7f83bd04cbcb3eff3d05119b974d4', 3, '0', NULL, '2023-06-23 11:23:18', '/index.php?logout'),
(111, 'Поликлиника № 7', 'gomp7', 'd4ea3910789bf7de1c5c0907042f0254', 3, NULL, NULL, NULL, NULL),
(112, 'Гомельская центральная городская детская клиническая поликлиника', 'gomcgdkp', 'c34b63c78150c7eac48ec2620ae53a26', 3, NULL, NULL, NULL, NULL),
(113, 'Гомельская центральная городская стоматологическая поликлиника', 'gomcgsp', '4de0c63e1f0c0e98040b7ae2b25dfc75', 3, NULL, NULL, NULL, NULL),
(114, 'Мозырская центральная городская поликлиника', 'mozcgp', '62d97280f28e55d52ffa173c6e63da25', 3, NULL, NULL, NULL, NULL),
(115, 'Центр медицинской реабилитации для детей-инвалидов и молодых инвалидов с психоневрологическими заболеваниями «Радуга»', 'radugacmrdi', 'ee25f4b10557e264ae0c6cd4930460df', 3, '0', NULL, '2023-06-23 11:23:41', '/index.php?logout'),
(116, 'Мозырская городская стоматологическая поликлиника', 'mozgsp', '9b8073512100f57a6136f2ef1d85b1b1', 3, NULL, NULL, NULL, NULL),
(117, 'Мозырская городская поликлиника №4', 'mozgp4', 'aa60a09bb93dc5b20cd68bbf6a05d72c', 3, NULL, NULL, NULL, NULL),
(118, 'Белыничская центральная районная больница', 'belincrb', 'd98beb62c8136ddb15fcb039d0094435', 3, NULL, NULL, NULL, NULL),
(119, 'Быховская центральная районная больница', 'bihovcrb', '2dcddc92c2f429dbcdaeaaf5918558b7', 3, NULL, NULL, NULL, NULL),
(120, 'Глусская центральная районная больница', 'glusscrb', '49ac3166fc1abcc2926d3e799a6a11cb', 3, NULL, NULL, NULL, NULL),
(121, 'Горецкая центральная районная больница', 'goreccrb', '4c7f7e68f06ba02e475ce9ae4702b3a7', 3, NULL, NULL, NULL, NULL),
(122, 'Дрибинская центральная районная больница', 'dribincrb', '7c0b274e6ecb2b97bb23d559d3805d7d', 3, NULL, NULL, NULL, NULL),
(123, 'Кировская центральная районная больница', 'kirovcrb', '08c76e848b9f9dc6abf60be006dc4024', 3, NULL, NULL, NULL, NULL),
(124, 'Климовичская центральная районная больница', 'klimovichcrb', 'a33ea18ea1b2784e148a5ebbf72c509c', 3, NULL, NULL, NULL, NULL),
(125, 'Кличевская центральная районная больница', 'klichevcrb', '93e19cc0c7605075eb0b8c739c08ebc3', 3, NULL, NULL, NULL, NULL),
(126, 'Костюковичская центральная районная больница', 'kostukovcrb', '3704c60d53abc0988b1d187650f0ff3c', 3, NULL, NULL, NULL, NULL),
(127, 'Краснопольская центральная районная больница', 'krasnopolcrb', 'a67a88d49a646679a7f9de64cb043668', 3, NULL, NULL, NULL, NULL),
(128, 'Кричевская центральная районная больница', 'krichevcrb', '8346958473175887d4675dbf89a5f8aa', 3, NULL, NULL, NULL, NULL),
(129, 'Круглянская центральная районная больница', 'kruglyancrb', 'fb7344836d0389c7815f7b2fe553c30e', 3, NULL, NULL, NULL, NULL),
(130, 'Мстиславская центральная районная больница', 'msticlavcrb', '10ad9237b2ecce48936351d56ec079f6', 3, NULL, NULL, NULL, NULL),
(131, 'Осиповичская центральная районная больница', 'osipcrb', '4c594dceae3cad87571f07c6c6ef237e', 3, NULL, NULL, NULL, NULL),
(132, 'Славгородская центральная районная больница', 'slavogorodcrb', 'd232950f2b7b12b7fc8368a8f8792ec1', 3, NULL, NULL, NULL, NULL),
(133, 'Хотимская центральная районная больница', 'hotimcrb', 'f81dc864af5f9f01f46f28d37402b82c', 3, NULL, NULL, NULL, NULL),
(134, 'Чаусская центральная районная больница', 'chausscrb', 'c40b7ceea1c02fa233df6a728caa67c4', 3, NULL, NULL, NULL, NULL),
(135, 'Чериковская центральная районная больница', 'cherikovcrb', 'c80fbb7b82422e6665dd7817114cfbbe', 3, NULL, NULL, NULL, NULL),
(136, 'Шкловская центральная районная больница', 'sklovcrb', '211d442e54b2acdd170f804641bcab21', 3, NULL, NULL, NULL, NULL),
(137, 'Могилёвская областная клиническая  больница', 'mogokb', '486e547dfb4fcc28144a2037892601ef', 3, NULL, NULL, NULL, NULL),
(138, 'Могилёвская областная детская больница', 'mogodb', 'f365d108355a142f65d49d95694e7e1b', 3, NULL, NULL, NULL, NULL),
(139, 'Могилёвская областная больница медицинской реабилитации', 'mogobmr', '1103a126eabcc91c3c3a88206305daa9', 3, NULL, NULL, NULL, NULL),
(140, 'Могилёвский областной госпиталь ИОВ', 'mogogivov', '8164b499d12fe3a6d3ce0b667bb64349', 3, NULL, NULL, NULL, NULL),
(141, 'Могилёвская областная психиатрическая больница', 'mogopb', 'dc237af45503726c26c699e709f56323', 3, NULL, NULL, NULL, NULL),
(142, 'Областной детский центр медицинской реабилитации «Космос»', 'cosmosodcmr', '738e980f080a2e1ebc55dc748dae3791', 3, NULL, NULL, NULL, NULL),
(143, 'Могилёвский областной противотуберкулёзный диспансер', 'mogopd', 'e0d4126bf985ecce9950d78a2bf3c692', 3, NULL, NULL, NULL, NULL),
(144, 'Могилёвский областной онкологический диспансер', 'mogood', 'a2b943f49935193bad8d9e9f5134af98', 3, NULL, NULL, NULL, NULL),
(145, 'Могилёвский областной наркологический диспансер', 'mogond', '70ca6e4e5006b9d26922bdda1b7a5495', 3, NULL, NULL, NULL, NULL),
(146, 'Могилёвский областной кожно-венерологический диспансер', 'mogokvd', 'abbd4bbf1b5aeca11e0ae8b6b968ba8b', 3, NULL, NULL, NULL, NULL),
(147, 'Могилёвская больница № 1', 'mogb1', 'bf9c32958eaa9f07bcc1a3598be311f2', 3, NULL, NULL, NULL, NULL),
(148, 'Могилёвская городская больница скорой медицинской помощи', 'moggbsmp', '5159fb359c757ac48b77449a1f106f29', 3, NULL, NULL, NULL, NULL),
(149, 'Бобруйская городская больница скорой медицинской помощи', 'bobrgbsmp', '550488c69d7a9acbefa5f7f5d6d25ffc', 3, NULL, NULL, NULL, NULL),
(150, 'Бобруйский межрайонный онкологический диспансер', 'bobrmod', '77f0272eca8370fb9b11b7f3387d27be', 3, NULL, NULL, NULL, NULL),
(151, 'Бобруйская центральная больница', 'bobrcb', '7746e779512e99d3ff90e9bb785330d4', 3, NULL, NULL, NULL, NULL),
(152, 'Бобруйский родильный дом', 'bobrrd', '27818311fc5358e9ba01b83c7649edc1', 3, NULL, NULL, NULL, NULL),
(153, 'Могилёвская центральная поликлиника', 'mogcp1', '5a9fb59ba618d436080508c3fdf60edb', 3, '0', 'b1su7tp9hk5ivlaokbqekarecglgf3uh', '2023-07-13 16:45:42', '/index.php?logout'),
(154, 'Могилёвская поликлиника № 2', 'mogp2', '3cab5ff32ec52df602947045bf14012d', 3, NULL, NULL, NULL, NULL),
(155, 'Могилёвская поликлиника № 3', 'mogp3', '7d5f08679f61ef3e08d653607d1c553f', 3, NULL, NULL, NULL, NULL),
(156, 'Могилёвская поликлиника № 4', 'mogp4', '4116ce97f7447f14f7e58b0799ce0af1', 3, NULL, NULL, NULL, NULL),
(157, 'Могилёвская поликлиника № 5', 'mogp5', 'e279f5420f5e760d1e382b67dffa9c7f', 3, NULL, NULL, NULL, NULL),
(158, 'Могилёвская поликлиника № 6', 'mogp6', '609cfc5b4d8ba49853ccb60e19d94c87', 3, NULL, NULL, NULL, NULL),
(159, 'Могилёвская поликлиника № 7', 'mogp7', '9ffb6a4095c8bda4ff8416764ebc9ac3', 3, NULL, NULL, NULL, NULL),
(160, 'Могилёвская поликлиника № 8', 'mogp8', '9daa1b1206856818fe11a29205a5e6c0', 3, NULL, NULL, NULL, NULL),
(161, 'Могилёвская поликлиника № 9', 'mogp9', '539e58c857080de06853d18db0b38e06', 3, NULL, NULL, NULL, NULL),
(162, 'Могилёвская поликлиника № 10', 'mogp10', 'bc7ee77c8e31bf55c24f02abd3e32fc9', 3, NULL, NULL, NULL, NULL),
(163, 'Могилёвская поликлиника № 11', 'mogp11', '271a367f3b83e17c75f1365f3e57a697', 3, NULL, NULL, NULL, NULL),
(164, 'Могилёвская поликлиника № 12', 'mogp12', '31c3e7c375d4b11841e11d1fe3e224c8', 3, '0', NULL, '2023-06-29 12:06:00', '/index.php?logout'),
(165, 'Могилёвская детская поликлиника', 'mogdp', 'e0979a51dd440eef0cb52a6df30c3b0e', 3, NULL, NULL, NULL, NULL),
(166, 'Могилёвская детская поликлиника № 1', 'mogdp1', '19c6645444fffadcbcb83b1b8524fc81', 3, NULL, NULL, NULL, NULL),
(167, 'Могилёвская детская поликлиника № 2', 'mogdp2', '2495cdf58a095b31c3f376e9663017c4', 3, NULL, NULL, NULL, NULL),
(168, 'Могилёвская детская поликлиника № 4', 'mogdp4', '4843b42ed8b5b2ae6941acafb38a588f', 3, NULL, NULL, NULL, NULL),
(169, 'Могилёвский областной лечебно- диагностический центр', 'mogoldc', '53c1274b108a0ae5a41495eb5c088af5', 3, NULL, NULL, NULL, NULL),
(170, 'Могилёвская стоматологическая поликлиника', 'mogsp', 'df9c42c006c19ece734aa8618f4a8713', 3, NULL, NULL, NULL, NULL),
(171, 'Могилёвская стоматологическая поликлиника № 2', 'mogsp2', 'd4fc2f53edc254075fd3d36d160b5f1e', 3, NULL, NULL, NULL, NULL),
(172, 'Могилёвская детская стоматологическая поликлиника', 'mogdsp', '7217f72d02b4331c342bc96de932438e', 3, NULL, NULL, NULL, NULL),
(173, 'Могилёвская областная стоматологическая поликлиника', 'mogosp', '41f015fdccc037bd5955fd28d0d3ab8e', 3, NULL, NULL, NULL, NULL),
(174, 'Могилёвская областная детская стоматологическая поликлиника', 'mogodsp', '57c3f174417faaca51209e66ed6f57ad', 3, NULL, NULL, NULL, NULL),
(175, 'Бобруйская городская поликлиника № 1', 'bobrgp1', 'f9e18e747119c6e6d2bb27c9765da958', 3, NULL, NULL, NULL, NULL),
(176, 'Бобруйская городская поликлиника № 2', 'bobrgp2', '71ac274039cea15946a3cd7b3d732e9c', 3, NULL, NULL, NULL, NULL),
(177, 'Бобруйская городская поликлиника № 3', 'bobrgp3', 'aa8cb999e958ecd02747865152ff6548', 3, NULL, NULL, NULL, NULL),
(178, 'Бобруйская городская поликлиника № 6', 'bobrgp6', '7f7768f182635a14ac722cb1cf7e7752', 3, NULL, NULL, NULL, NULL),
(179, 'Бобруйская городская поликлиника № 7', 'bobrgp7', 'd735cbfd33fa153e93b171ebc94b25eb', 3, NULL, NULL, NULL, NULL),
(180, 'Бобруйская городская детская больница', 'bobrgdb', 'f7aacd19a8fb9b4dcd1229a2bbb15194', 3, NULL, NULL, NULL, NULL),
(181, 'Бобруйская городская стоматологическая поликлиника № 1', 'bobrgsp1', '8c7ac16dbfb15d21ba42438d257cf30a', 3, NULL, NULL, NULL, NULL),
(182, 'Бобруйская лечебно-консультативная поликлиника', 'bobrlkp', '8da55ad0bfb7019c125a53e8915dba9d', 3, NULL, NULL, NULL, NULL),
(183, 'admin', 'hancharou@rnpcmt.by', '2c904ec0191ebc337d56194f6f9a08fa', 1, '0', 'b1su7tp9hk5ivlaokbqekarecglgf3uh', '2023-07-13 14:41:03', '/index.php?logout');

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
  MODIFY `id_application` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

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
  MODIFY `id_mark_rating` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT для таблицы `rating_criteria`
--
ALTER TABLE `rating_criteria`
  MODIFY `id_rating_criteria` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=157;

--
-- AUTO_INCREMENT для таблицы `roles`
--
ALTER TABLE `roles`
  MODIFY `id_role` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `status`
--
ALTER TABLE `status`
  MODIFY `id_status` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `subvision`
--
ALTER TABLE `subvision`
  MODIFY `id_subvision` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=184;

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
