DEF TEMP-TABLE tt-dados
    FIELD tt-seq    AS CHARACTER FORMAT "x(02)"
    FIELD tt-nome   AS CHARACTER FORMAT "x(12)"
    FIELD tt-email  AS CHARACTER FORMAT "x(40)".
    
    
EMPTY TEMP-TABLE tt-dados.

IF SEARCH ("c:\cursoprogress\Relatorios\email.csv") = ? THEN
    DO:
        MESSAGE "Arquivo não existe." VIEW-AS ALERT-BOX ERROR.
        UNDO.
    END.

INPUT FROM "c:\cursoprogress\Relatorios\email.csv".

    REPEAT WHILE TRUE:
        CREATE tt-dados.
        IMPORT DELIMITER ";" tt-dados.
    END.
    
INPUT CLOSE.

FOR EACH tt-dados:
    DISPLAY tt-dados.
END.
