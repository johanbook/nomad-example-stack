# nomad-poc

Install the nomad binary and spin up an agent using

```sh
sudo nomad agent -dev -bind 127.0.0.1 -log-level INFO
```

Run the manifest using

```sh
nomad run manifest/whoami.nomad
```
