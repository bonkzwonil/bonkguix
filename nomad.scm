;; Nomad binary package manifest
;; Nomad binary package manifest
(define-module (nomad)
  #:use-module (guix packages)
  #:use-module (gnu packages)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages gcc)
	#:use-module (gnu services)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix licenses:)
	#:use-module (gnu services configuration)
	#:use-module (guix records)
	#:use-module (guix gexp)
	#:use-module (gnu services shepherd)
	#:use-module (nonguix build-system  binary)
	#:export (nomad-hc nomad-configuration nomad-shepherd-service nomad-service-type))



(define-public nomad-hc
  (package
    (name "nomad-hc")
    (version "1.8.0")
    (source (origin
             (method url-fetch)
             (uri (string-append "https://releases.hashicorp.com/nomad/"
																 version "/nomad_" version "_linux_amd64.zip"))
             (sha256
              (base32 "1wj738qrz8ygahwymp2dscdxhbbwzm9zxjrcc66h93wj7a5mg8q7"))))
    (build-system binary-build-system)
    (supported-systems '("x86_64-linux"))
    (arguments
     `(
			 #:strip-binaries? #f
			 #:patchelf-plan (list (list "nomad" '( "gcc:lib")))
			 #:install-plan '(("nomad" "bin/"))))
			 
		(inputs 
		 `(("unzip" ,unzip) ("gcc:lib" ,gcc "lib")))
    (synopsis "Nomad")
    (description "Nomad is simple and flexible scheduler and orchestrator to deploy and manage containers and non-containerized applications across on-premises and clouds at scale. A lightweight alternative to k8s")
    (home-page "https://nomadproject.io")
    (license licenses:mpl2.0)))

(define-configuration/no-serialization nomad-configuration
	(foo (string "bar") "baz"))

(define nomad-shepherd-service
	(match-record-lambda
	 <nomad-configuration>
	 (foo)
	 (list
		(shepherd-service
		 (documentation "Run the nomad server/client in dev mode")
		 (provision '(nomad))
		 (start #~(make-forkexec-constructor
							 (list #$(file-append nomad-hc "/bin/nomad") "agent" "-dev")))
		 (stop #~(make-kill-destructor))))))


(define nomad-service-type
	(service-type
	 (name 'nomad)
	 (extensions
		(list (service-extension shepherd-root-service-type
														 nomad-shepherd-service)))
	 (description "Run nomad in dev mode as shepherd")))





