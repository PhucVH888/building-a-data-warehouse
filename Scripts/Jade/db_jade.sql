use master
go

if db_id ('Jade') is not null
drop database Jade;
go

create database Jade 
on primary (name = 'Jade_fg1'
, filename = 'd:\disk\source1\Jade_fg1.mdf'
, size = 2 MB, filegrowth = 512 MB)
log on (name = 'Jade_log'
, filename = 'd:\disk\source1\Jade_log.ldf'
, size = 128 MB, filegrowth = 128 KB)
collate SQL_Latin1_General_CP1_CI_AS
go

if exists 
(select * from syslogins
 where name = 'ETL')
drop login ETL
go
create login ETL with password = 'ETL', check_policy = OFF, default_database = stage
go
sp_addsrvrolemember 'ETL', 'bulkadmin'
go
use Jade
go
create user ETL for login ETL
go
sp_addrolemember 'db_owner', 'ETL'
go
use Stage
go
create user ETL for login ETL
go
sp_addrolemember 'db_owner', 'ETL'
go
use Meta
go
create user ETL for login ETL
go
sp_addrolemember 'db_owner', 'ETL'
go