(define-public my-motif
  ;; replacement for default motif which lacks xsessions file creation
  (let ((commit "0f556b0873c72ba1152a12fd54c3198ee039e413")
        (revision "1"))
    (package
      (name "motif")
      (version (git-version "2.3.8" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://git.code.sf.net/p/motif/code")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32
           "1g28i4978p9dpcdxv2yx4m17bchdypm3yy6m6gzchdlrv2iklhl9"))))
      (build-system gnu-build-system)
      (arguments
       `(#:phases
	 (modify-phases %standard-phases
			(add-after 'install 'install-xsession
				   (lambda* (#:key outputs #:allow-other-keys)
					    (let* ((out (assoc-ref outputs "out"))
						   (xsessions (string-append out "/share/xsessions")))
					      (mkdir-p xsessions)
					      (make-desktop-entry-file
					       (string-append xsessions "/motif.desktop")
					       #:name "Motif"
					       #:exec (string-append out "/bin/mwm")
					       #:comment '("Motif")))
					    #t)))))
      (inputs
       (list libx11 xorgproto))
      (propagated-inputs
       (list fontconfig freetype libxext libxft libxpm libxt xbitmaps))
      (native-inputs
       ;; This fails to build with GCC 14 due to missing header includes and
       ;; other C semantics issues.
       (list gcc-11
             autoconf
             automake
             byacc
             flex
             libtool
             pkg-config))
      (home-page "https://motif.ics.com/motif")
      (synopsis "Toolkit for the X window system")
      (description "Motif is a standard graphical user interface, (as defined
by the IEEE 1295 specification), used on more than 200 hardware and software
platforms.  It provides application developers, end users, and system vendors
with a widely used environment for standardizing application presentation on a
wide range of platforms.")
      (license license:lgpl2.1+))))
