DEF TEMP-TABLE tt_dados LIKE customer.
EMPTY TEMP-TABLE tt_dados.

INSERT tt_dados EXCEPT tt_dados.cust-num tt_dados.comments
       WITH FRAME f-dados 1 COL.
       
CREATE customer.
BUFFER-COPY tt_dados EXCEPT tt_dados.cust-num TO customer.
ASSIGN customer.cust-num = NEXT-VALUE(next-cust-num).

MESSAGE "Código gerado: " CURRENT-VALUE(next-cust-num)
        VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
