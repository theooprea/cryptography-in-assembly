%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
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
    xor bl, bl
    mov bl, [esi + eax]
    cmp bl, 65
    jl done
    cmp bl, 122
    jg done
    cmp bl, 90
    jle letter
    cmp bl, 97
    jge letter
    jmp done

letter:
    cmp bl, 90
    jle upper

lower:
    add ebx, edi
    sub ebx, 97
while_lower:
    cmp bl, 26
    jl lower_out
    sub ebx, 26
    jmp while_lower
lower_out:
    add ebx, 97
    jmp done

upper:
    add ebx, edi
    sub ebx, 65
while_upper:
    cmp bl, 26
    jl upper_out
    sub ebx, 26
    jmp while_upper
upper_out:
    add ebx, 65
    jmp done

done:
    mov [edx + eax], bl
    inc eax
    cmp eax, ecx
    jnz while

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY