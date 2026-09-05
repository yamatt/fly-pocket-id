FROM ghcr.io/pocket-id/pocket-id@sha256:01540977dcf4c7b41b1159f34d68e4632f2658d62790e460ca65a42722b13c4a AS pocket-id
FROM litestream/litestream@sha256:f757c70d070ac278d45b8847d31a54ab2de24de5e77b09018c642eca263e3967 AS litestream

FROM gcr.io/distroless/static@sha256:f2ea2709ac8db56323cbd7d014277f32cb572d9ea124b0076f7aafe5980678fe

WORKDIR /app

COPY --from=pocket-id /app /app
COPY --from=litestream /usr/local/bin/litestream /usr/local/bin/litestream

# Stick to UID 1000 to match your Fly volume permissions perfectly
USER 1000

# Let Litestream supervise the Pocket ID binary
ENTRYPOINT ["litestream", "replicate"]