class Buildah < Formula
  desc "Tool that facilitates building OCI images"
  homepage "https://buildah.io"
  url "https://github.com/slp/buildah/archive/v1.19.2.macos_unpriv-2.tar.gz"
  sha256 "a666231e67ed1acc1993877bbef05b5deeb432ae7af6b8a58ec053fa293f1715"
  license "Apache-2.0"

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
