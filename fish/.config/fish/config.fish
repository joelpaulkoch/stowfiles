if status is-interactive
    # Aliases
    alias l 'ls -lAh1'
    alias lg lazygit
    alias lsql lazysql
    alias y yazi

    # Environment
    set -gx EDITOR hx

    # Interactive shell initialisation
    set fish_greeting # Disable greeting

    if type -q mise
        ~/.local/bin/mise activate fish | source
    end

    if type -q asdf
        source ~/.asdf/asdf.fish
    end
end
