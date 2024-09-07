# Aliases
alias hm home-manager
alias hmsw 'home-manager switch --flake ~/nix'
alias l 'ls -lAh1'
alias lg lazygit
alias lsql lazysql
alias nixup 'nix flake update ~/nix'

# Interactive shell initialisation
set fish_greeting # Disable greeting

if type -q mise
    ~/.local/bin/mise activate fish | source
end
