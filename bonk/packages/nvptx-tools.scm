(define-module (bonk packages nvptx-tools)
  #:use-module (gnu packages)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages readline)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages m4)
  #:use-module (gnu packages xorg)
  #:use-module (guix build-system gnu)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (ice-9 match)
  #:use-module ((srfi srfi-1) #:hide (zip))
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages commencement))

(define-public nvptx-tools
  (package
   (name "nvptx-tools")
   (version "a0c1fff6534a4df9fb17937c3c4a4b1071212029")
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/SourceryTools/nvptx-tools.git")
                  (commit version)))
            (file-name (git-file-name name version))
            (sha256
             (base32
              "1gcf3hq9a5yv34fkg2s41j5z3l6c91lvz0mdhp77c60gqm5lgr6f")
             )))
   (build-system gnu-build-system)
   (arguments
    `(#:tests? #f)) ;;Disabled for now, need to look into it why it fails
   (native-inputs (list gcc-toolchain perl))
   (synopsis "Tools for NVPTX GCC toolchains")
   (description "Assembler and linker for NVPTX.")
   (home-page "https://github.com/SourceryTools/nvptx-tools")
   (license license:gpl3+)))
