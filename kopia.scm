(define-module (gnu packages sync)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system go)
  #:use-module (guix build-system meson)
  #:use-module (guix build-system qt)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (gnu packages)
  #:use-module (gnu packages acl)
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


(define-public kopia
  (package
    (name "kopia")
    (version "0.17.0")
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
        (base32 "1fbckdw84mccj8sxssdp5wr6zxd8mafqfwr8r2fh8ligamwbvb06"))))
		(build-system go-build-system)
    (synopsis "kopia")
    (description "kopia")
    (home-page "https://kopia")
    (license license:expat)))