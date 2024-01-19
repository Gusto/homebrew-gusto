# typed: false
# frozen_string_literal: true

class Packs < Formula
  desc "Pure Rust implementation of packwerk, a gradual modularization tool for Ruby"
  homepage "https://github.com/alexevanczuk/packs"
  url "https://github.com/alexevanczuk/packs/releases/download/v0.1.85/packs-mac.tar.gz"
  sha256 "f7b1dd465b8f79b67dd83e5cf0dc868a24fdc028c8ce219138e1775a8afa7239"
  license "MIT"

  def install
    bin.install "packs" => "pks"
  end
end
