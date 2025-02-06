#!/bin/bash

set -eu

# Either to build against to-be-released heudiconv
dev_build=

generate() {
	if [ "$dev_build" = "1" ]; then
		apt_pkgs=python3-pip
		run_cmd="pip install git+https://github.com/ReproNim/segstats_jsonld@master"
	else
		apt_pkgs=""
		run_cmd=":"
	fi
	# more details might come on https://github.com/ReproNim/neurodocker/issues/330
	[ "$1" == singularity ] && add_entry=' "$@"' || add_entry=''
	#neurodocker generate "$1" \
	ndversion=1.0.1
	#ndversion=master
	${OCI_BINARY:-docker} run --rm repronim/neurodocker:$ndversion generate "$1" \
		--base-image=neurodebian:bookworm \
		--ndfreeze date=20241114 \
		--pkg-manager=apt \
		--install vim wget strace time ncdu gnupg curl procps datalad pigz less tree \
				  git-annex python3-nibabel \
				  python3-venv visidata $apt_pkgs \
		--run "$run_cmd" \
		--run "apt-get update && apt-get -y dist-upgrade" \
		--user=reproin
}

generate docker > Dockerfile
generate singularity > Singularity
