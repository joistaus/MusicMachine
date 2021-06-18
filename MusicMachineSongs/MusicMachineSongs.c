/*
 * MusicMachineSongs.c
 *
 * Created: 17/06/2021 12:33:19
 * Author : joistaus
 */ 

#include "canciones.h"

#define PLAY(x) reproducir_cancion(x, sizeof(x)/(sizeof(int)*2))

void configurar_pines()
{
     TRISC = 0b11001110;
     Sound_Init(&PORTC, 0);
}

void reproducir_cancion(const int *cancion, unsigned short cantidad_notas)
{
    int div_tempo;
    int mult_tempo;
    int i;
    for (i = 0; i < cantidad_notas * 2; i += 2)
    {
        div_tempo = cancion[i+1];
        mult_tempo = 1;
        if (div_tempo < 0)
        {
            div_tempo *= -2;
            mult_tempo = 3;
        }
        Sound_Play(cancion[i], (mult_tempo*1500)/div_tempo);
        delay_ms(5);
    }
}

void main() {

      configurar_pines();

      while (1)
      {
          PORTC &=~ 0b11 << 4;

          switch ((PORTC >> 1) & 0b111)
          {
              case 0b001:
                  PORTC |= 0b01 << 4;
                  PLAY(CANCION_1);
                  break;
              case 0b010:
                  PORTC |= 0b10 << 4;
                  PLAY(CANCION_2);
                  break;
              case 0b100:
                  PORTC |= 0b11 << 4;
                  PLAY(CANCION_3);
                  break;
          }
      }

}