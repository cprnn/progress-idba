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
        
     ON LEAVE OF vcli_codigo
         DO:
            FIND cliente WHERE
                 cliente.cli_codigo = INPUT vcli_codigo
                 NO-LOCK NO-ERROR.
                 
            IF AVAIL cliente THEN
                 DISPLAY cliente.cli_razaosocial @ vcli_razao WITH FRAME f-dados.
            ELSE
                 DISPLAY "Cliente Não Cadastrado" @ vcli_razao WITH FRAME f-dados.
         END.
         
     ON LEAVE OF vrep_codigo
         DO:
            FIND representante WHERE
                 representante.rep_codigo = INPUT vrep_codigo
                 NO-LOCK NO-ERROR.
                 
            IF AVAIL representante THEN
                 DISPLAY representante.rep_nome @ vrep_nome WITH FRAME f-dados.
            ELSE
                 DISPLAY "Representante Não Cadastrado" @ vrep_nome WITH FRAME f-dados.
         END.
         
     ON LEAVE OF vtsp_codigo
         DO:
            FIND transportadora WHERE
                 transportadora.tsp_codigo = INPUT vtsp_codigo
                 NO-LOCK NO-ERROR.
                 
            IF AVAIL transportadora THEN
                 DISPLAY transportadora.tsp_nome @ vtsp_nome WITH FRAME f-dados.
            ELSE
                 DISPLAY "Transportadora Não Cadastrado" @ vtsp_nome WITH FRAME f-dados.
         END.
         
     ON LEAVE OF vfop_codigo
        DO:
           FIND formapagamento WHERE
                formapagamento.fop_codigo = INPUT vfop_codigo
                NO-LOCK NO-ERROR.
                
           IF AVAIL formapagamento THEN
                DISPLAY formapagamento.fop_descricao @ vfop_descricao WITH FRAME f-dados.
           ELSE
                DISPLAY "Forma de Pagamento Não Cadastrado" @ vfop_descricao WITH FRAME f-dados.
        END.
     
     ON LEAVE OF vtip_codigo
        DO:
           FIND tipopagamento WHERE
                tipopagamento.tip_codigo = INPUT vtip_codigo
                NO-LOCK NO-ERROR.
                
           IF AVAIL tipopagamento THEN
                DISPLAY tipopagamento.tip_descricao @ vtip_descricao WITH FRAME f-dados.
           ELSE
                DISPLAY "Tipo de Pagamento Não Cadastrado" @ vtip_descricao WITH FRAME f-dados.
        END.
     
     ON LEAVE OF vpds_codigo
        DO:
           FIND pedidosituacao WHERE
                pedidosituacao.pds_codigo = INPUT vpds_codigo
                NO-LOCK NO-ERROR.
                
           IF AVAIL pedidosituacao THEN
                DISPLAY pedidosituacao.pds_desc @ vpds_desc WITH FRAME f-dados.
           ELSE
                DISPLAY "Tipo de Pagamento Não Cadastrado" @ vpds_desc WITH FRAME f-dados.
        END.
        
     ON LEAVE OF vcfo_codigo
        DO:
           FIND cfop WHERE
                cfop.cfo_codigo = INPUT vcfo_codigo
                NO-LOCK NO-ERROR.
                
           IF AVAIL cfop THEN
                DISPLAY cfop.cfo_descricao @ vcfo_descricao WITH FRAME f-dados.
           ELSE
                DISPLAY "Código Fiscal de Operação Não Cadastrada" @ vcfo_descricao WITH FRAME f-dados.
        END.   
        
REPEAT:
    ASSIGN vped_emissao = TODAY
           vconfirma    = NO
           vpds_codigo  = 1
           vped_entrega = TODAY + 7.
    
    DISPLAY vped_emissao WITH FRAME f-chave.
    DISPLAY vpds_codigo
            vped_entrega
            WITH FRAME f-dados.
    
    UPDATE vcli_codigo VALIDATE(CAN-FIND(FIRST cliente WHERE 
                                cliente.cli_codigo = vcli_codigo),
                                "Cliente Não Cadastrado")
           vorc_codigo
           vrep_codigo  VALIDATE(CAN-FIND(FIRST representante WHERE
                                representante.rep_codigo = vrep_codigo),
                                "Representante não Cadastrado")
           vtsp_codigo  VALIDATE(CAN-FIND(FIRST transportadora WHERE                    
                                transportadora.tsp_codigo = vtsp_codigo),
                                "Transportadora Não Cadastrada")
           vfop_codigo  VALIDATE(CAN-FIND(FIRST formapagamento WHERE
                                formapagamento.fop_codigo = vfop_codigo),
                                "Forma de Pagamento Não Cadastrada")
           vtip_codigo  VALIDATE(CAN-FIND(FIRST tipopagamento WHERE
                                tipopagamento.tip_codigo = vtip_codigo),
                                "Tipo de Pagamento Não Cadastrado")
           vpds_codigo  VALIDATE(CAN-FIND(FIRST pedidosituacao WHERE                     
                                pedidosituacao.pds_codigo = vpds_codigo),
                                "Situação de Pedido Não Cadastrada")
           vped_entrega VALIDATE(vped_entrega >= TODAY,
                                 "Data de Entrega Inválida")                     
           vcfo_codigo  VALIDATE(CAN-FIND(FIRST cfop WHERE 
                                cfop.cfo_codigo = vcfo_codigo),
                                "Código Fiscal de Operação Não Cadastrada")                     
           WITH FRAME f-dados. 

      UPDATE vconfirma LABEL "Deseja Incluir o Pedido (Sim/Não)?"
        WITH FRAME f-confirma
        SIDE-LABELS
        ROW 21
        NO-BOX
        THREE-D
        WIDTH 80.
        
      IF vconfirma = NO THEN
            UNDO.
            
      ASSIGN vped_codigo = NEXT-VALUE(ped_codigo).
      DISPLAY vped_codigo WITH FRAME f-chave.
      
      CREATE Pedido.
      ASSIGN Pedido.emp_codigo  = 1
             Pedido.est_codigo  = 1 
             Pedido.ped_codigo  = vped_codigo
             Pedido.ped_emissao = vped_emissao
             Pedido.cli_codigo  = vcli_codigo
             Pedido.orc_codigo  = vorc_codigo
             Pedido.rep_codigo  = vrep_codigo
             Pedido.tsp_codigo  = vtsp_codigo
             Pedido.fop_codigo  = vfop_codigo
             Pedido.tip_codigo  = vtip_codigo
             Pedido.pds_codigo  = vpds_codigo
             Pedido.ped_entrega = vped_entrega
             Pedido.nfe_num     = 0
             Pedido.cfo_codigo  = vcfo_codigo.
      MESSAGE "Pedido: " vped_codigo "criado com sucesso"
            VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
END.
