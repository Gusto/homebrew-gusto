# typed: false
# frozen_string_literal: true

class Packs < Formula
  desc "Pure Rust implementation of packwerk, a gradual modularization tool for Ruby"
  homepage "https://github.com/alexevanczuk/packs"
  url "https://github.com/alexevanczuk/packs/releases/download/v0.1.90/packs-mac.tar.gz"
  sha256 "f955dc0c5102baddfba9861fa7f77e88355603095c8f365b77c3471c2854aff9"
  license "MIT"

  def install
    bin.install "packs" => "pks"
  end
end
