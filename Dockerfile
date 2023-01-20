FROM ubuntu:jammy

VOLUME /dump

# Start by creating the run user
RUN useradd -m -s /bin/bash dumpyara
WORKDIR /home/dumpyara

# Install packages
RUN apt-get update -y && apt-get install -y curl python3 python3-pip git cpio sudo file p7zip-full

# Add into sudoers (required by script)
RUN echo "dumpyara ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
USER dumpyara

# Install extra python modules and download latest dumpyara version
RUN curl -sSL https://github.com/SebaUbuntu-python/dumpyara/archive/refs/heads/master.tar.gz | tar xvz --strip-components=1
RUN pip install --user .

COPY entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
