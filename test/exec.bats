#!/usr/bin/env bats

load test_helper

setup() {
  mkdir -p "$FUNL_HOOKS"
}

@test "no arguments prints nothing" {
  run funl exec
  [ "$status" -ne 0 ]
  [ -z "$output" ]
}

@test "unregistered command prints error" {
  run funl exec nyan
  [ "$status" -ne 0 ]
  [ "$output" == "funl: command not found: nyan" ]
}

@test "executes original command" {
  run funl hook grep
  run funl exec grep -h
  [ "$status" -eq 2 ]
  [ $(expr "$output" : "usage: grep.*") -ne 0 ]
}
