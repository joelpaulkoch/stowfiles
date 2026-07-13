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

    abbr oc opencode
    abbr pf pitchfork
    abbr ghprf 'gh pr create --fill-first --web'

    # Environment
    set -gx EDITOR hx
    set -gx ERL_AFLAGS "-kernel shell_history enabled"

    # Interactive shell initialisation
    set fish_greeting # Disable greeting

    ~/.local/bin/mise activate fish | source
    ~/.local/bin/mise x -- pitchfork activate fish | source

    set -l aube_bin (mise x -- aube bin -g)
    if test $status -eq 0 -a -n "$aube_bin"
        fish_add_path $aube_bin
    end

    zoxide init fish | source
end
