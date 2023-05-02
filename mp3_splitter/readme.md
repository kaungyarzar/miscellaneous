# MP3 Splitter

## Version
- v0.1.0

Current version is only support for `mp3` format. 

## Requirements
- FFmpeg
- bash

## FFmpeg Installation (Ubuntu 20.04)
```shell
sudo apt update
sudo apt install ffmpeg
```

## Usage Example

```
ubuntu@ubuntu:~$ ./splitter.sh 
Usage: ./splitter.sh <large_file.mp3> <tracklist.txt>
```
`tracklist.txt` format
```
00:00:00 'music_one'
00:01:57 'music_two'
00:04:48 'music_three'
00:08:09 'music_four'
```
