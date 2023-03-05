BREW_EXIST=`brew -v 2> /dev/null; echo $?`
CASK_ENV_FLAG=${HOMEBREW_CASK_OPTS}
JAVA_ENV_FLAG=${JAVA_HOME}
ARG=$1

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

if [ "$BREW_EXIST" -eq 127 ]; then
	if [[ ! "$PATH" =~ "$HOME/goinfre/brew/bin" ]]; then
		echo "export PATH=\$HOME/goinfre/brew/bin:\$PATH" >> $HOME/.zshrc
		export PATH="$PATH:$HOME/goinfre/brew/bin"
	fi
	#if [ -z "$CASK_ENV_FLAG" ]; then
	#	"export HOMEBREW_CASK_OPTS=\"--appdir=\$HOME/goinfre/Applications\"" >> $HOME/.zshrc
	#	export HOMEBREW_CASK_OPTS="--appdir=$HOME/goinfre/Applications"
	#fi
	git clone --depth=1 https://github.com/Homebrew/brew $HOME/goinfre/brew
	
	cd $HOME/goinfre/brew
	git fetch origin 3.5.10
	git reset --hard c5731faf8be1ddc1eeae4b162b88bd76318fc279
	cd -
	brew install ncdu
	brew install lsd
	brew install bat
	brew install nvm
	brew install --cask clion
	ln -s "$HOME/goinfre/Applications/CLion.app" "$HOME/Applications/CLion.app"
	rm -rf ~/Library/Caches/JetBrains/CLion2022.1/caches/*
	rm -rf ~/Library/Caches/JetBrains/CLion2022.2/caches/*
	rm -rf ~/Library/Caches/Homebrew/downloads/*
fi

if [ "$ARG" == "java" ]; then
	java
elif [ "$ARG" == "clean" ]; then
	clean
elif [ "$ARG" == "fclean" ]; then
	fclean
fi
