      * ----------------------------------------------------------- *
      * Description                                                 *
      * ----------------------------------------------------------- *
      *                                                             *
      * Program ....: FILE NAME #TF                                 *
      * Function ...: part of TD/OMS TIMEFLASH module               *
      *               DATA    Exit program  MIMIX promotor          *
      * copyright...: REMAIN B.V. ©  2012                           *
      * Startdate ..:                                  *
      * Parms in ...: PrFun  - User exit point  identifier          *
      *               PrVer  - control exit struct version          *
      *               PrCLen - control exit struct length           *
      *               PrCtlDs- control exit struct pointer          *
      *                                                             *
      * This program is called from all control UEP's               *
      * available for the MIMIX Promoter command  CPYACTF           *
      * It's name is the variable to be substituted in the          *
      *    command additional parameter:  DTAEXITPGM                *
      *                                                             *
      * ----------------------------------------------------------- *
      *               copyright('Remain B.V. 2000')
      * ----------------------------------------------------------- *
      /EJECT
      * ----------------------------------------------------------- *
      * File specifications                                         *
      * ----------------------------------------------------------- *
      /EJECT
      * ----------------------------------------------------------- *
      * Input pecifications                                         *
      * ----------------------------------------------------------- *
      ****/COPY LVCOPYR
      *
      *          ------------------------------------------
      *          Use OMSREF to define fields.
      *          ------------------------------------------
     D               E DS                  EXTNAME(OMSREF)
      *
      *          ------------------------------------------
      *          Program data structure
      *          ------------------------------------------
     D PGM            SDS
     D  PGMQ             *PROC
     D  D#PARM           *PARMS
     D  D#PGM                  1     10
     D  E#FILE               201    208
     D  D#USID               254    263
     D  D#JOB#               264    269  0
      *
      *
     D PrFun           S              4
     D PrVer           S              4
      *
      * -----------------------------------------------------------------------------
      * (C) Copyright Vision Solutions Inc., 1998, 2011
      *
      * Disclaimer:  This material contains command and program object and source
      *   code for your review.  These commands and programs HAVE NOT BEEN
      *   THOROUGHLY TESTED UNDER ALL CONDITIONS.  These commands and programs are
      *   not part of the MIMIX/Promoter software product and are hereby excluded
      *   from the warranty and support provisions contained in the license
      *   agreements covering the MIMIX/Promoter product.
      *
      *   Vision Solutions, Inc., therefore cannot guarantee or imply
      *   reliability, serviceability, performance or function of these programs.
      *   All programs contained herein are provided to you "AS IS".  THE IMPLIED
      *   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
      *   EXPRESSLY DISCLAIMED.
      *
      * -----------------------------------------------------------------------------
      *
      * Assumptions:
      *
      *   o  This program is a sample template for ILE RPG data exit programs, with
      *      exit function PrDXfer setup to provide a data transformation.
      *
      *   o  This program will be compiled with the CRTBNDRPG command.
      *   o  It will be given as the DTAEXITPGM parameter on the CPYACTF command.
      *
      *   o  The program as provided will do just a simple file transformation, extending the
      *      length of one field with a default value, while converting a date from a numeric
      *      format to a Date format.
      *   o  The file buffers in this program are described externally.
      *
      *   o  The program as provided will only work on a specific two file set, there is no
      *      generality available without implementing the PrDInit function.  That is the
      *      initialize function, which would then query the field definitions of the two files
      *      take the appropriate actions based on the comparison.
      *   o  Going into those issues is beyond the scope of this template.
      *
      *   o  IMPORTANT:  Your RPG program will not open, close, read, or write any record
      *                  from either the source or target file.  MIMIX/Promoter will handle
      *                  those tasks.  Your RPG program will just move and convert data
      *                  from the source record buffer to the target record buffer.  Your
      *                  RPG program will also have the default target record buffer available
      *                  to it if you want to use it for default values.
      *
      * Sample Creation:
      *
      *  NOTE:  The sample physical files TPFFROM and TPFTO must be compiled and in the current
      *         library list for this program to compile.  When you finish converting to your
      *         needs, your file formats will need to be in the library list also.
      *
      *  CRTBNDRPG PGM(yourlib/DTARPGPGMX) SRCFILE(yourlib/QRPGLESRC)
      *
      * Sample Usage:
      *
      *  CPYACTF FROMFILE(yourlib/TPFFROM) TOFILE(yourlib/TPFTO)
      *     DTAEXITPGM(yourlib/DTARPGPGMX)
      *
      * -----------------------------------------------------------------------------
      *
     D/COPY MPTEMPLSRC,PRDTAXPGM
      *
      * -------
      * Local program variables
      * -------
      *
      * ------
      * Data structure over source file.  Field names are prefixed with 'F', for
      * convenience only.  Exchange with your file layouts in EXTNAME keyword.
      * ------
     DTPFFR          E DS                  BASED(PrFBufPt)
     D                                     EXTNAME(OMOBJ)
     D                                     PREFIX(F)
      *
      * ------
      * Data structure over target file.  Field names are prefixed with 'T', for
      * convenience only.  Exchange with your file layouts in EXTNAME keyword.
      * ------
     DTPFTO          E DS                  BASED(PrTBufPt)
     D                                     EXTNAME(OMOBJ)
     D                                     PREFIX(T)
      *
      * ------
      * Data structure over target file Default buffer.  Names prefixed with 'D', for
      * convenience only.  Exchange with your file layouts in EXTNAME keyword.
      * ------
     DDPFTO          E DS                  BASED(PrTDfBPt)
     D                                     EXTNAME(OMOBJ)
     D                                     PREFIX(D)
      *
      * ------
      * Data structure over source null map.  Field names prefixed with 'O', for
      * convenience only.  Note that our Null map support requires you to know your
      * field layout explicitly, as the built in Null support in RPG cannot be
      * used.  Replace this with your files field structure.
      * ------
     D                 DS                  BASED(PrFMapPt)
     D OFRMAP                       221
     D  ORJAPPC                       5    OVERLAY(OFRMAP)
     D  ORJPDLC                       5    OVERLAY(OFRMAP:6)
      **  if it is necessary to apply,  define internally OMOBJ record format
      **
      *
      * ------
      * Data structure over target null map.  Field names prefixed with 'N', for
      * convenience only.  Note that our Null map support requires you to know your
      * field layout explicitly, as the built in Null support in RPG cannot be
      * used.  Replace this with your files field structure.
      * ------
     D                 DS                  BASED(PrTMapPt)
     D NTOMAP                       221
     D  NRJAPPC                       5    OVERLAY(NTOMAP)
     D  NRJPDLC                       5    OVERLAY(NTOMAP:6)
      **  if it is neessary to apply,  define internally OMOBJ record format
      **
      *
      * ------
      * Data structure over target default null map.  Field names prefixed with 'E', for
      * convenience only.  Note that our Null map support requires you to know your
      * field layout explicitly, as the built in Null support in RPG cannot be
      * used.  Replace this with your files field structure.
      * ------
     D                 DS                  BASED(PrTDfMPt)
     D   ERJAPPC                      5
     D   ERJPDLC                      5
      ** if it is neessary to apply,  define internally OMOBJ record format
      **
      *
      * Strings to hold date information
      *
     D DateStr         S              7A
     D DFDate          S              7S 0
     D DateStr2        S             10A
      *
      *          ------------------------------------------
      *          split Qualified names
      *          ------------------------------------------
     D D#QName         DS
     D D#Fname                       10
     D D#Lname                       10

      *          ------------------------------------------
      *          Library number
      *          ------------------------------------------
     D                 DS
     D D#LIB#                        10  0
     D  D#LIBC                       10    OVERLAY(D#LIB#)
      *
     D P#TFRC          S             10
     D P#IDLE          S              5
     D P#CNCL          S              5
     D P#STAT          S                   Like(STAT)
     D P#MBRC          S                   Like(MBRC)
     D P#CMD           S           5700
     D P#CMDL          S             15P 5

      *          ------------------------------------------
      *          Date structure.
      *          ------------------------------------------
     D                 DS
     D D#DATE                         7  0
     D  D#CENT                        1  0 OVERLAY(D#DATE)
     D  D#YEAR                        2  0 OVERLAY(D#DATE:2)
     D  D#MONT                        2  0 OVERLAY(D#DATE:4)
     D  D#DAY                         2  0 OVERLAY(D#DATE:6)
      *          ------------------------------------------
      *          Used for conversion
      *          ------------------------------------------
     D W#PRI           DS
     D W#PRI#                         1S 0
     D  W#PRIA                        1    OVERLAY(W#PRI#)
      *
      *          ------------------------------------------
      *           API TIMEFLASH retrieval
      *          ------------------------------------------
      /COPY QCPYLESRC,OMQCHGTFDS
      *
      *          ------------------------------------------
      *          IBM API Binary number definition
      *          ------------------------------------------
      /COPY QAPILESRC,DEFBINARY
      *
      *          ------------------------------------------
      *          IBM API error buffer
      *          ------------------------------------------
      /COPY QAPILESRC,ERR_BUFFER
      *----------------------------------------------------------------------
      * Stand Alone Fields - TOP
      *----------------------------------------------------------------------
     D I#PSSR          S              1
     D P#FILE          S             57
     D P#MSTA          S             40
      *----------------------------------------------------------------------
      * Stand Alone Fields - BOTTOM
      *----------------------------------------------------------------------
      *
      * ----------------------------------------------------------- *
      /EJECT
      * ----------------------------------------------------------- *
      * Main line                                                   *
      * ----------------------------------------------------------- *
      *
      * -------
      * Entry parameter list
      * -------
     C     *ENTRY        PLIST
     C                   PARM                    PrFun
     C                   PARM                    PrVer
     C                   PARM                    PrDLen
     C                   PARM                    PrDtaDs
      *
      *          ------------------------------------------
      *          End program when no parms passed
      *          ------------------------------------------
      /FREE
       IF D#PARM < 4;                                                           // B01
        *INLR = *ON;
       RETURN;
       ENDIF;                                                                   // E01

       //          ------------------------------------------
       //          Assume normal ending
       //          ------------------------------------------
        PrRtnInd = PrDCont;
       // Determine which function to run
       //
       Select;
       // ------
       // Initialize exit point (PrDInit)
       // ------
       When PrFun = PrDInit;
       //
       // Put any required initialization code here
       EXSR PRDataInit;
       //
       // ------
       // Finalize exit point (PrDFini)
       // ------
       When PrFun = PrDFini;
       //
       // Put any required cleanup code here
       //          ------------------------------------------
       //          only for setting LR  (no return parm)
       //          ------------------------------------------
        PrRtnInd = PrDStop;
       //
       // ------
       // Transfer record exit point (PrDXfer)
       // ------
       When PrFun = PrDXfer;
       //
       // Set target fields equal to source fields.  These are straight copies.
       // Replace with whatever your conversions are.
       //
        TRJAPPC   = FRJAPPC;
        TRJPDLC   = FRJPDLC;
        TRJOBJC   = FRJOBJC;
        TRJOBJL   = FRJOBJL;
        TRJOBJT   = FRJOBJT;
        TRJOBJA   = FRJOBJA;
        TRJOBJD   = *blank;
        TRJSRCF   = FRJSRCF;
        TRJSRCL   = FRJSRCL;
        TRJSRCM   = FRJSRCM;
        TRJSRCS   = FRJSRCS;
        TRJSRCX   = FRJSRCX;
        TRJOBJX   = FRJOBJX;
        TRJOMOD   = FRJOMOD;
        TRJOCRT   = FRJOCRT;
        TRJFIX#   = FRJFIX#;
        TRJUSDF   = FRJUSDF;
        TRJEXCI   = FRJEXCI;
        TRJOCLS   = FRJOCLS;
        TRJVRS#   = FRJVRS#;
        TRJMOD#   = FRJMOD#;
        TRJCHGX   = FRJCHGX;
        TRJROTC   = FRJROTC;
        TRJELBC   = FRJELBC;
       //
       //
       // Have to use the special ILE RPG DATE field features for this move.
       //
       //
       // Set target null maps equal to source null maps.
       // Replace with whatever your conversions are.
       //
       //*                 Eval      NRJAPPC    = ORJAPPC
       //*                 Eval      NRJPDLC    = ORJPDLC
        NTOMAP    = OFRMAP;
       //
       Endsl;
       //
       // ------
       // A PrRtnInd of 0 is PrDCont
       // Return "continue".  Returning 2 or 3 would cause the CPYACTF to go to error processing.
       // All data exit functions return through here
       // ------
       IF PrRtnInd <> PrDCont;
        *INLR = *ON;
       Endif;
       Return;
       // ------------------------------------------------------------ *
      /EJECT
       // ------------------------------------------------------------ *
       // PRDataInit   - Data exit initialisation                    *
       //                                                              *
       // ------------------------------------------------------------ *
       BEGSR PRDataInit;

       //          ------------------------------------------
       //          init qualified file name
       //          ------------------------------------------
       // First we can retrieve and check the copy registration in *
       // OMTFJ
       // if added fields, here an initial value may be defined for
       // the target file default buffer
       //
       //            ----------------------------------------
       //            Continue if not registered.
       //            ----------------------------------------
        PrRtnInd = PrDCont;
       //
       //          ------------------------------------------
       //          End of subroutine
       //          ------------------------------------------
       ENDSR;
       // ------------------------------------------------------------ *
       // ----------------------------------------------------------- *
      /EJECT
       // ----------------------------------------------------------- *
       // *PSSR  - Error handler                                      *
       //                                                             *
       // Standard RPG error handler.                                 *
       // Make sure the data structure PGM is defined as the          *
       // program status data structure (SDS) with a length of 429.   *
       // The file information data structure is also passed, but     *
       // not the complete data structure, only the relevant info.    *
       // After the program is called, the messages in the queue      *
       // of this program are passes back to the queue of the         *
       // calling program and the *CANCL procedure is invoked.        *
       //                                                             *
       // ----------------------------------------------------------- *
       BEGSR *PSSR;
       //
       //          ------------------------------------------
       //          Do if error not in this routine.
       //          ------------------------------------------
       IF I#PSSR <> *ON;                                                        // B01
        I#PSSR = *ON;
       //
       //          ------------------------------------------
       //          Post information about the last used file
       //          ------------------------------------------
       //
       //          ------------------------------------------
       //          Call the error handler
       //          ------------------------------------------
      /END-FREE
     C                   CALL      'OMX961'
     C                   PARM                    PGM
     C                   PARM                    P#FILE
      *
      *          ------------------------------------------
      *          Move the messages to the queue of the caller
      *          ------------------------------------------
      /FREE
        %SUBST(P#MSTA:1:5) = '*COMP';
        P#MSTA = %TRIMR(P#MSTA) + '     ' +
       '*DIAG';
        P#MSTA = %TRIMR(P#MSTA) + '     ' +
       '*ESCA';
        P#MSTA = %TRIMR(P#MSTA) + 'PE';
        P#MSTA = %TRIMR(P#MSTA) + '   ' + '*INFO';
      /END-FREE
     C                   CALL      'QMHMOVPM'
     C                   PARM      *BLANKS       P#MSKC
     C                   PARM                    P#MSTA
     C                   PARM      4             P#LOB#
     C                   PARM      '*'           P#PMQC
     C                   PARM      1             P#PSC#
     C                   PARM                    P#ERR
      *
      /FREE
       ENDIF;                                                                   // E01
       //
       //          ------------------------------------------
       //          Exit.
       //          ------------------------------------------
        D#PARM = 0;
       //
        *INLR = *ON;
       RETURN;
       //          ------------------------------------------
       //          End of subroutine
       //          ------------------------------------------
       ENDSR;
       // ----------------------------------------------------------- *
      /EJECT
       // ----------------------------------------------------------- *
       // *INZSR - Initialization program                             *
       //                                                             *
       // ----------------------------------------------------------- *
       BEGSR *INZSR;
       //
       //          ------------------------------------------
       //          IBM API field definition
       //          ------------------------------------------
      /END-FREE
      /COPY QAPILESRC,DEFOTHER

      *          ------------------------------------------
      *          End of subroutine
      *          ------------------------------------------
      /FREE
       ENDSR;
      /END-FREE
