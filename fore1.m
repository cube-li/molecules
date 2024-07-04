
clear;clc;close all

%raw_data_address
%Please use .dst file
%use MC algorithm to reconstruct models

%[ vX, vY, vZ, iCloudLength, iFaceLength, vFace ] 
%[ vX1, vY1, vZ1, iCloudLength1, iFaceLength1, vFace1 ]

[dVol,cross]= test3(vX, vY, vZ, iFaceLength, vFace,step,vStart,vX2, vY2, vZ2, iFaceLength1, vFace1,step1);


