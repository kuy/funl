#!/usr/bin/env bats

load test_helper

@test "prints version number with revision hash" {
  skip

  run funl version
  [ "$status" -eq 0 ]
  [ $(expr "$output" : "^.*0.0.0-[0-9a-z]\{7\}$") != "0" ]

  mkdir -p "$HOME"
  cd "$HOME"

  run funl version
  [ "$status" -eq 0 ]
  [ $(expr "$output" : "^.*0.0.0-[0-9a-z]\{7\}$") != "0" ]
}

@test "prints version number without revision hash" {
  skip

  run funl version
  [ "$status" -eq 0 ]
  [ "$output" == "funl 0.0.0" ]
}

@test "--version prints same output as no arguments" {
  run funl --version
  [ "$status" -eq 0 ]
  [ "$output" == "$(funl version)" ]
}
