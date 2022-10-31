rm -rf ~/Library/Caches/vscode-cpptools/*
rm -rf ~/Library/Caches/com.google.SoftwareUpdate
rm -rf ~/Liibrary/Application\ Support/Slack/Service/Service\ Worker/*
rm -rf ~/Liibrary/Application\ Support/Slack/Service\ Worker/*

rm -rf ~/Library/Application\ Support/Slack/Cache/*
rm -rf ~/Library/Application\ Support/Code/User/worksapceStorage/

FLAG="$HOME/goinfre/brew_setup"
function install_brew() {
	#rm -rf ~/Library/Caches/vscode-cpptools/*
	#rm -rf ~/Library/Caches/com.google.SoftwareUpdate
	#rm -rf ~/Liibrary/Application\ Support/Slack/Service/Service\ Worker/*
	#rm -rf ~/Library/Application\ Support/Slack/Cache/*
	#rm -rf ~/Library/Application\ Support/Code/User/worksapceStorage/

    git clone --depth=1 https://github.com/Homebrew/brew $HOME/goinfre/brew
	cd $HOME/goinfre/brew
	git fetch origin 3.5.10
	git reset --hard c5731faf8be1ddc1eeae4b162b88bd76318fc279
	cd -
    echo 'export PATH=$HOME/goinfre/brew/bin:$PATH' >> $HOME/.zshrc
    echo 'export HOMEBREW_CASK_OPTS="--appdir=$HOME/goinfre/Applications"' >> $HOME/.zshrc
    source $HOME/.zshrc
    #brew update
    touch "$FLAG"
    
    rm -rf $HOME/Applications/CLion.app
    brew install --cask clion
    ln -s "$HOME/goinfre/Applications/CLion.app" "$HOME/Applications/CLion.app"
    brew install ncdu
    brew install lsd
	brew install bat
	rm -rf ~/Library/Caches/JetBrains/CLion2022.1/caches/*
	rm -rf ~/Library/Caches/JetBrains/CLion2022.2/caches/*
	rm -rf ~/Library/Caches/Homebrew/downloads/*
}
if [ ! -e "$FLAG" ]; then
    install_brew
fi
