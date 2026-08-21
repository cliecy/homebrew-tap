cask "proxytop-app" do
  version "1.4.2"
  sha256 "d8a7121738b21a3be16930ec62e9ab02693dcae49a7ba51de01fc5521d52c4ca"

  url "https://github.com/cliecy/proxytop/releases/download/v#{version}/Proxytop-#{version}.dmg"
  name "Proxytop"
  desc "Proxy, VPN, and per-application network path inspector"
  homepage "https://github.com/cliecy/proxytop"

  depends_on macos: :sonoma

  app "Proxytop.app"

  uninstall quit: "com.proxytop.app"

  zap trash: [
    "~/.config/proxytop",
    "~/Library/Application Support/Proxytop",
  ]
end
