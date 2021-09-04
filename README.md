# nomad-example-stack

This is an example stack using Nomad as a scheduler, Consul as service mesh and
Envoy as sidecar proxies. The stack is managed using Terraform.

## Installing

First off, install the binaries for Nomad, Consul and Terraform and make sure
they are available in your path.

In order to run the jobs in bridged mode (which is required for Consul Connect),
we need some CNI plugins which can be installed using the following script

```sh
sh scripts/install.sh
```

Finally, we can initialize Terraform in this folder by running `terraform init`.

## Spinning it up

Start a consul agent using

```sh
make consul-dev
```

and in a separate terminal

```sh
make nomad-dev
```

Create our desired resources using

```sh
nomad run manifests/traefik.hcl
nomad run manifests/whoami.hcl
nomad run manifests/auth-server.hcl
```

or (which does not work with local images)

```sh
terraform apply
```

The nomad UI is available on [localhost:4646](http://localhost:4646/ui/) and the
consul one is at [localhost:8500](http://localhost:8500/ui/dc1/). The running
container can also be inspected using the standard Docker CLI.

## Inter-service communication

_Not confirmed to be working_

Exec into auth docker container and run

```sh
apk add curl
curl ${WHOAMI_URL}
```
