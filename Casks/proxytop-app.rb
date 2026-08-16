cask "proxytop-app" do
  version "1.4.1"
  sha256 "2e656b9607d604d75713f205c4fae96639fea05e3c827edaed13315a90e13d9a"

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
