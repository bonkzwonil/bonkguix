(define-module (gnu packages kopia)
  #:use-module (gnu packages)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix build-system go)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages linux)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages golang)
  #:use-module (ice-9 match)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module ((srfi srfi-1) #:hide (zip)))

(define-public kopia
  (package
    (name "kopia")
    (version "0.21.1")
    (source
     (origin
      (method git-fetch)
      (uri
       (git-reference
        (url "https://github.com/kopia/kopia.git")
         (commit (string-append "v" version))))
       (file-name
        (git-file-name name version))
       (sha256
        (base32 "1zppj7hmnk30hsw7za5x29kq7j8a0p4cl4rhhcmv6svpm0linbyj"))))
    (build-system gnu-build-system)
    (arguments
     '(#:phases (modify-phases %standard-phases
                               (delete 'configure))))
    (inputs `(("go" ,go)))
    (synopsis "kopia")
    (description "kopia backup tool")
    (license license:asl2.0)
    (home-page "https://github.com/kopia/kopia")))

kopia
