function [inOut,otherInOut]=Func_GetFlag(segments,temp,temp1)
%return true 就调换状态队列位置
       if(segments(temp1).poly==segments(temp).poly)
            inOut=~(segments(temp1).inOut);
            otherInOut=segments(temp1).otherInOut;
       else
            inOut=~(segments(temp1).otherInOut);
            if segments(temp1).start_x==segments(temp1).end_x             
                otherInOut=~(segments(temp1).inOut);
            else
                otherInOut=segments(temp1).inOut;
            end
        end
end
    
