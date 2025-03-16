@echo off
setlocal enabledelayedexpansion

REM change this
set "dir=%~dp0"
set "input_dir=%dir%input"
set "output_dir=%dir%output"
set "filetype=mp4"

REM Change to the specified directory
cd /d "%input_dir%"

REM Loop over .mkv files in the directory
for %%F in (*.%filetype%) do (
    REM Get the name of the file without the extension
    set "filename=%%~nF"
	
    REM Print the filename
    echo !filename!
	
	REM burn-in the subtitle (external)
	ffmpeg -v error -stats -i "!filename!.!filetype!" -c:v libx264 -c:a aac "!output_dir!\!filename!.mp4"
)

endlocal
pause