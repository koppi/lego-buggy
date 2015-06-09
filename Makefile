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

anim-8k:
	$(POVRAY) $(STONES)[ANIM-8K] -I$(STONES).pov
	ffmpeg -y -framerate 25 -i anim/8k/$(STONES)-%03d.png -s:v 7680x4320 -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p $(STONES)-8k.mp4

anim-whigh:
	$(POVRAY) $(STONES)[ANIM-WHIGH] -I$(STONES).pov
	ffmpeg -y -framerate 25 -i anim/whigh/$(STONES)-%03d.png -s:v 1280x1024 -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p $(STONES)-whigh.mp4

anim-low:
	$(POVRAY) $(STONES)[ANIM-LOW] -I$(STONES).pov
	ffmpeg -y -framerate 25 -i anim/low/$(STONES)-%03d.png -s:v 160x140 -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p $(STONES)-low.mp4

%.pov: Makefile

%.png: %.ini %.pov
	nice $(POVRAY) $(POVOPT) '$<[WHIGH]' -i'${@:.png=.pov}' +fn +o'$@'

%.pngclean:
	rm -fr '${@:.pngclean=.png}'

clean: $(PNGCLEAN)
	rm -fr *~ *.bak *.tga *.ppm

distclean: clean
	rm -fr *~ *.bak *.tga *.ppm
