.386
.model  flat, c
.code
public search
search  proc    table:dword, num:dword, target:dword
	push	ebx
	push	ecx
	push	edx
        push    esi
        push    edi
        mov     esi, target
        mov     edi, table
	xor	ebx, ebx
	xor	ecx, ecx
search_loop:
	cmp	ecx, num
	jge	search_finish		; ����ѧ�����ֶ������벻ͬ,ecx > num
	xor	eax, eax
search_inner:
	cmp	eax, 10
	jge	search_finish		; �����ַ�����ͬ
	mov	dl, ss:[esi + eax]
	cmp	ss:[edi + ebx], dl
	jnz	search_next
	cmp	dl, 0			; �ѱȽ������ַ�
	jz	search_finish		; �����ַ�����ͬ
	inc	eax
	inc	ebx
	jmp	search_inner
search_next:
	inc	ecx
	imul	ebx, ecx, 28
	jmp	search_loop
search_finish:
	mov	eax, ecx		; �����±�
	pop	edi
	pop	esi
	pop	edx
	pop	ecx
	pop	ebx
	ret
search  endp
        end