section .bss
  err_code resb 12
  written resb 12

section .data
	msg db "complete!", 0
	msg_len equ  $ - msg

section .text
  extern GetLastError, GetStdHandle
  extern WriteConsoleA, ExitProcess
	extern GetLastError
  done:  
    mov ecx, -11
    call GetStdHandle
    mov rbx, rax

    mov rcx, rbx
    lea rdx, msg
    mov r8, msg_len
    lea r9, written
    mov byte [rsp + 32], 0
    call WriteConsoleA

		mov ecx, 0
		call ExitProcess

	ecode:
		call GetLastError
		mov ecx, 10      
		lea rsi, [err_code + 12] 
		convert_loop:
			dec rsi
			xor rdx, rdx
			mov rax, rax     
			div rcx            
			add dl, '0'          
			mov [rsi], dl       
			test rax, rax
			jnz convert_loop

			mov ecx, -11
			call GetStdHandle
			
			mov rcx, rax     
			mov rdx, rsi          
			mov r8, err_code + 12
			sub r8, rsi        
			lea r9, written 
			call WriteConsoleA

			xor ecx, ecx
			call ExitProcess
