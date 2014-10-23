#!/usr/bin/env bats

load test_helper

setup() {
  eval_funl_init
}

HELP_CONTENT="$(cat <<USAGE
Usage: funl unhook [--all] <name>...

Unregisters hooks of the given names.
'--all' option deletes all registered hooks.
If you specify '--all' option, all other parameters will be ignored.
USAGE
)"

@test "no arguments prints usage" {
  run funl unhook
  [ "$status" -ne 0 ]
  [ "$output" == "$HELP_CONTENT" ]
}

@test "'-h' or '--help' options print usage" {
  run funl unhook -h
  [ "$status" -eq 0 ]
  [ "$output" == "$HELP_CONTENT" ]

  run funl unhook --help
  [ "$status" -eq 0 ]
  [ "$output" == "$HELP_CONTENT" ]
}

@test "mixed params print usage without unregistering hooks" {
  funl hook nyan foo bar

  run funl unhook -h nyan
  [ "$status" -eq 0 ]
  [ "$output" == "$HELP_CONTENT" ]
  [ -e "${FUNL_HOOKS}/nyan" ]
  [ -e "${FUNL_HOOKS}/foo" ]
  [ -e "${FUNL_HOOKS}/bar" ]

  run funl unhook foo --help bar
  [ "$status" -eq 0 ]
  [ "$output" == "$HELP_CONTENT" ]
  [ -e "${FUNL_HOOKS}/nyan" ]
  [ -e "${FUNL_HOOKS}/foo" ]
  [ -e "${FUNL_HOOKS}/bar" ]
}

@test "unregisters a hook" {
  funl hook foo
  [ -e "${FUNL_HOOKS}/foo" ]

  run funl unhook foo
  [ "$status" -eq 0 ]
  [ -z "$output" ]
  [ ! -e "${FUNL_HOOKS}/foo" ]
}

@test "unregisters multiple hooks at once" {
  funl hook apple banana cherry
  [ -e "${FUNL_HOOKS}/apple" ]
  [ -e "${FUNL_HOOKS}/banana" ]
  [ -e "${FUNL_HOOKS}/cherry" ]

  run funl unhook apple banana cherry
  [ "$status" -eq 0 ]
  [ -z "$output" ]
  [ ! -e "${FUNL_HOOKS}/apple" ]
  [ ! -e "${FUNL_HOOKS}/banana" ]
  [ ! -e "${FUNL_HOOKS}/cherry" ]
}

@test "'--all' option unregisters all hooks" {
  funl hook apple banana cherry

  run funl unhook --all
  [ "$status" -eq 0 ]
  [ -z "$output" ]
  [ ! -e "${FUNL_HOOKS}/apple" ]
  [ ! -e "${FUNL_HOOKS}/banana" ]
  [ ! -e "${FUNL_HOOKS}/cherry" ]
}

@test "'--all' option is specified, but no registered hooks" {
  run funl unhook --all
  echo "$status: $output"
  [ "$status" -ne 0 ]
  [ "$output" == "funl: no hooks registered" ]
}

@test "ignores hooks not registered" {
  funl hook foo bar
  [ -e "${FUNL_HOOKS}/foo" ]
  [ -e "${FUNL_HOOKS}/bar" ]

  run funl unhook apple foo
  [ "$status" -eq 0 ]
  [ "$output" == "funl: 'apple' isn't registered" ]
  [ ! -e "${FUNL_HOOKS}/apple" ]
  [ ! -e "${FUNL_HOOKS}/foo" ]
  [ -e "${FUNL_HOOKS}/bar" ]
}
