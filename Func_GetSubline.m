function [mLineSub_all,vRectangle]=Func_GetSubline(mLine,iCountContour,vContourPoint,vXTemp,vYTemp)

vFrom2To = zeros(iCountContour, 2);    
vRectangle = zeros(iCountContour, 4);%包围盒
mLineSub_all=cell(iCountContour,1);
for i =1:iCountContour
        mLineSub = zeros(vContourPoint(i), 2);%每个轮廓
        if(i == 1)
            iFrom = 1;
            iTo = vContourPoint(1);
%             vTest(i) = 1;
            vFrom2To(i, 1) = 1;
            vFrom2To(i, 2) = iTo;
            dMinX = vXTemp(mLine(1, 1));
            dMaxX = vXTemp(mLine(1, 1));
            dMinY = vYTemp(mLine(1, 1));
            dMaxY = vYTemp(mLine(1, 1));
        else
            iFrom = 1 + sum(vContourPoint(1 : i - 1));%找该轮廓的起点
            iTo = sum(vContourPoint(1 : i));
%             vTest(i) = iFrom;
            vFrom2To(i, 1) = iFrom;
            vFrom2To(i, 2) = iTo;
            dMinX = vXTemp(mLine(iFrom, 1));
            dMaxX = vXTemp(mLine(iFrom, 1));
            dMinY = vYTemp(mLine(iFrom, 1));
            dMaxY = vYTemp(mLine(iFrom, 1));
        end
        mLineSub = mLine(iFrom : iTo, :);
        mLineSub(vContourPoint(i), 2) = mLineSub(1, 1);
        mLineSub_all{i}=mLineSub;
        for j = 1 : vContourPoint(i)
            if(vXTemp(mLineSub(j + 1)) < dMinX)
                dMinX = vXTemp(mLineSub(j + 1));
            end
            if(vXTemp(mLineSub(j + 1)) > dMaxX)
                dMaxX = vXTemp(mLineSub(j + 1));
            end
            if(vYTemp(mLineSub(j + 1)) < dMinY)
                dMinY = vYTemp(mLineSub(j + 1));
            end
            if(vYTemp(mLineSub(j + 1)) > dMaxY)
                dMaxY = vYTemp(mLineSub(j + 1));
            end
            vRectangle(i, :) = [dMinX, dMaxX, dMinY, dMaxY];%相当于包围盒检测是否相交
        end
end
