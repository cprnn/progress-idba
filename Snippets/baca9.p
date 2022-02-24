DEF VAR vcli_ini LIKE customer.cust-num.
DEF VAR vcli_fim LIKE customer.cust-num INITIAL 99999.
DEF VAR vped_ini LIKE order.order-num.
DEF VAR vped_fim LIKE order.order-num INITIAL 99999.
DEF VAR vite_ini LIKE ITEM.item-num.
DEF VAR vite_fim LIKE ITEM.item-num INITIAL 99999.
DEF VAR vodt_ini LIKE order-date INITIAL 01/01/93.
DEF VAR vodt_fim LIKE order-date INITIAL 12/31/93.

FORM vcli_ini COLON 20 LABEL "Cliente" "Até"
vcli_fim COLON 40 NO-LABEL
vped_ini COLON 20 LABEL "Pedido" "Até"
vped_fim COLON 40 NO-LABEL
vite_ini COLON 20 LABEL "Item" "Até"
vite_fim COLON 40 NO-LABEL
vodt_ini COLON 20 LABEL "Data" "Até"
vodt_fim COLON 40 NO-LABEL
WITH FRAME f-parametros SIDE-LABELS WIDTH 80 TITLE " Parametros da Consulta " THREE-D.

REPEAT:

    UPDATE vcli_ini
    vcli_fim
    vped_ini
    vped_fim
    vite_ini
    vite_fim
    vodt_ini
    vodt_fim
    WITH FRAME f-parametros.

    FOR EACH customer WHERE
        customer.cust-num >= vcli_ini AND
        customer.cust-num <= vcli_fim
        NO-LOCK,

        EACH order OF customer WHERE
        (order.order-num >= vped_ini AND
        order.order-num <= vped_fim) AND
        (order.order-date >= vodt_ini AND
        order.order-date <= vodt_fim)
        NO-LOCK,

        EACH order-line OF order WHERE
        order-line.item-num >= vite_ini AND
        order-line.item-num <= vite_fim
        NO-LOCK,

        EACH ITEM OF order-line
        NO-LOCK:

        DISPLAY customer.cust-num
        customer.NAME
        order.order-num
        order-line.item-num
        ITEM.item-name.
    END.
END.