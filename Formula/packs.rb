# typed: false
# frozen_string_literal: true

class Packs < Formula
  desc "Pure Rust implementation of packwerk, a gradual modularization tool for Ruby"
  homepage "https://github.com/alexevanczuk/packs"
  url "https://github.com/alexevanczuk/packs/releases/download/v0.1.85/packs-mac.tar.gz"
  sha256 "6258fc183c1f71f24007dac6deffe58cbf18d40120ec99b937ce97f000fff50d"
  license "MIT"

  def install
    bin.install "packs" => "pks"
  end
end
