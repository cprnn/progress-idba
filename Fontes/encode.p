DEF VAR vcliente LIKE customer.cust-num.

DEF BUTTON bt-pedido LABEL "Pedido"
    TRIGGERS:
        ON CHOOSE 
        DO:
            FIND FIRST order OF customer EXCLUSIVE-LOCK NO-ERROR.
            
            IF AVAIL order THEN
               UPDATE order WITH FRAME f-update VIEW-AS DIALOG-BOX TITLE "Alteração Pedido" SIDE-LABELS.   
            END.
    END.
   
FORM bt-pedido
     vcliente
     customer.NAME
     WITH FRAME f-inicial.
  
ON f10 OF customer.NAME 
    DO:
        APPLY "choose" TO bt-pedido IN FRAME f-inicial.
    END.

REPEAT:
    
    UPDATE vcliente WITH FRAME f-inicial.
    
    FIND customer WHERE
         customer.cust-num = vcliente
         EXCLUSIVE-LOCK NO-ERROR.

    IF AVAIL customer THEN
       DISPLAY bt-pedido customer.NAME WITH FRAME f-inicial.
       
    ENABLE ALL WITH FRAME f-inicial.

    WAIT-FOR WINDOW-CLOSE OF CURRENT-WINDOW.
END.
