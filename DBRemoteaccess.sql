-- CREATE DATABASE
CREATE DATABASE DBRemoteAccess;
USE DBRemoteAccess;

-- CREATE TABLES
CREATE TABLE tbl_Allied_Type(
	typ_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	typ_name VARCHAR(35) NOT NULL
);

CREATE TABLE tbl_Medical_Record(
	emr_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	emr_name VARCHAR(35) NOT NULL
);

CREATE TABLE tbl_Remote_Status(
	rem_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	rem_name VARCHAR(35) NOT NULL
);

CREATE TABLE tbl_stepfive(
	fiv_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	fiv_name VARCHAR(35) NOT NULL
);

CREATE TABLE tbl_Employment_Status(
	emp_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	emp_name VARCHAR(35) NOT NULL
);

CREATE TABLE tbl_ItCompany(
	itc_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	itc_name VARCHAR(35) NOT NULL,
	itc_address VARCHAR(255),
	itc_phone VARCHAR(16),
	itc_email VARCHAR(255),
	itc_contact_name VARCHAR(35)
);

CREATE TABLE tbl_Practice(
	prc_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	prc_name VARCHAR(35) NOT NULL,
	prc_emr_id INT NOT NULL,
	prc_itcompany_id INT,
	prc_emp_id INT NOT NULL,
	prc_address VARCHAR(255),
	prc_phone VARCHAR(16),
	prc_email VARCHAR(255),
	FOREIGN KEY (prc_emr_id) REFERENCES tbl_Medical_Record(emr_id),
	FOREIGN KEY (prc_itcompany_id) REFERENCES tbl_ItCompany(itc_id),
	FOREIGN KEY (prc_emp_id) REFERENCES tbl_Employment_Status(emp_id)
);

CREATE TABLE tbl_Practice_Connection_Details(
	det_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	det_prc_id INT NOT NULL,
	det_server VARCHAR(50),
	det_string VARCHAR(50),
	det_gateway VARCHAR(50),
	det_port VARCHAR(10),
	det_program VARCHAR(50),
	FOREIGN KEY (det_prc_id) REFERENCES tbl_Practice(prc_id)
);

CREATE TABLE tbl_Allied_Professional(
	all_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	all_first_name VARCHAR(35),
	all_last_name VARCHAR(35),
	all_type_id INT NOT NULL,
	all_emp_id INT NOT NULL,
	all_phone VARCHAR(16),
	all_email VARCHAR(255),
	FOREIGN KEY (all_type_id) REFERENCES tbl_Allied_Type(typ_id),
	FOREIGN KEY (all_emp_id) REFERENCES tbl_Employment_Status(emp_id)
);

CREATE TABLE tbl_Practice_Allied_Affiliation(
	aff_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	aff_prc_id INT NOT NULL,
	aff_all_id INT NOT NULL,
	aff_start_date DATE,
	aff_end_date DATE,
	FOREIGN KEY (aff_all_id) REFERENCES tbl_Allied_Professional(all_id),
	FOREIGN KEY (aff_prc_id) REFERENCES tbl_Practice(prc_id)
);

CREATE TABLE tbl_Allied_Remote_Status(
	sta_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	sta_aff_id INT NOT NULL,
	sta_rem_id INT,
	sta_emr_login BOOLEAN,
	sta_comments VARCHAR(255),
	sta_last_update DATE,
	sta_step1 BOOLEAN,
	sta_step2 BOOLEAN,
	sta_step3 BOOLEAN,
	sta_step4 BOOLEAN,
	sta_fiv_id INT,
	FOREIGN KEY (sta_aff_id) REFERENCES tbl_Practice_Allied_Affiliation(aff_id),
	FOREIGN KEY (sta_rem_id) REFERENCES tbl_Remote_Status(rem_id),
	FOREIGN KEY (sta_fiv_id) REFERENCES tbl_stepfive(fiv_id)
);

