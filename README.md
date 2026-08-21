# homebrew-wispers

Tap do Homebrew pro app desktop do [Wispers](https://whisperz.space/) no macOS.

```sh
brew install --cask lucasultremare/wispers/wispers
```

Atualizar:

```sh
brew upgrade --cask wispers
```

(O próprio app avisa quando tem versão nova e roda isso sozinho.)

Só o arquivo da cask mora aqui — o binário é servido por `whisperz.space/downloads`.
A cask é gerada em `spec-wisoers/desktop` por `npm run dist` e publicada com `npm run cask:publicar`;
não edite o `.rb` na mão.
