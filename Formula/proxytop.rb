class Proxytop < Formula
  desc "macOS proxy, VPN, tunnel, and process traffic inspector"
  homepage "https://github.com/cliecy/proxytop"
  url "https://github.com/cliecy/proxytop/releases/download/v1.4.1/proxytop-1.4.1-darwin-arm.tar.gz"
  sha256 "2e89f91df4a6f500bf6c744801c2ba3c888d126d084b1e5c506a8174c8bf725a"
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
