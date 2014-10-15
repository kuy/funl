TODO
====

## Memo

- 別のシェルで新しくフックが追加されても反映されないため、`funl refresh`で更新する
- zshとかのフックで自動的にrefreshできないか調べる

## Must

- Implement alias for placeholders
  - b: &branch
- Running tests using Travis CI on other platforms
- [list] Sort by name for consistent output
- [list] Add '-1' option
  - Prints one name per one line
- [unhook] Add '--all' option to unregister all hooks
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
  - Install plugins using `funl`
- [hook] Raise warning if given command does not exist
- [hook] Add '-f' option to ignore warning
- [hook] Bulk register
  - `funl hook foo bar`
- [unhook] Bulk unregister
  - `funl unhook foo bar`
- Compare execution time of `funl git` and normal `git`
- Execute command in parallel using peco's multiple selection
- Enable in-place selector like `funl unhook {hooks}`
