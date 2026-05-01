BITS 32

extern atoi 
extern printf 
extern fgets 
extern stdin 
extern fact
extern is_palindromeC

global addstr 
global is_palindromeASM 
global factstr
global palindrome_check

SECTION .data
	prompt_str  db "Enter a string: ", 0
	yes_msg     db "It is a palindrome", 10, 0
	no_msg      db "It is NOT a palindrome", 10, 0

SECTION .bss
	buf resb 1024

SECTION .text

addstr: 
	push ebp 
	mov ebp, esp
    	push ebx

	push DWORD [ebp+8] 
	call atoi 
	add esp, 4
	mov  ebx, eax

	push DWORD [ebp+12]
	call atoi
	add  esp, 4

	add  eax, ebx

	pop ebx
	pop ebp
	ret

is_palindromeASM:
	push ebp
	mov ebp, esp
	push esi
	push edi

	mov esi, [ebp+8]

	mov edi, esi

.find_end:
	cmp BYTE [edi], 0 
	je .found_end 
	inc edi
	jmp  .find_end

.found_end: 
	dec edi

	cmp esi, edi
	jge  .asm_is_pal

.asm_compare_loop:
	cmp  esi, edi
	jge  .asm_is_pal

	mov  al, [esi]
	mov  ah, [edi]
	cmp  al, ah
	jne  .asm_not_pal

	inc  esi
	dec  edi
	jmp  .asm_compare_loop

.asm_is_pal:
	mov  eax, 1
	jmp  .asm_done


.asm_not_pal:
	mov  eax, 0

.asm_done: 
	pop edi 
	pop esi 
	pop ebp
	ret

factstr:
	push ebp
	mov  ebp, esp

	push DWORD [ebp+8]
	call atoi
	add  esp, 4

	push eax
	call fact
	add  esp, 4

	pop ebp
	ret

palindrome_check:
	push ebp
	mov  ebp, esp
	push ebx

	push prompt_str
	call printf
	add esp, 4

	push DWORD [stdin]
	push 1024
	push buf
	call fgets
	add  esp, 12
	
	mov ecx, buf

.strip_loop:
	cmp  BYTE [ecx], 10
	je   .strip_done
	cmp  BYTE [ecx], 0
	je   .strip_done
	inc  ecx
	jmp  .strip_loop

.strip_done:
	mov  BYTE [ecx], 0
	
	push buf
	call is_palindromeC
	add  esp, 4
	mov  ebx, eax

	cmp  ebx, 1
	je   .print_yes_msg

	push no_msg
	call printf
	add  esp, 4
	jmp  .check_done

.print_yes_msg:
	push yes_msg
	call printf
	add  esp, 4

.check_done: 
	pop ebx 
	pop ebp
	ret
