-- ******************************************************
-- 2015_fp.sql
--
-- Loader for Final Project Database
--
-- Description:	This script contains the DDL to load
--              the tables of the
--              In-A-Fix database
--
-- There are 7 tables on this DB
--
--
-- Student:  David Glauner
--
-- Date:   December, 2015
--
-- ******************************************************

-- ******************************************************
--    SPOOL SESSION
-- ******************************************************

spool 2015_fp.lst


-- ******************************************************
--    DROP Triggers
-- ******************************************************
Drop Trigger user_id_col;
Drop Trigger cust_id_col;

-- ******************************************************
--    DROP Stored Procedures
-- ******************************************************
Drop Procedure totalcost;

-- ******************************************************
--    DROP SEQUENCES
-- ******************************************************
DROP sequence seq_User_Id;
DROP sequence seq_cust_id;

-- ******************************************************
--    DROP TABLES
-- ******************************************************
Drop table fpCustomer CASCADE CONSTRAINTS PURGE;
Drop table fpJob CASCADE CONSTRAINTS PURGE;
Drop table fpAppliance CASCADE CONSTRAINTS PURGE;
Drop table fpTechnician CASCADE CONSTRAINTS PURGE;
Drop table fpSpecialty CASCADE CONSTRAINTS PURGE;
Drop table fpJob_Line CASCADE CONSTRAINTS PURGE;
Drop table fpUser CASCADE CONSTRAINTS PURGE;

-- ******************************************************
--    Create SEQUENCES
-- ******************************************************
CREATE SEQUENCE seq_User_Id;
CREATE SEQUENCE seq_cust_id;

-- ******************************************************
--    CREATE TABLES
-- ******************************************************
CREATE table fpUser  (
		user_id		number (11,0)	not null,
		user_number	varchar2(10)    not null,
		user_pass   varchar2(10)    not null,
		user_fname  varchar2(25)    not null,
		user_lname  varchar2(25)    not null,
		CONSTRAINT User_user_number_unique UNIQUE (user_number),
		CONSTRAINT User_pk PRIMARY KEY (user_id)
);

CREATE table fpCustomer	(
		cust_id		number (11,0)	not null,
		cust_number varchar2(25)    not null,
		cust_fname  varchar2(25)    not null,
		cust_lname  varchar2(25)    not null,
		cust_addr   varchar2(100)   not null,
		cust_city	varchar2(25)	not null,
		cust_state 	varchar2(25)	not null,
		cust_zip 	char    (5)		not null,
		cust_phone	varchar2(25)	not null,
		CONSTRAINT Customer_cust_number_unique UNIQUE (cust_number),
		CONSTRAINT Customer_pk PRIMARY KEY (cust_id)
);

CREATE table fpJob	(
		job_id 			number (11,0)	GENERATED ALWAYS AS IDENTITY not null,
		cust_id			number (11,0)   not null,
		job_desc 		varchar2(255)	null,
		job_date 		date			not null,
		job_completed	number(1)		DEFAULT 0 NOT NULL,
		job_invoice_sent number(1)		DEFAULT 0 NOT NULL,
		job_invoice_paid number(1)		DEFAULT 0 NOT NULL,
		CONSTRAINT Job_pk PRIMARY KEY (job_id, cust_id),
		CONSTRAINT Job_job_id_unique UNIQUE (job_id),
		CONSTRAINT Job_cust_id_fk 
			FOREIGN KEY (cust_id)
			REFERENCES fpCustomer(cust_id)
			ON DELETE CASCADE,
		CONSTRAINT Invoice_Req
			CHECK ((job_invoice_sent!=0 AND job_completed!=0)
					OR 
					(job_invoice_sent=0 AND job_completed!=0)
					OR
					(job_invoice_sent=0 AND job_completed=0)),
		CONSTRAINT	Invoice_Paid_Req 
			CHECK ((job_invoice_paid!=0 AND job_invoice_sent!=0)
					OR 
				   (job_invoice_paid=0 AND job_invoice_sent!=0)
					OR
				   (job_invoice_paid=0 AND job_invoice_sent=0))				
);

CREATE table fpAppliance (
		appl_id number (11,0)	GENERATED ALWAYS AS IDENTITY not null,
		appl_desc varchar2(100)   not null,
		CONSTRAINT Appliance_pk PRIMARY KEY (appl_id)
);

CREATE table fpTechnician (
		tech_id number (11,0)	GENERATED ALWAYS AS IDENTITY not null,
		tech_name varchar2(100)   not null,
		CONSTRAINT Technician_pk PRIMARY KEY (tech_id)
);

CREATE table fpSpecialty (
		tech_id number (11,0)   not null,
		appl_id number (11,0)   not null,
		CONSTRAINT Specialty_pk PRIMARY KEY (tech_id, appl_id),
		CONSTRAINT Specialty_appl_id_fk 
			FOREIGN KEY (appl_id)
			REFERENCES fpAppliance(appl_id)
			ON DELETE CASCADE,
		CONSTRAINT Specialty_tech_id_fk 
			FOREIGN KEY (tech_id)
			REFERENCES fpTechnician(tech_id)	
			ON DELETE CASCADE
);

