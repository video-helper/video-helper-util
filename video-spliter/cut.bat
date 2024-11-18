@echo off
setlocal EnableDelayedExpansion

:: Check input arguments
if "%~1"=="" (
    echo Please provide the video file name.
    exit /b
)
if "%~2"=="" (
    echo Please provide the cut times file.
    exit /b
)

set "videoFile=%~1"
set "cutTimesFile=%~2"

:: Verify the video file exists
if not exist "%videoFile%" (
    echo Video file not found: %videoFile%
    exit /b
)

:: Verify the cut times file exists
if not exist "%cutTimesFile%" (
    echo Cut times file not found: %cutTimesFile%
    exit /b
)

:: Initialize previous time variable
set "prevTime="

:: Loop through each line in cut times file
for /f "usebackq tokens=*" %%a in ("%cutTimesFile%") do (
    set "currentTime=%%a"
	
	 set "cutTime=%%a"
    set "outputFile=short_%%a.mp4"

    :: Replace colon (:) with underscore (_)
    set "outputFile=!outputFile::=_!"

    :: Debug: Print variables inside the loop to see their value
    echo In loop - cutTime: !cutTime!
    echo In loop - outputFile: !outputFile!
	



    echo Creating short for time %%a
	echo "!outputFile!"
	
	
    
    :: If this is not the first line, calculate the duration and cut the video
    if defined prevTime (
        :: Convert prevTime and currentTime to seconds for duration calculation
        for /f "tokens=1,2 delims=:" %%i in ("!prevTime!") do set /a "prevSec=%%i*60 + %%j"
        for /f "tokens=1,2 delims=:" %%i in ("!currentTime!") do set /a "currSec=%%i*60 + %%j"
        
        set /a duration=currSec - prevSec

        set "safePrevTime=!prevTime::=_!"  
        set "outputFile=short_!safePrevTime!.mp4"  

        echo Creating short from !prevTime! to !currentTime! with duration !duration! seconds...  !outputFile!
		echo short   !outputFile!
		

        :: Run FFmpeg command with calculated duration
        ffmpeg -i "%videoFile%" -ss !prevTime! -t !duration! -vf "crop=in_w/2:in_h,scale=1080:1920" -c:a copy "!outputFile!"
    )

    :: Update prevTime to currentTime for the next iteration
    set "prevTime=!currentTime!"
)

echo All shorts created.
endlocal