-- Alter the default value of the Medical Record Login as false or 0
ALTER TABLE tbl_Allied_Remote_Status MODIFY sta_emr_login BOOLEAN DEFAULT 0;

-- INSERT VALUES TO TABLES
INSERT INTO tbl_Allied_Type(typ_name) VALUES('Mental Health Counsellor'),('Registered Dietitian'),('Psychiatrist'),('Pharmacist'),('Mental Health Nurse');
INSERT INTO tbl_Medical_Record(emr_name) VALUES('PSS-ASP'),('PSS-Local'),('Oscar'),('Accuro'),('P&P'),('CHM'),('Avaros');
INSERT INTO tbl_Remote_Status(rem_name) VALUES('Yes'),('In Progress'),('Denied'),('Doesnt need'),('Removed'),('Completed'),('Unknown');
INSERT INTO tbl_stepfive(fiv_name) VALUES('Ready'),('Completed'),('Practice-no response'),('IHP-no response');
INSERT INTO tbl_Employment_Status(emp_name) VALUES('Active'),('Inactive'),('Unknown');
INSERT INTO tbl_ItCompany(itc_name,itc_address,itc_phone,itc_email,itc_contact_name) 
VALUES('Outsource IT','5420 Mainway #5, Burlington, ON L7L 6A4','1-800-759-0786','itsupport@oitc.ca','Mike'),
('Alliance Computers','211 King St E, Hamilton, ON L8N 1B6','905-522-8288',' kellyc@alliancecomputers.ca','Kelly Chan'),
('CCXIT','225 King William St, Hamilton, ON L8R 1B1','905-549-4447',' Preston@ccxit.com','Preston'),
('HFHT',NULL,NULL,NULL,'James');

INSERT INTO tbl_Practice(prc_name,prc_emr_id,prc_itcompany_id,prc_emp_id,prc_address,prc_phone,prc_email) 
VALUES('Core Care',2,4,1,'576 Main St E, Hamilton, ON L8M 1J2','905-528-5292','corecare@gmail.com'),
('Aguanno',2,2,1,'160 Dundurn Street South Hamilton, ON','905-528-5480','aguanno@gmail.com'),
('Kwok and Jones',1,1,1,'15 Mountain Avenue South, Unit 310 Stoney Creek, ON','905-522-9999','kwok@gmail.com'),
('Hutchings',1,3,1,'801 Mohawk Rd W, Suite 205 Hamilton, ON','905-222-5555','hutchings@gmail.com'),
('Kavalsky',1,1,1,'337 Queenston Rd.Hamilton, ON','905-333-6666','kavalsky@gmail.com'),
('Golda',3,2,1,'35 Upper Centennial Pkwy, Suite 2B Stoney Creek, ON','905-412-7777','golda@gmail.com'),
('Allega',5,4,1,'980 Queenston Road, Unit 201 Stoney Creek, ON','905-333-6666','kavalsky@gmail.com'),
('Blew',3,3,1,'200 James Street South, Suite 306 Hamilton, ON','905-892-1782','blew@gmail.com'),
('Creatchman',7,1,1,'1 Young Street, Suite 605 Hamilton, ON','905-658-9999','creatchman@gmail.com'),
('Di Paolo',6,4,1,'755 Concession Street, Unit 200 Hamilton, ON','905-958-4397','dipaolo@gmail.com');

INSERT INTO tbl_Practice_Connection_Details(det_prc_id,det_server,det_string,det_gateway,det_port,det_program) 
VALUES(1,'10.76.2.130',NULL,'10.50.20.30','443','Forticlient'),
(2,'10.35.2.31',NULL,'24.145.188.212','9443','Forticlient'),
(3,'10.21.5.59','29999on.pssuite.telushealth.com','remoteon.pssuite.telushealth.com','443','Forticlient'),
(4,'10.21.1.188','54699on.pssuite.telushealth.com','remoteon1.pssuite.telushealth.com','443','Forticlient'),
(5,'10.21.3.23','23899on.pssuite.telushealth.com','remoteon2.pssuite.telushealth.com','443','Forticlient'),
(6,NULL,'golda.kai-oscar.com/oscar/',NULL,NULL,'Web browser'),
(7,NULL,'logmein.com',NULL,NULL,'LogmeIn'),
(8,NULL,'blew.kai-oscar.com/oscar/',NULL,NULL,'Web browser'),
(9,NULL,'avaros.ca',NULL,NULL,'Web browser'),
(10,NULL,'teluschm.ca',NULL,NULL,'Citrix-browser');

