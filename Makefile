all: packages

x3270:
	guix build -f packages/x3270.scm

nvptx-tools:
	guix build -f packages/nvptx-tools.scm

tn5250:
	guix build -L packages tn5250

packages: x3270 nvptx-tools tn5250
