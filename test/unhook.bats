#!/usr/bin/env bats

load test_helper

setup() {
  mkdir -p "$FUNL_HOOKS"
  funl hook foo
}

@test "no arguments prints usage" {
  run funl unhook
  [ "$status" -ne 0 ]
  [ "$output" == "$(cat <<USAGE
Usage: funl unhook <name>

Unregisters a hook of the given name.
USAGE
  )" ]
}

@test "unregisters a hook well" {
  [ -x "${FUNL_HOOKS}/foo" ]
  run funl unhook foo
  [ "$status" -eq 0 ]
  [ -z "$output" ]
  [ ! -e "${FUNL_HOOKS}/foo" ]
}

@test "not registered" {
  run funl unhook foo
  run funl unhook foo
  [ "$status" -ne 0 ]
  [ "$output" == "funl: 'foo' isn't registered as hook" ]
}
