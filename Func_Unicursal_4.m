function [mLine,iCountContour,vContourPoint,LineFlag] = Func_Unicursal_4(vXTemp, vYTemp, dSlice,col)

    iLen = length(vXTemp);
    vUsed = zeros(iLen, 1);%���ʹ�����
    mLine = zeros(iLen, 2);%������
    iCount = 0;
    iCountContour = 0;
    iCountUnUsed = 0;
    iCountSub = 0;
    vColor = ['b', 'g', 'r', 'c', 'm', 'y', 'k', 'w'];
    dR = 5 * dSlice;
    while(iCount < iLen)
        iCountContour = iCountContour + 1;
        iStart = 1;
        %% �ҵ���������Ϊ���
        for i = 1 : iLen
            if(vUsed(iStart) == 1)%�����ʼ���Ѿ��ù�
                iStart = iStart + 1;
                continue;
            end
            if(1 == vUsed(i))
                continue;
            end
            if(vXTemp(iStart) > vXTemp(i))
                iStart = i;
            end
            if vXTemp(iStart)==vXTemp(i) && vYTemp(iStart)>vYTemp(i)
                iStart = i;
            end
        end
        iLeft = iStart;
        iCount = iCount + 1;%�����ߵ�����
        mLine(iCount, 1) = iStart;
        vUsed(iStart) = 1;
        vDisUU = zeros(iLen, 1);
        vIdxUU = zeros(iLen, 1);
        vDis = zeros(iLen, 1);
        vIdx = zeros(iLen, 1);
        iTemp = 1;
        iTempUU=1;
        for i = 1 : iLen
            if (iStart == i) || 1==vUsed(i)
                continue;
            end
            vDis(iTemp)=(vXTemp(i) - vXTemp(iStart))^2 + (vYTemp(i) - vYTemp(iStart))^2;
            vIdx(iTemp) = i;   
            if vDis(iTemp)<=dR^2 
                vDisUU(iTempUU) = vDis(iTemp);
                vIdxUU(iTempUU) = vIdx(iTemp);
                iTempUU = iTempUU + 1;
                iCountUnUsed = iCountUnUsed + 1;
            end
            iTemp = iTemp + 1;
        end
 %% һ����������       
        while(iCountUnUsed > 0)
%             iMin = [];
              iMin = 1;
            for i = 1 : iCountUnUsed
                if(vDisUU(iMin) > vDisUU(i))
                iMin = i;
                end
            end
          
            iNext = vIdxUU(iMin);
            mLine(iCount, 2) = iNext;    
%             line([vXTemp(iLeft), vXTemp(iNext)],[vYTemp(iLeft), vYTemp(iNext)], 'Color', vColor(iCountContour), 'linewidth', 2);
line([vXTemp(iLeft), vXTemp(iNext)],[vYTemp(iLeft), vYTemp(iNext)], 'Color', col, 'LineWidth', 2);
            vUsed(iNext) = 1;
            iCount = iCount + 1;
            iLeft = iNext;
            mLine(iCount, 1) = iLeft;
            iCountUnUsed = 0;
           vDisUU = zeros(iLen, 1);
            vIdxUU = zeros(iLen, 1);
            vDis = zeros(iLen, 1);
            vIdx = zeros(iLen, 1);
            iTemp = 1;
            iTempUU=1;
            for i = 1 : iLen
                if (iLeft == i) || 1==vUsed(i)
                    continue;
                end
                vDis(iTemp)=(vXTemp(i) - vXTemp(iLeft))^2 + (vYTemp(i) - vYTemp(iLeft))^2;
                vIdx(iTemp) = i;   
               
                if vDis(iTemp)<=dR^2
                    vDisUU(iTempUU) = vDis(iTemp);
                    vIdxUU(iTempUU) = vIdx(iTemp);
                    iTempUU = iTempUU + 1;
                    iCountUnUsed = iCountUnUsed + 1;
                end
                 iTemp = iTemp + 1;
            end        
            
        end
%         line([vXTemp(iLeft), vXTemp(iStart)],[vYTemp(iLeft), vYTemp(iStart)], 'Color', vColor(iCountContour),'linewidth', 2);
line([vXTemp(iLeft), vXTemp(iStart)],[vYTemp(iLeft), vYTemp(iStart)], 'Color', col,'LineWidth', 2);
    end
     %�����������ϵ����һ����־λ���ж��Ƿ�Ϊ��
   %%  ����������
    vS = zeros(iCountContour, 1);
    vContourPoint = zeros(iCountContour, 1);
    iCount = 0;
    vRectangle = zeros(iCountContour, 4);%��Χ��
    vTest = zeros(iCountContour, 1);%���λ�ã����ڲ��Ƿ�����ĵ�
    vFrom2To = zeros(iCountContour, 2);%�洢�����������յ���mline�е�����
    iCountContour = 0;%��������
    for i = 1 : iLen
        %�߶ξ�������ڶ���Ϊ0�����Ϊ���������һ����
        if(mLine(i, 2) ~= 0 )
            iCount = iCount + 1;
        else
            iCount = iCount + 1;
            iCountContour = iCountContour + 1;
            vContourPoint(iCountContour, 1) = iCount;%ÿ�������ж��ٵ�
            iCount = 0;
        end
    end
        %% ����������������
    for i = 1 : iCountContour
