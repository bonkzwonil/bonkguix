(define-module (gnu packages nvidia-texture-tools)
  #:use-module (gnu packages)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages image-processing)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages wine)
  #:use-module (gnu packages linux)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
	#:use-module (gnu packages sdl)
	
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (ice-9 match)
  #:use-module ((srfi srfi-1) #:hide (zip)))



(define-public linux-console
  (package
    (name "linux-console")
    (version "")
    (source (origin
              (method url-fetch)
              (uri "https://altushost-swe.dl.sourceforge.net/project/linuxconsole/linuxconsoletools-1.8.1.tar.bz2?viasf=1")
              (sha256
               (base32
                "0mi4bkrwp83gcg3jy7knscfi4qziggkljz7kylcdpdw2qx2rg8jd"))))
    (build-system gnu-build-system)
    (arguments
     `(#:make-flags
			 (list (string-append "DESTDIR=" (assoc-ref %outputs "out") "PREFIX=/")
                   "CC=gcc")
			 #:tests? #f
			 #:phases
			 (modify-phases %standard-phases
											(delete 'configure))))

    (native-inputs
     (list
			sdl2
			pkg-config
			))
			 
		 
    (synopsis "kernel utils")
    (description "")
    (home-page "")
    (license license:isc)))



linux-console
