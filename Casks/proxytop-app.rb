cask "proxytop-app" do
  version "1.4.0"
  sha256 "41fd8b20755dd552fa0545b4bb07167a8e97bfdec4db40f7a9db8e86d7afbd0b"

  url "https://github.com/cliecy/proxytop/releases/download/v1.4.0/Proxytop-1.4.0.dmg"
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
