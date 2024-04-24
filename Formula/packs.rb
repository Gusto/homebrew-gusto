# typed: false
# frozen_string_literal: true

class Packs < Formula
  desc "Pure Rust implementation of packwerk, a gradual modularization tool for Ruby"
  homepage "https://github.com/alexevanczuk/packs"
  url "https://github.com/alexevanczuk/packs/releases/download/v0.1.95/packs-mac.tar.gz"
  sha256 "1b495bbb4fc250d1dc3d8f08300055b15e32f6107b6133177901434d7dd271cf"
  license "MIT"

  def install
    bin.install "packs" => "pks"
  end
end
