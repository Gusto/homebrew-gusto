class GustoLima < Formula
  desc "Gusto's opinionated colima profile"
  homepage "https://github.com/abiosoft/colima/blob/main/README.md"
  url "https://github.com/abiosoft/colima.git",
      tag:      "v0.6.8",
      revision: "9b0809d0ed9ad3ff1e57c405f27324e6298ca04f"
  license "MIT"
  head "https://github.com/abiosoft/colima.git", branch: "main"
  
  depends_on "go" => :build
  depends_on "docker"
  depends_on "docker-buildx"
  depends_on "docker-compose"
  depends_on "docker-credential-helper"
  depends_on "docker-credential-helper-ecr"
  depends_on "lima"

  def install
    project = "github.com/abiosoft/colima"
    ldflags = %W[
      -s -w
      -X #{project}/config.appVersion=#{version}
      -X #{project}/config.revision=#{Utils.git_head}
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/colima"

    bin.install_symlink bin/"gusto-lima" => bin/"colima"

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
