function fish_prompt
    set -l last_command_status $status
    set -l cwd

    if test "$theme_short_path" = 'yes'
        set cwd (basename (prompt_pwd))
    else
        set cwd (prompt_pwd)
    end
    set -l normal_color     (set_color normal)
    set -l error_color      (set_color red --bold)
    set -l directory_color  (set_color blue)
    echo -e "\b\b\b\b $directory_color$cwd$error_color:$normal_color "

end
