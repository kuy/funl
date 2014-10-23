#!/usr/bin/env bats

load test_helper

@test "no arguments prints usage overview" {
  run funl help
  [ "$status" -eq 0 ]
  [ "$output" == "$(cat <<USAGE
Usage: funl <command> [...]

Here are available commands:

   config: Show available placeholders
     help: Show this usage
     hook: Register a hook of the given executable
     list: List all registered hooks
   unhook: Unregister a hook
  version: Show version information

Use 'funl help <command>' for more information of specific command.
USAGE
  )" ]
}

@test "--help and -h print same output as \`funl help\`" {
  run funl --help
  [ "$status" -eq 0 ]
  [ "$output" == "$(funl help)" ]

  run funl -h
  [ "$status" -eq 0 ]
  [ "$output" == "$(funl help)" ]
}

@test "invalid command" {
  run funl help foo
  [ "$status" -ne 0 ]
  [ "$output" == "funl: 'foo' is not a funl command" ]
}

@test "prints help content of specific command" {
  run funl help list
  [ "$status" -eq 0 ]
  [ "$output" == "$(cat <<USAGE
Usage: funl list [-1]

Lists all registered hook names.
In case of no registered hooks, this command prints nothing.
If '-1' option is specified, funl lists one name per one line.
USAGE
  )" ]
}
