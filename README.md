# Example Packer - Qemu Ubuntu Docker Build

## Requirements

* Docker
* Make

## Build & Run

1. run `make build` (it builds the a container with Packer, Qemu and all tools - this step can be skipped after the first build)
2. run `make run` (the command opens a shell within the container)
3. run in the given shell of the container `make build` (it builds the VM image)
4. run `make run` (run the image and bind it to the VNC client)
5. open the browser with [http://localhost:8080](http://localhost:8080), click connect and login in the VM with credentials: `myuser / mypassword`
