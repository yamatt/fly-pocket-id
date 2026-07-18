FROM ghcr.io/pocket-id/pocket-id@sha256:b7c37ab3044e53fd29b5f7295eebff5fdc0367dc043f36b41bcbe1815fcd965d AS pocket-id
FROM litestream/litestream@sha256:83f04e91edc7980095d03de58f1cca3697e1138a60e466eb11e4dcd4d5effbfa AS litestream

FROM gcr.io/distroless/static@sha256:d5f030ca7c5793784e9ea4178a116da360250411d13921a5af27c6cb5a5949bf

WORKDIR /app

COPY --from=pocket-id /app /app
COPY --from=litestream /usr/local/bin/litestream /usr/local/bin/litestream

# Stick to UID 1000 to match your Fly volume permissions perfectly
USER 1000

# Let Litestream supervise the Pocket ID binary
ENTRYPOINT ["litestream", "replicate"]