if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

export PATH=$PATH:/opt/homebrew/bin
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Github Copilot for CLI
eval "$(gh copilot alias -- zsh)"

source ~/.nix-profile/share/zplug/init.zsh

zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

zplug load

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

export EDITOR="nvim"

# if macos
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias ghosttyconfig="$EDITOR ~/Library/Application\ Support/com.mitchellh.ghostty/config"
fi

# if ~/.local/bin exists, add it to path
if [[ -d "$HOME/.local/bin" ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

source <(fzf --zsh)
eval "$(direnv hook zsh)"

alias awsp='export AWS_PROFILE=$(aws configure list-profiles | fzf --prompt "Choose active AWS profile: ")'
alias awsr='export AWS_REGION=$(aws ec2 describe-regions --region eu-west-1 --query "Regions[].RegionName" --output text | tr "\t" "\n" | fzf)'
alias ncp='cd ~/NORDCLOUD/$(find ~/NORDCLOUD -type d | fzf)'
alias k='kubectl'

# fzf select context
alias ksc='kubectl config get-contexts -o name | fzf --prompt "Choose context: " | xargs kubectl config use-context'
# show current context
alias kgc='kubectl config current-context'

if [[ -z "$TMUX" ]]; then
    if tmux has-session 2>/dev/null; then
        tmux attach
    else
        tmux
    fi
fi

