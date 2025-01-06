@echo off
cls

:: Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python is not installed. Installing Python...
    
    :: Download Python installer
    set "PYTHON_INSTALLER=python-3.10.0-amd64.exe"  :: Change this to the desired version
    set "PYTHON_URL=https://www.python.org/ftp/python/3.10.0/%PYTHON_INSTALLER%"
    
    :: Download the installer
    powershell -Command "Invoke-WebRequest -Uri %PYTHON_URL% -OutFile %PYTHON_INSTALLER%"
    
    :: Install Python silently and add to PATH
    start /wait %PYTHON_INSTALLER% /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
    
    if %errorlevel% neq 0 (
        echo There was an error installing Python. Exiting...
        pause
        exit /b %errorlevel%
    )
    
    echo Python installed successfully.
) else (
    echo Python is already installed.
)

cls
echo Installing requirements...
pip install --quiet -r requirements.txt

if %errorlevel% neq 0 (
    echo There was an error installing the requirements. Exiting...
    pause
    exit /b %errorlevel%
)

cls
echo Requirements installed successfully.
echo Starting react.py...
python react.py

pause