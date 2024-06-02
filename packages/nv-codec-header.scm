(define-module (guix-packager)
  #:use-module (guix)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages))

(define-public nv-codec-headers
  (package
    (name "nv-codec-headers")
    (version "n12.1.14.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
              (url "https://git.videolan.org/git/ffmpeg/nv-codec-headers.git")
              (commit "")))
        (file-name (git-file-name name version))
        (sha256 (base32 "1759rrv8nbar313wdapx3z5lsjb6rwnsaawlfwvhb4l5daz7gcbx"))))
    (build-system gnu-build-system)
	  (arguments
		  '(#:phases 
		    (modify-phases %standard-phases
				   (delete 'configure)
(add-before 'build 'set-prefix-in-makefile
                    (lambda* (#:key outputs #:allow-other-keys)
                      ;; Modify the makefile so that its
                      ;; 'PREFIX' variable points to "out".
                      (let ((out (assoc-ref outputs "out")))
                        (substitute* "Makefile"
                          (("PREFIX =.*")
                           (string-append "PREFIX = "
                                          out "\n"))))))

				   (delete 'check))))
    (home-page "https://git.videolan.org/git/ffmpeg/nv-codec-headers.git")
    (synopsis "NV codec")
    (description "yo")
    (license license:gpl3+)))

;; This allows you to run guix shell -f example.scm.
;; Remove this line if you just want to define a package.
nv-codec-headers
