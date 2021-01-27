class Krunvm < Formula
  desc "Manage lightweight VMs created from OCI images"
  homepage "https://github.com/slp/krunvm"
  url "https://github.com/slp/krunvm/archive/v0.1.0.tar.gz"
  sha256 "c53a2264144f0c09dbc61a9953225d82289951000d83f9dbf67f1b3b9b48d4b8"
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
