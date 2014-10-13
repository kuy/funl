TODO
====

## Memo

## Must

- Improve help content of individual commands
- `funl list` should print sorted commands for consistency
- Prepare config file
  - `post`: command line which does post-processing after peco/percol
- Improve test coverage
- Bulk register
  - `funl hook foo bar`
- Bulk unregister
  - `funl unhook foo bar`
- Option to unregister all hooks
  - `funl unhook --all`
- Running tests using Travis CI on other platforms
- Support both peco and percol
  - Auto detection or configuration in .funlrc file

## Wish

- Compare execution time of `funl git` and normal `git`
- Execute command in parallel using peco's multiple selection
- Enable in-place selector like `funl unhook {hooks}`
