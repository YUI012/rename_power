@echo off
powershell -executionpolicy RemoteSigned -File ".\%~n0.ps1"
pause