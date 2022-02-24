DEF VAR estados AS CHAR INITIAL "RS, SC, PR, SP, RJ, MG, GO".
DEF VAR uf      AS CHAR FORMAT "!!".

REPEAT:

    UPDATE uf LABEL "Unidade Federativa"
           HELP "Informe a UF de um estado brasileiro"
           WITH FRAME f-x SIDE-LABELS THREE-D WIDTH 80.
    
    IF LOOKUP(uf,estados) = 0 THEN
       MESSAGE "Unidade Federativa informada não encontrada na lista" VIEW-AS ALERT-BOX ERROR.
    ELSE
       MESSAGE "Unidade Federativa informada está na posição: " LOOKUP(uf,estados) " da lista."
               VIEW-AS ALERT-BOX INFORMATION.     
END.
