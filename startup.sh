#!/bin/bash

#1. place this script on Desktop
#2. chmod +x ~/Deskop/startup.sh
#3. ls -l shows that startup.sh is an executable file
#4. ./startup.sh      to execute file
#4. /bin/bash ./startup.sh (alternatively)

#wird weiter unten benötigt:
Filebashrc=~/.bashrc

echo " "
echo "@install build-essential, update, upgrade, dist upgrade"
echo "@install install automake, install checkinstal"
echo "Do this? (y/n); type y for yes, n for no"
read ANSWER
if [ "$ANSWER" == "y" ]
    then
        sudo apt-get install build-essential
	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get dist upgrade
	sudo apt-get install automake
	sudo apt-get install checkinstall
    else
        echo "nothing installed or updated etc."
fi

echo " "
echo "@install vim, tree?"
echo "Do this? (y/n); type y for yes, n for no"
read ANSWER
if [ "$ANSWER" == "y" ]
    then
	sudo apt-get install vim
	sudo apt-get install tree
    else
        echo "nothing installed or updated etc."
fi

echo " "
echo "@install git?"
echo "@info: Setup git:"
echo "git config --global user.name \"Your Name\""
echo "git config --global user.email \"youremail@domain.com\" "
echo "@info: Create a new repository"
echo "go to https://github.com/CesMak create new repository"
echo "create a new directory in your ubuntu machine and go in that directory"
echo "echo \"# dirname\" >> README.md"
echo "git init"
echo "git add README.md"
echo "git commit -m \"commit name\" "
echo "git remote add origin https://github.com/CesMak/repository_name"
echo "git push -u origin master"
echo "if that does not work: git push -f origin master"
echo "@info usefull commands:"
echo "git status"
echo "git remote -v -> list all currently configured remote repos"
echo "git fetch origin"
echo "git reset --hard origin/master -> download latest history."
echo "git add *"
echo "git commit -a"
echo "git push origin master"
echo "git branch -> list all branches in your repo"
echo "git push origin <branch name>"
echo "Do this? (y/n); type y for yes, n for no"
read ANSWER
if [ "$ANSWER" == "y" ]
    then
	sudo apt-get install git
    else
        echo "nothing installed or updated etc."
fi

echo " "
echo "@configure vim nicecly (syntax on, automatically set numbers)"
echo "@install autostyle c++ code "
echo "@usage inside vim: :%!astyle)"
echo "Do this? (y/n); type y for yes, n for no"
read ANSWER
if [ "$ANSWER" == "y" ]
    then
	echo "set number" >> ~/.vimrc
	echo "syntax on" >> ~/.vimrc
	sudo apt-get install astyle
    else
        echo "nothing installed or updated etc."
fi


echo " "
echo "@configure .bashrc nicecly (auto arrow up enable, highlight terminal, find function)"
echo "@usage open new terminal to see if highlighting works!"
echo "@usage fn ""*.txt"" equivalent to find . -name ""*.txt"" -print (y,n)"
echo "Do this? (y/n); type y for yes, n for no"
read ANSWER
if [ "$ANSWER" == "y" ]
    then
	 if grep -q history-search-backward "$Filebashrc"; then
   	     echo "history-search-backward already ok."
	   else
	   echo "bind '\"\e[A\": history-search-backward'" >> ~/.bashrc
 	fi

	 if grep -q history-search-forward "$Filebashrc"; then
   	     echo "history-search-forward already ok."
	   else
	   echo "bind '\"\e[B\": history-search-forward'" >> ~/.bashrc
 	fi

	# ersetzen - geht problemlos:
	sed  -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' ~/.bashrc

	if grep -q fn "$Filebashrc"; then
   	     echo "find fn() ... should already work!"
	   else
		echo "fn () { " >> ~/.bashrc
	   	echo "find . -name \"\$1\" -print ">> ~/.bashrc
		echo "}" >> ~/.bashrc
 	fi

	source ~/.bashrc
    else
        echo "nothing installed or updated etc."
fi

echo " "
echo "@install ros indigo full desktop"
echo "Do this? (y/n); type y for yes, n for no"
read ANSWER
if [ "$ANSWER" == "y" ]
    then
	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get update
sudo apt-get install ros-indigo-desktop-full
	sudo rosdep init
	rosdep update
	echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
	source ~/.bashrc
	echo "in a new terminal try: roscore"
	echo "in case of error try:"
	echo "rosdep update (without sudo!)"
	echo "sudo rosdep fix-permissions"
    else
        echo "nothing installed or updated etc."
fi

echo " "
echo "@install qt creator plugin for ROS?"
echo "@usage  New project import ROs project workspace!"
echo "@usage Tools Options fonts and colors set to dark ros."
echo "Do this? (y/n); type y for yes, n for no"
read ANSWER
if [ "$ANSWER" == "y" ]
    then
	sudo add-apt-repository ppa:levi-armstrong/qt-libraries-trusty
	sudo add-apt-repository ppa:levi-armstrong/ppa  
	sudo apt-get update && sudo apt-get install qt57creator-plugin-ros
    else
        echo "nothing installed or updated etc."
fi


echo " "
echo "@configure setup SSH - Keys"
echo "@usage  generate a SSH Key you have to enter in GITLAB"
echo "@usage Only if you setup this key you have access to turtlebot1, etc. "
echo "@usage in case of file to store your key etc. just press enter"
echo "@param Enter your E-Mail Address: e.g: lamprecht@sim.tu-darmstadt.de"
echo "Do this? (y/n); type y for yes, n for no"
read ANSWER
if [ "$ANSWER" == "y" ]
    then
	echo "@usage check for given keys: ls -al ~/.ssh: "
	ls -al ~/.ssh
	echo "Enter your E-Mail Address: e.g: lamprecht@sim.tu-darmstadt.de"
	read EMAIL
	ssh-keygen -t rsa -C EMAIL -b 4096
	echo "@install xclip:"
	sudo apt-get install xclip
	echo "@copy the following key into your gitlab account under user change SSH Keys"
	cat ~/.ssh/id_rsa.pub
    else
        echo "nothing installed or updated etc."
fi

echo " "
echo "@install turtlebot3?"
echo "@usage  New project import ROs project workspace!"
echo "@usage Tools Options fonts and colors set to dark ros."
echo "Do this? (y/n); type y for yes, n for no"
read ANSWER
if [ "$ANSWER" == "y" ]
    then
	cd ~/
	mkdir turtlebot3
	cd turtlebot3

git clone git@git.sim.informatik.tu-darmstadt.de:TurtleBot/turtlebot_install.git . -b turtlebot3
./install.sh
echo "source ~/turtlebot3/setup.bash" >> ~/.bashrc
    else
        echo "nothing installed or updated etc."
fi

echo " "
echo "@install telegram?"
echo "@info  Messenger program!"
echo "Do this? (y/n); type y for yes, n for no"
read ANSWER
if [ "$ANSWER" == "y" ]
    then
	sudo apt-add-repository -y 'ppa:atareao/telegram'; sudo apt-get update; sudo apt-get -y install telegram 
fi

echo " "
echo "@install shutter?"
echo "@info  a snipping tool "
echo "Do this? (y/n); type y for yes, n for no"
read ANSWER
if [ "$ANSWER" == "y" ]
    then
	sudo apt-get install shutter
fi