INSERT INTO tbl_Allied_Professional(all_first_name,all_last_name,all_type_id,all_emp_id,all_phone,all_email) 
VALUES('Sheryl','Werstuck',1,1,'289-555-6666','sheryl@gmail.com'),
('Saome','Abarca',1,1,'289-555-6666','salome@gmail.com'),
('Amy','Burke',1,1,'905-444-2345','amy@gmail.com'),
('Chloe','Bolus',1,1,'905-775-9045','chloe@gmail.com'),
('Sara','Doan',1,2,'289-246-0456','sara@gmail.com'),
('Shirley','Legault',1,2,'905-444-9876','shirley@gmail.com'),
('Paul','Sullivan',2,1,'289-222-7890','paul@gmail.com'),
('Laura','Page',2,1,'289-333-7777','laura@gmail.com'),
('Alicia','Elliott',2,1,'905-111-2222','alicia@gmail.com'),
('Julie','Bankes',2,1,'905-888-2398','julie@gmail.com'),
('Lindsay','Hart',3,1,'519-782-2244','lindsay@gmail.com'),
('Scott','Mallin',3,1,'647-127-7894','scott@gmail.com'),
('Jill','West',4,1,'289-999-3683','jill@gmail.com'),
('Steven','Pollock',5,1,'367-555-5465','steven@gmail.com'),
('Jeff','Sayes',5,1,'519-666-5688','jeff@gmail.com');

INSERT INTO tbl_Practice_Allied_Affiliation(aff_prc_id,aff_all_id,aff_start_date,aff_end_date) 
VALUES(1,1,'2020-01-20',NULL),
(1,7,'2021-06-18',NULL),
(1,11,'2020-01-20',NULL),
(1,13,'2020-10-12','2022-02-28'),
(1,14,'2021-06-20',NULL),
(2,12,'2018-09-27',NULL),
(2,15,'2018-09-27',NULL),
(3,1,'2021-04-15',NULL),
(3,5,'2021-05-08','2021-12-28'),
(3,10,'2022-03-10',NULL),
(4,3,'2022-01-20',NULL),
(5,7,'2022-01-20',NULL),
(6,5,'2022-01-20',NULL),
(7,11,'2022-01-20',NULL),
(7,14,'2022-01-20',NULL);

INSERT INTO tbl_Allied_Remote_Status(sta_aff_id,sta_rem_id,sta_emr_login,sta_comments,sta_last_update,sta_step1,sta_step2,sta_step3,sta_step4,sta_fiv_id) 
VALUES(1,2,1,'on vacations','2022-08-30',1,1,0,0,4),
(2,1,0,NULL,'2022-08-30',1,1,0,0,2),
(3,5,1,'oitc deleted account','2022-10-22',1,1,1,1,2),
(4,1,1,NULL,'2022-11-30',1,1,1,1,2),
(5,1,1,NULL,'2022-08-30',1,1,1,1,2),
(6,1,1,NULL,'2022-11-14',1,1,1,1,2),
(7,1,1,NULL,'2022-09-05',1,1,1,1,2),
(8,1,1,NULL,'2022-09-30',1,1,1,1,2),
(9,5,1,'oitc deleted account','2022-08-30',1,1,1,1,2),
(10,2,0,NULL,'2022-11-10',1,1,1,1,1),
(11,2,1,NULL,'2022-10-30',1,1,1,1,1),
(12,2,0,NULL,'2022-09-20',1,1,1,1,1),
(13,2,1,NULL,'2022-08-18',1,1,1,1,1),
(14,2,0,NULL,'2022-11-26',1,1,0,0,3),
(15,2,1,NULL,'2022-10-03',1,1,0,0,4);

