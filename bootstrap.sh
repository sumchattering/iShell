#! /bin/bash
#
# Created By Sumeru Chatterjee 10/06/11
#
# Basically this will call bootstrap.sh in all the subdirectories.

echo "Bootstrapping ${PWD##*/}..."

export OLDPATH=$PATH

execute() {
	cat ${1} | grep -i "export path=" > exports.bash
	if [ -s exports.bash ]; then source exports.bash; rm exports.bash;fi;
	bash ${1}
}

#bootstrap all other folders if they have a bootstrapper
for dir in ./*/
do
    if [[ -f $dir/bootstrap.sh ]]
    then
        if [[ ! $dir == "./dotfiles/" ]]; then echo ""; cd $dir ; execute bootstrap.sh ;cd .. ;fi;
    fi
done

#now bootstrap the dot files
if [[ -f ./dotfiles/bootstrap.sh ]]
then 
	echo ""
	cd ./dotfiles
	cat bootstrap.sh | grep -i "export path=" > exports.bash
	if [ -s exports.bash ]; then source exports.bash; rm exports.bash;fi;
	echo ${PATH%$OLDPATH} > .dynamicpaths
	bash bootstrap.sh
	cd ..
fi

