  (use-modules (gnu packages))
  (use-modules (guix packages))
  (use-modules (guix gexp))
  (use-modules (gnu packages autotools))
  (use-modules (gnu packages bison))
  (use-modules (gnu packages compression))
  (use-modules (gnu packages documentation))
  (use-modules (gnu packages elf))
  (use-modules (gnu packages flex))
  (use-modules (gnu packages fontutils))
  (use-modules (gnu packages freedesktop))
  (use-modules (gnu packages gettext))
  (use-modules (gnu packages guile))
  (use-modules (gnu packages image))
  (use-modules (gnu packages gtk))
  (use-modules (gnu packages gnome))
  (use-modules (gnu packages maths))
  (use-modules (gnu packages graphics))
  (use-modules (gnu packages photo))
  (use-modules (gnu packages protobuf))
  (use-modules (gnu packages linux))
  (use-modules (gnu packages llvm))
  (use-modules (gnu packages pkg-config))
  (use-modules (gnu packages python))
  (use-modules (gnu packages python-xyz))
  (use-modules (gnu packages tls))
  (use-modules (gnu packages video))
  (use-modules (gnu packages vulkan))
  (use-modules (gnu packages xdisorg))
  (use-modules (gnu packages xml))
  (use-modules (gnu packages qt))
  (use-modules (nongnu packages nvidia))
  (use-modules (gnu packages xorg))
  (use-modules (guix download))
  (use-modules (guix git-download))
  (use-modules (guix hg-download))
  (use-modules (guix packages))
  (use-modules (guix build-system gnu))
	(use-modules (gnu packages image-processing))
  (use-modules (guix build-system cmake))
  (use-modules (guix build-system meson))
  (use-modules (guix build-system copy))
  (use-modules (guix build-system python))
  (use-modules ((guix licenses) #:prefix license:))
  (use-modules (guix packages))
  (use-modules (guix utils))
  (use-modules (ice-9 match))
  (use-modules ((srfi srfi-1) #:hide (zip)))



(define-public swiftclient
  (package
    (name "swiftclient")
    (version "v0.12.111")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/swift-project/pilotclient.git")
                    (commit version)))
              (file-name (git-file-name name version))
              (modules '((guix build utils)))
              (sha256
               (base32
                "0fr075y9j5v90lsm259cw2i73c5qaqclm6fqkcif49hwym1ngxkx"))))
    (build-system cmake-build-system)
		
    (arguments
     `(#:configure-flags
       (list)))
			 
    (native-inputs
     `(("pkg-config" ,pkg-config)))

    (inputs
     (list
			qtbase-5
			zlib))
    (synopsis "Pilot ATC Client")
    (description "")
    (home-page "https://github.com/swift-project/pilotclient/tags")
    (license license:bsd-3)))



(packages->manifest (list swiftclient))
