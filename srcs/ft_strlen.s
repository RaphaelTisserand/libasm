section .text
	global ft_strlen

ft_strlen:
	xor	rax, rax
	jmp	compare

increment:
	inc	rdi
	inc	rax

compare:
	cmp	byte [rdi], 0
	jne	increment

end:
	ret
