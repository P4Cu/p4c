# wolf

Runner on gaming PC: https://games-on-whales.github.io/wolf/stable/user/quickstart.html

And as runner on remote PC: https://app.lizardbyte.dev/Sunshine/?lng=pl

## Impresions?

## Env when I did it

fedora32 + podman

## install

Use the podman quadlets.

## steam library sharing

In /etc/wolf/cfg/config.toml under `Steam` add
`mounts = [ '/games:/home/retro/games1:rw', '/disk2/games:/home/retro/games2:rw' ]`

### workaround

When adding the libraries in steam (exit big picture for it) the libraries are not added correctly.
Steam creates empty subfolder SteamLibrary. Remove it's contents and `ln -s libraryfolder.vdf && ln -s steamapps/`
