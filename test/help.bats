#!/usr/bin/env bats

load test_helper

@test "no arguments prints usage overview" {
  run funl help
  [ "$status" -eq 0 ]
  [ "$output" == "$(cat <<BLK
Usage: funl <command> [...]

Here are available commands:

     list: List all registered hook names
     hook: Register a hook of the given executable
   unhook: Unregister a hook
  version: Show version information
     help: Displays help contents

Use 'funl help <command>' for more information of specific command.
BLK
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
  [ "$output" == "$(cat <<BLK
Usage: funl list [-1]

Lists all registered hook names.
If '-1' option is specified, funl lists one name per one line.
BLK
  )" ]
}
