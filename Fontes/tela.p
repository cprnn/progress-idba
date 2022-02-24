DEF VAR vcli_ini   LIKE customer.cust-num.
DEF VAR vcli_fim   LIKE customer.cust-num.
DEF VAR vped_ini   LIKE order.order-num.
DEF VAR vped_fim   LIKE order.order-num.
DEF VAR vite_ini   LIKE order-line.item-num.
DEF VAR vite_fim   LIKE order-line.item-num.

DEF VAR vretorna AS CHARACTER.
DEF VAR vtipo    AS LOGICAL FORMAT "ComVariáveis/SemVariáveis".

FORM vcli_ini COLON 20 "até ==>" vcli_fim COLON 40 NO-LABEL
     vped_ini COLON 20 "até ==>" vped_fim COLON 40 NO-LABEL
     vite_ini COLON 20 "até ==>" vite_fim COLON 40 NO-LABEL
     WITH FRAME f-parametros THREE-D WIDTH 80 SIDE-LABELS
                             TITLE "Parâmetros do Relatório".
                             
REPEAT:

    ASSIGN vcli_ini = 0
           vcli_fim = 99999
           vped_ini = 0
           vped_fim = 99999
           vite_ini = 0
           vite_fim = 99999
           vretorna = ""
           vtipo = NO.

    UPDATE vcli_ini 
           vcli_fim VALIDATE(vcli_fim >= vcli_ini,
           "Erro: Valor inicial não pode ser maior que o valor final.")
           vped_ini 
           vped_fim VALIDATE(vped_fim >= vped_ini,
           "Erro: Valor inicial não pode ser maior que o valor final.")
           vite_ini 
           vite_fim VALIDATE(vite_fim >= vite_ini,
           "Erro: Valor inicial não pode ser maior que o valor final.")
           vtipo
           WITH FRAME f-parametros.
         
        IF vtipo = YES THEN
           RUN c:\cursoprogress\Relatorios\relatorio.p (vcli_ini,
                                                        vcli_fim,
                                                        vped_ini,
                                                        vped_fim,
                                                        vite_ini,
                                                        vite_fim,
                                                        OUTPUT vretorna).
        ELSE 
           RUN c:\cursoprogress\Relatorios\relatorio2.p (vcli_ini,
                                                        vcli_fim,
                                                        vped_ini,
                                                        vped_fim,
                                                        vite_ini,
                                                        vite_fim,
                                                        OUTPUT vretorna).                                                
    IF vretorna = "NOK" THEN
        MESSAGE "Problemas na geração do relatório!" VIEW-AS ALERT-BOX ERROR.
    ELSE 
        MESSAGE "Relatório gerado com sucesso!" VIEW-AS ALERT-BOX INFORMATION.
END.

