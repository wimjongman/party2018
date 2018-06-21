     h copyright('Remain B.V. 1999')
     h nomain
      /COPY QCPYSRC,PRSNDMSG

     pOMS_sndmsg       B                   export
     d                 PI
     d msgf                          10    value
     d msgid                          7    value
     d msgtype                       10    value
     d msgdta                       512    value

     d qualmsgf        S             20
     d msgdtalen       S              8B 0
     d callstkentry    S             10
     d callstkcntr     S              8B 0
     d msgkey          S              4
     d errorcode       S              4

     dCurrentEntry     C                   const('*PGMBDY')
     dPreviousPgm      C                   const(1)

     c                   eval      qualmsgf = msgf + '*LIBL'
     c                   eval      msgdtalen=%len(msgdta)
     c                   call      'QMHSNDPM'
     c                   parm                    msgid
     c                   parm                    qualmsgf
     c                   parm                    msgdta
     c                   parm                    msgdtalen
     c                   parm                    msgtype
     c                   parm      CurrentEntry  callstkentry
     c                   parm      PreviousPgm   callstkcntr
     c                   parm                    msgkey
     c                   parm      *LOVAL        errorcode
     c                   RETURN
     c
     pOMS_sndmsg       E
