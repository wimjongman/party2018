     FOMAPPL1   IF   E           K DISK
     FOMCNVL1   IF   E           K DISK
     FOMDMPL1   IF   E           K DISK
     FOMEODL1   IF   E           K DISK
     FOMERDL1   IF   E           K DISK
     FOMEROL1   IF   E           K DISK
     FOMERRL1   IF   E           K DISK
     FDSP01     CF   E             WORKSTN
      /FREE
       READ OMAPPL1;
        *IN96 = %EOF;
       READ OMCNVL1;
        *IN01 = %EOF;
       //read file again
       READ OMCNVL1;
        *IN95 = %EOF;
       READ OMCNVL1;
        *IN99 = %EOF;
       READ OMDMPL1;
        *IN98 = %EOF;
       READ OMEODL1;
        *IN99 = %EOF;
       READ OMERDL1;
        *IN98 = %EOF;
       READ OMAPPL1;
        *IN98 = %EOF;
       READ OMCNVL1;
        *IN99 = %EOF;
       READ OMDMPL1;
        *IN99 = %EOF;
       READ OMEODL1;
        *IN99 = %EOF;
       READ OMEODL1;
        *IN99 = %EOF;
       READ OMERDL1;
        *IN99 = %EOF;
       READ OMEROL1;
        *IN98 = %EOF;
       READ OMERRL1;
        *IN99 = %EOF;
      /END-FREE
     C                   CALL      'QCMDEXC'
     C                   CALL      'HAMWAY'
     C                   CALL      'QUSRTVUS'
     C                   CALL      'QCMD'
      /FREE
       EXFMT DSP;
        *INLR = *ON;
      /END-FREE
