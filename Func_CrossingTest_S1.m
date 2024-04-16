%%运用跨立实验判断线段是否相交
%%快速排斥实验
%改变——相交于端点pass,根据条件判断是否重合
function[segments,events,count,Flag]=Func_CrossingTest_S1(temp,temp1,segments,events,count)
Flag=0;

new=0;    
Line_2x=[segments(temp1).start_x,segments(temp1).end_x];
Line_2y=[segments(temp1).start_y,segments(temp1).end_y];
Line_1x=[segments(temp).start_x,segments(temp).end_x];
Line_1y=[segments(temp).start_y,segments(temp).end_y];
% P=[];
if((max(Line_2x)<min(Line_1x))||(max(Line_1x)<min(Line_2x))||(max(Line_2y)<min(Line_1y))||(max(Line_1y)<min(Line_2y)))
    return;
else
    Cross_P1=Func_CrossProduct(Line_1x(1)-Line_2x(1),Line_2x(2)-Line_2x(1),Line_1y(1)-Line_2y(1),Line_2y(2)-Line_2y(1));
    Cross_P2=Func_CrossProduct(Line_1x(2)-Line_2x(1),Line_2x(2)-Line_2x(1),Line_1y(2)-Line_2y(1),Line_2y(2)-Line_2y(1));
    Cross_P3=Func_CrossProduct(Line_2x(1)-Line_1x(1),Line_1x(2)-Line_1x(1),Line_2y(1)-Line_1y(1),Line_1y(2)-Line_1y(1));
    Cross_P4=Func_CrossProduct(Line_2x(2)-Line_1x(1),Line_1x(2)-Line_1x(1),Line_2y(2)-Line_1y(1),Line_1y(2)-Line_1y(1));
    if((Cross_P1*Cross_P2)<0&&(Cross_P3*Cross_P4)<0)
        

        are123=Func_abs_area(Line_2x(1),Line_2y(1),Line_1x(1),Line_1y(1),Line_1x(2),Line_1y(2));
        are124=Func_abs_area(Line_2x(2),Line_2y(2),Line_1x(1),Line_1y(1),Line_1x(2),Line_1y(2));
        k=are123/are124;
        intersection(1)=(Line_2x(1)+k*Line_2x(2))/(1+k);
        intersection(2)=(Line_2y(1)+k*Line_2y(2))/(1+k);
        
        segments=[segments;Segment(intersection(1),intersection(2),segments(temp).end_x,segments(temp).end_y,segments(temp).poly,false,true,-1)];
        segments=[segments;Segment(intersection(1),intersection(2),segments(temp1).end_x,segments(temp1).end_y,segments(temp1).poly,false,true,-1)];
        segments(temp).end_x=intersection(1);
        segments(temp).end_y=intersection(2);
        segments(temp1).end_x=intersection(1);
        segments(temp1).end_y=intersection(2);
        %改变events,两起两终
        old_e=find(events(:,3)==temp);
        old_e1=find(events(:,3)==temp1);
        events(old_e,3)=count;
        events=[events;intersection(1),intersection(2),temp,-2];
        events=[events;intersection(1),intersection(2),temp1,-2];
        events=[events;intersection(1),intersection(2),count,-1];
        count=count+1;
        events(old_e1,3)=count;
        events=[events;intersection(1),intersection(2),count,-1];
        count=count+1;
%         new=1;
        events=Func_SortEvents(events,2);
        return;
    elseif (Cross_P1*Cross_P2)==0&&(Cross_P3*Cross_P4)<0
            
        are134=Func_abs_area(Line_1x(1),Line_1y(1),Line_2x(1),Line_2y(1),Line_2x(2),Line_2y(2));

        if are134 == 0
            intersection=[Line_1x(1),Line_1y(1)];

        else
             intersection=[Line_1x(2),Line_1y(2)];
        end

        segments=[segments;Segment(intersection(1),intersection(2),segments(temp1).end_x,segments(temp1).end_y,segments(temp1).poly,false,true,-1)];
        segments(temp1).end_x=intersection(1);
        segments(temp1).end_y=intersection(2);
        
        old_e1=find(events(:,3)==temp1);
        events(old_e1,3)=count;
        events=[events;intersection(1),intersection(2),temp1,-2];
        events=[events;intersection(1),intersection(2),count,-1];
%         new=1;
        events=Func_SortEvents(events,1); 
        count=count+1;
        return;
    elseif (Cross_P1*Cross_P2)<0&&(Cross_P3*Cross_P4)==0
%       
        are123=Func_abs_area(Line_2x(1),Line_2y(1),Line_1x(1),Line_1y(1),Line_1x(2),Line_1y(2));
%       
        if are123 == 0
             intersection=[Line_2x(1),Line_2y(1)];
   
        else
             intersection=[Line_2x(2),Line_2y(2)];
        end     
        segments=[segments;Segment(intersection(1),intersection(2),segments(temp).end_x,segments(temp).end_y,segments(temp).poly,false,true,-1)];
        segments(temp).end_x=intersection(1);
        segments(temp).end_y=intersection(2);
        
        old_e=find(events(:,3)==temp);
        events(old_e,3)=count;
        events=[events;intersection(1),intersection(2),temp,-2];
        events=[events;intersection(1),intersection(2),count,-1];
