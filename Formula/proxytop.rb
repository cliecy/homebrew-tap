class Proxytop < Formula
  desc "macOS proxy, VPN, tunnel, and process traffic inspector"
  homepage "https://github.com/cliecy/proxytop"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/cliecy/proxytop/releases/download/v1.1.1/proxytop-1.1.1-darwin-arm.tar.gz"
    sha256 "9d6681f87220eee4c6ac22d0a033d519b460cf4f59aa2d3e7e494c8556cd6e5f"
  else
    url "https://github.com/cliecy/proxytop/releases/download/v1.1.1/proxytop-1.1.1-darwin-intel.tar.gz"
    sha256 "b225ad1f2b8777f7a18a7eeedfb9385ccdb5f03566291f5c0f971344582091b7"
  end

  def install
    artifact = Dir["proxytop-#{version}-darwin-*"]
    odie "release asset was not found" if artifact.empty?
    bin.install artifact.first => "proxytop"
  end

  test do
    assert_match "proxytop", shell_output("#{bin}/proxytop --help")
  end
end
