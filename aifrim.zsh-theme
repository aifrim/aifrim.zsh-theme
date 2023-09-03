node_version() {
  if [ -f ./package.json ]; then
    local name=$(cat package.json | grep "name" -m1 | sed -r 's/"name": |"|,|\ //g')
    local version=$(cat package.json | grep "version" -m1 | sed -r 's/"version": |"|,|\ //g')

    echo "$AIFRIM_THEME_NODE_NAME_PREFIX$name$AIFRIM_THEME_NODE_NAME_SUFFIX@$AIFRIM_THEME_NODE_VERSION_PREFIX$version$AIFRIM_THEME_NODE_VERSION_SUFFIX"
  fi
}

rust_version() {
  if [ -f ./Cargo.toml ]; then
    local name=$(cat Cargo.toml | grep "name = " -m1 | sed -r 's/name = |"|,|\ //g')
    local version=$(cat Cargo.toml | grep "version = " -m1 | sed -r 's/version = |"|,|\ //g')

    echo "$AIFRIM_THEME_RUST_NAME_PREFIX$name$AIFRIM_THEME_RUST_NAME_SUFFIX@$AIFRIM_THEME_RUST_VERSION_PREFIX$version$AIFRIM_THEME_RUST_VERSION_SUFFIX"
  fi
}

go_version() {
  if [ -f ./go.mod ]; then
    local name=$(cat go.mod | grep "module " -m1 | sed -r 's/module |"|,|\ |\/v[0-9]*//g')
    local version=$(cat go.mod | grep "v[0-9]*" -o -m1)

    if [ -z "$version" ]; then
      version="v1"
    fi

    echo "$AIFRIM_THEME_GO_NAME_PREFIX$name$AIFRIM_THEME_GO_NAME_SUFFIX@$AIFRIM_THEME_GO_VERSION_PREFIX$version$AIFRIM_THEME_GO_VERSION_SUFFIX"
  fi
}

PROMPT='    '
PROMPT+="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[bright-red]%}➜ ) %{$fg[cyan]%}%2c%{$reset_color%}"
PROMPT+='$(git_prompt_info)'
PROMPT+='$(git_commits_ahead)'
PROMPT+='$(git_commits_behind)'
PROMPT+='$(node_version)'
PROMPT+='$(rust_version)'
PROMPT+='$(go_version)'
PROMPT+=' $FX[bold]${FG[105]}»%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$FX[bold]$FG[167]%}git:(%{$FG[172]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[167]%})%{$fg[yellow]%} ✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[167]%})"

ZSH_THEME_GIT_COMMITS_AHEAD_PREFIX=" %{$fg_bold[green]%}↑%{$fg_no_bold[green]%} "
ZSH_THEME_GIT_COMMITS_AHEAD_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_COMMITS_BEHIND_PREFIX=" %{$FX[bold]$FG[132]%}↓%{$FX[no-bold]${FG[132]}%} "
ZSH_THEME_GIT_COMMITS_BEHIND_SUFFIX="%{$reset_color%}"

AIFRIM_THEME_NODE_NAME_PREFIX=" %{$FG[110]%}"
AIFRIM_THEME_NODE_NAME_SUFFIX=""
AIFRIM_THEME_NODE_VERSION_PREFIX="%{$FX[bold]$FG[110]%}"
AIFRIM_THEME_NODE_VERSION_SUFFIX="%{$reset_color%}"

AIFRIM_THEME_RUST_NAME_PREFIX=" %{$FG[110]%}"
AIFRIM_THEME_RUST_NAME_SUFFIX=""
AIFRIM_THEME_RUST_VERSION_PREFIX="%{$FX[bold]$FG[110]%}"
AIFRIM_THEME_RUST_VERSION_SUFFIX="%{$reset_color%}"

AIFRIM_THEME_GO_NAME_PREFIX=" %{$FG[110]%}"
AIFRIM_THEME_GO_NAME_SUFFIX=""
AIFRIM_THEME_GO_VERSION_PREFIX="%{$FX[bold]$FG[110]%}"
AIFRIM_THEME_GO_VERSION_SUFFIX="%{$reset_color%}"
