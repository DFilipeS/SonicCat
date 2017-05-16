FROM elixir:latest

WORKDIR /opt/app

RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get install -y nodejs

RUN mix local.hex --force && mix local.rebar --force
