     H/TITLE  Customer Listing
      * ProGen WebSmart Revision 21513
      * File overrides for compile command
      *__OV OVRDBF MU_CUSTL1  DOMSPR1DTA/MU_CUSTL1
      *__OV OVRDBF MU_CNTRYPF DOMSPR1DTA/MU_CNTRYPF
      *__   Following values are used to create the server program
      *__RO Pgm  lib DOMSP2OBJ  Pgm  CUSTLIST
      *__AG          WEBSMART
      *__SQ
      *__BD ECRTBND194
      *===============================================================*
      * Path:   C:\Users\burgs\IBM\rationalsdp\workspace95\RemoteSystemsTempFiles\NEWTON\QOpenSys\O
      * MSIFS\DEMO\DEV\WEBSMART\custlist - Customer Listing.pdw
      * System: BURGS-PC
      * Project:N/A
      * Set:    N/A
      * User:   burgs
      * Date Last Generated:   2016-07-05   10:40:37
      * Last Generated CRC: D24F1F84 06BCE235 5385CAC7 74449D80
      *===============================================================*
      */CPY *LIBL/PW_CSRC CPYRIGHT
      * File specifications
     FMU_CUSTL1 IF   E           K DISK    USROPN
     F                                     INFDS(FID001_   )
     FMU_CNTRYPFIF   E           K DISK    USROPN
     F                                     INFDS(FID002_   )

     D PTL__           S             50    DIM(1) CTDATA PERRCD(1)
     D RTLLA__         S             11    DIM(180)

     D*+FLDDCL Field declarations

     Dcustlist_        DS                  INZ
     D ww_orddir                      1A
     D ww_ordby                      64A
     D ww_pagea                       5A

     D ni              S              4B 0

     D RS001_          S              1A
     D AM001_          S              1A
     D RS002_          S              1A
     D AM002_          S              1A


      * Global variables:
     D firstls__       S              1A   INZ(*ON)
     D flush__         S              1A   INZ(*ON)
     D wfrtn__         S              1A
     D slrtn__         S              1A
     D rpml__          S              5I 0
     D msgdta__        S             70A
     D n30pm__         S             30A
     D voidrtn__a      S              1A
     D voidrtn__n      S              5P 0
     D persists__      S              1A   INZ(*OFF)

     D pltfrm__        S             10A   INZ('RPGFREE')
     D pgsizelm__      S              9P 0 IMPORT('PGSIZELM')

     D Up__            C                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
     D Lo__            C                   'abcdefghijklmnopqrstuvwxyz'

     D arclr__         S              8A
     D rwcolor1__      S             32A   INZ('altcol1')
     D rwcolor2__      S             32A   INZ('altcol2')


     D TASKRAN__       S              1    INZ(*OFF)


     D H__1            S             80    PERRCD(1) CTDATA DIM(40          )

     D H__2            S             80    PERRCD(1) CTDATA DIM(8           )

     D H__3            S             80    PERRCD(1) CTDATA DIM(14          )

     D H__4            S             80    PERRCD(1) CTDATA DIM(50          )

     D H__5            S             80    PERRCD(1) CTDATA DIM(3           )

     D H__6            S             80    PERRCD(1) CTDATA DIM(1           )

     D H__7            S             80    PERRCD(1) CTDATA DIM(73          )

     D H__8            S             80    PERRCD(1) CTDATA DIM(71          )


     D* File info DS for each file
     D FID001_         DS
     D  RR_001_              397    400B 0
     D FID002_         DS
     D  RR_002_              397    400B 0


     D Open_File_      PR             1A
     D OpnFile__                     10A   value
     D OpnMbr__                      10A   value
     D erropen__                      1A   value

     D Pgm_Init_       PR

     D Dfn_Klsts_      PR
     D Dfn_Pgmfs_      PR

     D UpdateRcd_      PR             1A
     D UpdRfmt__                     10A   value

     D DeleteRcd_      PR             1A
     D DltRfmt__                     10A   value

     D main__          PR

     D  True           S              1    INZ(*ON)
     D  False          S              1    INZ(*OFF)
     D  FirstTime      S              1    INZ(*ON)
     D  CV_ByKey       C                   CONST(*ON)
     D  CV_ByRrn       C                   CONST(*OFF)
     D  CV_Amp         C                   CONST('&')
     D  ovrflag__      S              1A   inz('0')

     D  QPNM__         S             32
     D  TASK__         S             32
     D  OWRTN__        S              1
     D  JOBTYPE__      S              1

      * Common indicators - subfield start/end positions = *IN value
     DComm_Ind__       DS                  Based(Cmin_Ptr__)
     D  GNERRSTS__            60     60
     D  VLDINARR__            60     89
     D  DBFIOERR__            93     93
     D  DBFSTS__              93     95

     DCmin_Ptr__       S               *   Inz(%addr(*IN))

      * Pointer to Condition Handler procedure:
     D CndHdlrPtr      S               *   ProcPtr Inz(%Paddr('RTMCNDHAND'))

     D CnlPtr__        S               *   ProcPtr Inz(%Paddr('PGM_CNL_'))

      * Pointer to Pgm status ds:
     D PSPtr__         S               *   inz(%addr(PSDS__))

     D PSDSSV__        S                   LIKE(PSDS__)
     D HTTPHEADERS__   S           4096A   import

     D displaylist0...
     D                 PR
     D buildpage0...
     D                 PR
     D selstring                   3200A   varying
     D                                     VALUE
     D pagenum                        5P 0
     D                                     VALUE
     D buildselectstring0...
     D                 PR         65535A   VARYING
     D fetch0...
     D                 PR
     D rowoffset                      5P 0
     D                                     VALUE
     D displayrecord0...
     D                 PR
     D deleteconfirm0...
     D                 PR
     D deleterecord0...
     D                 PR
     D beginadd0...
     D                 PR
     D endadd0...
     D                 PR
     D beginchange0...
     D                 PR
     D endchange0...
     D                 PR
     D QPGMNAM__       S             20A
     D CURTMST__       S               Z

     D cmcust_         S                   LIKE(cmcust        )

      /COPY *LIBL/PW_CSRC,SUBPROT194
      /COPY *LIBL/PW_CSRC,GDPROTO
      /COPY *LIBL/PW_CSRC,JPROTO002


      * field renames


      /free
       // Register the condition handler. Provide pointer to Pgm status
       // data structure
       RegCndHdlr_(CndHdlrPtr: PSPtr__:  *omit);
       WasInit_();
       Pgm_Init_();
       Dfn_Pgmfs_();
       main__();

       // Flush HTML buffer
       if  flush__ = *ON;
        outweb_('');
       endif;
       Pgm_Cleanup_();
       UnRegCndHdlr_(CndHdlrPtr : *omit);

       //  Close all files and shut down program:  -not persisent: close all.
       if ovrflag__ = '1';
        ExecCmd2_('dltovr file(*all)':17);
       endif;
       if  Persists__ = *OFF;
        *INLR = *ON;
       else;
        return;
       endif;

       // *PSSR  - Program exception/error handler.
       BEGSR *PSSR;
       // error handler closes error page HTML and writes it to browser:
       CALLP     ErrHandlr_('CLOSE' : PSDS__);
       // Exit program immediately:
       *INLR = *ON;
       RETURN;
       ENDSR;

      /end-free

      *--------------------------------------------------------------------------------------------*
      * Klistdcl__ - Subroutine to globally declare all KLISTS.
      *--------------------------------------------------------------------------------------------*
     C     Klistdcl__    BEGSR

     C     DL002_        KLIST
     C                   KFLD                    cmcount
     C                   ENDSR


      * Subprocedures follow:
      *--------------------------------------------------------------------------------------------*
      * main__ - Contains the main function source code from the PML
      *--------------------------------------------------------------------------------------------*
     P main__          B
     D main__          PI

      /free
       // PML Start ----------------------------------
       Setlibl_(PGMLIB__);
       Open_File_('*ALL': '*FIRST':  'Y');
      /end-free
     C/Exec SQL
     C+  SET OPTION DATFMT = *ISO
     C/End-Exec
      /free
       CUSTLIST_ = getcookie2_('CUSTLIST_state');
       if (task__ = 'DEFAULT');
        taskran__ = *ON;
        displaylist0();
       endif ;
       if (task__ = 'DISP');
        taskran__ = *ON;
        displayrecord0();
       endif ;
       if (task__ = 'DELCONF');
        taskran__ = *ON;
        deleteconfirm0();
       endif ;
       if (task__ = 'DEL');
        taskran__ = *ON;
        deleterecord0();
       endif ;
       if (task__ = 'BEGINADD');
        taskran__ = *ON;
        beginadd0();
       endif ;
       if (task__ = 'ENDADD');
        taskran__ = *ON;
        endadd0();
       endif ;
       if (task__ = 'BEGINCHANGE');
        taskran__ = *ON;
        beginchange0();
       endif ;
       if (task__ = 'ENDCHANGE');
        taskran__ = *ON;
        endchange0();
       endif ;

       // PML End   ----------------------------------
       if (taskran__ = *OFF and Jobtype__ ='0');

        // Write page for missing/incorrect TASK parm
        WriteNoTaskPg_();
       endif;
      /end-free
     c     *PSSR         begsr
     c                   endsr
     P main__          E



     P*---------------------------------------------------------------------
     P* displaylist0...             - User defined function
     P*---------------------------------------------------------------------
     P displaylist0...
     P                 B
     D displaylist0...
     D                 PI


     D selstring       S           3200A   varying
     D pagenum         S              5P 0


      /free
       pagenum = %dec(aton_( getparm3_('page':'*OPT'):46:16):5:0);
       if (pagenum = 0);
        pagenum = 1;
       endif;
       selstring = buildselectstring0();
       ww_pagea = %trim(%editc(pagenum:'P'));
       Setcookie_('CUSTLIST_state':CUSTLIST_:'*TEMP':'/':'*HOST':'0':'0');
       buildpage0(selstring:pagenum);
      /end-free
     c     *PSSR         begsr
     c                   endsr
     P                 E


     P*---------------------------------------------------------------------
     P* buildpage0...               - User defined function
     P*---------------------------------------------------------------------
     P buildpage0...
     P                 B
     D buildpage0...
     D                 PI
     D selstring                   3200A   varying
     D                                     VALUE

     D pagenum                        5P 0
     D                                     VALUE





     D rowoffset       S              5P 0
     D listsize        S              5P 0
     D x               S              5P 0

     D prevpage        S                   LIKE(pagenum       )
     D nextpage        S                   LIKE(pagenum       )

      /free
       selstring = selstring + ' FOR FETCH ONLY';
      /end-free
     C/Exec SQL
     C+            Declare CUSTLIST Scroll Cursor
     C+            For CUSTLIST
     C/End-Exec
     C/Exec SQL
     C+            Prepare CUSTLIST
     C+            From :selstring
     C/End-Exec
      /free
       if (sqlcod >= 0);
      /end-free
     C/Exec SQL
     C+            Open CUSTLIST
     C/End-Exec
      /free
       endif;
       prevpage = pagenum - 1;
       nextpage = pagenum + 1;
       listsize = 10;
       outweb_(%subst(%str(%addr(H__1(1))):1:1141));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__1(15))):22:558));
       AfToPage_(%trim(%editc(LISTSIZE:'Z')));
       outweb_(%subst(%str(%addr(H__1(22))):20:423));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__1(27))):43:18));
       wfrtn__ = AfToPage_(%char(CURTMST__));
       outweb_(%subst(%str(%addr(H__1(27))):61:118));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__1(29))):19:18));
       wfrtn__ = AfToPage_(%char(CURTMST__));
       outweb_(%subst(%str(%addr(H__1(29))):37:116));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__1(30))):73:18));
       wfrtn__ = AfToPage_(%char(CURTMST__));
       outweb_(%subst(%str(%addr(H__1(31))):11:112));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__1(32))):43:18));
       wfrtn__ = AfToPage_(%char(CURTMST__));
       outweb_(%subst(%str(%addr(H__1(32))):61:106));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__1(34))):7:19));
       wfrtn__ = AfToPage_(%char(CURTMST__));
       outweb_(%subst(%str(%addr(H__1(34))):26:112));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__1(35))):58:19));
       wfrtn__ = AfToPage_(%char(CURTMST__));
       outweb_(%subst(%str(%addr(H__1(35))):77:110));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__1(37))):27:18));
       wfrtn__ = AfToPage_(%char(CURTMST__));
       outweb_(%subst(%str(%addr(H__1(37))):45:115));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__1(38))):80:18));
       wfrtn__ = AfToPage_(%char(CURTMST__));
       outweb_(%subst(%str(%addr(H__1(39))):18:71));
       rowoffset = ( ( ( pagenum - 1) * listsize) + 1);
       fetch0(rowoffset);
       x = 1;
       dow (((((SQLCOD <> 100)) and ((SQLCOD >= 0)) and ((x <= listsize)))));
       chain(N) DL002_ R_CNTRYP;
       RS002_ = RcdSts2_('GETRCDN':%error: %found: %eof);
       Flip_Rc_();
       outweb_(%subst(%str(%addr(H__2(1))):1:12));
       wfrtn__ = AfToPage_(ARCLR__);
       outweb_(%subst(%str(%addr(H__2(1))):13:89));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__2(2))):22:18));
       AfToPage_(%trim(%editc(CMCUST:'X')));
       outweb_(%subst(%str(%addr(H__2(2))):40:5));
       wfrtn__ = AfToPage_(%char(CURTMST__));
       outweb_(%subst(%str(%addr(H__2(2))):45:65));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__2(3))):30:25));
       AfToPage_(%trim(%editc(CMCUST:'X')));
       outweb_(%subst(%str(%addr(H__2(3))):55:5));
       wfrtn__ = AfToPage_(%char(CURTMST__));
       outweb_(%subst(%str(%addr(H__2(3))):60:65));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__2(4))):45:21));
       AfToPage_(%trim(%editc(CMCUST:'X')));
       outweb_(%subst(%str(%addr(H__2(4))):66:60));
       AfToPage_(%trim(%editc(CMCUST:'X')));
       outweb_(%subst(%str(%addr(H__2(5))):46:42));
       AfToPage_(%trim(%editc(CMCUST:'P')));
       outweb_(%subst(%str(%addr(H__2(6))):8:25));
       wfrtn__ = AfToPage_(CMNAME);
       outweb_(%subst(%str(%addr(H__2(6))):33:25));
       wfrtn__ = AfToPage_(CMADR1);
       outweb_(%subst(%str(%addr(H__2(6))):58:25));
       wfrtn__ = AfToPage_(CMCITY);
       outweb_(%subst(%str(%addr(H__2(7))):3:25));
       wfrtn__ = AfToPage_(CMSTATE);
       outweb_(%subst(%str(%addr(H__2(7))):28:25));
       wfrtn__ = AfToPage_(CCNAME);
       outweb_(%subst(%str(%addr(H__2(7))):53:25));
       wfrtn__ = AfToPage_(CMCONT);
       outweb_(%subst(%str(%addr(H__2(7))):78:25));
       wfrtn__ = AfToPage_(%char(CMDACR: *USA));
       outweb_(%subst(%str(%addr(H__2(8))):23:12));
       x = x + 1;
       fetch0(1);
       enddo;
       outweb_(%subst(%str(%addr(H__3(1))):1:337));
       AfToPage_(%trim(%editc(LISTSIZE:'Z')));
       outweb_(%subst(%str(%addr(H__3(5))):18:403));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__3(10))):21:6));
       AfToPage_(%trim(%editc(PREVPAGE:'X')));
       outweb_(%subst(%str(%addr(H__3(10))):27:5));
       wfrtn__ = AfToPage_(%char(CURTMST__));
       outweb_(%subst(%str(%addr(H__3(10))):32:35));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__3(10))):67:6));
       AfToPage_(%trim(%editc(NEXTPAGE:'X')));
       outweb_(%subst(%str(%addr(H__3(10))):73:5));
       wfrtn__ = AfToPage_(%char(CURTMST__));
       outweb_(%subst(%str(%addr(H__3(10))):78:278));
       if (prevpage> 0);
        OutWeb_('jQuery(''.previous'').removeClass(''hidden'');');
       endif;
       outweb_(%subst(%str(%addr(H__3(14))):36:4));
       if (SQLCOD <> 100);
        OutWeb_('jQuery(''.next'').removeClass(''hidden'');');
       endif;
       outweb_(%subst(%str(%addr(H__3(14))):40:29));

      /end-free
     C/Exec SQL
     C+  close CUSTLIST
     C/End-Exec
      /free
      /end-free
     c     *PSSR         begsr
     c                   endsr
     P                 E


     P*---------------------------------------------------------------------
     P* buildselectstring0...       - User defined function
     P*---------------------------------------------------------------------
     P buildselectstring0...
     P                 B
     D buildselectstring0...
     D                 PI         65535A   VARYING


     D selstring       S           3200A   varying
     D ordby           S             64A


      /free
       selstring = 'SELECT  MU_CUSTL1.CMCUST, MU_CUSTL1.CMNAME, MU_CUSTL1.CMA-
       DR1, MU_CUSTL1.CMCITY, MU_CUSTL1.CMSTATE, MU_CUSTL1.CMCOUNT, MU_CUSTL1-
       .CMCONT, MU_CUSTL1.CMDACR FROM MU_CUSTL1';
       ordby = getparm3_('ordby':'*OPT');
       if (ordby <> '');
        if (ww_ordby = ordby);
         if (ww_orddir = 'A');
          ww_orddir = 'D';
         else;
          ww_orddir = 'A';
         endif;
        else;
         ww_ordby = ordby;
         ww_orddir = 'A';
        endif;
       else;
        if (ww_orddir = '');
         ww_orddir = 'A';
        endif;
       endif;
       if (ww_ordby = '');
        ww_ordby = 'CMNAME';
       endif;
       selstring = selstring + ' order by ' + ww_ordby;
       if (ww_orddir = 'D');
        selstring = selstring + ' DESC';
       endif;
       return selstring;
      /end-free
     c     *PSSR         begsr
     c                   endsr
     P                 E


     P*---------------------------------------------------------------------
     P* fetch0...                   - User defined function
     P*---------------------------------------------------------------------
     P fetch0...
     P                 B
     D fetch0...
     D                 PI
     D rowoffset                      5P 0
     D                                     VALUE






      /free

      /end-free
     C/Exec SQL
     C+  FETCH RELATIVE :RowOffset  FROM CUSTLIST INTO :CMCUST, :CMNAME, :CMADR1
     C+ , :CMCITY, :CMSTATE, :CMCOUNT, :CMCONT, :CMDACR
     C/End-Exec
      /free
      /end-free
     c     *PSSR         begsr
     c                   endsr
     P                 E


     P*---------------------------------------------------------------------
     P* displayrecord0...           - User defined function
     P*---------------------------------------------------------------------
     P displayrecord0...
     P                 B
     D displayrecord0...
     D                 PI


     D rcdcnt          S             10P 0


      /free
       cmcust = %dec(aton_( getparm3_('cmcust':'*OPT'):46:16):7:0);
      /end-free
     C/Exec SQL
     C+  SELECT COUNT(*) into :rcdcnt FROM MU_CUSTL1 where CMCUST = :CMCUST
     C/End-Exec
      /free
       if (rcdcnt> 1);
        OutWeb_('More than one row matches the set of key fields provided. No-
        record will be displayed.');
        return ;
       endif;
      /end-free
     C/Exec SQL
     C+  SELECT  CMCUST, CMNAME, CMADR1, CMCITY, CMSTATE, CMCOUNT, CMCONT, CMDAC
     C+ R, CMADR2, CMPOST, CMAREA, CMPHON, CMEMAIL, CMTERM, CMDSCNT INTO :CMCUST
     C+ , :CMNAME, :CMADR1, :CMCITY, :CMSTATE, :CMCOUNT, :CMCONT, :CMDACR, :CMAD
     C+ R2, :CMPOST, :CMAREA, :CMPHON, :CMEMAIL, :CMTERM, :CMDSCNT FROM MU_CUSTL
     C+ 1 where CMCUST = :CMCUST
     C/End-Exec
      /free
       outweb_(%subst(%str(%addr(H__4(1))):1:910));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__4(12))):31:6));
       wfrtn__ = AfToPage_(WW_PAGEA);
       outweb_(%subst(%str(%addr(H__4(12))):37:717));
       AfToPage_(%trim(%editc(CMCUST:'P')));
       outweb_(%subst(%str(%addr(H__4(21))):34:155));
       wfrtn__ = AfToPage_(CMNAME);
       outweb_(%subst(%str(%addr(H__4(23))):29:151));
       wfrtn__ = AfToPage_(CMADR1);
       outweb_(%subst(%str(%addr(H__4(25))):20:146));
       wfrtn__ = AfToPage_(CMCITY);
       outweb_(%subst(%str(%addr(H__4(27))):6:152));
       wfrtn__ = AfToPage_(CMSTATE);
       outweb_(%subst(%str(%addr(H__4(28))):78:149));
       wfrtn__ = AfToPage_(CMCOUNT);
       outweb_(%subst(%str(%addr(H__4(30))):67:154));
       wfrtn__ = AfToPage_(CMCONT);
       outweb_(%subst(%str(%addr(H__4(32))):61:156));
       wfrtn__ = AfToPage_(%char(CMDACR));
       outweb_(%subst(%str(%addr(H__4(34))):57:151));
       wfrtn__ = AfToPage_(CMADR2);
       outweb_(%subst(%str(%addr(H__4(36))):48:157));
       wfrtn__ = AfToPage_(CMPOST);
       outweb_(%subst(%str(%addr(H__4(38))):45:151));
       AfToPage_(%trim(%editc(CMAREA:'P')));
       outweb_(%subst(%str(%addr(H__4(40))):36:154));
       AfToPage_(%trim(%editc(CMPHON:'P')));
       outweb_(%subst(%str(%addr(H__4(42))):30:155));
       wfrtn__ = AfToPage_(CMEMAIL);
       outweb_(%subst(%str(%addr(H__4(44))):25:147));
       AfToPage_(%trim(%editc(CMTERM:'P')));
       outweb_(%subst(%str(%addr(H__4(46))):12:155));
       AfToPage_(%trim(%editc(CMDSCNT:'P')));
       outweb_(%subst(%str(%addr(H__4(48))):7:92));
       if (TASK__ = 'DISP');
        outweb_(%subst(%str(%addr(H__6(1))):1:52));
       else;
        if (TASK__ = 'DELCONF');
         outweb_(%subst(%str(%addr(H__5(1))):1:118));
         wfrtn__ = AfToPage_(QPGMNAM__);
         outweb_(%subst(%str(%addr(H__5(2))):39:17));
         AfToPage_(%trim(%editc(CMCUST:'X')));
         outweb_(%subst(%str(%addr(H__5(2))):56:83));
         wfrtn__ = AfToPage_(QPGMNAM__);
         outweb_(%subst(%str(%addr(H__5(3))):59:6));
         wfrtn__ = AfToPage_(WW_PAGEA);
         outweb_(%subst(%str(%addr(H__5(3))):65:14));
        endif;
       endif;
       outweb_(%subst(%str(%addr(H__4(49))):19:89));

      /end-free
     c     *PSSR         begsr
     c                   endsr
     P                 E


     P*---------------------------------------------------------------------
     P* deleteconfirm0...           - User defined function
     P*---------------------------------------------------------------------
     P deleteconfirm0...
     P                 B
     D deleteconfirm0...
     D                 PI


     D rcdcnt          S             10P 0


      /free
       cmcust = %dec(aton_( getparm3_('cmcust':'*OPT'):46:16):7:0);
      /end-free
     C/Exec SQL
     C+  SELECT COUNT(*) into :rcdcnt FROM MU_CUSTL1 where CMCUST = :CMCUST
     C/End-Exec
      /free
       if (rcdcnt> 1);
        OutWeb_('More than one record is identified by the key values you''ve-
        specified. Record deletion is NOT available.');
        return ;
       endif;
      /end-free
     C/Exec SQL
     C+  SELECT  CMCUST, CMNAME, CMADR1, CMCITY, CMSTATE, CMCOUNT, CMCONT, CMDAC
     C+ R, CMADR2, CMPOST, CMAREA, CMPHON, CMEMAIL, CMTERM, CMDSCNT INTO :CMCUST
     C+ , :CMNAME, :CMADR1, :CMCITY, :CMSTATE, :CMCOUNT, :CMCONT, :CMDACR, :CMAD
     C+ R2, :CMPOST, :CMAREA, :CMPHON, :CMEMAIL, :CMTERM, :CMDSCNT FROM MU_CUSTL
     C+ 1 where CMCUST = :CMCUST
     C/End-Exec
      /free
       outweb_(%subst(%str(%addr(H__4(1))):1:910));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__4(12))):31:6));
       wfrtn__ = AfToPage_(WW_PAGEA);
       outweb_(%subst(%str(%addr(H__4(12))):37:717));
       AfToPage_(%trim(%editc(CMCUST:'P')));
       outweb_(%subst(%str(%addr(H__4(21))):34:155));
       wfrtn__ = AfToPage_(CMNAME);
       outweb_(%subst(%str(%addr(H__4(23))):29:151));
       wfrtn__ = AfToPage_(CMADR1);
       outweb_(%subst(%str(%addr(H__4(25))):20:146));
       wfrtn__ = AfToPage_(CMCITY);
       outweb_(%subst(%str(%addr(H__4(27))):6:152));
       wfrtn__ = AfToPage_(CMSTATE);
       outweb_(%subst(%str(%addr(H__4(28))):78:149));
       wfrtn__ = AfToPage_(CMCOUNT);
       outweb_(%subst(%str(%addr(H__4(30))):67:154));
       wfrtn__ = AfToPage_(CMCONT);
       outweb_(%subst(%str(%addr(H__4(32))):61:156));
       wfrtn__ = AfToPage_(%char(CMDACR));
       outweb_(%subst(%str(%addr(H__4(34))):57:151));
       wfrtn__ = AfToPage_(CMADR2);
       outweb_(%subst(%str(%addr(H__4(36))):48:157));
       wfrtn__ = AfToPage_(CMPOST);
       outweb_(%subst(%str(%addr(H__4(38))):45:151));
       AfToPage_(%trim(%editc(CMAREA:'P')));
       outweb_(%subst(%str(%addr(H__4(40))):36:154));
       AfToPage_(%trim(%editc(CMPHON:'P')));
       outweb_(%subst(%str(%addr(H__4(42))):30:155));
       wfrtn__ = AfToPage_(CMEMAIL);
       outweb_(%subst(%str(%addr(H__4(44))):25:147));
       AfToPage_(%trim(%editc(CMTERM:'P')));
       outweb_(%subst(%str(%addr(H__4(46))):12:155));
       AfToPage_(%trim(%editc(CMDSCNT:'P')));
       outweb_(%subst(%str(%addr(H__4(48))):7:92));
       if (TASK__ = 'DISP');
        outweb_(%subst(%str(%addr(H__6(1))):1:52));
       else;
        if (TASK__ = 'DELCONF');
         outweb_(%subst(%str(%addr(H__5(1))):1:118));
         wfrtn__ = AfToPage_(QPGMNAM__);
         outweb_(%subst(%str(%addr(H__5(2))):39:17));
         AfToPage_(%trim(%editc(CMCUST:'X')));
         outweb_(%subst(%str(%addr(H__5(2))):56:83));
         wfrtn__ = AfToPage_(QPGMNAM__);
         outweb_(%subst(%str(%addr(H__5(3))):59:6));
         wfrtn__ = AfToPage_(WW_PAGEA);
         outweb_(%subst(%str(%addr(H__5(3))):65:14));
        endif;
       endif;
       outweb_(%subst(%str(%addr(H__4(49))):19:89));

      /end-free
     c     *PSSR         begsr
     c                   endsr
     P                 E


     P*---------------------------------------------------------------------
     P* deleterecord0...            - User defined function
     P*---------------------------------------------------------------------
     P deleterecord0...
     P                 B
     D deleterecord0...
     D                 PI




      /free
       cmcust = %dec(aton_( getparm3_('cmcust':'*OPT'):46:16):7:0);
      /end-free
     C/Exec SQL
     C+  delete from MU_CUSTL1 where CMCUST = :CMCUST with NC
     C/End-Exec
      /free
       if (SQLCOD <> 0);
        Alert_('Error: the record was not deleted.');
       endif;
       Redirect2_( '?page=' + ww_pagea:'*SAME');
      /end-free
     c     *PSSR         begsr
     c                   endsr
     P                 E


     P*---------------------------------------------------------------------
     P* beginadd0...                - User defined function
     P*---------------------------------------------------------------------
     P beginadd0...
     P                 B
     D beginadd0...
     D                 PI




      /free
       outweb_(%subst(%str(%addr(H__8(1))):1:995));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__8(13))):36:6));
       wfrtn__ = AfToPage_(WW_PAGEA);
       outweb_(%subst(%str(%addr(H__8(13))):42:581));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__8(20))):63:363));
       AfToPage_(%trim(%editc(CMCUST:'P')));
       outweb_(%subst(%str(%addr(H__8(25))):26:242));
       wfrtn__ = AfToPage_(CMNAME);
       outweb_(%subst(%str(%addr(H__8(28))):28:238));
       wfrtn__ = AfToPage_(CMADR1);
       outweb_(%subst(%str(%addr(H__8(31))):26:233));
       wfrtn__ = AfToPage_(CMCITY);
       outweb_(%subst(%str(%addr(H__8(34))):19:239));
       wfrtn__ = AfToPage_(CMSTATE);
       outweb_(%subst(%str(%addr(H__8(37))):18:236));
       wfrtn__ = AfToPage_(CMCOUNT);
       outweb_(%subst(%str(%addr(H__8(40))):14:241));
       wfrtn__ = AfToPage_(CMCONT);
       outweb_(%subst(%str(%addr(H__8(43))):15:243));
       wfrtn__ = AfToPage_(%char(CMDACR));
       outweb_(%subst(%str(%addr(H__8(46))):18:238));
       wfrtn__ = AfToPage_(CMADR2);
       outweb_(%subst(%str(%addr(H__8(49))):16:242));
       wfrtn__ = AfToPage_(CMPOST);
       outweb_(%subst(%str(%addr(H__8(52))):18:236));
       AfToPage_(%trim(%editc(CMAREA:'P')));
       outweb_(%subst(%str(%addr(H__8(55))):14:239));
       AfToPage_(%trim(%editc(CMPHON:'P')));
       outweb_(%subst(%str(%addr(H__8(58))):13:219));
       wfrtn__ = AfToPage_(CMEMAIL);
       outweb_(%subst(%str(%addr(H__8(60))):72:241));
       AfToPage_(%trim(%editc(CMTERM:'P')));
       outweb_(%subst(%str(%addr(H__8(63))):73:242));
       AfToPage_(%trim(%editc(CMDSCNT:'P')));
       outweb_(%subst(%str(%addr(H__8(66))):75:344));

      /end-free
     c     *PSSR         begsr
     c                   endsr
     P                 E


     P*---------------------------------------------------------------------
     P* endadd0...                  - User defined function
     P*---------------------------------------------------------------------
     P endadd0...
     P                 B
     D endadd0...
     D                 PI




      /free
       cmcust = %dec(aton_( getparm3_('cmcust':'*OPT'):46:16):7:0);
       cmname = getparm3_('cmname':'*OPT');
       cmadr1 = getparm3_('cmadr1':'*OPT');
       cmcity = getparm3_('cmcity':'*OPT');
       cmstate = getparm3_('cmstate':'*OPT');
       cmcount = getparm3_('cmcount':'*OPT');
       cmcont = getparm3_('cmcont':'*OPT');
       CMDACR = AlpToDate_( getparm3_('CMDACR':'*OPT'):'*ISO');
       cmadr2 = getparm3_('cmadr2':'*OPT');
       cmpost = getparm3_('cmpost':'*OPT');
       cmarea = %dec(aton_( getparm3_('cmarea':'*OPT'):46:16):3:0);
       cmphon = %dec(aton_( getparm3_('cmphon':'*OPT'):46:16):7:0);
       cmemail = getparm3_('cmemail':'*OPT');
       cmterm = %dec(aton_( getparm3_('cmterm':'*OPT'):46:16):2:0);
       cmdscnt = %dec(aton_( getparm3_('cmdscnt':'*OPT'):46:16):2:0);
      /end-free
     C/Exec SQL
     C+  INSERT INTO MU_CUSTL1 (CMCUST, CMNAME, CMADR1, CMADR2, CMCITY, CMSTATE,
     C+  CMCOUNT, CMPOST, CMAREA, CMPHON, CMCONT, CMEMAIL, CMTERM, CMDACR, CMDSC
     C+ NT) VALUES( :CMCUST, :CMNAME, :CMADR1, :CMADR2, :CMCITY, :CMSTATE, :CMCO
     C+ UNT, :CMPOST, :CMAREA, :CMPHON, :CMCONT, :CMEMAIL, :CMTERM, :CMDACR, :CM
     C+ DSCNT) with NC
     C/End-Exec
      /free
       if (SQLCOD <> 0);
        Alert_('Error: the record was not added.');
       endif;
       Redirect2_( '?page=' + ww_pagea:'*SAME');
      /end-free
     c     *PSSR         begsr
     c                   endsr
     P                 E


     P*---------------------------------------------------------------------
     P* beginchange0...             - User defined function
     P*---------------------------------------------------------------------
     P beginchange0...
     P                 B
     D beginchange0...
     D                 PI


     D rcdcnt          S             10P 0


      /free
       cmcust = %dec(aton_( getparm3_('cmcust':'*OPT'):46:16):7:0);
      /end-free
     C/Exec SQL
     C+  SELECT COUNT(*) into :rcdcnt FROM MU_CUSTL1 where CMCUST = :CMCUST
     C/End-Exec
      /free
       if (rcdcnt> 1);
        OutWeb_('Updating rows with requested parameters would change more th-
       an one record. A record was not opened for changes.');
        return ;
       endif;
      /end-free
     C/Exec SQL
     C+  SELECT  CMCUST, CMNAME, CMADR1, CMCITY, CMSTATE, CMCOUNT, CMCONT, CMDAC
     C+ R, CMADR2, CMPOST, CMAREA, CMPHON, CMEMAIL, CMTERM, CMDSCNT INTO :CMCUST
     C+ , :CMNAME, :CMADR1, :CMCITY, :CMSTATE, :CMCOUNT, :CMCONT, :CMDACR, :CMAD
     C+ R2, :CMPOST, :CMAREA, :CMPHON, :CMEMAIL, :CMTERM, :CMDSCNT FROM MU_CUSTL
     C+ 1 where CMCUST = :CMCUST
     C/End-Exec
      /free
       outweb_(%subst(%str(%addr(H__7(1))):1:1059));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__7(14))):20:6));
       wfrtn__ = AfToPage_(WW_PAGEA);
       outweb_(%subst(%str(%addr(H__7(14))):26:587));
       wfrtn__ = AfToPage_(QPGMNAM__);
       outweb_(%subst(%str(%addr(H__7(21))):53:161));
       AfToPage_(%trim(%editc(CMCUST:'X')));
       outweb_(%subst(%str(%addr(H__7(23))):54:294));
       AfToPage_(%trim(%editc(CMCUST:'P')));
       outweb_(%subst(%str(%addr(H__7(27))):28:242));
       wfrtn__ = AfToPage_(CMNAME);
       outweb_(%subst(%str(%addr(H__7(30))):30:238));
       wfrtn__ = AfToPage_(CMADR1);
       outweb_(%subst(%str(%addr(H__7(33))):28:233));
       wfrtn__ = AfToPage_(CMCITY);
       outweb_(%subst(%str(%addr(H__7(36))):21:239));
       wfrtn__ = AfToPage_(CMSTATE);
       outweb_(%subst(%str(%addr(H__7(39))):20:236));
       wfrtn__ = AfToPage_(CMCOUNT);
       outweb_(%subst(%str(%addr(H__7(42))):16:241));
       wfrtn__ = AfToPage_(CMCONT);
       outweb_(%subst(%str(%addr(H__7(45))):17:243));
       wfrtn__ = AfToPage_(%char(CMDACR));
       outweb_(%subst(%str(%addr(H__7(48))):20:238));
       wfrtn__ = AfToPage_(CMADR2);
       outweb_(%subst(%str(%addr(H__7(51))):18:242));
       wfrtn__ = AfToPage_(CMPOST);
       outweb_(%subst(%str(%addr(H__7(54))):20:236));
       AfToPage_(%trim(%editc(CMAREA:'P')));
       outweb_(%subst(%str(%addr(H__7(57))):16:239));
       AfToPage_(%trim(%editc(CMPHON:'P')));
       outweb_(%subst(%str(%addr(H__7(60))):15:219));
       wfrtn__ = AfToPage_(CMEMAIL);
       outweb_(%subst(%str(%addr(H__7(62))):74:241));
       AfToPage_(%trim(%editc(CMTERM:'P')));
       outweb_(%subst(%str(%addr(H__7(65))):75:242));
       AfToPage_(%trim(%editc(CMDSCNT:'P')));
       outweb_(%subst(%str(%addr(H__7(68))):77:347));

      /end-free
     c     *PSSR         begsr
     c                   endsr
     P                 E


     P*---------------------------------------------------------------------
     P* endchange0...               - User defined function
     P*---------------------------------------------------------------------
     P endchange0...
     P                 B
     D endchange0...
     D                 PI


     D rcdcnt          S             10P 0


      /free
       cmcust_ = %dec(aton_( getparm3_('cmcust_':'*OPT'):46:16):7:0);
      /end-free
     C/Exec SQL
     C+  SELECT CMCUST, CMNAME, CMADR1, CMADR2, CMCITY, CMSTATE, CMCOUNT, CMPOST
     C+ , CMAREA, CMPHON, CMCONT, CMEMAIL, CMTERM, CMDACR, CMDSCNT into :CMCUST,
     C+  :CMNAME, :CMADR1, :CMADR2, :CMCITY, :CMSTATE, :CMCOUNT, :CMPOST, :CMARE
     C+ A, :CMPHON, :CMCONT, :CMEMAIL, :CMTERM, :CMDACR, :CMDSCNT from MU_CUSTL1
     C+  where CMCUST = :CMCUST_
     C/End-Exec
      /free
       if (SQLCOD <> 0);
        Alert_('Error: couldn''t find the specified record');
       endif;
       cmcust = %dec(aton_( getparm3_('cmcust':'*OPT'):46:16):7:0);
       cmname = getparm3_('cmname':'*OPT');
       cmadr1 = getparm3_('cmadr1':'*OPT');
       cmcity = getparm3_('cmcity':'*OPT');
       cmstate = getparm3_('cmstate':'*OPT');
       cmcount = getparm3_('cmcount':'*OPT');
       cmcont = getparm3_('cmcont':'*OPT');
       CMDACR = AlpToDate_( getparm3_('CMDACR':'*OPT'):'*ISO');
       cmadr2 = getparm3_('cmadr2':'*OPT');
       cmpost = getparm3_('cmpost':'*OPT');
       cmarea = %dec(aton_( getparm3_('cmarea':'*OPT'):46:16):3:0);
       cmphon = %dec(aton_( getparm3_('cmphon':'*OPT'):46:16):7:0);
       cmemail = getparm3_('cmemail':'*OPT');
       cmterm = %dec(aton_( getparm3_('cmterm':'*OPT'):46:16):2:0);
       cmdscnt = %dec(aton_( getparm3_('cmdscnt':'*OPT'):46:16):2:0);
       cmcust = cmcust_;
       if ((cmcust <> cmcust_));
      /end-free
     C/Exec SQL
     C+  SELECT COUNT(*) into :rcdcnt from MU_CUSTL1 where CMCUST = :CMCUST
     C/End-Exec
      /free
        if (rcdcnt> 0);
         OutWeb_('Requested update would create multiple records with the sam-
       e key values. No records have been changed.');
         return ;
        endif;
       endif;
      /end-free
     C/Exec SQL
     C+  UPDATE MU_CUSTL1 SET(CMCUST, CMNAME, CMADR1, CMADR2, CMCITY, CMSTATE, C
     C+ MCOUNT, CMPOST, CMAREA, CMPHON, CMCONT, CMEMAIL, CMTERM, CMDACR, CMDSCNT
     C+ ) = ( :CMCUST, :CMNAME, :CMADR1, :CMADR2, :CMCITY, :CMSTATE, :CMCOUNT, :
     C+ CMPOST, :CMAREA, :CMPHON, :CMCONT, :CMEMAIL, :CMTERM, :CMDACR, :CMDSCNT)
     C+  where CMCUST = :CMCUST_ with NC
     C/End-Exec
      /free
       if (SQLCOD <> 0);
        Alert_('Error: the record was not updated.');
       endif;
       Redirect2_( '?page=' + ww_pagea:'*SAME');
      /end-free
     c     *PSSR         begsr
     c                   endsr
     P                 E


      *--------------------------------------------------------------------------------------------*
      * Pgm_Init_ - Program initialization
      *--------------------------------------------------------------------------------------------*
     P Pgm_Init_       B
     D Pgm_Init_       PI
      /free

      /end-free
      /free
       QPGMNAM__=%trim(PGMNAME__) + '.pgm';
      /end-free
      /free
       CURTMST__ = %timestamp();

       // Initialize library list array for current job to find files
       rtlla__(1) = 'DOMSPR1DTA';

       // Set the runtime library for support object references.
       // Also, determine job type
       jobtype__ = SetRtLib_('XL_WEBSPT');

       // Register the condition handler. Use a pointer to the
       // pgm status data structure
       RegCndHdlr_(CndHdlrPtr:  PSPtr__: *omit);

       // Set minimum page size limit to 2Mb.
       if PgSizeLm__ < 2000000;
        PgSizeLm__ = 2000000;
       endif;

       //  Get the task. If none provided, use the default:
       task__ = getparm3_('TASK');
       if  task__ = '';
        task__ = 'DEFAULT';
       else;
        //  Convert the parameter value to upper case:
        task__ = %XLATE(lo__: up__  :task__);
       endif;

       // Clear the HTTP Headers
       HTTPHEADERS__ = '';

      /end-free
     P Pgm_Init_       E


      *--------------------------------------------------------------------------------------------*
      * Pgm_Cnl_  - Program cancellation initiated by Condition Handler
      *--------------------------------------------------------------------------------------------*
     P Pgm_Cnl_        B
      *   Call error handler to close error page HTML properly, and write it to browser:
     C                   CALLP     ErrHandlr_('CLOSE')
      /free

      /end-free
      *   Shutdown program immediately:
     C                   CALLP     Shutdown_
     P Pgm_Cnl_        E


      *----------------------------------------------------------------
      * Open_File_  - Open a specified file
      *----------------------------------------------------------------
     P Open_File_      B
     D Open_File_      PI             1A
      * Parameters: HTML string to write, and its calculated length:
     D file__                        10    value
     D mbr__                         10    value
     D erropen__                      1    value

     C                   eval      *in90 = *off

      /free
       // Open database files
       if   ((file__='MU_CUSTL1' or file__='*ALL') and NOT %OPEN(MU_CUSTL1));
        if (mbr__ <> '*FIRST');
         ovrdbf_(ovrflag__:'MU_CUSTL1':'MU_CUSTL1' : '*LIBL' : mbr__);
        elseif ('MU_CUSTL1' <> 'MU_CUSTL1');
         ovrdbf_(ovrflag__:'MU_CUSTL1':'MU_CUSTL1' : '*LIBL');
        endif;
        if    erropen__ = 'Y';
         OPEN(E) MU_CUSTL1;                //    DOMSPR1DTA/MU_CUSTL1
         if        %error;
          return %error;
         endif;
        else;
         OPEN MU_CUSTL1;                //    DOMSPR1DTA/MU_CUSTL1
        endif;
       endif;
       if   ((file__='MU_CNTRYPF' or file__='*ALL') and NOT %OPEN(MU_CNTRYPF));
        if (mbr__ <> '*FIRST');
         ovrdbf_(ovrflag__:'MU_CNTRYPF':'MU_CNTRYPF' : '*LIBL' : mbr__);
        elseif ('MU_CNTRYPF' <> 'MU_CNTRYPF');
         ovrdbf_(ovrflag__:'MU_CNTRYPF':'MU_CNTRYPF' : '*LIBL');
        endif;
        if    erropen__ = 'Y';
         OPEN(E) MU_CNTRYPF;                //    DOMSPR1DTA/MU_CNTRYPF
         if        %error;
          return %error;
         endif;
        else;
         OPEN MU_CNTRYPF;                //    DOMSPR1DTA/MU_CNTRYPF
        endif;
       endif;
      /end-free

     C                   return    *in90
     P Open_File_      E


      *--------------------------------------------------------------------------------------------*
      * UpdateRcd_  - Update a specified record format
      *--------------------------------------------------------------------------------------------*
     P UpdateRcd_      B
     D UpdateRcd_      PI             1A
      * Parameters: Record format name to Update
     D rcdfmt__                      10    value

     D UpdateRcdSts    S              1

      /free
       select;
       endsl;
      /end-free

     C                   EVAL      UpdateRcdSts= RcdSts2_('UPDRCD'
     C                             :%error:%found:%eof)
     C                   RETURN    UpdateRcdSts

     P UpdateRcd_      E



      *--------------------------------------------------------------------------------------------*
      * DeleteRcd_  - Delete a specified record format
      *--------------------------------------------------------------------------------------------*
     P DeleteRcd_      B
     D DeleteRcd_      PI             1A
      * Parameters: Record format name to delete
     D rcdfmt__                      10    value

     D DeleteRcdSts    S              1

      /free
       select;
       endsl;
      /end-free

     C                   EVAL      DeleteRcdSts= RcdSts2_('DELRCD'
     C                             :%error:%found:%eof)
     C                   RETURN    DeleteRcdSts

     P DeleteRcd_      E


      *--------------------------------------------------------------------------------------------*
      * Dfn_Pgmfs_ - Define Program Fields for use in any program
      *--------------------------------------------------------------------------------------------*
     P Dfn_Pgmfs_      B
     D Dfn_Pgmfs_      PI
      *+DFNPGF

     P Dfn_Pgmfs_      E

      *--------------------------------------------------------------------------------------------*
      * Flip_Rc_ - Flip the alternating row colors
      *--------------------------------------------------------------------------------------------*
     P Flip_Rc_        B
     D Flip_Rc_        PI
      /free
       if ARCLR__ = RWCOLOR1__;
        ARCLR__ = RWCOLOR2__;
       else;
        ARCLR__ = RWCOLOR1__;
       endif;

      /end-free
     P Flip_Rc_        E

      *--------------------------------------------------------------------------------------------*
      * Exit_Immed_ - Exit program immediately. Flush current HTML buffer.
      *--------------------------------------------------------------------------------------------*
     P Exit_Immed_     B
     D Exit_Immed_     PI
      /free
       outweb_('');
       Pgm_Cleanup_();

       // Close all files and shut down program:
       if ovrflag__ = '1';
        ExecCmd2_('dltovr file(*all)':17);
       endif;
       Shutdown_();                          //     Shut down completely

      /end-free
     P Exit_Immed_     E







      *+CTARRS Compile-time Arrays go here:
**CTDATA PTL__      Program title contents
Customer Listing
**CTDATA H__1        ListHeader                       3128
<!DOCTYPE html>
<html>
  <head>
    <meta name="generator" content="WebSmart" />

    <meta http-equiv="Pragma" content="no-cache" />
    <title>Customer Listing
</title>
    
    <link rel="stylesheet" type="text/css" href="/websmart/v10.8/S
onora/css/jquery-ui.css"/>	
    <link rel="stylesheet" type="text/css" href="/we
bsmart/v10.8/Sonora/css/screen.css" media="all" />
    <link rel="stylesheet" ty
pe="text/css" href="/websmart/v10.8/Sonora/css/print.css" media="print" />
    

    <script type="text/javascript" src="/websmart/v10.8/js/jquery.min.js"></scri
pt>
    <script type="text/javascript" src="/websmart/v10.8/js/jquery-ui.min.js"
></script>
  </head>
  <body class="display-list">
    <div id="outer-content">

      <div id="page-title-block" class="page-title-block">
        <img class="p
age-title-image" src="/websmart/v10.8/Sonora/images/company-logo.png" alt="logo"
 />
        <div id="page-divider-top" class="page-divider"></div>
      </div>

      <div id="page-content">
        <div id="content-header">
          <h1 cl
ass="title">Customer Listing</h1>
          <span class="add-link">

<a class="add" href="?task=beginadd">
              <img src="/websmart/v10.8/So
nora/images/add.png" alt="" /> Add Record
            </a>
          </span>

     </div>
        <div id="contents">
          <span id="list-paging-top" cla
ss="list-paging">
            <a id="previous-link-top" class="list-paging previ
ous hidden" href="#">
              <img src="/websmart/v10.8/Sonora/images/arro
w-left.png" title="Previous" alt="" /> <span>Previous</span>
            </a>

          <a id="next-link-top" class="list-paging next hidden" href="#">

        <span>Next </span> <img src="/websmart/v10.8/Sonora/images/arrow-right.p
ng" title="Next" alt="" />
            </a>
          </span>
          <div cla
ss="clear-layout"></div>
          <table id="list-table" class="main-list ui-wi
dget-content" cellspacing="0">
            <tr class="header ui-widget-header">

              <th class="actions">Action</th> 
              <th width="70">

             <a class="list-header" href="?ordby=CMCUST&rnd=">Customer Number</a
>
              </th>
              <th width="200">
                <a class="l
ist-header" href="?ordby=CMNAME&rnd=">Customer Name</a>
              </th>

          <th width="200">
                <a class="list-header" href="?ordby=C
MADR1&rnd=">Address 1</a>
              </th>
              <th width="200">

             <a class="list-header" href="?ordby=CMCITY&rnd=">City</a>

     </th>
              <th width="20">
                <a class="list-header"
href="?ordby=CMSTATE&rnd=">State/Prov</a>
              </th>
              <th
width="20">
                <a class="list-header" href="?ordby=CMCOUNT&rnd=">Co
untry</a>
              </th>
              <th width="200">
                <a
class="list-header" href="?ordby=CMCONT&rnd=">Contact Name</a>
              </t
h>
              <th width="100">
                <a class="list-header" href="?
ordby=CMDACR&rnd=">Customer Since</a>
              </th>
            </tr>


**CTDATA H__2        ListDetails                      594

<tr class=""> 
  <td class="actions"><span>
      <a class="display" title="Vie
w this record" href="?TASK=disp&CMCUST=&rnd="></a> 
      <a class="change" titl
e="Change this record" href="?TASK=beginchange&CMCUST=&rnd="></a> 
      <a clas
s="delete" title="Delete this record" href="?TASK=delconf&CMCUST="></a></span>

     <a href="ORDERS.pgm?task=DEFAULT&custno=">Orders</a></td> 
  <td class="tex
t num"></td>
  <td class="text"></td>
  <td class="text"></td>
  <td class="text
"></td>
  <td class="text"></td>
  <td class="text"></td>
  <td class="text"></t
d>
  <td class="text"></td>
</tr>

**CTDATA H__3        ListFooter                       1108
</table>
<span id="list-paging-bottom" class="list-paging">
  <a id="previous-li
nk-bottom" class="list-paging previous hidden" href="#">
    <img src="/websmart
/v10.8/Sonora/images/arrow-left.png" title="Previous" alt="" /> <span>Previous</
span>
  </a>
  <a id="next-link-bottom" class="list-paging next hidden" href="#"
>
    <span>Next </span> <img src="/websmart/v10.8/Sonora/images/arrow-right.png
" title="Next" alt="" />
  </a>
</span>
<div class="clear-layout"></div>
<div id
="page-divider-bottom" class="page-divider"></div>
</div>
</div>
</div>

<script
 type="text/javascript">
	jQuery(function() {
		jQuery( "input:submit, button, a
.add").button();
		jQuery('input:enabled:first').focus();
	});
	
	jQuery(".previ
ous").attr("href", "?page=&rnd=");
	jQuery(".next").attr("href", "?page=&rnd=");

	
	jQuery(".delete").button({
		icons: { primary: "ui-icon-closethick" },
		tex
t: false
	}); 
	jQuery(".display").button({
		icons: { primary: "ui-icon-documen
t" },
		text: false
	}); 
	jQuery(".change").button({
		icons: { primary: "ui-ic
on-pencil" },
		text: false
	});	
	
	
		
</script>

</body>
</html>

**CTDATA H__4        RcdDisplay                       3947
<!DOCTYPE html>
<html>
  <head>
    <meta name="generator" content="WebSmart" />

    <meta http-equiv="Pragma" content="no-cache" />
    <title>Customer Listing
 - Display</title>
    
    <link rel="stylesheet" type="text/css" href="/websma
rt/v10.8/Sonora/css/jquery-ui.css"/>	
    <link rel="stylesheet" type="text/css"
 href="/websmart/v10.8/Sonora/css/screen.css" media="all" />
    <link rel="styl
esheet" type="text/css" href="/websmart/v10.8/Sonora/css/print.css" media="print
" />
    
    <script type="text/javascript" src="/websmart/v10.8/js/jquery.min.
js"></script>
    <script type="text/javascript" src="/websmart/v10.8/js/jquery-
ui.min.js"></script>
    <script type="text/javascript">
		jQuery(function() {


			jQuery("input:submit, button, input:button").button();

			// Bind event to t
he Back button
			jQuery('#backbutton').click(goback);
			function goback()
			{

				window.location.replace("?page=");
				return false;
			}
		});
	</script>

  </head>
  <body class="single-record display-record">
    <div id="outer-conte
nt">
      <div id="page-title-block" class="page-title-block">
        <img cla
ss="page-title-image" src="/websmart/v10.8/Sonora/images/company-logo.png" alt="
logo" />
        <div id="page-divider-top" class="page-divider"></div>
      </
div>
      <div id="page-content">
        <div id="content-header">
          <
h1 class="title">Customer Listing - Display</h1>
        </div>
        <div id=
"contents">
          <div id="display-fields" class="fields">
            <div
class="field-group">
              <span class="label">Customer Number:</span>

             <span class="value"></span>
            </div>
            <div cla
ss="field-group">
              <span class="label">Customer Name:</span>

        <span class="value"></span>
            </div>
            <div class="f
ield-group">
              <span class="label">Address 1:</span>
              <
span class="value"></span>
            </div>
            <div class="field-grou
p">
              <span class="label">City:</span>
              <span class="va
lue"></span>
            </div>
            <div class="field-group">

    <span class="label">State/Prov:</span>
              <span class="value"></s
pan>
            </div>
            <div class="field-group">
              <spa
n class="label">Country:</span>
              <span class="value"></span>

      </div>
            <div class="field-group">
              <span class="la
bel">Contact Name:</span>
              <span class="value"></span>

</div>
            <div class="field-group">
              <span class="label">C
ustomer Since:</span>
              <span class="value"></span>
            </di
v>
            <div class="field-group">
              <span class="label">Addre
ss 2:</span>
              <span class="value"></span>
            </div>

      <div class="field-group">
              <span class="label">Postal/Zip Cod
e:</span>
              <span class="value"></span>
            </div>

   <div class="field-group">
              <span class="label">Area Code:</span>

              <span class="value"></span>
            </div>
            <div c
lass="field-group">
              <span class="label">Phone Number:</span>

         <span class="value"></span>
            </div>
            <div class="
field-group">
              <span class="label">Email Address:</span>

    <span class="value"></span>
            </div>
            <div class="field
-group">
              <span class="label">Terms:</span>
              <span cla
ss="value"></span>
            </div>
            <div class="field-group">

          <span class="label">Discount Code:</span>
              <span class="v
alue"></span>
            </div>
          </div>
          
          <div id="
nav">
            
            
          </div>
        </div>
      </div>	

  </div>
  </body>
</html>

**CTDATA H__5        DelChoice                        238
<p>Are you SURE you want to delete this record?</p>
<input type="button" class="
accept" onClick="javascript:location='?task=del&CMCUST=';" value="Yes">
<input t
ype="button" class="cancel" onClick="javascript:location='?page='" value="No">
**CTDATA H__6        RtnToList                        52
<button id="backbutton" class="cancel">Back</button>
**CTDATA H__7        RcdChange                        5783
<!DOCTYPE html>
<html>
  <head>
    <meta name="generator" content="WebSmart" />

    <meta http-equiv="Pragma" content="no-cache" />
    <title>Customer Listing
 - Change</title>
    
    <link rel="stylesheet" type="text/css" href="/websmar
t/v10.8/Sonora/css/jquery-ui.css"/>	
    <link rel="stylesheet" type="text/css"
href="/websmart/v10.8/Sonora/css/screen.css" media="all" />
    <link rel="style
sheet" type="text/css" href="/websmart/v10.8/Sonora/css/print.css" media="print"
 />
    
    <script type="text/javascript" src="/websmart/v10.8/js/jquery.min.j
s"></script>
    <script type="text/javascript" src="/websmart/v10.8/js/jquery-u
i.min.js"></script>
    <script type="text/javascript">
		jQuery(function() {

	
		jQuery("input:submit, input:button, button").button();
			
			jQuery("input[na
me='CMCUST']").attr("disabled",true);
			
			//focus the first input on page loa
d
			jQuery('input:enabled:first').focus();
			
			// Bind event to the Back but
ton
			jQuery('#backbutton').click(goback);
			function goback()
			{
				window
.location.replace("?page=");
				return false;
			}
		});
	</script>
  </head>

 <body class="single-record manage-record">
    <div id="outer-content">
      <
div id="page-title-block" class="page-title-block">
        <img class="page-tit
le-image" src="/websmart/v10.8/Sonora/images/company-logo.png" alt="logo" />

     <div id="page-divider-top" class="page-divider"></div>
      </div>
      <
div id="page-content">
        <div id="content-header">
          <h1 class="ti
tle">Customer Listing - Change</h1>
        </div>
        <div id="contents"> 

          
          <form id="change-form" action="" method="post">

 <input id="task" type="hidden" name="task" value="endchange" />
            <in
put id="CMCUST_" type="hidden" name="CMCUST_" value="" />
            

   <div id="changefields" class="manage-fields fields">
              <div class
="field-group">
                <span class="label">Customer Number:</span>

            <span class="value"><input type="text" id="CMCUST" name="CMCUST" siz
e="7" maxlength="7" value=""></span>
              </div>
              <div cla
ss="field-group">
                <span class="label">Customer Name:</span>

            <span class="value"><input type="text" id="CMNAME" name="CMNAME" siz
e="50" maxlength="50" value=""></span>
              </div>
              <div c
lass="field-group">
                <span class="label">Address 1:</span>

          <span class="value"><input type="text" id="CMADR1" name="CMADR1" size=
"50" maxlength="50" value=""></span>
              </div>
              <div cla
ss="field-group">
                <span class="label">City:</span>

   <span class="value"><input type="text" id="CMCITY" name="CMCITY" size="20" ma
xlength="20" value=""></span>
              </div>
              <div class="fie
ld-group">
                <span class="label">State/Prov:</span>

  <span class="value"><input type="text" id="CMSTATE" name="CMSTATE" size="2" ma
xlength="2" value=""></span>
              </div>
              <div class="fiel
d-group">
                <span class="label">Country:</span>
                <s
pan class="value"><input type="text" id="CMCOUNT" name="CMCOUNT" size="2" maxlen
gth="2" value=""></span>
              </div>
              <div class="field-gr
oup">
                <span class="label">Contact Name:</span>
                <
span class="value"><input type="text" id="CMCONT" name="CMCONT" size="50" maxlen
gth="50" value=""></span>
              </div>
              <div class="field-g
roup">
                <span class="label">Customer Since:</span>

  <span class="value"><input type="text" id="CMDACR" name="CMDACR" size="10" max
length="10" value=""></span>
              </div>
              <div class="fiel
d-group">
                <span class="label">Address 2:</span>

<span class="value"><input type="text" id="CMADR2" name="CMADR2" size="50" maxle
ngth="50" value=""></span>
              </div>
              <div class="field-
group">
                <span class="label">Postal/Zip Code:</span>

    <span class="value"><input type="text" id="CMPOST" name="CMPOST" size="7" ma
xlength="7" value=""></span>
              </div>
              <div class="fiel
d-group">
                <span class="label">Area Code:</span>

<span class="value"><input type="text" id="CMAREA" name="CMAREA" size="3" maxlen
gth="3" value=""></span>
              </div>
              <div class="field-gr
oup">
                <span class="label">Phone Number:</span>
                <
span class="value"><input type="text" id="CMPHON" name="CMPHON" size="7" maxleng
th="7" value=""></span>
              </div>
              <div class="field-gro
up">
                <span class="label">Email Address:</span>
                <
span class="value"><textarea id="CMEMAIL" name="CMEMAIL" maxlength="256"></texta
rea></span>
              </div>
              <div class="field-group">

         <span class="label">Terms:</span>
                <span class="value"><
input type="text" id="CMTERM" name="CMTERM" size="2" maxlength="2" value=""></sp
an>
              </div>
              <div class="field-group">

 <span class="label">Discount Code:</span>
                <span class="value"><
input type="text" id="CMDSCNT" name="CMDSCNT" size="2" maxlength="2" value=""></
span>
              </div>	
            </div>
            <div id="navbottom">

              <input id="submitbutton" type="submit" class="accept" name="mode"
value="Change" />
              <button id="backbutton" class="cancel">Cancel</b
utton>
            </div>		
          </form>
        </div>
      </div>
    </
div>
  </body>
</html>

**CTDATA H__8        RcdAdd                           5618
<!DOCTYPE html>
<html>
  <head>
    <meta name="generator" content="WebSmart" />

    <meta http-equiv="Pragma" content="no-cache" />
    <title>Customer Listing
 - Add</title>
    
    <link rel="stylesheet" type="text/css" href="/websmart/v
10.8/Sonora/css/jquery-ui.css"/>	
    <link rel="stylesheet" type="text/css" hre
f="/websmart/v10.8/Sonora/css/screen.css" media="all" />
    <link rel="styleshe
et" type="text/css" href="/websmart/v10.8/Sonora/css/print.css" media="print" />

    
    <script type="text/javascript" src="/websmart/v10.8/js/jquery.min.js">
</script>
    <script type="text/javascript" src="/websmart/v10.8/js/jquery-ui.m
in.js"></script>
    <script type="text/javascript">
		jQuery(function() {

			j
Query("input:submit, input:button, button").button();
			
			//focus the first i
nput on page load
			jQuery('input:enabled:first').focus();
			
			// Bind event
 to the Back button
			jQuery('#backbutton').click(goback);
			function goback()

			{
				window.location.replace("?page=");
				return false;
			}
		});
	</scr
ipt>
  </head>
  <body class="single-record manage-record">
    <div id="outer-c
ontent">
      <div id="page-title-block" class="page-title-block">
        <img
 class="page-title-image" src="/websmart/v10.8/Sonora/images/company-logo.png" a
lt="logo" />
        <div id="page-divider-top" class="page-divider"></div>

  </div>
      <div id="page-content">
        <div id="content-header">

   <h1 class="title">Customer Listing - Add</h1>
        </div>
        <div id=
"contents"> 
          
          <form id="add-form" action="" method="post">

           <input id="task" type="hidden" name="task" value="endadd" />

    <div id="addfields" class="manage-fields fields">
              <div class="
field-group">
                <span class="label">Customer Number:</span>

          <span class="value"><input type="text" id="CMCUST" name="CMCUST" size=
"7" maxlength="7" value=""></span>
              </div>
              <div class
="field-group">
                <span class="label">Customer Name:</span>

          <span class="value"><input type="text" id="CMNAME" name="CMNAME" size=
"50" maxlength="50" value=""></span>
              </div>
              <div cla
ss="field-group">
                <span class="label">Address 1:</span>

        <span class="value"><input type="text" id="CMADR1" name="CMADR1" size="5
0" maxlength="50" value=""></span>
              </div>
              <div class
="field-group">
                <span class="label">City:</span>

 <span class="value"><input type="text" id="CMCITY" name="CMCITY" size="20" maxl
ength="20" value=""></span>
              </div>
              <div class="field
-group">
                <span class="label">State/Prov:</span>

<span class="value"><input type="text" id="CMSTATE" name="CMSTATE" size="2" maxl
ength="2" value=""></span>
              </div>
              <div class="field-
group">
                <span class="label">Country:</span>
                <spa
n class="value"><input type="text" id="CMCOUNT" name="CMCOUNT" size="2" maxlengt
h="2" value=""></span>
              </div>
              <div class="field-grou
p">
                <span class="label">Contact Name:</span>
                <sp
an class="value"><input type="text" id="CMCONT" name="CMCONT" size="50" maxlengt
h="50" value=""></span>
              </div>
              <div class="field-gro
up">
                <span class="label">Customer Since:</span>

<span class="value"><input type="text" id="CMDACR" name="CMDACR" size="10" maxle
ngth="10" value=""></span>
              </div>
              <div class="field-
group">
                <span class="label">Address 2:</span>
                <s
pan class="value"><input type="text" id="CMADR2" name="CMADR2" size="50" maxleng
th="50" value=""></span>
              </div>
              <div class="field-gr
oup">
                <span class="label">Postal/Zip Code:</span>

  <span class="value"><input type="text" id="CMPOST" name="CMPOST" size="7" maxl
ength="7" value=""></span>
              </div>
              <div class="field-
group">
                <span class="label">Area Code:</span>
                <s
pan class="value"><input type="text" id="CMAREA" name="CMAREA" size="3" maxlengt
h="3" value=""></span>
              </div>
              <div class="field-grou
p">
                <span class="label">Phone Number:</span>
                <sp
an class="value"><input type="text" id="CMPHON" name="CMPHON" size="7" maxlength
="7" value=""></span>
              </div>
              <div class="field-group
">
                <span class="label">Email Address:</span>
                <sp
an class="value"><textarea id="CMEMAIL" name="CMEMAIL" maxlength="256"></textare
a></span>
              </div>
              <div class="field-group">

       <span class="label">Terms:</span>
                <span class="value"><in
put type="text" id="CMTERM" name="CMTERM" size="2" maxlength="2" value=""></span
>
              </div>
              <div class="field-group">
                <
span class="label">Discount Code:</span>
                <span class="value"><in
put type="text" id="CMDSCNT" name="CMDSCNT" size="2" maxlength="2" value=""></sp
an>
              </div>	
            </div>
            <div id="navbottom">

            <input id="submitbutton" type="submit" class="accept" name="mode" va
lue="Add" />
              <button id="backbutton" class="cancel">Cancel</button
>
            </div>		
          </form>
        </div>
      </div>
    </div>

  </body>
</html>

