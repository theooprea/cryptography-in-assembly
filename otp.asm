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

    ;; initialize iterator with 0
    mov eax, 0

    ;; while loop to iterate through the plaintext and xor with the
    ;; coresponding letter in the key string then add it to the answer string
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