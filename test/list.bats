#!/usr/bin/env bats

load test_helper

setup() {
  mkdir -p "$FUNL_HOOKS"
}

@test "no registered hooks" {
  run funl list
  [ "$status" -eq 0 ]
  [ "$output" == "funl: no hooks registered" ]
}

@test "prints registered commands" {
  touch "$FUNL_HOOKS/foo"
  touch "$FUNL_HOOKS/bar"
  run funl list
  [ "$status" -eq 0 ]
  [ "$output" == "bar, foo" ]
}

@test "with '-1' option prints one command per one line" {
  skip

  run funl list -1
  [ "$status" -eq 0 ]
}
