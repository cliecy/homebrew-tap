cask "proxytop-app" do
  version "1.2.0"
  sha256 "fa56a7b9671b82a90a0ae3b0393bbcaa9a3b9aaebbb2b07e10bcc51ecb4f8d6f"

  url "https://github.com/cliecy/proxytop/releases/download/v#{version}/Proxytop-#{version}.dmg"
  name "Proxytop"
  desc "macOS proxy, VPN, and per-application network path inspector"
  homepage "https://github.com/cliecy/proxytop"

  app "Proxytop.app"

  uninstall quit: "com.proxytop.app"

  zap trash: [
    "~/Library/Application Support/Proxytop",
    "~/.config/proxytop",
  ]
end
