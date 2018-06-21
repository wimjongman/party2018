     FOMLOGL2   IF   E           K DISK
     FOMMBRL2   IF   E           K DISK
     FOMMRRL1   IF   E           K DISK
     FOMOBJL1   IF   E           K DISK
     FOMO001L3  IF   E           K DISK
     FOMPDLL1   IF   E           K DISK
     FOMRSRJ6   IF   E           K DISK
     FDSP05     CF   E             WORKSTN
      *
     DSourceRel        PR              O   CLASS(*JAVA:'nl.remain.td.Testjava')
     D                                     Extproc(*JAVA:'nl.remain.td.Testjava'
     D                                     :*CONSTRUCTOR)
      *
     C                   READ      OMLOGL2                                99
     C                   READ      OMMBRL2                                98
     C                   READ      OMMRRL1                                99
     C                   READ      OMOBJL1                                99
     C                   READ      OMO001L3                               99
     C                   READ      OMPDLL1                                99
     C                   READ      OMRSRJ6                                99
     C*
     C                   EXFMT     DSP
     C*
     C                   SETON                                        LR
