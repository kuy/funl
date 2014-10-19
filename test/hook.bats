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

'-e' option can be used to reflect this to the current shell.
e.g. $ eval "\$(funl hook -e git)"
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
  run funl hook funl nyan command
  [ "$status" -eq 0 ]
  [ -z "$output" ]
  [ ! -e "${FUNL_HOOKS}/funl" ]
  [ -e "${FUNL_HOOKS}/nyan" ]
  [ ! -e "${FUNL_HOOKS}/command" ]
}

@test "already registered raises error" {
  funl hook foo
  run funl hook foo
  [ "$status" -ne 0 ]
  [ "$output" == "funl: 'foo' is already hooked" ]
  [ -e "${FUNL_HOOKS}/foo" ]
}
