# typed: false
# frozen_string_literal: true

class WaitForIt < Formula
  desc "CLI to test if a given TCP host/port are available"
  homepage "https://github.com/vishnubob/wait-for-it"

  # choose the recent revision so we can have a stable revision
  head "https://github.com/vishnubob/wait-for-it.git", revision: "81b1373f17855a4dc21156cfe1694c31d7d1792e"

  def install
    bin.install "wait-for-it.sh" => "wait-for-it"
  end

  test do
    system "#{bin}/wait-for-it", "--help"
  end
end
