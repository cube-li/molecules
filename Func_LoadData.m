function [ Atom_info, AtomNum, org_coor, step_num, step, ElecCloudDen, ElecCloudDenNum ] = Func_LoadData( strFile )


fMol = fopen( strFile );
fgetl( fMol );
fgetl( fMol );

[ AtomNum, org_coor, step_num, step ] = Func_GetData( fMol );

Atom_info = zeros(AtomNum, 4);

for i = 1 : AtomNum
    strLine = str2num( fgetl( fMol ) );
    Atom_info(i,1)=strLine(1);  %Ô­×ÓÐòÊý
    Atom_info(i,2)=strLine(3);  %X
    Atom_info(i,3)=strLine(4);  %Y
    Atom_info(i,4)=strLine(5);  %Z
end

ElecCloudDenNum = 1;

while( ~feof( fMol ) )
    
    strLine = str2num( fgetl( fMol ) );
    
    [ ~, n ] = size( strLine );
    
    for i = 1 : n
        
        ElecCloudDen(  ElecCloudDenNum ) = strLine( i );
        ElecCloudDenNum = ElecCloudDenNum + 1;
        
    end

end
    
ElecCloudDenNum = ElecCloudDenNum - 1;

fclose( fMol );


