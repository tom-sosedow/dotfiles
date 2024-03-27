if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting
    set -x TERMINAL "alacritty"
    set -x QT_QPA_PLATFORMTHEME qt5ct
    set -Ux MOZ_X11 1
    fish_add_path /home/tom/.local/bin
    fish_add_path /home/tom/.spicetify
    fish_add_path /home/tom/.pub-cache/bin
    fish_add_path /home/tom/.cargo/bin
    cat ~/.cache/wal/sequences
    nvm use 18 >> /dev/null
end

#set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/tom/.ghcup/bin # ghcup-env

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/tom/.ghcup/bin # ghcup-env
