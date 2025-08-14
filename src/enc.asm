section .data
  spread_factor equ 15
  seed equ 0x2000
  m_const equ 101
  a_const equ 17 
  efile_name db "embed.txt", 0
  OF_PROMPT equ 0x00002000
  secret_cap equ 36
  header_offet equ 192

section .bss
  spread_pos resb 1
  efile_buf resb 136
  secret resb secret_cap
  read1 resb secret_cap
  secret_bin resb 240

section .text
  extern ExitProcess, GetStdHandle, WriteConsoleA
  extern OpenFile, ReadFile, CloseHandle
  extern bin_buf, out, ecode, read
  enc:
    mov rcx, efile_name
    lea rdx, efile_buf
    mov r8, OF_PROMPT
    call OpenFile
    mov rsi, rax
    mov rcx, rsi
    lea rdx, secret
    mov r8, secret_cap
    lea r9, read1
    mov byte [rsp + 32], 0
    call ReadFile
    test rax, rax 
    jz ecode
    mov rcx, rsi
    call CloseHandle
    test rax, rax 
    jz ecode

    mov rsi, secret
    mov rbx, secret_bin
    mov rdx, [read1]
    bytewise:
      mov rax, [rsi]
      mov rcx, 8

      bitwise:
        shl al, 1
        jnc write_null
        mov byte [rbx], '1'
        jmp next_bit

      write_null:
        mov byte [rbx], '0'

      next_bit:
        inc rbx
        dec rcx
        cmp rcx, 0
        jne bitwise
    
    inc rsi
    dec rdx
    cmp rdx, 0
    jne bytewise

    mov rsi, secret_bin
    mov rcx, [read1]
    imul rcx, 8
    mov r11, 0

    mov rdi, spread_pos
    mov r8, [read] ; modulus
    mov r12, bin_buf
    toencloop:
      mov r9, spread_factor

      modulate:
        mov r10, seed
        add r10, r11
        imul r10, m_const
        add r10, a_const
        mov rax, r10
        xor rdx, rdx
        div r8
        mov r13b, [rsi]
        cmp rdx, header_offet
        jge skip
        add rdx, header_offet
        
        skip:
          mov byte [r12 + rdx], r13b
          xor rdx, rdx
          dec r9
          cmp r9, 0
          jne modulate      

      inc r11
      inc rsi
      dec rcx
      cmp rcx, 0
      jne toencloop

    jmp out