SELECT * FROM tbl_Allied_Type;
SELECT * FROM tbl_Medical_Record;
SELECT * FROM tbl_Remote_Status;
SELECT * FROM tbl_stepfive;
SELECT * FROM tbl_Employment_Status;
SELECT * FROM tbl_ItCompany;
SELECT * FROM tbl_Practice;
SELECT * FROM tbl_Practice_Connection_Details;
SELECT * FROM tbl_Allied_Professional;
SELECT * FROM tbl_Practice_Allied_Affiliation;
SELECT * FROM tbl_Allied_Remote_Status;

-- MODIFY INSERTED DATA 
UPDATE tbl_Remote_Status SET rem_name ='Incompleted' WHERE rem_id = 6;

UPDATE tbl_Allied_Professional SET all_first_name ='Salome' WHERE all_id = 2;

DELETE FROM tbl_Employment_Status WHERE emp_id =3;

-- SCRIPTS
-- User #1: As an Allied Professional
-- List of all practices assigned to a specific Allied Professional, including the status and details of their remote access requests
SELECT prc_name AS 'Practice',emr.emr_name AS 'EMR',rem.rem_name AS 'Remote Status',sta.sta_emr_login AS 'Has a EMR Login?',sta.sta_comments AS 'Comments',sta.sta_last_update AS 'Last Update' 
FROM tbl_Practice AS prc
JOIN tbl_Medical_Record AS emr
ON emr.emr_id = prc.prc_emr_id 
JOIN tbl_Practice_Allied_Affiliation AS aff
ON prc.prc_id = aff.aff_prc_id
JOIN tbl_Allied_Professional AS al
ON al.all_id = aff.aff_all_id
JOIN tbl_Allied_Remote_Status AS sta
ON aff.aff_id = sta.sta_aff_id
JOIN tbl_Remote_Status AS rem
ON rem.rem_id = sta.sta_rem_id
JOIN tbl_Employment_Status AS emp
ON emp.emp_id = prc.prc_emp_id
WHERE al.all_id = 7 AND al.all_emp_id = 1
ORDER by emr.emr_name;

-- If the status shows as In prgress in the prior query, show the details of the process
SELECT prc_name AS 'Practice',emr.emr_name AS 'EMR',sta.sta_step1 AS 'Step1',sta.sta_step2 AS 'Step2',sta.sta_step3 AS 'Step3',sta.sta_step4 AS 'Step4',fiv.fiv_name AS 'Step5'
FROM tbl_Practice AS prc
JOIN tbl_Medical_Record AS emr
ON emr.emr_id = prc.prc_emr_id 
JOIN tbl_Practice_Allied_Affiliation AS aff
ON prc.prc_id = aff.aff_prc_id
JOIN tbl_Allied_Professional AS al
ON al.all_id = aff.aff_all_id
JOIN tbl_Allied_Remote_Status AS sta
ON aff.aff_id = sta.sta_aff_id
JOIN tbl_Remote_Status AS rem
ON rem.rem_id = sta.sta_rem_id
JOIN tbl_Employment_Status AS emp
ON emp.emp_id = prc.prc_emp_id
JOIN tbl_stepfive AS fiv
ON fiv.fiv_id = sta.sta_fiv_id
WHERE al.all_first_name LIKE '%aul' AND al.all_emp_id = 1 AND rem.rem_name = 'In Progress'
ORDER by emr.emr_name;

