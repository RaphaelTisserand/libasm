section .text
	global start
	global _ft_strlen

start:
	call _ft_strlen

_ft_strlen:
	xor rax, rax
	jmp compare

increment:
	inc rdi
	inc rax

compare:
	cmp byte [rdi], 0
	jne increment

end:
	ret
