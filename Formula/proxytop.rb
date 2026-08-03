class Proxytop < Formula
  desc "macOS proxy, VPN, tunnel, and process traffic inspector"
  homepage "https://github.com/cliecy/proxytop"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/cliecy/proxytop/releases/download/v1.1.1/proxytop-1.1.1-darwin-arm64"
    sha256 "f27aef77d46d3ae67148149b4e55cd1d7e7bfcbdbefd7997bdc6266c31bf4da3"
  else
    url "https://github.com/cliecy/proxytop/releases/download/v1.1.1/proxytop-1.1.1-darwin-x86_64"
    sha256 "b7055b00c138002a5d928eb0647eb157b015813f91ad5fc0697d22a0e976f49d"
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
