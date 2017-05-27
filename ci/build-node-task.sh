#!/bin/sh

set -e # fail fast
set -x # print commands

ls -la
cd output
ls -la
cd assets

npm install
