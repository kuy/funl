funl [![Build Status](https://travis-ci.org/kuy/funl.svg?branch=master)](https://travis-ci.org/kuy/funl)
====

peco/percol powered interactive placeholders in shell environment.

## Description

`funl` detects placeholders in command-line string, launches peco/percol
to prompt selecting item, substitutes placeholders with selected item.  
In addition to this, `funl` has 'post-filter' to process output from peco/percol before filling placeholders.

## Demo

WIP


## Requirements

- bash 3.2 / zsh 5.0.4
- [peco](https://github.com/lestrrat/peco) 0.2.10 / [percol](https://github.com/mooz/percol) 0.0.7

To install peco/percol, please see the project page.

## Install

### 1. Check out funl into your home directory.

```sh
$ git clone git@github.com:kuy/funl.git $HOME/.funl
```

### 2. Add following setting to your `.bashrc` or `.zshrc` file.

```sh
export PATH="$HOME/.funl/bin:$PATH"
eval "$(funl init)"
```

### 3. Put `.funlrc` file in home directory

`.funlrc` is used to define placeholders.

## Tutorial

### Register a command/program name which you want to hook

```sh
$ funl hook echo
```

### Define placeholders in `.funlrc` file

For example, following command defines 'color' placeholder.

```sh
$ echo "color.src: echo -e \"red\\\\ngreen\\\\nblue\"" >> ~/.funlrc
```

### Reload or restart shell environment

```sh
$ source ~/.zshrc
```

### Use placeholder in command-line

Try this command

```sh
$ echo {color}
```

`funl` launches `peco`, and then outputs selected color.


## Configuration

`funl` provides environment variables to customize behaviours.
Following options can be set in your `.bashrc` or `.zshrc` to apply permanently.

### `FUNL_SELECTOR`: Use `percol` instead of `peco`

```sh
FUNL_SELECTOR=$(which percol)
```

Or you can just put a command name if it's installed to
the directory which is appeared in $PATH.

```sh
FUNL_SELECTOR=percol
```

### `FUNL_DEBUG`: Debugging `funl`

```sh
FUNL_DEBUG=1
```

## Placeholder definition

### Placeholder

```sh
<name>.<type>: <command> ...
```

#### `<name>`

Placeholder name.  
You can use this name in placeholders, like `kill {ps}`.

#### `<type>`

- `src`: Required. A shell script which generates input to peco/percol
- `post`: Optional. A filter script/command to process output from peco/percol

### Alias

```sh
<alias>: &<name>
```

#### `<alias>`

Alias name.  

```sh
ticket.src: fetch_ticket
t: &ticket
```


## Sample `.funlrc` file

```
branch.src: git for-each-ref --sort=-committerdate refs/heads/ | cut -f2 | sed 's:refs/heads/::g'
branch.post: sed -e 's:^\(.*\)$:\1:g'

ps.src: ps aux
ps.post: awk '{ print $2 }'

color.src: echo -e "red\\ngreen\\nblue"
```


## History

- 0.0.0 (2014-10-16)


## Licence

The MIT License (MIT)


## Author

[kuy](https://github.com/kuy)
