if status is-interactive
    # Aliases
    alias fly flyctl
    alias l 'ls -lAh1'
    alias lg lazygit
    alias lsql lazysql
    alias y yazi

    abbr mt 'mix test'
    abbr mtl 'mix test --listen-on-stdin'

    abbr be 'bundle exec'
    abbr rubo 'bundle exec rubocop -A'
    abbr rsp 'bundle exec rspec'

    # Environment
    set -gx EDITOR hx
    set -gx ERL_AFLAGS "-kernel shell_history enabled"

    # Interactive shell initialisation
    set fish_greeting # Disable greeting

    ~/.local/bin/mise activate fish | source

    zoxide init fish | source
end
