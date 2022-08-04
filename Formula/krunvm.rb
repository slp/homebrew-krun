class Krunvm < Formula
  desc "Manage lightweight VMs created from OCI images"
  homepage "https://github.com/slp/krunvm"
  url "https://github.com/containers/krunvm/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "9642ee0a80f7c4bfdbdc59bd24a0a2d2e3be82df039911485b6e9267e16d6e55"
  license "Apache-2.0"

  depends_on "asciidoctor" => :build
  depends_on "rust" => :build
  # We depend on libkrun, which only supports Hypervisor.framework on arm64
  depends_on arch: :arm64
  depends_on "buildah"
  depends_on "libkrun"

  def install
    system "make"
    bin.install "target/release/krunvm"
    man1.install Dir["target/release/build/krunvm-*/out/*.1"]
  end

  test do
    system "krunvm", "--version"
  end
end
