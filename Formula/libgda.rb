class Libgda < Formula
  desc "Provides unified data access to the GNOME project"
  homepage "https://www.gnome-db.org/"
  url "https://download.gnome.org/sources/libgda/6.0/libgda-6.0.0.tar.xz"
  sha256 "995f4b420e666da5c8bac9faf55e7aedbe3789c525d634720a53be3ccf27a670"
  # The executable tools are GPL-2.0-or-later, but these are considered experimental
  # and not installed by default. The license should be updated when tools are installed.
  license "LGPL-2.0-or-later"
  revision 2

  depends_on "gettext" => :build
  depends_on "gobject-introspection" => :build
  depends_on "intltool" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => [:build, :test]
  depends_on "vala" => :build
  depends_on "glib"
  depends_on "iso-codes"
  depends_on "json-glib"
  depends_on "sqlite"
  depends_on "mysql-client"

  uses_from_macos "libxml2"

  on_macos do
    depends_on "gettext"
  end

  # Backport fix for sqlcipher and sqlite pkg-config file generation
  patch do
    url "https://gitlab.gnome.org/GNOME/libgda/-/commit/3e0c7583ddcc3649f24ad1f1b5d851072fd3f721.diff"
    sha256 "a6cb1927ef2174267fd5b01ca7d6b1141f4bad969fa6d10560c62998c6150fd4"
  end

  # Backport fix for undefined behavior due to signed integer overflow
  patch do
    url "https://gitlab.gnome.org/GNOME/libgda/-/commit/657b2f8497da907559a6769c5b1d2d7b5bd40688.diff"
    sha256 "bfc26217647e27aaf065a4b6c210b96e1a6f7cd67d780a3a124951c6a5bc566d"
  end

  # Backport fix for macOS dynamic loading of sqlite.dylib
  patch do
    url "https://gitlab.gnome.org/GNOME/libgda/-/commit/98f014c783583e3ad87ee546e8dccf34d50f1e37.diff"
    sha256 "2f2d257085b40ef4fccf2db68fe51407ba0f59d39672fc95fd91be3e46e91ffa"
  end

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
    pkgshare.install "examples/SimpleExample/example.c"
  end

  test do
    cp pkgshare/"example.c", testpath
    flags = shell_output("pkg-config --cflags --libs libgda-#{version.major_minor}").chomp.split
    system ENV.cc, "example.c", "-o", "example", *flags
    assert_match <<~EOS, shell_output("./example")
      ------+---------+---------
      p1    | chair   | 2.000000
      p3    | glass   | 1.100000
      p1000 | flowers | 1.990000
      (3 rows)
    EOS
  end
end
