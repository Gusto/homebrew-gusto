class Gustovm < Formula
  desc "Gusto's container runtime"
  url "https://github.com/abiosoft/colima.git",
      tag:      "v0.6.8",
      revision: "9b0809d0ed9ad3ff1e57c405f27324e6298ca04f"

  depends_on "go" => :build
  depends_on "lima"
  depends_on "docker"
  depends_on "docker-credential-helper-ecr"
  depends_on "docker-compose" 
  depends_on "docker-buildx"
  depends_on "docker-credential-helper"

  def install
    project = "github.com/abiosoft/colima"
    ldflags = %W[
      -s -w
      -X #{project}/config.appVersion=#{version}
      -X #{project}/config.revision=#{Utils.git_head}
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/colima"
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