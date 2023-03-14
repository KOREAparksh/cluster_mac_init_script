BREW_EXIST=`brew -v 2> /dev/null; echo $?`
CASK_ENV_FLAG=${HOMEBREW_CASK_OPTS}
JAVA_ENV_FLAG=${JAVA_HOME}
ARG=$1

rm -rf ~/Library/Caches/vscode-cpptools/*
rm -rf ~/Library/Caches/com.google.SoftwareUpdate
rm -rf ~/Liibrary/Application\ Support/Slack/Service/Service\ Worker/*
rm -rf ~/Liibrary/Application\ Support/Slack/Service\ Worker/*
rm -rf ~/Library/Application\ Support/Slack/Cache/*
rm -rf ~/Library/Application\ Support/Code/User/worksapceStorage/

mkdir -p "$HOME/goinfre/Applications"

export HOMEBREW_CASK_OPTS="--appdir=$HOME/goinfre/Applications"

function java() {
	if [ -z "$JAVA_ENV_FLAG" ]; then
		"export JAVA_HOME=\"\$HOME/goinfre/amazon-corretto-17.jdk/Contents/Home\"" >> $HOME/.zshrc
	fi
	if [[ ! "$PATH" =~ "$HOME/goinfre/amazon-corretto-17.jdk/Contents/Home/bin" ]]; then
		"export PATH=\"\$PATH:\$JAVA_HOME/bin\"" >> $HOME/.zshrc
	fi
	if [ ! -e "$HOME/goinfre/amazone-corretto-17.jdk" ]; then
		
		cd $HOME/goinfre
		curl -LO https://corretto.aws/downloads/latest/amazon-corretto-17-x64-macos-jdk.tar.gz
		tar -xzvf $HOME/goinfre/amazon-corrette-17-x64-maxos-jdk.tar.gz
		cd -
	fi
	brew install --cask postman dbeaver-community intellij-idea
}

function clean() {
	rm -rf $HOME/goinfre/brew 1> /dev/null
}

function fclean() {
	echo "fclean"
}

function js() {
	rm -rf ~/.nvm
	rm -rf ~/.npm
	sleep 5
	brew install nvm
	sleep 5
	mkdir ~/.nvm
	sleep 5
	nvm install --lts
	sleep 5
	npm install -g yarn
	sleep 5
	npm i -g @nestjs/cli
	sleep 5
	brew install postgresql
	sleep 5
	yarn add pg typeorm @nestjs/typeorm --save
	#pg : nestJS 와 postgresql을 연동할 수 있는 모듈. mysql npm 모듈과 비슷.
	#typeorm 
	#@nestjs/typeorm 
}

if [ "$BREW_EXIST" -eq 127 ]; then
	if [[ ! "$PATH" =~ "$HOME/goinfre/brew/bin" ]]; then
		echo "export PATH=\$HOME/goinfre/brew/bin:\$PATH" >> $HOME/.zshrc
		export PATH="$PATH:$HOME/goinfre/brew/bin"
	fi
	#if [ -z "$CASK_ENV_FLAG" ]; then
		# "export HOMEBREW_CASK_OPTS=\"--appdir=\$HOME/goinfre/Applications\"" >> $HOME/.zshrc
		# export HOMEBREW_CASK_OPTS="--appdir=$HOME/goinfre/Applications"
	#fi
	git clone --depth=1 https://github.com/Homebrew/brew $HOME/goinfre/brew
	
	cd $HOME/goinfre/brew
	git fetch origin 3.5.10
	git reset --hard c5731faf8be1ddc1eeae4b162b88bd76318fc279
	cd -
	brew update
	brew install bat
	brew install --cask clion
	ln -s "$HOME/goinfre/Applications/CLion.app" "$HOME/Applications/CLion.app"
	#brew install lsd
	rm -rf ~/Library/Caches/JetBrains/CLion2022.1/caches/*
	rm -rf ~/Library/Caches/JetBrains/CLion2022.2/caches/*
	rm -rf ~/Library/Caches/Homebrew/downloads/*
fi

if [ "$ARG" == "java" ]; then
	java
elif [ "$ARG" == "js" ]; then
	js
elif [ "$ARG" == "clean" ]; then
	clean
elif [ "$ARG" == "fclean" ]; then
	fclean
fi
