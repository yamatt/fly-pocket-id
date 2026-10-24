FROM ghcr.io/pocket-id/pocket-id@sha256:f085157f0b6ea4b2e8aa5ecfd99eada0d83a4960f3a3dcfd46014097d0ef7ab5 AS pocket-id
FROM litestream/litestream@sha256:f757c70d070ac278d45b8847d31a54ab2de24de5e77b09018c642eca263e3967 AS litestream

FROM gcr.io/distroless/static@sha256:15f8637509792e05b97d83451b0b6ccfa4abd548f997e406ac1e72c87fe1fa78

WORKDIR /app

COPY --from=pocket-id /app /app
COPY --from=litestream /usr/local/bin/litestream /usr/local/bin/litestream

# Stick to UID 1000 to match your Fly volume permissions perfectly
USER 1000

# Let Litestream supervise the Pocket ID binary
ENTRYPOINT ["litestream", "replicate"]