cask "dictivo" do
  version "0.3.57"
  sha256 "27d959598e40e557d3dbb1334ff1c33cf02ea68c48d6f1eacd959e37c0362257"

  url "https://downloads.dictivo.app/v#{version}/Dictivo_#{version}_universal.dmg"
  name "Dictivo"
  desc "Offline dictation that pastes your speech into any app"
  homepage "https://dictivo.app/"

  livecheck do
    url "https://dictivo.app/downloads.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on :macos

  app "Dictivo.app"

  uninstall quit: "com.dictivo.desktop"

  zap trash: [
    "~/Library/Application Support/com.dictivo.desktop",
    "~/Library/Application Support/Dictivo",
    "~/Library/Caches/com.dictivo.desktop",
    "~/Library/Preferences/com.dictivo.desktop.plist",
    "~/Library/WebKit/com.dictivo.desktop",
  ]
end
