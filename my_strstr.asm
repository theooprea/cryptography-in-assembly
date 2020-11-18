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
    
    xor eax, eax
    mov [iterator1], eax
    mov [haystack_len], ecx
    mov [needle_len], edx
    mov [haystack_address], esi
    mov [needle_address], ebx
    add ecx, 1
    mov [not_found_length], ecx

while_haystack:
    mov eax, [iterator1]
    mov al, [esi + eax]
    mov ebx, [needle_address]
    mov bl, [ebx]
    cmp al, bl
    jnz back_haystack

    mov edx, [iterator1]
    xor eax, eax
    mov [iterator2], eax

while_needle:
    mov eax, [iterator2]
    mov ebx, [needle_address]
    mov ebx, [ebx + eax]
    mov ecx, edx
    add ecx, eax
    mov ecx, [esi + ecx]
    cmp cl, bl
    jnz back_needle

    mov eax, [iterator2]
    inc eax
    mov [iterator2], eax
    mov ecx, [needle_len]
    cmp ecx, [iterator2]
    jg while_needle 
    jmp end_of_story

back_needle:
    mov edx, [not_found_length]

back_haystack:
    mov eax, [iterator1]
    mov eax, [esi + eax]
    mov eax, [iterator1]
    inc eax
    mov [iterator1], eax
    mov ecx, [haystack_len]
    cmp ecx, [iterator1]
    jg while_haystack


end_of_story:
    mov eax, [ebp + 8]
    mov [eax], edx

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY