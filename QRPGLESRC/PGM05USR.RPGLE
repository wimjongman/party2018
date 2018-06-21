     FOMLOGL2   IF   E           K DISK
     FOMMBRL2   IF   E           K DISK
     FOMMRRL1   IF   E           K DISK
     FOMOBJL1   IF   E           K DISK
     FOMPDLL1   IF   E           K DISK
     FOMRSRJ6   IF   E           K DISK
      /FREE
       READ OMLOGL2;
        *IN99 = %EOF;
       READ OMMBRL2;
        *IN99 = %EOF;
       READ OMMRRL1;
        *IN99 = %EOF;
       READ OMOBJL1;
        *IN99 = %EOF;
       READ OMPDLL1;
        *IN99 = %EOF;
       READ OMRSRJ6;
        *IN99 = %EOF;
        *INLR = *ON;
      /END-FREE
