if status is-interactive
  abbr -a df df -h
  abbr -a du du -h

  abbr -a g    git
  abbr -a ga   git add
  abbr -a gaa  git add --all
  abbr -a gb   git branch
  abbr -a gc   git commit
  abbr -a gco  git checkout
  abbr -a gcp  git cherry-pick
  abbr -a gdh  git diff HEAD
  abbr -a gf   git fetch
  abbr -a gl   git pull
  abbr -a glf  git ls-files
  abbr -a glol git lol
  abbr -a gme  git merge
  abbr -a gp   git push
  abbr -a gre  git rebase
  abbr -a gst  git status
  abbr -a gsta git stash
  abbr -a gstl git stash list
  abbr -a gstp git stash pop

  if test "$(uname)" = "Linux"
    abbr -a open xdg-open
  end
end
