DEF VAR vcli_ini LIKE customer.cust-num.
DEF VAR vcli_fim LIKE customer.cust-num.

REPEAT:
    
    UPDATE vcli_ini
           vcli_fim WITH FRAME f-parametros.
           
    IF vcli_ini > vcli_fim THEN
    DO:
        MESSAGE "Erro: Código inicial não pode ser maior que o final." VIEW-AS ALERT-BOX ERROR.
        UNDO.
    END.
    
    FOR EACH customer WHERE
             customer.cust-num >= vcli_ini AND
             customer.cust num <= vcli_fim
             NO-LOCK:
             
        IF customer.cust-num = 3 OR
        customer.cust-num = 6 THEN
        NEXT.
        
        IF customer.cust-num = 15 THEN
        LEAVE.
        
        DISPLAY customer.cust-num
                customer.NAME
                WITH FRAME f-dados WIDTH 80.
        DOWN WITH FRAME f-dados.
    END.
    MESSAGE "sai do laço do for each" VIEW-AS ALERT-BOX INFORMATION.
END.
QUIT.
