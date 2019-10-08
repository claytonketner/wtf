#!/bin/bash

# wtf
#
# Create your own help files for different directories. Good for storing handy
# commands or just notes. Stores the wtf files in ~/wtfs
#
# - Create a new wtf for the current directory with `mkwtf`
# - Read your wtf for the current directory with `wtf`

function _get_wtf_file {
	# Convenience function for getting the path to the wtf file for the pwd
	for file in `find ~/wtfs -type f`; do
		first_line=`head -n 1 $file`
		if [[ "$PWD" = "$first_line"* ]]; then
			# Match!
			echo $file
			return 0
		fi
	done
	echo ""
	return 1
}
function mkwtf {
	# Creates a new wtf file for the current directory
	current_dir=${PWD##*/}  # Current dir w/o full path
	new_filename=~/wtfs/$current_dir
	if [[ -f $new_filename ]]; then
		echo "$new_filename already exists!"
		echo "Aborting"
		return 1
	else
		touch $new_filename
		echo "$PWD" > $new_filename
		echo -e "---\nPut your help text below\n---\n\n" >> $new_filename
		echo "Created $new_filename - go edit it (try \`editwtf\`)!"
		return 0
	fi
}
function editwtf {
	# Opens the wtf file for the current directory in a text editor
	wtf_file=$(_get_wtf_file)
	if [[ $? = 0 ]]; then
		$EDITOR $wtf_file
	else
		echo "Cannot edit WTF file because it wasn't found. Maybe make one with \`mkwtf\`?"
		return 1
	fi
}
alias ewtf=editwtf
function wtf {
	# Looks up a help file from ~/wtfs
	wtf_file=`_get_wtf_file`
	if [[ $? = 0 ]]; then
		wtf_text=`tail -n +5 $wtf_file`  # Omit the text in the first few lines
		echo "$wtf_text"
		echo ""
		return 0
	fi
	echo "WTF file not found. Maybe make one with \`mkwtf\`?"
	return 1
}
