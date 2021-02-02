class Krunvm < Formula
  desc "Manage lightweight VMs created from OCI images"
  homepage "https://github.com/slp/krunvm"
  url "https://github.com/slp/krunvm/archive/v0.1.4.tar.gz"
  sha256 "0ed02ff10a04e40431b50121f292b0b6b4b625ca6a12196811cb5ebbba0ad53d"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/slp/bottles-krun"
    cellar :any
    sha256 "22a4667f0d1053aa18c64dcbc363721ff16dbefa789ca5a41832ff9a66c40815" => :arm64_big_sur
  end

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
