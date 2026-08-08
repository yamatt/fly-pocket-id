FROM ghcr.io/pocket-id/pocket-id@sha256:b7c37ab3044e53fd29b5f7295eebff5fdc0367dc043f36b41bcbe1815fcd965d AS pocket-id
FROM litestream/litestream@sha256:0cfd95cc2d38f5bfe4cbba8060d9605d02f98ddea8bdb61c8e605e8d0159523a AS litestream

FROM gcr.io/distroless/static@sha256:9197324ba51d9cd071af8505989365c006adf9d6d2067eada25aef00abbb5278

WORKDIR /app

COPY --from=pocket-id /app /app
COPY --from=litestream /usr/local/bin/litestream /usr/local/bin/litestream

# Stick to UID 1000 to match your Fly volume permissions perfectly
USER 1000

# Let Litestream supervise the Pocket ID binary
ENTRYPOINT ["litestream", "replicate"]