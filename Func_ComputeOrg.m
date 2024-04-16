function [dX] = Func_ComputeOrg( i,dStartZ,dSlice,X1,X2,Z1,Z2)
dZ=dStartZ+i*dSlice;
temp=(dZ-Z1)/(Z2-Z1);
dX=temp*(X2-X1)+X1;


