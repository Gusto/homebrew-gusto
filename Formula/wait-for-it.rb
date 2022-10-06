# typed: false
# frozen_string_literal: true

# Previously, pdftk was in homebrew-cask, but it was removed because its installer changed
# /usr/local permissions which caused issues with brew update
#
# See https://github.com/Homebrew/homebrew-cask/issues/7707 for more details
#
# This formula was sourced from https://github.com/zph/homebrew-cervezas/blob/master/pdftk.rb
# The difference is this is a formlua, not a cask. It also extracts the contents of the pkg
# to install directly, rather than relaying on the package
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
