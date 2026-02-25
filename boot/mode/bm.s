bits 16
%include "sdk/osle.inc"
mov ah, 0x00
mov al, 0x03
int 0x10

mov si, BMT
mov cx, 0xFFFF
call str_print

mov ax, 0
int 0x16
int INT_RETURN

; Definitions
; -----------

; str_print(si: u8* string, cx: u16 max_length) -> void
; Prints up to up to cx characters of the string in si on screen.
str_print:
  pusha
    mov ah, 0x0E    ; 0x0E is teletype function for interrupt 0x10. It means
.loop:              ; "print char and advance cursor"
    lodsb
    test al, al     ; String are null terminated. Stop when current byte is 0
    je .done
    int 0x10        ; Issue interrupt to print on screen
    loop .loop
.done:
  popa
  ret


BMT:     db "BOOT PROTECT MODE TRIGGERED!"

RETURN:   db 0x0a, 0x0d, "PRESS A KEY TO REBOOT YOUR SYSTEM!", 0

times 510-($-$$) db 0
dw 0xAA55
