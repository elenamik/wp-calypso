FROM node:10.16.3
LABEL maintainer="Automattic"

WORKDIR    /calypso

ENV        CONTAINER 'docker'
ENV        NODE_PATH=/calypso/server:/calypso/client
ENV        PROGRESS=true

# Build a "base" layer
#
# This layer should never change unless env-config.sh
# changes. For local development this should always
# be an empty file and therefore this layer should
# cache well.
#
# env-config.sh
#   used by systems to overwrite some defaults
#   such as the apt and npm mirrors
COPY       ./env-config.sh /tmp/env-config.sh
RUN        bash /tmp/env-config.sh


# Install our package manager
ARG npm_version=6.13.4
ENV NPM_VERSION $npm_version

RUN npm install -g npm@$NPM_VERSION

# Build a node_modules layer
#
# This one builds out our node_modules tree. Since we use
# file: references, we have to copy over our
# package.json, lockfiles, and the contents of packages/*
COPY package.json package-lock.json /calypso/
COPY packages /calypso/packages
RUN npm ci

# Build a "source" layer
#
# This layer is populated with up-to-date files from
# Calypso development.
COPY       . /calypso/

# Build the final layer
#
# This contains built environments of Calypso. It will
# change any time any of the Calypso source-code changes.
ARG        commit_sha="(unknown)"
ENV        COMMIT_SHA $commit_sha

ARG        workers
RUN        WORKERS=$workers CALYPSO_ENV=production npm run build

USER       nobody
CMD        NODE_ENV=production node build/bundle.js
