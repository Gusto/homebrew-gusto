# typed: false
# frozen_string_literal: true

class SpaceliftCli < Formula
  include Language::Python::Virtualenv

  desc "CLI for Gusto's Terraform apply-before-merge workflows on Spacelift"
  homepage "https://github.com/Gusto/spacelift-cli"
  url "git@github.com:Gusto/spacelift-cli.git", branch: "experimental"
  version "1.0.0"
  license "MIT"
  head "git@github.com:Gusto/spacelift-cli.git", branch: "experimental"

  depends_on "libyaml"
  depends_on "python@3.11"

  def install
    # Create virtualenv in libexec with pip
    system "python3.11", "-m", "venv", libexec

    # Install the package from buildpath with all dependencies
    system libexec/"bin/pip", "install", "--upgrade", "pip", "setuptools", "wheel"
    system libexec/"bin/pip", "install", buildpath

    # Link the executable to bin
    bin.install_symlink libexec/"bin/spacelift"

    # Install shell completions
    bash_completion.install "completion/spacelift-completion.bash" => "spacelift"
    zsh_completion.install "completion/spacelift-completion.zsh" => "_spacelift"
  end

  test do
    assert_match "spacelift", shell_output("#{bin}/spacelift --version 2>&1")
  end
end
