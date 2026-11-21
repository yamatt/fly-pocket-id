# pocket-id v2.19.2
FROM ghcr.io/pocket-id/pocket-id@sha256:189e03bb73bb86d7108fe81cbe2237c408cff2176b14cd7a39cc12a2ee8b2762 AS pocket-id
# litestream v0.5.17-scratch
FROM litestream/litestream@sha256:0ba1cdbb2d0be8876e27b1e646dc031309b7e3928e0ed91503ebaa73ff7e2c5d AS litestream

FROM gcr.io/distroless/static@sha256:1a64f46364620465ef9e9a8f5413757dfdf22695e050bbfd7303eeaf17a59383

WORKDIR /app

COPY --from=pocket-id /app /app
COPY --from=litestream /usr/local/bin/litestream /usr/local/bin/litestream

# Stick to UID 1000 to match your Fly volume permissions perfectly
USER 1000

# Let Litestream supervise the Pocket ID binary
ENTRYPOINT ["litestream", "replicate"]