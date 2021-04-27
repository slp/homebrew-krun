class Libkrunfw < Formula
  desc "Dynamic library bundling a Linux kernel in a convenient storage format"
  homepage "https://github.com/slp/libkrunfw"
  url "https://github.com/containers/libkrunfw/releases/download/v0.5/v0.5-with_prebuilts.tar.gz"
  sha256 "bebd2cf420e1027205e2a3ac9e69a26bd82285c35a4eca0389c66a22ecaf9ada"
  license "LGPL-2.0"

  bottle do
    root_url "https://dl.bintray.com/slp/bottles-krun"
    sha256 cellar: :any, arm64_big_sur: "158eaf6556dcde8ddf48332142bfdf94ec56f1967e0b9a960e57786d1a8304ee"
  end

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      int krunfw_get_version();
      int main()
      {
         int v = krunfw_get_version();
         return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lkrunfw", "-o", "test"
    system "./test"
  end
end
