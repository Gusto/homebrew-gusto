class Gd < Formula
  homepage 'https://github.com/gusto/gd'
  head 'https://github.com/Gusto/gd.git', branch: 'main'

  def install
    bin.install "wrapper/gd"
    prefix.install 'exe', 'lib', 'vendor'
  end

  test do
    system "#{bin}/gd", 'help'
  end
end
