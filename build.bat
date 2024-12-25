echo off

mkdir thefield 2> NUL
mkdir thefield\maps 2> NUL

cd src
qcc
copy "progs.dat" "..\thefield\progs.dat"
cd ..

cd map
qbsp thefield.map thefield.bsp
light thefield.bsp
vis thefield.bsp
copy "thefield.bsp" "..\thefield\maps\thefield.bsp"
cd ..