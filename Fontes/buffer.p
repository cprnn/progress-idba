DEF VAR cont AS INTEGER.

DEF BUFFER b-customer FOR customer.

FOR EACH customer WHERE
         customer.cust-num <=10
         NO-LOCK:
    
    ASSIGN cont = 0.
    
    DISPLAY customer.cust-num
            customer.NAME
            customer.city.
            
    FOR EACH b-customer WHERE
             b-customer.city = customer.city AND
             b-customer.cust-num <> customer.cust-num
             NO-LOCK:
        
        ASSIGN cont = cont + 1.
    END.
    
    DISPLAY cont.
END.
