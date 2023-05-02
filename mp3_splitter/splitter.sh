#!/usr/bin/env bash
## version: v0.1.0
## dev: kaung yar zar 


if [ -z "${1}" ]; then
       echo "Usage: ./splitter.sh <large_file.mp3> <tracklist.txt>"
       exit 0
fi

source lib/utils.sh

# logging
log_file="/tmp/splitter_$(date +%T).log"


# read input args
input_file="${1}"
track_list="${2}"

# parse input file
name=$(get_file_name "${input_file}")
ext=$(get_file_ext "${input_file}")

# check supported file format (MP3)
if [ "${ext}" != "mp3" ]; then
	echo "Only support for mp3 file."
	exit 1
fi

# create output result dir by input file name
if [ ! -d "${name}" ]; then
	mkdir "${name}"
fi

readarray -t trackList < "${track_list}"
index=0
last_index=$((${#trackList[@]}-1))


for each in "${trackList[@]}"
do	
	current=$index
	next=$((current + 1))
	ss="$(echo ${trackList[$current]} | awk '{print $1}')"
	to="$(echo ${trackList[$next]} | awk '{print $1}')"
	song_name="$(echo ${trackList[$current]} | cut -d " " -f 2-)"

	if [ $last_index -eq $current ]; then
		to=$(get_last_time "${input_file}")
	fi

	show_progress $((current+1)) $((last_index + 1)) "${song_name}"
	split_file "${input_file}" $ss $to "${name}/${song_name}.mp3" >>"$log_file" 2>&1

	#Increase index counter.
	index=$next
done
