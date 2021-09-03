job "traefik" {
  region      = "global"
  datacenters = ["dc1"]
  type        = "service"

  group "traefik" {
    count = 1

    network {
      port "http" {
        static = 8080
      }

      port "api" {
        static = 8081
      }
    }

    service {
      name = "traefik"

      check {
        name     = "alive"
        type     = "tcp"
        port     = "http"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "traefik" {
      driver = "docker"

      config {
        image = "traefik:v2.5"
        args = [
          "--entryPoints.http.address=:80",
          "--entryPoints.traefik.address=:8080",

          "--api.dashboard=true",
          "--api.insecure=true",

          "--providers.consulcatalog.prefix=traefik",
          "--providers.consulcatalog.exposedByDefault=false",
          "--providers.consulcatalog.endpoint.address=http://127.0.0.1:8500",
        ]
        network_mode = "host"
      }

      resources {
        cpu    = 100
        memory = 128
      }
    }
  }
}
