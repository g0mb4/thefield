QBSP := qbsp
QBSPFALGS := -cwd
LIGHT := light
LIGHTFLAGS :=
VIS := vis
VISFLAGS :=

SRC := $(wildcard *.map)
BSPS := $(SRC:.map=.bsp)

.PHONY: all clean

all: $(BSPS)

%.bsp: %.map
	$(QBSP) $(QBSPFALGS) $< $@
	$(LIGHT) $(LIGHTFLAGS) $@
	$(VIS) $(VISFLAGS) $@

clean:
	rm -rf *.bsp
	rm -rf *.h1
	rm -rf *.h2
	rm -rf *.prt
	rm -rf *.pts
