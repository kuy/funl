TODO
====

## Memo

- `funl feed`で定義済みのシェル関数をクリアしてから再定義できるようにする
- zshとかのフックで自動的にfeedできないか調べる

## Must

- [fook] `funl hook -h hoge` raises error
- [proc] Validate command name with Regex pattern
- [select] Show error message if peco is not installed
  - Put guide to install peco in README.md
- [config] Implement alias for placeholders
  - b: &branch
- [list] Sort by name for consistent output
- [list] Add '-1' option
  - Prints one name per one line
- [unhook] Add '--all' option to unregister all hooks
- [proc] Ignore placeholer if not defined
- [proc] Fill multiple placeholders with same values at once
  - `git branch {branch} origin/{branch}`
- [select] Support both peco and percol
  - Auto detection or configuration in .funlrc file

## Continue

- Improve help content of individual commands

## Idea/Wish

- Context for placeholders
  - differ between `kill {ps}` and `pkill {ps}`
    - in `kill` command, {ps} will insert process ID
    - in `pkill` command, {ps} will insert process name
- Plugin mechanism for 'src' and 'post'
  - Install and select plugins using `funl`
- [hook] Raise warning if given command does not exist
- [hook] Add '-f' option to ignore warning
- Compare execution time of `funl git` and normal `git`
- Execute command in parallel using peco's multiple selection
- Enable in-place selector like `funl unhook {hooks}`
