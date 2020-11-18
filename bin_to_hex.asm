%include "io.mac"

section .data
    iterator1 dd 0
    iterator2 dd 0
    bin_length dd 0
    complete_hexas dd 0
    left_out_bin_length dd 0
    num_character1 db 0
    num_character2 db 0
    num_character3 db 0
    num_character4 db 0

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

    xor eax, eax
    mov [iterator1], eax
    mov edx, 0
    mov [bin_length], ecx
    mov eax, ecx
    mov ecx, 4
    div ecx
    mov ecx, [bin_length]
    mov [complete_hexas], eax
    mov [left_out_bin_length], edx

    xor eax, eax
    xor ebx, ebx
    cmp edx, 0
    jz complete

while_first:
    mov ecx, [esi + eax]
    sub cl, '0'
    add bl, bl
    add bl, cl
    inc eax
    cmp eax, edx
    jl while_first

    add bl, '0'
    mov edx, [ebp + 8]
    mov [edx], bl
    mov eax, 1
    mov [iterator1], eax

complete:

    mov eax, [left_out_bin_length]
    mov [iterator2], eax

while_complete:

    mov eax, [iterator2]
    mov ebx, [esi + eax]
    sub bl, '0'
    mov [num_character1], bl
    inc eax
    mov ebx, [esi + eax]
    sub bl, '0'
    mov [num_character2], bl
    inc eax
    mov ebx, [esi + eax]
    sub bl, '0'
    mov [num_character3], bl
    inc eax
    mov ebx, [esi + eax]
    sub bl, '0'
    mov [num_character4], bl
    mov [iterator2], eax

    xor eax, eax

    add eax, [num_character1]
    add eax, [num_character1]
    add eax, [num_character1]
    add eax, [num_character1]
    add eax, [num_character1]
    add eax, [num_character1]
    add eax, [num_character1]
    add eax, [num_character1]

    add eax, [num_character2]
    add eax, [num_character2]
    add eax, [num_character2]
    add eax, [num_character2]

    add eax, [num_character3]
    add eax, [num_character3]

    add eax, [num_character4]

    cmp al, 10
    jge greater_than_10
    add al, '0'
    jmp is_in_hexa

greater_than_10:
    sub al, 10
    add al, 'A'

is_in_hexa:
    mov ebx, [iterator1]
    mov edx, [ebp + 8]
    mov [edx + ebx], al
    inc ebx
    mov [iterator1], ebx

done_4_bits:

    mov eax, [iterator2]
    inc eax
    mov [iterator2], eax
    cmp eax, [bin_length]
    jl while_complete


    mov edx, [ebp + 8]
    mov eax, [iterator1]
    mov bl, 10
    mov [edx + eax], bl

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY