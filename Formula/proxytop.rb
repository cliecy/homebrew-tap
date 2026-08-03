class Proxytop < Formula
  desc "macOS proxy, VPN, tunnel, and process traffic inspector"
  homepage "https://github.com/cliecy/proxytop"
  url "https://github.com/cliecy/proxytop/releases/download/v1.1.1/proxytop-1.1.1-darwin-arm.tar.gz"
  sha256 "10f28fa2768ef2945b40b4c57d385c2014500944dbf1a67db555a9c7f3e91a13"
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
