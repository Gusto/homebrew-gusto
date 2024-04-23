class GustoLima < Formula
  desc "Gusto's opinionated colima profile"
  homepage "https://github.com/abiosoft/colima/blob/main/README.md"
  url "https://github.com/abiosoft/colima.git",
      tag:      "v0.1.0"
  license "MIT"
  head "https://github.com/abiosoft/colima.git", branch: "main"

  depends_on "colima"
  depends_on "docker"
  depends_on "docker-buildx"
  depends_on "docker-compose"
  depends_on "docker-credential-helper"
  depends_on "docker-credential-helper-ecr"

  def install

    bin.install_symlink bin/"colima" => bin/"gusto_lima"

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

    colima_profile_path = Pathname.new(Dir.home)/".colima/gusto"
    colima_profile_path.mkpath
    File.write(colima_profile_path/"colima.yaml", gusto_profile_config)
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
