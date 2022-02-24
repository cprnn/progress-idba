DEF VAR vopcao AS INTEGER FORMAT "9".

FORM "1 - Inclusão"  AT 5 SKIP
     "2 - Alteração" AT 5 SKIP
     "3 - Exclusão"  AT 5 SKIP
     "4 - Consulta"  AT 5 SKIP(2)
     vopcao LABEL "Digite a opcao desejada:"
     WITH FRAME f-opcao SIDE-LABELS THREE-D CENTERED.

REPEAT:

UPDATE vopcao WITH FRAME f-opcao.
    IF vopcao = 1 THEN RUN C:\cursoprogress\Fontes\inclusaopedido_v3.p.
    IF vopcao = 2 THEN RUN C:\cursoprogress\Fontes\alteracaopedido_v3.p.
    IF vopcao = 3 THEN RUN C:\cursoprogress\Fontes\exclusaopedido_v3.p.
    IF vopcao = 4 THEN RUN C:\cursoprogress\Fontes\consultapedido_v3.p.
    IF vopcao = 9 THEN LEAVE.
    
END.
