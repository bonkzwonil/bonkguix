(define-module (bonk packages x3270)
  #:use-module (gnu packages)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages image-processing)
  #:use-module (gnu packages linux)
        #:use-module (gnu packages readline)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (gnu packages tcl)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages m4)
  #:use-module (gnu packages xorg)
  #:use-module (guix build-system gnu)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (ice-9 match)
  #:use-module ((srfi srfi-1) #:hide (zip)))



(define-public x3270
  (package
    (name "x3270")
    (version "4.3ga9")
    (source (origin
              (method url-fetch)
              (uri (string-append
                                                                                "https://prdownloads.sourceforge.net/x3270/suite3270-"
                                                                                version
                                                                                "-src.tgz"))
              (sha256
               (base32
                "1cadrrrjdbxaxfsdx2xkji8dhmxir99z2pxkm9nqj3d455xx4134"))))
    (build-system gnu-build-system)

                (arguments
     `(#:configure-flags
       (list)
                         #:tests? #f))

    (native-inputs
     (list
                        pkg-config
                        readline
                        tcl
                        expat
                        m4
                        openssl
                        libx11
                        libice
                        libxft
                        libxt
                        libxcursor
                        libxext
                        libxaw
                        bdftopcf
                        mkfontdir
                        ))


    (synopsis "IBM 3270 Terminal emulator")
    (description "Emulators for the 3270 Terminal. x3270, c3270, t3270 etc")
    (home-page "https://x3270.miraheze.org")
    (license license:bsd-3)))



x3270
