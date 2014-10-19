#!/usr/bin/env bats

load test_helper

prepare_hooks() {
  mkdir -p "$FUNL_HOOKS"
  funl hook apple
  funl hook banana
  funl hook cherry
}

@test "no arguments print nothing" {
  run funl feed
  [ "$status" -ne 0 ]
  [ -z "$output" ]
}

@test "invalid subcommand" {
  run funl feed hoge
  [ "$status" -ne 0 ]
  [ -z "$output" ]
}

@test "generates shell script to define functions of all registered hooks" {
  prepare_hooks

  run funl feed def
  [ "$status" -eq 0 ]
  [ "$output" == "$(cat <<BLK
apple() { funl proc apple "\$@" ; }
banana() { funl proc banana "\$@" ; }
cherry() { funl proc cherry "\$@" ; }
BLK
  )" ]
}

@test "generates shell script to define function of specified hook" {
  run funl feed def foo
  [ "$status" -eq 0 ]
  [ "$output" == "$(cat <<BLK
foo() { funl proc foo "\$@" ; }
BLK
  )" ]
}

@test "generates shell script to define functions of specified hooks" {
  run funl feed def AAA BBB CCC
  [ "$status" -eq 0 ]
  [ "$output" == "$(cat <<BLK
AAA() { funl proc AAA "\$@" ; }
BBB() { funl proc BBB "\$@" ; }
CCC() { funl proc CCC "\$@" ; }
BLK
  )" ]
}

@test "generates shell script to remove functions of all registered hooks" {
  prepare_hooks

  run funl feed undef
  [ "$status" -eq 0 ]
  [ "$output" == "$(cat <<BLK
unset -f "apple" >/dev/null 2>&1 || true
unset -f "banana" >/dev/null 2>&1 || true
unset -f "cherry" >/dev/null 2>&1 || true
BLK
  )" ]
}

@test "generates shell script to remove function of specified hook" {
  run funl feed undef foo
  [ "$status" -eq 0 ]
  [ "$output" == "$(cat <<BLK
unset -f "foo" >/dev/null 2>&1 || true
BLK
  )" ]
}

@test "generates shell script to remove functions of specified hooks" {
  run funl feed undef AAA BBB CCC
  [ "$status" -eq 0 ]
  [ "$output" == "$(cat <<BLK
unset -f "AAA" >/dev/null 2>&1 || true
unset -f "BBB" >/dev/null 2>&1 || true
unset -f "CCC" >/dev/null 2>&1 || true
BLK
  )" ]
}
