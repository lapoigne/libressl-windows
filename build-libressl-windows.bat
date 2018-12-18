@echo off

REM --- Change to use different CygWin platform and final install path
REM set CYGSETUP=setup-x86_64.exe
set CYGSETUP=setup-x86.exe
set TARGETPATH=.

set libresslver=libressl-2.8.3.tar.gz

set libressldir=%libresslver:.tar.gz=%

REM --- Fetch Cygwin setup from internet using powershell

PowerShell -Command "(New-Object Net.WebClient).DownloadFile('https://cygwin.com/%CYGSETUP%', '%CYGSETUP%')"
PowerShell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/%libresslver%', '%libresslver%')"

REM --- Install build version of CygWin in a subfolder

set OURPATH=%cd%
set CYGBUILD=%OURPATH%\CygWin
set CYGMIRROR=http://mirrors.kernel.org/sourceware/cygwin/
set BUILDPKGS=binutils,gcc-g++,make,mingw64-i686-gcc-core,zip,unzip

%CYGSETUP% -q -B -o -n -g -R %CYGBUILD% -L -D -l %OURPATH% -s %CYGMIRROR% -P %BUILDPKGS%
REM %CYGSETUP% -B -o -n -g -R %CYGBUILD% -L -D -l %OURPATH% -s %CYGMIRROR%

REM --- Build libressl

MOVE /Y %libresslver% %CYGBUILD%
COPY /Y build-libressl.sh %CYGBUILD%

cd %CYGBUILD%
bin\bash --login -c '/build-libressl.sh %libresslver%'
cd %OURPATH%

REM --- Copy built packages into release path
MOVE /Y %CYGBUILD%\%libressldir%.zip

goto :EOF

pause
exit