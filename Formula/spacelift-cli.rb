# typed: false
# frozen_string_literal: true

class SpaceliftCli < Formula
  include Language::Python::Virtualenv

  desc "CLI for Gusto's Terraform apply-before-merge workflows on Spacelift"
  homepage "https://github.com/Gusto/spacelift-cli"
  url "https://github.com/Gusto/spacelift-cli.git", branch: "main"
  version "1.0.0"
  license "MIT"
  head "https://github.com/Gusto/spacelift-cli.git", branch: "main"

  depends_on "libyaml"
  depends_on "python@3.11"

  def install
    # Create virtualenv and install the package with all dependencies
    virtualenv_create(libexec, "python3.11")
    system libexec/"bin/pip", "install", "-v", "--no-binary", ":all:",
           "--ignore-installed", buildpath

    # Create wrapper script
    (bin/"spacelift").write_env_script libexec/"bin/spacelift", PATH: "#{libexec}/bin:$PATH"

    # Install shell completions
    bash_completion.install "completion/spacelift-completion.bash" => "spacelift"
    zsh_completion.install "completion/spacelift-completion.zsh" => "_spacelift"
  end

  test do
    assert_match "spacelift", shell_output("#{bin}/spacelift --version 2>&1")
  end
end
