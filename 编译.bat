@echo off
set b=%cd%
echo "====正在编译,请稍等...===="
rd /s /Q %b%\car-main\target\car-main
md %b%\car-main\target\car-main
start /max %b%\car-main\target\car-main
mvn package -Dmaven.skip.test=true
echo "====编译结束===="
::cd %b%\car-main\target\car-main


pause