-- User #2: As a Program Coordinator
-- List of all Allied Professionals and the status of the remote connection to their practices's medical records by Program
SELECT typ.typ_name AS 'Allied Type', CONCAT(al.all_first_name,' ',al.all_last_name) AS 'Allied Fullname',prc_name AS 'Practice',rem.rem_name AS 'Remote Status',sta.sta_emr_login AS 'Has a EMR Login?'
FROM tbl_Practice AS prc
JOIN tbl_Medical_Record AS emr
ON emr.emr_id = prc.prc_emr_id 
JOIN tbl_Practice_Allied_Affiliation AS aff
ON prc.prc_id = aff.aff_prc_id
JOIN tbl_Allied_Professional AS al
ON al.all_id = aff.aff_all_id
JOIN tbl_Allied_Remote_Status AS sta
ON aff.aff_id = sta.sta_aff_id
JOIN tbl_Allied_Type AS typ
ON typ.typ_id = al.all_type_id
JOIN tbl_Remote_Status AS rem
ON rem.rem_id = sta.sta_rem_id
JOIN tbl_Employment_Status AS emp
ON emp.emp_id = prc.prc_emp_id
JOIN tbl_stepfive AS fiv
ON fiv.fiv_id = sta.sta_fiv_id
WHERE al.all_emp_id = 1
ORDER by typ.typ_name, al.all_last_name;

-- Same list as before and filtered by specific Program(s) 
SELECT typ.typ_name AS 'Allied Type', CONCAT(al.all_first_name,' ',al.all_last_name) AS 'Allied Fullname',prc_name AS 'Practice',rem.rem_name AS 'Remote Status',sta.sta_emr_login AS 'Has a EMR Login?'
FROM tbl_Practice AS prc
JOIN tbl_Medical_Record AS emr
ON emr.emr_id = prc.prc_emr_id 
JOIN tbl_Practice_Allied_Affiliation AS aff
ON prc.prc_id = aff.aff_prc_id
JOIN tbl_Allied_Professional AS al
ON al.all_id = aff.aff_all_id
JOIN tbl_Allied_Remote_Status AS sta
ON aff.aff_id = sta.sta_aff_id
JOIN tbl_Allied_Type AS typ
ON typ.typ_id = al.all_type_id
JOIN tbl_Remote_Status AS rem
ON rem.rem_id = sta.sta_rem_id
JOIN tbl_Employment_Status AS emp
ON emp.emp_id = prc.prc_emp_id
JOIN tbl_stepfive AS fiv
ON fiv.fiv_id = sta.sta_fiv_id
WHERE typ.typ_id IN (1,2) AND al.all_emp_id = 1
ORDER by typ.typ_name, al.all_last_name;

-- Show total number of active remote accesses by Allied Professional program
SELECT typ.typ_name AS 'Allied Type',COUNT(rem.rem_name) AS 'Total Active Remote Access'
FROM tbl_Practice AS prc
JOIN tbl_Medical_Record AS emr
ON emr.emr_id = prc.prc_emr_id 
JOIN tbl_Practice_Allied_Affiliation AS aff
ON prc.prc_id = aff.aff_prc_id
JOIN tbl_Allied_Professional AS al
ON al.all_id = aff.aff_all_id
JOIN tbl_Allied_Remote_Status AS sta
ON aff.aff_id = sta.sta_aff_id
JOIN tbl_Allied_Type AS typ
ON typ.typ_id = al.all_type_id
JOIN tbl_Remote_Status AS rem
ON rem.rem_id = sta.sta_rem_id
JOIN tbl_Employment_Status AS emp
ON emp.emp_id = prc.prc_emp_id
JOIN tbl_stepfive AS fiv
ON fiv.fiv_id = sta.sta_fiv_id
WHERE al.all_emp_id = 1 AND rem.rem_name = 'Yes'
GROUP BY typ.typ_name;

