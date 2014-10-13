TODO
====

## Memo

## Must

- Improve help content of individual commands
- `funl list` should print sorted commands for consistency
- Prepare config file
  - `post`: command line which does post-processing after peco/percol
- Improve test coverage
- [list] Add '-1' option
  - Prints one name per one line
- [hook] Raise warning if given command does not exist
- [hook] Add '-f' option to ignore warning
- [hook] Bulk register
  - `funl hook foo bar`
- [unhook] Add '--all' option to unregister all hooks at once
- [unhook] Bulk unregister
  - `funl unhook foo bar`
- Running tests using Travis CI on other platforms
- Support both peco and percol
  - Auto detection or configuration in .funlrc file

## Wish

- Compare execution time of `funl git` and normal `git`
- Execute command in parallel using peco's multiple selection
- Enable in-place selector like `funl unhook {hooks}`
