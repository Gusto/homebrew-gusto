class Colima < Formula
  desc "Container runtime for MacOS (and Linux)"
  homepage "https://github.com/abiosoft/colima/blob/main/README.md"
  url "https://github.com/abiosoft/colima.git",
      tag:      "v0.6.8",
      revision: "9b0809d0ed9ad3ff1e57c405f27324e6298ca04f"
  license "MIT"
  head "https://github.com/abiosoft/colima.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "go" => :build
  depends_on "lima"

  def install
    project = "github.com/abiosoft/colima"
    ldflags = %W[
      -s -w
      -X #{project}/config.appVersion=#{version}
      -X #{project}/config.revision=#{Utils.git_head}
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/colima"

    bin.install_symlink opt_bin/"colima" => "colima@0.6.8"
  end

  service do
    run [opt_bin/"colima@0.6.8", "start", "-f"]
    keep_alive successful_exit: true
    environment_variables PATH: std_service_path_env
    error_log_path var/"log/default.log"
    log_path var/"log/default.log"
    working_dir Dir.home
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/colima@0.6.8 version 2>&1")
    assert_match "colima@0.6.8 is not running", shell_output("#{bin}/colima@0.6.8 status 2>&1", 1)
  end
end
