class GustoLima < Formula
  desc "Gusto's Colima Brew Service"
  homepage "https://github.com/abiosoft/colima/blob/main/README.md"
  url "https://github.com/gusto/homebrew-gusto.git", tag: "v0.1.0"

  depends_on "colima"
  depends_on "docker"
  depends_on "docker-buildx"
  depends_on "docker-compose"
  depends_on "docker-credential-helper"
  depends_on "docker-credential-helper-ecr"

  def install
    bin.install_symlink Formula["colima"].bin/"colima" => "gusto-lima"
  end

  service do
    run [opt_bin/"gusto-lima", "start", "-f", "gusto"]
    keep_alive successful_exit: true
    environment_variables PATH: std_service_path_env
    error_log_path var/"log/gusto.log"
    log_path var/"log/gusto.log"
    working_dir Dir.home
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gusto-lima version 2>&1")
    assert_match "gusto-lima is not running", shell_output("#{bin}/gusto-lima status 2>&1", 1)
  end
end
