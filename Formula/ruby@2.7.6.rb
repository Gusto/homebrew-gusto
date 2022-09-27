# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class RubyAT276 < Formula
  desc "Powerful, clean, object-oriented scripting language"
  homepage "https://www.ruby-lang.org/"
  url "https://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.6.tar.bz2"
  sha256 "6de239d74cf6da09d0c17a116378a866743f5f0a52c9355da26b5d312ca6eed3"
  license "Ruby"

  depends_on "ruby-install" => :build

  # based on https://github.com/postmodern/ruby-install/blob/master/share/ruby-install/ruby/dependencies.txt's brew section
  depends_on "automake" => :build
  depends_on "bison" => :build
  depends_on "xz" => :build
  depends_on "openssl@1.1"
  depends_on "readline"
  depends_on "libyaml"
  depends_on "gdbm"
  depends_on "libffi"

  def install
    ENV['DLDFLAGS'] = '-Wl,-undefined,dynamic_lookup'
    system "ruby-install", "--update"
    system "ruby-install", "ruby-2.7.6", "--install-dir", prefix
  end

  def post_install
    mkdir_p rubies_version_dir.dirname

    if rubies_version_dir.directory?
      opoo "#{rubies_version_dir} is a directory, seems you previously ran `ruby-install ruby-2.7.6` to build it manually"
    elsif rubies_version_dir.symlink?
      ln_sf prefix, rubies_version_dir
    elsif !rubies_version_dir.exist?
      ln_s prefix, rubies_version_dir
    end
  end

  def rubies_dir
    @rubies_dir ||= Pathname.new("#{Dir.home}/.rubies")
  end

  def rubies_version_dir
    @rubies_version_dir ||= rubies_dir.join("ruby-2.7.6")
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test ruby@2.7.4`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "ruby", "--version"
  end
end
