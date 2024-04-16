
function [point,num_con]=Func_FindOverlap_1(mLine,mLine1,vXtemp,vYtemp,vXtemp1,vYtemp1,aaa)
point={};
num_con=0;

len=length(mLine);
if len<3
    return;
end
len1=length(mLine1);
if len1<3
    return;
end

Len_ALL=len+len1;

segments = repmat(Segment(0, 0, 0, 0, 0,false,true,-1),Len_ALL, 1 ); % 预分配数组

count=1;
idx_other=[];
for i=1:len
     L1x(1)=vXtemp(mLine(i,1));
     L1x(2)=vXtemp(mLine(i,2));
     L1y(1)=vYtemp(mLine(i,1));
     L1y(2)=vYtemp(mLine(i,2));
     if(isequal([L1x(1),L1y(1)],[L1x(2),L1y(2)]))
         continue;
     end
     if(L1x(2)<L1x(1))
         segments(count)=Segment(L1x(2),L1y(2),L1x(1),L1y(1),1,false,true,-1);
         count=count+1;
     elseif((L1x(2)==L1x(1))&&(L1y(2)<L1y(1)))
         segments(count)=Segment(L1x(2),L1y(2),L1x(1),L1y(1),1,false,true,-1);
         count=count+1;
     else
         segments(count)=Segment(L1x(1),L1y(1),L1x(2),L1y(2),1,false,true,-1);
         count=count+1;
     end
end
for j=1:len1
     L2x(1)=vXtemp1(mLine1(j,1));
     L2x(2)=vXtemp1(mLine1(j,2));
     L2y(1)=vYtemp1(mLine1(j,1));
     L2y(2)=vYtemp1(mLine1(j,2));
     if(isequal([L2x(1),L2y(1)],[L2x(2),L2y(2)]))
         continue;
     end
     if(L2x(2)<L2x(1))
         segments(count)=Segment(L2x(2),L2y(2),L2x(1),L2y(1),2,false,true,-1);
         count=count+1;
     elseif((L2x(2)==L2x(1))&&(L2y(2)<L2y(1)))
         segments(count)=Segment(L2x(2),L2y(2),L2x(1),L2y(1),2,false,true,-1);
         count=count+1;
     else
         segments(count)=Segment(L2x(1),L2y(1),L2x(2),L2y(2),2,false,true,-1);
         count=count+1;
     end
end
segments(count:Len_ALL,:)=[];

events =zeros((count-1)*2,4);

for i = 1:count-1

    start_x = segments(i).start_x;
    start_y = segments(i).start_y;
    end_x = segments(i).end_x;
    end_y = segments(i).end_y;
    

    events(2*i-1,:) = [start_x, start_y, i, -1];

    events(2*i, :) = [end_x, end_y, i, -2];

end

events=Func_SortEvents(events,0);
%%

current_x = -inf;
status=[];

