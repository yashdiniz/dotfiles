# setting up informative fit promot for fish
# https://fishshell.com/docs/current/cmds/fish_git_prompt.html
set -g __fish_git_prompt_show_informative_status true
set -g __fish_git_prompt_showuntrackedfiles false
set -g __fish_git_prompt_showdirtystate true
set -g __fish_git_prompt_showupstream "informative"

set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""
set -g __fish_git_prompt_color_branch --bold magenta

set -g __fish_git_prompt_char_cleanstate "✔"
set -g __fish_git_prompt_color_cleanstate --bold green
set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_char_invalidstate "✖"
set -g __fish_git_prompt_color_invalidstate red

if status is-interactive
    # Commands to run in interactive sessions can go here
    command inxi -PBxz

    function fish_prompt -d "Custom fish prompt"
        set_color -o
        set -l user_emoji '👤'
        set -l user_char '> '
        if fish_is_root_user
            set user_char '# '
        end
        printf '%s' \
            $user_emoji \
            (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) \
            (fish_git_prompt) \
            (set_color $fish_color_status) "[$status]" (set_color normal) \
            $user_char
    end

    function fish_right_prompt -d "Custom fish right prompt"
        set_color -o
        printf '%s' (set_color grey) (date +%b\ %e\ \'%y\,\ %R) (set_color normal)
    end
end

# aliases
# some cool widgets
#alias weather="curl https://wttr.in/?format=4"
function dy
    command dig +short @dns.toys $argv
end

# aliases for terminal convenience
function ga
    command git add $argv
end
function gc
    command git commit -S $argv
end
function gd
    command git diff $argv
end
function gg
    command lazygit $argv
end
function gst
    command git status $argv
end
function tmux
    command tmux -u $argv
end

# vim aliases to neovim
function vim
    command nvim $argv
end
# https://stackoverflow.com/a/70584930/13227113
function vimdiff
    command nvim -d $argv
end

# aliases to work folders (for yash@yash-IdeaPad-5-15ITL05)
function s
    cd ~/Workspaces/spyke $argv
end
function smom
    cd ~/Workspaces/spyke/minutes-of-meetings $argv
end
function sna
    cd ~/Workspaces/spyke/Spyke-FrontEnd $argv
end
function slp
    cd ~/Workspaces/spyke/spyke-landing-page $argv
end
function swa
    cd ~/Workspaces/spyke/Spyke-Web-App $argv
end
function sga 
    cd ~/Workspaces/spyke/spyke-gateway $argv
end
# approach aliases
function alp
    cd ~/Workspaces/spyke/approach-landing-page $argv
end
function afr
    cd ~/Workspaces/spyke/approach-frontend $argv
end
function aba
    cd ~/Workspaces/spyke/approach-backend $argv
end
function gcf
    cd ~/Workspaces/spyke/get-creative-goa-frontend $argv
end
function gcb
    cd ~/Workspaces/spyke/get-creative-goa-backend $argv
end

# personal stuff
function blog
    cd ~/Workspaces/personal/yashdiniz.github.io $argv
end
function fcsa
    cd ~/Workspaces/personal/measure_app $argv
end
function bs
    cd ~/Workspaces/personal/bee-slap $argv
end
function aoc
    cd ~/Workspaces/personal/aoc2023 $argv
end

# custom functions
zoxide init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/yash/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
