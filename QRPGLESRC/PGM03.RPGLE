     FOMDMPL3   IF   E           K DISK
     FOMEROL3   IF   E           K DISK
     FOMERRL3   IF   E           K DISK
     FOMERSL2   IF   E           K DISK
     FOMLBDL2   IF   E           K DISK
     FOMLBLL1   IF   E           K DISK
     FOMLOAL1   IF   E           K DISK
     FDSP03     CF   E             WORKSTN
      /FREE
       READ OMDMPL3;
        *IN99 = %EOF;
       READ OMEROL3;
        *IN99 = %EOF;
       READ OMERRL3;
        *IN94 = %EOF;
       READ OMERSL2;
        *IN98 = %EOF;
       READ OMLBDL2;
        *IN97 = %EOF;
       READ OMLBLL1;
        *IN96 = %EOF;
       //
       // Call to DEM3P object
       //
      /END-FREE
     C                   CALL      'PGM013P'
      *
      /FREE
       READ OMLOAL1;
        *IN99 = %EOF;
       EXFMT DSP;
        *INLR = *ON;
      /END-FREE
