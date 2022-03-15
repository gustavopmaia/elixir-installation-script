#!/bin/sh

# Install ASDF

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

dnf install curl git

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0

echo . $HOME/.asdf/asdf.sh >> ~/.zshrc

source ~/.zshrc

asdf plugin-add erlang
asdf plugin-add elixir

asdf install elixir latest
asdf global elixir latest

dnf groupinstall -y 'Development Tools' 'C Development Tools and Libraries'

dnf install -y autoconf ncurses-devel wxGTK3-devel wxBase3 openssl-devel java-1.8.0-openjdk-devel libiodbc unixODBC-devel.x86_64 erlang-odbc.x86_64 libxslt fop

asdf install erlang latest
asdf global erlang latest

source ~/.zshrc

mix archive.install hex phx_new

dnf install -y moby-engine docker-compose

systemctl enable docker

groupadd docker
usermod -aG docker $USER

docker run --name postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres
