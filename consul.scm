;; Nomad binary package manifest
(define-module (consul)
	       #:use-module (gnu packages)

	       #:use-module (nonguix build-system  binary)
  #:use-module (guix packages)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages gcc)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix licenses:)
	#:use-module (gnu services configuration)
	#:use-module (guix records)
	#:use-module (guix gexp)
	#:use-module (gnu services)
	#:use-module  (gnu services shepherd)
	#:export (consul-hc consul-configuration consul-shepherd-service consul-service-type))

(define-public consul
  (package
    (name "consul")
    (version "1.19.0")
    (source (origin
             (method url-fetch)
             (uri (string-append "https://releases.hashicorp.com/consul/"
																 version "/consul_" version "_linux_amd64.zip"))
             (sha256
              (base32 "07slhsz7yh8fihn9i8ijy0kwig5qdrhsg13s2ymppz4m4ahzndz3"))))
    (build-system binary-build-system)
    (supported-systems '("x86_64-linux"))
    (arguments
     `(
			 #:strip-binaries? #f
			 #:patchelf-plan #f
			 #:install-plan '(("consul" "bin/"))))
			 
		(inputs
		 `(("unzip" ,unzip) ("gcc:lib" ,gcc "lib")))
    (synopsis "Consul")
    (description "Consul")
    (home-page "https://nomadproject.io")
    (license licenses:expat)))



(define-configuration/no-serialization consul-configuration
	(foo (string "bar") "baz"))

(define consul-shepherd-service
	(match-record-lambda
	 <consul-configuration>
	 (foo)
	 (list
		(shepherd-service
		 (documentation "Run the consul server/client in dev mode")
		 (provision '(consul))
		 (start #~(make-forkexec-constructor
							 (list #$(file-append consul "/bin/consul") "agent" "-dev")))
		 (stop #~(make-kill-destructor)))))) 


(define consul-service-type
	(service-type
	 (name 'consul)
	 (extensions
		(list (service-extension shepherd-root-service-type
														 consul-shepherd-service)))
	 (description "Run consul in dev mode as shepherd")))


