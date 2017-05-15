#!/bin/sh

set -e # fail fast
set -x # print commands

cd resource-podcasts
mix local.hex --force
mix local.rebar --force
mix deps.get
mix deps.compile

cp -R . ../output
