# nomad-example-stack

We need CNI plugins

```sh
sh scripts/install.sh
```

Install the Nomad and Consul binaries and spin up agents using

```sh
sudo nomad agent -dev-connect -bind 127.0.0.1 -log-level WARN
```

and in a separate terminal

```sh
consul -dev -log-level WARN
```

Run the manifest using

```sh
nomad run manifest/whoami.hcl
nomad run manifest/traefik.hcl
```

The nomad UI is available on [localhost:4646](http://localhost:4646/ui/) and the
consul one is at [localhost:8500](http://localhost:8500/ui/dc1/).

(Not confirmed to be working)

Exec into auth docker container and run

```sh
apk add curl
curl ${WHOAMI_URL}
```
