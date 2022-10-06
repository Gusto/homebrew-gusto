# typed: false
# frozen_string_literal: true

class WaitForIt < Formula
  desc "CLI to test if a given TCP host/port are available"
  homepage "https://github.com/vishnubob/wait-for-it"
  sha256 "b7a04f38de1e51e7455ecf63151c8c7e405bd2d45a2d4e16f6419db737a125d6"

  head 'https://github.com/vishnubob/wait-for-it.git'

  def install
    bin.install "wait-for-it.sh" => "wait-for-it"
  end

  test do
    system "#{bin}/wait-for-it", "--help"
  end
end
