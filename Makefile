all: packages

x3270:
	guix build -f packages/x3270.scm

nvptx-tools:
	guix build -f packages/nvptx-tools.scm

tn5250:
	guix build -L . tn5250

nomad-hc:
	guix build -L . nomad-hc



packages: x3270 nvptx-tools tn5250 nomad-hc
