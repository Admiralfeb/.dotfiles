FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Chicago

# OS updates and install
RUN apt-get update -qq
RUN apt-get install -qq git sudo wget curl

RUN apt-get install -qq tzdata

# Create test user and add to sudoers
RUN useradd -m -s /bin/bash tester
RUN usermod -aG sudo tester
RUN echo "tester   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

# Add dotfiles and chown
ADD . /home/tester/projects/dotfiles
RUN chown -R tester:tester /home/tester

# Switch testuser
USER tester
ENV HOME /home/tester

# Change working directory
WORKDIR /home/tester/projects/dotfiles

# Run setup
WORKDIR /home/tester/projects/dotfiles/os/pop
RUN chmod +x ./install.sh
RUN ./install.sh

CMD ["/bin/bash"]
