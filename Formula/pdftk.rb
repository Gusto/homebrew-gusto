# typed: false
# frozen_string_literal: true

# This formula tracks pdftk-java, a source-compatible reimplementation of pdftk.
#
# It previously unpacked PDFLabs' pdftk-server 2.02 pkg, which is an x86_64-only
# binary built for macOS 10.11. That binary cannot execute on Apple Silicon at all
# without Rosetta 2, and PDFLabs never shipped an arm64 build. Because the payload
# was prebuilt rather than compiled, Homebrew happily linked it and the failure only
# surfaced at runtime as "bad CPU type in executable".
#
# pdftk-java runs on the JVM, so it is architecture-independent. We keep the formula
# name `pdftk` rather than using homebrew-core's `pdftk-java` directly so that the
# existing `brew 'gusto/gusto/pdftk'` entries in consumer Brewfiles keep working.
#
# Upstream: https://gitlab.com/pdftk-java/pdftk
# Core formula this mirrors: https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/p/pdftk-java.rb
class Pdftk < Formula
  desc "CLI for working with PDFs"
  homepage "https://gitlab.com/pdftk-java/pdftk"
  url "https://gitlab.com/pdftk-java/pdftk/-/archive/v3.3.3/pdftk-v3.3.3.tar.gz"
  sha256 "9c947de54658539e3a136e39f9c38ece1cf2893d143abb7f5bf3a2e3e005b286"
  license "GPL-2.0-or-later"
  head "https://gitlab.com/pdftk-java/pdftk.git", branch: "master"

  # gradle@8 rather than gradle: https://gitlab.com/pdftk-java/pdftk/-/issues/182
  depends_on "gradle@8" => :build
  depends_on "openjdk"

  # Both provide bin/pdftk.
  conflicts_with "pdftk-java", because: "both install a `pdftk` binary"

  def install
    system "gradle", "shadowJar", "--no-daemon"
    libexec.install "build/libs/pdftk-all.jar"
    bin.write_jar_script libexec/"pdftk-all.jar", "pdftk"
    man1.install "pdftk.1"
  end

  test do
    pdf = test_fixtures("test.pdf")
    output_path = testpath/"output.pdf"
    system bin/"pdftk", pdf, pdf, "cat", "output", output_path
    assert output_path.read.start_with?("%PDF")
  end
end
