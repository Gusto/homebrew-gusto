# typed: false
# frozen_string_literal: true

class Packs < Formula
  desc "Pure Rust implementation of packwerk, a gradual modularization tool for Ruby"
  homepage "https://github.com/alexevanczuk/packs"
  url "https://github.com/alexevanczuk/packs/releases/download/v0.2.0/packs-mac.tar.gz"
  sha256 "37205d8a8bc93e4e145ebc5559595e97fa78b17ddc0f25af12f1739137e226ea"
  license "MIT"

  def install
    bin.install "packs" => "pks"
  end
end
