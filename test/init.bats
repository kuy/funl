#!/usr/bin/env bats

load test_helper

@test "no hooks print only 'funl' function" {
  run funl init
  [ "$status" -eq 0 ]
  [ ! -z $(echo "$output" | grep "#!/usr/bin/env bash") ]
}

@test "creates 'hooks' directory if not exist" {
  [ ! -d "$FUNL_HOOKS" ]

  run funl init
  [ "$status" -eq 0 ]
  [ ! -z "$output" ]
  [ -d "$FUNL_HOOKS" ]
}

@test "prints shell functions with hooked name" {
  mkdir -p "$FUNL_HOOKS"
  run funl hook foo
  run funl hook bla-bla

  run funl init
  [ "$status" -eq 0 ]
  [ ! -z $(echo "$output" | grep "#!/usr/bin/env bash") ]
  [ ! -z "$(echo "$output" | grep "bla-bla()")" ]
  [ ! -z "$(echo "$output" | grep "foo()")" ]
}
