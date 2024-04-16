function [ Atom_info,AtomNum, ElecCloudDenNum, CubePoints, step_num, step, org_coor ] = Func_GetCubePoints( strFile )


[ Atom_info,AtomNum, org_coor, step_num, step, ElecCloudDen, ElecCloudDenNum ] = Func_LoadData( strFile );


a = 1;
b = step_num( 1 ) * step_num( 2 ) * step_num( 3 );
CubePoints = zeros( b, 5 );

for i = 1 : step_num( 1 )
    
    new_x = org_coor( 1 ) + ( i - 1 ) .* step( 1 );
    
    for j = 1 : step_num( 2 )
        
        new_y = org_coor( 2 ) + ( j - 1 ) .* step( 2 );
        
        for k = 1 : step_num( 3 )
            
            new_z =  org_coor( 3 ) + ( k - 1 ) .* step( 3 );
            a = ( i - 1 ) * step_num( 2 ) * step_num( 3 ) + ( j - 1 ) * step_num( 3 ) + k;
            CubePoints( a, 1 ) =  new_x ;
            CubePoints( a, 2 ) =  new_y ;
            CubePoints( a, 3 ) =  new_z ;
             
        end
        
    end
    
end

CubePoints( :, 4 ) = ElecCloudDen';

for i = 1 : b
    if ( CubePoints( i, 4 ) > 0.001 )
        CubePoints( i, 5 ) = 1;
    else
        CubePoints( i, 5 ) = 0;
    end
end













            