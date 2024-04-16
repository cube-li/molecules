function [ AtomNum, org_coor, step_num, step ] = Func_GetData( fMol )

strLine = strtrim( fgetl( fMol ) );
data = str2num( strLine );  
AtomNum = data( 1 );
org_coor = [ data( 2 ), data( 3 ), data( 4 ) ];

strLine = strtrim( fgetl( fMol ) );
data_x = str2num( strLine );
step_num( 1 ) = data_x( 1 );
step( 1 ) = data_x( 2 );

strLine = strtrim( fgetl( fMol ) );
data_y = str2num( strLine );
step_num( 2 ) = data_y( 1 );
step( 2 ) = data_y( 3 );

strLine = strtrim( fgetl( fMol ) );
data_z = str2num( strLine );
step_num( 3 ) = data_z( 1 );
step( 3 ) = data_z( 4 );
