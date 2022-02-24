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
DEF VAR vconfirma       AS LOGICAL FORMAT "Sim/N�o".

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
    
     ON LEAVE OF vcli_codigo
         DO:
            FIND cliente WHERE
                 cliente.cli_codigo = INPUT vcli_codigo
                 NO-LOCK NO-ERROR.
                 
            IF AVAIL cliente THEN
                 DISPLAY cliente.cli_razaosocial @ vcli_razao WITH FRAME f-dados.
            ELSE
                 DISPLAY "Cliente N�o Cadastrado" @ vcli_razao WITH FRAME f-dados.
         END.
         
     ON LEAVE OF vrep_codigo
         DO:
            FIND representante WHERE
                 representante.rep_codigo = INPUT vrep_codigo
                 NO-LOCK NO-ERROR.
                 
            IF AVAIL representante THEN
                 DISPLAY representante.rep_nome @ vrep_nome WITH FRAME f-dados.
            ELSE
                 DISPLAY "Representante N�o Cadastrado" @ vrep_nome WITH FRAME f-dados.
         END.
         
     ON LEAVE OF vtsp_codigo
         DO:
            FIND transportadora WHERE
                 transportadora.tsp_codigo = INPUT vtsp_codigo
                 NO-LOCK NO-ERROR.
                 
            IF AVAIL transportadora THEN
                 DISPLAY transportadora.tsp_nome @ vtsp_nome WITH FRAME f-dados.
            ELSE
                 DISPLAY "Transportadora N�o Cadastrado" @ vtsp_nome WITH FRAME f-dados.
         END.
         
     ON LEAVE OF vfop_codigo
        DO:
           FIND formapagamento WHERE
                formapagamento.fop_codigo = INPUT vfop_codigo
                NO-LOCK NO-ERROR.
                
           IF AVAIL formapagamento THEN
                DISPLAY formapagamento.fop_descricao @ vfop_descricao WITH FRAME f-dados.
           ELSE
                DISPLAY "Forma de Pagamento N�o Cadastrado" @ vfop_descricao WITH FRAME f-dados.
        END.
     
     ON LEAVE OF vtip_codigo
        DO:
           FIND tipopagamento WHERE
                tipopagamento.tip_codigo = INPUT vtip_codigo
                NO-LOCK NO-ERROR.
                
           IF AVAIL tipopagamento THEN
                DISPLAY tipopagamento.tip_descricao @ vtip_descricao WITH FRAME f-dados.
           ELSE
                DISPLAY "Tipo de Pagamento N�o Cadastrado" @ vtip_descricao WITH FRAME f-dados.
        END.
     
     ON LEAVE OF vpds_codigo
        DO:
           FIND pedidosituacao WHERE
                pedidosituacao.pds_codigo = INPUT vpds_codigo
                NO-LOCK NO-ERROR.
                
           IF AVAIL pedidosituacao THEN
                DISPLAY pedidosituacao.pds_desc @ vpds_desc WITH FRAME f-dados.
           ELSE
                DISPLAY "Tipo de Pagamento N�o Cadastrado" @ vpds_desc WITH FRAME f-dados.
        END.
        
     ON LEAVE OF vcfo_codigo
        DO:
           FIND cfop WHERE
                cfop.cfo_codigo = INPUT vcfo_codigo
                NO-LOCK NO-ERROR.
                
           IF AVAIL cfop THEN
                DISPLAY cfop.cfo_descricao @ vcfo_descricao WITH FRAME f-dados.
           ELSE
                DISPLAY "C�digo Fiscal de Opera��o N�o Cadastrada" @ vcfo_descricao WITH FRAME f-dados.
        END.    
        
REPEAT:
    ASSIGN vconfirma = NO.
    
    UPDATE vped_codigo WITH FRAME f-chave.
    
    FIND pedido WHERE
        pedido.ped_codigo = vped_codigo
        EXCLUSIVE-LOCK NO-ERROR.
        
    IF NOT AVAIL pedido THEN
        DO:
            MESSAGE "Pedido n�o Cadastrado" VIEW-AS ALERT-BOX INFORMATION.
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
            MESSAGE "Cliente N�o Cadastrado" VIEW-AS ALERT-BOX ERROR.
            UNDO.
        END.
        
     DISPLAY cliente.cli_razaosocial @ vcli_razao WITH FRAME f-dados.
     
     FIND representante WHERE
            representante.rep_cod = vrep_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL representante THEN
         DO:
             MESSAGE "Representante N�o Cadastrado" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
     DISPLAY representante.rep_nome @ vrep_nome WITH FRAME f-dados.
          
     FIND transportadora WHERE
            transportadora.tsp_codigo = vtsp_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL transportadora THEN
         DO:
             MESSAGE "Transportadora N�o Cadastrada" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
     DISPLAY transportadora.tsp_nome @ vtsp_nome WITH FRAME f-dados.
     
     FIND formapagamento WHERE
            formapagamento.fop_codigo = vfop_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL formapagamento THEN
         DO:
             MESSAGE "Forma de Pagamento N�o Cadastrada" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
     DISPLAY formapagamento.fop_descricao @ vfop_descricao WITH FRAME f-dados.
     
     FIND tipopagamento WHERE
            tipopagamento.tip_codigo = vtip_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL tipopagamento THEN
         DO:
             MESSAGE "Tipo de Pagamento N�o Cadastrada" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
     DISPLAY tipopagamento.tip_descricao @ vtip_descricao WITH FRAME f-dados.
            
     DISPLAY vpds_codigo
             vped_entrega
            WITH FRAME f-dados.
     
     FIND pedidosituacao WHERE
            pedidosituacao.pds_codigo = vpds_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL pedidosituacao THEN
         DO:
             MESSAGE "Situa��o de Pedido N�o Cadastrada" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
         
     DISPLAY pedidosituacao.pds_desc @ vpds_desc WITH FRAME f-dados.
     
     FIND cfop WHERE
        cfop.cfo_codigo = vcfo_codigo
        NO-LOCK NO-ERROR.
        
     IF NOT AVAIL cfop THEN
         DO:
             MESSAGE "C�digo Fiscal de Opera��o N�o Cadastrada" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.    

     FIND cliente WHERE cliente.cli_codigo = vcli_codigo
     NO-LOCK NO-ERROR.
  
     IF NOT AVAIL cliente THEN
        DO:
            MESSAGE "Cliente N�o Cadastrado" VIEW-AS ALERT-BOX ERROR.
            UNDO.
        END.
        
     DISPLAY cliente.cli_razaosocial @ vcli_razao WITH FRAME f-dados.
    
     FIND representante WHERE
            representante.rep_cod = vrep_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL representante THEN
         DO:
             MESSAGE "Representante N�o Cadastrado" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
     DISPLAY representante.rep_nome @ vrep_nome WITH FRAME f-dados.
    
     FIND transportadora WHERE
            transportadora.tsp_codigo = vtsp_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL transportadora THEN
         DO:
             MESSAGE "Transportadora N�o Cadastrada" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
     DISPLAY transportadora.tsp_nome @ vtsp_nome WITH FRAME f-dados.
    
     FIND formapagamento WHERE
            formapagamento.fop_codigo = vfop_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL formapagamento THEN
         DO:
             MESSAGE "Forma de Pagamento N�o Cadastrada" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
     DISPLAY formapagamento.fop_descricao @ vfop_descricao WITH FRAME f-dados.
 
     FIND tipopagamento WHERE
            tipopagamento.tip_codigo = vtip_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL tipopagamento THEN
         DO:
             MESSAGE "Tipo de Pagamento N�o Cadastrada" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
     DISPLAY tipopagamento.tip_descricao @ vtip_descricao WITH FRAME f-dados.

     FIND pedidosituacao WHERE
            pedidosituacao.pds_codigo = vpds_codigo
            NO-LOCK NO-ERROR.
     
     IF NOT AVAIL pedidosituacao THEN
         DO:
             MESSAGE "Situa��o de Pedido N�o Cadastrada" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END.
         
     DISPLAY pedidosituacao.pds_desc @ vpds_desc WITH FRAME f-dados.

     FIND cfop WHERE
        cfop.cfo_codigo = vcfo_codigo
        NO-LOCK NO-ERROR.
        
     IF NOT AVAIL cfop THEN
         DO:
             MESSAGE "C�digo Fiscal de Opera��o N�o Cadastrada" VIEW-AS ALERT-BOX ERROR.
             UNDO.
         END. 
         
      DISPLAY cfop.cfo_descricao @ vcfo_descricao WITH FRAME f-dados.
      
      UPDATE vcli_codigo VALIDATE(CAN-FIND(FIRST cliente WHERE 
                                cliente.cli_codigo = vcli_codigo),
                                "Cliente N�o Cadastrado")
           vorc_codigo
           vrep_codigo  VALIDATE(CAN-FIND(FIRST representante WHERE
                                representante.rep_codigo = vrep_codigo),
                                "Representante n�o Cadastrado")
           vtsp_codigo  VALIDATE(CAN-FIND(FIRST transportadora WHERE                    
                                transportadora.tsp_codigo = vtsp_codigo),
                                "Transportadora N�o Cadastrada")
           vfop_codigo  VALIDATE(CAN-FIND(FIRST formapagamento WHERE
                                formapagamento.fop_codigo = vfop_codigo),
                                "Forma de Pagamento N�o Cadastrada")
           vtip_codigo  VALIDATE(CAN-FIND(FIRST tipopagamento WHERE
                                tipopagamento.tip_codigo = vtip_codigo),
                                "Tipo de Pagamento N�o Cadastrado")
           vpds_codigo  VALIDATE(CAN-FIND(FIRST pedidosituacao WHERE                     
                                pedidosituacao.pds_codigo = vpds_codigo),
                                "Situa��o de Pedido N�o Cadastrada")
           vped_entrega VALIDATE(vped_entrega >= TODAY,
                                 "Data de Entrega Inv�lida")
           vnfe_num
           vcfo_codigo  VALIDATE(CAN-FIND(FIRST cfop WHERE 
                                cfop.cfo_codigo = vcfo_codigo),
                                "C�digo Fiscal de Opera��o N�o Cadastrada")                     
           WITH FRAME f-dados.
      
      UPDATE vconfirma LABEL "Deseja Alterar o Pedido (Sim/N�o)?"
        WITH FRAME f-confirma
        SIDE-LABELS
        ROW 21
        NO-BOX
        THREE-D
        WIDTH 80.
        
      IF vconfirma = NO THEN
            UNDO.
            
      ASSIGN Pedido.ped_codigo  = vped_codigo
             Pedido.ped_emissao = vped_emissao
             Pedido.cli_codigo  = vcli_codigo
             Pedido.orc_codigo  = vorc_codigo
             Pedido.rep_codigo  = vrep_codigo
             Pedido.tsp_codigo  = vtsp_codigo
             Pedido.fop_codigo  = vfop_codigo
             Pedido.tip_codigo  = vtip_codigo
             Pedido.pds_codigo  = vpds_codigo
             Pedido.ped_entrega = vped_entrega
             Pedido.nfe_num     = vnfe_num
             Pedido.cfo_codigo  = vcfo_codigo.
      MESSAGE "Pedido: " vped_codigo "alterado com sucesso"
            VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
END.
