class Gustovm < Formula
  desc "Gusto's opinionated container runtime for MacOS (and Linux)"
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

  depends_on "gusto/gustotest/colima"
  depends_on "docker"
  depends_on "docker-buildx"
  depends_on "docker-compose"
  depends_on "docker-credential-helper"
  depends_on "docker-credential-helper-ecr"

  def install
    gusto_profile_config = <<~YAML
  cpu: 4
  disk: 60
  memory: 8
  arch: host
  runtime: docker
  hostname: ""
  kubernetes:
  enabled: false
  version: v1.24.3+k3s1
  k3sArgs:
    - --disable=traefik
  autoActivate: true
  network:
  address: false
  dnsHosts:
    host.docker.internal: host.lima.internal
  forwardAgent: false
  docker: {}
  vmType: vz
  rosetta: false
  mountType: virtiofs
  mountInotify: false
  cpuType: host
  provision:
    - mode: system
      script: sysctl -w vm.max_map_count=262144
  sshConfig: true
  mounts: []
  env: {}
YAML
    # Create a gusto colima profile
    user_home = Pathname.new(Dir.home)
    (user_home/".colima/gusto").mkpath
    new_file = user_home/".colima/gusto/colima.yaml"
    File.open(new_file, "w") do |f|
      f.write(gusto_profile_config)
    end
    bin.install_symlink "/opt/homebrew/opt/colima/bin/colima" => "gustovm"
  end 

  service do
    run [opt_bin/"colima", "start", "-f", "gusto"]
    keep_alive successful_exit: true
    environment_variables PATH: std_service_path_env
    error_log_path var/"log/gusto.log"
    log_path var/"log/gusto.log"
    working_dir Dir.home
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/colima version 2>&1")
    assert_match "colima is not running", shell_output("#{bin}/colima status 2>&1", 1)
  end
end