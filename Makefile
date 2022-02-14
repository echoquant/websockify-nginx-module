stock:
	docker build -t nginx-wsproxy .

.PHONY: openresty
openresty:
	docker build -f Dockerfile.openresty -t openresty-wsproxy .

.PHONY: push
push:
	docker tag openresty-wsproxy:latest soylentio/openresty-wsproxy:latest
	docker push soylentio/openresty-wsproxy:latest
