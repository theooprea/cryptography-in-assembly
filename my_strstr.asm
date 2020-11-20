%include "io.mac"

section .data
    iterator1 dd 0
    iterator2 dd 0
    haystack_len dd 0
    needle_len dd 0
    haystack_address dd 0
    needle_address dd 0
    not_found_length dd 0

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY
    
    ;; move the given parameters into variables
    xor eax, eax
    mov [iterator1], eax
    mov [haystack_len], ecx
    mov [needle_len], edx
    mov [haystack_address], esi
    mov [needle_address], ebx
    add ecx, 1
    mov [not_found_length], ecx

while_haystack:
    ;; iterate through the haystack and compare the current letter with the
    ;; first letter of the needle
    mov eax, [iterator1]
    mov al, [esi + eax]
    mov ebx, [needle_address]
    mov bl, [ebx]
    ;; if the letters are not equal, we move further in the haystack string
    cmp al, bl
    jnz back_haystack

    ;; if the the letters are the same we start iterating through the key and
    ;; see if there are any differences, if there are, we move forward in the
    ;; haystack string
    ;; we keep in edx the potential answer
    mov edx, [iterator1]
    xor eax, eax
    mov [iterator2], eax

while_needle:
    mov eax, [iterator2]
    mov ebx, [needle_address]
    mov ebx, [ebx + eax]
    mov ecx, edx
    add ecx, eax
    cmp ecx, [haystack_len]
    jz back_needle
    mov ecx, [esi + ecx]
    cmp cl, bl
    ;; if there is a difference we go back to the haystack loop after we write
    ;; to edx the nod_found_length
    jnz back_needle

    mov eax, [iterator2]
    inc eax
    mov [iterator2], eax
    mov ecx, [needle_len]
    cmp ecx, [iterator2]
    jg while_needle
    ;; if there were no differences, we jump to end_of_story
    jmp end_of_story

back_needle:
    mov edx, [not_found_length]

back_haystack:
    ;; keep iterating through haystack
    mov eax, [iterator1]
    mov eax, [esi + eax]
    mov eax, [iterator1]
    inc eax
    mov [iterator1], eax
    mov ecx, [haystack_len]
    cmp ecx, [iterator1]
    jg while_haystack


end_of_story:
    ;; move the answer to the argument
    mov eax, [ebp + 8]
    mov [eax], edx

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY