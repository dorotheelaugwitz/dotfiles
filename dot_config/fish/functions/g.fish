# ~/.config/fish/functions/g.fish

function g --wraps git --description 'git status with no args, otherwise git <args>'
    if test (count $argv) -gt 0
        git $argv
    else
        git status
    end
end
