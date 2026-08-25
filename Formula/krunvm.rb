class Krunvm < Formula
  desc "Manage lightweight VMs created from OCI images"
  homepage "https://github.com/slp/krunvm"
  url "https://github.com/containers/krunvm/archive/refs/tags/v0.2.7.tar.gz"
  sha256 "1b2a54d670b09a8825a005184f7498a54535f86eb3d35850a37d4702da3121fc"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/libkrun/homebrew-krun/releases/download/krunvm-0.2.7"
    sha256 cellar: :any, arm64_tahoe:   "776f3b8c76b2c2aa61974719a251fe800184c33a0e76b91502436bf3ee7c62ea"
    sha256 cellar: :any, arm64_sequoia: "8ae8d78d57ffba3cfed395c1790dc882403033ac18ed67daed187a1b1f2f4b86"
  end

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
    system "#{bin}/krunvm", "--version"
  end
end
