DEF VAR vcli_ini LIKE customer.cust-num.
DEF VAR vcli_fim LIKE customer.cust-num.

DEF QUERY q-browse FOR order-line, ITEM.

DEF BROWSE b-browse QUERY q-browse
    DISPLAY order-line.order-num        COLUMN-LABEL "Pedido"
            order-line.item-num         COLUMN-LABEL "Código"
            ITEM.item-name              COLUMN-LABEL "Descrição Item" FORMAT "x(20)"
            order-line.qty              COLUMN-LABEL "Quant"
            order-line.price            COLUMN-LABEL "Preço"
            order-line.discount         COLUMN-LABEL "Desc"
            order-line.extended-price   COLUMN-LABEL "Total"
            
            WITH SEPARATORS TITLE " Cadastro de Pedidos " WIDTH 80 18 DOWN THREE-D.

FORM vcli_ini
     vcli_fim
     WITH FRAME f-parametros WIDTH 80 SIDE-LABELS TITLE " Parâmetros da Consulta " THREE-D.
     
FORM b-browse  
     WITH FRAME f-browse WIDTH 80 NO-BOX OVERLAY ROW 4.
     
REPEAT:
    ASSIGN vcli_ini = 0
           vcli_fim = 99999.
           
    UPDATE vcli_ini
           vcli_fim
           WITH FRAME f-parametros. 
    
    RUN pro-open-query.
    
END.

PROCEDURE pro-open-query:

    OPEN QUERY q-browse
        FOR EACH order-line WHERE
                 order-line.order-num >= vcli_ini AND
                 order-line.order-num <= vcli_fim
                 NO-LOCK,
            EACH ITEM OF order-line
                 NO-LOCK.
        ENABLE b-browse WITH FRAME f-browse.
        WAIT-FOR WINDOW-CLOSE OF CURRENT-WINDOW.
END.
