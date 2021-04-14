@ECHO OFF
set /p target="Where are your hashes? "
set /p list="Which wordlist would you like to use?(No ext. PATH to set an alternate path) "
if %list% == "PATH" (
	set /p listpath="Your Path: "
) else (
	set listpath=C:\Users\%USERNAME%\Documents\hashcat-6.1.1\Wordlists\%list%.txt
)
ECHO Wordlist: %listpath%
set /p mode="And your mode? "
set /p frd="Finally; Recursive?(1) or Folder?(2)"

echo I will iterate through %target%  and run each file against %list% using the mode: %mode%

timeout /t 5

CD C:\Users\%USERNAME%\Documents\hashcat-6.1.1

if %frd% EQU 1 (CALL :recursive
	) else (CALL :single)

:recursive

ECHO Recursive Mode

timeout /t 5

REM This is recursive

FOR /R %target% %%G IN (*.*) DO (
	ECHO "Now Hashing: %%G"
	timeout /t 5 /nobreak
	@ECHO ON
	hashcat -m %mode% %%G %listpath%
	@ECHO OFF
	timeout /t 60
	)

:single

ECHO Single Folder Mode:

timeout /t 5

REM This is single folder

FOR %%G IN (%target%\*) DO (
	ECHO "Now Hashing: %%G"
	timeout /t 5 /nobreak
	@ECHO ON
	hashcat -m %mode% %%G %listpath%
	@ECHO OFF
	timeout /t 60
	)

cmd /k