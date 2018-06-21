/*********************************************************************/
/*                                                                   */
/*            RELEASE PROCESSING AID  (RPA)€                        */
/*                                                                   */
/*  Program:   RPI002C  Integrate USRFD's in new version             */
/*             Depending command: INTUSRFD                           */
/*                                                                   */
/*  Author:    Frans van Gils                                        */
/*  Date:      Maart 1991                                            */
/*  Release:   1.1                                                   */
/*                                                                   */
/*                                                                   */
/*********************************************************************/
/*                                                                   */
             PGM        PARM(&MEMBER &SRCFIL &STDLIB &PTFMBR &PTFSRF +
                          &PTFLIB &USRMBR &USRSRF &USRLIB &EXTFMT +
                          &EXTLIB &MODN &CMPFRC &CMPTOC &CMPCM +
                          &JOBD &HLDJOB &PRTMOD &PRTNEW &PHASE)

 /* ---------------------------------------------------------------- */
 /*  Declare program parameters                                      */
 /* ---------------------------------------------------------------- */
             DCL        VAR(&MEMBER) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SRCFIL) TYPE(*CHAR) LEN(10)
             DCL        VAR(&STDLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PTFMBR) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PTFSRF) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PTFLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&USRMBR) TYPE(*CHAR) LEN(10)
             DCL        VAR(&USRSRF) TYPE(*CHAR) LEN(10)
             DCL        VAR(&USRLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&EXTFMT) TYPE(*CHAR) LEN(1)
             DCL        VAR(&EXTLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&MODN)   TYPE(*CHAR) LEN(10)
             DCL        VAR(&CMPFRC) TYPE(*CHAR) LEN(3)
             DCL        VAR(&CMPTOC) TYPE(*CHAR) LEN(3)
             DCL        VAR(&CMPCM)  TYPE(*CHAR) LEN(1)
             DCL        VAR(&JOBD)   TYPE(*CHAR) LEN(10)
             DCL        VAR(&HLDJOB) TYPE(*CHAR) LEN(1)
             DCL        VAR(&PRTMOD) TYPE(*CHAR) LEN(1)
             DCL        VAR(&PRTNEW) TYPE(*CHAR) LEN(1)
             DCL        VAR(&PHASE)  TYPE(*CHAR) LEN(1)

 /* ---------------------------------------------------------------- */
 /*  Declare local variables                                         */
 /* ---------------------------------------------------------------- */
             DCL        VAR(&SRCTYP) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SRCTXT) TYPE(*CHAR) LEN(50)
             DCL        VAR(&TYP)    TYPE(*CHAR) LEN(3)
             DCL        VAR(&INTMODSRF) TYPE(*CHAR) LEN(10)
             DCL        VAR(&INTPTFSRF) TYPE(*CHAR) LEN(10)
             DCL        VAR(&INTNEWSRF) TYPE(*CHAR) LEN(10)
             DCL        VAR(&MSGDTA) TYPE(*CHAR) LEN(256)
             DCL        VAR(&CNYNAM) TYPE(*CHAR) LEN(10)
             DCL        VAR(&RLSID)  TYPE(*CHAR) LEN(10)
             DCL        VAR(&RPALIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&STAT)   TYPE(*CHAR) LEN(5)
             DCL        VAR(&SSTLEN) TYPE(*DEC)  LEN(2)
             DCL        VAR(&RECLEN) TYPE(*DEC)  LEN(15 6)

 /* ---------------------------------------------------------------- */
 /*  Install global error monitor                                    */
 /* ---------------------------------------------------------------- */
             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERROR))

 /* ---------------------------------------------------------------- */
 /*  Active application                                              */
 /* ---------------------------------------------------------------- */
             CALL       PGM(OMX001) PARM('2' 'OMSSC' '2' &STAT)

 /* ---------------------------------------------------------------- */
 /*  Define internal file name for Modified source                   */
 /* ---------------------------------------------------------------- */
             CHGVAR     VAR(&SSTLEN) VALUE(1)
             CHGVAR     VAR(&INTMODSRF) VALUE(&USRSRF)
 INTM1:      CHGVAR     VAR(&SSTLEN) VALUE(&SSTLEN + 1)
             IF         COND(&SSTLEN *GT 10) THEN(GOTO CMDLBL(INTM9))

             IF         COND(%SST(&USRSRF &SSTLEN 1) *EQ ' ') THEN(DO)
             CHGVAR     VAR(%SST(&INTMODSRF &SSTLEN 1)) VALUE('@')
             GOTO       CMDLBL(INTM9)
             ENDDO

             GOTO       CMDLBL(INTM1)
 INTM9:

 /* ---------------------------------------------------------------- */
 /*  Check existance of internal format of Modified source           */
 /* ---------------------------------------------------------------- */
             CHKOBJ     OBJ(&USRLIB/&INTMODSRF) OBJTYPE(*FILE) +
                          MBR(&USRMBR)

             MONMSG     MSGID(CPF0000) EXEC(DO)
             CHGVAR     VAR(&MSGDTA) VALUE(' ')
             CHGVAR     VAR(%SST(&MSGDTA  1 10)) VALUE(&USRMBR)
             CHGVAR     VAR(%SST(&MSGDTA 11 10)) VALUE(&INTMODSRF)
             CHGVAR     VAR(%SST(&MSGDTA 21 10)) VALUE(&USRLIB)
             SNDPGMMSG  MSGID(INT0001) MSGF(RPAMSG) MSGDTA(&MSGDTA)
             GOTO CMDLBL(ERROR)
             ENDDO

 /* ---------------------------------------------------------------- */
 /*  CRTUSRFD for new version                                        */
 /* ---------------------------------------------------------------- */
             CRTUSRFD   MEMBER(&MEMBER) SRCFIL(&SRCFIL) +
                          STDLIB(&STDLIB) MDFMBR(&PTFMBR) +
                          MDFSRF(&PTFSRF) MDFLIB(&PTFLIB) +
                          USRMBR(&USRMBR) USRSRF(&USRSRF) +
                          USRLIB(&USRLIB) EXTFMT(&EXTFMT) +
                          EXTLIB(&EXTLIB) MODN(&MODN) +
                          CMPFR(&CMPFRC) CMPTO(&CMPTOC) +
                          CMPCM(&CMPCM) JOBD(&JOBD) HLDJOB(&HLDJOB) +
                          PRTMOD(&PRTMOD) PHASE(#)

 /* ---------------------------------------------------------------- */
 /*  Define internal file name for PTF source                        */
 /* ---------------------------------------------------------------- */
             CHGVAR     VAR(&SSTLEN) VALUE(1)
             CHGVAR     VAR(&INTPTFSRF) VALUE(&USRSRF)
 INTP1:      CHGVAR     VAR(&SSTLEN) VALUE(&SSTLEN + 1)
             IF         COND(&SSTLEN *GT 10) THEN(GOTO CMDLBL(INTP9))

             IF         COND(%SST(&USRSRF &SSTLEN 1) *EQ ' ') THEN(DO)
             CHGVAR     VAR(%SST(&INTPTFSRF &SSTLEN 1)) VALUE('#')
             GOTO       CMDLBL(INTP9)
             ENDDO

             GOTO       CMDLBL(INTP1)
 INTP9:

 /* ---------------------------------------------------------------- */
 /*  Check existance of internal format of PTF source                */
 /* ---------------------------------------------------------------- */
             CHKOBJ     OBJ(&USRLIB/&INTPTFSRF) OBJTYPE(*FILE) +
                          MBR(&USRMBR)

             MONMSG     MSGID(CPF0000) EXEC(DO)
             CHGVAR     VAR(&MSGDTA) VALUE(' ')
             CHGVAR     VAR(%SST(&MSGDTA  1 10)) VALUE(&USRMBR)
             CHGVAR     VAR(%SST(&MSGDTA 11 10)) VALUE(&INTPTFSRF)
             CHGVAR     VAR(%SST(&MSGDTA 21 10)) VALUE(&USRLIB)
             SNDPGMMSG  MSGID(INT0001) MSGF(RPAMSG) MSGDTA(&MSGDTA)
             GOTO CMDLBL(ERROR)
             ENDDO

 /* ---------------------------------------------------------------- */
 /*  Retreive source type                                            */
 /* ---------------------------------------------------------------- */
             CHGVAR     VAR(&SRCTYP) VALUE(' ')
             RTVMBRD    FILE(&PTFLIB/&PTFSRF) MBR(&PTFMBR) +
                          SRCTYPE(&SRCTYP) TEXT(&SRCTXT)
             IF         COND(&SRCTYP *EQ ' ') THEN(DO)
             CALL     PGM(RPA103C) PARM(&PTFMBR &SRCTYP)
             ENDDO
             CHGVAR     VAR(&TYP) VALUE(%SST(&SRCTYP 1 3))

 /* ---------------------------------------------------------------- */
 /*  Make workmembers and set overrides                              */
 /* ---------------------------------------------------------------- */
             RTVOBJD    OBJ(RPI002C) OBJTYPE(*PGM) RTNLIB(&RPALIB)
             OVRDBF     FILE(RPA113) TOFILE(&USRLIB/&INTMODSRF) +
                          MBR(&USRMBR)
             OVRDBF     FILE(RPA114) TOFILE(&USRLIB/&INTPTFSRF) +
                          MBR(&USRMBR)

             ADDPFM     FILE(RPA115) MBR(&USRMBR)
             MONMSG     MSGID(CPF0000)
             CLRPFM     FILE(RPA115) MBR(&USRMBR)
             OVRDBF     FILE(RPA115) TOFILE(*LIBL/RPA115) MBR(&USRMBR)

             ADDPFM     FILE(RPA116) MBR(&USRMBR)
             MONMSG     MSGID(CPF0000)
             CLRPFM     FILE(RPA116) MBR(&USRMBR)
             OVRDBF     FILE(RPA116) TOFILE(*LIBL/RPA116) MBR(&USRMBR)

             ADDPFM     FILE(RPA117) MBR(&USRMBR)
             MONMSG     MSGID(CPF0000)
             CLRPFM     FILE(RPA117) MBR(&USRMBR)
             OVRDBF     FILE(RPA117) TOFILE(*LIBL/RPA117) MBR(&USRMBR)

             ADDPFM     FILE(RPA105) MBR(&USRMBR)
             MONMSG     MSGID(CPF0000)
             CLRPFM     FILE(RPA105) MBR(&USRMBR)
             OVRDBF     FILE(RPA105) TOFILE(*LIBL/RPA105) MBR(&USRMBR)

 /* ---------------------------------------------------------------- */
 /*  Process inserts                                                 */
 /* ---------------------------------------------------------------- */
             CALL       PGM(RPA116) PARM(&TYP &USRMBR &SRCTXT)

 /* ---------------------------------------------------------------- */
 /*  Process deletes                                                 */
 /* ---------------------------------------------------------------- */
             CALL       PGM(RPA117) PARM(&TYP &USRMBR &SRCTXT)

 /* ---------------------------------------------------------------- */
 /*  Define internal file name for NEW source                        */
 /* ---------------------------------------------------------------- */
             CHGVAR     VAR(&SSTLEN) VALUE(1)
             CHGVAR     VAR(&INTNEWSRF) VALUE(&USRSRF)
 INTN1:      CHGVAR     VAR(&SSTLEN) VALUE(&SSTLEN + 1)
             IF         COND(&SSTLEN *GT 10) THEN(GOTO CMDLBL(INTN9))

             IF         COND(%SST(&USRSRF &SSTLEN 1) *EQ ' ') THEN(DO)
             CHGVAR     VAR(%SST(&INTNEWSRF &SSTLEN 1)) VALUE('$')
             GOTO       CMDLBL(INTN9)
             ENDDO

             GOTO       CMDLBL(INTN1)
 INTN9:

 /* ---------------------------------------------------------------- */
 /*  Create internal file name for NEW source                        */
 /* ---------------------------------------------------------------- */
             CHKOBJ     OBJ(&USRLIB/&INTNEWSRF) OBJTYPE(*FILE) +
                          MBR(&USRMBR)
             MONMSG     MSGID(CPF9815)
             MONMSG     MSGID(CPF9801) EXEC(DO)
             CRTDUPOBJ  OBJ(RPA117) FROMLIB(&RPALIB) OBJTYPE(*FILE) +
                          TOLIB(&USRLIB) NEWOBJ(&INTNEWSRF)
             RMVM       FILE(&USRLIB/&INTNEWSRF) MBR(*ALL)
             ENDDO
             RMVM       FILE(&USRLIB/&INTNEWSRF) MBR(&USRMBR)
             MONMSG     MSGID(CPF0000)
             ADDPFM     FILE(&USRLIB/&INTNEWSRF) MBR(&USRMBR) +
                          TEXT(&SRCTXT)

 /* ---------------------------------------------------------------- */
 /*  Fill userfile internal format (RPA117)                          */
 /* ---------------------------------------------------------------- */
             CPYF       FROMFILE(&RPALIB/RPA117) +
                          TOFILE(&USRLIB/&INTNEWSRF) +
                          FROMMBR(&USRMBR) TOMBR(&USRMBR) MBROPT(*ADD)

 /* ---------------------------------------------------------------- */
 /*  Check userfile and usermember external format (Source)          */
 /* ---------------------------------------------------------------- */
             CHKOBJ     OBJ(&USRLIB/&USRSRF) OBJTYPE(*FILE) +
                          MBR(&USRMBR)
             MONMSG     MSGID(CPF9815)
             MONMSG     MSGID(CPF9801) EXEC(DO)
             CALL       PGM(OMX919C) PARM(&PTFSRF &PTFLIB &RECLEN +
                          &STAT)
             CRTSRCPF   FILE(&USRLIB/&USRSRF) RCDLEN(&RECLEN) +
                          TEXT('Generated by RPA')
             ENDDO
             RMVM       FILE(&USRLIB/&USRSRF) MBR(&USRMBR)
             MONMSG     MSGID(CPF0000)
             CPYF       FROMFILE(&PTFLIB/&PTFSRF) +
                          TOFILE(&USRLIB/&USRSRF) FROMMBR(&USRMBR) +
                          TOMBR(&USRMBR) MBROPT(*ADD) NBRRCDS(1)
             CLRPFM     FILE(&USRLIB/&USRSRF) MBR(&USRMBR)

 /* ---------------------------------------------------------------- */
 /*  Fill userfile external format (SOURCE)                          */
 /* ---------------------------------------------------------------- */
             OVRDBF     FILE(RPA420) TOFILE(&USRLIB/&INTNEWSRF) +
                          MBR(&USRMBR)
             OVRDBF     FILE(RPAOUT) TOFILE(&USRLIB/&USRSRF) +
                          MBR(&USRMBR) LVLCHK(*NO) SEQONLY(*YES)

             CALL       PGM(RPA424) PARM(&SRCTYP)

 /* ---------------------------------------------------------------- */
 /*  Print messages                                                  */
 /* ---------------------------------------------------------------- */
             DLTOVR     FILE(*ALL)
             ADDLFM     FILE(&RPALIB/RPA108) MBR(&USRMBR) +
                          DTAMBRS((&RPALIB/RPA105 (&USRMBR)))
             MONMSG     MSGID(CPF0000)
             OVRDBF     FILE(RPA108) TOFILE(&RPALIB/RPA108) +
                          MBR(&USRMBR)
             CALL       PGM(RPA119) PARM(&CNYNAM &RLSID)

 /* ---------------------------------------------------------------- */
 /*  Print new modifications                                         */
 /* ---------------------------------------------------------------- */
             IF         COND(&PRTNEW *EQ 'Y') THEN(DO)

             DSPUSRFD   USRMBR(&USRMBR) USRSRF(&USRSRF) +
                          USRLIB(&USRLIB) PRTTYP($)

             ENDDO

 /* ---------------------------------------------------------------- */
 /*  Do the cleaning                                                 */
 /* ---------------------------------------------------------------- */
             DLTOVR     FILE(*ALL)
             RMVM       FILE(RPA115) MBR(&USRMBR)
             MONMSG     MSGID(CPF0000)
             RMVM       FILE(RPA116) MBR(&USRMBR)
             MONMSG     MSGID(CPF0000)
             RMVM       FILE(RPA117) MBR(&USRMBR)
             MONMSG     MSGID(CPF0000)
             RMVM       FILE(RPA108) MBR(&USRMBR)
             MONMSG     MSGID(CPF0000)
             RMVM       FILE(RPA105) MBR(&USRMBR)
             MONMSG     MSGID(CPF0000)

 /* ---------------------------------------------------------------- */
 /*  GOTO end of program                                             */
 /* ---------------------------------------------------------------- */
             GOTO       CMDLBL(LAB999)

 /* ---------------------------------------------------------------- */
 /*  ERROR routine                                                   */
 /* ---------------------------------------------------------------- */
 ERROR:      SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('''** +
                          RPA **. Error found on INTUSRFD-command. +
                          See low level messages for specific +
                          reason. RPA-USRFD integration not +
                          executed!') MSGTYPE(*ESCAPE)
             MONMSG     MSGID(CPF0000)

 LAB999:     ENDPGM
