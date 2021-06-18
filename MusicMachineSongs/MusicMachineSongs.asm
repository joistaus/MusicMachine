
_configurar_pines:

;MusicMachineSongs.c,5 :: 		void configurar_pines()
;MusicMachineSongs.c,7 :: 		TRISC = 0b11001110;
	MOVLW      206
	MOVWF      TRISC+0
;MusicMachineSongs.c,8 :: 		Sound_Init(&PORTC, 0);
	MOVLW      PORTC+0
	MOVWF      FARG_Sound_Init_snd_port+0
	CLRF       FARG_Sound_Init_snd_pin+0
	CALL       _Sound_Init+0
;MusicMachineSongs.c,9 :: 		}
L_end_configurar_pines:
	RETURN
; end of _configurar_pines

_reproducir_cancion:

;MusicMachineSongs.c,11 :: 		void reproducir_cancion(const int *cancion, unsigned short cantidad_notas)
;MusicMachineSongs.c,16 :: 		for (i = 0; i < cantidad_notas * 2; i += 2)
	CLRF       reproducir_cancion_i_L0+0
	CLRF       reproducir_cancion_i_L0+1
L_reproducir_cancion0:
	MOVF       FARG_reproducir_cancion_cantidad_notas+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	RLF        R1+0, 1
	RLF        R1+1, 1
	BCF        R1+0, 0
	MOVLW      128
	XORWF      reproducir_cancion_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__reproducir_cancion14
	MOVF       R1+0, 0
	SUBWF      reproducir_cancion_i_L0+0, 0
L__reproducir_cancion14:
	BTFSC      STATUS+0, 0
	GOTO       L_reproducir_cancion1
;MusicMachineSongs.c,18 :: 		div_tempo = cancion[i+1];
	MOVF       reproducir_cancion_i_L0+0, 0
	ADDLW      1
	MOVWF      R3+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      reproducir_cancion_i_L0+1, 0
	MOVWF      R3+1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       FARG_reproducir_cancion_cancion+0, 0
	ADDWF      R0+0, 1
	MOVF       FARG_reproducir_cancion_cancion+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R2+0
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R2+1
	MOVF       R2+0, 0
	MOVWF      reproducir_cancion_div_tempo_L0+0
	MOVF       R2+1, 0
	MOVWF      reproducir_cancion_div_tempo_L0+1
;MusicMachineSongs.c,19 :: 		mult_tempo = 1;
	MOVLW      1
	MOVWF      reproducir_cancion_mult_tempo_L0+0
	MOVLW      0
	MOVWF      reproducir_cancion_mult_tempo_L0+1
;MusicMachineSongs.c,20 :: 		if (div_tempo < 0)
	MOVLW      128
	XORWF      R2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__reproducir_cancion15
	MOVLW      0
	SUBWF      R2+0, 0
L__reproducir_cancion15:
	BTFSC      STATUS+0, 0
	GOTO       L_reproducir_cancion3
;MusicMachineSongs.c,22 :: 		div_tempo *= -2;
	MOVF       reproducir_cancion_div_tempo_L0+0, 0
	MOVWF      R0+0
	MOVF       reproducir_cancion_div_tempo_L0+1, 0
	MOVWF      R0+1
	MOVLW      254
	MOVWF      R4+0
	MOVLW      255
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      reproducir_cancion_div_tempo_L0+0
	MOVF       R0+1, 0
	MOVWF      reproducir_cancion_div_tempo_L0+1
;MusicMachineSongs.c,23 :: 		mult_tempo = 3;
	MOVLW      3
	MOVWF      reproducir_cancion_mult_tempo_L0+0
	MOVLW      0
	MOVWF      reproducir_cancion_mult_tempo_L0+1
;MusicMachineSongs.c,24 :: 		}
L_reproducir_cancion3:
;MusicMachineSongs.c,25 :: 		Sound_Play(cancion[i], (mult_tempo*1500)/div_tempo);
	MOVF       reproducir_cancion_i_L0+0, 0
	MOVWF      R0+0
	MOVF       reproducir_cancion_i_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       FARG_reproducir_cancion_cancion+0, 0
	ADDWF      R0+0, 1
	MOVF       FARG_reproducir_cancion_cancion+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVF       reproducir_cancion_mult_tempo_L0+0, 0
	MOVWF      R0+0
	MOVF       reproducir_cancion_mult_tempo_L0+1, 0
	MOVWF      R0+1
	MOVLW      220
	MOVWF      R4+0
	MOVLW      5
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       reproducir_cancion_div_tempo_L0+0, 0
	MOVWF      R4+0
	MOVF       reproducir_cancion_div_tempo_L0+1, 0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVF       R0+1, 0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;MusicMachineSongs.c,26 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_reproducir_cancion4:
	DECFSZ     R13+0, 1
	GOTO       L_reproducir_cancion4
	DECFSZ     R12+0, 1
	GOTO       L_reproducir_cancion4
	NOP
	NOP
