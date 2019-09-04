setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY
setopt CORRECT
setopt EXTENDED_HISTORY
setopt MENUCOMPLETE
setopt ALL_EXPORT
unsetopt BG_NICE

# Set/unset shell options.
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash


# Autoload zsh modules when they are referenced.
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
# zmodload -ap zsh/mapfile mapfile

TERM=xterm-256color
HISTFILE=$HOME/.zhistory
HISTSIZE=10000
SAVEHIST=10000
HOSTNAME="`hostname`"
PAGER='less'
EDITOR='vim'
    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
   colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
   eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
   eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
   (( count = $count + 1 ))
    done
    PR_NO_COLOR="%{$terminfo[sgr0]%}"
RPS1="$PR_MAGENTA(%D{%m-%d %H:%M})$PR_NO_COLOR"
LC_ALL='en_US.UTF-8'
LANG='en_US.UTF-8'
LC_CTYPE=C
if [ $SSH_TTY ]; then
  MUTT_EDITOR=vim
else
  MUTT_EDITOR=emacsclient.emacs-snapshot
fi

unsetopt ALL_EXPORT

autoload -U compinit
compinit
# Updates editor information when the keymap changes.
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}

# Ensure that the prompt is redrawn when the terminal size changes.
# TRAPWINCH() {
#   zle &&  zle -R
# }

# zle -N zle-keymap-select
# zle -N edit-command-line


bindkey -v

# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# allow ctrl-r to perform backward search in history
bindkey '^r' history-incremental-search-backward
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# allow ctrl-a and ctrl-e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST
export LS_COLORS="d=i1;;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Completion Styles
## list of completers to use
# zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
## allow one error for every three characters typed in approximate completer
# zstyle -e ':completion:*:approximate:*' max-errors \
    # 'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
## insert all expansions for expand completer
# zstyle ':completion:*:expand:*' tag-order all-expansions
# ## formatting and messages
# zstyle ':completion:*' verbose yes
# zstyle ':completion:*:descriptions' format '%B%d%b'
# zstyle ':completion:*:messages' format '%d'
# zstyle ':completion:*:warnings' format 'No matches for: %d'
# zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
# zstyle ':completion:*' group-name ''
# ## match uppercase from lowercase
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# ## offer indexes before parameters in subscripts
# zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
# ## command for process lists, the local web server details and host completion
# ## on processes completion complete all user processes
# ## zstyle ':completion:*:processes' command 'ps -au$USER'
# ## add colors to processes for kill completion
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
# zstyle ':completion:*:processes-names' command 'ps axho command'
# ## All /etc/hosts hostnames are in autocomplete
# zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}')
# ## Filename suffixes to ignore during completion (except after rm command)
# zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
#     '*?.old' '*?.pro'
# ## ignore completion functions (until the _ignored completer)
# zstyle ':completion:*:functions' ignored-patterns '_*'
# zstyle ':completion:*:*:*:users' ignored-patterns \
#         adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
#         named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
#         rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
#         avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
#         firebird gnats haldaemon hplip irc klog list man cupsys postfix\
#         proxy syslog www-data mldonkey sys snort

# # SSH Completion
# zstyle ':completion:*:scp:*' tag-order \
#    files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
# zstyle ':completion:*:scp:*' group-order \
#    files all-files users hosts-domain hosts-host hosts-ipaddr
# zstyle ':completion:*:ssh:*' tag-order \
#    users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
# zstyle ':completion:*:ssh:*' group-order \
#    hosts-domain hosts-host users hosts-ipaddr
# zstyle '*' single-ignored show

# Start SSH agent.
SSH_ENV="$HOME/.ssh/environment"
function start_agent {
echo "Initialising new SSH agent..."
/usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
echo succeeded
chmod 600 "${SSH_ENV}"
. "${SSH_ENV}" > /dev/null
/usr/bin/ssh-add;
}

if [ -f "${SSH_ENV}" ]; then
. "${SSH_ENV}" > /dev/null
ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
start_agent;
}
else
start_agent;
fi

