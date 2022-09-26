
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
class Pdftk < Formula
  FILENAME = "pdftk_server-2.02-mac_osx-10.11-setup.pkg"
  homepage 'https://www.pdflabs.com/tools/pdftk-server'
  url "https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/#{FILENAME}"
  sha256 'c33cf95151e477953cd57c1ea9c99ebdc29d75f4c9af0d5f947b385995750b0c'

  def install
    # Outputs it to pdftk.pkg/*
    safe_system '/usr/bin/xar', '-xf', FILENAME
    Dir.mkdir 'tmp'
    safe_system 'tar -xf pdftk.pkg/Payload -C tmp/.'

    # don't install man files into the prefix
    prefix_files = Dir['tmp/*'] - ['tmp/man']
    prefix.install prefix_files

    # install the man files to the correct subdirectory instead
    man1.install Dir['tmp/man/pdftk.1']
  end

  test do
    system "#{bin}/pdftk", '--version'
  end
end
