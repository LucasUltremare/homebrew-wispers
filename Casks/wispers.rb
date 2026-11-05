cask "wispers" do
  arch arm: "-arm64", intel: ""

  version "0.3.1"
  sha256 arm:   "fc529c08f1a16412e0357f295e00aa74c0bcd413da1ddf508975bb96c551e7d8",
         intel: "15a9d853b685907572cbf450ecd5d3d9af5bdf61cb366c046a48ca76ef43e66f"

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
