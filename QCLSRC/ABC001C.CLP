             PGM

             DCL        VAR(&CMD) TYPE(*CHAR) LEN(2000)
             DCL        VAR(&CMDLEN) TYPE(*DEC) LEN(15 5)

             CALL       PGM(QCMDEXC) PARM(&CMD &CMDLEN)
             CALL       PGM(LNS001CL) PARM('CAFB0W0')
             call       PGM14

             ENDPGM
