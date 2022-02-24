DEF VAR vlinha AS CHARACTER FORMAT "x(60)".

IF SEARCH ("c:\cursoprogress\Relatorios\email.txt") = ? THEN
    DO:
        MESSAGE "Arquivo não existe." VIEW-AS ALERT-BOX ERROR.
        UNDO.
    END.

INPUT FROM "c:\cursoprogress\Relatorios\email.txt".

    REPEAT WHILE TRUE:
        IMPORT UNFORMATTED vlinha.
        DISPLAY SUBSTRING(vlinha,1,1)   FORMAT "x(02)"
                SUBSTRING(vlinha,2,9)   FORMAT "x(10)"
                SUBSTRING(vlinha,11,30) FORMAT "x(30)"
                SKIP.
    END.
    
INPUT CLOSE.
