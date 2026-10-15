use master 
go
declare @fecha char(50)
select @fecha = 'PLUNION_'+convert(varchar(1),datepart(dw, getdate()))+'.BAK'
select @fecha = "C:\respaldos\" + @fecha

BACKUP DATABASE NOMINA TO DISK = @fecha

go

use master 
go



