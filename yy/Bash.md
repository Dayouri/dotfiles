## `if..elif..else` Statement 

```sh
if [[ $VAR1 -ge $VAR2 ]] && [[ $VAR1 -ge $VAR3 ]]
then
  echo "$VAR1 is the largest number."
elif [[ $VAR2 -ge $VAR1 ]] && [[ $VAR2 -ge $VAR3 ]]
then
  echo "$VAR2 is the largest number."
else
  echo "$VAR3 is the largest number."
fi
```

## Test Operators

In Bash, the `test` command takes one of the following syntax forms:

```sh
test EXPRESSION
[ EXPRESSION ]
[[ EXPRESSION ]]
```

To make the script portable, prefer using the old test `[` command which is available on all POSIX shells. The new upgraded version of the `test` command `[[` (double brackets) is supported on most modern systems using Bash, Zsh, and Ksh as a default shell.

### Most commonly used operators:

- `-n` `VAR` - True if the length of `VAR` is greater than zero.
- `-z` `VAR` - True if the `VAR` is empty.
- `STRING1 = STRING2` - True if `STRING1` and `STRING2` are equal.
- `STRING1 != STRING2` - True if `STRING1` and `STRING2` are not equal.
- `INTEGER1 -eq INTEGER2` - True if `INTEGER1` and `INTEGER2` are equal.
- `INTEGER1 -gt INTEGER2` - True if `INTEGER1` is greater than `INTEGER2`.
- `INTEGER1 -lt INTEGER2` - True if `INTEGER1` is less than `INTEGER2`.
- `INTEGER1 -ge INTEGER2` - True if `INTEGER1` is equal or greater than INTEGER2.
- `INTEGER1 -le INTEGER2` - True if `INTEGER1` is equal or less than `INTEGER2`.
- `-h` `FILE` - True if the `FILE` exists and is a symbolic link.
- `-r` `FILE` - True if the `FILE` exists and is readable.
- `-w` `FILE` - True if the `FILE` exists and is writable.
- `-x` `FILE` - True if the `FILE` exists and is executable.
- `-d` `FILE` - True if the `FILE` exists and is a directory.
- `-e` `FILE` - True if the `FILE` exists and is a file, regardless of type (node, directory, socket, etc.).
- `-f` `FILE` - True [if the `FILE` exists](https://linuxize.com/post/bash-check-if-file-exists/) and is a regular file (not a directory or device).