FROM ghcr.io/pocket-id/pocket-id@sha256:a2a38a96699d7483d65b5849b015d954f294938306a03a9c0699bc5b79554e86 AS pocket-id
FROM litestream/litestream@sha256:c41e086a58f7290531c7f52e9602f3bf74f9fc6459d63c47086752255e4d8ace AS litestream

FROM gcr.io/distroless/static@sha256:3592aa8171c77482f62bbc4164e6a2d141c6122554ace66e5cc910cadb961ff0

WORKDIR /app

COPY --from=pocket-id /app /app
COPY --from=litestream /usr/local/bin/litestream /usr/local/bin/litestream

# Stick to UID 1000 to match your Fly volume permissions perfectly
USER 1000

# Let Litestream supervise the Pocket ID binary
ENTRYPOINT ["litestream", "replicate"]