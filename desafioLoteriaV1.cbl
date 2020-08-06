      $set sourceformat"free"

      *>Divisão de identificação do programa
       identification division.
       program-id. "desafioLoteriaV1".
       author. "Falande loiseau Etienne ".
       installation. "PC".
       date-written. 14/07/2020.
       date-compiled. 14/07/2020.



      *>Divisão para configuração do ambiente
       environment division.
       configuration section.
           special-names. decimal-point is comma.

      *>-----Declaração dos recursos externos
       input-output section.
       file-control.


       i-o-control.

      *>Declaração de variáveis
       data division.

      *>----Variaveis de arquivos
       file section.

      *>----Variaveis de trabalho
       working-storage section.


       01  ws-sorteio.
           05 ws-num-sort1                         pic 9(02) value zero.
           05 filler                               pic x(01) value "-".
           05 ws-num-sort2                         pic 9(02) value zero.
           05 filler                               pic x(01) value "-".
           05 ws-num-sort3                         pic 9(02) value zero.
           05 filler                               pic x(01) value "-".
           05 ws-num-sort4                         pic 9(02) value zero.
           05 filler                               pic x(01) value "-".
           05 ws-num-sort5                         pic 9(02) value zero.
           05 filler                               pic x(01) value "-".
           05 ws-num-sort6                         pic 9(02) value zero.
           05 filler                               pic x(01) value "-".
           05 ws-num-sort7                         pic 9(02) value zero.
           05 filler                               pic x(01) value "-".
           05 ws-num-sort8                         pic 9(02) value zero.
           05 filler                               pic x(01) value "-".
           05 ws-num-sort9                         pic 9(02) value zero.
           05 filler                               pic x(01) value "-".
           05 ws-num-sort10                        pic 9(02) value zero.

       01  ws-aposta.
           05 ws-num-apos1                         pic 9(02) value zero.
           05 filler                               pic x(01) value "-".
           05 ws-num-apos2                         pic 9(02) value zero.
           05 filler                               pic x(01) value "-".
           05 ws-num-apos3                         pic 9(02) value zero.
           05 filler                               pic x(01) value "-".
           05 ws-num-apos4                         pic 9(02) value zero.
           05 filler                               pic x(01) value "-".
           05 ws-num-apos5                         pic 9(02) value zero.
           05 filler                               pic x(01) value "-".
           05 ws-num-apos6                         pic 9(02) value zero.
           05 filler                               pic x(01) value "-".
           05 ws-num-apos7                         pic 9(02) value zero.
           05 filler                               pic x(01) value "-".
           05 ws-num-apos8                         pic 9(02) value zero.
           05 filler                               pic x(01) value "-".
           05 ws-num-apos9                         pic 9(02) value zero.
           05 filler                               pic x(01) value "-".
           05 ws-num-apos10                        pic 9(02) value zero.

       01  hora-atual.
           05 ano                                  pic 9(04).
           05 mes                                  pic 9(02).
           05 dia                                  pic 9(02).
           05 hora                                 pic 9(02).
           05 minuto                               pic 9(02).
           05 segundo                              pic 9(02).
           05 centesimo-segundo                    pic 9(02).
           05 diferenca-greenwich                  pic x(05).


       01 ws-uso-comum.
          05 qtd-num-jogar                         pic 9(02).
          05 ws-tentativas                         pic 9(09).
          05 ind                                   pic 9(02).
       01 sorteio.
          05  semente                              pic  9(08).
          05  semente1                             pic  9(08).
          05  num_random                           pic  9(01)V9999999.


       01 ws-controle                              pic x(1).
          88  trocou                               value "1".
          88  nao_trocou                           value "2".
          88  acertou                              value "3".
          88  nao_acertou                          value "4".

       01  ws-tempo.
           05 ws-hora-inicio.
              10 ws-hora-inic                      pic 9(02).
              10 ws-minut-inic                     pic 9(02).
              10 ws-seg-inic                       pic 9(02).
           05 ws-hora-final.
              10 ws-hora-fim                       pic 9(02).
              10 ws-minut-fim                      pic 9(02).
              10 ws-seg-fim                        pic 9(02).
           05 ws-difer-hora                        pic 9(02).
           05 ws-difer-minut                       pic 9(02).
           05 ws-difer-seg                         pic 9(02).


      *>----Variaveis para comunicação entre programas
       linkage section.


      *>----Declaração de tela
       screen section.


      *>Declaração do corpo do programa

      *>Crie um programa que receba uma aposta e sorteie 6 números aleatórios compreendidos
      *>no subconjunto dos números inteiros no intervalo de 1 a 60.Uma oposta pode conter
      *> entre 6 e 10 números compreendidos no subconjunto dos números inteiros no intervalo
      *>de 1 a 60.O programa deve seguir sorteando até que os números sorteados sejam idênticos
      *>aos números da aposta.
      *>Imprimir os resultados da rodada:
      *>    - Cada sorteio deve ser exibido na tela em uma linha;
      *>    - Exibir a quantidade de tentativas até o acerto;
      *>    - Exibir o tempo gasto até acertar a aposta.




       procedure division.


           perform inicializa.
           perform processamento.
           perform finaliza.

      *>----------------------------------------------------------------*
      *> Inicilizacao de variaveis, abertura de arquivos
      *> procedimentos que serao realizados apenas uma vez
      *>----------------------------------------------------------------*

       inicializa section.

            move zero  to ws-tentativas

           .
       inicializa-exit.
           exit.


      *>----------------------------------------------------------------*
      *> Section para processar o programa
      *>----------------------------------------------------------------*

       processamento section.


               display "Informe quantos numero voce quer apostar : "
               accept qtd-num-jogar

               if   qtd-num-jogar < 6
               or   qtd-num-jogar > 10 then        *> Descatar numeros fora do intervalo
                    display "Numero Invalido"
                    move 0                         to qtd-num-jogar
                    perform until ws-num-apos1 <> 0
                        accept ws-num-apos1
                        if   qtd-num-jogar < 6
                        or   qtd-num-jogar > 10 then
                             display "Numero Invalido"
                             move 0                to qtd-num-jogar
                        end-if
                    end-perform
               end-if


               if qtd-num-jogar = 6 then           *> Sorteio de 6 numeros
                   perform fazerApostas            *> Chamar section para fazer apostas

                   set nao_acertou to true

                   perform until acertou
                       perform gerar-random6       *> Chamar section numero random
                       perform testarSorteio6      *> Chamar section testar sorteio
                       display "Numeros Sorteiados : "
                       display " "
                       display ws-sorteio
                   end-perform
               end-if


               if qtd-num-jogar = 7 then           *> Sorteio de 7 numeros
                   perform fazerApostas            *> Chamar section para fazer apostas
                   perform fazerAposta7

                   set nao_acertou to true

                   perform until acertou
                       perform gerar-random6       *> Chamar section numero random
                       perform gerar-random7
                       perform testarSorteio6      *> Chamar section testar sorteio
                       display "Numeros Sorteiados : "
                       display " "
                       display ws-sorteio

                   end-perform

               end-if

               if qtd-num-jogar = 8 then           *> Sorteio de 8 numeros
                   perform fazerApostas            *> Chamar section para fazer apostas
                   perform fazerAposta7
                   perform fazerAposta8

                   set nao_acertou to true

                   perform until acertou
                       perform gerar-random6       *> Chamar section numero random
                       perform gerar-random7
                       perform gerar-random8
                       perform testarSorteio8      *> Chamar section testar sorteio
                       display "Numeros Sorteiados : "
                       display " "
                       display ws-sorteio

                   end-perform
               end-if

               if qtd-num-jogar = 9 then           *> Sorteio de 9 numeros
                   perform fazerApostas            *> Chamar section para fazer apostas
                   perform fazerAposta7
                   perform fazerAposta8
                   perform fazerAposta9

                   set nao_acertou to true

                   perform until acertou
                       perform gerar-random6       *> Chamar section numero random
                       perform gerar-random7
                       perform gerar-random8
                       perform gerar-random9
                       perform testarSorteio9      *> Chamar section testar sorteio
                       display "Numeros Sorteiados : "
                       display " "
                       display ws-sorteio

                   end-perform
               end-if

               if qtd-num-jogar = 10 then          *> Sorteio de 10 numeros
                   perform fazerApostas            *> Chamar section para fazer apostas
                   perform fazerAposta7
                   perform fazerAposta8
                   perform fazerAposta9
                   perform fazerAposta10

                   set nao_acertou to true

                   perform until acertou
                       perform gerar-random6       *> Chamar section numero random
                       perform gerar-random7
                       perform gerar-random8
                       perform gerar-random9
                       perform gerar-random10
                       perform testarSorteio10     *> Chamar section testar sorteio
                       display "Numeros Sorteiados : "
                       display " "
                       display ws-sorteio

                   end-perform
               end-if

               display erase
               perform tempo-gasto                 *> o tempo gasto até acertar
               display "Levou " ws-difer-hora " Hrs, "
               display ws-difer-minut " min e "
               display ws-difer-seg " seg para acertar."
               display "Numeros Apostados : "
               display " "
               display ws-aposta
               display " "
               display "Numeros Sorteiados : "
               display " "
               display ws-sorteio
               display " "
               display "Tentativas ate o acerto " ws-tentativas  *> Quantidade de sorteio até acerta a aposta



           .
       processamento-exit.
           exit.

      *>----------------------------------------------------------------*
      *> Section para apostas
      *>----------------------------------------------------------------*
       fazerApostas section.

           display "Faca sua aposta"

           accept ws-num-apos1
           if   ws-num-apos1 < 0
           or   ws-num-apos1 > 60 then             *> Descatar numero fora do intervalo
                display "Numero Invalido"
                move 0 to ws-num-apos1
                perform until ws-num-apos1 <> 0
                    accept ws-num-apos1
                    if   ws-num-apos1 < 0
                    or   ws-num-apos1 > 60 then
                         display "Numero Invalido"
                         move 0                    to ws-num-apos1
                    end-if
                end-perform
           end-if

           accept ws-num-apos2
           if   ws-num-apos2 < 1
           or   ws-num-apos2 > 60                  *> Descatar numero fora do intervalo
           or   ws-num-apos2 = ws-num-apos1 then   *> Descatar numeros iguais
                display "Numero Invalido"
                move 0 to ws-num-apos2
                perform until ws-num-apos2 <> 0
                    accept ws-num-apos2
                    if   ws-num-apos2 < 1
                    or   ws-num-apos2 > 60
                    or   ws-num-apos2 = ws-num-apos1 then
                         display "Numero Invalido"
                         move 0                    to ws-num-apos2
                    end-if
                end-perform
           end-if

           accept ws-num-apos3
           if   ws-num-apos3 < 1
           or   ws-num-apos3 > 60                  *> Descatar numero fora do intervalo
           or   ws-num-apos3 = ws-num-apos1
           or   ws-num-apos3 = ws-num-apos2 then   *> Descatar numeros iguais
                display "Numero Invalido"
                move 0                             to ws-num-apos3
                perform until ws-num-apos3 <> 0
                    accept ws-num-apos3
                    if   ws-num-apos3 < 1
                    or   ws-num-apos3 > 60
                    or   ws-num-apos3 = ws-num-apos1
                    or   ws-num-apos3 = ws-num-apos2 then
                         display "Numero Invalido"
                         move 0                    to ws-num-apos3
                    end-if
                end-perform
           end-if

           accept ws-num-apos4
           if   ws-num-apos4 < 1
           or   ws-num-apos4 > 60                  *> Descatar numero fora do intervalo
           or   ws-num-apos4 = ws-num-apos1
           or   ws-num-apos4 = ws-num-apos2
           or   ws-num-apos4 = ws-num-apos3 then   *> Descatar numeros iguais
                display "Numero Invalido"
                move 0                              to ws-num-apos4
                perform until ws-num-apos4 <> 0
                    accept ws-num-apos4
                    if   ws-num-apos4 < 1
                    or   ws-num-apos4 > 60
                    or   ws-num-apos4 = ws-num-apos1
                    or   ws-num-apos4 = ws-num-apos2
                    or   ws-num-apos4 = ws-num-apos3 then
                         display "Numero Invalido"
                         move 0                    to ws-num-apos4
                    end-if
                end-perform
           end-if

           accept ws-num-apos5
           if   ws-num-apos5 < 1
           or   ws-num-apos5 > 60                  *> Descatar numero fora do intervalo
           or   ws-num-apos5 = ws-num-apos1
           or   ws-num-apos5 = ws-num-apos2
           or   ws-num-apos5 = ws-num-apos3
           or   ws-num-apos5 = ws-num-apos4 then   *> Descatar numeros iguais
                display "Numero Invalido"
                move 0                             to ws-num-apos5
                perform until ws-num-apos5 <> 0
                    accept ws-num-apos5
                    if   ws-num-apos5 < 1
                    or   ws-num-apos5 > 60
                    or   ws-num-apos5 = ws-num-apos1
                    or   ws-num-apos5 = ws-num-apos2
                    or   ws-num-apos5 = ws-num-apos3
                    or   ws-num-apos5 = ws-num-apos4 then
                         display "Numero Invalido"
                         move 0                    to ws-num-apos5
                    end-if
                end-perform
           end-if

           accept ws-num-apos6
           if   ws-num-apos6 < 1
           or   ws-num-apos6 > 60                  *> Descatar numero fora do intervalo
           or   ws-num-apos6 = ws-num-apos1
           or   ws-num-apos6 = ws-num-apos2
           or   ws-num-apos6 = ws-num-apos3
           or   ws-num-apos6 = ws-num-apos4
           or   ws-num-apos6 = ws-num-apos5 then   *> Descatar numeros iguais
                display "Numero Invalido"
                move 0                             to ws-num-apos6
                perform until ws-num-apos6 <> 0
                    accept ws-num-apos6
                    if   ws-num-apos6 < 1
                    or   ws-num-apos6 > 60
                    or   ws-num-apos6 = ws-num-apos1
                    or   ws-num-apos6 = ws-num-apos2
                    or   ws-num-apos6 = ws-num-apos3
                    or   ws-num-apos6 = ws-num-apos4
                    or   ws-num-apos6 = ws-num-apos5 then
                         display "Numero Invalido"
                         move 0                    to ws-num-apos6
                    end-if
                end-perform
           end-if
             .
       fazerApostas-exit.
           exit.

      *>----------------------------------------------------------------*
      *> Section para apostas
      *>----------------------------------------------------------------*
       fazerAposta7 section.

           accept ws-num-apos7
           if   ws-num-apos7 < 1
           or   ws-num-apos7 > 60                  *> Descatar numero fora do intervalo
           or   ws-num-apos7 = ws-num-apos1
           or   ws-num-apos7 = ws-num-apos2
           or   ws-num-apos7 = ws-num-apos3
           or   ws-num-apos7 = ws-num-apos4
           or   ws-num-apos7 = ws-num-apos5
           or   ws-num-apos7 = ws-num-apos6 then   *> Descatar numeros iguais
                display "Numero Invalido"
                move 0                             to ws-num-apos7
                perform until ws-num-apos7 <> 0
                    accept ws-num-apos7
                    if   ws-num-apos7 < 1
                    or   ws-num-apos7 > 60
                    or   ws-num-apos7 = ws-num-apos1
                    or   ws-num-apos7 = ws-num-apos2
                    or   ws-num-apos7 = ws-num-apos3
                    or   ws-num-apos7 = ws-num-apos4
                    or   ws-num-apos7 = ws-num-apos5
                    or   ws-num-apos7 = ws-num-apos6 then
                         display "Numero Invalido"
                         move 0                    to ws-num-apos7
                    end-if
                end-perform
           end-if
             .
       fazerAposta7-exit.
           exit.

      *>----------------------------------------------------------------*
      *> Section para apostas
      *>----------------------------------------------------------------*
       fazerAposta8 section.

           accept ws-num-apos8
           if   ws-num-apos8 < 1
           or   ws-num-apos8 > 60                  *> Descatar numero fora do intervalo
           or   ws-num-apos8 = ws-num-apos1
           or   ws-num-apos8 = ws-num-apos2
           or   ws-num-apos8 = ws-num-apos3
           or   ws-num-apos8 = ws-num-apos4
           or   ws-num-apos8 = ws-num-apos5
           or   ws-num-apos8 = ws-num-apos6
           or   ws-num-apos8 = ws-num-apos7 then   *> Descatar numeros iguais
                display "Numero Invalido"
                move 0                             to ws-num-apos8
                perform until ws-num-apos8 <> 0
                    accept ws-num-apos8
                    if   ws-num-apos8 < 1
                    or   ws-num-apos8 > 60
                    or   ws-num-apos8 = ws-num-apos1
                    or   ws-num-apos8 = ws-num-apos2
                    or   ws-num-apos8 = ws-num-apos3
                    or   ws-num-apos8 = ws-num-apos4
                    or   ws-num-apos8 = ws-num-apos5
                    or   ws-num-apos8 = ws-num-apos6
                    or   ws-num-apos8 = ws-num-apos7 then
                         display "Numero Invalido"
                         move 0                    to ws-num-apos8
                    end-if
                end-perform
           end-if
             .
       fazerAposta8-exit.
           exit.


      *>----------------------------------------------------------------*
      *> Section para apostas
      *>----------------------------------------------------------------*
       fazerAposta9 section.


           accept ws-num-apos9
           if   ws-num-apos9 < 1
           or   ws-num-apos9 > 60                  *> Descatar numero fora do intervalo
           or   ws-num-apos9 = ws-num-apos1
           or   ws-num-apos9 = ws-num-apos2
           or   ws-num-apos9 = ws-num-apos3
           or   ws-num-apos9 = ws-num-apos4
           or   ws-num-apos9 = ws-num-apos5
           or   ws-num-apos9 = ws-num-apos6
           or   ws-num-apos9 = ws-num-apos7
           or   ws-num-apos9 = ws-num-apos8 then   *> Descatar numeros iguais
                display "Numero Invalido"
                move 0                             to ws-num-apos9
                perform until ws-num-apos9 <> 0
                    accept ws-num-apos9
                    if   ws-num-apos9 < 1
                    or   ws-num-apos9 > 60
                    or   ws-num-apos9 = ws-num-apos1
                    or   ws-num-apos9 = ws-num-apos2
                    or   ws-num-apos9 = ws-num-apos3
                    or   ws-num-apos9 = ws-num-apos4
                    or   ws-num-apos9 = ws-num-apos5
                    or   ws-num-apos9 = ws-num-apos6
                    or   ws-num-apos9 = ws-num-apos7
                    or   ws-num-apos9 = ws-num-apos8 then
                         display "Numero Invalido"
                         move 0                    to ws-num-apos9
                    end-if
                end-perform
           end-if
             .
       fazerAposta9-exit.
           exit.


      *>----------------------------------------------------------------*
      *> Section para apostas
      *>----------------------------------------------------------------*
       fazerAposta10 section.

           accept ws-num-apos10
           if   ws-num-apos10 < 1
           or   ws-num-apos10 > 60                 *> Descatar numero fora do intervalo
           or   ws-num-apos10 = ws-num-apos1
           or   ws-num-apos10 = ws-num-apos2
           or   ws-num-apos10 = ws-num-apos3
           or   ws-num-apos10 = ws-num-apos4
           or   ws-num-apos10 = ws-num-apos5
           or   ws-num-apos10 = ws-num-apos6
           or   ws-num-apos10 = ws-num-apos7
           or   ws-num-apos10 = ws-num-apos8
           or   ws-num-apos10 = ws-num-apos9 then  *> Descatar numeros iguais
                display "Numero Invalido"
                move 0                             to ws-num-apos10
                perform until ws-num-apos10 <> 0
                    accept ws-num-apos10
                    if   ws-num-apos10 < 1
                    or   ws-num-apos10 > 60
                    or   ws-num-apos10 = ws-num-apos1
                    or   ws-num-apos10 = ws-num-apos2
                    or   ws-num-apos10 = ws-num-apos3
                    or   ws-num-apos10 = ws-num-apos4
                    or   ws-num-apos10 = ws-num-apos5
                    or   ws-num-apos10 = ws-num-apos6
                    or   ws-num-apos10 = ws-num-apos7
                    or   ws-num-apos10 = ws-num-apos8
                    or   ws-num-apos10 = ws-num-apos9 then
                        display "Numero Invalido"
                        move 0                     to ws-num-apos10
                    end-if
                end-perform
           end-if

             .
       fazerAposta10-exit.
           exit.


      *>----------------------------------------------------------------*
      *> Section para gerar numero aleatorio
      *>----------------------------------------------------------------*
       gerar-random6 section.
           *>função para saber a hora que inicia o sorteio
           move function current-date(9:6) to ws-hora-inicio
           initialize ws-sorteio

           perform until ws-num-sort1 <> 0         *> sorteiando numeros dentro do intervalo
               perform semente-delay
               compute  ws-num-sort1 =  function random(semente) * 60
           end-perform

           perform until ws-num-sort2 <> 0 and ws-num-sort1
               perform semente-delay
               compute  ws-num-sort2 =  function random(semente + ws-num-sort1) * 60
           end-perform

           perform until ws-num-sort3 <> 0 and ws-num-sort1 and ws-num-sort2
               perform semente-delay
               compute  ws-num-sort3 =  function random(semente + ws-num-sort2) * 60
           end-perform

           perform until ws-num-sort4 <> 0 and ws-num-sort1 and ws-num-sort2 and ws-num-sort3
               perform semente-delay
               compute  ws-num-sort4 =  function random(semente + ws-num-sort3) * 60
           end-perform

           perform until ws-num-sort5 <> 0 and ws-num-sort1 and ws-num-sort2 and ws-num-sort3
                                         and ws-num-sort4
               perform semente-delay
               compute  ws-num-sort5 =  function random(semente + ws-num-sort4) * 60
           end-perform

           perform until ws-num-sort6 <> 0 and ws-num-sort1 and ws-num-sort2 and ws-num-sort3
                                         and ws-num-sort4 and ws-num-sort5
               perform semente-delay
               compute  ws-num-sort6 =  function random(semente + ws-num-sort5) * 60
           end-perform

           .
       gerar-random6-exit.
           exit.


      *>----------------------------------------------------------------*
      *> Section para gerar numero aleatorio
      *>----------------------------------------------------------------*
       gerar-random7 section.


           perform until ws-num-sort7 <> 0 and ws-num-sort1 and ws-num-sort2 and ws-num-sort3
                                           and ws-num-sort4 and ws-num-sort5 and ws-num-sort6
               perform semente-delay
               compute  ws-num-sort7 =  function random(semente + ws-num-sort6) * 60
           end-perform

           .
       gerar-random7-exit.
           exit.


      *>----------------------------------------------------------------*
      *> Section para gerar numero aleatorio
      *>----------------------------------------------------------------*
       gerar-random8 section.

           perform until ws-num-sort8 <> 0 and ws-num-sort1 and ws-num-sort2 and ws-num-sort3
                                           and ws-num-sort4 and ws-num-sort5 and ws-num-sort6
                                           and ws-num-sort7
               perform semente-delay
               compute  ws-num-sort8 =  function random(semente + ws-num-sort6) * 60
           end-perform

           .
       gerar-random8-exit.
           exit.


      *>----------------------------------------------------------------*
      *> Section para gerar numero aleatorio
      *>----------------------------------------------------------------*
       gerar-random9 section.

           perform until ws-num-sort9 <> 0 and ws-num-sort1 and ws-num-sort2 and ws-num-sort3
                                           and ws-num-sort4 and ws-num-sort5 and ws-num-sort6
                                           and ws-num-sort7 and ws-num-sort8
               perform semente-delay
               compute  ws-num-sort9 =  function random(semente + ws-num-sort8) * 60
           end-perform

           .
       gerar-random9-exit.
           exit.


      *>----------------------------------------------------------------*
      *> Section para gerar numero aleatorio
      *>----------------------------------------------------------------*
       gerar-random10 section.

           perform until ws-num-sort10 <> 0 and ws-num-sort1 and ws-num-sort2 and ws-num-sort3
                                            and ws-num-sort4 and ws-num-sort5 and ws-num-sort6
                                            and ws-num-sort7 and ws-num-sort8 and ws-num-sort9
               perform semente-delay
               compute  ws-num-sort10 =  function random(semente + ws-num-sort9) * 60
           end-perform

           .
       gerar-random10-exit.
           exit.


      *>----------------------------------------------------------------*
      *>   Rotina para atrasar cada sorteio
      *>----------------------------------------------------------------*

       semente-delay section.                      *> delay de 1 centésimo de segundo
           perform 10 times
               accept semente1 from time
               move semente1                       to semente
               perform until semente > semente1
                   accept semente from time
               end-perform
           end-perform
           .
       semente-delay-exit.
           exit.


      *>----------------------------------------------------------------*
      *> Section para calcular o tempo gasto
      *>----------------------------------------------------------------*
       tempo-gasto section.

           compute ws-difer-hora = ws-hora-inic - ws-hora-fim
           compute ws-difer-minut = ws-minut-inic - ws-minut-fim
           compute ws-difer-seg = ws-seg-inic - ws-seg-fim
           .
       tempo-gasto-exit.
           exit.


      *>----------------------------------------------------------------*
      *> Section para testar o acerto do sorteio
      *>----------------------------------------------------------------*
       testarSorteio6 section.

               if  ws-num-sort1 = ws-num-apos1 or ws-num-sort1 = ws-num-apos2 or ws-num-sort1 = ws-num-apos3
                   or ws-num-sort1 = ws-num-apos4 or ws-num-sort1 = ws-num-apos5 or ws-num-sort1 = ws-num-apos6 then
                   if ws-num-sort2 = ws-num-apos1 or ws-num-sort2 = ws-num-apos2 or ws-num-sort2 = ws-num-apos3
                       or ws-num-sort2 = ws-num-apos4 or ws-num-sort2 = ws-num-apos5 or ws-num-sort2 = ws-num-apos6 then
                       if ws-num-sort3 = ws-num-apos1 or ws-num-sort3 = ws-num-apos2 or ws-num-sort3 = ws-num-apos3
                           or ws-num-sort3 = ws-num-apos4 or ws-num-sort3 = ws-num-apos5 or ws-num-sort3 = ws-num-apos6 then
                           if ws-num-sort4 = ws-num-apos1 or ws-num-sort4 = ws-num-apos2 or ws-num-sort4 = ws-num-apos3
                               or ws-num-sort4 = ws-num-apos4 or ws-num-sort4 = ws-num-apos5 or ws-num-sort4 = ws-num-apos6 then
                               if ws-num-sort5 = ws-num-apos1 or ws-num-sort5 = ws-num-apos2 or ws-num-sort5 = ws-num-apos3
                                   or ws-num-sort5 = ws-num-apos4 or ws-num-sort5 = ws-num-apos5 or ws-num-sort5 = ws-num-apos6 then
                                   if ws-num-sort6 = ws-num-apos1 or ws-num-sort6 = ws-num-apos2 or ws-num-sort6 = ws-num-apos3
                                       or ws-num-sort6 = ws-num-apos4 or ws-num-sort6 = ws-num-apos5 or ws-num-sort6 = ws-num-apos6 then

                   display "Voce acertou !!! "
                   set acertou to true
               else
                   continue
               end-if

               add 1 to ws-tentativas

           .
       testarSorteio6-exit.
           exit.


      *>----------------------------------------------------------------*
      *> Section para testar o acerto do sorteio
      *>----------------------------------------------------------------*
       testarSorteio7 section.


               if  ws-num-sort1 = ws-num-apos1 or ws-num-sort1 = ws-num-apos2 or ws-num-sort1 = ws-num-apos3 or ws-num-sort1 = ws-num-apos4
                   or ws-num-sort1 = ws-num-apos5 or ws-num-sort1 = ws-num-apos6 or ws-num-sort1 = ws-num-apos7 then
                   if ws-num-sort2 = ws-num-apos1 or ws-num-sort2 = ws-num-apos2 or ws-num-sort2 = ws-num-apos3 or ws-num-sort2 = ws-num-apos4
                       or ws-num-sort2 = ws-num-apos5 or ws-num-sort2 = ws-num-apos6 or ws-num-sort2 = ws-num-apos7 then
                       if ws-num-sort3 = ws-num-apos1 or ws-num-sort3 = ws-num-apos2 or ws-num-sort3 = ws-num-apos3 or ws-num-sort3 = ws-num-apos4
                           or ws-num-sort3 = ws-num-apos5 or ws-num-sort3 = ws-num-apos6 or ws-num-sort3 = ws-num-apos7 then
                           if ws-num-sort4 = ws-num-apos1 or ws-num-sort4 = ws-num-apos2 or ws-num-sort4 = ws-num-apos3 or ws-num-sort4 = ws-num-apos4
                               or ws-num-sort4 = ws-num-apos5 or ws-num-sort4 = ws-num-apos6 or ws-num-sort4 = ws-num-apos7 then
                               if ws-num-sort5 = ws-num-apos1 or ws-num-sort5 = ws-num-apos2 or ws-num-sort5 = ws-num-apos3 or ws-num-sort5 = ws-num-apos4
                                   or ws-num-sort5 = ws-num-apos5 or ws-num-sort5 = ws-num-apos6 or ws-num-sort5 = ws-num-apos7 then
                                   if ws-num-sort6 = ws-num-apos1 or ws-num-sort6 = ws-num-apos2 or ws-num-sort6 = ws-num-apos3 or ws-num-sort6 = ws-num-apos4
                                       or ws-num-sort6 = ws-num-apos5 or ws-num-sort6 = ws-num-apos6 or ws-num-sort6 = ws-num-apos7 then
                                       if ws-num-sort7 = ws-num-apos1 or ws-num-sort7 = ws-num-apos2 or ws-num-sort7 = ws-num-apos3 or ws-num-sort7 = ws-num-apos4
                                           or ws-num-sort7 = ws-num-apos5 or ws-num-sort7 = ws-num-apos6 or ws-num-sort7 = ws-num-apos7 then

                   display "Voce acertou !!! "
                   set acertou to true
               else
                   continue
               end-if

               add 1 to ws-tentativas

           .
       testarSorteio7-exit.
           exit.


      *>----------------------------------------------------------------*
      *> Section para testar o acerto do sorteio
      *>----------------------------------------------------------------*
       testarSorteio8 section.


               if  ws-num-sort1 = ws-num-apos1 or ws-num-sort1 = ws-num-apos2 or ws-num-sort1 = ws-num-apos3 or ws-num-sort1 = ws-num-apos4
                   or ws-num-sort1 = ws-num-apos5 or ws-num-sort1 = ws-num-apos6 or ws-num-sort1 = ws-num-apos7 or ws-num-sort1 = ws-num-apos8 then
                   if ws-num-sort2 = ws-num-apos1 or ws-num-sort2 = ws-num-apos2 or ws-num-sort2 = ws-num-apos3 or ws-num-sort2 = ws-num-apos4
                       or ws-num-sort2 = ws-num-apos5 or ws-num-sort2 = ws-num-apos6 or ws-num-sort2 = ws-num-apos7 or ws-num-sort2 = ws-num-apos8 then
                       if ws-num-sort3 = ws-num-apos1 or ws-num-sort3 = ws-num-apos2 or ws-num-sort3 = ws-num-apos3 or ws-num-sort3 = ws-num-apos4
                           or ws-num-sort3 = ws-num-apos5 or ws-num-sort3 = ws-num-apos6 or ws-num-sort3 = ws-num-apos7 or ws-num-sort3 = ws-num-apos8 then
                           if ws-num-sort4 = ws-num-apos1 or ws-num-sort4 = ws-num-apos2 or ws-num-sort4 = ws-num-apos3 or ws-num-sort4 = ws-num-apos4
                               or ws-num-sort4 = ws-num-apos5 or ws-num-sort4 = ws-num-apos6 or ws-num-sort4 = ws-num-apos7 or ws-num-sort4 = ws-num-apos8 then
                               if ws-num-sort5 = ws-num-apos1 or ws-num-sort5 = ws-num-apos2 or ws-num-sort5 = ws-num-apos3 or ws-num-sort5 = ws-num-apos4
                                   or ws-num-sort5 = ws-num-apos5 or ws-num-sort5 = ws-num-apos6 or ws-num-sort5 = ws-num-apos7 or ws-num-sort5 = ws-num-apos8 then
                                       if ws-num-sort6 = ws-num-apos1 or ws-num-sort6 = ws-num-apos2 or ws-num-sort6 = ws-num-apos3 or ws-num-sort6 = ws-num-apos4
                                       or ws-num-sort6 = ws-num-apos5 or ws-num-sort6 = ws-num-apos6 or ws-num-sort6 = ws-num-apos7 or ws-num-sort6 = ws-num-apos8 then
                                           if ws-num-sort7 = ws-num-apos1 or ws-num-sort7 = ws-num-apos2 or ws-num-sort7 = ws-num-apos3 or ws-num-sort7 = ws-num-apos4
                                           or ws-num-sort7 = ws-num-apos5 or ws-num-sort7 = ws-num-apos6 or ws-num-sort7 = ws-num-apos7 or ws-num-sort7 = ws-num-apos8 then
                                               if ws-num-sort8 = ws-num-apos1 or ws-num-sort8 = ws-num-apos2 or ws-num-sort8 = ws-num-apos3 or ws-num-sort8 = ws-num-apos4
                                                   or ws-num-sort8 = ws-num-apos5 or ws-num-sort8 = ws-num-apos6 or ws-num-sort8 = ws-num-apos7 or ws-num-sort8 = ws-num-apos8 then


                   display "Voce acertou !!! "
                   set acertou to true
               else
                   continue
               end-if

               add 1 to ws-tentativas

           .
       testarSorteio8-exit.
           exit.


      *>----------------------------------------------------------------*
      *> Section para testar o acerto do sorteio
      *>----------------------------------------------------------------*
       testarSorteio9 section.


               if  ws-num-sort1 = ws-num-apos1 or ws-num-sort1 = ws-num-apos2 or ws-num-sort1 = ws-num-apos3 or ws-num-sort1 = ws-num-apos4 or ws-num-sort1 = ws-num-apos5
                   or ws-num-sort1 = ws-num-apos6 or ws-num-sort1 = ws-num-apos7 or ws-num-sort1 = ws-num-apos8 or ws-num-sort1 = ws-num-apos9 then
                   if ws-num-sort2 = ws-num-apos1 or ws-num-sort2 = ws-num-apos2 or ws-num-sort2 = ws-num-apos3 or ws-num-sort2 = ws-num-apos4 or ws-num-sort2 = ws-num-apos5
                       or ws-num-sort2 = ws-num-apos6 or ws-num-sort2 = ws-num-apos7 or ws-num-sort2 = ws-num-apos8 or ws-num-sort2 = ws-num-apos9 then
                       if ws-num-sort3 = ws-num-apos1 or ws-num-sort3 = ws-num-apos2 or ws-num-sort3 = ws-num-apos3 or ws-num-sort3 = ws-num-apos4 or ws-num-sort3 = ws-num-apos5
                           or ws-num-sort3 = ws-num-apos6 or ws-num-sort3 = ws-num-apos7 or ws-num-sort3 = ws-num-apos8 or ws-num-sort3 = ws-num-apos9 then
                           if ws-num-sort4 = ws-num-apos1 or ws-num-sort4 = ws-num-apos2 or ws-num-sort4 = ws-num-apos3 or ws-num-sort4 = ws-num-apos4 or ws-num-sort4 = ws-num-apos5
                               or ws-num-sort4 = ws-num-apos6 or ws-num-sort4 = ws-num-apos7 or ws-num-sort4 = ws-num-apos8 or ws-num-sort4 = ws-num-apos9 then
                               if ws-num-sort5 = ws-num-apos1 or ws-num-sort5 = ws-num-apos2 or ws-num-sort5 = ws-num-apos3 or ws-num-sort5 = ws-num-apos4 or ws-num-sort5 = ws-num-apos5
                                   or ws-num-sort5 = ws-num-apos6 or ws-num-sort5 = ws-num-apos7 or ws-num-sort5 = ws-num-apos8 or ws-num-sort5 = ws-num-apos9 then
                                   if ws-num-sort6 = ws-num-apos1 or ws-num-sort6 = ws-num-apos2 or ws-num-sort6 = ws-num-apos3 or ws-num-sort6 = ws-num-apos4 or ws-num-sort6 = ws-num-apos5
                                       or ws-num-sort6 = ws-num-apos6 or ws-num-sort6 = ws-num-apos7 or ws-num-sort6 = ws-num-apos8 or ws-num-sort6 = ws-num-apos9 then
                                       if ws-num-sort7 = ws-num-apos1 or ws-num-sort7 = ws-num-apos2 or ws-num-sort7 = ws-num-apos3 or ws-num-sort7 = ws-num-apos4 or ws-num-sort7 = ws-num-apos5
                                           or ws-num-sort7 = ws-num-apos6 or ws-num-sort7 = ws-num-apos7 or ws-num-sort7 = ws-num-apos8 or ws-num-sort7 = ws-num-apos9 then
                                           if ws-num-sort8 = ws-num-apos1 or ws-num-sort8 = ws-num-apos2 or ws-num-sort8 = ws-num-apos3 or ws-num-sort8 = ws-num-apos4 or ws-num-sort8 = ws-num-apos5
                                               or ws-num-sort8 = ws-num-apos6 or ws-num-sort8 = ws-num-apos7 or ws-num-sort8 = ws-num-apos8 or ws-num-sort8 = ws-num-apos9 then
                                               if ws-num-sort9 = ws-num-apos1 or ws-num-sort9 = ws-num-apos2 or ws-num-sort9 = ws-num-apos3 or ws-num-sort9 = ws-num-apos4 or ws-num-sort9 = ws-num-apos5
                                                   or ws-num-sort9 = ws-num-apos6 or ws-num-sort9 = ws-num-apos7 or ws-num-sort9 = ws-num-apos8 or ws-num-sort9 = ws-num-apos9 then

                   display "Voce acertou !!! "
                   set acertou to true
               else
                   continue
               end-if

               add 1 to ws-tentativas

           .
       testarSorteio9-exit.
           exit.


      *>----------------------------------------------------------------*
      *> Section para testar o acerto do sorteio
      *>----------------------------------------------------------------*
       testarSorteio10 section.


               if  ws-num-sort1 = ws-num-apos1 or ws-num-sort1 = ws-num-apos2 or ws-num-sort1 = ws-num-apos3 or ws-num-sort1 = ws-num-apos4 or ws-num-sort1 = ws-num-apos5
                   or ws-num-sort1 = ws-num-apos6 or ws-num-sort1 = ws-num-apos7 or ws-num-sort1 = ws-num-apos8 or ws-num-sort1 = ws-num-apos9 or ws-num-sort1 = ws-num-apos10 then
                   if ws-num-sort2 = ws-num-apos1 or ws-num-sort2 = ws-num-apos2 or ws-num-sort2 = ws-num-apos3 or ws-num-sort2 = ws-num-apos4 or ws-num-sort2 = ws-num-apos5
                       or ws-num-sort2 = ws-num-apos6 or ws-num-sort2 = ws-num-apos7 or ws-num-sort2 = ws-num-apos8 or ws-num-sort2 = ws-num-apos9 or ws-num-sort2 = ws-num-apos10 then
                       if ws-num-sort3 = ws-num-apos1 or ws-num-sort3 = ws-num-apos2 or ws-num-sort3 = ws-num-apos3 or ws-num-sort3 = ws-num-apos4 or ws-num-sort3 = ws-num-apos5
                           or ws-num-sort3 = ws-num-apos6 or ws-num-sort3 = ws-num-apos7 or ws-num-sort3 = ws-num-apos8 or ws-num-sort3 = ws-num-apos9 or ws-num-sort3 = ws-num-apos10 then
                           if ws-num-sort4 = ws-num-apos1 or ws-num-sort4 = ws-num-apos2 or ws-num-sort4 = ws-num-apos3 or ws-num-sort4 = ws-num-apos4 or ws-num-sort4 = ws-num-apos5
                               or ws-num-sort4 = ws-num-apos6 or ws-num-sort4 = ws-num-apos7 or ws-num-sort4 = ws-num-apos8 or ws-num-sort4 = ws-num-apos9 or ws-num-sort4 = ws-num-apos10 then
                               if ws-num-sort5 = ws-num-apos1 or ws-num-sort5 = ws-num-apos2 or ws-num-sort5 = ws-num-apos3 or ws-num-sort5 = ws-num-apos4 or ws-num-sort5 = ws-num-apos5
                                   or ws-num-sort5 = ws-num-apos6 or ws-num-sort5 = ws-num-apos7 or ws-num-sort5 = ws-num-apos8 or ws-num-sort5 = ws-num-apos9 or ws-num-sort5 = ws-num-apos10 then
                                   if ws-num-sort6 = ws-num-apos1 or ws-num-sort6 = ws-num-apos2 or ws-num-sort6 = ws-num-apos3 or ws-num-sort6 = ws-num-apos4 or ws-num-sort6 = ws-num-apos5
                                       or ws-num-sort6 = ws-num-apos6 or ws-num-sort6 = ws-num-apos7 or ws-num-sort6 = ws-num-apos8 or ws-num-sort6 = ws-num-apos9 or ws-num-sort6 = ws-num-apos10 then
                                       if ws-num-sort7 = ws-num-apos1 or ws-num-sort7 = ws-num-apos2 or ws-num-sort7 = ws-num-apos3 or ws-num-sort7 = ws-num-apos4 or ws-num-sort7 = ws-num-apos5
                                           or ws-num-sort7 = ws-num-apos6 or ws-num-sort7 = ws-num-apos7 or ws-num-sort7 = ws-num-apos8 or ws-num-sort7 = ws-num-apos9 or ws-num-sort7 = ws-num-apos10 then
                                           if ws-num-sort8 = ws-num-apos1 or ws-num-sort8 = ws-num-apos2 or ws-num-sort8 = ws-num-apos3 or ws-num-sort8 = ws-num-apos4 or ws-num-sort8 = ws-num-apos5
                                               or ws-num-sort8 = ws-num-apos6 or ws-num-sort8 = ws-num-apos7 or ws-num-sort8 = ws-num-apos8 or ws-num-sort8 = ws-num-apos9 or ws-num-sort8 = ws-num-apos10 then
                                               if ws-num-sort9 = ws-num-apos1 or ws-num-sort9 = ws-num-apos2 or ws-num-sort9 = ws-num-apos3 or ws-num-sort9 = ws-num-apos4 or ws-num-sort9 = ws-num-apos5
                                                   or ws-num-sort9 = ws-num-apos6 or ws-num-sort9 = ws-num-apos7 or ws-num-sort9 = ws-num-apos8 or ws-num-sort9 = ws-num-apos9 or ws-num-sort9 = ws-num-apos10 then
                                                   if ws-num-sort10 = ws-num-apos1 or ws-num-sort10 = ws-num-apos2 or ws-num-sort10 = ws-num-apos3 or ws-num-sort10 = ws-num-apos4 or ws-num-sort10 = ws-num-apos5
                                                       or ws-num-sort10 = ws-num-apos6 or ws-num-sort10 = ws-num-apos7 or ws-num-sort10 = ws-num-apos8 or ws-num-sort10 = ws-num-apos9 or ws-num-sort10 = ws-num-apos10 then
                   move function current-date(9:6) to ws-hora-inicio  *> função para saber a hora final após ter acertado
                   display "Voce acertou !!! "
                   set acertou to true
               else
                   continue
               end-if

               add 1 to ws-tentativas

           .
       testarSorteio10-exit.
           exit.


      *>----------------------------------------------------------------*
      *> Section de finalizacao do programa
      *>----------------------------------------------------------------*
       finaliza section.

           display " "

           display "Finalizando programa!!!"

           Stop run
           .
       finaliza-exit.
           exit.













