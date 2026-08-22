FROM ghcr.io/pocket-id/pocket-id@sha256:01540977dcf4c7b41b1159f34d68e4632f2658d62790e460ca65a42722b13c4a AS pocket-id
FROM litestream/litestream@sha256:0cfd95cc2d38f5bfe4cbba8060d9605d02f98ddea8bdb61c8e605e8d0159523a AS litestream

FROM gcr.io/distroless/static@sha256:9197324ba51d9cd071af8505989365c006adf9d6d2067eada25aef00abbb5278

WORKDIR /app

COPY --from=pocket-id /app /app
COPY --from=litestream /usr/local/bin/litestream /usr/local/bin/litestream

# Stick to UID 1000 to match your Fly volume permissions perfectly
USER 1000

# Let Litestream supervise the Pocket ID binary
ENTRYPOINT ["litestream", "replicate"]