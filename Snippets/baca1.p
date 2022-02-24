DEF VAR vcliente AS INTEGER.



REPEAT:



UPDATE vcliente.

FIND customer WHERE
customer.cust-num = vcliente
NO-LOCK NO-ERROR.



IF NOT AVAILABLE customer THEN
DO:
MESSAGE "Registro: " vcliente " Não está cadastrado" VIEW-AS ALERT-BOX ERROR.
UNDO.
END.

DISPLAY customer.cust-num
customer.NAME.

END.