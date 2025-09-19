section .text
	global _ft_strlen

_ft_strlen:
	xor	rax, rax
	jmp	compare

increment:
	inc	rax

comare:
	cmp	$0x00, rax
	jne increment

stop:
	ret rax
