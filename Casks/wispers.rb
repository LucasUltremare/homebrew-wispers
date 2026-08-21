cask "wispers" do
  arch arm: "-arm64", intel: ""

  version "0.2.0"
  sha256 arm:   "32e67ff5f00dba83eceed1d11ee9dcdd3b790c11ee994668a3217c68fb09feff",
         intel: "a7202017aca85e12a6b0de0695f7eda25b261d1c1303e450509a0244482b6855"

  url "https://github.com/LucasUltremare/homebrew-wispers/releases/download/v#{version}/Wispers-#{version}#{arch}-mac.zip"
  name "Wispers"
  desc "Salas privadas pra você e seus amigos — tela com áudio, voz e chat"
  homepage "https://whisperz.space/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Wispers.app"

  # O app é assinado ad-hoc (sem conta Apple). Com a quarentena o Gatekeeper
  # bloqueia na abertura e manda pra Ajustes > Privacidade. Tirar o atributo
  # aqui faz o `brew install` bastar — equivale ao --no-quarantine, sem a
  # pessoa precisar lembrar da flag.
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/Wispers.app"],
                   must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/Wispers",
    "~/Library/Caches/space.whisperz.app",
    "~/Library/Preferences/space.whisperz.app.plist",
    "~/Library/Saved Application State/space.whisperz.app.savedState",
  ]
end
