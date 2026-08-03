class Proxytop < Formula
  desc "macOS proxy, VPN, tunnel, and process traffic inspector"
  homepage "https://github.com/cliecy/proxytop"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/cliecy/proxytop/releases/download/v1.1.1/proxytop-1.1.1-darwin-arm64.tar.gz"
    sha256 "e789c91b4aaa10640e80e011a520d2322b0f58419d596cae6cbd24f23cfe6bfb"
  else
    url "https://github.com/cliecy/proxytop/releases/download/v1.1.1/proxytop-1.1.1-darwin-x86_64.tar.gz"
    sha256 "d95e910373a7e7c574dc079df8a79e46f10067e272dedf03e74db214dcb0cdb0"
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
