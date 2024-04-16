function [  X, Y, Z, iCloudLength, iFaceLength, vFace ] = Func_ContourV2( CubePoints, step_1, step_2, step_3, LUT  )
    iCloudLength = 0;
    iFaceLength = 0;
    Cub_num = step_2 * step_3;
    a = step_1 * step_2 * step_3;
    for i = 1 : step_1 
        if (i == step_1)
            continue;
        end
        for j = 1 : step_2
            if(j == step_2)
                continue;
            end
            for k = 1 : step_3
                if( k == step_3)
                    continue;
                end
                num_3 = k + step_3 * (j - 1) + step_2 * step_3 * (i -1);
                num_2 = num_3 + step_3;
                num_7 = num_3 + Cub_num;
                num_6 = num_3 + Cub_num + step_3;
                num_0 = num_3 + 1;
                num_1 = num_3 + step_3 + 1;
                num_4 = num_3 + Cub_num + 1;
                num_5 = num_3 + Cub_num + step_3 + 1;
                count = CubePoints(num_0, 5) + CubePoints(num_1, 5) + CubePoints(num_2, 5) + CubePoints(num_3, 5) + CubePoints(num_4, 5) + CubePoints(num_5, 5) + CubePoints(num_6, 5) + CubePoints(num_7, 5);
                if (count ~= 8 && count ~= 0)
                    index = CubePoints(num_0,5) * 2^0 + CubePoints(num_1,5) * 2^1 + CubePoints(num_2,5) * 2^2 + CubePoints(num_3,5) * 2^3 + CubePoints(num_4,5) * 2^4 + CubePoints(num_5,5) * 2^5 + CubePoints(num_6,5) * 2^6 + CubePoints(num_7,5) * 2^7;
                    ePoints = LUT(index + 1, :);
                    count1 = 1;
                    while(ePoints(1, count1) ~= -1)
                        count1 = count1 + 1;
                    end
                    Triangle_num = (count1 - 1) / 3;
                    iFaceLength = iFaceLength + Triangle_num;
                    iCloudLength = iCloudLength + (count1 - 1);
                end
            end
        end
    end
    X = zeros(iCloudLength, 1);
    Y = zeros(iCloudLength, 1);
    Z = zeros(iCloudLength, 1);
    vFace = zeros(iFaceLength, 3);
    iCloudCount = 0;
    iFaceCount = 0;  
    for i = 1 : step_1 
        if (i == step_1)
            continue;
        end
        for j = 1 : step_2
            if(j == step_2)
                continue;
            end
            for k = 1 : step_3
                if( k == step_3)
                    continue;
                end
                num_3 = k + step_3 * (j - 1) + step_2 * step_3 * (i -1);
                num_2 = num_3 + step_3;
                num_7 = num_3 + Cub_num;
                num_6 = num_3 + Cub_num + step_3;
                num_0 = num_3 + 1;
                num_1 = num_3 + step_3 + 1;
                num_4 = num_3 + Cub_num + 1;
                num_5 = num_3 + Cub_num + step_3 + 1;
                count = CubePoints(num_0, 5) + CubePoints(num_1, 5) + CubePoints(num_2, 5) + CubePoints(num_3, 5) + CubePoints(num_4, 5) + CubePoints(num_5, 5) + CubePoints(num_6, 5) + CubePoints(num_7, 5);
                if (count ~= 8 && count ~= 0)
                    index = CubePoints(num_0,5) * 2^0 + CubePoints(num_1,5) * 2^1 + CubePoints(num_2,5) * 2^2 + CubePoints(num_3,5) * 2^3 + CubePoints(num_4,5) * 2^4 + CubePoints(num_5,5) * 2^5 + CubePoints(num_6,5) * 2^6 + CubePoints(num_7,5) * 2^7;
                    ePoints = LUT(index + 1, :);
                    count1 = 1;
                    while(ePoints(1, count1) ~= -1)
                        count1 = count1 + 1;
                    end
                    for m = 1 : count1 - 1
                        %此处记的点云数量
                        iCloudCount = iCloudCount + 1;
                        switch ePoints(1, m)
                            case 0
                                X(iCloudCount) = CubePoints(num_0,1) ;
                                % Triangle_coordinates(m, 2) = (CubePoints(num_0,2) + CubePoints(num_1,2))/2;
                                Y(iCloudCount) = Func_get_coor( CubePoints(num_0,:), CubePoints(num_1,:), 2 );
                                Z(iCloudCount) = CubePoints(num_0,3) ;
                            case 1
                                X(iCloudCount) = CubePoints(num_1,1) ;
                                Y(iCloudCount) = CubePoints(num_1,2) ;
                                % Triangle_coordinates(m, 3) = (CubePoints(num_1,3) + CubePoints(num_2,3))/2;
                                Z(iCloudCount) = Func_get_coor( CubePoints(num_1,:), CubePoints(num_2,:), 3 );
                            case 2
                                X(iCloudCount) = CubePoints(num_2,1) ;
                                % Triangle_coordinates(m, 2) = (CubePoints(num_2,2) + CubePoints(num_3,2))/2;
                                Y(iCloudCount) = Func_get_coor( CubePoints(num_2,:), CubePoints(num_3,:), 2 );
                                Z(iCloudCount) = CubePoints(num_2,3) ;
                            case 3
                                X(iCloudCount) = CubePoints(num_3,1) ;
                                Y(iCloudCount) = CubePoints(num_3,2) ;
                                % Triangle_coordinates(m, 3) = (CubePoints(num_3,3) + CubePoints(num_0,3))/2;
                                Z(iCloudCount) = Func_get_coor( CubePoints(num_3,:), CubePoints(num_0,:), 3 );
                            case 4
                                X(iCloudCount) = CubePoints(num_4,1) ;
                                % Triangle_coordinates(m, 2) = (CubePoints(num_4,2) + CubePoints(num_5,2))/2;
                                Y(iCloudCount) = Func_get_coor( CubePoints(num_4,:), CubePoints(num_5,:), 2 );
                                Z(iCloudCount) = CubePoints(num_4,3) ;
                            case 5
                                X(iCloudCount) = CubePoints(num_5,1) ;
                                Y(iCloudCount) = CubePoints(num_5,2) ;
                                % Triangle_coordinates(m, 3) = (CubePoints(num_5,3) + CubePoints(num_6,3))/2;
                                Z(iCloudCount) = Func_get_coor( CubePoints(num_5,:), CubePoints(num_6,:), 3 );
                            case 6
                                X(iCloudCount) = CubePoints(num_6,1) ;
                                % Triangle_coordinates(m, 2) = (CubePoints(num_6,2) + CubePoints(num_7,2))/2;
                                Y(iCloudCount) = Func_get_coor( CubePoints(num_6,:), CubePoints(num_7,:), 2 );
                                Z(iCloudCount) = CubePoints(num_6,3) ;
                            case 7
                                X(iCloudCount) = CubePoints(num_7,1) ;
                                Y(iCloudCount) = CubePoints(num_7,2) ;
                                % Triangle_coordinates(m, 3) = (CubePoints(num_7,3) + CubePoints(num_4,3))/2;
                                Z(iCloudCount) =  Func_get_coor( CubePoints(num_7,:), CubePoints(num_4,:), 3 );
                            case 8
                                % Triangle_coordinates(m, 1) = (CubePoints(num_0,1) + CubePoints(num_4,1))/2 ;
                                X(iCloudCount) = Func_get_coor( CubePoints(num_0,:), CubePoints(num_4,:), 1 ) ;
                                Y(iCloudCount) = CubePoints(num_0,2);
                                Z(iCloudCount) = CubePoints(num_0,3);
                            case 9
                                % Triangle_coordinates(m, 1) = (CubePoints(num_1,1) + CubePoints(num_5,1))/2 ;
                                X(iCloudCount) = Func_get_coor( CubePoints(num_1,:), CubePoints(num_5,:), 1 ) ;
                                Y(iCloudCount) = CubePoints(num_1,2);
                                Z(iCloudCount) = CubePoints(num_1,3);
                            case 10
                                % Triangle_coordinates(m, 1) = (CubePoints(num_2,1) + CubePoints(num_6,1))/2 ;
                                X(iCloudCount) = Func_get_coor( CubePoints(num_2,:), CubePoints(num_6,:), 1 ) ;
                                Y(iCloudCount) = CubePoints(num_2,2);
                                Z(iCloudCount) = CubePoints(num_2,3);
                            case 11
                                % Triangle_coordinates(m, 1) = (CubePoints(num_3,1) + CubePoints(num_7,1))/2 ;
                                X(iCloudCount) = Func_get_coor( CubePoints(num_3,:), CubePoints(num_7,:), 1 ) ;
                                Y(iCloudCount) = CubePoints(num_3,2);
                                Z(iCloudCount) = CubePoints(num_3,3);
                        end
                        if(0 == mod(m, 3))
                            iFaceCount = iFaceCount + 1;
                            if(1 == iFaceCount)%第一个面
                                vFace(iFaceCount, 1) = iCloudCount - 2;
                                vFace(iFaceCount, 2) = iCloudCount - 1;
                                vFace(iFaceCount, 3) = iCloudCount;
                            else
                                iIsequal = iCloudCount;
                                %看当前面片中的点与之前面片中的点是否有重合
                                for iCount = 1 : iIsequal - 3
                                    if(X(iIsequal - 2) == X(iCount) & Y(iIsequal - 2) == Y(iCount) & Z(iIsequal - 2) == Z(iCount))
                                        X(iIsequal - 2) = X(iIsequal - 1);
                                        Y(iIsequal - 2) = Y(iIsequal - 1);
                                        Z(iIsequal - 2) = Z(iIsequal - 1);
                                        
                                        X(iIsequal - 1) = X(iIsequal);
                                        Y(iIsequal - 1) = Y(iIsequal);
                                        Z(iIsequal - 1) = Z(iIsequal);
                                        
                                        vFace(iFaceCount, 1) = iCount;
                                        iIsequal = iIsequal - 1;
                                        break;
                                    else
                                        vFace(iFaceCount, 1) = iIsequal - 2;
                                    end
                                end
                                
                                for iCount = 1 : iIsequal - 2
                                   if(X(iIsequal - 1) == X(iCount) & Y(iIsequal - 1) == Y(iCount) & Z(iIsequal - 1) == Z(iCount))
                                        X(iIsequal - 1) = X(iIsequal);
                                        Y(iIsequal - 1) = Y(iIsequal);
                                        Z(iIsequal - 1) = Z(iIsequal);
                                        
                                        vFace(iFaceCount, 2) = iCount;
                                        iIsequal = iIsequal - 1;
                                        break;
                                    else
                                        vFace(iFaceCount, 2) = iIsequal - 1;
                                    end
                                end
                                
                                for iCount = 1 : iIsequal - 1
                                    if(X(iIsequal) == X(iCount) & Y(iIsequal) == Y(iCount) & Z(iIsequal) == Z(iCount))
                                        vFace(iFaceCount, 3) = iCount;
                                        iIsequal = iIsequal - 1;
                                        break;
                                    else
                                        vFace(iFaceCount, 3) = iIsequal;
                                    end
                                end
                                %此处的作用是因为三角面片有共同点，多余占得位置置空，缩短矩阵长度
                                if(iIsequal < iCloudCount)
                                    iTemp = iCloudCount - iIsequal;
                                    for iCount = 1 : iTemp
                                        X(iCloudLength) = [];
                                        Y(iCloudLength) = [];
                                        Z(iCloudLength) = [];
                                        iCloudCount = iCloudCount - 1;
                                        iCloudLength = iCloudLength - 1;
                                    end
                                end
                            end
                        end
                    end
                    
                end
            end
        end
    end
end

