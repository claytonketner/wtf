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
	best_match=""
	best_match_file=""
	for file in `find ~/wtfs -type f`; do
		first_line=`head -n 1 $file`
		# Find the deepest match
		if [[ "$PWD" = "$first_line"* ]]; then
			if [[ ${#first_line} > ${#best_match} ]]; then
				best_match="$first_line"
				best_match_file="$file"
			fi
		fi
	done
	echo $best_match_file
	if [[ $best_match_file = "" ]]; then
		return 1
	else
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
function mkwtf {
	# Creates a new wtf file for the current directory
	filename=$(echo $PWD | sed -e "s/\//_/g")
	filepath=~/wtfs/$filename
	if [[ -f $filepath ]]; then
		echo "$filepath already exists!"
		echo "Aborting"
		return 1
	else
		touch $filepath
		echo "$PWD" > $filepath
		echo -e "---\nPut your help text below\n---\n" >> $filepath
		echo "Created $filepath. Opening it for editing..."
		editwtf
		return 0
	fi
}
function wtf {
	# Looks up a help file from ~/wtfs
	wtf_file=$(_get_wtf_file)
	if [[ $? = 0 ]]; then
		wtf_text=`tail -n +5 $wtf_file`  # Omit the text in the first few lines
		echo "$wtf_text"
		echo ""
		return 0
	fi
	echo "WTF file not found. Maybe make one with \`mkwtf\`?"
	return 1
}
