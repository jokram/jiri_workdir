@REM Do not use "echo off" to not affect any child calls.

@REM Enable extensions, the `verify` call is a trick from the setlocal help
@VERIFY other 2>nul
@SETLOCAL EnableDelayedExpansion
@IF ERRORLEVEL 1 (
    @ECHO Unable to enable extensions
    @GOTO end
)

@REM Set the Windows TEMP and TMP environment variables to the local tmp directory
@SET TMP=%~dp0\tmp
@SET TEMP=%TMP%

@REM Search the git-bash.exe to start the git bash
@FOR %%i IN ("git.exe") DO @SET GIT=%%~$PATH:i
@IF EXIST "%GIT%" @(
    @REM Get the git-bash executable
    @FOR %%i IN ("git-bash.exe") DO @SET GIT_BASH=%%~$PATH:i
    @IF NOT EXIST "%GIT_BASH%" @(
        @FOR %%s IN ("%GIT%") DO @SET GIT_DIR=%%~dps
        @FOR %%s IN ("!GIT_DIR!") DO @SET GIT_DIR=!GIT_DIR:~0,-1!
        @FOR %%s IN ("!GIT_DIR!") DO @SET GIT_ROOT=%%~dps
        @FOR %%s IN ("!GIT_ROOT!") DO @SET GIT_ROOT=!GIT_ROOT:~0,-1!
        @FOR /D %%s in ("!GIT_ROOT!\git-bash.exe") DO @SET GIT_BASH=%%~s
        @IF NOT EXIST "!GIT_BASH!" (
            @ECHO Can't find git-bash.exe
            @GOTO end
        )
    )
    @ECHO Starting "!GIT_BASH!"
    @"!GIT_BASH!"
)

:end
@ENDLOCAL



