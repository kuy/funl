#!/usr/bin/env bats

load test_helper

setup() {
  eval_funl_init
}

HELP_CONTENT="$(cat <<USAGE
Usage: funl hook <name>...

Registers hooks of the given executable, such as builtin command,
program, and shell script.
USAGE
)"

@test "no arguments prints usage" {
  run funl hook
  [ "$status" -ne 0 ]
  [ "$output" == "$HELP_CONTENT" ]
}

@test "'-h' or '--help' options print usage" {
  run funl hook -h
  [ "$status" -eq 0 ]
  [ "$output" == "$HELP_CONTENT" ]

  run funl hook --help
  [ "$status" -eq 0 ]
  [ "$output" == "$HELP_CONTENT" ]
}

@test "mixed params print usage without registering hooks" {
  run funl hook -h nyan
  [ "$status" -eq 0 ]
  [ "$output" == "$HELP_CONTENT" ]
  [ ! -e "${FUNL_HOOKS}/nyan" ]
  [ ! -e "${FUNL_HOOKS}/command" ]

  run funl hook foo --help bar funl
  [ "$status" -eq 0 ]
  [ "$output" == "$HELP_CONTENT" ]
  [ ! -e "${FUNL_HOOKS}/foo" ]
  [ ! -e "${FUNL_HOOKS}/bar" ]
  [ ! -e "${FUNL_HOOKS}/funl" ]
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
  [ "$output" == "$(cat <<OUTPUT
funl: 'funl' is banned
funl: 'command' is banned
OUTPUT
  )" ]
  [ ! -e "${FUNL_HOOKS}/funl" ]
  [ -e "${FUNL_HOOKS}/nyan" ]
  [ ! -e "${FUNL_HOOKS}/command" ]
}

@test "ignores existing names" {
  funl hook foo bar
  [ -e "${FUNL_HOOKS}/foo" ]
  [ -e "${FUNL_HOOKS}/bar" ]

  run funl hook bar nyan foo
  [ "$status" -eq 0 ]
  [ "$output" == "$(cat <<OUTPUT
funl: 'bar' is already registered
funl: 'foo' is already registered
OUTPUT
  )" ]
  [ -e "${FUNL_HOOKS}/bar" ]
  [ -e "${FUNL_HOOKS}/nyan" ]
  [ -e "${FUNL_HOOKS}/foo" ]
}

@test "ignores banned and existing names" {
  funl hook nyan
  [ -e "${FUNL_HOOKS}/nyan" ]

  run funl hook foo nyan command hoge
  [ "$status" -eq 0 ]
  [ "$output" == "$(cat <<OUTPUT
funl: 'nyan' is already registered
funl: 'command' is banned
OUTPUT
  )" ]
  [ -e "${FUNL_HOOKS}/foo" ]
  [ -e "${FUNL_HOOKS}/nyan" ]
  [ ! -e "${FUNL_HOOKS}/command" ]
  [ -e "${FUNL_HOOKS}/hoge" ]
}
