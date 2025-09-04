;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2015 Sou Bunnbu <iyzsong@gmail.com>
;;; Copyright © 2016, 2023 Efraim Flashner <efraim@flashner.co.il>
;;; Copyright © 2017 Nikita <nikita@n0.is>
;;; Copyright © 2019 Tobias Geerinckx-Rice <me@tobias.gr>
;;;
;;; This file is part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (bonk packages fvwm3)
  #:use-module ((guix licenses) #:select (gpl2+))
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system meson)
  #:use-module (gnu packages fribidi)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages python)
  #:use-module (gnu packages image)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg))

(define-public fvwm3
  (package
    (name "fvwm3")
    (version "1.1.3")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://github.com/fvwmorg/fvwm3/releases/download/"
                    version "/fvwm3-" version ".tar.gz"))
              (sha256
               (base32
                "1rax1h0s00vz5ffhnrvgnr6qk557qclf7zcy9szgvm1ardzbyxrk"))))
    (build-system meson-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (add-after 'install 'install-xsession
           (lambda* (#:key outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
                    (xsessions (string-append out "/share/xsessions")))
               (mkdir-p xsessions)
               (make-desktop-entry-file
                 (string-append xsessions "/fvwm3.desktop")
                 #:name "FVWM3"
                 #:exec (string-append out "/bin/" ,name)
                 #:comment '("FVWM3")))
             #t)))))
    (native-inputs
     `(("perl" ,perl)
       ("pkg-config" ,pkg-config)
       ("cmake" ,cmake)
       ("python" ,python)
       ("xsltproc" ,libxslt)))
    (inputs
     (list fribidi
	xtrans
	libxt
	freetype
	libxrandr
	libxkbcommon
	libevent
           libpng
           (librsvg-for-system)
           libxcursor
           libxext
           libxft
           libxinerama
           libxpm
           libxt
           readline))
    (synopsis "Virtual window manager for X11")
    (description
     "FVWM is an extremely powerful ICCCM-compliant multiple virtual desktop
window manager for the X Window system.")
    (home-page "https://www.fvwm.org/")
    (license gpl2+)))


fvwm3
