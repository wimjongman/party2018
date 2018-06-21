     FOMAPPL1   IF   E           K DISK
     FOMCNVL1   IF   E           K DISK
     FOMDMPL1   IF   E           K DISK
     FOMEODL1   IF   E           K DISK
     FOMERDL1   IF   E           K DISK
     FOMEROL1   IF   E           K DISK
     FOMERRL1   IF   E           K DISK
     FOMO001W1  IF   E           K DISK
      /FREE
       READ OMAPPL1;
        *IN99 = %EOF;
       READ OMCNVL1;
        *IN99 = %EOF;
       READ OMDMPL1;
        *IN99 = %EOF;
       READ OMEODL1;
        *IN99 = %EOF;
       READ OMERDL1;
        *IN99 = %EOF;
       READ OMEROL1;
        *IN99 = %EOF;
      /END-FREE
     C                   GOTO      NEXT
      /FREE
       READ OMERRL1;
        *IN99 = %EOF;
       READ OMO001W1;
        *IN99 = %EOF;
      /END-FREE
     C                   CALL      'PGM10'
     C     NEXT          TAG
     C                   CALL      'PGM11'
     C                   CALL      'PGM13'
      /FREE
        *INLR = *ON;
      /END-FREE
