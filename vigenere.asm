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

    ;; keep the given function parameters in variables
    mov [plaintext_len], ecx
    mov [key_len], ebx
    xor ebx, ebx
    ;; initialize the iterators
    mov [iterator1], ebx
    mov [iterator2], ebx

while:
    ;; we get the iterator into eax and put into al the current letter
    mov eax, [iterator1]
    mov al, [esi + eax]
    mov [current_letter], al
    ;; compare the letter with ascii's to process letters and keep non-letter
    ;; characters same as before
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
    ;; check to see if we overflow the iterator through the key, if so, we can
    ;; just set it back to 1, otherwise increase it
    mov ecx, [iterator2]
    cmp ecx, [key_len]
    jnz not_overflow
    mov ecx, 0

not_overflow:
    inc ecx

out:
    ;; decrease the current iterator (indexation from 0), add in the current
    ;; letter the coresponding key code and then process the letter accordingly
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
    ;; process the letter back to 97 - 122 interval
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
    ;; process the letter back to 65 - 90 interval
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
    ;; when the processing is done we move the cl to the mentioned variable
    mov [current_letter], cl

while_out:
    ;; increment iterators, load the letter into the string and loop
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