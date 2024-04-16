
function[dS]= Func_Find_interp(vXTemp,vYTemp,vXTemp1,vYTemp1,j,dSlice,step1)
Flag=1;
FontSize = 22;
FontWeight = 'bold';
mLine=[];
mLine1=[];
dS=0;
dS1=0;
Max_X=max(vXTemp);
Max_Y=max(vYTemp);
Max_X1=max(vXTemp1);
Max_Y1=max(vYTemp1);
Min_X=min(vXTemp);
Min_Y=min(vYTemp);
Min_X1=min(vXTemp1);
Min_Y1=min(vYTemp1);
w=Max_X-Min_X;
h=Max_Y-Min_Y;
w1=Max_X1-Min_X1;
h1=Max_Y1-Min_Y1;

if(((Min_X>Max_X1)||(Min_Y>Max_Y1))||((Max_X<Min_X1)||(Max_Y<Min_Y1))
    Flag=0;
    return
end

if(Flag==1)  
   [mLine,iCountContour,vContourPoint,LineFlag] = Func_Unicursal_4(vXTemp, vYTemp, dSlice,[0.8235,0.1255,0.1529]); 
   [mLine1,iCountContour1,vContourPoint1,LineFlag1] = Func_Unicursal_4(vXTemp1, vYTemp1, step1(1),[0.2196,0.3490,0.5373]);  
    if iCountContour>1&&iCountContour1==1  
       [mLineSub,vRectangle]=Func_GetSubline(mLine,iCountContour,vContourPoint,vXTemp, vYTemp);
        for num_c=1:iCountContour
                if((vRectangle(num_c,1)>Max_X1)||(vRectangle(num_c,3)>Max_Y1)||(vRectangle(num_c,2)<Min_X1)||(vRectangle(num_c,4)<Min_Y1))
                        continue;
                else
%                  
                   mLine1(vContourPoint1,2)=mLine1(1,1);
%                   
                   [point,num_con]=Func_FindOverlap_1(mLineSub{num_c},mLine1,vXTemp,vYTemp,vXTemp1,vYTemp1,num_c);
                   if ~isempty(point)
%                         
                        dS1=Func_ComputeArea(point,num_con,LineFlag(num_c),LineFlag1);
                   else
                       dS1=0;
                   end
                end
                dS=dS+dS1;
        end

    elseif iCountContour1>1&&iCountContour==1 
       [mLineSub,vRectangle]=Func_GetSubline(mLine1,iCountContour1,vContourPoint1,vXTemp1, vYTemp1);
       for num_c=1:iCountContour1
               if((vRectangle(num_c,1)>Max_X)||(vRectangle(num_c,3)>Max_Y)||(vRectangle(num_c,2)<Min_X)||(vRectangle(num_c,4)<Min_Y))
                        continue;
               else
%                  
                   mLine(vContourPoint,2)=mLine(1,1);
                   [point,num_con]=Func_FindOverlap_1(mLine,mLineSub{num_c},vXTemp,vYTemp,vXTemp1,vYTemp1);
%                   
                   if ~isempty(point)
                        dS1=Func_ComputeArea(point,num_con,LineFlag,LineFlag1(num_c));
                   else
                       dS1=0;
                   end
               end
               dS=dS+dS1;
        end
   elseif iCountContour1>1&&iCountContour>1 
       [mLineSub,vRectangle]=Func_GetSubline(mLine,iCountContour,vContourPoint,vXTemp, vYTemp);
       [mLineSub1,vRectangle1]=Func_GetSubline(mLine1,iCountContour1,vContourPoint1,vXTemp1, vYTemp1);
       for num_c=1:iCountContour
           for num_c1=1:iCountContour1
               if((vRectangle(num_c,1)>vRectangle1(num_c1,2))||(vRectangle(num_c,3)>vRectangle1(num_c1,4))||(vRectangle(num_c,2)<vRectangle1(num_c1,1))||(vRectangle(num_c,4)<vRectangle1(num_c1,3)))
                        continue;
               else
%                    figure;
                   [point,num_con]=Func_FindOverlap_1(mLineSub{num_c},mLineSub1{num_c1},vXTemp,vYTemp,vXTemp1,vYTemp1);
                    
                   if ~isempty(point)
                        dS1=Func_ComputeArea(point,num_con,LineFlag(num_c),LineFlag1(num_c1));
                   else
                       dS1=0;
                   end
                   
               end
               dS=dS+dS1;
           end
       end  
   else
       mLine(vContourPoint,2)=mLine(1,1);
       mLine1(vContourPoint1,2)=mLine1(1,1);
       [point,num_con]=Func_FindOverlap_1(mLine,mLine1,vXTemp,vYTemp,vXTemp1,vYTemp1);
       if ~isempty(point)
            dS=Func_ComputeArea(point,num_con,LineFlag,LineFlag1);
            scatter(point(:,1),point(:,2),30,[0.8235,0.1255,0.1529],'filled');
       end
    end
end
