if status is-interactive
    # Commands to run in interactive sessions can go here
    command inxi -PBxz

    function fish_prompt -d "Write out the prompt"
        set st $status
        set_color -o
        set -l user_emoji '👤'
        if test -n "$SSH_CONNECTION"
            # set user_emoji '⚡'
            set user_emoji '🌐'
        end
        set -l user_char '> '
        if fish_is_root_user
            set user_char '# '
        end
        # $USER $HOSTNAME $PWD
        printf '%s %s%s%s%s%s%s%s%s' \
            $user_emoji \
            (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) \
            (fish_git_prompt) \
            (set_color $fish_color_status) "[$st]" (set_color normal) \
            $user_char
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
function sga 
    cd ~/Workspaces/spyke/spyke-gateway $argv
end

# personal stuff
function blog
    cd ~/Workspaces/personal/yashdiniz.github.io $argv
end
