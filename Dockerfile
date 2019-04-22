FROM ubuntu:18.04
WORKDIR /mount
RUN apt-get update \
    && apt-get install -y \
        gcc \
        g++ \
        gcc-avr \
        avr-libc \
        cpputest \
        make \
        pkg-config \
        avrdude \
        minicom \
    && rm -rf /var/lib/apt/lists/*  
COPY avrduderc /root/.avrduderc
COPY minirc.dfl /etc/minicom/minirc.dfl
CMD ["make"]
