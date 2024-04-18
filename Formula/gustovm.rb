class Gustovm < Formula
  desc "Gusto's container runtime"
  url "https://github.com/abiosoft/colima.git",
      tag:      "v0.6.8",
      revision: "9b0809d0ed9ad3ff1e57c405f27324e6298ca04f"

  depends_on "colima"
  depends_on "docker"
  depends_on "docker-credential-helper-ecr"
  depends_on "docker-compose" 
  depends_on "docker-buildx"
  depends_on "docker-credential-helper"

  def install
    bin.install_symlink "/opt/homebrew/opt/colima/bin/colima" => "gustovm"
  end

  service do
    run [opt_bin/"gustovm", "start", "-f", "gusto"]
    keep_alive successful_exit: true
    environment_variables PATH: std_service_path_env
    error_log_path var/"log/gusto.log"
    log_path var/"log/gusto.log"
    working_dir Dir.home
  end
end