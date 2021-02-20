#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install packeges
# Development packages
brew install git vim

# Go
brew install go@1.14 gotags ctags-exuberant

# Networking Tools
brew install httping htop


