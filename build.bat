echo off

mkdir thefield 2> NUL
mkdir thefield\maps 2> NUL

cd src
qcc || goto :error
copy "progs.dat" "..\thefield\progs.dat" || goto :error
cd ..

cd map
qbsp -cwd thefield.map thefield.bsp || goto :error
light thefield.bsp || goto :error
vis thefield.bsp || goto :error
copy "thefield.bsp" "..\thefield\maps\thefield.bsp" || goto :error
cd ..

goto :EOF

:error
echo ---------- ERROR ----------
cd ..
exit /b 1