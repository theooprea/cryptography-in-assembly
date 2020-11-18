%include "io.mac"

section .data
    iterator1 dd 0
    iterator2 dd 0
    plaintext_len dd 0
    key_len dd 0
    current_letter db 0

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    mov [plaintext_len], ecx
    mov [key_len], ebx
    xor ebx, ebx
    mov [iterator1], ebx
    mov [iterator2], ebx

while:
    mov eax, [iterator1]
    mov al, [esi + eax]
    mov [current_letter], al
    cmp al, 65
    jl while_out
    cmp al, 122
    jg while_out
    cmp al, 90
    jle letter
    cmp al, 97
    jge letter
    mov ebx, [iterator1]
    jmp while_out

letter:
    mov ecx, [iterator2]
    cmp ecx, [key_len]
    jnz not_overflow
    mov ecx, 0

not_overflow:
    inc ecx

out:
    mov [iterator2], ecx
    dec ecx
    mov ecx, [edi + ecx]
    mov ebx, [iterator1]
    mov eax, [esi + ebx]
    sub ecx, 'A'
    add ecx, eax

    cmp al, 90
    jle upper

lower:
    sub ecx, 97
while_lower:
    cmp cl, 26
    jl lower_out
    sub ecx, 26
    jmp while_lower
lower_out:
    add ecx, 97
    jmp done


upper:
    sub ecx, 65
while_upper:
    cmp cl, 26
    jl upper_out
    sub ecx, 26
    jmp while_upper
upper_out:
    add ecx, 65
    jmp done


done:
    mov [current_letter], cl

while_out:
    mov eax, [iterator1]
    mov ebx, [current_letter]
    mov [edx + eax], bl
    inc eax
    mov [iterator1], eax
    mov ebx, [plaintext_len]
    cmp eax, ebx
    jl while

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY