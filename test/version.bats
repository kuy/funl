#!/usr/bin/env bats

load test_helper

@test "no arguments prints version number" {
  run funl version
  [ "$status" -eq 0 ]
  [ $(expr "$output" : "^.*0.0.0-[0-9a-z]\{7\}$") != "0" ]
}

@test "--version prints same output as no arguments" {
  run funl --version
  [ "$status" -eq 0 ]
  [ "$output" == "$(funl version)" ]
}
