/*table creation*/
CREATE TABLE TRAIN_DETAILS (TRAIN_DETAILS_ID INT PRIMARY KEY,
TRAIN_NAMEID INT FOREIGN KEY(TRAIN_NAMEID) REFERENCES TRAIN_TABLE(TRAIN_ID),
ORGIN_ID INT FOREIGN KEY(ORGIN_ID) REFERENCES PLACE(PLACE_ID),
DESTINATION_ID INT FOREIGN KEY(DESTINATION_ID) REFERENCES PLACE(PLACE_ID),
ARRIVAL_DATEID INT  FOREIGN KEY(ARRIVAL_DATEID) REFERENCES time_table(DATE_ID ),
DEPARTURE_DATEID INT  FOREIGN KEY(DEPARTURE_DATEID ) REFERENCES time_table(DATE_ID ),
JOURNEY_CLASSID INT NOT NULL FOREIGN KEY(JOURNEY_CLASSID) REFERENCES class_table(journey_id ),
CREATED_BY VARCHAR(50) NOT NULL DEFAULT 'ADMIN',
CREATED_DATE DATETIME NOT NULL DEFAULT GETDATE(),
MODIFIED_BY VARCHAR(50) NOT NULL DEFAULT 'ADMIN',
MODIFIED_DATE DATETIME NOT NULL DEFAULT GETDATE(),
RECORD_STATUS BIT DEFAULT 1,
ROWGUID VARCHAR(MAX) DEFAULT NEWID());

/* stored procedure insert,update -TRAIN_DETAILS  TABLE*/
ALTER PROCEDURE SP_TRAIN_DETAILS	     
										    
											(@TRAIN_DETAILS_ID INT,
											@TRAIN_NAMEID INT,
                                            @ORGIN_ID INT,
											@DESTINATION_ID INT,
											@ARRIVAL_DATEID INT,
											@DEPARTURE_DATEID INT,
											@JOURNEY_CLASSID INT ,
											@STATEMENTTYPE NVARCHAR(20) = '')
AS
  BEGIN
      IF @STATEMENTTYPE = 'Insert'
        BEGIN
            INSERT INTO TRAIN_DETAILS
									
									(TRAIN_DETAILS_ID,
									TRAIN_NAMEID,
                                     ORGIN_ID,
									 DESTINATION_ID ,
									 ARRIVAL_DATEID ,
									 DEPARTURE_DATEID ,
									 JOURNEY_CLASSID)

            VALUES				
								(
								@TRAIN_DETAILS_ID,
								@TRAIN_NAMEID,
                                @ORGIN_ID,
								@DESTINATION_ID ,
								@ARRIVAL_DATEID ,
								@DEPARTURE_DATEID  ,
								@JOURNEY_CLASSID)
        END
		IF @STATEMENTTYPE= 'Update'
        BEGIN
            UPDATE TRAIN_DETAILS
           
		   SET    
				   TRAIN_NAMEID=@TRAIN_NAMEID,
                   ORGIN_ID=@ORGIN_ID,
				   DESTINATION_ID=@DESTINATION_ID ,
				   ARRIVAL_DATEID=@ARRIVAL_DATEID ,
				   DEPARTURE_DATEID=@DEPARTURE_DATEID  ,
				   JOURNEY_CLASSID=@JOURNEY_CLASSID 
            WHERE  TRAIN_DETAILS_ID = @TRAIN_DETAILS_ID
        END
END

/*exec of insert*/
exec SP_TRAIN_DETAILS 1,1,1,2,10,20,111,'Insert';

exec SP_TRAIN_DETAILS 2,2,2,3,20,30,222,'Insert';

exec SP_TRAIN_DETAILS 3,3,3,1,30,10,333,'Insert';



/*exec of UPDATE*/
exec SP_TRAIN_DETAILS 1,2,3,1,30,10,333,'UPDATE';

exec SP_TRAIN_DETAILS 2,1,2,10,20,111,'UPDATE';

/* SP select  all*/
ALTER procedure sp_train_details_select
as
        BEGIN
           select * from Train_details; 
        END

/*exec of SELECT*/

exec sp_train_details_select

/* SP select active */
CREATE procedure sp_train_details_select_active
as
        BEGIN
           select * from Train_details where record_status=1; 
        END

/*exec of SELECT active*/

exec sp_train_details_select_active

/* SP select deactive*/
CREATE procedure sp_train_details_select_deactive
as
        BEGIN
           select * from Train_details where record_status=0; 
        END

/*exec of SELECT deactive*/

exec sp_train_details_select_deactive

/* SP DELETE*/
CREATE procedure sp_train_detail_delete
@TRAIN_DETAILS_ID int
as
 BEGIN
            UPDATE TRAIN_DETAILS
           
		   SET    RECORD_STATUS=0
            WHERE  TRAIN_DETAILS_ID = @TRAIN_DETAILS_ID
END

/*exec delete*/
exec sp_train_detail_delete 3





/*master table*/ 

/*master table TRAIN TABLE*/ 

create table TRAIN_TABLE(TRAIN_id int primary key,TRAIN_name varchar(50) not null ,
createdBy varchar(50) not null default 'admin',
createdDate datetime not null default getDate(),
modifiedBy varchar(50) not null default 'admin',
modifiedDate datetime not null default getDate(),
RecordStatus bit default 1,
RowGUID varchar(max) default newid())

/*INSERT FOR TRAIN_TABLE*/
insert into train_table (TRAIN_id,TRAIN_NAME) values(1,'CHENNAIEXPRESS')

insert into train_table (TRAIN_id,TRAIN_NAME) values(1,'CHENNAIEXPRESS')

insert into train_table (TRAIN_id,TRAIN_NAME) values(1,'CHENNAIEXPRESS')


SELECT * FROM TRAIN_TABLE


/*master table TIMETABLE*/ 

CREATE TABLE time_table(DATE_ID INT PRIMARY KEY,
ARRIVAL_DATE varchar(50) NOT NULL ,
DEPARTURE_DATE varchar(50) NOT NULL,
CREATED_BY VARCHAR(50) NOT NULL DEFAULT 'ADMIN',
CREATED_DATE DATETIME NOT NULL DEFAULT GETDATE(),
MODIFIED_BY VARCHAR(50) NOT NULL DEFAULT 'ADMIN',
MODIFIED_DATE DATETIME NOT NULL DEFAULT GETDATE(),
RECORD_STATUS BIT DEFAULT 1,
ROWGUID VARCHAR(MAX) DEFAULT NEWID());

/*INSERT FOR TIME_TABLE*/

insert into time_table (date_id,arrival_date,departure_date) values(10,'11/09/2021','12/09/2021')
insert into time_table (date_id,arrival_date,departure_date) values(20,'13/09/2021','14/09/2021')
insert into time_table (date_id,arrival_date,departure_date) values(30,'15/09/2021','16/09/2021')

SELECT * FROM TIME_TABLE


/*master table CLASS_TABLE*/ 

create table class_table(journey_id int primary key,journey_class varchar(50) not null, quota varchar(50),
createdBy varchar(50) not null default 'admin',
createdDate datetime not null default getDate(),
modifiedBy varchar(50) not null default 'admin',
modifiedDate datetime not null default getDate(),
RecordStatus bit default 1,
RowGUID varchar(max) default newid())


SELECT * FROM CLASS_TABLE


/*INSERT FOR CLASS_TABLE*/

insert into class_table (journey_id,journey_class,quota) values(111,'AC 1SLEEPER','TATKAL')
insert into class_table (journey_id,journey_class,quota) values(222,'AC 2SLEEPER','TATKAL')
insert into class_table (journey_id,journey_class,quota) values(333,'AC 3SLEEPER','TATKAL')

/*master table PLACE TABLE*/ 


create table place(place_id int primary key,place_name varchar(20) not null unique,
createdBy varchar(50) not null default 'admin',
createdDate datetime not null default getDate(),
modifiedBy varchar(50) not null default 'admin',
modifiedDate datetime not null default getDate(),
RecordStatus bit default 1,
RowGUID varchar(max) default newid())


SELECT * FROM PLACE

/*INSERT FOR PLACE*/

insert into class_table (journey_id,journey_class,quota) values(1,'CHENNAI','MUMBAI')
insert into class_table (journey_id,journey_class,quota) values(2,'MUMBAI','CHENNAI')
insert into class_table (journey_id,journey_class,quota) values(3,'BANGALORE','PUNE')
