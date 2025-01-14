_DOCKER_ ?= docker

build_all:  build_base build_annotation build_users build_convert build_jobs build_keycloak build_assets build_web  build_processing build_pipelines build_models build_taxonomy clean

build_base: 
	mkdir -p build_dir
	cp -r lib/ build_dir/lib
	cp infra/docker/python_base/Dockerfile build_dir 
	${_DOCKER_} build --target base build_dir/ -t 818863528939.dkr.ecr.eu-central-1.amazonaws.com/badgerdoc/python_base:0.1.7

build_keycloak:
	mkdir -p build_dir
	git clone https://github.com/keycloak/keycloak-containers.git build_dir/keycloak
	cd build_dir/keycloak; git checkout 15.1.1
	${_DOCKER_} build build_dir/keycloak/server -t badgerdoc_keycloak

build_annotation:
	${_DOCKER_} build --target build annotation/ -t badgerdoc_annotation

build_users:
	${_DOCKER_} build --target build users/ -t badgerdoc_users

build_convert:
	${_DOCKER_} build --target build convert/ -t badgerdoc_convert

build_processing:
	${_DOCKER_} build --target build processing/ -t badgerdoc_processing

build_jobs:
	${_DOCKER_} build --target build jobs/ -t badgerdoc_jobs

build_assets:
	${_DOCKER_} build --target build assets/ -t badgerdoc_assets

build_web:
	${_DOCKER_} build --target build web/ -t badgerdoc_web

build_pipelines:
	${_DOCKER_} build --target build pipelines/ -t badgerdoc_pipelines

build_models:
	${_DOCKER_} build --target build models/ -t badgerdoc_models

build_taxonomy:
	${_DOCKER_} build --target build taxonomy/ -t badgerdoc_taxonomy

clean:
	rm -rf build_dir