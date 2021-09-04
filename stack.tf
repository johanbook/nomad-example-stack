provider nomad {
  address = "http://127.0.0.1:4646"
}

resource "nomad_job" "traefik" {
  jobspec = file("${path.module}/manifests/traefik.hcl")
}

resource "nomad_job" "whoami" {
  jobspec = file("${path.module}/manifests/whoami.hcl")
}

resource "nomad_job" "auth-server" {
  jobspec = file("${path.module}/manifests/auth-server.hcl")
}

