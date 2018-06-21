             CMD        PROMPT('Create Impact Analysis Data')

             PARM       KWD(OBJDTA) TYPE(LIST1) MIN(1) MAX(20) +
                          PROMPT('Object data')

             PARM       KWD(DETAIL) TYPE(*CHAR) LEN(9) RSTD(*YES) +
                          DFT(*COMPLETE) VALUES(*COMPLETE *SINGLE) +
                          PROMPT('Detail')

             PARM       KWD(OUTPUT) TYPE(*CHAR) LEN(8) RSTD(*YES) +
                          DFT(*PRINT) VALUES(*PRINT *OUTFILE *BOTH) +
                          PROMPT('Output')

             PARM       KWD(OUTFILE) TYPE(OBJQUAL2) PMTCTL(OUTF) +
                          PROMPT('File to receive output')

             PARM       KWD(OUTMBR) TYPE(LIST2) MIN(0) PMTCTL(OUTF) +
                          PROMPT('Output member options')

 LIST1:      ELEM       TYPE(OBJQUAL) PROMPT('Object')

             ELEM       TYPE(*CHAR) LEN(9) CHOICE('Object type') +
                          PROMPT('Object type')

             ELEM       TYPE(*NAME) LEN(10) DFT(*NONE) SPCVAL((*NONE +
                          *NONE)) PROMPT('Detail')

             ELEM       TYPE(*NAME) LEN(10) DFT(*FIRST) +
                          SPCVAL((*FIRST *FIRST)) CHOICE(*PGM) +
                          CHOICEPGM(*LIBL/OMM0022C) PROMPT('Report')

 LIST2:      ELEM       TYPE(*NAME) LEN(10) DFT(*FIRST) +
                          SPCVAL((*FIRST *FIRST)) PROMPT('Member to +
                          receive output')
             ELEM       TYPE(*CHAR) LEN(8) RSTD(*YES) DFT(*REPLACE) +
                          VALUES(*REPLACE *ADD) PROMPT('Replace or +
                          add records')


 OBJQUAL:    QUAL       TYPE(*NAME) LEN(12)
             QUAL       TYPE(*NAME) LEN(10) PROMPT('Library')

 OBJQUAL2:   QUAL       TYPE(*NAME) LEN(10)
             QUAL       TYPE(*NAME) LEN(10) RSTD(*NO) DFT(*LIBL) +
                          SPCVAL((*LIBL *LIBL) (*CURLIB *CURLIB)) +
                          PROMPT('Library')

 OUTF:       PMTCTL     CTL(OUTPUT) COND((*EQ *OUTFILE) (*EQ *BOTH)) +
                          NBRTRUE(*EQ 1)
