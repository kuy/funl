#!/usr/bin/env bats

load test_helper

setup() {
  eval_funl_init
}

@test "no arguments prints usage" {
  run funl unhook
  [ "$status" -ne 0 ]
  [ "$output" == "$(cat <<USAGE
Usage: funl unhook <name>...

Unregisters hooks of the given names.
USAGE
  )" ]
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

@test "ignores unregistered hooks" {
  skip

  funl hook foo bar
  [ -e "${FUNL_HOOKS}/foo" ]
  [ -e "${FUNL_HOOKS}/bar" ]

  run funl unhook apple
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}
