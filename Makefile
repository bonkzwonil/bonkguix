all: packages

x3270:
	guix build -f ./bonk/packages/x3270.scm

nvptx-tools:
	guix build -f ./bonk/packages/nvptx-tools.scm

tn5250:
	guix build -f ./bonk/packages/tn5250.scm

nomad-hc: #Currently not running in gh, as it needs nonguix
	guix build -L ./bonk/packages nomad-hc



packages: x3270 nvptx-tools tn5250
