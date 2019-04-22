# rubberduck/avr

Docker image for AVR development

This image contains all the dependencies you need for AVR development.

- Make
- CppUTest
- gcc
- avr-gcc

## Build Image

docker build -t rubberduck/avr .

## Run Container As Build Tool

This command will run the container and mount the current working directory to the working directory of the container. Mounting the current container means we leave the build artifacts behind on the host machine.

```bash
docker run --rm -it -v ${PWD}:/mount rubberduck/avr bash
```

Once inside the container, just run your makefile like you would if you had the dependencies installed on your local machine.

```bash
make check
make 
# etc.
```

### Flashing

The container has [avrdude](https://www.nongnu.org/avrdude/user-manual/avrdude_10.html) installed and a default conf file located in `/root/.avrduderc`.
By default, it points to the `/dev/ttyUSB0` port.

```bash
docker run --rm -it --device /dev/ttyUSB0 -v ${PWD}:/mount rubberduck/avr bash
```

If you need to use a differenc avrdude conf file, you can mount it in like this.

```bash
docker run --rm -it --device /dev/someOtherTty -v ${PWD}:/mount -v someOtherAvrdude.conf:/root/.avrduderc rubberduck/avr bash
```

#### Mac/Windows

Accessing the host's USB ports can be difficult on non-Linux operating systems.
You need to use a virtual machine to host the docker daemon.

[See this blog post for instructions on accessing USB ports inside the container on Mac](https://christopherjmcclellan.wordpress.com/2019/04/21/using-usb-with-docker-for-mac/).

## CppUTest and Make

This image includes pkg-config.
It can be leveraged in your makefile to locate the CppUTest includes and libs.

```bash
CPPFLAGS += $(shell pkg-config --cflags cpputest)
CXXFLAGS += -include CppUTest/MemoryLeakDetectorNewMacros.h
CFLAGS += -include CppUTest/MemoryLeakDetectorMallocMacros.h
LD_LIBRARIES = $(shell pkg-config --libs cpputest)
```
