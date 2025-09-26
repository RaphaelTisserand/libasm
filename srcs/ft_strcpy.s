section .text
	global start
	global _ft_strcpy

start:
	call _ft_strcpy

_ft_strcpy:
	xor rax, rax
	xor r10, r10
	cmp rdx, 0
	jle end

end:
	ret
