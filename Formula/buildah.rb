class Buildah < Formula
  desc "Tool that facilitates building OCI images"
  homepage "https://buildah.io"
  url "https://github.com/slp/buildah/archive/v1.19.2.macos_unpriv.tar.gz"
  sha256 "80a2e0899106da4e2b4ebf1f5135417533d57acd5f5643f58c422d91bff143a4"
  license "Apache-2.0"

  depends_on "go" => :build
  depends_on "go-md2man" => :build

  def install
    system "make"
    bin.install "bin/buildah" => "buildah"
    man1.install Dir["docs/*.1"]
  end

  test do
    assert_match "buildah version", shell_output("#{bin}/buildah -v")
  end
end
