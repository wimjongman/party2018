       PROCESS APOST.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. RPA116.
      *****************************************************************
      *                                                               *
      *       RELEASE PROCESSING AID  (RPA)€                         *
      *                                                               *
      *  Program:   RPA116 - Process insertions in source file        *
      *                                                               *
      *  Author:    Jurjen D. Oostenveld                              *
      *  Date:      October 2013                                      *
      *  Release:   1.1                                               *
      *                                                               *
      *    This program reads the NEW RELEASE source member and the   *
      *    source member from LIBUSRSRC and processes the INSERT      *
      *    blocks of the USRFD mofifications.                         *
      *    The generated output file is an intermediate source file.  *
      *                                                               *
      *****************************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-S38.
       OBJECT-COMPUTER. IBM-S38.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT RPA113 ASSIGN TO DATABASE-RPA113.
           SELECT RPA114 ASSIGN TO DATABASE-RPA114
                  ORGANIZATION RELATIVE
                  ACCESS RANDOM
                  RELATIVE W14-KEY.
           SELECT RPA115 ASSIGN TO DATABASE-RPA115.
           SELECT RPA116 ASSIGN TO DATABASE-RPA116.
           SELECT RPA105 ASSIGN TO DATABASE-RPA105.
       DATA DIVISION.
       FILE SECTION.
      *****************************************************************
      *    Modified source file (LIBUSRSRC)                           *
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
      *    New release source file                                    *
      *****************************************************************
       FD  RPA114
           LABEL RECORDS ARE STANDARD.
       01  RPA114R.
           03  SEQ114                        PIC X(06).
           03  CHG114                        PIC X(01).
           03  BLK114                        PIC X(01).
           03  DTA114.
               05  FILLER                    PIC X(06).
               05  CMT114                    PIC X(01).
               05  FILLER                    PIC X(107).
           03  KEY114                        PIC X(80).
           03  ORG114                        PIC X(06).
           03  DAT114                        PIC X(06).
           03  REF114                        PIC X(06).

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
       01  W01-99.                                                      PL 250
           03  W01-02.                                                  PL 250
      *            End of file switches                               *
               05  W01-EOF                   PIC X(01).                 PL 250
               05  W02-EOF                   PIC X(01).                 PL 250
           03  W03-09.
      *            Line indicators                                    *
               05  W03-COMMENT               PIC S9(3)   COMP-3.        PL 250
               05  W04-USRFD                 PIC S9(3)   COMP-3.          PL 250
               05  W05-BEGIN                 PIC S9(3)   COMP-3.          PL 250
               05  W06-INSERT                PIC S9(3)   COMP-3.          PL 250
               05  W07-DELETE                PIC S9(3)   COMP-3.          PL 250
               05  W08-END                   PIC S9(3)   COMP-3.          PL 250
               05  W09-STAR                  PIC S9(3)   COMP-3.          PL 250
           03  W10-LINE                      PIC S9(06)  COMP-3.        PL 250
           03  W11-LINE                      PIC S9(06)  COMP-3.        PL 250
           03  W12-KIND                      PIC X(06).                 PL 250
           03  W13-LAST                      PIC X(114).                PL 250
           03  W13-CHG                       PIC X(1).                  PL 250
           03  W13-BLK                       PIC X(1).                  PL 250
           03  W14-KEY                       PIC 9(7).                  PL 250

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
      *    Save a not changed source line of RPA113
      *    --------------------------------------------------
           IF    DTA113 NOT EQUAL SPACE
           AND   CHG113 EQUAL SPACE
                 MOVE DTA113 TO W13-LAST.
      *
      *    --------------------------------------------------
      *    When first insert line, process source
      *    --------------------------------------------------
           IF   BLK113 EQUAL 'I'
           AND  W13-BLK NOT EQUAL 'I'
                PERFORM R70
                IF    DTA113 NOT EQUAL SPACE
                AND   CHG113 EQUAL SPACE
                      MOVE DTA113 TO W13-LAST.
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
                         RPA114.
           OPEN  OUTPUT  RPA115
                         RPA116.
           OPEN  EXTEND  RPA105.
           MOVE  ZERO  TO W01-EOF
                          W02-EOF
                          W03-COMMENT                                   PL 250
                          W04-USRFD                                       PL 250
                          W05-BEGIN                                       PL 250
                          W06-INSERT                                      PL 250
                          W07-DELETE                                      PL 250
                          W08-END                                         PL 250
                          W09-STAR.                                       PL 250
           MOVE  SPACE TO W13-LAST.
           MOVE  ZERO  TO W14-KEY.
           PERFORM R81.
           MOVE  SPACE    TO ODOBTX.
           MOVE  P02-NAME TO ODOBNM.
           WRITE RPA105R.
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
           MOVE  RPA114R TO RPA115R.
           MOVE  ' '     TO BLK115
           WRITE RPA115R.
           GO TO R9901.
       R9903.
           CLOSE RPA113
                 RPA114
                 RPA115
                 RPA116
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
           MOVE  BLK113   TO W13-BLK.
           READ  RPA113 AT END
                 MOVE '1' TO W01-EOF.
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

      *    Process new release lines until checkpoint appears
           MOVE  ZERO TO W11-LINE.
       R7003.
           PERFORM R51.
           IF    W02-EOF NOT EQUAL ZERO
                 GO TO R7005.
           IF    W13-LAST EQUAL DTA114
           AND   CHG114 NOT EQUAL 'A'
                 ADD 1 TO W11-LINE.
           MOVE  RPA114R TO RPA115R.
           MOVE  ' '     TO BLK115.
           WRITE RPA115R.
           IF    W10-LINE GREATER W11-LINE
                 GO TO R7003.
       R7005.
      *    Process insertion lines until 'END' in line
           PERFORM R40.
           PERFORM R53.
           OPEN OUTPUT RPA116.
       R7099.
           EXIT.
      /
       R51 SECTION.
      *****************************************************************
      *    Read new release source file                               *
      *****************************************************************
       R5101.
           IF    W02-EOF NOT EQUAL ZERO
                 GO TO R5199.
           ADD   1  TO W14-KEY.
           READ  RPA114 INVALID
                 MOVE '1' TO W02-EOF.
           IF    CHG114 EQUAL 'I'
                 MOVE 'A'  TO CHG114
                 MOVE 'A'  TO BLK114
           ELSE  IF   CHG114 EQUAL 'D'
                      MOVE 'R' TO CHG114
                      MOVE 'R' TO BLK114.
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
                 ADD 1 TO W10-LINE.
           GO TO R5203.
       R5205.
           CLOSE RPA116.
       R5299.
           EXIT.

       R53 SECTION.
      *****************************************************************
      *    Process insertion lines until 'END' in line                *
      *****************************************************************
       R5301.
           MOVE  RPA113R  TO RPA115R.
           WRITE RPA115R.
           PERFORM R81.
           IF    W01-EOF EQUAL ZERO
           AND   CHG113  EQUAL 'I'
                 GO TO R5301.
       R5399.
           EXIT.

       R40 SECTION.
      *****************************************************************
      *    Generate error identification                              *
      *****************************************************************
       R4001.
           IF  CHG114 NOT EQUAL 'R'
               GO TO R4050.
           MOVE '***RPA*MESSAGE *** INSERT BLOCK CHECKPOINT DELETED'
      -                   TO DTA115.
           MOVE  ZERO    TO DAT115.
           MOVE  'M'     TO CHG115.
           MOVE  ' '     TO BLK115.
           MOVE  ZERO    TO SEQ115.
           MOVE  DTA115  TO ODOBTX.
           WRITE RPA115R.
      *
           MOVE  P02-NAME TO ODOBNM.
           WRITE RPA105R.
       R4050.
           PERFORM R51.
           IF W02-EOF NOT EQUAL ZERO
              GO TO R4099.
           IF CHG114 EQUAL 'A'
              MOVE '***RPA*MESSAGE *** INSERTED LINES JUST AFTER INSERT
      -       'BLOCK'         TO DTA115
              MOVE  ZERO    TO DAT115
              MOVE  'M'     TO CHG115
              MOVE  ' '     TO BLK115
              MOVE ZERO     TO SEQ115
              MOVE  DTA115  TO ODOBTX
              WRITE RPA115R
              MOVE  P02-NAME TO ODOBNM
              WRITE RPA105R.
           SUBTRACT 1 FROM W14-KEY.
       R4099.
           EXIT.
