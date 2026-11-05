cask "wispers" do
  arch arm: "-arm64", intel: ""

  version "0.3.0"
  sha256 arm:   "8c7e03c541ed7553a34045a3b964fef3cb543a72d1280b1e3e750293fe2da2f6",
         intel: "80d14b6fdede1abceaf8dbc297c2b6568eca99d083120da8a5ee1e5eef165aba"

  url "https://github.com/LucasUltremare/homebrew-wispers/releases/download/v#{version}/Wispers-#{version}#{arch}-mac.zip"
  name "Wispers"
  desc "Salas privadas pra você e seus amigos — tela com áudio, voz e chat"
  homepage "https://whisperz.space/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # O próprio app se atualiza (baixa o zip da Release, confere o sha512 e
  # troca o .app ao abrir/fechar). Sem isto o `brew upgrade` brigaria com ele
  # reinstalando por cima; com isto o brew só mexe com --greedy.
  auto_updates true
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
