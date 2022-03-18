LOCATION ?= .cn
host_arch= $(shell uname -m)
ARCH?=$(host_arch)

IMAGE_SUFFIX=
ifeq ($(ARCH),aarch64)
	IMAGE_SUFFIX="-arm64v8"
endif

ifeq ($(LOCATION), .cn)
	APK_MIRROR = https://mirrors.tuna.tsinghua.edu.cn/alpine/v3.11
	APK_ADD_ARGS = --repositories-file /dev/null --repository ${APK_MIRROR}/main --repository ${APK_MIRROR}/community
	APT_ARGS = -o Dir::Etc::sourcelist=/etc/apt/sources.list.cn
	GITHUBUSERCONTENT_IP = 151.101.8.133
	GRPC_BINARY_SITE = https://npm.taobao.org/mirrors/
	SASS_BINARY_SITE = https://npm.taobao.org/mirrors/node-sass/
	NPM_REGISTRY = https://registry.npm.taobao.org
	NPM_INSTALL_ARGS = --registry=${NPM_REGISTRY} --sass-binary-site=${SASS_BINARY_SITE} --grpc-node-binary-host-mirror=${GRPC_BINARY_SITE}
	PIP_ARGS = -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
	YARN_ENV = SASS_BINARY_SITE="${SASS_BINARY_SITE}"
	DOCKER_BUILD_OPTS += \
	--build-arg LOCATION="${LOCATION}" \
	--build-arg APK_ADD_ARGS="${APK_ADD_ARGS}" \
	--build-arg APT_ARGS="${APT_ARGS}" \
	--build-arg GITHUBUSERCONTENT_IP="${GITHUBUSERCONTENT_IP}" \
	--build-arg NPM_INSTALL_ARGS="${NPM_INSTALL_ARGS}" \
	--build-arg NPM_REGISTRY="${NPM_REGISTRY}" \
	--build-arg PIP_ARGS="${PIP_ARGS}" \
	--build-arg YARN_ENV="${YARN_ENV}"
endif

stock:
	docker build -t nginx-wsproxy .

.PHONY: openresty
openresty:
	docker build  ${DOCKER_BUILD_OPTS} \
		-f Dockerfile.openresty${LOCATION} -t openresty-wsproxy .

.PHONY: push
push:
	docker tag openresty-wsproxy:latest soylentio/openresty-wsproxy${IMAGE_SUFFIX}:latest
	docker push soylentio/openresty-wsproxy${IMAGE_SUFFIX}:latest
