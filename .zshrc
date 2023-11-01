# gitブランチ/ステータス表示
function rprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then 
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    branch_status=""
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    branch_status=" !"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    branch_status=" *"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    branch_status=" +"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    echo "%F{red} !!"
    return
  else
    branch_status=""
  fi
  echo "($branch_name${branch_status})"
}

# プロンプトが表示されるたび、毎回プロンプトの文字列を評価し、置換する
setopt prompt_subst

PROMPT='
%F{green}[%n@%m]%F{white}: %B%~%b `rprompt-git-current-branch`
$ '
