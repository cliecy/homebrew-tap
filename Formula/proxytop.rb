class Proxytop < Formula
  desc "macOS proxy, VPN, tunnel, and process traffic inspector"
  homepage "https://github.com/cliecy/proxytop"
  url "https://github.com/cliecy/proxytop/releases/download/v1.4.2/proxytop-1.4.2-darwin-arm.tar.gz"
  sha256 "3f3fc31d52d18ffdb4fdab458795d63bce8db87909ab79a682980a7ed876cc41"
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
