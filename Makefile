stock:
	docker build -t nginx-wsproxy .

.PHONY: openresty
openresty:
	docker build -f Dockerfile.openresty -t openresty-wsproxy .
