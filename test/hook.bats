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
  mkdir -p "$FUNL_TEST_BIN"
  stub_command 'nyan'
  stub_peco 2

  mkdir -p "$HOME"
  cat <<RC > "$HOME/.funlrc"
placeholder.src: echo -e "apple\nbanana\ncherry"
RC

  run nyan {placeholder} bla
  [ "$status" -eq 0 ]
  [ "$output" == "nyan: {placeholder} bla" ]

  run funl hook nyan
  [ "$status" -eq 0 ]
  [ -z "$output" ]
  [ -x "${FUNL_HOOKS}/nyan" ]

  run nyan {placeholder} bla
  [ "$status" -eq 0 ]
  [ "$output" == "nyan: banana bla" ]
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
