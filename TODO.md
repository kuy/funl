TODO
====

## Memo

- `funl feed`で定義済みのシェル関数をクリアしてから再定義できるようにする
- zshとかのフックで自動的にfeedできないか調べる

## Issues

- [fook/unhook] `funl hook/unhook -h hoge` raises error
  - Use named pipe to return function definitions to caller
  - STDOUT should not be used for this purpose
- [select] Show error message if peco is not installed
  - Put guide to install peco in README.md

## Must

- [config] Implement alias for placeholders
  - b: &branch
- [unhook] Add '--all' option to unregister all hooks
- [proc] Validate command name with Regexp pattern
  - Empty string, symbols, spaces
- [proc] Ignore placeholders if not defined
- [proc] Fill multiple placeholders with same value at once
  - `git branch {branch} origin/{branch}` => `git branch apple origin/apple`
- [select] Support multiple selection
  - Add support command to process multiple selection
    - For example, convert "one item per one item" format to "comma separated" or "space separated"
- [select] Add test case when 'src' returns nothing
- [select] Support both peco and percol
  - Auto detection or configuration in .funlrc file

## Idea/Wish

- [funl] Add `funl upgrade` command for self updating
  - Prepare '--edge' option to grab latest version
- [select] Option to auto-select if only one option is available
- [list] Add '-1' option
  - Prints one name per one line
- [list] Sort by name for consistent output
- Utility command to define static 'src'
  - `funl gen "apple" "banana" "cherry"` => `echo -e "apple\\nbanana\\ncherry"`
- Syntax for inserting value without peco's interaction
  - git push origin {{current-branch}}
- Context for placeholders
  - Different behaviour between `kill {ps}` and `pkill {ps}`
    - In `kill` command, {ps} will insert process ID
    - In `pkill` command, {ps} will insert process name
- Plugin mechanism for 'src' and 'post'
  - Install and select plugins using `funl`
- [hook] Raise warning if given command does not exist
- [hook] Add '-f' option to ignore warning
- Compare execution time of `funl git` and normal `git`
- Execute command in parallel using peco's multiple selection
- Enable in-place selector like `funl unhook {hooks}`

## Continue

- Improve help content of individual commands
