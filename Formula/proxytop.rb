class Proxytop < Formula
  desc "macOS proxy, VPN, tunnel, and process traffic inspector"
  homepage "https://github.com/cliecy/proxytop"
  url "https://github.com/cliecy/proxytop/releases/download/v1.3.0/proxytop-1.3.0-darwin-arm.tar.gz"
  sha256 "ec37d3d10727adb2ddaf93821e456d47c12f78e862ef8de99e5f58130ea3528c"
  license "MIT"
  depends_on arch: :arm64

  def install
    artifact = Dir["proxytop-#{version}-darwin-*"]
    odie "release asset was not found" if artifact.empty?
    bin.install artifact.first => "proxytop"
  end

  test do
    assert_match "proxytop", shell_output("#{bin}/proxytop --help")
  end
end
