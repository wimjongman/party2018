       PROCESS APOST.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. RPA118B.
      *****************************************************************
      *                                                               *
      *       RELEASE PROCESSING AID  (RPA)€                         *
      *                                                               *
      *  Program:   RPA117 - Process ideletions in source file        *
      *                                                               *
      *  Author:    Jurjen D. Oostenveld                              *
      *  Date:      October 1989                                      *
      *  Release:   1.1                                               *
      *                                                               *
      *    This program reads the 'intermediate' source member and    *
      *    the source member from LIBUSRSRC and processes the DELETE  *
      *    blocks of the USRFD mofifications.                         *
      *    The generated output file is the new modified source file. *
      *                                                               *
      *****************************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-S38.
       OBJECT-COMPUTER. IBM-S38.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT RPA113 ASSIGN TO DATABASE-RPA113.
           SELECT RPA115 ASSIGN TO DATABASE-RPA115
                  ORGANIZATION RELATIVE
                  ACCESS RANDOM
                  RELATIVE W14-KEY.
           SELECT RPA116 ASSIGN TO DATABASE-RPA116.
           SELECT RPA117 ASSIGN TO DATABASE-RPA117.
           SELECT RPA121 ASSIGN TO DATABASE-RPA121.
           SELECT RPA105 ASSIGN TO DATABASE-RPA105.
       DATA DIVISION.
       FILE SECTION.
      *****************************************************************
      *    Modified source file                                       *
      *****************************************************************
       FD  RPA113
           LABEL RECORDS ARE STANDARD.
       01  RPA113R.
           03  SEQ113                        PIC X(06).
           03  CHG113                        PIC X(01).
           03  BLK113                        PIC X(01).
           03  DTA113.
               05  FILLER                    PIC X(06).
               05  CMT113                    PIC X(01).
               05  FILLER                    PIC X(107).
           03  KEY113                        PIC X(80).
           03  ORG113                        PIC X(06).
           03  DAT113                        PIC X(06).
           03  REF113                        PIC X(06).

      *****************************************************************
      *    Intermediate source file with INSERT blocks                *
      *****************************************************************
       FD  RPA115
           LABEL RECORDS ARE STANDARD.
       01  RPA115R.
           03  SEQ115                        PIC X(06).
           03  CHG115                        PIC X(01).
           03  BLK115                        PIC X(01).
           03  DTA115.
               05  FILLER                    PIC X(06).
               05  CMT115                    PIC X(01).
               05  FILLER                    PIC X(107).
           03  KEY115                        PIC X(80).
           03  ORG115                        PIC X(06).
           03  DAT115                        PIC X(06).
           03  REF115                        PIC X(06).

      *****************************************************************
      *    Work file to detect checkpoint                             *
      *****************************************************************
       FD  RPA116
           LABEL RECORDS ARE STANDARD.
       01  RPA116R.
           03  SEQ116                        PIC X(06).
           03  CHG116                        PIC X(01).
           03  BLK116                        PIC X(01).
           03  DTA116.
               05  FILLER                    PIC X(06).
               05  CMT116                    PIC X(01).
               05  FILLER                    PIC X(107).
           03  KEY116                        PIC X(80).
           03  ORG116                        PIC X(06).
           03  DAT116                        PIC X(06).
           03  REF116                        PIC X(06).

      *****************************************************************
      *    New release source file with DELETE (and INSERT) blocks    *
      *****************************************************************
       FD  RPA117
           LABEL RECORDS ARE STANDARD.
       01  RPA117R.
           03  SEQ117                        PIC X(06).
           03  CHG117                        PIC X(01).
           03  BLK117                        PIC X(01).
           03  DTA117.
               05  FILLER                    PIC X(06).
               05  CMT117                    PIC X(01).
               05  FILLER                    PIC X(107).
           03  KEY117                        PIC X(80).
           03  ORG117                        PIC X(06).
           03  DAT117                        PIC X(06).
           03  REF117                        PIC X(06).

      *****************************************************************
      *    Outfile for management report                              *
      *****************************************************************
       FD  RPA121
           LABEL RECORDS ARE STANDARD.
       01  RPA121R.
           COPY DDS-ALL-FORMATS OF RPA121.

      *****************************************************************
      *    Names of sources that should be checked manually           *
      *****************************************************************
       FD  RPA105
           LABEL RECORDS ARE STANDARD.
       01  RPA105R.
           COPY DDS-ALL-FORMATS OF RPA105.
      /
       WORKING-STORAGE SECTION.
      *****************************************************************
      *    Work fields                                                *
      *****************************************************************
       01  A01-99.                                                      PL 250
           03  A01-COMPRESS.
               05  A01-CHAR                  PIC X(01)   OCCURS 114.
           03  M                             PIC S9(3) COMP-3.
      *                                                               *
       01  W01-99.                                                      PL 250
           03  W01-02.                                                  PL 250
      *            End of file indicators                             *
               05  W01-EOF                   PIC X(01).                 PL 250
               05  W02-EOF                   PIC X(01).                 PL 250
           03  W03-09.
      *            Line indicators                                    *
               05  W03-COMMENT               PIC S9(3)   COMP-3.        PL 250
               05  W04-USRFD                 PIC S9(3)   COMP-3.          PL 250
               05  W04-USRFD2                PIC S9(3)   COMP-3.          PL 250
               05  W05-BEGIN                 PIC S9(3)   COMP-3.          PL 250
               05  W05-BEGIN2                PIC S9(3)   COMP-3.          PL 250
               05  W06-INSERT                PIC S9(3)   COMP-3.          PL 250
               05  W06-INSERT2               PIC S9(3)   COMP-3.          PL 250
               05  W07-DELETE                PIC S9(3)   COMP-3.          PL 250
               05  W07-DELETE2               PIC S9(3)   COMP-3.          PL 250
               05  W08-END                   PIC S9(3)   COMP-3.          PL 250
               05  W08-END2                  PIC S9(3)   COMP-3.          PL 250
               05  W09-STAR                  PIC S9(3)   COMP-3.          PL 250
           03  W10-LINE                      PIC S9(06)  COMP-3.        PL 250
           03  W11-LINE                      PIC S9(06)  COMP-3.        PL 250
           03  W12-KIND                      PIC X(06).                 PL 250
           03  W12-KIND2                     PIC X(06).                 PL 250
           03  W12-KINDSAVE                  PIC X(06).                 PL 250
           03  W13-LAST.                                                PL 250
               05  FILLER                    PIC X(06).
               05  W13-CMT                   PIC X(01).
               05  FILLER                    PIC X(107).
           03  W13-CHG                       PIC X(01).                 PL 250
           03  W13-BLK                       PIC X(01).                 PL 250
           03  W14-KEY                       PIC 9(7).                  PL 250
           03  W15-CHG                       PIC X(01).                 PL 250
           03  W15-BLK                       PIC X(01).                 PL 250

       01  W21-FIELDS.
           03  W21-PTFINS                    PIC S9(6)    COMP-3.
           03  W21-PTFDEL                    PIC S9(6)    COMP-3.
           03  W21-PTFUNC                    PIC S9(6)    COMP-3.
           03  W21-MODINS                    PIC S9(6)    COMP-3.
           03  W21-MODDEL                    PIC S9(6)    COMP-3.
           03  W21-MODUNC                    PIC S9(6)    COMP-3.
           03  W21-RPAMES                    PIC S9(6)    COMP-3.

       LINKAGE SECTION.
      *****************************************************************
      *    Parameter fields                                           *
      *****************************************************************
       01  P01-TYP                           PIC X(03).                 PL 250
       01  P02-NAME                          PIC X(10).                 PL 250
       01  P03-TEXT                          PIC X(50).                 PL 250
      /
       PROCEDURE DIVISION USING P01-TYP P02-NAME P03-TEXT.
       DECLARATIVES.
       DCL-INP SECTION.
           USE AFTER ERROR PROCEDURE ON INPUT.
       DCL-INP01.
       DCL-INP99.
           EXIT.
       DCL-OUT SECTION.
           USE AFTER ERROR PROCEDURE ON OUTPUT.
       DCL-OUT01.
       DCL-OUT99.
           EXIT.
       DCL-IO SECTION.
           USE AFTER ERROR PROCEDURE ON I-O.
       DCL-IO01.
       DCL-IO99.
           EXIT.
       DCL-EXT SECTION.
           USE AFTER ERROR PROCEDURE ON EXTEND.
       DCL-EX01.
       DCL-EX99.
           EXIT.
       END DECLARATIVES.
      *
       R00 SECTION.
      *****************************************************************
      *    Mainline                                                   *
      *****************************************************************
       R0001.
      *    --------------------------------------------------
      *    Initialize program and read first record of RPA113
      *    --------------------------------------------------
           PERFORM R98.
      *
      *    --------------------------------------------------
      *    Do while not EOF of RPA113
      *    --------------------------------------------------
       R0003.
           IF W01-EOF EQUAL '1'
              GO TO R0009.
      *
      *    --------------------------------------------------
      *    When first delete line, process source
      *    --------------------------------------------------
           IF   BLK113 EQUAL 'D'
           AND  W13-BLK NOT EQUAL 'D'
              PERFORM R70.
      *
      *    --------------------------------------------------
      *    Write in work file
      *    --------------------------------------------------
           PERFORM R84.
      *
      *    --------------------------------------------------
      *    Read next RPA113
      *    --------------------------------------------------
           PERFORM R81.
           GO TO R0003.
       R0009.
      *    Close program
           PERFORM R99.
       R0099.
           STOP RUN.

       R98 SECTION.
      *****************************************************************
      *    Initialize program                                         *
      *****************************************************************
       R9801.
           OPEN  INPUT   RPA113
                         RPA115.
           OPEN  OUTPUT  RPA116
                         RPA117.
           OPEN  EXTEND  RPA105.
           MOVE  ZERO  TO W01-EOF
                          W02-EOF
                          W03-COMMENT                                   PL 250
                          W04-USRFD                                       PL 250
                          W05-BEGIN                                       PL 250
                          W06-INSERT                                      PL 250
                          W07-DELETE                                      PL 250
                          W08-END                                         PL 250
           MOVE ZERO   TO W21-PTFINS
                          W09-STAR.                                       PL 250
           MOVE ZERO   TO W21-PTFINS
                          W21-PTFDEL
                          W21-PTFUNC
                          W21-MODINS
                          W21-MODDEL
                          W21-MODUNC
                          W21-RPAMES.
           MOVE  SPACE TO W13-LAST.
           MOVE  SPACE TO W12-KINDSAVE.
           MOVE  ZERO  TO W14-KEY.
           PERFORM R81.
       R9899.
           EXIT.

       R99 SECTION.
      *****************************************************************
      *    Close program                                              *
      *****************************************************************
       R9901.
           PERFORM R51.
           IF    W02-EOF NOT EQUAL ZERO
                 GO TO R9903.
           IF    BLK115 NOT EQUAL 'D'
                 MOVE  RPA115R TO RPA117R
                 PERFORM R57.
           GO TO R9901.
       R9903.
           OPEN  EXTEND  RPA121.
           MOVE P02-NAME    TO MBRNAM.
           MOVE P01-TYP     TO MBRTYP.
           MOVE P03-TEXT    TO MBRTXT.
           ACCEPT CHGDAT FROM DATE.
           ACCEPT CHGTIM FROM TIME.
           MOVE W21-PTFINS  TO PTFINS.
           MOVE W21-PTFDEL  TO PTFDEL.
           MOVE W21-PTFUNC  TO PTFUNC.
           MOVE W21-MODINS  TO MODINS.
           MOVE W21-MODDEL  TO MODDEL.
           MOVE W21-MODUNC  TO MODUNC.
           MOVE W21-RPAMES  TO RPAMES.
           WRITE RPA121R.

           CLOSE RPA113
                 RPA115
                 RPA116
                 RPA117
                 RPA121
                 RPA105.
       R9999.
           EXIT.

       R81 SECTION.
      *****************************************************************
      *    Read modified source                                       *
      *****************************************************************
       R8101.
           IF W01-EOF EQUAL '1'
                 GO TO R8199.
           MOVE  CHG113   TO W13-CHG.
           MOVE  BLK113   TO W13-BLK.
           READ  RPA113 AT END
                 MOVE '1' TO W01-EOF.
           IF W01-EOF EQUAL '1'
                 GO TO R8199.
      *
           IF   CHG113 = 'D'
                ADD  1        TO W21-MODDEL
           ELSE IF    CHG113 = 'I'
                      ADD  1        TO W21-MODINS
                 ELSE ADD  1        TO W21-MODUNC.
      *
           IF    DTA113 NOT EQUAL SPACE
           AND   BLK113 EQUAL SPACE
                 MOVE DTA113 TO W13-LAST.
       R8199.
           EXIT.

       R84 SECTION.
      *****************************************************************
      *    Write in work file                                         *
      *****************************************************************
       R8401.
           WRITE RPA116R FROM RPA113R.
       R8499.
           EXIT.

       R70 SECTION.
      *****************************************************************
      *    Process source change                                      *
      *****************************************************************
       R7001.
           CLOSE RPA116.
      *    How many times does the last line appear in work file ?
           PERFORM R52.
           IF    W10-LINE EQUAL ZERO
                 GO TO R7005.

      *    Process intermediate lines until checkpoint appears IN 116
           MOVE  ZERO TO W11-LINE.
       R7003.
           PERFORM R51.
           IF    W02-EOF NOT EQUAL ZERO
                 GO TO R7005.
           IF    W13-LAST EQUAL DTA115
             IF  CHG115 = 'I' OR 'A' OR 'M'
     *****   AND W13-BLK NOT EQUAL 'I'
                 NEXT SENTENCE
             ELSE ADD 1 TO W11-LINE.
      *
           IF    CHG115 NOT EQUAL 'D'
                 MOVE  RPA115R TO RPA117R
                 PERFORM R57.
           IF    W10-LINE GREATER W11-LINE
                 GO TO R7003.
           MOVE CHG115 TO W15-CHG.
           MOVE BLK115 TO W15-BLK.
       R7005.
      *    Process deletion lines until 'END' in line
           PERFORM R40.
           PERFORM R53.
           OPEN  OUTPUT RPA116.
       R7099.
           EXIT.

       R51 SECTION.
      *****************************************************************
      *    Read intermediate file                                     *
      *****************************************************************
       R5101.
           IF    W02-EOF NOT EQUAL ZERO
                 GO TO R5199.
           ADD   1  TO W14-KEY.
           READ  RPA115 INVALID
                 MOVE '1' TO W02-EOF.
           IF    W02-EOF NOT EQUAL ZERO
                 GO TO R5199.
      *
           MOVE  SPACE TO W12-KIND2.
           MOVE  ZERO TO W04-USRFD2.
           IF   CHG115 = 'I' OR 'M' OR 'D'
                NEXT SENTENCE
           ELSE IF    CHG115 = 'R'
                      ADD  1        TO W21-PTFDEL
                 ELSE IF    CHG115 = 'A'
                            ADD  1        TO W21-PTFINS
                       ELSE ADD  1        TO W21-PTFUNC.
       R5199.
           EXIT.

       R52 SECTION.
      *****************************************************************
      *    How many times does the last line appear in work file ?    *
      *****************************************************************
       R5201.
           MOVE  ZERO TO W10-LINE.
           IF    W13-LAST EQUAL SPACE
                 GO TO R5299.
           OPEN  INPUT RPA116.
       R5203.
           READ  RPA116 AT END
                 GO TO R5205.
           IF    W13-LAST EQUAL DTA116
           AND   CHG116 NOT EQUAL 'I'
                 ADD 1 TO W10-LINE.
           GO TO R5203.
       R5205.
           CLOSE RPA116.
       R5299.
           EXIT.

       R53 SECTION.
      *****************************************************************
      *    Process deletion block lines until 'END' in line           *
      *****************************************************************
       R5301.
           MOVE  SPACE TO W13-LAST.
       R5303.
      *  CHECK IF USRFD END HAS BEEN REACHED
       R5305.
           IF    BLK113  NOT EQUAL 'D'
           OR    W01-EOF NOT EQUAL ZERO
                 GO TO R5350.
      *
           IF    W02-EOF NOT EQUAL ZERO
                 MOVE RPA113R    TO RPA117R
                 PERFORM R57
                 PERFORM R81
                 MOVE '***RPA*MESSAGE *** DELETE BLOCK, AND EOF RELEASE
      -               '            '   TO DTA117
                 MOVE ZERO     TO DAT117
                 MOVE 'M'      TO CHG117
                 MOVE 'D'      TO BLK117
                 MOVE ZERO     TO SEQ117
                 MOVE  DTA117   TO ODOBTX
                 PERFORM R57
      *
                 MOVE  P02-NAME TO ODOBNM
                 WRITE RPA105R
                 GO TO R5305.
      *
           IF    DTA115 EQUAL SPACE
                 MOVE RPA115R    TO RPA117R
                 MOVE 'D'        TO BLK117
                 PERFORM R57
                 PERFORM R51
                 GO TO R5305.
      *
           IF    DTA113 EQUAL SPACE
                 PERFORM R81
                 GO TO R5305.
      *
           IF    CHG115 EQUAL 'M'
                 MOVE RPA115R    TO RPA117R
                 MOVE 'D'        TO BLK117
                 PERFORM R57
                 PERFORM R51
                 GO TO R5305.
      *
           IF    CHG115 EQUAL 'I'
                 MOVE RPA115R    TO RPA117R
                 PERFORM R57
                 PERFORM R51
                 GO TO R5305.
      *
           IF    CHG115 EQUAL ' '
                 MOVE RPA113R    TO RPA117R
                 PERFORM R57
                 IF   KEY113 = KEY115
                      PERFORM R51
                      PERFORM R81
                      GO TO R5305
                 ELSE
                 MOVE '***RPA*MESSAGE *** DELETED LINE not equal TO ORIG
      -               'INAL LINE   '   TO DTA117
                      MOVE ZERO     TO DAT117
                      MOVE 'M'      TO CHG117
                      MOVE 'D'      TO BLK117
                      MOVE ZERO     TO SEQ117
                      MOVE  DTA117   TO ODOBTX
                      PERFORM R57
      *
                      MOVE  P02-NAME TO ODOBNM
                      WRITE RPA105R
                      PERFORM R51
                      PERFORM R81
                      GO TO R5305.
      *
           IF    CHG115 EQUAL 'A'
                 MOVE RPA115R    TO RPA117R
                 MOVE 'D'        TO BLK117
                 PERFORM R57
                 PERFORM R51
                 MOVE '***RPA*MESSAGE *** INSERT LINE IN DELETE BLOCK
      -               '        '   TO DTA117
                 MOVE ZERO   TO DAT117
                 MOVE 'M'    TO CHG117
                 MOVE 'D'    TO BLK117
                 MOVE ZERO   TO SEQ117
                 MOVE DTA117 TO ODOBTX
                 PERFORM R57
      *
                 MOVE  P02-NAME TO ODOBNM
                 WRITE RPA105R
                 GO TO R5305.
      *
           IF    CHG115 EQUAL 'R'
                 MOVE RPA113R    TO RPA117R
                 PERFORM R57
                 PERFORM R51
                 PERFORM R81
                 MOVE '***RPA*MESSAGE *** DELETE LINE ALREADY DELETED
      -               '        '   TO DTA117
                 MOVE ZERO   TO DAT117
                 MOVE 'M'    TO CHG117
                 MOVE 'D'    TO BLK117
                 MOVE ZERO   TO SEQ117
                 MOVE DTA117 TO ODOBTX
                 PERFORM R57
      *
                 MOVE  P02-NAME TO ODOBNM
                 WRITE RPA105R
                 GO TO R5305.
      *
           MOVE RPA113R    TO RPA117R.
           PERFORM R57.
           PERFORM R81.
           MOVE '***RPA*MESSAGE *** PROGRAM MISMATCH
      -               '        '   TO DTA117.
           MOVE ZERO     TO DAT117.
           MOVE 'M'      TO CHG117.
           MOVE 'D'      TO BLK117.
           MOVE ZERO     TO SEQ117.
           MOVE DTA117   TO ODOBTX.
           PERFORM R57.
           MOVE  P02-NAME TO ODOBNM.
           WRITE RPA105R.
           GO TO R5305.
      *
       R5350.
      *
           IF  CHG115 = 'A'
           AND W15-CHG NOT EQUAL 'A'
               MOVE '***RPA*MESSAGE *** LINES INSERTED, JUST AFTER DELET
      -         'E BLOCK'    TO DTA117
               MOVE ZERO      TO DAT117
               MOVE 'M'       TO CHG117
               MOVE ' '       TO BLK117
               MOVE ZERO      TO SEQ117
               MOVE DTA117    TO ODOBTX
               PERFORM R57
               MOVE  P02-NAME TO ODOBNM
               WRITE RPA105R.
      *
           IF W14-KEY GREATER 0
              SUBTRACT 1 FROM W14-KEY.
       R5399.
           EXIT.

       R57 SECTION.
      *****************************************************************
      *    Write the line to the new source file                      *
      *****************************************************************
       R5701.
           IF   CHG117 = 'M'
                ADD  1     TO W21-RPAMES
                ACCEPT DAT117 FROM DATE.

           IF    CHG117 NOT EQUAL 'D'
           AND   CHG117 NOT EQUAL 'M'
           AND   CHG117 NOT EQUAL 'R'
                 GO TO R5780.
      *
           IF    P01-TYP EQUAL 'CLP'
                 GO TO R5750.
           MOVE '*' TO CMT117.
           GO TO R5780.
       R5750.
           INSPECT DTA117 REPLACING ALL '/*' BY '@@'.
           INSPECT DTA117 REPLACING ALL '*/' BY '¢¢'.
           MOVE DTA117 TO A01-COMPRESS.
           MOVE '/' TO A01-CHAR (1).
           MOVE '*' TO A01-CHAR (2).
           MOVE 114 TO M.
       R5760.
           IF M < 80
              GO TO R5770.
           IF A01-CHAR (M) NOT EQUAL SPACE
              GO TO R5770.
           SUBTRACT 1 FROM M.
           GO TO R5760.
       R5770.
           MOVE '/' TO A01-CHAR (M).
           SUBTRACT 1 FROM M.
           MOVE '*' TO A01-CHAR (M).
           SUBTRACT 1 FROM M.
           MOVE ' ' TO A01-CHAR (M).
           MOVE A01-COMPRESS TO DTA117.
       R5780.
           WRITE RPA117R.
       R5799.
           EXIT.

       R40 SECTION.
      *****************************************************************
      *    FIRST WRITE ALL BLANK LINES OF 115
      *    THEN  WRITE ALL INSERTS OF 115 THEN
      *    CHECK IF CHECKPOINT IS DELETED
      *****************************************************************
       R4001.
           PERFORM R51.
       R4010.
           IF W02-EOF NOT EQUAL ZERO
              GO TO R4050.
           IF CHG115 = 'I' OR 'M' OR 'A'
           OR DTA115 = SPACE
              NEXT SENTENCE
           ELSE GO TO R4050.
      *
           IF  CHG115 = 'A'
           AND W15-CHG NOT EQUAL 'A'
               MOVE '***RPA*MESSAGE *** LINES INSERTED, JUST BEFORE DELE
      -         'TE BLOCK'    TO DTA117
               MOVE ZERO      TO DAT117
               MOVE 'M'       TO CHG117
               MOVE ' '       TO BLK117
               MOVE ZERO      TO SEQ117
               MOVE DTA117    TO ODOBTX
               PERFORM R57
               MOVE  P02-NAME TO ODOBNM
               WRITE RPA105R.
      *
           MOVE  RPA115R  TO RPA117R.
           PERFORM R57.
           PERFORM R51.
           GO TO R4010.
      *
       R4050.
           IF  W15-CHG NOT EQUAL 'R'
           OR  W10-LINE EQUAL ZERO
               GO TO R4099.
           MOVE '***RPA*MESSAGE *** DELETE BLOCK, CHECKPOINT DELETED
      -         '       ' TO DTA117.
           MOVE ZERO     TO DAT117.
           MOVE 'M'      TO CHG117.
           MOVE ' '      TO BLK117.
           MOVE ZERO     TO SEQ117.
           MOVE DTA117   TO ODOBTX.
           PERFORM R57.
      *
           MOVE  P02-NAME TO ODOBNM.
           WRITE RPA105R.
       R4099.
           EXIT.
