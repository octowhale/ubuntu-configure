#!/bin/bash
#
#


function ssh(){
    [ -f ~/.ssh/config ] && {
        mv ~/.ssh/config{,.bak_$(date +%F_%H)}
    }
    cp .ssh ~/
}

function pip(){
    which pip || {
        sudo apt install python-pip
    }

    cp .pip ~/
}

function stormssh(){
    which storm || {
        sudo pip install stormssh
    }

    [ -f ~/.stormssh/config ] && {
        mv ~/.stormssh/config{,.bak_$(date +%F_%H)}
    }
    cp .stormssh ~/
}

function ohmyzsh(){
    sudo apt install git zsh
    sudo bash -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    sudo echo "PS1='${ret_status} ${USER} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'" >> $ZSH/oh-my-zsh.sh 
}



select var in ssh pip stormssh ohmyzsh
do
    case $var in
    all)
        ssh; pip; stormssh; ohmyzsh ;;
    ssh|pip|stormssh|ohmyzsh) 
        $var ;;
    *)
        exit 1 ;;
    esac

done
