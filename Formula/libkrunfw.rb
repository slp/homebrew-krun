class Libkrunfw < Formula
  desc "Dynamic library bundling a Linux kernel in a convenient storage format"
  homepage "https://github.com/slp/libkrunfw"
  url "https://github.com/containers/libkrunfw/releases/download/v3.8.1/v3.8.1-with_macos_prebuilts.tar.gz"
  sha256 "8bb6ed8c60606fdded1ec8484b4d91a78f76881e1a1b437852e470bfa3e4ba48"
  license all_of: ["GPL-2.0-only", "LGPL-2.1-only"]

  bottle do
    root_url "https://raw.githubusercontent.com/slp/homebrew-krun/master/bottles"
    sha256 cellar: :any, arm64_ventura: "8f20895a4e5df248b8e196939ab1cab8658934e001743df6ae5a651c2cf2fe0a"
  end

  # libkrun, our only consumer, only supports Hypervisor.framework on arm64
  depends_on arch: :arm64

  def install
    system "make"
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
