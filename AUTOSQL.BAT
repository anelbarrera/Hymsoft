echo off
echo Haciendo el Respaldo de la Base de Datos
sqlcmd -Usa -P306Hawk001 -SUNION-SRV\UNIONZL -i"C:\Backup\respaldosql.sql"
echo Copiando a Backups
copy  C:\Respaldos\PLUNION_*.*   C:\Backup\ /Y
echo Copiando a Dropbox
copy  C:\Respaldos\PLUNION_*.*   Y:\ /Y
echo Eliminando Backup
del /Q C:\Respaldos\PLUNION_*.*


