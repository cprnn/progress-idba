DEF VAR vcliente AS INTEGER LABEL "Código Cliente".

REPEAT:

	UPDATE vcliente WITH FRAME f-cliente SIDE-LABELS CENTERED TITLE " Dados Cliente " ROW 4 WIDTH 70 THREE-D.

	FIND customer WHERE
	customer.cust-num = vcliente
	NO-LOCK NO-ERROR.

		IF NOT AVAILABLE customer THEN
			DO:
			MESSAGE "Registro: " vcliente " Não está cadastrado" VIEW-AS ALERT-BOX ERROR.
			UNDO.
		END.

	DISPLAY customer.NAME NO-LABEL
	WITH FRAME f-cliente.

END.