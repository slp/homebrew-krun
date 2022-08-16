class Libkrunfw < Formula
  desc "Dynamic library bundling a Linux kernel in a convenient storage format"
  homepage "https://github.com/slp/libkrunfw"
  url "https://github.com/containers/libkrunfw/releases/download/v3.6.0/v3.6.0-with_macos_prebuilts.tar.gz"
  sha256 "f08c15188d3c2104c5416fdd59741ad13bbfb23938f8de03202fdb44eb4d0b63"
  license all_of: ["GPL-2.0-only", "LGPL-2.1-only"]

  bottle do
    root_url "https://raw.githubusercontent.com/slp/homebrew-krun/master/bottles"
    sha256 cellar: :any, arm64_monterey: "eefe4539927bb35e0e088a901fc977d106140e9298f0141cc6d891a365718952"
  end

  # libkrun, our only consumer, only supports Hypervisor.framework on arm64
  depends_on arch: :arm64

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