# Set alias.
alias man='LC_ALL=C LANG=C man'
alias v="vim"
alias vi="vim"
alias ls='ls -G '
alias ll="ls -la"
alias ads="cd ~/projects/tenmax-ads-web"
alias ads-api="cd ~/projects/tenmax-ads"
alias adcode="cd ~/projects/ads-adcode"
alias imax="cd ~/projects/tenmax-imax-web"


alias gss="git stash save"
alias gsp="git stash pop"
# Environment Variables.
export TZ="/usr/share/zoneinfo/Asia/Taipei"
export MAVEN_HOME=/home/m/lib/maven
export PATH="/usr/local/bin:/usr/local/sbin/:/bin:/sbin:/usr/bin:/usr/sbin:/home/{$USER}/bin:${PATH}"
export PATH="/opt/flex/bin:/opt/fdbuild:${PATH}"
export NODE_PATH="/usr/lib/node_modules:${PATH}"
# get the name of the branch we are on
#git_prompt_info() {
#      ref=$(git symbolic-ref HEAD 2> /dev/null) || return
#            echo "(${ref#refs/heads/})"
#}
export LSCOLORS="gxfxcxdxcxegedabagacad"
 setopt prompt_subst

export DEV_ROOT=/home/${USER}/
# export DEV_PORT=<YOUR DEV_PORT>
export SITE_ENV=develop
source ~/.git-completion

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
# PS1='%{$fg[green]%}%n@%m %{$fg[cyan]%}%~ %{$fg[red]%}$(__git_ps1 "( %s)")%{$reset_color%}
# % > '
#PS1='%{$fg[green]%}%n@%m %~ %{$fg[red]%}$(__git_ps1 "(%s)")%{$reset_color%} %# '
#PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
eval $(keychain --eval --agents ssh -Q --quiet id_rsa)


# ZSH=$HOME/.oh-my-zsh

#source ~/.zsh-nvm/zsh-nvm.plugin.zsh
# zsh-completions
# fpath=(/usr/local/share/zsh-completions $fpath)

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

export JAVA_HOME=$(/usr/libexec/java_home)
# export NODE_PATH=$NODE_PATH:/Users/kevin/.nvm/versions/node/v4.3.1/lib/node_modules
cd ~/projects/

# export PATH=$PATH:/Users/kevin/bin

# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
#
# Mar 2013 Yad Smood

# VCS
YS_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}x"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}o"

# Git info
local git_info='$(__git_ps1 "( %s)")'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}git${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

# HG info
local hg_info='$(ys_hg_prompt_info)'
ys_hg_prompt_info() {
    # make sure this is a hg dir
    if [ -d '.hg' ]; then
        echo -n "${YS_VCS_PROMPT_PREFIX1}hg${YS_VCS_PROMPT_PREFIX2}"
        echo -n $(hg branch 2>/dev/null)
        if [ -n "$(hg status 2>/dev/null)" ]; then
            echo -n "$YS_VCS_PROMPT_DIRTY"
        else
            echo -n "$YS_VCS_PROMPT_CLEAN"
        fi
        echo -n "$YS_VCS_PROMPT_SUFFIX"
    fi
}

local exit_code="%(?,,C:%{$fg[red]%}%?%{$reset_color%})"

# Prompt format:

# PRIVILEGES USER @ MACHINE in DIRECTORY on git:BRANCH STATE [TIME] C:LAST_EXIT_CODE
# $ COMMAND

# For example:

# % ys @ ys-mbp in ~/.oh-my-zsh on git:master x [21:47:42] C:0
# $
PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[cyan]%}%n)\
%{$fg[white]%}@\
%{$fg[green]%}%m \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
${hg_info}\
${git_info}\
 \
%{$fg[white]%}[%D %*] $exit_code
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kevin/projects/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/kevin/projects/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kevin/projects/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/kevin/projects/google-cloud-sdk/completion.zsh.inc'; fi

##-begin-npm-completion-###

# npm command completion script

# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm


if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
##-end-npm-completion-###

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn
