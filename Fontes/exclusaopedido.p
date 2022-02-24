DEF VAR vped_codigo     LIKE Pedido.ped_codigo.
DEF VAR vped_emissao    LIKE Pedido.ped_emissao.
DEF VAR vcli_codigo     LIKE Pedido.cli_codigo.
DEF VAR vcli_razao      LIKE Cliente.cli_razaosocial.
DEF VAR vorc_codigo     LIKE Pedido.orc_codigo.
DEF VAR vrep_codigo     LIKE Pedido.rep_codigo.
DEF VAR vrep_nome       LIKE Representante.rep_nome.
DEF VAR vtsp_codigo     LIKE Pedido.tsp_codigo.
DEF VAR vtsp_nome       LIKE Transportadora.tsp_nome.
DEF VAR vfop_codigo     LIKE Pedido.fop_codigo.
DEF VAR vfop_descricao  LIKE FormaPagamento.fop_descricao.
DEF VAR vtip_codigo     LIKE Pedido.tip_codigo.
DEF VAR vtip_descricao  LIKE TipoPagamento.tip_descricao.
DEF VAR vpds_codigo     LIKE Pedido.pds_codigo.
DEF VAR vpds_desc       LIKE PedidoSituacao.pds_desc.
DEF VAR vped_entrega    LIKE Pedido.ped_entrega.
DEF VAR vnfe_num        LIKE Pedido.nfe_num.
DEF VAR vcfo_codigo     LIKE Pedido.cfo_codigo.
DEF VAR vcfo_descricao  LIKE CFOP.cfo_descricao.
DEF VAR vconfirma       AS LOGICAL FORMAT "Sim/Não".

FORM vped_codigo
     vped_emissao COLON 62
        WITH FRAME f-chave
            SIDE-LABELS
            THREE-D
            WIDTH 80.
            
FORM vcli_codigo    COLON 18
     vcli_razao     NO-LABEL FORMAT "x(40)"
     vorc_codigo    COLON 18
     vrep_codigo    COLON 18
     vrep_nome      NO-LABEL
     vtsp_codigo    COLON 18
     vtsp_nome      NO-LABEL
     vfop_codigo    COLON 18
     vfop_descricao NO-LABEL
     vtip_codigo    COLON 18
     vtip_descricao NO-LABEL
     vpds_codigo    COLON 18
     vpds_desc      NO-LABEL
     vped_entrega   COLON 18
     vnfe_num       COLON 18
     vcfo_codigo    COLON 18
     vcfo_descricao NO-LABEL
     WITH FRAME f-dados
        SIDE-LABELS
        THREE-D
        WIDTH 80.
        
REPEAT:
    ASSIGN vconfirma = NO.
    
    UPDATE vped_codigo WITH FRAME f-chave.
    
    FIND pedido WHERE
        pedido.ped_codigo = vped_codigo
        EXCLUSIVE-LOCK NO-ERROR.
        
    IF NOT AVAIL pedido THEN
        DO:
            MESSAGE "Pedido não Cadastrado" VIEW-AS ALERT-BOX INFORMATION.
        END.
    
    ASSIGN vped_emissao = Pedido.ped_emissao
           vcli_codigo  = Pedido.cli_codigo 
           vorc_codigo  = Pedido.orc_codigo 
           vrep_codigo  = Pedido.rep_codigo 
           vtsp_codigo  = Pedido.tsp_codigo 
           vfop_codigo  = Pedido.fop_codigo 
           vtip_codigo  = Pedido.tip_codigo 
           vpds_codigo  = Pedido.pds_codigo 
           vped_entrega = Pedido.ped_entrega
           vnfe_num     = Pedido.nfe_num    
           vcfo_codigo  = Pedido.cfo_codigo.
     
    DISPLAY vped_codigo
            vped_emissao
            WITH FRAME f-chave.
            
    DISPLAY vcli_codigo 
            vorc_codigo 
            vrep_codigo 
            vtsp_codigo 
            vfop_codigo 
            vtip_codigo 
            vpds_codigo 
            vped_entrega
            vnfe_num    
            vcfo_codigo
            WITH FRAME f-dados.
           
    FIND cliente WHERE cliente.cli_codigo = vcli_codigo
    NO-LOCK NO-ERROR.
    
    IF NOT AVAIL cliente THEN
        DO:
            MESSAGE "Cliente Não Cadastrado" VIEW-AS ALERT-BOX ERROR.
            UNDO.
        END.
        
     DISPLAY cliente.cli_razaosocial @ vcli_razao WITH FRAME f-dados.
     
     FIND representante WHERE
            representante.rep_cod = vrep_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL representante THEN
         DO:
             MESSAGE "Representante Não Cadastrado" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
     DISPLAY representante.rep_nome @ vrep_nome WITH FRAME f-dados.
          
     FIND transportadora WHERE
            transportadora.tsp_codigo = vtsp_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL transportadora THEN
         DO:
             MESSAGE "Transportadora Não Cadastrada" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
     DISPLAY transportadora.tsp_nome @ vtsp_nome WITH FRAME f-dados.
     
     FIND formapagamento WHERE
            formapagamento.fop_codigo = vfop_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL formapagamento THEN
         DO:
             MESSAGE "Forma de Pagamento Não Cadastrada" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
     DISPLAY formapagamento.fop_descricao @ vfop_descricao WITH FRAME f-dados.
     
     FIND tipopagamento WHERE
            tipopagamento.tip_codigo = vtip_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL tipopagamento THEN
         DO:
             MESSAGE "Tipo de Pagamento Não Cadastrada" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
     DISPLAY tipopagamento.tip_descricao @ vtip_descricao WITH FRAME f-dados.
     
     ASSIGN vpds_codigo = 1.
            vped_entrega = TODAY + 7.
            
     DISPLAY vpds_codigo
             vped_entrega
            WITH FRAME f-dados.
     
     FIND pedidosituacao WHERE
            pedidosituacao.pds_codigo = vpds_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL pedidosituacao THEN
         DO:
             MESSAGE "Situação de Pedido Não Cadastrada" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
         
     DISPLAY pedidosituacao.pds_desc @ vpds_desc WITH FRAME f-dados.
     
     FIND cfop WHERE
        cfop.cfo_codigo = vcfo_codigo
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
      
      MESSAGE "Pedido: " vped_codigo "excluído com sucesso"
            VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
END.
