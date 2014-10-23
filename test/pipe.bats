#!/usr/bin/env bats

load test_helper

@test "prepares 2 pipes" {
  run funl pipe
  [ "$status" -eq 0 ]
  [ -d "$output" ]
  [ -p "$output/output" ]
  [ -p "$output/code" ]
}

@test "'-d' option deletes pipes and directory" {
  base=$(funl pipe)
  [ -d "$base" ]

  run funl pipe -d "$base"
  [ "$status" -eq 0 ]
  [ ! -d "$base" ]
  [ ! -p "$base/output" ]
  [ ! -p "$base/code" ]
}
