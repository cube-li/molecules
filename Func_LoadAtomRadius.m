function cAtomRadius = Func_LoadAtomRadius( strFile )

fRadius = fopen( strFile );
if( -1 == fRadius )
    cAtomRadius = nan;
    return;
end

Count = 1;
while( ~feof( fRadius ) )
    strLine = strtrim( fgetl( fRadius ) );
    %按空格划分
    cTemp = strsplit( strLine, {' ', '\t'} );
    cAtomRadius{ Count, 1 } = cTemp{ 1 };
    cAtomRadius{ Count, 2 } = str2double( cTemp{ 2 } );
    cAtomRadius{ Count, 3 } = str2double( cTemp{ 3 } );
    Count = Count + 1;
end

fclose( fRadius );
