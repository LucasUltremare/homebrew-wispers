cask "wispers" do
  arch arm: "-arm64", intel: ""

  version "0.1.0"
  sha256 arm:   "fa56ad2472a8d750fd5bc78a73535b609f94b3e03d38b5aadb8e922422715751",
         intel: "0e63ee510767653124b4776f0edd06f7f69bf11861da35ce396820d5735ce1c0"

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
