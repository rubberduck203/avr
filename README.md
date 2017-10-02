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
docker run --rm -it -v ${PWD}:/mount rubberduck/avr
```

Once inside the container, just run your makefile like you would if you had the dependencies installed on your local machine.

```bash
make check
make 
# etc.
```

## CppUTest and Make

This image includes pkg-config.
It can be leveraged in your makefile to locate the CppUTest includes and libs.

```bash
CPPFLAGS += $(shell pkg-config --cflags cpputest)
CXXFLAGS += -include CppUTest/MemoryLeakDetectorNewMacros.h
CFLAGS += -include CppUTest/MemoryLeakDetectorMallocMacros.h
LD_LIBRARIES = $(shell pkg-config --libs cpputest)
```
