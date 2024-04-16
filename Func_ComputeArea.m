function vS=Func_ComputeArea(point,num_con,LineFlag,LineFlag1)
vS=0;
    for i =1:num_con
        len=length(point{i,1});
        if len <=2
            continue;
        end
        point_sub=point{i,1};
        dS=0;
        for j=1:len-1
            dS=dS+0.5*(point_sub(j,1)*point_sub(j+1,2)-point_sub(j+1,1)*point_sub(j,2));
        end
        dS=dS+0.5*(point_sub(len,1)*point_sub(1,2)-point_sub(1,1)*point_sub(len,2));
        vS=vS+abs(dS);
    end
    mFlag=xor(LineFlag,LineFlag1);
    vS =(-1)^mFlag * vS;
end