CREATE table fpJob_Line (
		job_id number (11,0)   		not null,
		line_id number (11,0)   	GENERATED ALWAYS AS IDENTITY not null,
		tech_id number (11,0)   	null,
		appl_id number (11,0)   	null,
		line_desc varchar2(100) 	not null,
		line_estimate number(12,2) 	not null,
		line_actual number(12,2) 	null,
		line_notes varchar2(100) 	null,
		CONSTRAINT Job_Line_pk PRIMARY KEY (job_id, line_id),
		CONSTRAINT Job_Line_Line_id_unique UNIQUE (line_id),
		CONSTRAINT Job_Line_appl_tech_fk 
			FOREIGN KEY (appl_id, tech_id)
			REFERENCES fpSpecialty(appl_id, tech_id)
			ON DELETE SET NULL,
		CONSTRAINT Job_Line_job_id_fk 
			FOREIGN KEY (job_id)
			REFERENCES fpJob(job_id)
			ON DELETE CASCADE
);

-- ******************************************************
--    CREATE TRIGGERS
-- ******************************************************
CREATE TRIGGER user_id_col 
BEFORE INSERT ON fpUser 
FOR EACH ROW

BEGIN
  SELECT seq_user_Id.NEXTVAL
  INTO   :new.user_id
  FROM   dual;
END;
/

CREATE TRIGGER cust_id_col 
BEFORE INSERT ON fpCustomer 
FOR EACH ROW

BEGIN
  SELECT seq_cust_id.NEXTVAL
  INTO   :new.cust_id
  FROM   dual;
END;
/

-- ******************************************************
--    Create Stored Procedures
-- ******************************************************
create or replace PROCEDURE totalcost (jobid in number, totalcost out number) 
Is
BEGIN 
select sum(decode(LINE_ACTUAL, null, LINE_ESTIMATE, LINE_ACTUAL)) into totalcost
		from FPJOB_LINE
		where JOB_ID = jobid
		group by JOB_ID;
END;
/
 
-- ******************************************************
--    POPULATE TABLES
-- ******************************************************
/*  fpCustomer */
INSERT into fpCustomer ( cust_number, cust_fname, cust_lname, cust_addr, cust_city, cust_state, cust_zip, cust_phone)
Values ( 'A123','Fred', 'Smith', '1 Main St.', 'Cambridge', 'MA', '05115', '617-212-1515');
INSERT into fpCustomer ( cust_number, cust_fname, cust_lname, cust_addr, cust_city, cust_state, cust_zip, cust_phone)
Values ( 'A124','Jane', 'Mathers', '53 Main St', 'Boston', 'MA', '09875', '617-555-1515');
INSERT into fpCustomer ( cust_number, cust_fname, cust_lname, cust_addr, cust_city, cust_state, cust_zip, cust_phone)
Values ( 'A125', 'James', 'Potter', '26 Evergreen St', 'Boston', 'MA', '01569', '617-987-2323');

/* fpJob */
INSERT into fpJob (cust_id, job_desc, job_date)
VALUES (1, 'Fix Dishwasher ' || chr(38) || ' Stove', TO_DATE('01/25/2015', 'mm/dd/yyyy'));  
INSERT into fpJob (cust_id, job_desc, job_date)
VALUES (2, 'Fix Refrigerator ' || chr(38) || ' Stove', TO_DATE('11/12/2015', 'mm/dd/yyyy'));
INSERT into fpJob (cust_id, job_desc, job_date)
VALUES (3, 'Fix Stove', TO_DATE('12/01/2015', 'mm/dd/yyyy'));

/* fpAppliance */
INSERT into fpAppliance (appl_desc)
VALUES ('Dishwasher');
INSERT into fpAppliance (appl_desc)
VALUES ('Refrigerator');
INSERT into fpAppliance (appl_desc)
VALUES ('Stove');
INSERT into fpAppliance (appl_desc)
VALUES ('Garbage Disposal');

/* fpTechnician */
INSERT into fpTechnician (tech_name)
VALUES ('James Smith');
INSERT into fpTechnician (tech_name)
VALUES ('Dave Jones');
INSERT into fpTechnician (tech_name)
VALUES ('Sally Sunderson');

/* fpSpecialty */
INSERT into fpSpecialty (tech_id, appl_id)
VALUES (1, 1); 
INSERT into fpSpecialty (tech_id, appl_id)
VALUES (2, 2); 
INSERT into fpSpecialty (tech_id, appl_id)
VALUES (3, 1); 
INSERT into fpSpecialty (tech_id, appl_id)
VALUES (1, 3); 

/* fpJob_Line */
INSERT into fpJob_Line (job_id, tech_id, appl_id, line_desc, line_estimate, line_actual, line_notes)
VALUES (1, 1, 1, 'Fix Bosch Dishwasher', 200, 300, 'Extra parts needed');
INSERT into fpJob_Line (job_id, tech_id, appl_id, line_desc, line_estimate, line_actual, line_notes)
VALUES (1 ,1, 3, 'Fix jenn-air Range', 100, 100, '');
INSERT into fpJob_Line (job_id, tech_id, appl_id, line_desc, line_estimate, line_actual, line_notes)
VALUES (3, 1, 3, 'Fix Kenmore Range', 150, 200, 'Longer then average repair time');

/* fpUser */
INSERT into fpUser (user_number, user_fname, user_lname, user_pass)
VALUES ('A320', 'Fred', 'Jameson', 'password1');
INSERT into fpUser (user_number, user_fname, user_lname, user_pass)
VALUES ('A355', 'Jane', 'Certson', 'password1');
 INSERT into fpUser (user_number, user_fname, user_lname, user_pass)
VALUES ('B620', 'Todd', 'Johnstone', 'password1'); 
  
-- ******************************************************
--    VIEW TABLES
-- ******************************************************

Commit;

SELECT * FROM fpCustomer;
SELECT * FROM fpJob;
SELECT * FROM fpAppliance;
SELECT * FROM fpTechnician;
SELECT * FROM fpSpecialty;
SELECT * FROM fpJob_Line;
SELECT * FROM fpUser;

spool off

