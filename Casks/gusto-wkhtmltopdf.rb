# This cask is sourced from https://github.com/Homebrew/homebrew-cask/blob/2de07d3f7a6bdeb08f23402d3d2da6595fbdc7a2/Casks/w/wkhtmltopdf.rb
# The name was changed per this guidance https://docs.brew.sh/Taps#formula-with-duplicate-names
cask "gusto-wkhtmltopdf" do
  version "0.12.6-2"
  sha256 "81a66b77b508fede8dbcaa67127203748376568b3673a17f6611b6d51e9894f8"

  url "https://github.com/wkhtmltopdf/packaging/releases/download/#{version}/wkhtmltox-#{version}.macos-cocoa.pkg",
      verified: "github.com/wkhtmltopdf/packaging/"
  name "wkhtmltopdf"
  desc "HTML to PDF renderer"
  homepage "https://wkhtmltopdf.org/"

  # begin patch

  # It's actually been disabled upstream.
  # https://github.com/Homebrew/homebrew-cask/commit/241dc44278db6ff882cf9a9118bcbcca878f9815
  #
  # Keeping the deprecation warning because this dependency needs replaced
  deprecate! date: "2024-12-16", because: :discontinued

  # can't have the original cask and this one installed
  conflicts_with cask: "wkhtmltopdf"

  # end patch

  pkg "wkhtmltox-#{version}.macos-cocoa.pkg"

  uninstall script:  {
              executable: "/usr/local/bin/uninstall-wkhtmltox",
              sudo:       true,
            },
            pkgutil: "org.wkhtmltopdf.wkhtmltox",
            delete:  [
              "/usr/local/bin/wkhtmltoimage",
              "/usr/local/bin/wkhtmltopdf",
              "/usr/local/include/wkhtmltox",
              "/usr/local/lib/libwkhtmltox.#{version.major_minor}.dylib",
              "/usr/local/lib/libwkhtmltox.#{version.major}.dylib",
              "/usr/local/lib/libwkhtmltox.#{version.sub(/-.*$/, "")}.dylib",
              "/usr/local/lib/libwkhtmltox.dylib",
            ]

  # No zap stanza required

  caveats do
    files_in_usr_local
  end
end
