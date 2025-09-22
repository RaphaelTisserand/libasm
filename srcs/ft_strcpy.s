section .text
	global ft_strcpy

ft_strcpy:
	xor rax, rax
	xor r10, r10
	cmp rdx, 0
	jle end

end:
	ret