%         new=1;
        events=Func_SortEvents(events,1); 
        count=count+1;
        return;
    elseif((Cross_P1*Cross_P2)==0&&(Cross_P3*Cross_P4)==0)
         if(Cross_P1==0)&&(Cross_P2==0)
             sortline={};
             
             result1=sort_line(segments(temp).start_x,segments(temp).start_y,segments(temp1).start_x,segments(temp1).start_y);
             result2=sort_line(segments(temp).end_x,segments(temp).end_y,segments(temp1).end_x,segments(temp1).end_y);
            
             switch result1
                 case 0
                     sortline{end+1}=0;
                 case 1
                     sortline{end+1}=temp1;
                     sortline{end+1}=temp;
                 case 2
                     sortline{end+1}=temp;
                     sortline{end+1}=temp1;
             end
             switch result2
                 case 0  
                     sortline{end+1}=0;
                 case 1
                     sortline{end+1}=temp1;
                     sortline{end+1}=temp;
                 case 2
                     sortline{end+1}=temp;
                     sortline{end+1}=temp1; 
             end
             
             if size(sortline,2)==2 

                 Flag=1;
                 return;
             elseif size(sortline,2)==3 
%                  
                 if sortline{1}==0
          

                     segments=[segments;Segment(segments(sortline{2}).end_x,segments(sortline{2}).end_y,segments(sortline{3}).end_x,segments(sortline{3}).end_y,segments(sortline{3}).poly,false,true,-1)];
                     segments(sortline{3}).end_x=segments(sortline{2}).end_x;
                     segments(sortline{3}).end_y=segments(sortline{2}).end_y;
                     
                  
                    old_e=find(events(:,3)==sortline{3});
                    events(old_e,3)=count;
                    events=[events;segments(sortline{2}).end_x,segments(sortline{2}).end_y,sortline{3},-2];   
                    events=[events;segments(sortline{2}).end_x,segments(sortline{2}).end_y,count,-1]; 
                    count=count+1;
                    events=Func_SortEvents(events,new); 
                    Flag=1;
                    return;
                 else
               
                     
                     segments=[segments;Segment(segments(sortline{2}).start_x,segments(sortline{2}).start_y,segments(sortline{2}).end_x,segments(sortline{2}).end_y,segments(sortline{1}).poly,false,true,-1)];
                     segments(sortline{1}).end_x=segments(sortline{2}).start_x;
                     segments(sortline{1}).end_y=segments(sortline{2}).start_y;
                     
               
                    old_e=find(events(:,3)==sortline{1});
                    events(old_e,3)=count;
                    events=[events;segments(sortline{2}).start_x,segments(sortline{2}).start_y,sortline{1},-2];   
                    events=[events;segments(sortline{2}).start_x,segments(sortline{2}).start_y,count,-1];

                    count=count+1;
                    events=Func_SortEvents(events,new);
                     
                    
                    return;
                 end
                 
                 
             elseif  segments(sortline{2}).start_x ==segments(sortline{3}).end_x && segments(sortline{2}).start_y==segments(sortline{3}).end_y
%                    
                 return;
             else 
               
                 
                 if sortline{1}==sortline{3}
%                    
                     old_e=find(events(:,3)==sortline{1});
                     old_e1=find(events(:,3)==sortline{2});
                     events(old_e,3)=sortline{2};
                     events=[events; segments(sortline{2}).start_x, segments(sortline{2}).start_y,sortline{1},-2];
                     events(old_e1,3)=count;
                     events=[events; segments(sortline{3}).end_x,segments(sortline{3}).end_y,count,-1];
                     count=count+1;
                     events=Func_SortEvents(events,new);
%                      
                      segments=[segments;Segment(segments(sortline{3}).end_x,segments(sortline{3}).end_y,segments(sortline{4}).end_x,segments(sortline{4}).end_y,segments(sortline{4}).poly,false,true,-1)];
                      segments(sortline{2}).end_x=segments(sortline{3}).end_x;
                      segments(sortline{2}).end_y=segments(sortline{3}).end_y;
                      segments(sortline{1}).end_x=segments(sortline{2}).start_x;
                      segments(sortline{1}).end_y=segments(sortline{2}).start_y;
                  
                  
                        
                        return;
                 else
                     
                      segments=[segments;Segment(segments(sortline{3}).end_x,segments(sortline{3}).end_y,segments(sortline{4}).end_x,segments(sortline{4}).end_y,segments(sortline{4}).poly,false,true,-1)];
                      segments(sortline{1}).end_x=segments(sortline{2}).start_x;
                      segments(sortline{1}).end_y=segments(sortline{2}).start_y;
%                      
                        old_e=find(events(:,3)==sortline{4});
%                      
                        events(old_e,3)=count;
                        events=[events; segments(sortline{2}).start_x, segments(sortline{2}).start_y,sortline{1},-2];
                        events=[events; segments(sortline{3}).end_x, segments(sortline{3}).end_y,count,-1];
                        count=count+1;
%                         
                        events=Func_SortEvents(events,new);
                        return;
                 end

             end
%            
         else
%            
             return;
         end
    else
        return;
    end
end

   
end
    



