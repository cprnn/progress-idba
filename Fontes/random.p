DEF VAR hilite AS CHARACTER EXTENT 3.
DEF VAR loop   AS INTEGER.

ASSIGN hilite[1] = "NORMAL"
       hilite[2] = "INPUT"
       hilite[3] = "MESSAGES".
       
REPEAT WHILE loop <= 20:

    FORM bar AS CHARACTER WITH ROW(RANDOM(3,17)) COLUMN(RANDOM(5,50)) NO-BOX NO-LABELS WITH FRAME semposicao.
    
    COLOR DISPLAY VALUE(hilite[RANDOM(1,3)]) bar WITH FRAME semposicao.
    
    DISPLAY FILL ("*", RANDOM(1,8)) @ bar WITH FRAME semposicao.
    
    PAUSE 1 NO-MESSAGE.
    
    HIDE FRAME semposicao NO-PAUSE.
    
    ASSIGN loop = loop + 1.
    
END.
