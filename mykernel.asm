        mov ax, 2000h
        mov ds, ax
        mov es, ax

loop:
        mov si, prompt
        call lib_print_string
        mov si, user_input
        call lib_input_string

        cmp byte [si], 0
        je loop
        cmp word [si], "dv"
        je list_files

        mov ax, si
        mov cx, 32768
        call lib_load_file
        jc load_fail

        call 32768
        jmp loop

load_fail:
        mov si, load_fail_msg
        call lib_print_string
        jmp loop

list_files:
        mov si, file_list
        call lib_get_file_list
        call lib_print_string
        jmp loop

        prompt          db 13, 10, "XOS 1.0 > ", 0
        load_fail_msg   db 13, 10, "Illegal Input", 0
        user_input      times 256 db 0
        file_list       times 1024 db 0

        %include "C:\Users\Logan\Desktop\asmschool\asmschool\lib.asm"