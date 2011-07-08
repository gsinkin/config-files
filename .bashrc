if [ -d "$HOME/opt/bin" ] ; then
    PATH="$HOME/opt/bin:$PATH"
fi

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.gem/ruby/1.8/bin" ] ; then
    PATH="$HOME/.gem/ruby/1.8/bin:$PATH"
fi

# add macports path, if it exists
if [ -d "/opt/local/sbin" ] ; then
    PATH="/opt/local/sbin:$PATH"
fi

if [ -d "/opt/local/bin" ] ; then
    PATH="/opt/local/bin:$PATH"
    LIBRARY_PATH="/opt/local/include:/opt/include:$LIBRARY_PATH"
    LD_LIBRARY_PATH="/opt/local/lib:/opt/lib:$LD_LIBRARY_PATH"
    DYLD_LIBRARY_PATH="/opt/local/lib:$DYLD_LIBRARY_PATH"
fi

# add android path, if it exists
if [ -d "/opt/android-sdk-linux_86/tools/" ] ; then
    PATH="/opt/android-sdk-linux_86/tools/:$PATH"
fi

if [ -d "$HOME/.cabal/bin" ] ; then
    PATH=$PATH:~/.cabal/bin
fi

if [ -d "/var/lib/gems/1.8/bin" ] ; then
    PATH=$PATH:/var/lib/gems/1.8/bin
fi

if [ -d "/pluto" ] ; then
    PYTHONPATH=/pluto:/pluto/pycloud
    export PYTHONPATH
    export MAGIC_ENV=development
fi

if [ -d "/pluto/pycloud/apps/utils/bin" ] ; then
    PATH=$PATH:/pluto/pycloud/apps/utils/bin
fi

if [ -d "/opt/local/lib/postgresql84/bin/" ] ; then
    PATH="/opt/local/lib/postgresql84/bin/:$PATH"
fi

if [ -d "/opt/local/lib/postgresql90/bin/" ] ; then
    PATH="/opt/local/lib/postgresql90/bin/:$PATH"
    alias psql=psql90
fi

if [ -d "/usr/local/cuda/bin/" ] ; then
    PATH="/usr/local/cuda/bin/:$PATH"
fi

if [ -d "/home/jvanwink/.gem/ruby/1.8/gems/jekyll-0.6.2/bin/" ] ; then
    PATH="/home/jvanwink/.gem/ruby/1.8/gems/jekyll-0.6.2/bin/:$PATH"
fi

export EDITOR='emacs -nw'
export VISUAL=$EDITOR

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /usr/bin/ack-grep ]; then
    alias ack=ack-grep
fi

export LESS='-s'
alias more='less'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#if macports and coreutils installed
if [ -x /opt/local/bin/gls ]; then
    alias ls='gls --color=auto'
fi


alias gf='find | grep -v \.pyc$ | grep'
alias fa='find | ack-grep'
alias ggf='git ls-files | grep'
alias gg='git grep'
# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -x /pluto/local/activate-environment ]; then
    . /pluto/local/activate-environment
fi

# . ~/.profile
DEBEMAIL=justin.vanwinkle@gmail.com
DEBFULLNAME="Justin Van Winkle"
export DEBEMAIL DEBFULLNAME
