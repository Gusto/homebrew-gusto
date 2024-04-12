# typed: false
# frozen_string_literal: true

class Packs < Formula
  desc "Pure Rust implementation of packwerk, a gradual modularization tool for Ruby"
  homepage "https://github.com/alexevanczuk/packs"
  url "https://github.com/alexevanczuk/packs/releases/download/v0.1.94/packs-mac.tar.gz"
  sha256 "a4415cc6f7e23979fcdca8e05f60a9260487663d27f3321676f6e8110ebdaa2e"
  license "MIT"

  def install
    bin.install "packs" => "pks"
  end
end
