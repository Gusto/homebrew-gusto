# typed: false
# frozen_string_literal: true

class Packs < Formula
  desc "Pure Rust implementation of packwerk, a gradual modularization tool for Ruby"
  homepage "https://github.com/alexevanczuk/packs"
  url "https://github.com/alexevanczuk/packs/releases/download/v0.1.88/packs-mac.tar.gz"
  sha256 "6ba18350ce2b77d8fce6e266807cb8234dd2438085f1053074d7c803301dfacc"
  license "MIT"

  def install
    bin.install "packs" => "pks"
  end
end
