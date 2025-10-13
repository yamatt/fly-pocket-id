# Pocket ID on Fly.io

Hosts Pocket ID on Fly.io

## Setup

You need a fly.io account and the fly CLI installed, then run:

```sh
fly deploy --app app-name
```

### Secrets

You will want to set some secrets on the app in fly.io

- `APP_URL` the URL where this will run. i.e.: `https://auth.example.com`
- `ENCRYPTION_KEY` a random string used to encrypt the data. Store a copy somewhere secure.
