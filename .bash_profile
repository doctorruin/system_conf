# This file overrides the .profile, so set standard stuff first before the fancy stuff

# if running bash
 if [ -n "$BASH_VERSION" ]; then
	     # include .bashrc if it exists
	         if [ -f "$HOME/.bashrc" ]; then
			         . "$HOME/.bashrc"
				     fi
 fi

 # set PATH so it includes user's private bin if it exists
 if [ -d "$HOME/bin" ] ; then
	     PATH="$HOME/bin:$PATH"
 fi

 # set PATH so it includes user's private bin if it exists
 if [ -d "$HOME/.local/bin" ] ; then
	     PATH="$HOME/.local/bin:$PATH"
 fi

 # below add the git info to bash

parse_git_branch() {
	     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
     }

export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
