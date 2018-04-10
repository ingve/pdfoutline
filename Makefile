OPTS=-fobjc-arc -fmodules
FRAMEWORKS=-framework Foundation -framework Quartz

all:
	clang -o pdfoutline $(OPTS) $(FRAMEWORKS) main.m