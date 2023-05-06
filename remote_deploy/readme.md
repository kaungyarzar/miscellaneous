# Simple remote deployment automation script for linux os.

## Reason
Due to the requirements of dynamic scenario on every deployment cases.

## Dependencies
- sshpass
- ssh

## How it's works
Copy the whole dependencies files and automation script to remote host (/tmp/) dir and execute shell script.

## Help

```
Usage: $ deploy_on <remote address> <packages.tar>

	* 'package.tar' must contains 'deploy.sh' file.
	* 'SSHPASS' env variable can be used for login automation.
```
