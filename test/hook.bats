#!/usr/bin/env bats

load test_helper

setup() {
  eval_funl_init
}

@test "no arguments prints usage" {
  run funl hook
  [ "$status" -ne 0 ]
  [ "$output" == "$(cat <<USAGE
Usage: funl hook [-e] <name>...

Registers hooks of the given executable, such as builtin command,
program, and shell script.

'-e' option is useful to enable hooked command right now.
e.g. $ eval "\$(funl hook -e git)"
USAGE
  )" ]
}

@test "registers a hook well" {
  mkdir -p "$FUNL_STUB_BIN"
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
  [ -e "${FUNL_HOOKS}/nyan" ]

  eval_funl_init

  run nyan {placeholder} bla
  echo "$status: $output"
  [ "$status" -eq 0 ]
  [ "$output" == "nyan: banana bla" ]
}

@test "already registered" {
  run funl hook foo
  run funl hook foo
  echo "$status: $output"
  [ "$status" -ne 0 ]
  [ "$output" == "funl: 'foo' is already hooked" ]
  [ -e "${FUNL_HOOKS}/foo" ]
}
