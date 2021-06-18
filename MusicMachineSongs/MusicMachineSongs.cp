#line 1 "//Mac/Home/Desktop/MusicMachine/MusicMachineSongs/MusicMachineSongs.c"
#line 1 "//mac/home/desktop/musicmachine/musicmachinesongs/canciones.h"
#line 1 "//mac/home/desktop/musicmachine/musicmachinesongs/notas.h"
#line 10 "//mac/home/desktop/musicmachine/musicmachinesongs/canciones.h"
const int TETRIS[] = {

  659 , 4,  494 ,8,  523 ,8,  587 ,4,  523 ,8,  494 ,8,
  440 , 4,  440 ,8,  523 ,8,  659 ,4,  587 ,8,  523 ,8,
  494 , -4,  523 ,8,  587 ,4,  659 ,4,
  523 , 4,  440 ,4,  440 ,4,  494 ,8,  523 ,4,

  587 , 4,  698 ,8,  880 ,4,  784 ,8,  698 ,8,
  659 , -4,  523 ,8,  659 ,4,  587 ,8,  523 ,8,
  494 , 4,  494 ,8,  523 ,8,  587 ,4,  659 ,4,
  523 , 4,  440 ,4,  440 ,2,


  659 ,2,  523 ,2,
  587 ,2,  494 ,2,
  523 ,2,  440 ,2,
  415 ,2,  494 ,2,
  659 ,2,  523 ,2,
  587 ,2,  494 ,2,
  523 ,4,  659 ,4,  880 ,2,
  831 ,2,
};

const int TAKE_ON_ME_INTRO[] = {
  740 ,8,  740 ,8, 587 ,8,  494 ,8,  1 ,8,  494 ,8,  1 ,8,  659 ,8,
  1 ,8,  659 ,8,  1 ,8,  659 ,8,  831 ,8,  831 ,8,  880 ,8,  988 ,8,
  880 ,8,  880 ,8,  880 ,8,  659 ,8,  1 ,8,  587 ,8,  1 ,8,  740 ,8,
  1 ,8,  740 ,8,  1 ,8,  740 ,8,  659 ,8,  659 ,8,  740 ,8,  659 ,8,
  740 ,8,  740 ,8, 587 ,8,  494 ,8,  1 ,8,  494 ,8,  1 ,8,  659 ,8,

  1 ,8,  659 ,8,  1 ,8,  659 ,8,  831 ,8,  831 ,8,  880 ,8,  988 ,8,
  880 ,8,  880 ,8,  880 ,8,  659 ,8,  1 ,8,  587 ,8,  1 ,8,  740 ,8,
  1 ,8,  740 ,8,  1 ,8,  740 ,8,  659 ,8,  659 ,8,  740 ,8,  659 ,8,
  740 ,8,  740 ,8, 587 ,8,  494 ,8,  1 ,8,  494 ,8,  1 ,8,  659 ,8,
  1 ,8,  659 ,8,  1 ,8,  659 ,8,  831 ,8,  831 ,8,  880 ,8,  988 ,8,

  880 ,8,  880 ,8,  880 ,8,  659 ,8,  1 ,8,  587 ,8,  1 ,8,  740 ,8,
  1 ,8,  740 ,8,  1 ,8,  740 ,8,  659 ,8,  659 ,8,  740 ,8,  659 ,8,
};

const int HAPPY_BIRTHDAY[] = {

  262 ,4,  262 ,8,
  294 ,-4,  262 ,-4,  349 ,-4,
  330 ,-2,  262 ,4,  262 ,8,
  294 ,-4,  262 ,-4,  392 ,-4,
  349 ,-2,  262 ,4,  262 ,8,

  523 ,-4,  440 ,-4,  349 ,-4,
  330 ,-4,  294 ,-4,  466 ,4,  466 ,8,
  440 ,-4,  349 ,-4,  392 ,-4,
  349 ,-2,

};
#line 5 "//Mac/Home/Desktop/MusicMachine/MusicMachineSongs/MusicMachineSongs.c"
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
  reproducir_cancion( TETRIS , sizeof( TETRIS )/(sizeof(int)*2)) ;
 break;
 case 0b010:
 PORTC |= 0b10 << 4;
  reproducir_cancion( TAKE_ON_ME_INTRO , sizeof( TAKE_ON_ME_INTRO )/(sizeof(int)*2)) ;
 break;
 case 0b100:
 PORTC |= 0b11 << 4;
  reproducir_cancion( HAPPY_BIRTHDAY , sizeof( HAPPY_BIRTHDAY )/(sizeof(int)*2)) ;
 break;
 }
 }

}
