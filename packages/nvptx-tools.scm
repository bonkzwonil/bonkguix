(use-modules (guix packages)
 (guix git-download)
 (guix licenses)
(gnu)
(gnu packages)
 (guix build-system gnu)
 (gnu packages perl)
(gnu packages commencement))
(package
  (name "nvptx-tools")
  (version "a0c1fff6534a4df9fb17937c3c4a4b1071212029")
  (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/SourceryTools/nvptx-tools.git")
                  (commit version)))
            (file-name (git-file-name name version))
		(sha256
		 (base32                                                          
                "1gcf3hq9a5yv34fkg2s41j5z3l6c91lvz0mdhp77c60gqm5lgr6f")
		)))
  (build-system gnu-build-system)
(arguments
 `(#:tests? #f))
  (native-inputs (list gcc-toolchain perl))
  (synopsis "Tools for NVPTX GCC toolchains")
  (description "Assembler and linker for NVPTX.")
  (home-page "https://github.com/SourceryTools/nvptx-tools")
  (license gpl3+))

