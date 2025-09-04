(define-module (gnu packages nvidia-texture-tools)
  #:use-module (gnu packages)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (gnu packages pkg-config)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (ice-9 match)
  #:use-module ((srfi srfi-1) #:hide (zip)))



(define-public nvidia-texture-tools
  (package
    (name "nvidia-texture-tools")
    (version "2.1.2")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/castano/nvidia-texture-tools.git")
                    (commit version)))
              (file-name (git-file-name name version))
              (modules '((guix build utils)))
              (sha256
               (base32
                "1i4kamnkg8vkmvlzpwjprdpikxp9862dcs87pdpl3b994ncw0yy7"))))
    (build-system cmake-build-system)
    (arguments
     `(#:configure-flags
       (list)
			 #:tests? #f))
			 
    (native-inputs
     `(("pkg-config" ,pkg-config)))
			 
		 
    (synopsis "Nvidia Texture Tools")
    (description "The NVIDIA Texture Tools is a collection of image processing and texture manipulation tools, designed to be integrated in game tools and asset processing pipelines.")
    (home-page "https://github.com/castano/nvidia-texture-tools")
    (license license:expat)))

nvidia-texture-tools
		
