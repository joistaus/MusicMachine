/*
 * MusicMachineDisplay.c
 *
 * Created: 17/06/2021 11:53:58
 * Author : joistaus
 */ 

#include <avr/io.h>
#include <util/delay.h>
#include <avr/pgmspace.h>

#include "secuencias.h"

#define FILAS 8
#define ANIMACION(x) mostrar_animacion(x, sizeof(x) / FILAS)

void configurar_pines()
{
	DDRB  =  0xFF;
	DDRD  =  0xFF;
}

uint8_t tablero[FILAS+1] = {0};
void mostrar_tablero()
{
	for (uint8_t i = 0; i < FILAS; i++)
	{
		PORTB =     (1 << i);
		PORTD =~  tablero[i];
		_delay_ms(1);
	}
}

void mostrar_animacion(const uint8_t *secuencia, uint8_t cantidad_imagenes)
{
	uint8_t c, i, _, k, n;
	// Mostrar
	for (c = 0; c < cantidad_imagenes; c++){
		// Transici�n de entrada o de movimiento
		for (i = 0; i <= FILAS; i++)
		{
			for (_ = 0; _ < 20; _++)
			mostrar_tablero(tablero);
			for (k = 0; k < FILAS; k++)
			tablero[k] = tablero[k+1];
			for (n = 0; n < i; n++)
			tablero[FILAS-i+n] = pgm_read_byte(secuencia + n + c * FILAS);
		}
	}
	
	// Pausar por un momento la animacion en caso de que haya una sola imagen en la secuencia
	if (cantidad_imagenes == 1)
	for (_ = 0; _ < 100; _++)
	mostrar_tablero(tablero);
	
	// Transici�n de salida para la �ltima imagen de la secuencia
	for (i = 1; i <= FILAS; i++)
	{
		for (_ = 0; _ < 20; _++)
		mostrar_tablero(tablero);
		for (n = 0; n < FILAS; n++)
		tablero[n] = tablero[n+1];
	}
}

int main(void)
{
	configurar_pines();
	
	while (1)
	{
		switch (PINC & 0b11)
		{
			case 0b00:
			ANIMACION(STOP);
			break;
			case 0b01:
			ANIMACION(SECUENCIA_1);
			break;
			case 0b10:
			ANIMACION(SECUENCIA_2);
			break;
			case 0b11:
			ANIMACION(SECUENCIA_3);
			break;
		}
	}
}

