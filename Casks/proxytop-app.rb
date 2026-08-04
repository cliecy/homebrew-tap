cask "proxytop-app" do
  version "1.3.0"
  sha256 "ee191354cffb08a15f707d28ee4c5fa49dd5680893bbc9c3a5657a1691341e41"

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
