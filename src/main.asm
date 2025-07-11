section .data
  file_name db "in.mp3", 0
  OF_PROMPT equ 0x00002000
  MAX_FILE_SIZE equ 966656
  MAX_BIN_SIZE equ 9666560
  bin_f db "out.mp3", 0

section .bss
  ofstruct resb 136
  file_read_buf resb MAX_FILE_SIZE
  read resb 12
  bin_buf resb MAX_BIN_SIZE

section .text
  extern OpenFile, ExitProcess
  extern ecode, enc
  extern ReadFile, sig
  extern WriteFile
  global _main
  _main:
    push rbp
    sub rsp, 40

    lea rcx, file_name
    lea rdx, ofstruct
    mov r8d, OF_PROMPT
    call OpenFile
    test rax, rax
    jz ecode
    mov rsi, rax
    jmp fileop
    end:
      add rsp, 40
      mov rcx, 0
      call ExitProcess
  
  fileop:
    mov rcx, rsi 
    push rcx
    lea rdx, file_read_buf
    mov r8, MAX_JPEG_SIZE
    lea r9, read
    mov qword [rsp + 32], 0
    call ReadFile
    test rax, rax 
    jz ecode

    mov rdi, file_read_buf
    mov rdx, [read] 
    
    mov r8, bin_buf
    binloop:
      mov byte al, [rdi]
      mov rcx, 8  
      nextbit:
        test rcx, rcx
        jz nextbyte

        shl al, 1
        jc write_one 
        mov byte [r8], '0'
        inc r8
        dec rcx
        jmp nextbit

        write_one:
          mov byte [r8], '1'
          inc r8          
          dec rcx
          jmp nextbit

      nextbyte:
        inc rdi
        dec rdx
        cmp rdx, 0
        jne binloop

    mov r8, file_read_buf
    mov rcx, [read]
    clean_buf:
      mov byte [r8], 0
      inc r8
      dec rcx
      cmp rcx, 0
      jne clean_buf

    jmp enc
    out:
      mov r8, bin_buf
      mov r9, file_read_buf
      mov rdx, [read] 
      unbinloop:
        mov al, 0
        mov rcx, 8

        reconstruct:
          mov bl, [r8]
          shl al, 1
          cmp bl, '1'
          jne write_zero
          or al, 1
        
        write_zero:
          inc r8
          dec rcx
          cmp rcx, 0
          jne reconstruct
      
        mov [r9], al
        inc r9
        dec rdx
        cmp rdx, 0
        jne unbinloop

      mov rcx, bin_f
      lea rdx, ofstruct
      mov r8d, 0x00001000
      call OpenFile
      test rax, rax
      jz ecode
    
      mov rcx, rax
      lea rdx, file_read_buf
      mov r8d, [read]
      mov r9d, 0
      mov qword [rsp + 32], 0
      call WriteFile
      test rax, rax
      jz ecode    
      jmp end
