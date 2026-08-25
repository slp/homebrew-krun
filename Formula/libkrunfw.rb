class Libkrunfw < Formula
  desc "Dynamic library bundling a Linux kernel in a convenient storage format"
  homepage "https://github.com/containers/libkrunfw"
  url "https://github.com/containers/libkrunfw/releases/download/v5.5.0/libkrunfw-prebuilt-aarch64.tgz"
  sha256 "5bfae6efee63dbdf04a8fac2a69d772d9f900af2f54c4429b4acdfd6d86b9979"
  license all_of: ["GPL-2.0-only", "LGPL-2.1-only"]

  bottle do
    root_url "https://github.com/slp/homebrew-krun/releases/download/libkrunfw-5.5.0"
    sha256 cellar: :any, arm64_tahoe:   "c106c1f8cf2c498caf925a6771a69ad44a50ecd128043d06926172b8b8848214"
    sha256 cellar: :any, arm64_sequoia: "7bd32ab2c6f5306879f90ae5a77d6950030f04096d1ab24f9e3842108e984571"
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
