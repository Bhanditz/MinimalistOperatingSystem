; Second Stage Bootloader of MOS Operating System.

; Check the license at GitHub.com/leosncz/OperatingSystem/

; NASM syntax.

[org 0x500]
jmp main
%include "resources.asm"
%include "gdtResources.asm" ; Contains usefull gdt datas.
main:
mov si, text3
call printIntPrepareNL
call printInt
mov si, text4
call printIntPrepareNL
call printInt
mov si, text5
call printIntPrepareNL
call printInt
call setupGDT ; Setup GDT.
jmp CODE_SEG:startPMode

[bits 32]
jmp startPMode
%include "pModeResources.asm"
startPMode:
mov ax , DATA_SEG ; Now in PM , our old segments are meaningless ,
mov ds , ax ; so we point our segment registers to the
mov ss , ax ; data selector we defined in our GDT
mov es , ax
mov fs , ax
mov gs , ax
mov ebp , 0x90000 ; Update our stack position so it is right
mov esp , ebp ; at the top of the free space.

mov cx, 0x3C0
mov si, text6
call writeGreenSIToVideoMemory
jmp $
; THEN LOADS C KERNEL