DEF VAR vresp AS LOGICAL.

MESSAGE "Realmente quer formatar a máquina?"
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "Formatação" UPDATE vresp.
 
IF vresp = YES THEN
   DISPLAY "Formatando Disco C: 2%".
ELSE
   DISPLAY "Formatação cancelada.".
