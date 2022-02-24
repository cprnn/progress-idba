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
                 
              DISPLAY cfop.cfo_descricao @ vcfo_descricao WITH FRAME f-dados.
