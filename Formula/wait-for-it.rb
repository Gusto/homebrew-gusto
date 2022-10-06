# typed: false
# frozen_string_literal: true

class WaitForIt < Formula
  desc "CLI to test if a given TCP host/port are available"
  FILENAME = "wait-for-it.sh"
  homepage "https://github.com/vishnubob/wait-for-it"
  url "https://raw.githubusercontent.com/vishnubob/wait-for-it/master/#{FILENAME}"
  sha256 "b7a04f38de1e51e7455ecf63151c8c7e405bd2d45a2d4e16f6419db737a125d6"
  version "master"

  def install
    bin.install "wait-for-it.sh" => "wait-for-it"
  end

  test do
    system "#{bin}/wait-for-it", "--help"
  end
end
