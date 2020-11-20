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
    ;; initialize the iterator used to move through esi
    mov eax, 0

while:
    ;; initialize bl and move into it the current character from the esi string
    xor bl, bl
    mov bl, [esi + eax]
    ;; checking that the character is letter, otherwise jump to done
    ;; if it's less than 65 or greater than 122 jump to done
    cmp bl, 65
    jl done
    cmp bl, 122
    jg done
    ;; if it's less than 90 or greater then 97 jump to letter
    cmp bl, 90
    jle letter
    cmp bl, 97
    jge letter
    ;; if it's between 91 and 96 jump to done (non letter characters between
    ;; 65 and 122)
    jmp done

letter:
    ;; if less then 90 jump to upper, else going directly to lower
    cmp bl, 90
    jle upper

lower:
    ;; add for each letter the coresponding code and subtract 97 to get back
    ;; to 97 - 122 interval, doing (letter - 97)mod26 + 97
    add ebx, edi
    sub ebx, 97
    ;; doing mod with a while, subtracting 26  repeatedly
while_lower:
    cmp bl, 26
    jl lower_out
    sub ebx, 26
    jmp while_lower
    ;; adding 97 to get a letter
lower_out:
    add ebx, 97
    jmp done

upper:
    ;; same as before, processing the letter back to 65 - 97 interval we do
    ;; (letter - 65)mod26 + 65
    ;; subtract 65 and add the code
    add ebx, edi
    sub ebx, 65
    ;; doing mod 26
while_upper:
    cmp bl, 26
    jl upper_out
    sub ebx, 26
    jmp while_upper
    ;; coming back to letter
upper_out:
    add ebx, 65
    jmp done

    ;; cand ajunge in done, se muta in vectorul final litera prelucrata
    ;; when we get to done, we move the processed letter in the final string
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