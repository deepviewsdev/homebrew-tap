# Dictivo Homebrew tap

[Dictivo](https://dictivo.app/) is an offline dictation app for Mac and Windows. Press a shortcut, speak, and Dictivo pastes the text into the app you are using. Local mode keeps audio on your device.

## Install

```sh
brew install --cask deepviewsdev/tap/dictivo
```

The cask installs the signed and notarized universal build (Apple Silicon and Intel) from `downloads.dictivo.app`, the same file as the download button on [dictivo.app](https://dictivo.app/).

## Update

Dictivo updates itself. `brew upgrade --cask dictivo` also works.

## Uninstall

```sh
brew uninstall --cask dictivo
```

`brew uninstall --zap --cask dictivo` also deletes Dictivo's settings, license file and downloaded models from `~/Library`.

## How this tap stays current

A daily GitHub Action reads [dictivo.app/downloads.json](https://dictivo.app/downloads.json), checks the file's SHA-256 against the published value, and updates the cask.

Questions: support@dictivo.app
