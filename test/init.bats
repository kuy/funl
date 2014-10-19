#!/usr/bin/env bats

load test_helper

@test "no hooks print nothing" {
  run funl init
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}

@test "creates 'hooks' directory if not exist" {
  [ ! -d "$FUNL_HOOKS" ]

  run funl init
  [ "$status" -eq 0 ]
  [ -z "$output" ]
  [ -d "$FUNL_HOOKS" ]
}

@test "prints shell functions with hooked name" {
  mkdir -p "$FUNL_HOOKS"
  run funl hook foo
  run funl hook bla-bla

  run funl init
  echo "$status: $output"
  [ "$status" -eq 0 ]
  [ "$output" == "$(cat <<OUT
bla-bla() { funl proc bla-bla "\$@" ; }
foo() { funl proc foo "\$@" ; }
OUT
  )" ]
}
