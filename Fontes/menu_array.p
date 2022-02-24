DEF VAR vopcao AS CHARACTER FORMAT "x(9)" EXTENT 5
                  INITIAL [" Inclusão ", " Alteração ", " Exclusão ", " Consulta ", "Browse "].
                  
FORM vopcao[1]
     vopcao[2]
     vopcao[3]
     vopcao[4]
     vopcao[5]
     WITH FRAME f-opcao   NO-LABELS WIDTH 80 THREE-D.
     
REPEAT:
    MESSAGE "Escolha a opção desejada:".
    DISPLAY vopcao WITH FRAME f-opcao.
    CHOOSE FIELD vopcao AUTO-RETURN WITH FRAME f-opcao.
    
    IF FRAME-INDEX = 1 THEN RUN c:\cursoprogress\Fontes\inclusaopedido_v3.p.
    IF FRAME-INDEX = 2 THEN RUN c:\cursoprogress\Fontes\alteracaopedido_v3.p.
    IF FRAME-INDEX = 3 THEN RUN c:\cursoprogress\Fontes\exclusaopedido_v3.p.
    IF FRAME-INDEX = 4 THEN RUN c:\cursoprogress\Fontes\consultapedido_v3.p.
    IF FRAME-INDEX = 5 THEN RUN c:\cursoprogress\Fontes\BROWSE.p.
    
END.
