#!/usr/bin/env bats

load test_helper

setup() {
  mkdir -p "$HOME"
}

prepare_config() {
  cat <<RC > "$HOME/.funlrc"
animal.post: sed -e 's:^\(.*\)$:_\1_:'
RC
}

@test "accepts exactly 2 arguments" {
  prepare_config

  run funl post-proc
  [ "$status" -ne 0 ]
  [ -z "$output" ]

  run funl post-proc animal
  [ "$status" -ne 0 ]
  [ -z "$output" ]
}

@test "no config raises error" {
  run funl post-proc animal monkey
  [ "$status" -ne 0 ]
  [ "$output" == "funl: config not found" ]
}

@test "no 'post' definition echoes the input" {
  cat <<RC > "$HOME/.funlrc"
animal.src: sed -e 's:^\(.*\)$:_\1_:'
book.post: sed -e 's:^\(.*\)$:__\1__:'
RC

  run funl post-proc animal monkey
  [ "$status" -eq 0 ]
  [ "$output" == "monkey" ]
}

@test "returns processed value" {
  prepare_config

  run funl post-proc animal monkey
  [ "$status" -eq 0 ]
  [ "$output" == "_monkey_" ]
}

@test "invalid 'post' definition raises error" {
  cat <<RC > "$HOME/.funlrc"
animal.post: obviously invalid 'post' definition
RC

  run funl post-proc animal monkey
  [ "$status" -ne 0 ]
  [ -z "$output" ]
}
