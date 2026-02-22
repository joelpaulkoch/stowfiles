if status is-interactive
    # Aliases
    alias fly flyctl
    alias l 'ls -lAh1'
    alias lg lazygit
    alias lsql lazysql
    alias y yazi

    # Environment
    set -gx EDITOR hx

    # Interactive shell initialisation
    set fish_greeting # Disable greeting

    ~/.local/bin/mise activate fish | source

    if type -q asdf
        source ~/.asdf/asdf.fish
    end

    zoxide init fish | source
end
