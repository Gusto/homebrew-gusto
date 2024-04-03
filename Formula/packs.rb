# typed: false
# frozen_string_literal: true

class Packs < Formula
  desc "Pure Rust implementation of packwerk, a gradual modularization tool for Ruby"
  homepage "https://github.com/alexevanczuk/packs"
  url "https://github.com/alexevanczuk/packs/releases/download/v0.1.92/packs-mac.tar.gz"
  sha256 "6d110aa03a19301fd8e85bfc1b2bca6606c9181de7c551ed529b8e58b7c865d7"
  license "MIT"

  def install
    bin.install "packs" => "pks"
  end
end
