class Krunkit < Formula
  desc "CLI tool to start Linux KVM or macOS HVF VMs using the libkrun"
  homepage "https://github.com/containers/krunkit"
  url "https://github.com/containers/krunkit/archive/refs/tags/v1.3.1.tar.gz"
  sha256 "75b4eae8d2cfd7aabee9ce98534d267d964acd7ee260a23bfb9f71cbf279d439"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/libkrun/homebrew-krun/releases/download/krunkit-1.3.1"
    sha256 cellar: :any, arm64_tahoe:   "e2e24f54eab2fe9d383f4a57532fd6154f1b0448ffa9b75fce07365422548291"
    sha256 cellar: :any, arm64_sequoia: "7487c4fed155158a46c401b0469df04344ee1b51dfc8db8929e12344c33c8506"
  end

  depends_on "rust" => :build
  # We depend on libkrun, which only supports Hypervisor.framework on arm64
  depends_on arch: :arm64
  depends_on "gvproxy"
  depends_on "libkrun"

  def install
    homebrew_lib = ENV["HOMEBREW_PREFIX"] + "/lib"
    system "make"
    MachO::Tools.add_rpath("target/release/krunkit", homebrew_lib)
    system "codesign", "--entitlements", "krunkit.entitlements", "--force", "-s", "-", "target/release/krunkit"
    bin.install "target/release/krunkit"
    pkgshare.install "edk2/KRUN_EFI.silent.fd"
  end

  test do
    system "#{bin}/krunkit", "--version"
  end
end
