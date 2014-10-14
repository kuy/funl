TODO
====

## Memo

- 関数を定義してビルドインコマンドもフックする
  - シェル起動時にhooksディレクトリにあるコマンド名をすべて関数として定義する
  - 別のシェルで新しくフックが追加されても反映されないため、`funl refresh`で更新する
    - zshとかのフックで自動的にrefreshできないか調べる

## Must

- Improve test coverage
- Improve help content of individual commands
- [list] Sort by name for consistent output
- [list] Add '-1' option
  - Prints one name per one line
- [hook] Raise warning if given command does not exist
- [hook] Add '-f' option to ignore warning
- [hook] Bulk register
  - `funl hook foo bar`
- [unhook] Add '--all' option to unregister all hooks
- [unhook] Bulk unregister
  - `funl unhook foo bar`
- Fill multiple placeholders with same values at once
  - `git branch {branch} origin/{branch}`
- Running tests using Travis CI on other platforms
- Support both peco and percol
  - Auto detection or configuration in .funlrc file

## Wish

- Compare execution time of `funl git` and normal `git`
- Execute command in parallel using peco's multiple selection
- Enable in-place selector like `funl unhook {hooks}`
