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
	#:use-module (nonguix build-system binary)
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


(define (nomad-config->file config)
	(mixed-text-file "nomad-config.hcl"
									 "
# Nomad Config for Seybold Single VM dev setup

server {
	enabled = true
	bootstrap_expect = 1  # single VM for now.  should be n=3 for production cluster
	encrypt = \"KEY HERE=\"
}

client {
	enabled = true

	# Persistent Host Volumes
	servers = [\"127.0.0.1:4647\"]
}

advertise {
  # Defaults to the first private IP address.
  http = \"127.0.0.1\"
  rpc  = \"127.0.0.1\"
  serf = \"127.0.0.1\"
}

datacenter = \"dc1\"
data_dir = \"" (nomad-configuration-datadir config) "\"
name =  \"" (nomad-configuration-name config) "\"
#bind_addr = \"127.0.0.1\"



plugin \"docker\" {
  config {
    auth {
      #config = \"/opt/etc/docker-ghcr.json\"
    }
  }
}
"))

(define-configuration/no-serialization nomad-configuration
	(name (string "Nomad Server") "Name of server/client")
	
	(datadir (string "/opt/nomad") "datadir"))

(define (nomad-shepherd-service config)
	(list
	 (shepherd-service
		(documentation "Run the nomad server/client in dev mode")
		(provision '(nomad))
		(requirement '(networking))
		(start #~(make-forkexec-constructor
							(list #$(file-append nomad-hc "/bin/nomad") "agent" "-config=" (nomad-configuration->file config))))
		(stop #~(make-kill-destructor)))))


(define nomad-service-type
	(service-type
	 (name 'nomad)
	 (extensions
		(list (service-extension shepherd-root-service-type
														 nomad-shepherd-service)))
	 (default-value (nomad-configuration))
	 (description "Run nomad in dev mode as shepherd")))





