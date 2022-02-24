DEF TEMP-TABLE tt-pedido LIKE Pedido.

DEF VAR vcli_razao      LIKE Cliente.cli_razaosocial.
DEF VAR vrep_nome       LIKE Representante.rep_nome.
DEF VAR vtsp_nome       LIKE Transportadora.tsp_nome.
DEF VAR vfop_descricao  LIKE FormaPagamento.fop_descricao.
DEF VAR vtip_descricao  LIKE TipoPagamento.tip_descricao.
DEF VAR vpds_desc       LIKE PedidoSituacao.pds_desc.
DEF VAR vcfo_descricao  LIKE CFOP.cfo_descricao.
DEF VAR vconfirma       AS LOGICAL FORMAT "Sim/Não".

FORM tt-pedido.ped_codigo
     tt-pedido.ped_emissao COLON 62
        WITH FRAME f-chave
            SIDE-LABELS
            THREE-D
            WIDTH 80.
            
FORM tt-pedido.cli_codigo  COLON 18
     vcli_razao            NO-LABEL FORMAT "x(40)"
     tt-pedido.orc_codigo  COLON 18
     tt-pedido.rep_codigo  COLON 18
     vrep_nome             NO-LABEL
     tt-pedido.tsp_codigo  COLON 18
     vtsp_nome             NO-LABEL
     tt-pedido.fop_codigo  COLON 18
     vfop_descricao        NO-LABEL
     tt-pedido.tip_codigo  COLON 18
     vtip_descricao        NO-LABEL
     tt-pedido.pds_codigo  COLON 18
     vpds_desc             NO-LABEL
     tt-pedido.ped_entrega COLON 18
     tt-pedido.nfe_num     COLON 18
     tt-pedido.cfo_codigo  COLON 18
     vcfo_descricao        NO-LABEL
     WITH FRAME f-dados
         SIDE-LABELS
         THREE-D
         WIDTH 80.
        
REPEAT:
    ASSIGN vconfirma = NO.
    
    EMPTY TEMP-TABLE tt-pedido.
    
    CREATE tt-pedido.
    
    UPDATE tt-pedido.ped_codigo WITH FRAME f-chave.
    
    FIND pedido WHERE
        pedido.ped_codigo = tt-pedido.ped_codigo
        EXCLUSIVE-LOCK NO-ERROR.
        
    IF NOT AVAIL pedido THEN
        DO:
            MESSAGE "Pedido não Cadastrado" VIEW-AS ALERT-BOX INFORMATION.
            UNDO.
        END.
    
    ASSIGN tt-pedido.ped_emissao = Pedido.ped_emissao
           tt-pedido.cli_codigo  = Pedido.cli_codigo 
           tt-pedido.orc_codigo  = Pedido.orc_codigo 
           tt-pedido.rep_codigo  = Pedido.rep_codigo 
           tt-pedido.tsp_codigo  = Pedido.tsp_codigo 
           tt-pedido.fop_codigo  = Pedido.fop_codigo 
           tt-pedido.tip_codigo  = Pedido.tip_codigo 
           tt-pedido.pds_codigo  = Pedido.pds_codigo 
           tt-pedido.ped_entrega = Pedido.ped_entrega
           tt-pedido.nfe_num     = Pedido.nfe_num    
           tt-pedido.cfo_codigo  = Pedido.cfo_codigo.
     
    DISPLAY tt-pedido.ped_codigo
            tt-pedido.ped_emissao
            WITH FRAME f-chave.
            
    DISPLAY tt-pedido.cli_codigo 
            tt-pedido.orc_codigo 
            tt-pedido.rep_codigo 
            tt-pedido.tsp_codigo 
            tt-pedido.fop_codigo 
            tt-pedido.tip_codigo 
            tt-pedido.pds_codigo 
            tt-pedido.ped_entrega
            tt-pedido.nfe_num    
            tt-pedido.cfo_codigo
            WITH FRAME f-dados.
           
    FIND cliente WHERE cliente.cli_codigo = tt-pedido.cli_codigo
    NO-LOCK NO-ERROR.
    
    IF NOT AVAIL cliente THEN
        DO:
            MESSAGE "Cliente Não Cadastrado" VIEW-AS ALERT-BOX ERROR.
            UNDO.
        END.
        
     DISPLAY cliente.cli_razaosocial @ vcli_razao WITH FRAME f-dados.
     
     FIND representante WHERE
            representante.rep_cod = tt-pedido.rep_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL representante THEN
         DO:
             MESSAGE "Representante Não Cadastrado" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
     DISPLAY representante.rep_nome @ vrep_nome WITH FRAME f-dados.
          
     FIND transportadora WHERE
            transportadora.tsp_codigo = tt-pedido.tsp_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL transportadora THEN
         DO:
             MESSAGE "Transportadora Não Cadastrada" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
     DISPLAY transportadora.tsp_nome @ vtsp_nome WITH FRAME f-dados.
     
     FIND formapagamento WHERE
            formapagamento.fop_codigo = tt-pedido.fop_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL formapagamento THEN
         DO:
             MESSAGE "Forma de Pagamento Não Cadastrada" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
     DISPLAY formapagamento.fop_descricao @ vfop_descricao WITH FRAME f-dados.
     
     FIND tipopagamento WHERE
            tipopagamento.tip_codigo = tt-pedido.tip_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL tipopagamento THEN
         DO:
             MESSAGE "Tipo de Pagamento Não Cadastrada" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
     DISPLAY tipopagamento.tip_descricao @ vtip_descricao WITH FRAME f-dados.
     
     ASSIGN tt-pedido.pds_codigo = 1.
            tt-pedido.ped_entrega = TODAY + 7.
            
     DISPLAY tt-pedido.pds_codigo
             tt-pedido.ped_entrega
            WITH FRAME f-dados.
     
     FIND pedidosituacao WHERE
            pedidosituacao.pds_codigo = tt-pedido.pds_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL pedidosituacao THEN
         DO:
             MESSAGE "Situação de Pedido Não Cadastrada" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
         
     DISPLAY pedidosituacao.pds_desc @ vpds_desc WITH FRAME f-dados.
     
     FIND cfop WHERE
        cfop.cfo_codigo = tt-pedido.cfo_codigo
        NO-LOCK NO-ERROR.
        
     IF NOT AVAIL cfop THEN
         DO:
             MESSAGE "Código Fiscal de Operação Não Cadastrada" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.    
    //Aqui começa a exclusao
    
          
      UPDATE vconfirma LABEL "Deseja Excluir o Pedido (Sim/Não)?"
        WITH FRAME f-confirma
        SIDE-LABELS
        ROW 21
        NO-BOX
        THREE-D
        WIDTH 80.
        
      IF vconfirma = NO THEN
            UNDO.
            
      DELETE pedido.
      
      MESSAGE "Pedido: " tt-pedido.ped_codigo "excluído com sucesso"
            VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
END.
