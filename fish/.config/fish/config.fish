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

    # helper
    function rename
        set old $argv[1]
        set new $argv[2]
        set pattern $argv[3]

        if test -z "$old" -o -z "$new"
            echo "usage: grename OLD NEW [INCLUDE_GLOB]"
            return 1
        end

        if test -n "$pattern"
            rg -l -0 --glob "$pattern" --fixed-strings "$old" | xargs -0 perl -0pi -e "s/\Q$old\E/$new/g"
        else
            rg -l -0 --fixed-strings "$old" | xargs -0 perl -0pi -e "s/\Q$old\E/$new/g"
        end
    end

    ~/.local/bin/mise activate fish | source
    ~/.local/bin/mise x -- pitchfork activate fish | source

    set -l aube_bin (mise x -- aube bin -g)
    if test $status -eq 0 -a -n "$aube_bin"
        fish_add_path $aube_bin
    end

    zoxide init fish | source
end
