class GustoLima < Formula
  desc "Gusto's Colima Brew Service"
  homepage "https://github.com/abiosoft/colima/blob/main/README.md"
  url "https://github.com/gusto/homebrew-gusto.git", branch: "main"
  version "0.1.1"

  depends_on "colima"
  depends_on "docker"
  depends_on "docker-buildx"
  depends_on "docker-compose"
  depends_on "docker-credential-helper"
  depends_on "docker-credential-helper-ecr"

  def install
    gusto_colima_script = Tempfile.new(["colima_gusto", ".sh"])
    gusto_colima_script.write <<~SCRIPT
      #!/bin/bash
      colima -p gusto $@
    SCRIPT

    gusto_colima_script.chmod(0755)

    bin.install gusto_colima_script.path => "gusto-lima"

    gusto_colima_script.unlink
  end

  service do
    run [opt_bin/"gusto-lima", "start", "-f"]
    keep_alive successful_exit: true
    environment_variables PATH: std_service_path_env
    error_log_path var/"log/gusto.log"
    log_path var/"log/gusto.log"
    working_dir Dir.home
  end

  test do
    assert_match "colima is not running", shell_output("#{bin}/gusto-lima status 2>&1", 1)
  end
end
