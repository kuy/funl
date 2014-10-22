#!/usr/bin/env bats

load test_helper

setup() {
  eval_funl_init
}

@test "no arguments prints usage" {
  run funl hook
  [ "$status" -ne 0 ]
  [ "$output" == "$(cat <<USAGE
Usage: funl hook <name>...

Registers hooks of the given executable, such as builtin command,
program, and shell script.
USAGE
  )" ]
}

@test "registers a hook" {
  run funl hook hoge
  [ "$status" -eq 0 ]
  [ -z "$output" ]
  [ -e "${FUNL_HOOKS}/hoge" ]
}

@test "registers multiple hooks at once" {
  run funl hook apple banana cherry
  [ "$status" -eq 0 ]
  [ -z "$output" ]
  [ -e "${FUNL_HOOKS}/apple" ]
  [ -e "${FUNL_HOOKS}/banana" ]
  [ -e "${FUNL_HOOKS}/cherry" ]
}

@test "ignores banned names" {
  skip

  run funl hook funl nyan command
  [ "$status" -eq 0 ]
  [ "$output" == "funl: banned names: funl, command" ]
  [ ! -e "${FUNL_HOOKS}/funl" ]
  [ -e "${FUNL_HOOKS}/nyan" ]
  [ ! -e "${FUNL_HOOKS}/command" ]
}

@test "ignores existing names" {
  skip

  funl hook foo
  [ -e "${FUNL_HOOKS}/foo" ]

  run funl hook foo
  [ "$status" -eq 0 ]
  [ "$output" == "funl: registered names: foo" ]
  [ -e "${FUNL_HOOKS}/foo" ]
}