;MusicMachineSongs.c,16 :: 		for (i = 0; i < cantidad_notas * 2; i += 2)
	MOVLW      2
	ADDWF      reproducir_cancion_i_L0+0, 1
	BTFSC      STATUS+0, 0
	INCF       reproducir_cancion_i_L0+1, 1
;MusicMachineSongs.c,27 :: 		}
	GOTO       L_reproducir_cancion0
L_reproducir_cancion1:
;MusicMachineSongs.c,28 :: 		}
L_end_reproducir_cancion:
	RETURN
; end of _reproducir_cancion

_main:

;MusicMachineSongs.c,30 :: 		void main() {
;MusicMachineSongs.c,32 :: 		configurar_pines();
	CALL       _configurar_pines+0
;MusicMachineSongs.c,34 :: 		while (1)
L_main5:
;MusicMachineSongs.c,36 :: 		PORTC &=~ 0b11 << 4;
	MOVLW      192
	ANDWF      PORTC+0, 1
;MusicMachineSongs.c,38 :: 		switch ((PORTC >> 1) & 0b111)
	MOVF       PORTC+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVLW      7
	ANDWF      R0+0, 0
	MOVWF      FLOC__main+0
	GOTO       L_main7
;MusicMachineSongs.c,40 :: 		case 0b001:
L_main9:
;MusicMachineSongs.c,41 :: 		PORTC |= 0b01 << 4;
	BSF        PORTC+0, 4
;MusicMachineSongs.c,42 :: 		PLAY(CANCION_1);
	MOVLW      _TETRIS+0
	MOVWF      FARG_reproducir_cancion_cancion+0
	MOVLW      hi_addr(_TETRIS+0)
	MOVWF      FARG_reproducir_cancion_cancion+1
	MOVLW      55
	MOVWF      FARG_reproducir_cancion_cantidad_notas+0
	CALL       _reproducir_cancion+0
;MusicMachineSongs.c,43 :: 		break;
	GOTO       L_main8
;MusicMachineSongs.c,44 :: 		case 0b010:
L_main10:
;MusicMachineSongs.c,45 :: 		PORTC |= 0b10 << 4;
	BSF        PORTC+0, 5
;MusicMachineSongs.c,46 :: 		PLAY(CANCION_2);
	MOVLW      _TAKE_ON_ME_INTRO+0
	MOVWF      FARG_reproducir_cancion_cancion+0
	MOVLW      hi_addr(_TAKE_ON_ME_INTRO+0)
	MOVWF      FARG_reproducir_cancion_cancion+1
	MOVLW      96
	MOVWF      FARG_reproducir_cancion_cantidad_notas+0
	CALL       _reproducir_cancion+0
;MusicMachineSongs.c,47 :: 		break;
	GOTO       L_main8
;MusicMachineSongs.c,48 :: 		case 0b100:
L_main11:
;MusicMachineSongs.c,49 :: 		PORTC |= 0b11 << 4;
	MOVLW      48
	IORWF      PORTC+0, 1
;MusicMachineSongs.c,50 :: 		PLAY(CANCION_3);
	MOVLW      _HAPPY_BIRTHDAY+0
	MOVWF      FARG_reproducir_cancion_cancion+0
	MOVLW      hi_addr(_HAPPY_BIRTHDAY+0)
	MOVWF      FARG_reproducir_cancion_cancion+1
	MOVLW      25
	MOVWF      FARG_reproducir_cancion_cantidad_notas+0
	CALL       _reproducir_cancion+0
;MusicMachineSongs.c,51 :: 		break;
	GOTO       L_main8
;MusicMachineSongs.c,52 :: 		}
L_main7:
	MOVF       FLOC__main+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVF       FLOC__main+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVF       FLOC__main+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_main11
L_main8:
;MusicMachineSongs.c,53 :: 		}
	GOTO       L_main5
;MusicMachineSongs.c,55 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
