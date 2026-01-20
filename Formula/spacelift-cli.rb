# typed: false
# frozen_string_literal: true

class SpaceliftCli < Formula
  include Language::Python::Virtualenv

  desc "Spacelift CLI for Gusto's Terraform apply-before-merge workflows"
  homepage "https://github.com/Gusto/spacelift-cli"
  url "https://github.com/Gusto/spacelift-cli.git", branch: "main"
  version "1.0.0"
  license "MIT"
  head "https://github.com/Gusto/spacelift-cli.git", branch: "main"

  depends_on "python@3.11"

  resource "typer" do
    url "https://files.pythonhosted.org/packages/5b/49/39f10d0f75886439ab3dac889f14f8ad511982a754e382c9b6ca895b29e9/typer-0.12.5.tar.gz"
    sha256 "f592f089bedcc8ec1b974125d64851029c3b1af145f04aca64d69410f0c9b722"
  end

  resource "httpx" do
    url "https://files.pythonhosted.org/packages/78/82/08f8c936781f67d9e6b9eeb8a0c8b4e406136ea4c3d1f89a5db71d42e0e6/httpx-0.27.2.tar.gz"
    sha256 "f7c2be1d2f3c3c3160d441802406b206c2b76f5947b11115e6df10c6c65e66c2"
  end

  resource "pydantic" do
    url "https://files.pythonhosted.org/packages/45/0f/27908242621b14e649a84e62b133de45f84c255eecb350ab02da7baa3d6c/pydantic-2.10.4.tar.gz"
    sha256 "82f12e9723da6de4fe2ba888b5971157b3be7ad914267dea8f05f82b28254f06"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/ab/3a/0316b28d0761c6734d6bc14e770d85506c986c85ffb239e688eeaab2c2bc/rich-13.9.4.tar.gz"
    sha256 "439594978a49a09530cff7ebc4b5c7103ef57baf48d5ea3184f21d9a2befa098"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/54/ed/79a089b6be93607fa5cdaedf301d7dfb23af5f25c398d5ead2525b063e17/pyyaml-6.0.2.tar.gz"
    sha256 "d584d9ec91ad65861cc08d42e834324ef890a082e591037abe114850ff7bbc3e"
  end

  resource "boto3" do
    url "https://files.pythonhosted.org/packages/3e/da/26cd2349c5ec68fedd90e56c31ae67757feef96f1aeacdfe5d54d1df7498/boto3-1.35.93.tar.gz"
    sha256 "4981095e583c82adfa90e59df79f0a6768babc2d7caa7e183f1bfe85e0b07aa5"
  end

  resource "datadog" do
    url "https://files.pythonhosted.org/packages/e7/29/7c13de4b0336ae4bb19c050e0e51178aa3329f71019bf37f75b1944f41fb/datadog-0.50.2.tar.gz"
    sha256 "469b4fa87d1e952e4610c7b3e4b6223bf387c4b8f3ed07f61e70cc5c1bcb548d"
  end

  resource "authlib" do
    url "https://files.pythonhosted.org/packages/8c/6f/43c5c74fd4fa7c9baff94dc2e23c09eab8bc3e0c18c3df05120f9d7fc0a7/Authlib-1.3.2.tar.gz"
    sha256 "4b16130117f9eb82aa6eec97f6dd4673c3f960ac0283ccdae2897ee4bc030ba2"
  end

  resource "python-hcl2" do
    url "https://files.pythonhosted.org/packages/7c/a8/e7e06f37fc80c9b5e88e678b4e1b5d72e9319da0021a2cc66e23e74f9ee6/python-hcl2-4.3.5.tar.gz"
    sha256 "c7e6e822e3ea7e99a85bc750b68aa21ab9e7dc2bf8b63b20e9b58983d28bca98"
  end

  def install
    virtualenv_install_with_resources
    
    # Install shell completions
    bash_completion.install "completion/spacelift-completion.bash" => "spacelift"
    zsh_completion.install "completion/spacelift-completion.zsh" => "_spacelift"
  end

  test do
    assert_match "spacelift", shell_output("#{bin}/spacelift --version 2>&1")
  end
end
