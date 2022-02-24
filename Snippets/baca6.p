DEF VAR vencimento AS DATE.
DEF VAR dias AS INT.
DEF VAR cont AS INT.

REPEAT:
	UPDATE dias.

	IF dias = 0 THEN
	DO:
	MESSAGE "A Quantidade de dias não pode ser zero" VIEW-AS ALERT-BOX.
	UNDO.
	END.

	ASSIGN vencimento = TODAY + dias.

	DO cont = 1 TO 3:

	IF WEEKDAY(vencimento) = 7 THEN ASSIGN vencimento = vencimento + 2.
	IF WEEKDAY(vencimento) = 1 THEN ASSIGN vencimento = vencimento + 1.

	FIND feriado WHERE
	feriado.fer_data = vencimento
	NO-LOCK NO-ERROR.

	IF AVAIL feriado THEN ASSIGN vencimento = vencimento + 1.
END.

DISPLAY vencimento.
END.