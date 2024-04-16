function [non_con,non_con1]=Func_GetCon(segments,temp,temp1)
     non_con=0;
     if(segments(temp).inOut==segments(temp1).inOut)
         non_con1=1;
     else
         non_con1=0;
     end
end
