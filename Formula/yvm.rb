# This version is imported form https://github.com/tophat/homebrew-bar/pull/49
# to fix a deprecation. It can be removed, and tophat/bar can be used instead
#
# Yarn Version Manager
class Yvm < Formula
  desc "Manage multiple versions of Yarn"
  homepage "https://yvm.js.org"
  # Should only be updated if a newer version is listed as a stable release
  url "https://github.com/tophat/yvm/releases/download/v4.1.4/yvm.js"
  sha256 "27b255daff1b9baebddbcd122bacafb155079a188138fbaa0a23d9d309f6c1c0"

  depends_on "node" => [:recommended] # Can be ignored if node is already managed

  conflicts_with "hadoop", because: "both install `yarn` binaries"
  conflicts_with "yarn", because: "yvm installs and manages yarn"

  def write_install_files
    File.write(".bashrc", "")
    File.write(".zshrc", "")
    mkdir_p ".config/fish"
    File.write(".config/fish/config.fish", "")
    File.write(".version", "{ \"version\": \"#{version}\" }")
    system "node", "yvm.js", "configure-shell", "--yvmDir", ".", "--home", "."
    mv ".bashrc", ".config"
    mv ".zshrc", ".config"
  end

  def patch_install_files
    update_self_disabled = "echo 'YVM update-self disabled. Use `brew upgrade yvm`.'"
    inreplace "yvm.sh" do |s|
      s.gsub! 'YVM_DIR=${YVM_DIR-"${HOME}/.yvm"}', "YVM_DIR='#{prefix}'"
      s.gsub! "curl -fsSL https://raw.githubusercontent.com/tophat/yvm/master/scripts/install.js"\
              " | YVM_INSTALL_DIR=${YVM_DIR} node", update_self_disabled
    end
    inreplace "yvm.fish" do |s|
      s.gsub! 'set -q YVM_DIR; or set -gx YVM_DIR "$HOME/.yvm"', "set -gx YVM_DIR '#{prefix}'"
      s.gsub! "env YVM_INSTALL_DIR=$YVM_DIR curl -fsSL https://raw.githubusercontent.com/tophat/yvm"\
              "/master/scripts/install.js | node", update_self_disabled
    end
  end

  def install
    write_install_files
    patch_install_files
    prefix.install [".version", ".config", "shim", "yvm.sh", "yvm.fish", "yvm.js"]
  end

  def caveats
    <<~POSTINSTALLCONFIG
      Run the following command to configure your shell rc file
      $ node "#{prefix}/yvm.js" configure-shell --yvmDir "#{prefix}"
      See "#{prefix}/.config" for examples.

      If you have previously installed YVM, link the versions folder
      to allow all brewed YVM access to the managed yarn distributions
      $ ln -sF ~/.yvm/versions #{prefix}
    POSTINSTALLCONFIG
  end

  test do
    File.write("#{ENV["HOME"]}/.bashrc", "")
    system "node", "#{prefix}/yvm.js", "configure-shell", "--yvmDir", prefix.to_s
    assert_match prefix.to_s, shell_output("bash -i -c 'echo $YVM_DIR'").strip
    shell_output("bash -i -c 'yvm ls-remote'")
    File.write("./.yvmrc", "1.22.5")
    assert_match "1.22.5", shell_output("bash -i -c '#{prefix}/shim/yarn --version'").strip
    shell_output("bash -i -c 'yvm ls'")
  end
end
