DROP database covid;
create database covid;
use covid;


 CREATE TABLE `bookingpatient` (
 `id` int(11) NOT NULL,
`srfid` varchar(50) NOT NULL,
`bedtype` varchar(50) NOT NULL,
`hcode` varchar(50) NOT NULL,
`spo2` int(11) NOT NULL,
`pname` varchar(50) NOT NULL,
`pphone` varchar(12) NOT NULL,
`paddress` text NOT NULL
);

 CREATE TABLE `hospitaldata` (
 `id` int(11) NOT NULL,
 `hcode` varchar(200) NOT NULL,
`hname` varchar(200) NOT NULL,
`normalbed` int(11) NOT NULL,
`hicubed` int(11) NOT NULL,
`icubed` int(11) NOT NULL,
`vbed` int(11) NOT NULL
) ;


 CREATE TRIGGER `Insert` AFTER INSERT ON `hospitaldata` FOR EACH ROW INSERT INTO trig VALUES(null,NEW.hcode,NEW.normalbed,NEW.hicubed,NEW.icubed,NEW.vbed,' INSERTED',NOW());


 CREATE TRIGGER `Update` AFTER UPDATE ON `hospitaldata` FOR EACH ROW INSERT INTO trig VALUES(null,NEW.hcode,NEW.normalbed,NEW.hicubed,NEW.icubed,NEW.vbed,' UPDATED',NOW());


CREATE TRIGGER `delet` BEFORE DELETE ON `hospitaldata` FOR EACH ROW INSERT INTO trig VALUES(null,OLD.hcode,OLD.normalbed,OLD.hicubed,OLD.icubed,OLD.vbed,' DELETED',NOW())
     ;

CREATE TABLE `hospitaluser` (
      `id` int(11) NOT NULL,
       `hcode` varchar(20) NOT NULL,
      `email` varchar(100) NOT NULL,
       `password` varchar(1000) NOT NULL
     ) ;

 CREATE TABLE `test` (
       `id` int(11) NOT NULL,
      `name` varchar(50) NOT NULL
     );


 INSERT INTO `test` (`id`, `name`) VALUES
     (1, 'taha'),
     (2, 'pratham');



 CREATE TABLE `trig` (
 `id` int(11) NOT NULL,
`hcode` varchar(50) NOT NULL,
`normalbed` int(11) NOT NULL,
       `hicubed` int(11) NOT NULL,
       `icubed` int(11) NOT NULL,
       `vbed` int(11) NOT NULL,
       `querys` varchar(50) NOT NULL,
       `date` date NOT NULL
     ) ;


 INSERT INTO `trig` (`id`, `hcode`, `normalbed`, `hicubed`, `icubed`, `vbed`, `querys`, `date`) VALUES
     (1, 'BBH01', 50, 9, 2, 1, ' UPDATED', '2021-11-26'),
     (2, 'BBH01', 50, 9, 2, 1, ' DELETED', '2021-11-26'),
     (3, 'AA1100', 15, 5, 4, 2, ' INSERTED', '2021-11-26'),
     (4, 'AA1100', 15, 10, 8, 2, ' UPDATED', '2021-11-26'),
	(5, 'AA1100', 15, 10, 7, 2, ' UPDATED', '2021-11-26'),
     (6, 'ARK123 ', 12, 55, 22, 22, ' INSERTED', '2022-01-12'),
     (7, 'ARK123', 12, 50, 22, 22, ' UPDATED', '2022-01-12'),
     (8, 'ABCD123 ', 11, 15, 4, 20, ' INSERTED', '2022-01-12'),
     (9, 'ABCD123', 11, 11, 4, 20, ' UPDATED', '2022-01-12'),
     (10, 'ARK123', 12, 50, 21, 22, ' UPDATED', '2022-01-12'),
     (11, 'MAT123', 40, 4, 4, 1, ' DELETED', '2022-01-30'),
     (12, 'AA1100', 15, 10, 7, 2, ' DELETED', '2022-01-30'),
     (13, 'ARK123', 12, 50, 21, 22, ' DELETED', '2022-01-30'),
     (14, 'ABCD123', 11, 11, 4, 20, ' DELETED', '2022-01-30');


 CREATE TABLE `user` (
 `id` int(11) NOT NULL,
`srfid` varchar(20) NOT NULL,
`email` varchar(100) NOT NULL,
`dob` varchar(1000) NOT NULL
     );


 ALTER TABLE `bookingpatient`
ADD PRIMARY KEY (`id`),
ADD UNIQUE KEY `srfid` (`srfid`(20));


 ALTER TABLE `hospitaldata`
       ADD PRIMARY KEY (`id`),
       ADD UNIQUE KEY `hcode` (`hcode`);


 ALTER TABLE `hospitaluser`
ADD PRIMARY KEY (`id`);


 ALTER TABLE `test`
ADD PRIMARY KEY (`id`);


 ALTER TABLE `trig`
	ADD PRIMARY KEY (`id`);


 ALTER TABLE `user`
 ADD PRIMARY KEY (`id`),
ADD UNIQUE KEY `srfid` (`srfid`);


 ALTER TABLE `bookingpatient`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;


 ALTER TABLE `hospitaldata`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

 ALTER TABLE `hospitaluser`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;


 ALTER TABLE `test`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

 ALTER TABLE `trig`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;


 ALTER TABLE `user`
	MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;


 COMMIT;


 select*from covid.bookingpatient;


 select*from covid.hospitaldata;

 select*from covid.hospitaluser;

 select*from covid.test;
 select*from covid.trig;
 select*from covid.user;


