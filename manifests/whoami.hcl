job "whoami" {
  datacenters = ["dc1"]

  type = "service"

  group "server" {
    count = 1

    network {
      port "http" {
        to = 80
      }
    }

    service {
      name = "whoami-server"
      port = "http"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.whoami.rule=Path(`/whoami`)",
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "whoami" {
      driver = "docker"

      config {
        image = "traefik/whoami:latest"
        ports = ["http"]
      }

    }
  }
}
