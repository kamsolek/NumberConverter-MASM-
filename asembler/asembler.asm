.486
.model flat, stdcall
.stack 4096

include winapi.inc 
include macros.inc 

.data
	txt  db 'podaj liczbe lub nacisnij klawisz q aby zakonczyc program: ',0
	txt1 db 13,10,'wartosc BIN: ',0
	txt2 db 13,10,'wartosc OCT: ',0
	txt3 db 13,10,'wartosc DEC: ',0
	txt4 db 13,10,'wartosc HEX: ',0
	zm2 dw 0

.code
main proc
start:
	and zm2, 0
	xor eax, eax ;wyzerowanie eax

	INVOKE printf, addr txt   ;"podaj liczbê: "

	mov cx, 16  ;licznik do bin

loop_wczytaj:
	
	pob_znak
	cmp al,71h	;q
	je quit

	cmp al,0Dh  ;enter
	je enter1

	cmp al, 08h  ;bckspace
	je backspace

	shl zm2, 1  ;przesun w lewo zmienna zm2 o 1 bit(pomnoz razy 2)(miejsce dla kolejnej cyfry)
	
	wysw_znak al  ;wyswietl znak wpisywany z klaw

	sub al, 30h
	add zm2, ax  ;(ax bo zmienna dw)

	push cx ;(potrzebne do makra quit)
	dec cx	;dekrementuj licznik
	jnz loop_wczytaj
	jmp enter1


backspace:
	cmp cx, 16
	je loop_wczytaj
	shr zm2, 1
	INVOKE putchar, 08h  ; Wyœlij backspace do konsoli (kursor siê cofa)
    INVOKE putchar, ' '  ; Wpisz spacjê, usuwaj¹c znak
    INVOKE putchar, 08h  ; Ponownie cofnij kursor
	pop cx
    jmp loop_wczytaj  ; Wróæ do pêtli wprowadzania danych


	
enter1:
	wysw_bin:
		INVOKE printf, addr txt1

		mov bx,[zm2]
		mov ecx,16
	ety1:
		push ecx
		rcl bx,1
		jc ety2
		mov eax,'0'
		jmp ety3
	ety2:
		mov eax,'1'
	ety3:
		INVOKE putchar, eax
		pop ecx
		loop ety1

	wysw_oct:
		INVOKE printf, addr txt2

		movzx eax,[zm2]  ;pierwsza cyfra oct
		shr ax,15			   
		add al,30h	
		INVOKE putchar, eax
	
		movzx eax,[zm2]  ;druga cyfra oct
		shl ax,1			
		shr ax,13			
		add al,30h			
		INVOKE putchar, eax

		movzx eax,[zm2]  ;trzecia dyfra oct
		shl ax,4
		shr ax,13
		add al,30h
		INVOKE putchar, eax


		movzx eax,[zm2]  ;czwarta dyfra oct
		shl ax,7
		shr ax,13
		add al,30h
		INVOKE putchar, eax

		movzx eax,[zm2]  ;pi¹ta dyfra oct
		shl ax,10
		shr ax,13
		add al,30h
		INVOKE putchar, eax

		movzx eax,[zm2]  ;szósta dyfra oct
		and ax, 7
		add al,30h
		INVOKE putchar, eax



	wysw_dec:
		INVOKE printf, addr txt3
		;sprawdzenie znaku:
		mov ax ,zm2	
		shr ax, 15
		cmp ax, 1
		je ujemna

		INVOKE putchar, 2Bh ;wysw +
		jmp decc
	ujemna:
		INVOKE putchar, 2Dh ;wysw -
decc:
		mov ecx, 5
		mov ax,[zm2]
		shl ax, 1  ;skasuj 1 cyfre (KOD ZM)
		shr ax, 1
petla_dec:
		xor edx,edx

		mov ebx,10
		div bx
		      
		add dx,30h	    ; edx - jednostki,
		push dx			; ax -setki i dziesiatki
		loop petla_dec

		pop dx
		INVOKE putchar, dl
		pop dx
		INVOKE putchar, dl
		pop dx
		INVOKE putchar, dl
		pop dx
		INVOKE putchar, dl
		pop dx
		INVOKE putchar, dl


	wysw_hex:
		INVOKE printf, addr txt4

		movzx eax,[zm2]  ;pierwsza cyfra hex
		shr ax,12
		cmp al,10
		jb ety4
		add al,55	; kody ascii liter
		jmp ety5
	ety4:
		add al,30h
	ety5:
		INVOKE putchar, eax

		movzx eax,[zm2]  ;druga cyfra hex
		shl ax,4
		shr ax,12 
		cmp al,10
		jb ety6
		add al,55	; kody ascii liter
		jmp ety7
	ety6:
		add al,30h
	ety7:
		INVOKE putchar, eax

		movzx eax,[zm2]  ;trzecia cyfra hex
		shl ax,8
		shr ax,12 
		cmp al,10
		jb ety8
		add al,55	; kody ascii liter
		jmp ety9
	ety8:
		add al,30h
	ety9:
		INVOKE putchar, eax

		movzx eax,[zm2]  ;czwarta cyfra hex
		and al,0Fh
		cmp al,10 
		jb ety10
		add al,55	; kody ascii liter
		jmp ety11
	ety10:
		add al,30h
	ety11:		     
		INVOKE putchar, eax

		INVOKE putchar, 0Dh  ; Wypisz Carriage Return
		INVOKE putchar, 0Ah  ; Wypisz Line Feed
	jmp start

	quit:
		INVOKE ExitProcess, 0

	main endp
		public main
	END main