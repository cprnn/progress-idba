DEF STREAM st-cliente.
DEF STREAM st-pedido.
DEF STREAM st-item.

OUTPUT STREAM st-cliente TO VALUE("c:\cursoprogress\Relatorios\cliente.txt") PAGED.
OUTPUT STREAM st-pedido  TO VALUE("c:\cursoprogress\Relatorios\pedido.txt") PAGED.
OUTPUT STREAM st-ITEM  TO VALUE("c:\cursoprogress\Relatorios\item.txt") PAGED.

FOR EACH customer NO-LOCK:
    
    DISPLAY STREAM st-cliente
            customer.cust-num   COLUMN-LABEL "Código"
            customer.NAME       COLUMN-LABEL "Nome Cliente"
            customer.city       COLUMN-LABEL "Cidade"
            customer.state      COLUMN-LABEL "Estado"
            customer.country    COLUMN-LABEL "País"
            WITH FRAME f-cliente STREAM-IO DOWN WIDTH 100.
            
   FOR EACH order OF customer NO-LOCK:
            
   DISPLAY STREAM st-pedido
                  Order.Carrier           COLUMN-LABEL "Operador"
                  Order.Cust-Num          COLUMN-LABEL "Cliente"
                  Order.Instructions      COLUMN-LABEL "Instruções"
                  Order.Order-Date        COLUMN-LABEL "Criação"
                  Order.Order-num         COLUMN-LABEL "Pedido"
                  Order.PO                COLUMN-LABEL "O.Compra"
                  Order.Promise-Date      COLUMN-LABEL "Prometida"
                  Order.Sales-Rep         COLUMN-LABEL "Vendedor"
                  Order.Ship-Date         COLUMN-LABEL "Data de envio"
                  Order.Terms             COLUMN-LABEL "Condições"
           WITH FRAME f-pedido STREAM-IO DOWN WIDTH 120.

    FOR EACH order-line OF order      NO-LOCK,
        EACH ITEM       OF order-line NO-LOCK:
        
        DISPLAY STREAM st-item
                Order-Line.Order-num        COLUMN-LABEL "Pedido"
                Item.Item-Name              COLUMN-LABEL "Item"
                Order-Line.Item-num         COLUMN-LABEL "Nome Item"
                Order-Line.Qty              COLUMN-LABEL "Quant"
                Order-Line.Price            COLUMN-LABEL "Preço"
                Order-Line.Discount         COLUMN-LABEL "Desc"
                Order-Line.Extended-Price   COLUMN-LABEL "Total"
                Item.Allocated              COLUMN-LABEL "Alocado"
                Item.On-hand                COLUMN-LABEL "Disponível"
                Item.On-Order               COLUMN-LABEL "Em Pedidos"
                Item.Re-Order               COLUMN-LABEL "Reprocesso"
                WITH FRAME f-item STREAM-IO DOWN WIDTH 180.
         END.
     END.
END.

OUTPUT STREAM st-cliente CLOSE.
OUTPUT STREAM st-pedido CLOSE.
