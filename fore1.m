
clear;clc;close all
FontSize = 22;
FontWeight = 'bold';
%raw_data_address
%Please use .dst file
[ Atom_info, AtomNum, ~, CubePoints, step_num, step, vStart ] = Func_GetCubePoints( strFile );
[ Atom_info1, AtomNum1, ~, CubePoints1, step_num1, step1, vStart1 ] = Func_GetCubePoints( strFile1 );
load LUT;
cAtomRadius = Func_LoadAtomRadius( 'Acce3.txt' );

[ vX, vY, vZ, iCloudLength, iFaceLength, vFace ] = Func_ContourV2( CubePoints, step_num( 1 ), step_num( 2 ), step_num( 3 ), LUT  );
[ vX1, vY1, vZ1, iCloudLength1, iFaceLength1, vFace1 ] = Func_ContourV2( CubePoints1, step_num1( 1 ), step_num1( 2 ), step_num1( 3 ), LUT  );

dStartX = vStart(1);
dStartY = vStart(2);
dStartZ = vStart(3);

vX1 = vX1 + 10;
vY1 = vY1 + 10;
%%
figure;
hold on;
Surface1.faces = vFace;
Surface1.vertices = [vX,vY,vZ];
S=Surface1;
hh=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.5, 'FaceColor', [1,0.98039,0.98039] );
set(hh,'EdgeColor',[0.8235,0.1255,0.1529]);
axis off;
axis image;
hold off;

figure;
Surface1.faces = vFace1;
%Surface1.vertices = [vX2,vY2,vZ2];
Surface1.vertices = [vX1,vY1,vZ1];
S=Surface1; h=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.5, 'FaceColor', [0.99216,0.96078,0.90196]);
set(h,'EdgeColor',[0.2196,0.3490,0.5373]);
view(-145, 30);
axis off;
axis image;
hold off;

dVol=0;
cross=[];

% 
    [dVol,cross]= test3(vX, vY, vZ, iFaceLength, vFace,step,vStart,vX2, vY2, vZ2, iFaceLength1, vFace1,step1);


