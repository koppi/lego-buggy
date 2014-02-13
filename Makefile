POVRAY  = povray
POVOPT  = +v

#POVOPT  += +Q1
POVOPT  += +Q11

POVOPT  += -c +d -p +w1280 +h1024

STONES    = lego-buggy

DOCPNG    = ${STONES:=.png}
PNGCLEAN  = ${STONES:=.pngclean}

.SUFFIXES:
.SUFFIXES: .pov .ini .png .pngclean

all: $(DOCPNG)

%.pov: Makefile

%.png: %.ini %.pov
	$(POVRAY) $(POVOPT) '$<[HIGH]' -i'${@:.png=.pov}' +fn +o'$@'

%.pngclean:
	rm -fr '${@:.pngclean=.png}'

clean: $(PNGCLEAN)
	rm -fr *~ *.bak *.tga *.ppm

distclean: clean
	rm -fr *~ *.bak *.tga *.ppm
