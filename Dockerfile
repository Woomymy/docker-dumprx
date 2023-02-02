FROM archlinux:latest

VOLUME /dump

# Start by creating the run user
RUN useradd -m -s /bin/bash dumprx
WORKDIR /home/dumprx

# Install curl, sudo and git
RUN pacman -Syyu --noconfirm && pacman -S curl sudo git gcc python-pip --noconfirm

# Add into sudoers (required by script)
RUN echo "dumprx ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
USER dumprx

# Install extra python modules and download latest dumpyara version
RUN curl -sSL https://github.com/DumprX/DumprX/archive/refs/heads/main.tar.gz | tar xvz --strip-components=1
RUN /home/dumprx/setup.sh

COPY entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
