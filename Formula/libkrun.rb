class Libkrun < Formula
  desc "Dynamic library providing KVM-based process isolation capabilities"
  homepage "https://github.com/containers/libkrun"
  url "https://github.com/containers/libkrun/releases/download/v1.3.0/v1.3.0-with_macos_prebuilts.tar.gz"
  sha256 "441a9e194841e9276df89ba3c90056ffbea66709d3d0b36cf40318afcf8e0955"
  license "Apache-2.0"

  depends_on "rust" => :build
  # Upstream only supports Hypervisor.framework on arm64
  depends_on arch: :arm64
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
