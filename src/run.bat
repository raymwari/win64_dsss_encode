@echo off
if exist main.exe (del main.exe)
nasm -f win64 main.asm
nasm -f win64 ecodes.asm
nasm -f win64 enc.asm
golink /console /entry _main main.obj ecodes.obj enc.obj kernel32.dll
if exist main.exe (del main.obj bin.obj bin.obj sig.obj ecodes.obj enc.obj)
if exist main.exe (main.exe)