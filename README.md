## 👀 Overview

Katze is a [real-mode](https://wiki.osdev.org/Real_Mode) OS that fits in a boot 
sector. 

It's written in x86 assembly and, despite its tiny size (only 510 bytes), it 
packs essential features like:

- **Shell**: Run commands and builtins.
- **File System**: Read, write, and find files on the system.
- **Process Management**: Cooperatively spawn child processes.
- **Userland Software**: Comes with [pre-built software](./bin/) and an 
[SDK](./sdk/) to write your own.

[Check out the online demo](https://shikaan.github.io/Katze) to see it in action!

## 📚 Creating your first Katze program

Katze includes a tiny [Software Development Kit (SDK)](./sdk/) that includes
definitions and a toolchain to create your own Katze programs.

Follow the [step-by-step tutorial](./tutorial/) to write your first program!

## 🛠️ Development

To develop Katze and Katze programs you will need the following tools:

- [nasm](https://www.nasm.us)
- [GNU make](https://www.gnu.org/software/make/) (usually preinstalled)
- [bochs](https://bochs.sourceforge.io) (optional)

<details>
<summary>Installation instructions</summary>

#### macOS

Install dependencies using Homebrew:

```sh
brew install nasm
brew install bochs
```

#### Linux

Install dependencies using your local package manager, e.g., on Debian:

```sh
apt install nasm bochs
```
</details>

### Build and Run Katze locally

These recipes will compile Katze and use the [SDK](./sdk/) to compile and bundle
all the pre-built programs. Using `start` will also run bochs right away.

```sh
# build and run Katze on bochs
make start

# or

# build Katze
make
# use QEMU to run it
qemu-system-i386 -fda vmkatzz.img
```

### Build and Run your Katze program

```sh
# ensure you have a working Katze image at vmkatzz.img
make

# compile your source to generate my_file.bin
sdk/build my_file.s

# bundle my_file.bin into the vmkatzz.img image
sdk/pack my_file.bin

# run it!
qemu-system-i386 -fda vmkatzz.img
```

### Use Katze on a Real Device

Write the built image to a device using `dd`:

> [!WARNING]  
> The following action can damage your hardware. We take no responsibility for
> any damage Katze might cause.

```sh
# generate an Katze image at vmkatzz.img
make

# write it on a device
sudo dd if=vmkatzz.img of=/dev/YOUR_DEVICE bs=512 count=1
```

## Thanks to
OSle for making this project possible

## License

[MIT](./LICENSE)
