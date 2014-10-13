#!/usr/bin/env bats

load test_helper

@test "no arguments prints version number" {
  run funl version
  [ "$status" -eq 0 ]
  [ "$output" == "funl 0.0.0-dev" ]
}

@test "--version prints same output as no arguments" {
  run funl --version
  [ "$status" -eq 0 ]
  [ "$output" == "$(funl version)" ]
}
