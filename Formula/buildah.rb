class Buildah < Formula
  desc "Tool that facilitates building OCI images"
  homepage "https://buildah.io"
  url "https://github.com/containers/buildah/archive/refs/tags/v1.26.2.tar.gz"
  sha256 "a5e95c7b50e31db80b07149cc4bd7ddbe43c2b8ef6add0f58333b250731c1168"
  license "Apache-2.0"

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "gpgme"

  # All these patches have been committed upstream, we're just cherry-picking
  # or backporting them to v1.26.2.
  patch do
    url "https://raw.githubusercontent.com/slp/homebrew-krun/cd74e3bd5196134d0219d918651e6b8bbf64ead8/patches/buildah/0001-Update-vendor-of-containers-storage.patch"
    sha256 "4616b4c41d5c019caa8f691d34f42ea93a98dab30c85535069a85f99f7553829"
  end
  patch do
    url "https://raw.githubusercontent.com/slp/homebrew-krun/cd74e3bd5196134d0219d918651e6b8bbf64ead8/patches/buildah/0002-run_unix-return-a-valid-DefaultNamespaceOptions.patch"
    sha256 "02d2c7743e5d200eecd41e0b79e2374635797c38347fc3dd409df51a868c2638"
  end
  patch do
    url "https://raw.githubusercontent.com/slp/homebrew-krun/cd74e3bd5196134d0219d918651e6b8bbf64ead8/patches/buildah/0003-run_unix-don-t-return-an-error-from-getNetworkInterf.patch"
    sha256 "99e2f5c272fc749d09a294bbdf0766a1b734e608aeaaab3a9d61b4038a302ed8"
  end
  patch do
    url "https://raw.githubusercontent.com/slp/homebrew-krun/cd74e3bd5196134d0219d918651e6b8bbf64ead8/patches/buildah/0004-Makefile-allow-building-without-.git.patch"
    sha256 "3235bda888b8c8a76e87185518281d445efdc0152eac5098e878236ed67ca2a5"
  end

  def install
    system "make", "bin/buildah", "docs"
    bin.install "bin/buildah" => "buildah"
    mkdir_p etc/"containers"
    etc.install "docs/samples/registries.conf" => "containers/registries.conf"
    etc.install "tests/policy.json" => "containers/policy.json"
    man1.install Dir["docs/*.1"]
  end

  test do
    assert_match "buildah version", shell_output("#{bin}/buildah -v")
  end
end
