## Monitoring on a process
This is interactive tool for monitoring on a process on a `linux` system. I hope it will be useful debugging. 

### Requirements:
- bash <default: linux>
- pidstat
- tput <default: linux>

### Install dependencies:

```
$ sudo apt update && sudo apt install sysstat
```

### How to use
```
ubuntu@ubuntu:~ $ ./pid_monitor
Usage: ./pid_monitor <pid>
```