while ~isempty(events)
    event = events(1, :);
    events(1, :) = [];


    current_x = event(1);


    if(current_x>=-12.2)
        a=1;

    end
    if event(4) == -1 
        status = [status; struct('x',event(1),'y', event(2), 'segment', event(3),'inte_y',event(2) )];

        if numel(status) == 1
     
            continue;
        end

        for ss=1:numel(status)
    
            line=status(ss).segment;
            if(segments(line).end_x==segments(line).start_x)
                status(ss).inte_y=segments(line).start_y;
                continue;
            end
            slope =(segments(line).end_y-segments(line).start_y)/(segments(line).end_x-segments(line).start_x);
            status(ss).inte_y= segments(line).start_y + slope * (current_x - segments(line).start_x);
        end
        
        [~, idx] = sort([status.inte_y]);
        status = status(idx);
        idx_new=find(idx==max(idx));
            if numel(status) == 2
                temp=status(1).segment;
                temp1=status(2).segment;
                if(idx_new~=1)
                  [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp);
                  [segments,events,count,Flag]=Func_CrossingTest_S1(temp,temp1,segments,events,count);
                  if(Flag==1)
                      segments(temp).inOut=false;
                      segments(temp).otherInOut=true;
                      [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp);
                      [segments(temp).non_con,segments(temp1).non_con]=Func_GetCon(segments,temp,temp1);       
                  end
                else
                    [segments,events,count,Flag]=Func_CrossingTest_S1(temp,temp1,segments,events,count);
                   if(Flag==1)
                      [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp);
                      [segments(temp).non_con,segments(temp1).non_con]=Func_GetCon(segments,temp,temp1); 
                   end
                end   
          
            elseif numel(status) > 2    
                if(idx_new==1)
                    temp=status(1).segment;
                    temp1=status(2).segment;
                    [segments,events,count,Flag]=Func_CrossingTest_S1(temp,temp1,segments,events,count);
                    if(Flag==1)
                      [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp); 
                      [segments(temp).non_con,segments(temp1).non_con]=Func_GetCon(segments,temp,temp1);
                    end
                elseif(idx_new==numel(status))
                    temp=status(idx_new-1).segment;
                    temp1=status(idx_new).segment;   
                    [segments,events,count,Flag]=Func_CrossingTest_S1(temp,temp1,segments,events,count); 
                    [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp);    
                    if(Flag==1)
                      temp2=status(idx_new-2).segment;    
                      [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp2);    
                      [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp);
                      [segments(temp).non_con,segments(temp1).non_con]=Func_GetCon(segments,temp,temp1);
                    end
                else
                    temp=status(idx_new).segment;
                    temp1=status(idx_new-1).segment;
                    temp2=status(idx_new+1).segment;                
                   [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp1);    
                   [segments,events,count,Flag]=Func_CrossingTest_S1(temp1,temp,segments,events,count);

                   if(Flag==1)
                       if idx_new~=2
                           temp3=status(idx_new-2).segment;
                           [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp3);    
                           [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp1);  
                           [segments(temp1).non_con,segments(temp).non_con]=Func_GetCon(segments,temp1,temp); 
                        else
                           segments(temp1).inOut=false;
                           segments(temp1).otherInOut=true;
                           [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp1);
                           [segments(temp1).non_con,segments(temp).non_con]=Func_GetCon(segments,temp1,temp);
                       end
                   end

                   [segments,events,count,Flag]=Func_CrossingTest_S1(temp,temp2,segments,events,count);
                   if(Flag==1)
                       [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp1);  
                       [segments(temp2).inOut,segments(temp2).otherInOut]=Func_GetFlag(segments,temp2,temp);  
                       [segments(temp).non_con,segments(temp2).non_con]=Func_GetCon(segments,temp,temp2);
                   end
                  end

            end
    else
        if (segments(event(3)).otherInOut==0 && segments(event(3)).non_con<0) || (segments(event(3)).non_con>0)
           idx_other(end+1)=event(3); 
        end
        for i = 1:numel(status)
       
            if isequal(status(i).segment, event(3))
                
                if(i==1||i==numel(status))
                    status(i) = [];
                    break;
                else
                    temp=status(i-1).segment;
                    temp1=status(i+1).segment;
                    [segments,events,count,Flag]=Func_CrossingTest_S1(temp,temp1,segments,events,count);
                    status(i) = [];
                    break;
                end
                
            end
        end 

          
    end
end



if ~isempty(idx_other)
    point1=[];
    len=length(idx_other);
    len2=len*2;
    results =zeros(len2,7);
    for i=1:len
            x=[segments(idx_other(i)).start_x,segments(idx_other(i)).end_x];
            y=[segments(idx_other(i)).start_y,segments(idx_other(i)).end_y]; 

            start_x = segments(idx_other(i)).start_x;
            start_y = segments(idx_other(i)).start_y;
            end_x = segments(idx_other(i)).end_x;
            end_y = segments(idx_other(i)).end_y;

            results(2*i-1,1:6) = [start_x, start_y, i, -1,end_x,end_y];
            results(2*i,1:6) = [end_x, end_y, i, -2,start_x,start_y];
    end
    results=Func_SortEvents(results,0);
    for j=1:len2
        results(j,7)=j;
        if results(j,4)==-2
            idx=find(results(:,3)==results(j,3));
            idx=idx(idx~=j);
            temppos=results(idx,7);
            if temppos==0
                results(idx,4)=-2;
                results(j,4)=-1;
                continue;
            end
            results(j,7)=temppos;
            results(idx,7)=j;
        end
    end
    process = false(size(results, 1), 1); 

flag=0;
    for j=1:len2
        if process(j)
            continue;
        end
        pos=j;
        initial=results(j,1:2);
        num_con=num_con+1;
        point1=[];
        point1(end+1,:)=initial(:);
        while(~isequal(results(pos,5:6),initial))

            process(pos)=true;
            pos=results(pos,7);
            process(pos)=true;
            point1(end+1,:)=results(pos,1:2);
            pos=nextpos(pos,results,process);
            if pos <1 
                flag=1;
                break;
            end
        end
        if flag
            figure;
            hold on;
            for p=1:size(point1,1)
              scatter(point1(p,1),point1(p,2));  
            end
            hold off;
            title('wrong')
            num_con=num_con-1;
            disp('出错');
            return;
        end
        process(pos)=true;
        process(results(pos,7))=true;
        point{num_con,1}=point1;
    end
end

 function newpos = nextpos(pos,results,process)
        newpos=pos+1;
        while newpos<=size(results,1) && isequal(results(newpos,1:2),results(pos,1:2))
            if(~process(newpos))
                 return
            else
            newpos=newpos+1;
            end
        end

        newpos=pos-1;
        while(newpos>0 && process(newpos))

            newpos=newpos-1;

        end
        if newpos==0
            return;
        end
        
 end   
hold off;
end

