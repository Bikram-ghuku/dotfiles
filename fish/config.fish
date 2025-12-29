# Disable Fish welcome message
set -g fish_greeting

# Git branch prompt function
function fish_vcs_prompt
    if command -q git
        if git rev-parse --is-inside-work-tree >/dev/null 2>&1
            set branch (git branch --show-current 2>/dev/null)
            if test -n "$branch"
                echo -n "[$branch]"
            end
        end
    end
end

# Prompt function
function fish_prompt
    set_color purple
    echo -n (whoami) '@' (uname -n) ' '
    set_color cyan
    echo -n (prompt_pwd) ' '
    set_color green
    echo -n (fish_vcs_prompt) ' '
    set_color yellow
    echo -n '❯ '
    set_color normal
end

# Run fastfetch if installed
if type -q fastfetch
    fastfetch
end

set -gx EDITOR nano
set -gx LANG en_US.UTF-8
