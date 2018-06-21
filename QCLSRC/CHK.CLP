             PGM        PARM(&NAME &VAR)

          /* ------------------------------------------------------- */
          /* Declare parameter-variables                             */
          /* ------------------------------------------------------- */
             DCL        VAR(&NAME) TYPE(*CHAR) LEN(10)
             DCL        VAR(&VAR)  TYPE(*CHAR) LEN(40)

             DCL        VAR(&STRDTA) TYPE(*CHAR) LEN(3)
             DCL        VAR(&STRPOS) TYPE(*DEC) LEN(3 0)
             DCL        VAR(&STRVAL) TYPE(*CHAR) LEN(50)

             RTVDTAARA  DTAARA(MIDDA/CHECK (1 3)) RTNVAR(&STRDTA)
             CHGVAR     VAR(&STRVAL) VALUE(&NAME *CAT ' : ' *CAT &VAR)
             CHGVAR     VAR(&STRPOS) VALUE(&STRDTA)
             CHGDTAARA  DTAARA(MIDDA/CHECK (&STRPOS 50)) +
                          VALUE(&STRVAL)

             CALL       PGM(LNS001CL) PARM('CAFB0W0')

             CHGVAR     VAR(&STRPOS) VALUE(&STRPOS + 50)
             CHGVAR     VAR(&STRDTA) VALUE(&STRPOS)
             CHGDTAARA  DTAARA(MIDDA/CHECK (1 3)) VALUE(&STRDTA)
             ENDPGM
