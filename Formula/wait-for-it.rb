# typed: false
# frozen_string_literal: true

class WaitForIt < Formula
  COMMIT = "81b1373f17855a4dc21156cfe1694c31d7d1792e"

  desc "CLI to test if a given TCP host/port are available"
  homepage "https://github.com/vishnubob/wait-for-it"
  url "https://github.com/vishnubob/wait-for-it.git", revision: COMMIT
  version COMMIT
  sha256 "8a841290928ba4aa930089a16b8b31eb24f0cfd036dd8ee88be371130eb85961"
  license "MIT"
  head "https://github.com/vishnubob/wait-for-it.git", branch: "master"

  def install
    bin.install "wait-for-it.sh" => "wait-for-it"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/wait-for-it --help 2>&1", 1)
  end
end
