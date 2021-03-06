#!/usr/bin/env bats

load test_helper

setup() {
  mkdir -p "$HOME"
  mkdir -p "$FUNL_STUB_BIN"
}

prepare_config() {
  cat <<RC > "$HOME/.funlrc"
animal.src: echo -e "cat\ndog\nmonkey"
RC
}

@test "no config raises error" {
  run funl select animal
  [ "$status" -ne 0 ]
  [ "$output" == "funl: config not found" ]
}

@test "no arguments or 2 arguments raise error" {
  prepare_config

  run funl select
  [ "$status" -ne 0 ]
  [ -z "$output" ]

  run funl select bla bla
  [ "$status" -ne 0 ]
  [ -z "$output" ]
}

@test "runs peco, then returns choice" {
  prepare_config
  stub_peco 3

  run funl select animal
  [ "$status" -eq 0 ]
  [ "$output" == "monkey" ]
}

@test "runs peco, but cancelled" {
  prepare_config
  stub_peco -1

  run funl select animal
  [ "$status" -ne 0 ]
  [ -z "$output" ]
}

@test "invalid 'src' definition raises error" {
  cat <<RC > "$HOME/.funlrc"
animal.src: obviously invalid 'src' definition
RC
  stub_peco 2

  run funl select animal
  [ "$status" -ne 0 ]
  [ -z "$output" ]
}

@test "blank 'src' definition raises error" {
  cat <<RC > "$HOME/.funlrc"
animal.src:
RC
  stub_peco 2

  run funl select animal
  [ "$status" -ne 0 ]
  [ -z "$output" ]
}

@test "'src' generates nothing" {
  cat <<RC > "$HOME/.funlrc"
color.src: echo ""
RC
  stub_peco 1

  run funl select color
  [ "$status" -ne 0 ]
  [ -z "$output" ]
}

@test "detects that peco isn't installed" {
  prepare_config

  run funl select animal
  [ "$status" -ne 0 ]
  [ "$output" == "funl: peco/percol is not available" ]
}

@test "use 'FUNL_SELECTOR' to tell yet another selector" {
  prepare_config
  stub_peco 3
  mv "$FUNL_STUB_BIN/peco" "$FUNL_STUB_BIN/ocep"

  FUNL_SELECTOR="$FUNL_STUB_BIN/ocep" run funl select animal
  [ "$status" -eq 0 ]
  [ "$output" == "monkey" ]

  FUNL_SELECTOR="ocep" run funl select animal
  [ "$status" -eq 0 ]
  [ "$output" == "monkey" ]
}
