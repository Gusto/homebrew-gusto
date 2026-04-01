# typed: false
# frozen_string_literal: true

# This formula is sourced from https://github.com/Homebrew/homebrew-core/blob/9116960e5a57cde79ff6b6739a13052b855da7cf/Formula/m/mailhog.rb
# mailhog was removed from homebrew-core on 2026-04-01 because it was disabled as unmaintained.
# We are mirroring it here until we can replace the mailhog dependency.
class Mailhog < Formula
  desc "Web and API based SMTP testing tool"
  homepage "https://github.com/mailhog/MailHog"
  url "https://github.com/mailhog/MailHog/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "6227b566f3f7acbfee0011643c46721e20389eba4c8c2d795c0d2f4d2905f282"
  license "MIT"
  head "https://github.com/mailhog/MailHog.git", branch: "master"

  # begin patch

  # mailhog was disabled upstream as unmaintained and removed from homebrew-core.
  # https://github.com/Homebrew/homebrew-core/commit/9116960e5a57cde79ff6b6739a13052b855da7cf
  # The disable! stanza has been removed so this formula can be installed.
  # Keeping the deprecation warning as a signal that this dependency needs to be replaced.
  deprecate! date: "2024-03-27", because: :unmaintained

  # end patch

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"

    path = buildpath/"src/github.com/mailhog/MailHog"
    path.install buildpath.children

    system "go", "build", *std_go_args(output: bin/"MailHog", ldflags: "-s -w"), path
  end

  service do
    run [
      opt_bin/"MailHog",
      "-api-bind-addr",
      "127.0.0.1:8025",
      "-smtp-bind-addr",
      "127.0.0.1:1025",
      "-ui-bind-addr",
      "127.0.0.1:8025",
    ]
    keep_alive true
    log_path var/"log/mailhog.log"
    error_log_path var/"log/mailhog.log"
  end

  test do
    address = "127.0.0.1:#{free_port}"
    fork { exec "#{bin}/MailHog", "-ui-bind-addr", address }
    sleep 2

    output = shell_output("curl --silent #{address}")
    assert_match "<title>MailHog</title>", output
  end
end
