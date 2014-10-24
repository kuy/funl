#!/usr/bin/env bats

load test_helper

setup() {
  mkdir -p "$FUNL_HOOKS"
}

HELP_CONTENT="$(cat <<USAGE
Usage: funl list [-1]

Lists all registered hook names.
In case of no registered hooks, this command prints nothing.
If '-1' option is specified, funl lists one name per one line.
USAGE
)"

@test "no registered hooks" {
  run funl list
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}

@test "'-h' or '--help' options print usage" {
  run funl list -h
  [ "$status" -eq 0 ]
  [ "$output" == "$HELP_CONTENT" ]

  run funl list --help
  [ "$status" -eq 0 ]
  [ "$output" == "$HELP_CONTENT" ]
}

@test "prints registered commands" {
  touch "$FUNL_HOOKS/foo"
  touch "$FUNL_HOOKS/apple"
  touch "$FUNL_HOOKS/bar"

  run funl list
  [ "$status" -eq 0 ]
  [ "$output" == "apple bar foo" ]
}

@test "with '-1' option prints one command per one line" {
  touch "$FUNL_HOOKS/banana"
  touch "$FUNL_HOOKS/apple"
  touch "$FUNL_HOOKS/cherry"

  run funl list -1
  [ "$status" -eq 0 ]
  [ "$output" == "$(cat <<OUTPUT
apple
banana
cherry
OUTPUT
  )" ]
}
