function events=Func_SortEvents(events,new)
%     enents1=events;
%      events = sortrows(events,[1,2,4]);
     len_event=size(events,1);
     [events, idx] = sortrows(events,[1,2,4]);
     switch new
           case 1
              idx_new=find(idx==len_event);%新边开始端点的索引
              idx_new1=find(events(:,3)==events(idx_new,3));
              idx_new1=idx_new1(idx_new1~=idx_new);%结束端点索引
              if idx_new1<idx_new
                  events(idx_new,4)=-2;
                  events(idx_new1,4)=-1;
              end
           case 2
               for ii=1:2
                   idx_new=find(idx==len_event-ii+1);%新边开始端点的索引
                   idx_new1=find(events(:,3)==events(idx_new,3));
                   idx_new1=idx_new1(idx_new1~=idx_new);%结束端点索引
                   if idx_new1<idx_new
                       events(idx_new,4)=-2;
                       events(idx_new1,4)=-1;
                   end
               end
       end

   events = sortrows(events,[1,2,4]);
    % 创建索引矩阵
    index_m = false(len_event, 1); % 创建与矩阵行数相同的逻辑值矩阵
%     matching = [];
   
    for k=1:len_event
        if index_m(k)==true
            continue;
        end
        index_m(k)=true;
        matching = find((events(:,4)==events(k,4)) & (events(:,1)==events(k,1))&(events(:,2)==events(k,2)));
        len=length(matching);
        if len>1
            index_m(matching)=true;
            slope=zeros(len,1);
            for l=1:length(matching)
                vIdx1=find(events(:,3)==events(matching(l),3));
                if length(vIdx1)==1
                    continue;
                end
                vIdx1=vIdx1(vIdx1~=matching(l));
                slope(l)=slope_com(events(matching(l),1),events(vIdx1,1),events(matching(l),2),events(vIdx1,2));
            end
            if events(k,4)==-1
                [~,indice]=sortrows(slope);
                matching=matching(indice);
                events(k:k+len-1,:)=events(matching,:);
            else
                [~,indice]=sortrows(slope,'descend');
                matching=matching(indice);
                events(k:k+len-1,:)=events(matching,:);
            end
%             matching=matching(indice);
           
        end
%         if((events(k,4)==events(k+1,4)) && (events(k,1)==events(k+1,1))&&(events(k,2)==events(k+1,2)))
%             vIdx=find(events(:,3)==events(k,3));
%             vIdx=vIdx(vIdx~=k);
%             vIdx1=find(events(:,3)==events(k+1,3));
%             vIdx1=vIdx1(vIdx1~=(k+1));
%             if events(k,1)==events(vIdx,1) | events(k+1,1)==events(vIdx1,1)
%                 if(events(vIdx,2)>events(vIdx1,2))
%                     events([k,k+1],:)=events([k+1,k],:);
%                 end 
%             else
%                 slope1=(events(vIdx,2)-events(k,2))/(events(vIdx,1)-events(k,1));
%                 slope2=(events(vIdx1,2)-events(k+1,2))/(events(vIdx1,1)-events(k+1,1));
%                 if slope2<slope1
%                     events([k,k+1],:)=events([k+1,k],:);
%                 end 
%             end
%            
%         end
%         continue;   
 
    end
    function slope = slope_com(x1,x2,y1,y2)
            if x1==x2
                slope=Inf;
            else
                slope=(y2-y1)/(x2-x1);
            end
    end
end
