DEF VAR vresp AS LOGICAL.

MESSAGE "Realmente quer formatar a m�quina?"
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "Formata��o" UPDATE vresp.
 
IF vresp = YES THEN
   DISPLAY "Formatando Disco C: 2%".
ELSE
   DISPLAY "Formata��o cancelada.".
