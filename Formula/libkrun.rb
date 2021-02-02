class Libkrun < Formula
  desc "Dynamic library providing KVM-based process isolation capabilities"
  homepage "https://github.com/containers/libkrun"
  url "https://github.com/containers/libkrun/releases/download/v0.1.4/v0.1.4-with_prebuilts.tar.gz"
  sha256 "c405c153452c1593fab9f3f4853cd111ace5cf8b1ed0f25ce4daa9bdba6ee0be"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/slp/bottles-krun"
    sha256 cellar: :any, arm64_big_sur: "fb6400a6be6aa7da3f96873f5a5e895dfb9e8f05ffb484dbb4524ea9cc6936ae"
  end

  depends_on "rust" => :build
  depends_on "dtc"
  depends_on "libkrunfw"

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <libkrun.h>
      int main()
      {
         int c = krun_create_ctx();
         return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lkrun", "-o", "test"
    system "./test"
  end
end
