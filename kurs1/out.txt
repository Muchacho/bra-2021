.586
.model flat, stdcall
includelib libucrt.lib
includelib kernel32.lib
includelib ../Debug/BRA_Lib.lib
ExitProcess PROTO : DWORD
_compare PROTO : DWORD, :DWORD
_strln PROTO : DWORD
_out PROTO : DWORD
_outInt PROTO : DWORD
_strcopy PROTO : BYTE, :BYTE
_strcon PROTO : BYTE, :BYTE


.stack 4096
.const
	_DIVISION_BY_ZERO_ERROR BYTE 'Ошибка выполнения: деление на ноль', 0
	_OVERFLOW_ERROR BYTE 'Ошибка выполнения: переполнение', 0
	L0 DWORD 12
	L1 DWORD 12
	L2 DWORD 5
	L3 DWORD 0
	L4 DWORD 2
	L5 DWORD 0
.data
	_umy		DWORD 0 ; int
	_mainz		DWORD 0 ; int

.code
_um PROC _umx: DWORD
	push		L0
	pop			_umy

	push		L1
	push		L2

	pop		ebx
	pop		eax
	test		ebx, ebx
	jz		EXIT_DIV_ON_NULL
	cdq
	idiv		ebx
	jo		EXIT_OVERFLOW
	push		edx

	pop			_umx



	jmp EXIT
EXIT_DIV_ON_NULL:
	push offset _DIVISION_BY_ZERO_ERROR
	call _out
	push -1
	call ExitProcess

EXIT_OVERFLOW:
	push offset _OVERFLOW_ERROR
	call _out
	push -2
	call ExitProcess

EXIT:
	mov		eax, _umx
	ret		4
_um ENDP

main PROC
	push		L3
	pop			_mainz

	push		_mainz
	call		_outInt

	push		L4
	call		_um
	push		eax
	pop			_mainz

	push		_mainz
	call		_outInt



	jmp EXIT
EXIT_DIV_ON_NULL:
	push offset _DIVISION_BY_ZERO_ERROR
	call _out
	push -1
	call ExitProcess

EXIT_OVERFLOW:
	push offset _OVERFLOW_ERROR
	call _out
	push -2
	call ExitProcess

EXIT:
	push		L5
	call		ExitProcess

main ENDP
end main
