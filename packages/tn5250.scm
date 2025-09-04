(define-module (packages tn5250)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system gnu)
  #:use-module (guix gexp)
  #:use-module (gnu packages m4)
  #:use-module (guix utils)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (gnu packages)
  #:use-module (gnu packages acl)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages adns)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages crypto)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages dlang)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages graphviz)
  #:use-module (gnu packages image)
  #:use-module (gnu packages kde-frameworks)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages lua)
  #:use-module (gnu packages ocaml)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages rsync)
  #:use-module (gnu packages ruby)
  #:use-module (gnu packages selinux)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages sphinx)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages tls))

(define-public tn5250
  (package
    (name "tn5250")
    (version "0.18.0")
    (source
                 (origin
      (method git-fetch)
      (uri
       (git-reference
        (url "https://github.com/tn5250/tn5250.git")
         (commit (string-append "v" version))))
       (file-name
        (git-file-name name version))
       (sha256
        (base32 "0b7y0ic4zrw0ild1hl0ba96fqpff95r7513qpj4p62bq6cjf79q9"))))


    (build-system gnu-build-system)
    (arguments '(#:configure-flags (list (string-append "--with-ssl=" (assoc-ref %build-inputs "openssl")))))
    (inputs
     (list openssl autoconf automake m4 libtool ncurses))
    (native-inputs
     (list
      openssl
      ncurses
      pkg-config
      ))

    (synopsis "tn5250")
    (description "tn5250")
    (home-page "https://github.com/tn5250/tn5250")
    (license license:lgpl2.1)))
