DEF VAR vcli_ini    LIKE customer.cust-num.
DEF VAR vcli_fim    LIKE customer.cust-num.
DEF VAR vlinha      AS INTEGER.
DEF VAR chExcelApp  AS COM-HANDLE NO-UNDO.
DEF VAR chWorkBook  AS COM-HANDLE NO-UNDO.
DEF VAR chWorkSheet AS COM-HANDLE NO-UNDO.

FORM vcli_ini COLON 20    LABEL "Cliente" "até ===>"
     vcli_fim COLON 40 NO-LABEL
     WITH FRAME f-parametros WIDTH 80 SIDE-LABELS TITLE " Parâmetros da Consulta " THREE-D.    
     
REPEAT:
    ASSIGN vcli_ini = 0
           vcli_fim = 99999.
           
    UPDATE vcli_ini
           vcli_fim
           WITH FRAME f-parametros. 
           
    CREATE "Excel.Application" chExcelApp.
    ASSIGN chWorkBook  = chExcelApp:WorkBooks:ADD()
           chWorkSheet = chExcelApp:Sheets:ITEM(1)
           vlinha      = 1.
           
    FOR EACH customer WHERE
             customer.cust-num >= vcli_ini AND
             customer.cust-num <= vcli_fim
             NO-LOCK:
             
             ASSIGN vlinha = vlinha + 1
                    chWorkSHeet:Range("A" + STRING(vlinha)):VALUE = customer.cust-num
                    chWorkSHeet:Range("B" + STRING(vlinha)):VALUE = customer.NAME
                    chWorkSHeet:Range("C" + STRING(vlinha)):VALUE = customer.city
                    chWorkSHeet:Range("D" + STRING(vlinha)):VALUE = customer.state
                    chWorkSHeet:Range("E" + STRING(vlinha)):VALUE = customer.country.
    END.
    
    ASSIGN chExcelApp:VISIBLE = TRUE.
    
    RELEASE OBJECT chWorkSheet.
    RELEASE OBJECT chWorkBook.
    RELEASE OBJECT chExcelApp.
END.
