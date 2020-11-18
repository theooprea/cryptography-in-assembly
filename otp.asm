%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    mov eax, 0

while:
    mov bl, [esi + eax]
    xor bl, [edi + eax]
    mov [edx + eax], bl
    inc eax
    cmp eax, ecx
    jnz while

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY