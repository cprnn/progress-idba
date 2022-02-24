DEF VAR vcli_razao      LIKE Cliente.cli_razaosocial.
DEF VAR vrep_nome       LIKE Representante.rep_nome.
DEF VAR vtsp_nome       LIKE Transportadora.tsp_nome.
DEF VAR vfop_descricao  LIKE FormaPagamento.fop_descricao.
DEF VAR vtip_descricao  LIKE TipoPagamento.tip_descricao.
DEF VAR vpds_desc       LIKE PedidoSituacao.pds_desc.
DEF VAR vcfo_descricao  LIKE CFOP.cfo_descricao.
DEF VAR vconfirma       AS LOGICAL FORMAT "Sim/N�o".
DEF VAR vopcao AS INTEGER FORMAT "9".

DEF TEMP-TABLE tt-pedido LIKE Pedido.

FORM tt-pedido.ped_codigo
    tt-pedido.ped_emissao COLON 62
    WITH FRAME f-chave SIDE-LABELS THREE-D WIDTH 80.
    
FORM tt-pedido.cli_codigo     COLON 18
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
        WITH FRAME f-dados SIDE-LABELS THREE-D WIDTH 80.

ON LEAVE OF tt-pedido.cli_codigo
     DO:
        FIND cliente WHERE
             cliente.cli_codigo = INPUT tt-pedido.cli_codigo
             NO-LOCK NO-ERROR.
             
        IF AVAIL cliente THEN
             DISPLAY cliente.cli_razaosocial @ vcli_razao WITH FRAME f-dados.
        ELSE
             DISPLAY "Cliente N�o Cadastrado" @ vcli_razao WITH FRAME f-dados.
     END.
 
ON LEAVE OF tt-pedido.rep_codigo
     DO:
        FIND representante WHERE
             representante.rep_codigo = INPUT tt-pedido.rep_codigo
             NO-LOCK NO-ERROR.
             
        IF AVAIL representante THEN
             DISPLAY representante.rep_nome @ vrep_nome WITH FRAME f-dados.
        ELSE
             DISPLAY "Representante N�o Cadastrado" @ vrep_nome WITH FRAME f-dados.
     END.
 
ON LEAVE OF tt-pedido.tsp_codigo
     DO:
        FIND transportadora WHERE
             transportadora.tsp_codigo = INPUT tt-pedido.tsp_codigo
             NO-LOCK NO-ERROR.
                            
        IF AVAIL transportadora THEN
             DISPLAY transportadora.tsp_nome @ vtsp_nome WITH FRAME f-dados.
        ELSE
             DISPLAY "Transportadora N�o Cadastrado" @ vtsp_nome WITH FRAME f-dados.
     END.
 
ON LEAVE OF tt-pedido.fop_codigo
    DO:
       FIND formapagamento WHERE
            formapagamento.fop_codigo = INPUT tt-pedido.fop_codigo
            NO-LOCK NO-ERROR.
            
       IF AVAIL formapagamento THEN
            DISPLAY formapagamento.fop_descricao @ vfop_descricao WITH FRAME f-dados.
       ELSE
            DISPLAY "Forma de Pagamento N�o Cadastrado" @ vfop_descricao WITH FRAME f-dados.
    END.

ON LEAVE OF tt-pedido.tip_codigo
    DO:
       FIND tipopagamento WHERE
            tipopagamento.tip_codigo = INPUT tt-pedido.tip_codigo
            NO-LOCK NO-ERROR.
            
       IF AVAIL tipopagamento THEN
            DISPLAY tipopagamento.tip_descricao @ vtip_descricao WITH FRAME f-dados.
       ELSE
            DISPLAY "Tipo de Pagamento N�o Cadastrado" @ vtip_descricao WITH FRAME f-dados.
    END.

ON LEAVE OF tt-pedido.pds_codigo
    DO:
       FIND pedidosituacao WHERE
            pedidosituacao.pds_codigo = INPUT tt-pedido.pds_codigo
            NO-LOCK NO-ERROR.
            
       IF AVAIL pedidosituacao THEN
            DISPLAY pedidosituacao.pds_desc @ vpds_desc WITH FRAME f-dados.
       ELSE
            DISPLAY "Tipo de Pagamento N�o Cadastrado" @ vpds_desc WITH FRAME f-dados.
    END.

ON LEAVE OF tt-pedido.cfo_codigo
    DO:
       FIND cfop WHERE
            cfop.cfo_codigo = INPUT tt-pedido.cfo_codigo
            NO-LOCK NO-ERROR.
            
       IF AVAIL cfop THEN
            DISPLAY cfop.cfo_descricao @ vcfo_descricao WITH FRAME f-dados.
       ELSE
            DISPLAY "C�digo Fiscal de Opera��o N�o Cadastrada" @ vcfo_descricao WITH FRAME f-dados.
    END.   

FORM "1 - Inclus�o"  AT 5 SKIP
     "2 - Altera��o" AT 5 SKIP
     "3 - Exclus�o"  AT 5 SKIP
     "4 - Consulta"  AT 5 SKIP(2)
     vopcao LABEL "Digite a opcao desejada:"
     WITH FRAME f-opcao SIDE-LABELS THREE-D CENTERED.

REPEAT:

UPDATE vopcao WITH FRAME f-opcao.

    IF vopcao = 1 THEN 
    
        REPEAT:

            EMPTY TEMP-TABLE tt-pedido.
            
            CREATE tt-pedido.
            
            ASSIGN tt-pedido.ped_emissao = TODAY
                   vconfirma             = NO
                   tt-pedido.pds_codigo  = 1
                   tt-pedido.ped_entrega = TODAY + 7.
            
            DISPLAY tt-pedido.ped_emissao WITH FRAME f-chave.
            DISPLAY tt-pedido.pds_codigo
                    tt-pedido.ped_entrega
                    WITH FRAME f-dados.
            
            UPDATE tt-pedido.cli_codigo VALIDATE(CAN-FIND(FIRST cliente WHERE 
                                        cliente.cli_codigo = tt-pedido.cli_codigo),
                                        "Cliente N�o Cadastrado")
                   tt-pedido.orc_codigo
                   tt-pedido.rep_codigo  VALIDATE(CAN-FIND(FIRST representante WHERE
                                        representante.rep_codigo = tt-pedido.rep_codigo),
                                        "Representante n�o Cadastrado")
                   tt-pedido.tsp_codigo  VALIDATE(CAN-FIND(FIRST transportadora WHERE                    
                                        transportadora.tsp_codigo = tt-pedido.tsp_codigo),
                                        "Transportadora N�o Cadastrada")
                   tt-pedido.fop_codigo  VALIDATE(CAN-FIND(FIRST formapagamento WHERE
                                        formapagamento.fop_codigo = tt-pedido.fop_codigo),
                                        "Forma de Pagamento N�o Cadastrada")
                   tt-pedido.tip_codigo  VALIDATE(CAN-FIND(FIRST tipopagamento WHERE
                                        tipopagamento.tip_codigo = tt-pedido.tip_codigo),
                                        "Tipo de Pagamento N�o Cadastrado")
                   tt-pedido.pds_codigo  VALIDATE(CAN-FIND(FIRST pedidosituacao WHERE                     
                                        pedidosituacao.pds_codigo = tt-pedido.pds_codigo),
                                        "Situa��o de Pedido N�o Cadastrada")
                   tt-pedido.ped_entrega VALIDATE(tt-pedido.ped_entrega >= TODAY,
                                         "Data de Entrega Inv�lida")                     
                   tt-pedido.cfo_codigo  VALIDATE(CAN-FIND(FIRST cfop WHERE 
                                        cfop.cfo_codigo = tt-pedido.cfo_codigo),
                                        "C�digo Fiscal de Opera��o N�o Cadastrada")                     
                   WITH FRAME f-dados. 

              UPDATE vconfirma LABEL "Deseja Incluir o Pedido (Sim/N�o)?"
                WITH FRAME f-confirma SIDE-LABELS ROW 21 NO-BOX THREE-D WIDTH 80.
                
              IF vconfirma = NO THEN
                    UNDO.
                    
              ASSIGN tt-pedido.ped_codigo = NEXT-VALUE(ped_codigo).
              DISPLAY tt-pedido.ped_codigo WITH FRAME f-chave.
              
              CREATE Pedido.
              ASSIGN Pedido.emp_codigo  = 1
                     Pedido.est_codigo  = 1 
                     Pedido.ped_codigo  = tt-pedido.ped_codigo
                     Pedido.ped_emissao = tt-pedido.ped_emissao
                     Pedido.cli_codigo  = tt-pedido.cli_codigo
                     Pedido.orc_codigo  = tt-pedido.orc_codigo
                     Pedido.rep_codigo  = tt-pedido.rep_codigo
                     Pedido.tsp_codigo  = tt-pedido.tsp_codigo
                     Pedido.fop_codigo  = tt-pedido.fop_codigo
                     Pedido.tip_codigo  = tt-pedido.tip_codigo
                     Pedido.pds_codigo  = tt-pedido.pds_codigo
                     Pedido.ped_entrega = tt-pedido.ped_entrega
                     Pedido.nfe_num     = 0
                     Pedido.cfo_codigo  = tt-pedido.cfo_codigo.
              MESSAGE "Pedido: " tt-pedido.ped_codigo "criado com sucesso"
                    VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
        END.
    
    IF vopcao = 2 THEN 
    
        DO:
            ASSIGN vconfirma = NO.

            EMPTY TEMP-TABLE tt-pedido.
            
            CREATE tt-pedido.

            UPDATE tt-pedido.ped_codigo WITH FRAME f-chave.
            
            FIND pedido WHERE
                pedido.ped_codigo = tt-pedido.ped_codigo
                EXCLUSIVE-LOCK NO-ERROR.
                
            IF NOT AVAIL pedido THEN
                DO:
                    MESSAGE "Pedido n�o Cadastrado" VIEW-AS ALERT-BOX INFORMATION.
                END.

            {c:\cursoprogress\Fontes\monta_tela.i}
              
              UPDATE tt-pedido.cli_codigo VALIDATE(CAN-FIND(FIRST cliente WHERE 
                                        cliente.cli_codigo = tt-pedido.cli_codigo),
                                        "Cliente N�o Cadastrado")
                   tt-pedido.orc_codigo
                   tt-pedido.rep_codigo  VALIDATE(CAN-FIND(FIRST representante WHERE
                                        representante.rep_codigo = tt-pedido.rep_codigo),
                                        "Representante n�o Cadastrado")
                   tt-pedido.tsp_codigo  VALIDATE(CAN-FIND(FIRST transportadora WHERE                    
                                        transportadora.tsp_codigo = tt-pedido.tsp_codigo),
                                        "Transportadora N�o Cadastrada")
                   tt-pedido.fop_codigo  VALIDATE(CAN-FIND(FIRST formapagamento WHERE
                                        formapagamento.fop_codigo = tt-pedido.fop_codigo),
                                        "Forma de Pagamento N�o Cadastrada")
                   tt-pedido.tip_codigo  VALIDATE(CAN-FIND(FIRST tipopagamento WHERE
                                        tipopagamento.tip_codigo = tt-pedido.tip_codigo),
                                        "Tipo de Pagamento N�o Cadastrado")
                   tt-pedido.pds_codigo  VALIDATE(CAN-FIND(FIRST pedidosituacao WHERE                     
                                        pedidosituacao.pds_codigo = tt-pedido.pds_codigo),
                                        "Situa��o de Pedido N�o Cadastrada")
                   tt-pedido.ped_entrega VALIDATE(tt-pedido.ped_entrega >= TODAY,
                                         "Data de Entrega Inv�lida")
                   tt-pedido.nfe_num
                   tt-pedido.cfo_codigo  VALIDATE(CAN-FIND(FIRST cfop WHERE 
                                        cfop.cfo_codigo = tt-pedido.cfo_codigo),
                                        "C�digo Fiscal de Opera��o N�o Cadastrada")                     
                   WITH FRAME f-dados.
              
              UPDATE vconfirma LABEL "Deseja Alterar o Pedido (Sim/N�o)?"
                WITH FRAME f-confirma2 SIDE-LABELS ROW 21 NO-BOX THREE-D WIDTH 80.
                
              IF vconfirma = NO THEN
                    UNDO.
                    
              ASSIGN Pedido.ped_codigo  = tt-pedido.ped_codigo
                     Pedido.ped_emissao = tt-pedido.ped_emissao
                     Pedido.cli_codigo  = tt-pedido.cli_codigo
                     Pedido.orc_codigo  = tt-pedido.orc_codigo
                     Pedido.rep_codigo  = tt-pedido.rep_codigo
                     Pedido.tsp_codigo  = tt-pedido.tsp_codigo
                     Pedido.fop_codigo  = tt-pedido.fop_codigo
                     Pedido.tip_codigo  = tt-pedido.tip_codigo
                     Pedido.pds_codigo  = tt-pedido.pds_codigo
                     Pedido.ped_entrega = tt-pedido.ped_entrega
                     Pedido.nfe_num     = tt-pedido.nfe_num
                     Pedido.cfo_codigo  = tt-pedido.cfo_codigo.
              MESSAGE "Pedido: " tt-pedido.ped_codigo "alterado com sucesso"
                    VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
                END.
    
    IF vopcao = 3 THEN 
    
        DO:
            ASSIGN vconfirma = NO.
            
            EMPTY TEMP-TABLE tt-pedido.
            
            CREATE tt-pedido.
            
            UPDATE tt-pedido.ped_codigo WITH FRAME f-chave.
            
            FIND pedido WHERE
                pedido.ped_codigo = tt-pedido.ped_codigo
                EXCLUSIVE-LOCK NO-ERROR.
                
            IF NOT AVAIL pedido THEN
                DO:
                    MESSAGE "Pedido n�o Cadastrado" VIEW-AS ALERT-BOX INFORMATION.
                    UNDO.
                END.
            
            {c:\cursoprogress\Fontes\monta_tela.i}
            
            //Aqui come�a a exclusao
             
              UPDATE vconfirma LABEL "Deseja Excluir o Pedido (Sim/N�o)?"
                WITH FRAME f-confirma3
                SIDE-LABELS
                ROW 21
                NO-BOX
                THREE-D
                WIDTH 80.
                
              IF vconfirma = NO THEN
                    UNDO.
                    
              DELETE pedido.
              
              MESSAGE "Pedido: " tt-pedido.ped_codigo "exclu�do com sucesso"
                    VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
                END.
    
    IF vopcao = 4 THEN 
    
        DO:
            ASSIGN vconfirma = NO.
            
            EMPTY TEMP-TABLE tt-pedido.
            
            CREATE tt-pedido.

            UPDATE tt-pedido.ped_codigo WITH FRAME f-chave.

            FIND pedido WHERE
                pedido.ped_codigo = tt-pedido.ped_codigo
                EXCLUSIVE-LOCK NO-ERROR.
                
            IF NOT AVAIL pedido THEN
                DO:
                    MESSAGE "Pedido n�o Cadastrado" VIEW-AS ALERT-BOX INFORMATION.
                    UNDO.
                END.
            
            {c:\cursoprogress\Fontes\monta_tela.i}    
             
            PAUSE.
          END.
    
    IF vopcao = 9 THEN LEAVE.
    
END.
