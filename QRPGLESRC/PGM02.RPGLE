     FOMDMPL2   IF   E           K DISK
     FOMEODL2   IF   E           K DISK
     FOMEROL2   IF   E           K DISK
     FOMERRL2   IF   E           K DISK
     FOMERSL1   IF   E           K DISK
     FOMESDL1   IF   E           K DISK
     FOMLBDL1   IF   E           K DISK
     FDSP02     CF   E             WORKSTN
      /FREE
       READ OMDMPL2;
        *IN99 = %EOF;
       READ OMEODL2;
        *IN99 = %EOF;
       READ OMEODL2;
        *IN99 = %EOF;
       READ OMEROL2;
        *IN99 = %EOF;
       READ OMERRL2;
        *IN98 = %EOF;
       READ OMERSL1;
        *IN98 = %EOF;
       READ OMESDL1;
        *IN98 = %EOF;
       READ OMLBDL1;
        *IN89 = %EOF;
      /END-FREE
     C                   CALL      'QCMDEXC'                              97
      /FREE
       EXFMT DSP;
        *INLR = *ON;
      /END-FREE
