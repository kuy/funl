TODO
====

## Memo

- funlrc
  - source: generates options to be passed to `peco`
  - post: post processing output

## Must

- Bulk register
  - `funl hook foo bar`
- Bulk unregister
  - `funl unhook foo bar`
- Option to unregister all hooks
  - `funl unhook --all`
- Write test codes
  - shunit2: https://code.google.com/p/shunit2/
  - BATS: https://github.com/sstephenson/bats
- Running tests using Travis CI on other platforms
- Support peco and percol
  - Auto detection
- Compare execution time of `funl git` and normal `git`

## Wish

- Execute command in parallel using peco's multiple selection
- Enable in-place selector like `funl unhook {hooks}`
