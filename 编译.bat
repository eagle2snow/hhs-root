@echo off
set b=%cd%
echo "====���ڱ���,���Ե�...===="
rd /s /Q %b%\car-main\target\car-main
md %b%\car-main\target\car-main
start /max %b%\car-main\target\car-main
mvn package -Dmaven.skip.test=true
echo "====�������===="
::cd %b%\car-main\target\car-main


pause