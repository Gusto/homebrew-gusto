class SwigAT421 < Formula
  desc "Generate scripting interfaces to C/C++ code"
  homepage "https://www.swig.org/"
  url "https://downloads.sourceforge.net/project/swig/swig/swig-4.2.1/swig-4.2.1.tar.gz"
  sha256 "fa045354e2d048b2cddc69579e4256245d4676894858fcf0bab2290ecf59b7d8"
  license "GPL-3.0-or-later"

  head do
    url "https://github.com/swig/swig.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  keg_only "versioned formulae"

  depends_on "python-setuptools" => :test
  depends_on "python@3.12" => :test
  depends_on "pcre2"

  def install
    ENV.append "CXXFLAGS", "-std=c++11" # Fix `nullptr` support detection.
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      int add(int x, int y)
      {
        return x + y;
      }
    EOS
    (testpath/"test.i").write <<~EOS
      %module test
      %inline %{
      extern int add(int x, int y);
      %}
    EOS
    (testpath/"setup.py").write <<~EOS
      #!/usr/bin/env python3
      from distutils.core import setup, Extension
      test_module = Extension("_test", sources=["test_wrap.c", "test.c"])
      setup(name="test",
            version="0.1",
            ext_modules=[test_module],
            py_modules=["test"])
    EOS
    (testpath/"run.py").write <<~EOS
      #!/usr/bin/env python3
      import test
      print(test.add(1, 1))
    EOS

    ENV.remove_from_cflags(/-march=\S*/)
    system "#{bin}/swig", "-python", "test.i"
    system "python3", "setup.py", "build_ext", "--inplace"
    assert_equal "2", shell_output("python3 ./run.py").strip
  end
end
