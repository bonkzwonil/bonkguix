(define-module (glmark2)
  #:use-module (gnu packages)
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
  #:use-module (nongnu packages nvidia)
  #:use-module (gnu packages xorg)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix hg-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system meson)
  #:use-module (guix build-system python)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (ice-9 match)
  #:use-module ((srfi srfi-1) #:hide (zip)))

(define-public glmark2
  (package
    (name "glmark2")
    (version "2021.12")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/glmark2/glmark2")
                    (commit version)))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1aydqbrg9i74s19rrdrsscx94m885yvc43v3sdqlgyh675ms98jb"))))
    (build-system meson-build-system)
    (arguments
     '(#:tests? #f                      ; no check target
       #:configure-flags
       (list (string-append "-Dflavors="
                            (string-join '("x11-gl" "x11-glesv2"
                                           "drm-gl" "drm-glesv2"
                                           "wayland-gl" "wayland-glesv2")
                                         ",")))
       #:phases
       (modify-phases %standard-phases
				 (delete 'validate-runpath)
         (add-after 'unpack 'patch-paths
           (lambda* (#:key inputs #:allow-other-keys)
             (let ((nvidia (assoc-ref inputs "nvda")))
               (substitute* (find-files "src" "gl-state-.*\\.cpp$")
                 (("libGL.so") (string-append nvidia "/lib/libGL.so"))
                 (("libEGL.so") (string-append nvidia "/lib/libEGL.so"))
                 (("libgbm.so.1") (string-append nvidia "/lib/libgbm.so.1"))
                 (("libGLESv2.so") (string-append nvidia "/lib/libGLESv2.so")))
               #t))))))
    (native-inputs
     (list nvda pkg-config))
    (inputs
     (list eudev
           nvda
           libdrm
           libjpeg-turbo
           libpng
           libx11
           libxcb
           wayland
           wayland-protocols))
    (home-page "https://github.com/glmark2/glmark2")
    (synopsis "OpenGL 2.0 and OpenGL ES 2.0 benchmark")
    (description
     "glmark2 is an OpenGL 2.0 and OpenGL ES 2.0 benchmark based on the
original glmark benchmark by Ben Smith.")
    (license license:gpl3+)))
