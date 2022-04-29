class Krunvm < Formula
  desc "Manage lightweight VMs created from OCI images"
  homepage "https://github.com/slp/krunvm"
  url "https://github.com/slp/krunvm/archive/v0.1.5.tar.gz"
  sha256 "ef31f19f8aa907d6555342fe67f2bdaa83987680553993403edf0e830a9da562"
  license "Apache-2.0"

  depends_on "rust" => :build
  depends_on "buildah"
  depends_on "libkrun"

  def install
    system "make"
    bin.install "target/release/krunvm"
  end

  test do
    system "krunvm", "--version"
  end
end
