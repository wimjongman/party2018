     h option(*nodebugio) bnddir('MATHBNDD')
     h dftactgrp(*NO)  actgrp('as400code')

      /copy *libl/qrpglesrc,mathprt

     d $num1           s             15s 2 inz(20)
     d $num2           s             15s 2 inz(2)
     d result          s             15s 2

      /FREE
       result = Add($num1:$num2);
       dsply result;

       result = Substract($num1:$num2);
       dsply result;

       result = Multiply($num1:$num2);
       dsply result;

       result = Divide($num1:$num2);
       dsply result;

       *inlr = *on;
      /END-FREE
