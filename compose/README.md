# Run with docker compose

```
docker-compose up -d
```

## Customize port

```
echo WS_RTSP_PORT=<port> > ./.env
docker-compose up -d
```

## WS TCP proxy access

When docker container will start proxy will be available at:

```
http://<server_ip>:<custom_port|8844>/websockify?host=<dsthost>&port=<dstport>
```
