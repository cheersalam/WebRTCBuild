echo on

set DEPOT_TOOLS_WIN_TOOLCHAIN=0

set _VSWHERE="%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
if exist %_VSWHERE% (
  for /f "usebackq tokens=*" %%i in (`%_VSWHERE% -version 15.0 -property installationPath`) do (
    set VSCOMNTOOLS2017=%%i\Common7\Tools
    goto :break
  )
)
:break

if DEFINED VSCOMNTOOLS2017 (
  call "%VSCOMNTOOLS2017%\..\..\VC\Auxiliary\Build\vcvarsall.bat" x86
  set LSMSVS=2017
) ELSE (
  IF DEFINED VS140COMNTOOLS (
    ECHO VS140COMNTOOLS IS defined
    call "%VS140COMNTOOLS%\..\..\VC\vcvarsall.bat" x86
    set CL=/D_USING_V140_SDK71_;%CL%
    set LSMSVS=2015
  ) ELSE (
    IF DEFINED VS120COMNTOOLS (
      ECHO VS120COMNTOOLS IS defined
      call "%VS120COMNTOOLS%\..\..\VC\vcvarsall.bat" x86
      set CL=/D_USING_V120_SDK71_;%CL%
      set LSMSVS=2013
    )
  )
)

set INCLUDE=%ProgramFiles(x86)%\Microsoft SDKs\Windows\7.1A\Include;%INCLUDE%
set PATH=%ProgramFiles(x86)%\Microsoft SDKs\Windows\7.1A\Bin;%PATH%
set LIB=%ProgramFiles(x86)%\Microsoft SDKs\Windows\7.1A\Lib;%LIB%

set LSBUILD=32
SET BUILD_ROOT_DIR=%~dp0
start cmd

