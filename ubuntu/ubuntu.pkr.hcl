packer {
  required_plugins {
    qemu = {
      version = "~> 1"
      source  = "github.com/hashicorp/qemu"
    }
  }
}


# -----
# https://developer.hashicorp.com/packer/integrations/hashicorp/qemu
source "qemu" "ubuntu" {
   
  boot_wait = "2s"
  shutdown_command       = "sudo shutdown -P now"
  
  vga                    = "virtio"
  vnc_port_min           = 5990
  vnc_port_max           = 5990
  vm_name                = "ubuntu.img"
  output_directory       = "./build"

  iso_url                = "https://cloud-images.ubuntu.com/daily/server/noble/current/noble-server-cloudimg-amd64.img"
  iso_checksum           = "sha256:482244b83f49a97ee61fb9b8520d6e8b9c2e3c28648de461ba7e17681ddbd1c9"

  cd_label               = "cidata"
  cd_files               = ["./cidata/meta-data", "./cidata/user-data"]

  # set to none if no kvm installed
  accelerator            = "none"
  headless               = true
  format                 = "qcow2"

  communicator           = "ssh"
  ssh_username           = "myuser"
  ssh_password           = "mypassword"
  ssh_timeout            = "60m"
  ssh_handshake_attempts = 50

  disk_size              = "5G"
  disk_compression       = true
  disk_image             = true
  memory                 = 8192
  cpus                   = 8

  net_device             = "virtio-net"
  disk_interface         = "virtio"
}


# -----
build {
  sources = [ 
    "source.qemu.ubuntu", 
  ]
}
