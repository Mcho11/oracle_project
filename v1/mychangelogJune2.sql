-- liquibase formatted sql

--changeset SteveZ:45555-createTable_TABLE200 context:"UAT,QA,SIT" labels:Jira-166,feature1
CREATE TABLE TABLE200
 (
   JOB_ID VARCHAR2(10 BYTE) NOT NULL,
   MIN_SALARY NUMBER(6, 0),
   MAX_SALARY NUMBER(6, 0),
   CONSTRAINT JOB_ID_PK200 PRIMARY KEY (JOB_ID)
 )
;
--rollback drop table TABLE200
--changeset SteveZ:45555-createTable_EMPLOYEES context:"UAT,QA,SIT" labels:Jira-166,feature1
CREATE TABLE EMPLOYEES
(	
  EMPLOYEE_ID NUMBER(6,0) NOT NULL ENABLE, 
	FIRST_NAME VARCHAR2(20), 
	LAST_NAME VARCHAR2(25) CONSTRAINT "EMP_LAST_NAME_NN" NOT NULL ENABLE, 
	EMAIL VARCHAR2(25) CONSTRAINT "EMP_EMAIL_NN" NOT NULL ENABLE, 
	PHONE_NUMBER VARCHAR2(20), 
	HIRE_DATE DATE CONSTRAINT "EMP_HIRE_DATE_NN" NOT NULL ENABLE, 
	JOB_ID VARCHAR2(10) CONSTRAINT "EMP_JOB_NN" NOT NULL ENABLE, 
	SALARY NUMBER(8,2), 
	COMMISSION_PCT NUMBER(2,2), 
	MANAGER_ID NUMBER(6,0), 
	DEPARTMENT_ID NUMBER(4,0), 
	CONSTRAINT EMP_EMP_ID_PK PRIMARY KEY ("EMPLOYEE_ID"))
   ;
--rollback DROP TABLE EMPLOYEES

--changeset TsviZ:create_TABLE_categories runwith:sqlplus 
CREATE TABLE categories
( category_id int NOT NULL,
  category_name char(50) NOT NULL,
  CONSTRAINT categories_pk PRIMARY KEY (category_id)
);
quit;
--rollback drop TABLE categories;
--changeset TsviZ:insert_INTO_categories runwith:sqlplus
INSERT INTO categories
(category_id, category_name)
VALUES
(150, 'Miscellaneous');
quit;
--rollback delete from categories where category_id=150;
--changeset TsviZ:select_from_categories runwith:sqlplus runOnChange:true
set lines 256
set trimout on
set tab off
set pagesize 100
set trimspool on
spool categories.csv
SELECT * FROM categories;
quit;
--rollback select * from categories;
--changeset TsviZ:createtrigger runwith:sqlplus runOnChange:true
CREATE TABLE trigger_test (
  id           NUMBER         NOT NULL,
  description  VARCHAR2(50)   NOT NULL
);
CREATE OR REPLACE PACKAGE trigger_test_api AS
TYPE t_tab IS TABLE OF VARCHAR2(50);
g_tab t_tab := t_tab();
  END trigger_test_api;
/

CREATE OR REPLACE TRIGGER trigger_test_as_trg
AFTER INSERT OR UPDATE OR DELETE ON trigger_test
BEGIN
  trigger_test_api.g_tab.extend;
  CASE
    WHEN INSERTING THEN
      trigger_test_api.g_tab(trigger_test_api.g_tab.last) := 'AFTER STATEMENT - INSERT';
    WHEN UPDATING THEN
      trigger_test_api.g_tab(trigger_test_api.g_tab.last) := 'AFTER STATEMENT - UPDATE';
    WHEN DELETING THEN
      trigger_test_api.g_tab(trigger_test_api.g_tab.last) := 'AFTER STATEMENT - DELETE';
  END CASE;
  FOR i IN trigger_test_api.g_tab.first .. trigger_test_api.g_tab.last LOOP
    DBMS_OUTPUT.put_line(trigger_test_api.g_tab(i));
  END LOOP;
  trigger_test_api.g_tab.delete;
END trigger_test_as_trg;
/
quit;

