provider "digitalocean" {
    token = "xxx-xxx-xxx"
}

resource "digitalocean_droplet" "db1" {
    name = "db1"
    size = "1gb"
    image = "15943679"
    region = "sfo1"
    private_networking = true
    ssh_keys = ["fa:d3:d1:25:21:6e:cb:f4:4b:17:27:37:9c:58:a2:f0"]

    // user_data = "${file("user_data.yml")}"

    provisioner "remote-exec" {
        inline = [
            # install salt-minion and salt-master
            "curl -L https://bootstrap.saltstack.com | sh -s -- -M -A localhost"
          ]
    }
}