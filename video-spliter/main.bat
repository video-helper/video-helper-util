@echo off
REM This is a batch file to call your main program with parameters my.mp4 and time.txt

REM Define your parameters
SET video_file=my.mp4
SET time_file=time.txt

REM Call your main program with the parameters
REM Assuming your main program is a script or executable (e.g., my_program.exe)
REM Replace 'my_program.exe' with the actual program you want to call

cut.bat %video_file% %time_file%

REM End of batch file
echo Process completed!
pause

