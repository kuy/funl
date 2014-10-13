#!/usr/bin/env bats

load test_helper

setup() {
  mkdir -p "$FUNL_HOOKS"
}

@test "no arguments prints usage" {
  run funl hook
  [ "$status" -ne 0 ]
  [ "$output" == "$(cat <<USAGE
Usage: funl hook <name>

Registers a hook of the given executable, such as builtin command,
program, and shell script.
USAGE
  )" ]
}

@test "registers a hook well" {
  run funl hook foo
  [ "$status" -eq 0 ]
  [ -z "$output" ]
  [ -x "${FUNL_HOOKS}/foo" ]
}

@test "already registered" {
  run funl hook foo
  run funl hook foo
  [ "$status" -ne 0 ]
  [ "$output" == "funl: 'foo' is already hooked" ]
  [ -x "${FUNL_HOOKS}/foo" ]
}

@test "creates 'hooks' directory if not exist" {
  rmdir "$FUNL_HOOKS"
  run funl hook bar
  [ -d "$FUNL_HOOKS" ]
  [ -x "${FUNL_HOOKS}/bar" ]
}
