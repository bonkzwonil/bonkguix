(define-module (gcc-nvptx)
  #:use-module (guix packages)
  #:use-module (nongnu packages)
  #:use-module (guix download)
  #:use-module (guix-science-nonfree packages cuda)
  #:use-module (gnu packages multiprecision)
  #:use-module (guix build-system gnu)
  #:use-module (gnu)
  #:use-module (guix git-download)
  #:use-module  (guix licenses)
  #:use-module (gnu packages)
  #:use-module  (guix build-system gnu)
  #:use-module  (gnu packages perl)
  #:use-module (gnu packages commencement)
  #:use-module (guix-science-nonfree packages cuda)
  #:use-module (gnu packages gcc)
  #:use-module (nongnu packages nvidia))


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
    `(#:tests? #f))
   (native-inputs (list gcc-toolchain perl))
   (synopsis "Tools for NVPTX GCC toolchains")
   (description "Assembler and linker for NVPTX.")
   (home-page "https://github.com/SourceryTools/nvptx-tools")
   (license gpl3+))                   )



(define-public gcc-nvptx
  (package
   (inherit gcc)
   (name "gcc-nvptx")
   (version "14.3.0")
   (arguments
    `(#:configure-flags
      (list
       (string-append "--prefix=" (assoc-ref %outputs "out"))
       ;(string-append "--with-sysroot=" (assoc-ref %outputs "out"))
(string-append "--with-native-system-header-dir=" (assoc-ref %build-inputs "gcc") "/include")
      (string-append "--enable-offload-targets=nvptx-none=" (assoc-ref %build-inputs "nvptx-tools" ) "/nvptx-none")
(string-append "--with-cuda-driver=" (assoc-ref %build-inputs "cuda") )
"--disable-sjlj-exceptions" "--enable-newlib-io-long-long"
       "--enable-languages=c,fortran"
(string-append "--with-gmp=" (assoc-ref %build-inputs "gmp"))
(string-append "--with-mpc=" (assoc-ref %build-inputs "mpc"))
(string-append "--with-mpfr=" (assoc-ref %build-inputs "mpfr"))
       "--disable-multilib"
       )))
   (inputs
    `(("cuda" ,cuda-toolkit)
      ("nvptx-tools" ,nvptx-tools)))
   (native-inputs `(
                    ("gmp" ,gmp)
                    ("gcc" ,gcc-toolchain)
    ("cuda" ,cuda-toolkit)
      ("nvptx-tools" ,nvptx-tools)
                    ("mpfr" ,mpfr)
                    ("mpc" ,mpc)
                    ))))
gcc-nvptx
