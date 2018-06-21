     FOMAPPL1   IF   E           K DISK
     FOMCNVL1   IF   E           K DISK
     FOMDMPL1   IF   E           K DISK
     FOMEODL1   IF   E           K DISK
     FOMERDL1   IF   E           K DISK
     FOMEROL1   IF   E           K DISK
     FOMERRL1   IF   E           K DISK
      /FREE
       READ OMAPPL1;
        *IN99 = %EOF;
       READ OMCNVL1;
        *IN99 = %EOF;
       READ OMDMPL1;
        *IN99 = %EOF;
       READ OMEODL1;
        *IN98 = %EOF;
       READ OMERDL1;
        *IN99 = %EOF;
       READ OMEROL1;
        *IN99 = %EOF;
       READ OMERRL1;
        *IN98 = %EOF;
      /END-FREE
     C                   CALL      'PGM01'
     C                   CALL      'PGM02'
     C                   CALL      'PGM03'
     C                   CALL      'PGM04'
      /FREE
        *INLR = *ON;
      /END-FREE
