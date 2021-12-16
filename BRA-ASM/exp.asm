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
	L0 BYTE 'aиТ', 0
	L1 DWORD 2
	L2 DWORD -6
	L3 BYTE 'one', 0
	L4 BYTE 'two', 0
	L5 BYTE '---', 0
	L6 BYTE 'hиТ', 0
	L7 DWORD 0
.data
	_mainf		DWORD 0 ; sym
	_mainz		DWORD 0 ; int
	_mainw		DWORD 0 ; int
	_mainq		DWORD 0 ; int
	_mains		DWORD 0 ; str
	_maing		DWORD 0 ; str

.code
main PROC
	push		offset L0
	pop			_mainf

	push		L1
	pop			_mainw

	push		L2
	pop			_mainq

	push		offset L3
	pop			_mains

	push		offset L4
	pop			_maing

	push		offset L5
	call		_out

	push		_mainf
	call		_out

	push		offset L6
	pop			_mainf

	push		_mainf
	call		_out

	push		offset L5
	call		_out

	push		_mainw
	call		_outInt

	push		_mainw
	push		_mainq

	pop		eax
	pop		ebx
	add		eax, ebx
	jo		EXIT_OVERFLOW
	push		eax

	pop			_mainw

	push		_mainw
	call		_outInt

	push		_mainq
	call		_outInt

	push		_maing
	call		_strln
	push		eax
	pop			_mainq

	push		_mains
	call		_strln
	push		eax
	pop			_mainw

	push		_mains
	call		_out

	push		_maing
	call		_out

	push		_mains
	push		_maing
	call		_strcon
	push		eax
	pop			_mains

	push		_mains
	call		_out



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
	push		L7
	call		ExitProcess

main ENDP
end main
