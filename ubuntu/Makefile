CONFIG=ubuntu.pkr.hcl

default: build
.PHONY:  build
build:
	@packer init ${CONFIG}
	@packer build -force ${CONFIG}

.PHONEY: run
run:
	@qemu-system-x86_64 -vnc 127.0.0.1:90 -smp 8 -m 8192 -vga virtio -machine type=pc -boot c -drive file=./build/ubuntu.img,if=virtio,cache=writeback,discard=ignore,format=qcow2
