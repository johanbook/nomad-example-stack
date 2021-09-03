job "whoami" {
  datacenters = ["dc1"]

  type = "service"

  update {
    max_parallel = 1
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    progress_deadline = "10m"
    auto_revert = false
    canary = 0
  }

  migrate {
    max_parallel = 1
    health_check = "checks"
    min_healthy_time = "10s"
    healthy_deadline = "5m"
  }

  group "server" {
    count = 1

    network {
      port "whoami" {
        static = 6379
      }
    }

    service {
      name = "whoami-server"
      tags = ["global", "app"]
      port = "whoami"

      check {
        name     = "alive"
        type     = "tcp"
        interval = "10s"
        timeout  = "2s"
      }
    }

    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }

    ephemeral_disk {
      size = 300
    }



    task "whoami" {
      driver = "docker"

      config {
        image = "traefik/whoami:latest"
        ports = ["whoami"]
        args = ["--port", "6379"]
      }

      resources {
        cpu    = 50 
        memory = 100 
      }
    }
  }
}
