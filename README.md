# nomad-example-stack

Install the Nomad and Consul binaries and spin up agents using

```sh
sudo nomad agent -dev -bind 127.0.0.1 -log-level WARN
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
