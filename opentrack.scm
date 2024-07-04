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
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (ice-9 match)
  #:use-module ((srfi srfi-1) #:hide (zip)))



(define-public opentrack
  (package
    (name "opentrack")
    (version "opentrack-2023.3.0")
    (source (origin
              (method url-fetch)
              (uri "https://github.com/opentrack/opentrack/archive/refs/tags/opentrack-2023.3.0.tar.gz")
              (sha256
               (base32
                "097q144b1wfslncplq7b342i9vcbrmnvm5cfcii03mxpljfylpxs"))))
    (build-system cmake-build-system)
    (arguments
     `(#:configure-flags
       (list
				(string-append "-DOpenCV_DIR="
											 (assoc-ref %build-inputs "opencv"))
				"-DSDK_WINE=ON"
				)
			 #:tests? #f))
			 
    (native-inputs
     (list
			pkg-config
			opencv
			qttools-5
			qtbase-5
			procps
			wine64
																				;opentrack-aruco-module
			))
			 
		 
    (synopsis "Headtracking")
    (description "opentrack is an application dedicated to tracking user's head movements and relaying the information to games and flight simulation software.")
    (home-page "https://github.com/opentrack/opentrack")
    (license license:isc)))

(define-public opentrack-aruco-module
  (package
    (name "opentrack-aruco-module")
    (version "e08d336bd2c70859efd19622582817fe8eabe714")
    (source (origin
             (method git-fetch)
						 (uri
							(git-reference
							 (url "https://github.com/opentrack/aruco.git")
							 (commit version)))
						 (file-name (git-file-name name version))
             (sha256
              (base32
               "1d7yg3la58skv3nwdpc0b0g18frx1ydq2w7cghcn4igizgzp5zjr"))))
    (build-system cmake-build-system)
    (arguments
     `(#:configure-flags
       (list
				)
			 #:tests? #f
			 #:phases
			 (modify-phases %standard-phases
											(delete 'install))
))
			 
    (native-inputs
     (list
			pkg-config
			opencv))
    (synopsis "Headtracking paperprint plugin")
    (description "opentrack is an application dedicated to tracking user's head movements and relaying the information to games and flight simulation software.")
    (home-page "https://github.com/opentrack/opentrack")
    (license license:isc)))


opentrack
