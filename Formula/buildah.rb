class Buildah < Formula
  desc "Tool that facilitates building OCI images"
  homepage "https://buildah.io"
  url "https://github.com/slp/buildah/archive/v1.19.2.macos_unpriv.tar.gz"
  sha256 "80a2e0899106da4e2b4ebf1f5135417533d57acd5f5643f58c422d91bff143a4"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/slp/bottles-krun"
    sha256 cellar: :any, arm64_big_sur: "c5f0c9b7bdcf6674b5bcf24d03c2572b6b1df0ece3f0deb5c66805c8190c6bcf"
  end

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "gpgme"

  def install
    system "make"
    bin.install "bin/buildah" => "buildah"
    man1.install Dir["docs/*.1"]
  end

  test do
    assert_match "buildah version", shell_output("#{bin}/buildah -v")
  end
end
