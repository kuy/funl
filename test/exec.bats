#!/usr/bin/env bats

load test_helper

@test "no arguments prints nothing" {
  run funl exec
  [ "$status" -ne 0 ]
  [ -z "$output" ]
}

@test "unregistered command raises error" {
  run funl exec nyan
  [ "$status" -ne 0 ]
  [ "$output" == "funl: command not found: nyan" ]
}

@test "executes original command" {
  mkdir -p "$FUNL_STUB_BIN"
  stub_command 'nyan'
  eval "nyan() { echo 'nyan: shell function' ; }"

  run nyan "{hoge}"
  [ "$status" -eq 0 ]
  [ "$output" == "nyan: shell function" ]

  run funl exec nyan "{hoge}"
  [ "$status" -eq 0 ]
  [ "$output" == "nyan: {hoge}" ]
}
