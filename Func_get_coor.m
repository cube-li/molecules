function coor = Func_get_coor( CubePointsA, CubePointsB, a )
potdiff =  CubePointsA(4) - CubePointsB(4) ;
stddiff = 0.001 - CubePointsA(4);
prop = stddiff / potdiff;
switch a
    case 1
        distol =  CubePointsA(1) - CubePointsB(1) ;
        coor = CubePointsA(1) + prop * distol;
    case 2
        distol =  CubePointsA(2) - CubePointsB(2) ;
        coor = CubePointsA(2) + prop * distol;
    case 3
        distol =  CubePointsA(3) - CubePointsB(3);
        coor = CubePointsA(3) + prop * distol;
end
