DEF VAR vano    AS INT INITIAL 2022.
DEF VAR vmes    AS INT INITIAL 10.
DEF VAR vdia    AS INT INITIAL 03.
DEF VAR vdata   AS DATE.

ASSIGN vdata = DATE(vmes, vdia, vano).

DISPLAY vdata.
