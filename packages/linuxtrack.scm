(define-module (linuxtrack)
  #:use-module (gnu packages)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages elf)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages image)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages graphics)
  #:use-module (gnu packages photo)
  #:use-module (gnu packages protobuf)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages video)
  #:use-module (gnu packages vulkan)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages qt)
  #:use-module (nongnu packages nvidia)
  #:use-module (gnu packages xorg)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix hg-download)
  #:use-module (guix packages)
  #:use-module (guix build-system gnu)
	#:use-module (gnu packages image-processing)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system meson)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system python)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (ice-9 match)
  #:use-module ((srfi srfi-1) #:hide (zip)))



(define-public opencv-2
  (package
    (name "opencv")
    (version "2.4.13.5")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/opencv/opencv")
                    (commit version)))
              (file-name (git-file-name name version))
              (modules '((guix build utils)))
              (sha256
               (base32
                "1sqqzgfb27blsdincrkcvpc3x7niin60nc0kvigb7w2d60fk6dda"))))
    (build-system cmake-build-system)
    (arguments
     `(#:configure-flags
       (list "-DWITH_ADE=OFF"           ;we don't have a package for ade yet
             "-DWITH_IPP=OFF"
             "-DWITH_ITT=OFF"
             "-DWITH_CAROTENE=OFF"      ; only visible on arm/aarch64
             "-DENABLE_PRECOMPILED_HEADERS=OFF"
             "-DOPENCV_GENERATE_PKGCONFIG=ON"
             "-DCPU_BASELINE=SSE2"

             ;; Build Python bindings.
             "-DBUILD_opencv_python3=ON"


             ;; Is ON by default and would try to rebuild 3rd-party protobuf,
             ;; which we had removed, which would lead to an error:
             "-DBUILD_PROTOBUF=OFF"

             ;; Rebuild protobuf files, because we have a slightly different
             ;; version than the included one. If we would not update, we
             ;; would get a compile error later:
             "-DPROTOBUF_UPDATE_FILES=ON"

             ;; xfeatures2d disabled, because it downloads extra binaries from
             ;; https://github.com/opencv/opencv_3rdparty
             ;; defined in xfeatures2d/cmake/download_{vgg|bootdesc}.cmake
             ;; Cmp this bug entry:
             ;; https://github.com/opencv/opencv_contrib/issues/1131
             "-DBUILD_opencv_xfeatures2d=OFF")))
			 
    (native-inputs
     `(("pkg-config" ,pkg-config)
			 ("xorg-server" ,xorg-server-for-tests))) ;For running the tests
			 
		 
    (inputs
     (list ffmpeg-4
           gtk+
			
           gtkglext
           hdf5
           ilmbase
           imath                        ;should be propagated by openexr
           jasper
           libgphoto2
           libjpeg-turbo
           libpng
           libtiff
           libwebp
           openblas
           openexr
           openjpeg
           protobuf
           python
           python-numpy
           vtk
           zlib))
    (synopsis "Computer vision library")
    (description "OpenCV is a library aimed at real-time computer vision,
including several hundred computer vision algorithms.  It can be used to do
things like:

@itemize
@item image and video input and output
@item image and video processing
@item displaying
@item feature recognition
@item segmentation
@item facial recognition
@item stereo vision
@item structure from motion
@item augmented reality
@item machine learning
@end itemize\n

This package includes the Python bindings for OpenCV, which are also known as
the OpenCV-Python library.")
    (home-page "https://opencv.org/")
    (license license:bsd-3)))


(define-public linuxtrack-binary
	(package
    (name "linuxtrack")
    (version "0.99.18")
		(source (origin
							(method url-fetch)
							(uri (string-append "http://linuxtrack.eu/repositories/universal/linuxtrack-" version "-64.zip"))
						 (sha256 (base32 "0wzi85c9wwvqlbwbvyha48sfbjfazabcagxr63y92g6hsxm9h4cz"))))
		(build-system copy-build-system)
		(arguments
		 '(#:install-plan '(("caddy" "bin/caddy"))))
		(native-inputs
		 (list
			unzip
			bison
			libxml2
			minixml
			pkg-config
			nvidia-driver))
		(home-page "https://forums.developer.nvidia.com")
    (synopsis "Linuxtrack is a project aiming to bring head tracking to Linux and Mac.")
    (description "Linuxtrack is a project aiming to bring head tracking to Linux and Mac.")
    (license license:expat)))
	

(define-public linuxtrack
  (package
    (name "linuxtrack")
    (version "0.99.18")
		(source (origin
						 (method url-fetch)
						 (uri (string-append "http://linuxtrack.eu/repositories/universal/linuxtrack-" version ".tar.bz2"))
						 (sha256 (base32 "1xc5rczyq4515481zfd6n5l57smn94jikmbwdpkap9267krff4k9"))))
		(build-system gnu-build-system)
		(native-inputs
		 (list
			bison
			libxml2
			minixml
			opencv-2
			pkg-config
			nvidia-driver))
    (home-page "https://forums.developer.nvidia.com")
    (synopsis "Linuxtrack is a project aiming to bring head tracking to Linux and Mac.")
    (description "Linuxtrack is a project aiming to bring head tracking to Linux and Mac.")
    (license license:expat)))

linuxtrack-binary

		
