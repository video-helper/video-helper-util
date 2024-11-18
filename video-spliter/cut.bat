@echo off
setlocal


@echo off
setlocal enabledelayedexpansion

:: Set some test variables
set "cutTime=00:01:30"
set "outputFile=test_00:01:30.mp4"

:: Print values with delayed expansion
echo cutTime: !cutTime!
echo outputFile: !outputFile!


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






:: Loop through each line in the cut times file
for /f "usebackq tokens=*" %%a in ("%cutTimesFile%") do (
    set "cutTime=%%a"
    set "outputFile=short_%%a.mp4"

    :: Debug: Print variables inside the loop to see their value
    echo In loop - cutTime: !cutTime!
    echo In loop - outputFile: !outputFile!

    :: Adjust FFmpeg command as needed
    :: ffmpeg -i "%videoFile%" -ss !cutTime! -t 00:02 -vf "crop=in_w/2:in_h,scale=1080:1920" -c:a copy "!outputFile!"
)


:: Loop through each line in cut times file
for /f "usebackq tokens=*" %%a in ("%cutTimesFile%") do (
    set "cutTime=%%a"
    set "outputFile=short_%%a.mp4"

    :: Replace colon (:) with underscore (_)
    set "outputFile=!outputFile::=_!"

    :: Debug: Print variables inside the loop to see their value
    echo In loop - cutTime: !cutTime!
    echo In loop - outputFile: !outputFile!
	



    echo Creating short for time %%a
	echo "%outputFile%"
	

    :: Adjust FFmpeg command as needed
    ffmpeg -i "%videoFile%" -ss %%a -t 00:02 -vf "crop=in_w/2:in_h,scale=1080:1920" -c:a copy !outputFile!
)

echo All shorts created.
endlocal
