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

anim-2160:
	mkdir -p anim/4k
	$(POVRAY) $(STONES)[ANIM-2160] -I$(STONES).pov
	avconv -y -framerate 25 -i anim/4k/$(STONES)-%03d.png -s:v 3840x2160 -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p $(STONES)-2160.mp4

anim-4320:
	mkdir -p anim/8k
	$(POVRAY) $(STONES)[ANIM-4320] -I$(STONES).pov
	avconv -y -framerate 25 -i anim/8k/$(STONES)-%03d.png -s:v 7680x4320 -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p $(STONES)-4320.mp4

anim-1024:
	mkdir -p anim/1024
	$(POVRAY) $(STONES)[ANIM-1024] -I$(STONES).pov
	avconv -y -framerate 25 -i anim/whigh/$(STONES)-%03d.png -s:v 1280x1024 -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p $(STONES)-1024.mp4

anim-240:
	mkdir -p anim/240
	$(POVRAY) $(STONES)[ANIM-240] -I$(STONES).pov
	avconv -y -framerate 25 -i anim/low/$(STONES)-%03d.png -s:v 320x240 -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p $(STONES)-140.mp4

%.pov: Makefile

%.png: %.ini %.pov
	nice $(POVRAY) $(POVOPT) '$<[WHIGH]' -i'${@:.png=.pov}' +fn +o'$@'

%.pngclean:
	rm -fr '${@:.pngclean=.png}'

clean: $(PNGCLEAN)
	rm -fr *~ *.bak *.tga *.ppm

distclean: clean
	rm -fr *~ *.bak *.tga *.ppm
