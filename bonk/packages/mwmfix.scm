(define-module (bonk packages mwmfix)
  #:use-module (guix)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (guix build-system copy)
  #:use-module (gnu packages lesstif))

(define-public mwmfix
  (package
    (name "mwmfix")
    (version "0.1")
    (source
      (origin
       (method url-fetch)
       (uri "file:///home/bonk/mwm.desktop")
       (sha256 (base32 "07sc3r9imgl5nlgl6mjchf7rg8qlan81nfs7wif65l1vvx5f83a0"))))
    (inputs (list motif))
    (build-system copy-build-system)
    (arguments  (list #:install-plan
                      #~(list
                       '("mwm.desktop" "share/xsessions/"))
                      ))
    (home-page "")
    (synopsis "MWM.desktop fixer")
    (description "Fixed nonexistant mwm.desktop file")
    (license license:gpl3+)))

;; This allows you to run guix shell -f guix-packager.scm.
;; Remove this line if you just want to define a package.
mwmfix
