# typed: false
# frozen_string_literal: true

class WaitForItHeadOnly < Formula
  desc "CLI to test if a given TCP host/port are available"
  homepage "https://github.com/vishnubob/wait-for-it"

  head "https://github.com/vishnubob/wait-for-it.git"

  def install
    bin.install "wait-for-it.sh" => "wait-for-it"
  end

  test do
    system "#{bin}/wait-for-it", "--help"
  end
end
