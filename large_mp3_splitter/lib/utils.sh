#!/usr/bin/env bash

show_progress () {
    local bar_size=40
    local bar_char_done="#"
    local bar_char_todo="-"
    local bar_percentage_scale=2
    local current="$1"
    local total="$2"
    local msg="${3}"

    # calculate the progress in percentage
    local percent=$(bc <<< "scale=$bar_percentage_scale; 100 * $current / $total" )
    # The number of done and todo characters
    local done=$(bc <<< "scale=0; $bar_size * $percent / 100" )
    local todo=$(bc <<< "scale=0; $bar_size - $done" )

    # build the done and todo sub-bars
    local done_sub_bar=$(printf "%${done}s" | tr " " "${bar_char_done}")
    local todo_sub_bar=$(printf "%${todo}s" | tr " " "${bar_char_todo}")

    # output the bar
    echo -ne "\rProgress : [${done_sub_bar}${todo_sub_bar}] ${percent}% [$msg]"

    if [ $total -eq $current ]; then
        echo -e "\nDONE"
    fi
}

get_file_name () {
    echo "${1%.*}"
}

get_file_ext () {
    echo "${1##*.}"
}

escape_special_chrs () {
    echo "${1}" | sed 's/[&/\,^$*.[]/\\&/g; s/ /\\ /g'
}

split_file () {
    local input_file=$(escape_special_chrs "${1}")
    local ss=${2}
    local to=${3}
    local output_file=$(escape_special_chrs "${4}")
    cmd="ffmpeg -i $input_file -ss $ss -to $to $output_file >/dev/null 2>&1"
    # echo $cmd
    eval $cmd
}

get_last_time () {
    local t_sec=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "${1}")
    echo $(echo $t_sec | awk '{printf("%02d:%02d:%02d\n",int($1/3600),int($1/60%60),int($1%60))}')
}