-- User #3: As an Admin
-- Show list of all remote access requests and detailed information of the progress
SELECT CONCAT(al.all_first_name,' ',al.all_last_name) AS 'Allied Fullname',typ.typ_name AS 'Allied Type',prc_name AS 'Practice',emr.emr_name AS 'EMR',rem.rem_name AS 'Remote Status',sta.sta_emr_login AS 'Has a EMR Login?',sta.sta_step1 AS 'Step1',sta.sta_step2 AS 'Step2',sta.sta_step3 AS 'Step3',sta.sta_step4 AS 'Step4',fiv.fiv_name AS 'Step5',sta.sta_comments AS 'Comments',sta.sta_last_update AS 'Last Update'
FROM tbl_Practice AS prc
JOIN tbl_Medical_Record AS emr
ON emr.emr_id = prc.prc_emr_id 
JOIN tbl_Practice_Allied_Affiliation AS aff
ON prc.prc_id = aff.aff_prc_id
JOIN tbl_Allied_Professional AS al
ON al.all_id = aff.aff_all_id
JOIN tbl_Allied_Remote_Status AS sta
ON aff.aff_id = sta.sta_aff_id
JOIN tbl_Allied_Type AS typ
ON typ.typ_id = al.all_type_id
JOIN tbl_Remote_Status AS rem
ON rem.rem_id = sta.sta_rem_id
JOIN tbl_Employment_Status AS emp
ON emp.emp_id = prc.prc_emp_id
JOIN tbl_stepfive AS fiv
ON fiv.fiv_id = sta.sta_fiv_id
WHERE al.all_emp_id = 1
ORDER by sta.sta_last_update DESC, al.all_last_name,emr.emr_name,typ.typ_name;

-- Show total number of active remote accesses by Medical Record type
SELECT emr.emr_name AS 'EMR',COUNT(rem.rem_name) AS 'Total Active Remote Access'
FROM tbl_Practice AS prc
JOIN tbl_Medical_Record AS emr
ON emr.emr_id = prc.prc_emr_id 
JOIN tbl_Practice_Allied_Affiliation AS aff
ON prc.prc_id = aff.aff_prc_id
JOIN tbl_Allied_Professional AS al
ON al.all_id = aff.aff_all_id
JOIN tbl_Allied_Remote_Status AS sta
ON aff.aff_id = sta.sta_aff_id
JOIN tbl_Allied_Type AS typ
ON typ.typ_id = al.all_type_id
JOIN tbl_Remote_Status AS rem
ON rem.rem_id = sta.sta_rem_id
JOIN tbl_Employment_Status AS emp
ON emp.emp_id = prc.prc_emp_id
JOIN tbl_stepfive AS fiv
ON fiv.fiv_id = sta.sta_fiv_id
WHERE al.all_emp_id = 1 AND rem.rem_name = 'Yes'
GROUP BY emr.emr_name;

-- Show contact information about the IT Companies of each Practice
SELECT prc_name AS 'Practice',emr.emr_name AS 'EMR', itc.itc_name AS 'IT Name', itc.itc_email AS 'IT Email', itc.itc_phone AS 'IT Phone', itc.itc_contact_name AS 'Contact Name'
FROM tbl_Practice AS prc
JOIN tbl_Medical_Record AS emr
ON emr.emr_id = prc.prc_emr_id 
JOIN tbl_Employment_Status AS emp
ON emp.emp_id = prc.prc_emp_id
JOIN tbl_ItCompany AS itc
ON itc.itc_id = prc.prc_itcompany_id
WHERE prc.prc_emp_id =1
ORDER BY prc.prc_name;

-- Show list of all practices and remote onnections details of each of one
SELECT prc_name AS 'Practice',emr.emr_name AS 'EMR', det.det_string AS 'DNS String/ URL', det.det_server AS 'Server Address', det.det_gateway AS 'Gateway', det.det_port AS 'Port Number', det.det_program AS 'Program', itc.itc_name AS 'IT Company'
FROM tbl_Practice AS prc
JOIN tbl_Medical_Record AS emr
ON emr.emr_id = prc.prc_emr_id 
JOIN tbl_Employment_Status AS emp
ON emp.emp_id = prc.prc_emp_id
JOIN tbl_ItCompany AS itc
ON itc.itc_id = prc.prc_itcompany_id
JOIN tbl_Practice_Connection_Details AS det
ON prc.prc_id = det.det_prc_id
WHERE prc.prc_emp_id =1
ORDER BY prc.prc_name;