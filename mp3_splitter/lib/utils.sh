#!/usr/bin/env bash

show_progress () {
    local current="$1"
    local total="$2"
    local msg="$3"
    local width=40
    local max_msg_width=$((width - 5))  # maximum width of message
    local msg_width=${#msg}
    if (( msg_width > max_msg_width )); then
        msg="${msg:0:$((max_msg_width - 3))}..."  # truncate message and add ellipsis
        msg_width=${#msg}
    fi
    local percentage=$((current * 100 / total))
    local progress=$((current * (width - 14) / total))
    local remainder=$((width - 14 - progress))
    local done="$(printf '%*s' "$progress" | tr ' ' '#')"
    local todo="$(printf '%*s' "$remainder" | tr ' ' '-')"
    printf "\rProgress : [%s%s] %d%%\t%${max_msg_width}s" "$done" "$todo" "$percentage" "$msg"
    if (( current == total )); then
        printf "\nDONE\n"
    fi
}

get_file_name () {
    # arg = filename.ext
    # retrun `filename`
    
    echo "${1%.*}"
}

get_file_ext () {
    # arg = filename.ext
    # return `ext`
    
    echo "${1##*.}"
}

escape_special_chrs () {
    # arg = 'file name.ext'
    # return `file\ name.ext`
    
    echo "${1}" | sed "s/[&/\\| ',]/\\\\&/g"
}

split_file () {
    # arg1 = large_file.mp3
    # arg2 = the start time offset (hh:mm:ss)
    # arg3 = the end time offset (hh:mm:ss)
    # arg4 = output_dir/musicX.mp3
    
    local input_file=$(escape_special_chrs "${1}")
    local ss=${2}
    local to=${3}
    local output_file=$(escape_special_chrs "${4}")
    cmd="ffmpeg -i $input_file -ss $ss -to $to $output_file"
    printf "%0.s-" {1..30};printf " Begin ";printf "%0.s-" {1..30};printf "\n";
    printf "Command: $cmd";printf "\n";
    printf "%0.s." {1..42};printf "\n";
    eval $cmd
    printf "%0.s-" {1..30};printf " End ";printf "%0.s-" {1..30};printf "\n";
}

get_last_time () {
    # arg = large_file.mp3
    # return `the last time offset (hh:mm:ss)`
    
    local t_sec=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "${1}")
    echo $(echo $t_sec | awk '{printf("%02d:%02d:%02d\n",int($1/3600),int($1/60%60),int($1%60))}')
}