%         dS = 0;
        mLineSub = zeros(vContourPoint(i), 2);%ÿ������
        if(i == 1)
            iFrom = 1;
            iTo = vContourPoint(1);
            vTest(i) = 1;
            vFrom2To(i, 1) = 1;
            vFrom2To(i, 2) = iTo;
            dMinX = vXTemp(mLine(1, 1));
            dMaxX = vXTemp(mLine(1, 1));
            dMinY = vYTemp(mLine(1, 1));
            dMaxY = vYTemp(mLine(1, 1));
        else
            iFrom = 1 + sum(vContourPoint(1 : i - 1));%�Ҹ����������
            iTo = sum(vContourPoint(1 : i));
            vTest(i) = iFrom;
            vFrom2To(i, 1) = iFrom;
            vFrom2To(i, 2) = iTo;
            dMinX = vXTemp(mLine(iFrom, 1));
            dMaxX = vXTemp(mLine(iFrom, 1));
            dMinY = vYTemp(mLine(iFrom, 1));
            dMaxY = vYTemp(mLine(iFrom, 1));
        end
        mLineSub = mLine(iFrom : iTo, :);
        mLineSub(vContourPoint(i), 2) = mLineSub(1, 1);%������㣬��ȫ
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
            vRectangle(i, :) = [dMinX, dMaxX, dMinY, dMaxY];%�൱�ڰ�Χ�м���Ƿ��ཻ
%             dS = dS + 0.5 * (vXTemp(mLineSub(j)) * vYTemp(mLineSub(j, 2)) - vXTemp(mLineSub(j, 2)) * vYTemp(mLineSub(j)));
        end
%         vS(i) = abs(dS);
    end
    %%
    LineFlag=false(iCountContour,1);
    if(1 == iCountContour)
       % dS = sum(vS);
    else
        for i = 1 : iCountContour
            mLineSub = mLine(vFrom2To(i, 1) : vFrom2To(i, 2), :);
            mLineSub(vContourPoint(i), 2) = mLine(vFrom2To(i, 1), 1);
            for j = 1 : iCountContour%�����������İ�����
                if(j == i)
                    continue;
                end
                iTemp = mLine(vTest(j), 1);
                iFlag = 0;
                dTestX = vXTemp(iTemp);
                dTestY = vYTemp(iTemp);
                %%%����
                if(dTestX < vRectangle(i, 1) | dTestX > vRectangle(i, 2) | dTestY < vRectangle(i, 3) | dTestY > vRectangle(i, 4))
                        continue;
                else
                    for k = 1 : vContourPoint(i)
                        %�߶η���yֵ��С����
                        dTempMinY = min(vYTemp(mLineSub(k, 1)), vYTemp(mLineSub(k, 2)));
                        dTempMaxY = max(vYTemp(mLineSub(k, 1)), vYTemp(mLineSub(k, 2)));
                        mCors = zeros(2, 2);
                        mCors(1, :) = [vXTemp(mLineSub(k, 1)), vYTemp(mLineSub(k, 1))];
                        mCors(2, :) = [vXTemp(mLineSub(k, 2)), vYTemp(mLineSub(k, 2))];
                        %if������֤�ཻ
                        if(dTempMinY < dTestY && dTempMaxY >= dTestY)
                            
                            if(vYTemp(mLineSub(k, 1)) > vYTemp(mLineSub(k, 2)))
                                vTemp = zeros(1, 2);
                                vTemp(1, :) = mCors(1, :);
                                mCors(1, :) = mCors(2, :);
                                mCors(2, :) = vTemp(1, :);
                            end
                            dTemp1 = (mCors(2, 1) - mCors(1, 1)) * (dTestY - mCors(1, 2));
                            dTemp2 = (dTestX - mCors(1, 1)) * (mCors(2, 2) - mCors(1, 2));
                            if(dTemp1 < dTemp2)
                                iFlag = ~iFlag;
                                LineFlag(j,1)=~LineFlag(j,1);
                            end
                        else
                            continue;
                        end
                    end
%                     vS(j) = (-1)^iFlag * vS(j); 
                end
            end
        end
    end
end