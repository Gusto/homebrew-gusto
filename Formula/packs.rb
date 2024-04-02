# typed: false
# frozen_string_literal: true

class Packs < Formula
  desc "Pure Rust implementation of packwerk, a gradual modularization tool for Ruby"
  homepage "https://github.com/alexevanczuk/packs"
  url "https://github.com/alexevanczuk/packs/releases/download/v0.1.91/packs-mac.tar.gz"
  sha256 "06a06845bd0bb66c6cc86b3103d949ca424b2dd268ee5d4e5c9c8f0693648366"
  license "MIT"

  def install
    bin.install "packs" => "pks"
  end
end
