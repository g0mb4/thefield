.PHONY: clean map run src thefield

thefield: map src
	mkdir -p thefield/maps
	cp src/progs.dat thefield/progs.dat
	cp map/*.bsp thefield/maps

map:
	make -C map

src:
	make -C src

clean:
	rm -rf thefield/*
	make clean -C map
	make clean -C src

run: thefield
	quakespasm --args -nolauncher -basedir $(PWD) -game thefield \
		+map thefield +developer 1 \
		-width 1024 -height 768 -bpp 32 -window -nosound
