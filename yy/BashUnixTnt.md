# Bash and Gnu/Unix Tips and Tricks

## find

### Output files

#### By name

```bash
find <path> -name <wildcard name>
```

#### By type

````bash
find <path> -type f
````

```bash
find <path> -type d
```

### Perform command on files

#### One command

```bash
find <path> -type f -exec grep  "foo" {} \;
```

#### Two commands

```bash
find <path> -type f -exec grep "foo" {} \; -exec echo {} \;
```

```bash
find <path> -type f -exec grep "foo" {} \; -print
```

#### Display file name with grep

```bash
find <path> -type f -exec grep "foo" deepak {} \+
```

#### Combine exec with pipe

```bash
find <path> -type f -exec sh -c 'egrep -i a "$1" | grep -i amit' sh {} \; -print
```

#### Combine grep and find exec with sed

```bash
find /tmp/dir1/ -type f -exec grep deepak {} \; -exec echo -e {}"\n" \; | sed  's/deepak/deep/g'
```

