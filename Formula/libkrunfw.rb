class Libkrunfw < Formula
  desc "Dynamic library bundling a Linux kernel in a convenient storage format"
  homepage "https://github.com/slp/libkrunfw"
  url "https://github.com/containers/libkrunfw/releases/download/v2.0.0/v2.0.0-with_macos_prebuilts.tar.gz"
  sha256 "a7936dc9633961f163119bbcfb8805f4aba55b07ae27e13add596d966fb81a08"
  license "LGPL-2.0"

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
