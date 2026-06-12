FROM ghcr.io/pocket-id/pocket-id@sha256:6a3aad6023ea0729e3763c75b77060d6d5d9069ad566af0b0b14a2288da0c9e0 AS pocket-id
FROM litestream/litestream@sha256:c41e086a58f7290531c7f52e9602f3bf74f9fc6459d63c47086752255e4d8ace AS litestream

FROM gcr.io/distroless/static@sha256:dfadf31470f770fcabd48903762dce126958e98d1ce320acf1216bbfaa42d79c

WORKDIR /app

COPY --from=pocket-id /app /app
COPY --from=litestream /usr/local/bin/litestream /usr/local/bin/litestream

# Copy your local Litestream configuration file
COPY config/litestream.yml /etc/litestream.yml

# Stick to UID 1000 to match your Fly volume permissions perfectly
USER 1000

# Let Litestream supervise the Pocket ID binary
ENTRYPOINT ["litestream", "replicate"]