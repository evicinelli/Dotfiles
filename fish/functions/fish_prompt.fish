# You can override some default options with config.fish:
#
#  set -g theme_short_path yes

function fish_prompt
  set -l last_command_status $status
  set -l cwd

  if test "$theme_short_path" = 'yes'
    set cwd (basename (prompt_pwd))
  else
    set cwd (prompt_pwd)
  end

  set -l fish     "➜ " 
  set -l ahead    "↑ "
  set -l behind   "↓ "
  set -l diverged "⇕ "
  set -l dirty    "⨯ "
  set -l none     "◦ "

  set -l normal_color     (set_color normal)
  set -l success_color    (set_color green)
  set -l error_color      (set_color red --bold)
  set -l directory_color  (set_color blue)
  set -l repository_color (set_color cyan)
  set -l user_color       (set_color purple)
  set -l pc_color	  (set_color yellow)

  echo -n -s -e $user_color (whoami) $normal_color " at " $pc_color (hostname) $normal_color " in"
  if git_is_repo
    if test "$theme_short_path" = 'yes'
      set root_folder (command git rev-parse --show-toplevel ^/dev/null)
      set parent_root_folder (dirname $root_folder)
      set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")

      echo -n -s " " $directory_color $cwd $normal_color
    else
      echo -n -s " " $directory_color $cwd $normal_color
    end

    echo -n -s " on " $repository_color (git_branch_name) $normal_color " "

    if git_is_touched
      echo -n -s $dirty
    else
      echo -n -s (git_ahead $ahead $behind $diverged $none)
    end
  else
    echo -n -s " " $directory_color $cwd $normal_color
  end

  echo -n -s -e "\n "
    if test $last_command_status -eq 0
    echo -n -s $success_color $fish $normal_color
  else
    echo -n -s $error_color $fish $normal_color
  end
end
