class Krunkit < Formula
  desc "CLI tool to start Linux KVM or macOS HVF VMs using the libkrun"
  homepage "https://github.com/containers/krunkit"
  url "https://github.com/containers/krunkit/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "ab2fa5e0c0b6d00b9aa083f4fb4703348dad98ce6ab18dfb559b769cb0d439a9"
  license "Apache-2.0"

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
