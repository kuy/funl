funl
====

Puts placeholders in command-line, then enables in-place selecting with using peco/percol.

## Demo

WIP


## Install

1. Check out funl into your home directory.

    $ git clone git@github.com:kuy/funl.git .funl

2. Add following setting to your `.bashrc` or `.zshrc` file.

    export PATH="$HOME/.funl/bin:$PATH"
    eval "$(funl init)"

3. Put `.funlrc` file in home directory


## Setup

### Register a command/program name which you want to hook

    $ funl hook echo

### Define placeholders in `.funlrc` file

For example, following command defines 'color' placeholder.

    $ echo "color.src: echo -e \"red\\\\ngreen\\\\nblue\"" >> ~/.funlrc

### Reload or restart shell environment

    $ source ~/.zshrc

### Use placeholder in command-line

Try this command

    $ echo {color}

peco will be launched, and then you get selected color.


## Sample `.funlrc` file

branch.src: git for-each-ref --sort=-committerdate refs/heads/ | cut -f2 | sed 's:refs/heads/::g'
branch.post: sed -e 's:^\(.*\)$:hoge-\1:g'

ps.src: ps aux
ps.post: awk '{ print $2 }'


## History

- 0.1.0-dev (2014-10-16)


## Licence

The MIT License (MIT)


## Author

[kuy](https://github.com/kuy)
